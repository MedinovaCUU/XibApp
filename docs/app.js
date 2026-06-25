const STORAGE_KEYS = {
  preferences: "xibapp.web.preferences.v1",
  history: "xibapp.web.history.v1",
  performance: "xibapp.web.performance.v1",
  completedRecipes: "xibapp.web.completedRecipes.v1",
  shoppingList: "xibapp.web.shoppingList.v1",
  challengeRegistrations: "xibapp.web.challengeRegistrations.v1",
};

const VIEW_OPTIONS = [
  { id: "dashboard", label: "Inicio" },
  { id: "training", label: "Entrenamiento" },
  { id: "explorer", label: "Ejercicios" },
  { id: "nutrition", label: "Nutricion" },
  { id: "challenges", label: "Retos" },
  { id: "progress", label: "Progreso" },
];

const GOALS = [
  "Ganar musculo",
  "Reducir peso corporal",
  "Definir musculo",
  "Ganar fuerza",
  "Mejorar condicion fisica",
];

const SPLITS = [
  "Empuje/Jalon/Piernas",
  "Superior/Inferior/Cuerpo completo",
  "Cuerpo completo",
  "Tren superior/Tren inferior",
];

const FOCUS_CYCLES = {
  "Empuje/Jalon/Piernas": ["Empuje", "Jalon", "Piernas"],
  "Superior/Inferior/Cuerpo completo": ["Superior", "Inferior", "Cuerpo completo"],
  "Cuerpo completo": ["Cuerpo completo"],
  "Tren superior/Tren inferior": ["Superior", "Inferior"],
};

const FOCUS_KEYWORDS = {
  Empuje: ["pecho", "hombro", "tricep", "tricep", "deltoid", "push"],
  Jalon: ["espalda", "dorsal", "bicep", "bicep", "trapec", "remo", "jalon", "jalon", "pull"],
  Piernas: ["pierna", "cuadricep", "cuadricep", "femoral", "glute", "isquio", "pantorrilla", "sentadilla", "lunge"],
  Superior: ["pecho", "hombro", "espalda", "dorsal", "bicep", "tricep", "brazo"],
  Inferior: ["pierna", "cuadricep", "femoral", "glute", "isquio", "pantorrilla", "sentadilla", "lunge"],
  "Cuerpo completo": ["cuerpo completo", "full body", "cardio", "core", "sentadilla", "remo", "press", "zancada"],
};

const MUSCLE_PROFILES = {
  Empuje: {
    primary: ["pecho", "hombro", "deltoid", "tricep"],
    secondary: ["core", "serrato", "trapec"],
  },
  Jalon: {
    primary: ["espalda", "dorsal", "bicep", "trapec", "romboid"],
    secondary: ["core", "posterior", "antebrazo"],
  },
  Piernas: {
    primary: ["pierna", "cuadricep", "femoral", "glute", "isquio", "pantorrilla"],
    secondary: ["core", "abductor", "aductor"],
  },
  Superior: {
    primary: ["pecho", "hombro", "espalda", "dorsal", "bicep", "tricep"],
    secondary: ["core", "trapec", "antebrazo"],
  },
  Inferior: {
    primary: ["pierna", "cuadricep", "femoral", "glute", "isquio", "pantorrilla"],
    secondary: ["core", "abductor", "aductor"],
  },
  "Cuerpo completo": {
    primary: ["pecho", "espalda", "pierna", "cuadricep", "glute", "core"],
    secondary: ["hombro", "bicep", "tricep", "cardio"],
  },
};

const HEAVY_KEYWORDS = [
  "sentadilla",
  "squat",
  "hack",
  "peso muerto",
  "deadlift",
  "hip thrust",
  "press banca",
  "bench press",
  "press militar",
  "overhead press",
  "remo con barra",
  "pull up lastrado",
  "dominadas lastradas",
  "prensa",
];

const LIGHT_KEYWORDS = [
  "abdomen",
  "abdominal",
  "crunch",
  "plancha",
  "core",
  "cuerda",
  "jump rope",
  "cardio",
  "bicicleta",
  "bike",
  "ergometro",
  "ergometer",
  "pantorrilla",
  "elevacion",
  "curl",
  "extension",
];

const EQUIPMENT_OPTIONS = [
  { id: "bodyweight", label: "Peso corporal", aliases: ["peso corporal", "bodyweight"] },
  { id: "barbell", label: "Barra", aliases: ["barra", "barbell"] },
  { id: "ezBar", label: "Barra Z", aliases: ["barra z", "ez bar", "ez_bar"] },
  { id: "dumbbells", label: "Mancuernas", aliases: ["mancuernas", "mancuerna", "dumbbell", "dumbbells"] },
  { id: "bench", label: "Banco", aliases: ["banco", "bench"] },
  { id: "machine", label: "Maquina", aliases: ["maquina", "machine"] },
  { id: "cable", label: "Polea", aliases: ["polea", "cable"] },
  { id: "kettlebell", label: "Kettlebell", aliases: ["kettlebell", "kettlebells"] },
  { id: "band", label: "Banda elastica", aliases: ["banda elastica", "band", "bands"] },
  { id: "pullupBar", label: "Barra dominadas", aliases: ["barra de dominadas", "barra dominadas", "pullup bar", "pullup_bar"] },
  { id: "parallelBars", label: "Paralelas", aliases: ["paralelas", "parallel bars", "parallel_bars"] },
  { id: "plate", label: "Discos", aliases: ["disco", "discos", "plate", "plates"] },
  { id: "box", label: "Cajon", aliases: ["cajon", "box", "plyo box", "plyo_box"] },
  { id: "jumpRope", label: "Cuerda", aliases: ["cuerda", "jump rope", "jump_rope"] },
  { id: "bike", label: "Bicicleta estatica", aliases: ["bicicleta estatica", "bike", "air bike", "stationary bike"] },
  { id: "rower", label: "Remo ergometro", aliases: ["remo ergometro", "rower", "ergometer"] },
];

const MEAL_ORDER = [
  { key: "desayuno", label: "Desayuno" },
  { key: "comida", label: "Comida" },
  { key: "colacion", label: "Colacion" },
  { key: "cena", label: "Cena" },
];

const DEFAULT_PREFERENCES = {
  goal: "Ganar musculo",
  split: "Empuje/Jalon/Piernas",
  sessionDurationMinutes: 60,
  availableEquipment: ["bodyweight", "dumbbells", "bench"],
};

const GOAL_MACRO_TARGETS = {
  "Ganar musculo": { calories: 2400, protein: 170, carbs: 250, fats: 75 },
  "Reducir peso corporal": { calories: 1900, protein: 160, carbs: 150, fats: 60 },
  "Definir musculo": { calories: 2100, protein: 170, carbs: 185, fats: 65 },
  "Ganar fuerza": { calories: 2500, protein: 175, carbs: 260, fats: 80 },
  "Mejorar condicion fisica": { calories: 2200, protein: 150, carbs: 220, fats: 70 },
};

const state = {
  view: "dashboard",
  loading: true,
  error: "",
  data: {
    exercises: [],
    families: [],
    recipes: [],
    challenges: buildChallengeSeed(),
  },
  preferences: loadStoredPreferences(),
  history: loadStoredHistory(),
  performanceBySlug: loadStoredPerformance(),
  completedRecipes: new Set(loadStoredArray(STORAGE_KEYS.completedRecipes)),
  shoppingList: loadStoredArray(STORAGE_KEYS.shoppingList),
  challengeRegistrations: loadStoredObject(STORAGE_KEYS.challengeRegistrations),
  plan: null,
  planInputs: {},
  ui: {
    exerciseQuery: "",
    recipeFilter: "all",
    selectedFamilyKey: null,
    toast: "",
  },
};

const appRoot = document.querySelector("#app");
let toastTimer = null;

window.addEventListener("hashchange", syncViewFromHash);
document.addEventListener("click", handleClick);
document.addEventListener("change", handleChange);
document.addEventListener("input", handleInput);

bootstrap();

async function bootstrap() {
  syncViewFromHash();
  render();
  await loadData();
}

async function loadData() {
  state.loading = true;
  state.error = "";
  render();

  try {
    const [exerciseResponse, recipeResponse] = await Promise.all([
      fetch("./data/exercise_detail_v1_seed.json"),
      fetch("./data/nutrition_recipes_mx.json"),
    ]);

    if (!exerciseResponse.ok || !recipeResponse.ok) {
      throw new Error("No se pudieron cargar los datos locales.");
    }

    const [exerciseSeed, recipeSeed] = await Promise.all([
      exerciseResponse.json(),
      recipeResponse.json(),
    ]);

    state.data.exercises = exerciseSeed.map(normalizeExercise);
    state.data.families = buildExerciseFamilies(state.data.exercises);
    state.data.recipes = recipeSeed.map(normalizeRecipe);
    state.data.challenges = buildChallengeSeed();
    state.ui.selectedFamilyKey = state.ui.selectedFamilyKey || state.data.families[0]?.key || null;
    regeneratePlan();
  } catch (error) {
    state.error = error instanceof Error ? error.message : "No se pudo iniciar la app web.";
  } finally {
    state.loading = false;
    render();
  }
}

function normalizeExercise(item) {
  const displayName = item.name.includes(" - ")
    ? item.name.split(" - ")[0].trim()
    : item.name.trim();
  const displayTechnique = item.technique || (item.name.includes(" - ") ? item.name.split(" - ").slice(1).join(" - ").trim() : "");
  const muscles = (item.muscles || []).map((muscle) => muscle.name);
  const equipment = (item.equipment || []).map((tool) => tool.name);

  return {
    ...item,
    displayName,
    displayTechnique,
    muscles,
    equipment,
    searchableText: normalize(
      [
        item.name,
        displayName,
        displayTechnique,
        item.slug,
        ...(item.similar_names || []),
        ...muscles,
        ...equipment,
      ].join(" ")
    ),
  };
}

function normalizeRecipe(recipe) {
  return {
    ...recipe,
    mealTypeKey: normalize(recipe.mealType),
    searchableText: normalize(
      [recipe.title, recipe.subtitle, recipe.mealType, ...(recipe.tags || []), ...(recipe.ingredients || [])].join(" ")
    ),
  };
}

function buildExerciseFamilies(exercises) {
  const map = new Map();

  for (const exercise of exercises) {
    const key = normalize(exercise.displayName);
    if (!map.has(key)) {
      map.set(key, {
        key,
        displayName: exercise.displayName,
        muscles: new Set(),
        equipment: new Set(),
        techniques: new Set(),
        instructions: exercise.instructions || [],
        variants: [],
      });
    }

    const family = map.get(key);
    exercise.muscles.forEach((name) => family.muscles.add(name));
    exercise.equipment.forEach((name) => family.equipment.add(name));
    if (exercise.displayTechnique) {
      family.techniques.add(exercise.displayTechnique);
    }
    family.variants.push(exercise);
  }

  return Array.from(map.values())
    .map((family) => ({
      ...family,
      muscles: Array.from(family.muscles),
      equipment: Array.from(family.equipment),
      techniques: Array.from(family.techniques),
      variantCount: family.variants.length,
      searchableText: normalize(
        [
          family.displayName,
          Array.from(family.muscles).join(" "),
          Array.from(family.equipment).join(" "),
          Array.from(family.techniques).join(" "),
        ].join(" ")
      ),
    }))
    .sort((left, right) => left.displayName.localeCompare(right.displayName, "es"));
}

function regeneratePlan() {
  if (!state.data.exercises.length) {
    state.plan = null;
    return;
  }

  state.plan = makePlan(
    state.preferences,
    state.history,
    state.data.exercises,
    state.performanceBySlug
  );
}

function makePlan(preferences, history, catalog, performanceBySlug) {
  const focus = nextFocus(preferences.split, history, new Date());
  const focusFatigue = fatiguePenalty(focus, preferences.split, history, new Date());
  const adjustedDuration = Math.max(20, preferences.sessionDurationMinutes - Math.round(focusFatigue * 6));
  const equipmentFiltered = filterByEquipment(catalog, new Set(preferences.availableEquipment));
  const focusFiltered = filterByFocus(equipmentFiltered, focus);
  const basePool = focusFiltered.length ? focusFiltered : equipmentFiltered;
  const rawTargetCount = targetExerciseCount(adjustedDuration);
  const fatigueReduction = Math.floor(Math.max(0, focusFatigue - 1.2));
  const targetCount = Math.max(2, rawTargetCount - fatigueReduction);
  const blueprints = makeBlueprints(preferences.goal, adjustedDuration, targetCount, focusFatigue);
  const scoredPool = [...basePool].sort(
    (left, right) =>
      score(right, focus, preferences.goal, focusFatigue) -
      score(left, focus, preferences.goal, focusFatigue)
  );

  const usedIds = new Set();
  const usedNames = new Set();
  const blocks = [];
  let blockIndex = 1;

  for (const blueprint of blueprints) {
    const picks = pickExercises(scoredPool, blueprint.type, preferences.goal, blueprint.size, usedIds, usedNames);
    if (!picks.length) {
      continue;
    }

    const exercises = picks.map((item, offset) => {
      const intensity = inferIntensity(item);
      const basePrescription = makePrescription(preferences.goal, blueprint.type, intensity, focus);
      const progression = makeProgression(
        item,
        performanceSnapshotForItem(item, performanceBySlug),
        basePrescription.repsText,
        preferences.goal,
        intensity
      );

      return {
        id: `${item.id}-${blockIndex}-${offset}`,
        exercise: item,
        sets: basePrescription.sets,
        repsText: basePrescription.repsText,
        restSeconds: adjustRest(basePrescription.restSeconds, focusFatigue, blueprint.type),
        notes: basePrescription.notes,
        suggestedWeightKg: progression.suggestedWeightKg,
        progressionNote: progression.note,
      };
    });

    blocks.push({
      id: `block-${blockIndex}`,
      type: blueprint.type,
      title: blockTitle(blueprint.type, blockIndex, preferences.goal),
      subtitle: blockSubtitle(blueprint.type, blueprint.rounds),
      rounds: blueprint.rounds,
      restBetweenRounds: blueprint.restBetweenRounds,
      exercises,
    });

    blockIndex += 1;
  }

  const estimatedMinutes = estimateDurationMinutes(adjustedDuration, blocks);
  const hasMatches = blocks.length > 0;

  return {
    id: uid("plan"),
    generatedAt: new Date().toISOString(),
    goal: preferences.goal,
    split: preferences.split,
    focus,
    title: hasMatches ? `Entrenamiento sugerido: ${focus}` : "Sin coincidencias de equipo",
    subtitle: `${preferences.goal} | ${estimatedMinutes} min`,
    estimatedMinutes,
    rationale:
      rationale(preferences.goal, preferences.split, focus, adjustedDuration, preferences.availableEquipment.length, focusFatigue) +
      (hasMatches ? "" : " No se encontraron ejercicios compatibles con el equipo seleccionado."),
    blocks,
  };
}

function nextFocus(split, history, now) {
  const cycle = FOCUS_CYCLES[split] || ["Cuerpo completo"];
  const splitHistory = history
    .filter((entry) => entry.split === split)
    .sort((left, right) => new Date(right.date) - new Date(left.date));

  if (!splitHistory.length) {
    return cycle[0];
  }

  const last = splitHistory[0];
  const lastIndex = cycle.indexOf(last.focus);
  if (lastIndex === -1) {
    return cycle[0];
  }

  const orderedCandidates = cycle.map((focus, index) => ({
    focus: cycle[(lastIndex + 1 + index) % cycle.length],
    order: index,
  }));

  orderedCandidates.sort((left, right) => {
    const leftPenalty = fatiguePenalty(left.focus, split, history, now) + left.order * 0.55;
    const rightPenalty = fatiguePenalty(right.focus, split, history, now) + right.order * 0.55;
    return leftPenalty - rightPenalty;
  });

  return orderedCandidates[0]?.focus || cycle[(lastIndex + 1) % cycle.length];
}

function fatiguePenalty(focus, split, history, now) {
  const focusSessions = history
    .filter((entry) => entry.split === split && entry.focus === focus)
    .sort((left, right) => new Date(right.date) - new Date(left.date));

  if (!focusSessions.length) {
    return 0;
  }

  const latestDate = new Date(focusSessions[0].date);
  const elapsedHours = Math.max(0, now - latestDate) / 3600000;

  let recencyPenalty = 0;
  if (elapsedHours < 24) recencyPenalty = 2.6;
  else if (elapsedHours < 48) recencyPenalty = 1.5;
  else if (elapsedHours < 72) recencyPenalty = 0.8;
  else if (elapsedHours < 120) recencyPenalty = 0.35;

  const weeklyWindow = now.getTime() - 7 * 24 * 3600 * 1000;
  const weeklyCount = focusSessions.filter((entry) => new Date(entry.date).getTime() >= weeklyWindow).length;
  const loadPenalty = Math.max(0, weeklyCount - 1) * 0.22;

  return recencyPenalty + loadPenalty;
}

function targetExerciseCount(durationMinutes) {
  if (durationMinutes < 35) return 3;
  if (durationMinutes < 50) return 4;
  if (durationMinutes < 65) return 5;
  if (durationMinutes < 80) return 6;
  return 7;
}

function makeBlueprints(goal, durationMinutes, targetCount, fatigue) {
  let template;
  switch (goal) {
    case "Ganar fuerza":
      template = ["single", "single", "single", "superset"];
      break;
    case "Ganar musculo":
      template = ["single", "superset", "single"];
      break;
    case "Definir musculo":
      template = ["superset", "circuit", "single"];
      break;
    case "Reducir peso corporal":
      template = ["circuit", "superset", "circuit"];
      break;
    default:
      template = ["circuit", "circuit", "superset"];
      break;
  }

  let pending = Math.max(2, targetCount);
  let index = 0;
  const result = [];

  while (pending > 0) {
    let type = template[index % template.length];
    let size = defaultBlockSize(type);

    if (pending < size) {
      if (pending === 1) {
        type = "single";
        size = 1;
      } else {
        size = pending;
      }
    }

    let rounds = null;
    let restBetweenRounds = null;

    if (type === "superset") {
      const baseRounds = durationMinutes >= 60 ? 4 : 3;
      rounds = fatigue >= 2 ? Math.max(2, baseRounds - 1) : baseRounds;
      restBetweenRounds = goal === "Ganar fuerza" ? 90 : 60;
    }

    if (type === "circuit") {
      const baseRounds =
        goal === "Mejorar condicion fisica" && durationMinutes >= 60
          ? 5
          : durationMinutes >= 50
            ? 4
            : 3;
      rounds = fatigue >= 2 ? Math.max(2, baseRounds - 1) : baseRounds;
      restBetweenRounds = goal === "Ganar fuerza" ? 90 : 60;
    }

    result.push({ type, size, rounds, restBetweenRounds });
    pending -= size;
    index += 1;
  }

  return result;
}

function defaultBlockSize(type) {
  if (type === "single") return 1;
  if (type === "superset") return 2;
  return 3;
}

function pickExercises(pool, type, goal, requestedCount, usedIds, usedNames) {
  const preferred = preferredIntensitiesForBlock(type, goal);
  const buckets = new Map();

  for (const item of pool) {
    const intensity = inferIntensity(item);
    if (!buckets.has(intensity)) {
      buckets.set(intensity, []);
    }
    buckets.get(intensity).push(item);
  }

  const result = [];

  for (const intensity of preferred) {
    const items = buckets.get(intensity) || [];
    for (const item of items) {
      const nameKey = normalize(item.displayName);
      if (usedIds.has(item.id) || usedNames.has(nameKey)) {
        continue;
      }
      result.push(item);
      usedIds.add(item.id);
      usedNames.add(nameKey);
      if (result.length >= requestedCount) {
        return result;
      }
    }
  }

  for (const item of pool) {
    const nameKey = normalize(item.displayName);
    if (usedIds.has(item.id) || usedNames.has(nameKey)) {
      continue;
    }
    result.push(item);
    usedIds.add(item.id);
    usedNames.add(nameKey);
    if (result.length >= requestedCount) {
      break;
    }
  }

  if (result.length < requestedCount) {
    for (const item of pool) {
      if (usedIds.has(item.id)) {
        continue;
      }
      result.push(item);
      usedIds.add(item.id);
      if (result.length >= requestedCount) {
        break;
      }
    }
  }

  return result;
}

function preferredIntensitiesForBlock(type, goal) {
  if (goal === "Ganar fuerza") {
    if (type === "single") return ["heavy", "moderate", "light"];
    return ["moderate", "light", "heavy"];
  }

  if (goal === "Ganar musculo") {
    if (type === "single") return ["heavy", "moderate", "light"];
    if (type === "superset") return ["moderate", "light", "heavy"];
    return ["light", "moderate", "heavy"];
  }

  if (goal === "Definir musculo") {
    if (type === "single") return ["moderate", "light", "heavy"];
    if (type === "superset") return ["moderate", "light", "heavy"];
    return ["light", "moderate", "heavy"];
  }

  if (goal === "Reducir peso corporal") {
    if (type === "single") return ["moderate", "light", "heavy"];
    return ["light", "moderate", "heavy"];
  }

  if (type === "single") return ["light", "moderate", "heavy"];
  return ["light", "moderate", "heavy"];
}

function makePrescription(goal, blockType, intensity, focus) {
  if (goal === "Ganar fuerza") {
    if (intensity === "heavy") return { sets: blockType === "single" ? 4 : 3, repsText: "4-6 reps", restSeconds: 180, notes: "Carga alta con tecnica estricta." };
    if (intensity === "moderate") return { sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Controla la fase excentrica." };
    return { sets: 3, repsText: "10-12 reps", restSeconds: 45, notes: "Usa este bloque como accesorio." };
  }

  if (goal === "Ganar musculo") {
    if (intensity === "heavy") return { sets: 4, repsText: "6-8 reps", restSeconds: 150, notes: "Enfocate en tension mecanica." };
    if (intensity === "moderate") return { sets: 3, repsText: "8-12 reps", restSeconds: 90, notes: "Busca rango completo y control." };
    return { sets: 3, repsText: "12-15 reps", restSeconds: 45, notes: "Serie metabolica para cierre." };
  }

  if (goal === "Definir musculo") {
    if (intensity === "heavy") return { sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Manten calidad de repeticiones." };
    if (intensity === "moderate") return { sets: 3, repsText: "10-14 reps", restSeconds: blockType === "single" ? 60 : 45, notes: "Prioriza densidad de entrenamiento." };
    return { sets: 3, repsText: "12-18 reps", restSeconds: 30, notes: "Descansos cortos para mayor gasto energetico." };
  }

  if (goal === "Reducir peso corporal") {
    if (intensity === "heavy") return { sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Conserva fuerza base." };
    if (intensity === "moderate") return { sets: 3, repsText: "10-15 reps", restSeconds: 45, notes: "Manten ritmo continuo." };
    return { sets: 3, repsText: "12-20 reps", restSeconds: 30, notes: "Bloque metabolico." };
  }

  if (intensity === "heavy") return { sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Compuesto de soporte." };
  if (intensity === "moderate") return { sets: 3, repsText: "10-14 reps", restSeconds: 45, notes: "Transiciones rapidas." };
  return {
    sets: 3,
    repsText: "40 seg trabajo",
    restSeconds: 30,
    notes: focus === "Cuerpo completo" ? "Prioriza respiracion y ritmo constante." : "Enfoca cardio y control tecnico.",
  };
}

function adjustRest(base, fatigue, blockType) {
  const fatigueExtra = Math.round(fatigue * 18);
  const typeAdjustment = blockType === "single" ? 0 : blockType === "superset" ? -8 : -12;
  return Math.max(20, base + fatigueExtra + typeAdjustment);
}

function makeProgression(item, snapshot, repsText, goal, intensity) {
  if (!snapshot) {
    return {
      suggestedWeightKg: null,
      note: "Sin historial. Registra tus series para activar progresion automatica.",
    };
  }

  const range = parseRepRange(repsText);
  if (!range) {
    return {
      suggestedWeightKg: snapshot.lastWeightKg || null,
      note: "Manten ritmo y tecnica; esta variante se guia por tiempo.",
    };
  }

  const lastWeight = Number(snapshot.lastWeightKg || 0);
  const lastReps = Number(snapshot.lastReps || 0);
  const incrementStep = intensity === "heavy" ? 2.5 : intensity === "moderate" ? 1.25 : 1.0;

  let delta = 0;
  if (lastReps >= range.max) {
    if (goal === "Ganar fuerza" || goal === "Ganar musculo") delta = incrementStep;
    if (goal === "Definir musculo") delta = incrementStep * 0.5;
  } else if (lastReps < range.min) {
    if (goal === "Ganar fuerza" || goal === "Ganar musculo") delta = -incrementStep * 0.5;
  }

  const suggestedWeightKg = roundToNearest(Math.max(0, lastWeight + delta), 0.5);
  const note =
    delta > 0
      ? `Progresion: +${formatWeight(delta)} kg respecto a tu ultimo registro.`
      : delta < 0
        ? `Ajuste tecnico: baja ~${formatWeight(Math.abs(delta))} kg para cumplir el rango objetivo.`
        : `Manten ${formatWeight(lastWeight)} kg y busca ${range.min}-${range.max} reps limpias.`;

  return { suggestedWeightKg, note };
}

function performanceSnapshotForItem(item, performanceBySlug) {
  const slugKey = normalize(item.slug);
  const idKey = normalize(item.id);
  return performanceBySlug[slugKey] || performanceBySlug[idKey] || null;
}

function parseRepRange(repsText) {
  const normalizedText = normalize(repsText);
  if (normalizedText.includes("seg") || normalizedText.includes("sec")) {
    return null;
  }

  const numbers = normalizedText
    .split(/[^0-9]+/g)
    .map((entry) => Number(entry))
    .filter((value) => Number.isFinite(value) && value > 0);

  if (!numbers.length) {
    return null;
  }

  if (numbers.length >= 2) {
    return { min: Math.min(numbers[0], numbers[1]), max: Math.max(numbers[0], numbers[1]) };
  }

  return { min: Math.max(1, numbers[0] - 1), max: numbers[0] + 1 };
}

function roundToNearest(value, step) {
  if (!step) return value;
  return Math.round(value / step) * step;
}

function formatWeight(value) {
  return Number.isInteger(value) ? String(value) : value.toFixed(1);
}

function inferIntensity(item) {
  const blob = normalize([item.name, item.slug, item.muscles.join(" ")].join(" "));

  if (HEAVY_KEYWORDS.some((keyword) => blob.includes(keyword))) {
    return "heavy";
  }

  if (LIGHT_KEYWORDS.some((keyword) => blob.includes(keyword))) {
    return "light";
  }

  return "moderate";
}

function filterByEquipment(exercises, selectedEquipment) {
  const allowedTokens = new Set();

  for (const id of selectedEquipment) {
    const option = EQUIPMENT_OPTIONS.find((entry) => entry.id === id);
    if (!option) {
      continue;
    }
    [option.label, ...option.aliases].forEach((value) => allowedTokens.add(normalize(value)));
  }

  return exercises.filter((item) => {
    if (!item.equipment.length) {
      return true;
    }

    const requirements = (item.equipment || []).map((name, index) => {
      const equipmentMeta = item.equipment?.[index];
      return [normalize(name), normalize(item.equipment?.[index] || ""), normalize(item.equipment?.[index] || "")];
    });

    return requirements.every((pair) => {
      const compactPair = pair.filter(Boolean);
      if (!compactPair.length) return true;
      return compactPair.some((requirement) =>
        Array.from(allowedTokens).some((token) => token.includes(requirement) || requirement.includes(token))
      );
    });
  });
}

function filterByFocus(exercises, focus) {
  const keywords = FOCUS_KEYWORDS[focus] || [];
  if (!keywords.length) {
    return exercises;
  }

  return exercises.filter((exercise) => {
    const blob = normalize([exercise.name, exercise.slug, exercise.muscles.join(" ")].join(" "));
    return keywords.some((keyword) => blob.includes(keyword));
  });
}

function score(item, focus, goal, fatigue) {
  const intensity = inferIntensity(item);
  const blob = normalize([item.name, item.slug, item.muscles.join(" ")].join(" "));
  const keywordMatches = (FOCUS_KEYWORDS[focus] || []).reduce(
    (count, keyword) => count + (blob.includes(keyword) ? 1 : 0),
    0
  );
  const muscleScore = musclePriorityScore(item, focus);

  let intensityScore = 1;
  if (goal === "Ganar fuerza") {
    intensityScore = intensity === "heavy" ? 2 : intensity === "moderate" ? 1 : 0.5;
  } else if (goal === "Ganar musculo") {
    intensityScore = intensity === "moderate" ? 2 : intensity === "heavy" ? 1.6 : 1;
  } else {
    intensityScore = intensity === "light" ? 2 : intensity === "moderate" ? 1.3 : 0.6;
  }

  const fatigueAdjustment =
    intensity === "heavy" ? fatigue * 0.55 : intensity === "moderate" ? fatigue * 0.25 : fatigue * 0.08;
  const equipmentSimplicity = item.equipment.length <= 1 ? 0.7 : 0.2;

  return muscleScore * 1.9 + keywordMatches * 0.8 + intensityScore + equipmentSimplicity - fatigueAdjustment;
}

function musclePriorityScore(item, focus) {
  const profile = MUSCLE_PROFILES[focus];
  if (!profile || !item.muscles.length) {
    return 0;
  }

  let total = 0;
  item.muscles.map(normalize).forEach((muscle, index) => {
    const isPrimary = profile.primary.some((entry) => muscle.includes(entry) || entry.includes(muscle));
    const isSecondary = profile.secondary.some((entry) => muscle.includes(entry) || entry.includes(muscle));

    if (isPrimary) {
      total += index === 0 ? 2.8 : 1.4;
    } else if (isSecondary) {
      total += index === 0 ? 1.4 : 0.8;
    }
  });

  return total;
}

function blockTitle(type, index, goal) {
  if (type === "single") {
    if (goal === "Ganar fuerza") return `Bloque de fuerza ${index}`;
    if (goal === "Ganar musculo") return `Bloque principal ${index}`;
    return `Bloque tecnico ${index}`;
  }
  return type === "superset" ? `Superset ${index}` : `Circuito ${index}`;
}

function blockSubtitle(type, rounds) {
  if (type === "single") {
    return "Descansa al terminar cada serie segun la prescripcion.";
  }
  const roundsText = rounds ? `${rounds} rondas` : "Rondas";
  return type === "superset"
    ? `Alterna ejercicios sin descanso. ${roundsText}.`
    : `Completa todos los ejercicios seguidos. ${roundsText}.`;
}

function estimateDurationMinutes(fallbackDuration, blocks) {
  if (!blocks.length) {
    return fallbackDuration;
  }

  let totalSeconds = 0;

  for (const block of blocks) {
    if (block.type === "single") {
      for (const exercise of block.exercises) {
        const workSeconds = estimateWorkSeconds(exercise.repsText);
        totalSeconds += (workSeconds + exercise.restSeconds) * exercise.sets;
      }
      continue;
    }

    const rounds = block.rounds || 3;
    const workPerRound = block.exercises.reduce((sum, exercise) => sum + estimateWorkSeconds(exercise.repsText), 0);
    totalSeconds += workPerRound * rounds;
    if (rounds > 1) {
      totalSeconds += (block.restBetweenRounds || 60) * (rounds - 1);
    }
  }

  const estimated = Math.ceil(totalSeconds / 60);
  if (!estimated) {
    return fallbackDuration;
  }

  const lowerBound = Math.max(20, fallbackDuration - 12);
  const upperBound = fallbackDuration + 12;
  return Math.min(Math.max(estimated, lowerBound), upperBound);
}

function estimateWorkSeconds(repsText) {
  const normalizedText = normalize(repsText);
  if (normalizedText.includes("seg") || normalizedText.includes("sec")) {
    const digits = normalizedText
      .split(/[^0-9]+/g)
      .map((entry) => Number(entry))
      .filter((value) => Number.isFinite(value) && value > 0);
    return digits.length ? Math.max(...digits) : 40;
  }

  const digits = normalizedText
    .split(/[^0-9]+/g)
    .map((entry) => Number(entry))
    .filter((value) => Number.isFinite(value) && value > 0);

  if (!digits.length) {
    return 40;
  }

  return Math.min(70, Math.max(25, Math.max(...digits) * 3));
}

function fatigueLabel(penalty) {
  if (penalty < 0.6) return "baja";
  if (penalty < 1.6) return "media";
  return "alta";
}

function rationale(goal, split, focus, durationMinutes, equipmentCount, fatigue) {
  return `Sugerencia generada por objetivo (${goal}), division (${split}), enfoque de hoy (${focus}), duracion objetivo (${durationMinutes} min), equipo disponible (${equipmentCount} opciones) y fatiga estimada (${fatigueLabel(fatigue)}).`;
}

function completeCurrentPlan() {
  if (!state.plan) {
    return;
  }

  const completedAt = new Date();
  const session = {
    id: uid("session"),
    date: completedAt.toISOString(),
    split: state.plan.split,
    focus: state.plan.focus,
    plannedMinutes: state.plan.estimatedMinutes,
    title: state.plan.title,
  };

  state.history.unshift(session);
  state.history = state.history.slice(0, 90);

  for (const block of state.plan.blocks) {
    for (const exercise of block.exercises) {
      const snapshotKey = normalize(exercise.exercise.slug);
      const previous = state.performanceBySlug[snapshotKey] || {
        id: snapshotKey,
        exerciseID: exercise.exercise.id,
        exerciseSlug: exercise.exercise.slug,
        lastWeightKg: 0,
        bestWeightKg: 0,
        lastReps: 0,
        sessionsCount: 0,
        updatedAt: completedAt.toISOString(),
      };

      const input = state.planInputs[exercise.id] || {};
      const parsedRange = parseRepRange(exercise.repsText);
      const defaultReps = parsedRange ? parsedRange.max : Number(previous.lastReps || 0);
      const weight =
        input.weight === "" || input.weight === undefined
          ? Number(exercise.suggestedWeightKg ?? previous.lastWeightKg ?? 0)
          : Number(input.weight);
      const reps =
        input.reps === "" || input.reps === undefined
          ? Number(defaultReps || 0)
          : Number(input.reps);

      state.performanceBySlug[snapshotKey] = {
        ...previous,
        lastWeightKg: Number.isFinite(weight) ? weight : previous.lastWeightKg,
        bestWeightKg: Math.max(previous.bestWeightKg || 0, Number.isFinite(weight) ? weight : 0),
        lastReps: Number.isFinite(reps) ? reps : previous.lastReps,
        sessionsCount: Number(previous.sessionsCount || 0) + 1,
        updatedAt: completedAt.toISOString(),
      };
    }
  }

  state.planInputs = {};
  persistState();
  regeneratePlan();
  setToast("Entrenamiento registrado en el navegador.");
}

function persistState() {
  localStorage.setItem(STORAGE_KEYS.preferences, JSON.stringify(state.preferences));
  localStorage.setItem(STORAGE_KEYS.history, JSON.stringify(state.history));
  localStorage.setItem(STORAGE_KEYS.performance, JSON.stringify(state.performanceBySlug));
  localStorage.setItem(STORAGE_KEYS.completedRecipes, JSON.stringify(Array.from(state.completedRecipes)));
  localStorage.setItem(STORAGE_KEYS.shoppingList, JSON.stringify(state.shoppingList));
  localStorage.setItem(STORAGE_KEYS.challengeRegistrations, JSON.stringify(state.challengeRegistrations));
}

function loadStoredPreferences() {
  const stored = loadStoredObject(STORAGE_KEYS.preferences);
  return {
    ...DEFAULT_PREFERENCES,
    ...stored,
    availableEquipment: Array.isArray(stored.availableEquipment)
      ? stored.availableEquipment
      : DEFAULT_PREFERENCES.availableEquipment,
  };
}

function loadStoredHistory() {
  const stored = loadStoredArray(STORAGE_KEYS.history);
  return stored.map((entry) => ({
    ...entry,
    date: entry.date,
  }));
}

function loadStoredPerformance() {
  return loadStoredObject(STORAGE_KEYS.performance);
}

function loadStoredArray(key) {
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return [];
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

function loadStoredObject(key) {
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return {};
    const parsed = JSON.parse(raw);
    return parsed && typeof parsed === "object" ? parsed : {};
  } catch {
    return {};
  }
}

function handleClick(event) {
  const target = event.target.closest("[data-action]");
  if (!target) {
    return;
  }

  const { action } = target.dataset;

  if (action === "set-view") {
    state.view = target.dataset.view;
    syncHashToView();
    render();
    return;
  }

  if (action === "retry-load") {
    loadData();
    return;
  }

  if (action === "jump-training") {
    state.view = "training";
    syncHashToView();
    render();
    return;
  }

  if (action === "jump-explorer") {
    state.view = "explorer";
    syncHashToView();
    render();
    return;
  }

  if (action === "jump-nutrition") {
    state.view = "nutrition";
    syncHashToView();
    render();
    return;
  }

  if (action === "jump-progress") {
    state.view = "progress";
    syncHashToView();
    render();
    return;
  }

  if (action === "generate-plan") {
    regeneratePlan();
    setToast("Plan actualizado con tus preferencias actuales.");
    render();
    return;
  }

  if (action === "complete-plan") {
    completeCurrentPlan();
    render();
    return;
  }

  if (action === "toggle-equipment") {
    const equipmentId = target.dataset.equipment;
    if (!equipmentId) return;

    const selected = new Set(state.preferences.availableEquipment);
    if (selected.has(equipmentId)) selected.delete(equipmentId);
    else selected.add(equipmentId);

    state.preferences.availableEquipment = Array.from(selected);
    persistState();
    regeneratePlan();
    render();
    return;
  }

  if (action === "select-family") {
    state.ui.selectedFamilyKey = target.dataset.familyKey;
    render();
    return;
  }

  if (action === "toggle-recipe") {
    const recipeId = target.dataset.recipeId;
    if (!recipeId) return;

    if (state.completedRecipes.has(recipeId)) state.completedRecipes.delete(recipeId);
    else state.completedRecipes.add(recipeId);

    persistState();
    render();
    return;
  }

  if (action === "add-ingredients") {
    const recipeId = target.dataset.recipeId;
    const recipe = state.data.recipes.find((entry) => entry.id === recipeId);
    if (!recipe) return;
    addIngredientsToShoppingList(recipe.ingredients);
    setToast(`Ingredientes agregados: ${recipe.title}.`);
    render();
    return;
  }

  if (action === "add-day-ingredients") {
    addIngredientsToShoppingList(state.data.recipes.flatMap((recipe) => recipe.ingredients));
    setToast("La lista de compras se actualizo con todo el menu.");
    render();
    return;
  }

  if (action === "clear-shopping") {
    state.shoppingList = [];
    persistState();
    setToast("Lista de compras vaciada.");
    render();
    return;
  }

  if (action === "toggle-shopping") {
    const itemId = target.dataset.itemId;
    state.shoppingList = state.shoppingList.map((item) =>
      item.id === itemId ? { ...item, done: !item.done } : item
    );
    persistState();
    render();
    return;
  }

  if (action === "remove-shopping") {
    const itemId = target.dataset.itemId;
    state.shoppingList = state.shoppingList.filter((item) => item.id !== itemId);
    persistState();
    render();
    return;
  }

  if (action === "toggle-challenge") {
    const challengeId = target.dataset.challengeId;
    if (!challengeId) return;

    if (state.challengeRegistrations[challengeId]) {
      delete state.challengeRegistrations[challengeId];
    } else {
      state.challengeRegistrations[challengeId] = new Date().toISOString();
    }

    persistState();
    render();
    return;
  }
}

function handleChange(event) {
  const target = event.target;
  if (!(target instanceof HTMLElement)) return;

  if (target.matches("[data-pref='goal']")) {
    state.preferences.goal = target.value;
    persistState();
    regeneratePlan();
    render();
    return;
  }

  if (target.matches("[data-pref='split']")) {
    state.preferences.split = target.value;
    persistState();
    regeneratePlan();
    render();
    return;
  }

  if (target.matches("[data-pref='duration']")) {
    state.preferences.sessionDurationMinutes = Number(target.value);
    persistState();
    regeneratePlan();
    render();
    return;
  }

  if (target.matches("[data-ui='recipeFilter']")) {
    state.ui.recipeFilter = target.value;
    render();
    return;
  }
}

function handleInput(event) {
  const target = event.target;
  if (!(target instanceof HTMLElement)) return;

  if (target.matches("[data-ui='exerciseQuery']")) {
    state.ui.exerciseQuery = target.value;
    render();
    return;
  }

  if (target.matches("[data-plan-field]")) {
    const exerciseId = target.dataset.exerciseId;
    const field = target.dataset.planField;
    if (!exerciseId || !field) return;
    state.planInputs[exerciseId] = state.planInputs[exerciseId] || {};
    state.planInputs[exerciseId][field] = target.value;
  }
}

function addIngredientsToShoppingList(ingredients) {
  const normalizedCurrent = new Set(state.shoppingList.map((item) => normalize(item.text)));
  for (const ingredient of ingredients) {
    if (normalizedCurrent.has(normalize(ingredient))) {
      continue;
    }
    state.shoppingList.push({
      id: uid("shop"),
      text: ingredient,
      done: false,
    });
    normalizedCurrent.add(normalize(ingredient));
  }
  persistState();
}

function syncViewFromHash() {
  const requested = window.location.hash.replace("#", "");
  const valid = VIEW_OPTIONS.some((entry) => entry.id === requested);
  state.view = valid ? requested : state.view || "dashboard";
}

function syncHashToView() {
  if (window.location.hash !== `#${state.view}`) {
    window.location.hash = state.view;
  }
}

function render() {
  const stats = buildStats();

  appRoot.innerHTML = `
    <div class="app-shell">
      ${renderHeader(stats)}
      ${state.error ? renderErrorBanner(state.error) : ""}
      ${state.loading ? renderLoading() : renderCurrentView(stats)}
    </div>
    ${state.ui.toast ? `<div class="toast" role="status" aria-live="polite">${escapeHtml(state.ui.toast)}</div>` : ""}
  `;
}

function renderHeader(stats) {
  return `
    <header class="masthead glass-panel">
      <div class="masthead-top">
        <div class="brand-line">
          <div class="brand-mark">X</div>
          <div class="brand-copy">
            <p class="eyebrow">Browser Ready</p>
            <h1>XibApp Web</h1>
            <p>Entrenamiento, explorador tecnico, nutricion y progreso directo en GitHub Pages.</p>
          </div>
        </div>
        <div class="status-cluster">
          <span class="status-pill"><span class="status-dot"></span>${state.data.exercises.length || 0} ejercicios</span>
          <span class="status-pill">${state.data.recipes.length || 0} recetas activas</span>
          <span class="status-pill">${stats.totalSessions} sesiones guardadas</span>
        </div>
      </div>
      <nav class="nav-strip" aria-label="Navegacion principal">
        ${VIEW_OPTIONS.map(
          (option) => `
            <button class="nav-pill ${state.view === option.id ? "is-active" : ""}" data-action="set-view" data-view="${option.id}">
              ${escapeHtml(option.label)}
            </button>
          `
        ).join("")}
      </nav>
    </header>
  `;
}

function renderErrorBanner(message) {
  return `
    <section class="panel-card">
      <div class="panel-title">
        <h3>Error de carga</h3>
        <button class="secondary-button" data-action="retry-load">Reintentar</button>
      </div>
      <p class="panel-copy">${escapeHtml(message)}</p>
    </section>
  `;
}

function renderLoading() {
  return `
    <section class="glass-panel boot-screen">
      <div>
        <div class="brand-lockup">
          <div class="brand-mark">X</div>
          <div>
            <p class="eyebrow">Inicializando</p>
            <h1>XibApp Web</h1>
          </div>
        </div>
        <p class="boot-copy">Preparando catalogo de ejercicios, recetas y modulos persistidos.</p>
      </div>
    </section>
  `;
}

function renderCurrentView(stats) {
  switch (state.view) {
    case "training":
      return renderTrainingView();
    case "explorer":
      return renderExplorerView();
    case "nutrition":
      return renderNutritionView();
    case "challenges":
      return renderChallengesView();
    case "progress":
      return renderProgressView(stats);
    default:
      return renderDashboardView(stats);
  }
}

function renderDashboardView(stats) {
  return `
    <section class="section-stack">
      <div class="hero-grid">
        <article class="glass-panel hero-copy">
          <p class="eyebrow">Native logic, browser workflow</p>
          <h1>Tu app fitness ahora vive dentro del navegador.</h1>
          <p>
            Esta version web toma los datos reales del proyecto iOS y los vuelve una experiencia
            interactiva para entrenamiento sugerido, exploracion tecnica, nutricion y seguimiento local.
          </p>
          <div class="hero-actions">
            <button class="action-button" data-action="jump-training">Generar entrenamiento</button>
            <button class="secondary-button" data-action="jump-explorer">Explorar ejercicios</button>
            <button class="ghost-button" data-action="jump-nutrition">Abrir nutricion</button>
          </div>
        </article>
        <aside class="summary-card hero-note">
          <div class="panel-title">
            <h3>Estado de hoy</h3>
            <span class="chip is-jade">${escapeHtml(state.plan?.focus || "Sin plan")}</span>
          </div>
          <p>${escapeHtml(state.plan?.rationale || "Configura tus preferencias para generar un plan de entrenamiento.")}</p>
          <div class="meta-strip">
            <span class="chip">${stats.weeklySessions} sesiones / 7 dias</span>
            <span class="chip is-gold">${stats.streakDays} dias de racha</span>
            <span class="chip">${stats.registeredChallenges} retos activos</span>
          </div>
        </aside>
      </div>

      <div class="summary-grid">
        <article class="summary-card">
          <span class="label">Sesiones totales</span>
          <span class="value">${stats.totalSessions}</span>
          <div class="accent-line"></div>
        </article>
        <article class="summary-card">
          <span class="label">Macros consumidos hoy</span>
          <span class="value">${stats.macros.calories}</span>
          <div class="accent-line"></div>
        </article>
        <article class="summary-card">
          <span class="label">Compras pendientes</span>
          <span class="value">${stats.pendingShopping}</span>
          <div class="accent-line"></div>
        </article>
      </div>

      <div class="content-grid">
        <section class="panel-card">
          <div class="view-header">
            <div>
              <h2>Resumen rapido</h2>
              <p>Lo mas util para arrancar sin cambiar de modulo.</p>
            </div>
          </div>
          <div class="metrics-grid">
            <article class="metric-card">
              <span class="label">Enfoque sugerido</span>
              <span class="value">${escapeHtml(state.plan?.focus || "Listo")}</span>
              <div class="accent-line"></div>
            </article>
            <article class="metric-card gold">
              <span class="label">Minutos planeados</span>
              <span class="value">${state.plan?.estimatedMinutes || state.preferences.sessionDurationMinutes}</span>
              <div class="accent-line"></div>
            </article>
            <article class="metric-card magenta">
              <span class="label">Recetas completadas</span>
              <span class="value">${stats.completedRecipes}</span>
              <div class="accent-line"></div>
            </article>
          </div>
          <div class="feature-card">
            <h3>Top retos registrados</h3>
            ${
              stats.registeredChallengeItems.length
                ? `
                  <div class="challenge-list">
                    ${stats.registeredChallengeItems
                      .map(
                        (item) => `
                          <article class="challenge-highlight">
                            <strong>${escapeHtml(item.title)}</strong>
                            <p class="panel-meta">${escapeHtml(item.subtitle)}</p>
                          </article>
                        `
                      )
                      .join("")}
                  </div>
                `
                : renderEmptyState("Todavia no te registras en un reto o evento.")
            }
          </div>
        </section>

        <section class="plan-shell">
          <article class="plan-overview panel-card">
            <div class="plan-title-row">
              <div>
                <p class="eyebrow">Plan actual</p>
                <h3>${escapeHtml(state.plan?.title || "Entrenamiento pendiente")}</h3>
              </div>
              <div class="button-row">
                <button class="secondary-button" data-action="jump-training">Editar preferencias</button>
                <button class="ghost-button" data-action="jump-progress">Ver progreso</button>
              </div>
            </div>
            <p>${escapeHtml(state.plan?.subtitle || "Crea tu primer plan con los modulos de entrenamiento y progreso.")}</p>
            <div class="meta-strip">
              <span class="chip is-jade">${escapeHtml(state.preferences.goal)}</span>
              <span class="chip">${escapeHtml(state.preferences.split)}</span>
              <span class="chip is-gold">${state.preferences.sessionDurationMinutes} min</span>
            </div>
          </article>
          ${renderPlanBlocks(true)}
        </section>
      </div>
    </section>
  `;
}

function renderTrainingView() {
  return `
    <section class="section-stack">
      <div class="view-header">
        <div>
          <h2>Entrenamiento en navegador</h2>
          <p>La recomendacion usa la misma logica de foco, equipo, fatiga y progresion que ya existe en la app.</p>
        </div>
        <div class="meta-strip">
          <span class="chip is-jade">${escapeHtml(state.preferences.goal)}</span>
          <span class="chip">${escapeHtml(state.preferences.split)}</span>
          <span class="chip is-gold">${state.preferences.sessionDurationMinutes} min</span>
        </div>
      </div>

      <div class="content-grid">
        <aside class="panel-card">
          <div class="panel-title">
            <h3>Preferencias</h3>
            <span class="chip">${state.preferences.availableEquipment.length} equipos</span>
          </div>
          <div class="field-grid">
            <div class="field-group">
              <label for="goal-select">Objetivo</label>
              <select id="goal-select" class="select-input" data-pref="goal">
                ${GOALS.map(
                  (goal) => `<option value="${escapeHtml(goal)}" ${goal === state.preferences.goal ? "selected" : ""}>${escapeHtml(goal)}</option>`
                ).join("")}
              </select>
            </div>
            <div class="field-group">
              <label for="split-select">Division</label>
              <select id="split-select" class="select-input" data-pref="split">
                ${SPLITS.map(
                  (split) => `<option value="${escapeHtml(split)}" ${split === state.preferences.split ? "selected" : ""}>${escapeHtml(split)}</option>`
                ).join("")}
              </select>
            </div>
            <div class="field-group">
              <label for="duration-range">Duracion de sesion</label>
              <div class="slider-row">
                <input
                  id="duration-range"
                  class="slider-input"
                  type="range"
                  min="20"
                  max="100"
                  step="5"
                  value="${state.preferences.sessionDurationMinutes}"
                  data-pref="duration"
                />
                <span class="range-badge">${state.preferences.sessionDurationMinutes} min</span>
              </div>
            </div>
            <div class="field-group">
              <span class="control-label">Equipo disponible</span>
              <div class="equipment-grid">
                ${EQUIPMENT_OPTIONS.map((option) => {
                  const active = state.preferences.availableEquipment.includes(option.id);
                  return `
                    <button class="toggle-chip ${active ? "is-active" : ""}" data-action="toggle-equipment" data-equipment="${option.id}">
                      ${escapeHtml(option.label)}
                    </button>
                  `;
                }).join("")}
              </div>
            </div>
            <div class="button-row">
              <button class="action-button" data-action="generate-plan">Regenerar plan</button>
              <button class="secondary-button" data-action="complete-plan">Completar entrenamiento</button>
            </div>
          </div>
        </aside>

        <section class="plan-shell">
          <article class="plan-overview panel-card">
            <div class="plan-title-row">
              <div>
                <p class="eyebrow">Plan generado</p>
                <h3>${escapeHtml(state.plan?.title || "Sin plan disponible")}</h3>
              </div>
              <div class="meta-strip">
                <span class="chip is-jade">${escapeHtml(state.plan?.focus || "-")}</span>
                <span class="chip is-gold">${state.plan?.estimatedMinutes || state.preferences.sessionDurationMinutes} min</span>
              </div>
            </div>
            <p>${escapeHtml(state.plan?.rationale || "Ajusta tus preferencias para crear un plan.")}</p>
          </article>
          ${renderPlanBlocks(false)}
        </section>
      </div>
    </section>
  `;
}

function renderPlanBlocks(compact) {
  if (!state.plan?.blocks?.length) {
    return renderEmptyState("No se encontraron ejercicios compatibles con la combinacion actual.");
  }

  return `
    <div class="plan-blocks">
      ${state.plan.blocks
        .map(
          (block) => `
            <article class="feature-card">
              <div class="panel-title">
                <div>
                  <h3>${escapeHtml(block.title)}</h3>
                  <p class="panel-meta">${escapeHtml(block.subtitle)}</p>
                </div>
                ${block.rounds ? `<span class="chip">${block.rounds} rondas</span>` : ""}
              </div>
              <div class="exercise-list">
                ${block.exercises.map((exercise) => renderPlanExerciseCard(exercise, compact)).join("")}
              </div>
            </article>
          `
        )
        .join("")}
    </div>
  `;
}

function renderPlanExerciseCard(entry, compact) {
  const input = state.planInputs[entry.id] || {};
  return `
    <article class="exercise-card">
      <div class="exercise-heading">
        <div>
          <h4>${escapeHtml(entry.exercise.displayName)}</h4>
          <p class="exercise-subtitle">${escapeHtml(entry.exercise.displayTechnique || entry.exercise.muscles.slice(0, 2).join(" / "))}</p>
        </div>
        <span class="family-count">${escapeHtml(entry.exercise.equipment.join(", ") || "Equipo libre")}</span>
      </div>
      <div class="exercise-meta-grid">
        <div class="mini-stat"><span class="label">Series</span><span class="value">${entry.sets}</span></div>
        <div class="mini-stat"><span class="label">Reps</span><span class="value">${escapeHtml(entry.repsText)}</span></div>
        <div class="mini-stat"><span class="label">Descanso</span><span class="value">${entry.restSeconds}s</span></div>
        <div class="mini-stat"><span class="label">Carga sugerida</span><span class="value">${entry.suggestedWeightKg != null ? `${formatWeight(entry.suggestedWeightKg)} kg` : "-"}</span></div>
      </div>
      <div class="exercise-prescription">
        <p class="small-copy">${escapeHtml(entry.notes)}</p>
        <p class="small-copy">${escapeHtml(entry.progressionNote)}</p>
      </div>
      ${
        compact
          ? ""
          : `
            <div class="inline-form-grid">
              <div class="field-group">
                <label for="weight-${entry.id}">Peso real (kg)</label>
                <input
                  id="weight-${entry.id}"
                  class="number-input"
                  type="number"
                  step="0.5"
                  min="0"
                  value="${escapeAttribute(input.weight ?? "")}"
                  data-plan-field="weight"
                  data-exercise-id="${entry.id}"
                />
              </div>
              <div class="field-group">
                <label for="reps-${entry.id}">Reps logradas</label>
                <input
                  id="reps-${entry.id}"
                  class="number-input"
                  type="number"
                  step="1"
                  min="0"
                  value="${escapeAttribute(input.reps ?? "")}"
                  data-plan-field="reps"
                  data-exercise-id="${entry.id}"
                />
              </div>
            </div>
          `
      }
    </article>
  `;
}

function renderExplorerView() {
  const filteredFamilies = state.data.families
    .filter((family) => !state.ui.exerciseQuery || family.searchableText.includes(normalize(state.ui.exerciseQuery)))
    .slice(0, 80);
  const selectedFamily =
    filteredFamilies.find((family) => family.key === state.ui.selectedFamilyKey) ||
    filteredFamilies[0] ||
    null;

  if (selectedFamily && state.ui.selectedFamilyKey !== selectedFamily.key) {
    state.ui.selectedFamilyKey = selectedFamily.key;
  }

  return `
    <section class="section-stack">
      <div class="view-header">
        <div>
          <h2>Explorador de ejercicios</h2>
          <p>Busqueda por familias de movimiento, con variantes, tecnicas y grupos musculares del catalogo local.</p>
        </div>
        <div class="meta-strip">
          <span class="chip is-jade">${filteredFamilies.length} familias visibles</span>
          <span class="chip">${state.data.exercises.length} variantes cargadas</span>
        </div>
      </div>

      <div class="exercise-grid">
        <section class="panel-card">
          <div class="field-group">
            <label for="exercise-query">Buscar ejercicio</label>
            <input
              id="exercise-query"
              class="text-input"
              type="search"
              value="${escapeAttribute(state.ui.exerciseQuery)}"
              placeholder="Ejemplo: sentadilla, espalda, mancuernas"
              data-ui="exerciseQuery"
            />
          </div>
          <div class="family-list">
            ${
              filteredFamilies.length
                ? filteredFamilies
                    .map(
                      (family) => `
                        <button class="family-card ${selectedFamily?.key === family.key ? "is-active" : ""}" data-action="select-family" data-family-key="${family.key}">
                          <div class="exercise-heading">
                            <div>
                              <h4>${escapeHtml(family.displayName)}</h4>
                              <p>${escapeHtml(family.muscles.slice(0, 3).join(", "))}</p>
                            </div>
                            <span class="family-count">${family.variantCount} variantes</span>
                          </div>
                          <div class="tag-row">
                            ${family.equipment.slice(0, 3).map((name) => `<span class="tag">${escapeHtml(name)}</span>`).join("")}
                          </div>
                        </button>
                      `
                    )
                    .join("")
                : renderEmptyState("No hay coincidencias con esa busqueda.")
            }
          </div>
        </section>

        <section class="exercise-detail panel-card">
          ${
            selectedFamily
              ? `
                <div class="view-header">
                  <div>
                    <h2>${escapeHtml(selectedFamily.displayName)}</h2>
                    <p>${escapeHtml(`Variantes tecnicas para ${selectedFamily.muscles.slice(0, 2).join(" y ") || "distintos grupos musculares"}.`)}</p>
                  </div>
                  <div class="meta-strip">
                    <span class="chip is-jade">${selectedFamily.variantCount} variantes</span>
                    <span class="chip">${selectedFamily.equipment.length} equipos</span>
                  </div>
                </div>
                <div class="detail-grid">
                  <div class="detail-block">
                    <h3>Musculos</h3>
                    <div class="chip-row">
                      ${selectedFamily.muscles.map((muscle) => `<span class="chip">${escapeHtml(muscle)}</span>`).join("")}
                    </div>
                  </div>
                  <div class="detail-block">
                    <h3>Equipo</h3>
                    <div class="chip-row">
                      ${selectedFamily.equipment.map((tool) => `<span class="chip is-gold">${escapeHtml(tool)}</span>`).join("")}
                    </div>
                  </div>
                </div>
                <div class="detail-grid">
                  <div class="detail-block">
                    <h3>Tecnicas disponibles</h3>
                    <div class="chip-row">
                      ${selectedFamily.techniques.length
                        ? selectedFamily.techniques.map((technique) => `<span class="chip">${escapeHtml(technique)}</span>`).join("")
                        : `<span class="chip">Tecnica base</span>`}
                    </div>
                  </div>
                  <div class="detail-block">
                    <h3>Instrucciones base</h3>
                    <ul>
                      ${(selectedFamily.instructions || []).slice(0, 4).map((step) => `<li>${escapeHtml(step)}</li>`).join("")}
                    </ul>
                  </div>
                </div>
                <div class="detail-block">
                  <h3>Variantes destacadas</h3>
                  <div class="exercise-list">
                    ${selectedFamily.variants.slice(0, 8).map((variant) => `
                      <article class="exercise-card">
                        <div class="exercise-heading">
                          <div>
                            <h4>${escapeHtml(variant.displayTechnique || variant.name)}</h4>
                            <p class="exercise-subtitle">${escapeHtml(variant.slug)}</p>
                          </div>
                          <span class="family-count">${escapeHtml(variant.equipment.join(", ") || "Libre")}</span>
                        </div>
                        <p class="small-copy">${escapeHtml((variant.instructions || [])[2] || (variant.instructions || [])[0] || "Sin instrucciones adicionales.")}</p>
                      </article>
                    `).join("")}
                  </div>
                </div>
              `
              : renderEmptyState("Selecciona una familia de ejercicios para ver detalles.")
          }
        </section>
      </div>
    </section>
  `;
}

function renderNutritionView() {
  const macroTarget = GOAL_MACRO_TARGETS[state.preferences.goal] || GOAL_MACRO_TARGETS["Ganar musculo"];
  const consumed = state.data.recipes
    .filter((recipe) => state.completedRecipes.has(recipe.id))
    .reduce(
      (totals, recipe) => ({
        calories: totals.calories + recipe.macros.calories,
        protein: totals.protein + recipe.macros.protein,
        carbs: totals.carbs + recipe.macros.carbs,
        fats: totals.fats + recipe.macros.fats,
      }),
      { calories: 0, protein: 0, carbs: 0, fats: 0 }
    );

  const filteredRecipes = state.data.recipes.filter((recipe) => {
    if (state.ui.recipeFilter === "all") return true;
    return recipe.mealTypeKey === state.ui.recipeFilter;
  });

  return `
    <section class="section-stack">
      <div class="view-header">
        <div>
          <h2>Nutricion aplicada</h2>
          <p>Recetas reales del proyecto con checklist, acumulado de macros y lista de compras persistida.</p>
        </div>
        <div class="button-row">
          <button class="secondary-button" data-action="add-day-ingredients">Agregar menu completo a compras</button>
          <button class="ghost-button" data-action="clear-shopping">Vaciar compras</button>
        </div>
      </div>

      <div class="stack-grid">
        <section class="panel-card">
          <div class="panel-title">
            <h3>Consumo del dia</h3>
            <select class="select-input" data-ui="recipeFilter">
              <option value="all" ${state.ui.recipeFilter === "all" ? "selected" : ""}>Todas las comidas</option>
              ${MEAL_ORDER.map(
                (meal) => `<option value="${meal.key}" ${state.ui.recipeFilter === meal.key ? "selected" : ""}>${escapeHtml(meal.label)}</option>`
              ).join("")}
            </select>
          </div>
          <div class="macro-grid">
            ${renderMacroRow("Calorias", consumed.calories, macroTarget.calories, "default")}
            ${renderMacroRow("Proteina", consumed.protein, macroTarget.protein, "protein")}
            ${renderMacroRow("Carbohidratos", consumed.carbs, macroTarget.carbs, "carbs")}
            ${renderMacroRow("Grasas", consumed.fats, macroTarget.fats, "fats")}
          </div>
        </section>

        <section class="shopping-card">
          <div class="panel-title">
            <h3>Lista de compras</h3>
            <span class="chip">${state.shoppingList.length} items</span>
          </div>
          ${
            state.shoppingList.length
              ? `
                <div class="shopping-list">
                  ${state.shoppingList
                    .map(
                      (item) => `
                        <div class="shopping-item ${item.done ? "is-done" : ""}">
                          <label>
                            <input type="checkbox" ${item.done ? "checked" : ""} data-action="toggle-shopping" data-item-id="${item.id}" />
                            <span>${escapeHtml(item.text)}</span>
                          </label>
                          <button class="ghost-button" data-action="remove-shopping" data-item-id="${item.id}">Quitar</button>
                        </div>
                      `
                    )
                    .join("")}
                </div>
              `
              : renderEmptyState("Agrega ingredientes desde las recetas para construir tu lista.")
          }
        </section>
      </div>

      <div class="recipe-grid">
        ${filteredRecipes.map((recipe) => renderRecipeCard(recipe)).join("")}
      </div>
    </section>
  `;
}

function renderRecipeCard(recipe) {
  const completed = state.completedRecipes.has(recipe.id);
  return `
    <article class="recipe-card ${completed ? "is-complete" : ""}">
      <div class="recipe-heading">
        <div>
          <h4>${escapeHtml(recipe.title)}</h4>
          <p class="recipe-subtitle">${escapeHtml(recipe.subtitle)}</p>
        </div>
        <span class="challenge-type">${escapeHtml(recipe.mealType)}</span>
      </div>
      <div class="exercise-meta-grid">
        <div class="mini-stat"><span class="label">Cal</span><span class="value">${recipe.macros.calories}</span></div>
        <div class="mini-stat"><span class="label">Prot</span><span class="value">${recipe.macros.protein} g</span></div>
        <div class="mini-stat"><span class="label">Carbs</span><span class="value">${recipe.macros.carbs} g</span></div>
        <div class="mini-stat"><span class="label">Grasas</span><span class="value">${recipe.macros.fats} g</span></div>
      </div>
      <div class="tag-row">
        <span class="tag">${recipe.prepMinutes} min</span>
        <span class="tag">${recipe.servings} porcion</span>
        ${(recipe.tags || []).map((tag) => `<span class="tag">${escapeHtml(tag)}</span>`).join("")}
      </div>
      <div class="detail-grid">
        <div class="detail-block">
          <h3>Ingredientes</h3>
          <ul>${recipe.ingredients.map((ingredient) => `<li>${escapeHtml(ingredient)}</li>`).join("")}</ul>
        </div>
        <div class="detail-block">
          <h3>Pasos</h3>
          <ul>${recipe.steps.map((step) => `<li>${escapeHtml(step)}</li>`).join("")}</ul>
        </div>
      </div>
      <div class="recipe-actions">
        <button class="action-button" data-action="toggle-recipe" data-recipe-id="${recipe.id}">
          ${completed ? "Marcar pendiente" : "Marcar completada"}
        </button>
        <button class="secondary-button" data-action="add-ingredients" data-recipe-id="${recipe.id}">
          Agregar ingredientes
        </button>
      </div>
    </article>
  `;
}

function renderMacroRow(label, value, target, style) {
  const ratio = target ? Math.min(100, Math.round((value / target) * 100)) : 0;
  const modifier =
    style === "protein"
      ? "is-protein"
      : style === "carbs"
        ? "is-carbs"
        : style === "fats"
          ? "is-fats"
          : "";
  return `
    <div class="macro-row">
      <header>
        <span class="macro-label">${escapeHtml(label)}</span>
        <span class="macro-label">${value} / ${target}</span>
      </header>
      <div class="macro-bar">
        <div class="macro-fill ${modifier}" style="width:${ratio}%"></div>
      </div>
    </div>
  `;
}

function renderChallengesView() {
  return `
    <section class="section-stack">
      <div class="view-header">
        <div>
          <h2>Retos, eventos y promos</h2>
          <p>Version web de los challenges del proyecto, con registro local para seguir tu participacion.</p>
        </div>
        <div class="meta-strip">
          <span class="chip is-jade">${Object.keys(state.challengeRegistrations).length} registrados</span>
        </div>
      </div>
      <div class="challenge-grid">
        ${state.data.challenges.map((challenge) => renderChallengeCard(challenge)).join("")}
      </div>
    </section>
  `;
}

function renderChallengeCard(challenge) {
  const registered = Boolean(state.challengeRegistrations[challenge.id]);
  const typeClass =
    challenge.type === "Evento"
      ? "is-event"
      : challenge.type === "Promocion"
        ? "is-promotion"
        : "is-challenge";

  return `
    <article class="challenge-card">
      <div class="challenge-heading">
        <div>
          <h4>${escapeHtml(challenge.title)}</h4>
          <p class="challenge-subtitle">${escapeHtml(challenge.subtitle)}</p>
        </div>
        <span class="challenge-type ${typeClass}">${escapeHtml(challenge.type)}</span>
      </div>
      <p class="challenge-copy">${escapeHtml(challenge.details)}</p>
      <div class="tag-row">
        ${challenge.tags.map((tag) => `<span class="tag">${escapeHtml(tag)}</span>`).join("")}
      </div>
      ${
        challenge.event
          ? `
            <div class="challenge-highlight">
              <strong>${escapeHtml(challenge.event.location || "Evento abierto")}</strong>
              <p class="panel-meta">${formatDate(challenge.event.startDate)}${challenge.event.endDate ? ` a ${formatDate(challenge.event.endDate)}` : ""}</p>
              ${challenge.event.totalSpots ? `<p class="panel-meta">${challenge.event.totalSpots} lugares disponibles</p>` : ""}
            </div>
          `
          : ""
      }
      <div class="challenge-actions">
        <button class="${registered ? "ghost-button" : "action-button"}" data-action="toggle-challenge" data-challenge-id="${challenge.id}">
          ${registered ? "Cancelar registro" : challenge.ctaTitle || "Unirme"}
        </button>
      </div>
    </article>
  `;
}

function renderProgressView(stats) {
  return `
    <section class="section-stack">
      <div class="view-header">
        <div>
          <h2>Progreso y persistencia</h2>
          <p>Todo lo que registras aqui queda guardado localmente en tu navegador para seguir el progreso entre visitas.</p>
        </div>
      </div>

      <div class="summary-grid">
        <article class="summary-card">
          <span class="label">Racha activa</span>
          <span class="value">${stats.streakDays}</span>
          <div class="accent-line"></div>
        </article>
        <article class="summary-card">
          <span class="label">Minutos en 7 dias</span>
          <span class="value">${stats.weeklyMinutes}</span>
          <div class="accent-line"></div>
        </article>
        <article class="summary-card">
          <span class="label">Focus mas usado</span>
          <span class="value">${escapeHtml(stats.favoriteFocus)}</span>
          <div class="accent-line"></div>
        </article>
      </div>

      <div class="progress-grid">
        <section class="timeline-card">
          <div class="panel-title">
            <h3>Ultimas sesiones</h3>
            <span class="chip">${stats.totalSessions}</span>
          </div>
          ${
            state.history.length
              ? `
                <ol class="timeline-list">
                  ${state.history
                    .slice(0, 8)
                    .map(
                      (entry) => `
                        <li>
                          <strong>${escapeHtml(entry.title)}</strong><br />
                          <span class="timeline-copy">${formatDateTime(entry.date)} | ${escapeHtml(entry.focus)} | ${entry.plannedMinutes} min</span>
                        </li>
                      `
                    )
                    .join("")}
                </ol>
              `
              : renderEmptyState("Completa un entrenamiento para empezar a construir historial.")
          }
        </section>

        <section class="timeline-card">
          <div class="panel-title">
            <h3>Rendimiento guardado</h3>
            <span class="chip">${Object.keys(state.performanceBySlug).length} ejercicios</span>
          </div>
          ${
            Object.keys(state.performanceBySlug).length
              ? `
                <table class="performance-table">
                  <thead>
                    <tr>
                      <th>Ejercicio</th>
                      <th>Ultimo peso</th>
                      <th>Mejor peso</th>
                      <th>Reps</th>
                      <th>Sesiones</th>
                    </tr>
                  </thead>
                  <tbody>
                    ${Object.values(state.performanceBySlug)
                      .sort((left, right) => new Date(right.updatedAt) - new Date(left.updatedAt))
                      .slice(0, 10)
                      .map(
                        (snapshot) => `
                          <tr>
                            <td>${escapeHtml(snapshot.exerciseSlug)}</td>
                            <td>${formatWeight(Number(snapshot.lastWeightKg || 0))} kg</td>
                            <td>${formatWeight(Number(snapshot.bestWeightKg || 0))} kg</td>
                            <td>${snapshot.lastReps || 0}</td>
                            <td>${snapshot.sessionsCount || 0}</td>
                          </tr>
                        `
                      )
                      .join("")}
                  </tbody>
                </table>
              `
              : renderEmptyState("Aun no hay snapshots de rendimiento.")
          }
        </section>
      </div>
    </section>
  `;
}

function buildStats() {
  const now = new Date();
  const weeklyBoundary = now.getTime() - 7 * 24 * 3600 * 1000;
  const weeklySessions = state.history.filter((entry) => new Date(entry.date).getTime() >= weeklyBoundary);
  const weeklyMinutes = weeklySessions.reduce((sum, entry) => sum + Number(entry.plannedMinutes || 0), 0);
  const focusCounts = state.history.reduce((accumulator, entry) => {
    accumulator[entry.focus] = (accumulator[entry.focus] || 0) + 1;
    return accumulator;
  }, {});
  const favoriteFocus =
    Object.entries(focusCounts).sort((left, right) => right[1] - left[1])[0]?.[0] || "Sin datos";

  const macros = state.data.recipes
    .filter((recipe) => state.completedRecipes.has(recipe.id))
    .reduce(
      (totals, recipe) => ({
        calories: totals.calories + recipe.macros.calories,
        protein: totals.protein + recipe.macros.protein,
        carbs: totals.carbs + recipe.macros.carbs,
        fats: totals.fats + recipe.macros.fats,
      }),
      { calories: 0, protein: 0, carbs: 0, fats: 0 }
    );

  const registeredChallengeItems = state.data.challenges.filter((challenge) => state.challengeRegistrations[challenge.id]);

  return {
    totalSessions: state.history.length,
    weeklySessions: weeklySessions.length,
    weeklyMinutes,
    streakDays: computeStreakDays(state.history),
    favoriteFocus,
    completedRecipes: state.completedRecipes.size,
    macros,
    pendingShopping: state.shoppingList.filter((item) => !item.done).length,
    registeredChallenges: registeredChallengeItems.length,
    registeredChallengeItems,
  };
}

function computeStreakDays(history) {
  if (!history.length) {
    return 0;
  }

  const uniqueDays = Array.from(
    new Set(history.map((entry) => new Date(entry.date).toISOString().slice(0, 10)))
  ).sort((left, right) => (left < right ? 1 : -1));

  let streak = 0;
  let pointer = new Date();
  pointer.setHours(0, 0, 0, 0);

  const latestDate = new Date(uniqueDays[0]);
  latestDate.setHours(0, 0, 0, 0);
  const dayDifference = Math.round((pointer - latestDate) / 86400000);
  if (dayDifference > 1) {
    return 0;
  }

  if (dayDifference === 1) {
    pointer = latestDate;
  }

  for (const day of uniqueDays) {
    const date = new Date(day);
    date.setHours(0, 0, 0, 0);
    if (date.getTime() === pointer.getTime()) {
      streak += 1;
      pointer = new Date(pointer.getTime() - 86400000);
    } else if (date.getTime() < pointer.getTime()) {
      break;
    }
  }

  return streak;
}

function renderEmptyState(message) {
  return `<div class="empty-state">${escapeHtml(message)}</div>`;
}

function setToast(message) {
  state.ui.toast = message;
  if (toastTimer) {
    clearTimeout(toastTimer);
  }
  toastTimer = window.setTimeout(() => {
    state.ui.toast = "";
    render();
  }, 2600);
}

function buildChallengeSeed(now = new Date()) {
  const start = new Date(now);
  start.setDate(start.getDate() + 3);
  start.setHours(8, 0, 0, 0);

  const end = new Date(start);
  end.setHours(end.getHours() + 2);

  return [
    {
      id: "promo-premium-2x1",
      title: "2x1 en membresia premium",
      subtitle: "Activa tu plan anual y conserva acceso web + app.",
      details: "Promocion temporal para usuarios nuevos. Mantiene tu stack de entrenamiento y seguimiento en ambos entornos.",
      type: "Promocion",
      ctaTitle: "Aprovechar",
      isFeatured: true,
      tags: ["Oferta", "Premium", "Anual"],
    },
    {
      id: "meetup-comunidad-xibapp",
      title: "Meetup de la comunidad",
      subtitle: "Sesion abierta con movilidad, fuerza y networking.",
      details: "Evento presencial para la comunidad XibApp con registro limitado y enfoque en activacion funcional.",
      type: "Evento",
      ctaTitle: "Reservar lugar",
      isFeatured: false,
      tags: ["Comunidad", "Outdoor", "Networking"],
      event: {
        startDate: start.toISOString(),
        endDate: end.toISOString(),
        location: "CDMX",
        totalSpots: 120,
      },
    },
    {
      id: "reto-core-30-dias",
      title: "Reto 30 dias core",
      subtitle: "Disciplina diaria para mejorar estabilidad y control.",
      details: "Completa una sesion de core por dia y registra tu avance dentro del modulo de progreso.",
      type: "Reto",
      ctaTitle: "Unirme",
      isFeatured: true,
      tags: ["Core", "Disciplina", "30 dias"],
    },
  ];
}

function normalize(value) {
  return String(value || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim()
    .toLowerCase();
}

function uid(prefix) {
  return `${prefix}-${Math.random().toString(36).slice(2, 10)}`;
}

function escapeHtml(value) {
  return String(value || "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

function escapeAttribute(value) {
  return escapeHtml(String(value ?? ""));
}

function formatDate(value) {
  return new Intl.DateTimeFormat("es-MX", {
    day: "numeric",
    month: "short",
    year: "numeric",
  }).format(new Date(value));
}

function formatDateTime(value) {
  return new Intl.DateTimeFormat("es-MX", {
    day: "numeric",
    month: "short",
    hour: "2-digit",
    minute: "2-digit",
  }).format(new Date(value));
}
