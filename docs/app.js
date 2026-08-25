const STORAGE_KEYS = {
  preferences: "xibapp.web.preferences.v1",
  history: "xibapp.web.history.v1",
  performance: "xibapp.web.performance.v1",
  equipmentProfiles: "xibapp.web.equipmentProfiles.v1",
  completedRecipes: "xibapp.web.completedRecipes.v1",
  shoppingList: "xibapp.web.shoppingList.v1",
  challengeRegistrations: "xibapp.web.challengeRegistrations.v1",
  motivationPhrasesCache: "xibapp.web.motivationPhrasesCache.v1",
  viewerId: "xibapp.web.viewerId.v1",
};

const VIEW_OPTIONS = [
  { id: "dashboard", label: "Inicio", shortLabel: "Inicio", kicker: "01" },
  { id: "training", label: "Entrenamiento", shortLabel: "Plan", kicker: "02" },
  { id: "explorer", label: "Ejercicios", shortLabel: "Explora", kicker: "03" },
  { id: "nutrition", label: "Nutricion", shortLabel: "Nutre", kicker: "04" },
  { id: "challenges", label: "Retos", shortLabel: "Retos", kicker: "05" },
  { id: "progress", label: "Progreso", shortLabel: "Stats", kicker: "06" },
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

const EXPERIENCE_LEVELS = ["Principiante", "Intermedio", "Avanzado"];

const LOAD_STRATEGIES = ["Conservadora", "Equilibrada", "Agresiva"];

const WEIGHT_UNIT_OPTIONS = [
  { id: "kg", label: "kg" },
  { id: "lb", label: "lb" },
];

const LOAD_MODE_OPTIONS = [
  { id: "stack", label: "Torre guiada" },
  { id: "cable", label: "Polea" },
  { id: "plate_loaded", label: "Discos / palanca" },
];

const MACHINE_BRAND_OPTIONS = [
  {
    id: "generic",
    label: "Generica",
    aliases: ["generica", "generico", "maquina generica", "polea generica"],
    machineMultiplier: 1,
    cableMultiplier: 1,
    note: "Base neutra",
  },
  {
    id: "technogym",
    label: "Technogym",
    aliases: ["techno gym", "selection", "technogym selection"],
    machineMultiplier: 0.96,
    cableMultiplier: 0.93,
    note: "Perfil suave en polea",
  },
  {
    id: "lifefitness",
    label: "Life Fitness",
    aliases: ["life fitness", "insignia", "signature"],
    machineMultiplier: 0.98,
    cableMultiplier: 0.96,
    note: "Recorrido estable",
  },
  {
    id: "hammerstrength",
    label: "Hammer Strength",
    aliases: ["hammer strength", "hammer", "iso lateral", "iso-lateral"],
    machineMultiplier: 1.04,
    cableMultiplier: 1,
    note: "Tendencia mas pesada",
  },
  {
    id: "matrix",
    label: "Matrix",
    aliases: ["matrix", "matrix ultra", "ultra"],
    machineMultiplier: 0.97,
    cableMultiplier: 0.95,
    note: "Sensacion ligeramente ligera",
  },
  {
    id: "precor",
    label: "Precor",
    aliases: ["precor", "vitality"],
    machineMultiplier: 0.95,
    cableMultiplier: 0.94,
    note: "Resistencia progresiva suave",
  },
  {
    id: "panatta",
    label: "Panatta",
    aliases: ["panatta", "monolith"],
    machineMultiplier: 1.02,
    cableMultiplier: 0.99,
    note: "Perfil cercano a carga libre",
  },
];

const LOAD_PATTERN_PROFILES = [
  {
    id: "knee-dominant",
    ratio: 0.82,
    minKg: 18,
    keywords: ["sentadilla", "squat", "hack", "prensa", "leg press", "front squat"],
  },
  {
    id: "hinge",
    ratio: 0.74,
    minKg: 18,
    keywords: ["peso muerto", "deadlift", "hip thrust", "rdl", "buenos dias", "good morning"],
  },
  {
    id: "single-leg",
    ratio: 0.28,
    minKg: 8,
    keywords: ["lunge", "zancada", "bulgar", "split squat", "step up", "desplante"],
  },
  {
    id: "horizontal-push",
    ratio: 0.38,
    minKg: 8,
    keywords: ["press banca", "bench press", "chest press", "press horizontal", "push up"],
  },
  {
    id: "incline-push",
    ratio: 0.34,
    minKg: 8,
    keywords: ["inclinado", "incline", "press superior"],
  },
  {
    id: "vertical-push",
    ratio: 0.27,
    minKg: 6,
    keywords: ["press militar", "overhead press", "shoulder press", "arnold"],
  },
  {
    id: "horizontal-pull",
    ratio: 0.42,
    minKg: 8,
    keywords: ["remo", "row", "seal row", "pullover"],
  },
  {
    id: "vertical-pull",
    ratio: 0.48,
    minKg: 10,
    keywords: ["jalon", "pulldown", "dominada", "pull up", "chin up"],
  },
  {
    id: "leg-isolation",
    ratio: 0.36,
    minKg: 8,
    keywords: ["extension", "curl femoral", "leg curl", "leg extension", "aductor", "abductor"],
  },
  {
    id: "chest-isolation",
    ratio: 0.22,
    minKg: 4,
    keywords: ["apertura", "fly", "pec deck", "crossover", "cruce de poleas"],
  },
  {
    id: "shoulder-isolation",
    ratio: 0.12,
    minKg: 3,
    keywords: ["elevacion lateral", "lateral raise", "rear delt", "pajaro", "face pull"],
  },
  {
    id: "arm-isolation",
    ratio: 0.16,
    minKg: 4,
    keywords: ["curl", "tricep", "triceps", "extension de triceps", "predicador"],
  },
  {
    id: "calf",
    ratio: 0.42,
    minKg: 10,
    keywords: ["pantorrilla", "calf"],
  },
  {
    id: "core",
    ratio: null,
    minKg: 0,
    keywords: ["abdomen", "abdominal", "crunch", "plancha", "core", "hollow", "wheel"],
  },
  {
    id: "conditioning",
    ratio: null,
    minKg: 0,
    keywords: ["bike", "bicicleta", "remo ergometro", "ergometer", "cuerda", "jump rope", "sprint", "cardio"],
  },
  {
    id: "generic",
    ratio: 0.2,
    minKg: 4,
    keywords: [],
  },
];

const MEAL_ORDER = [
  { key: "desayuno", label: "Desayuno" },
  { key: "comida", label: "Comida" },
  { key: "colacion", label: "Colacion" },
  { key: "cena", label: "Cena" },
];

const SUPABASE_PUBLIC_CONFIG = {
  url: "https://gayjoopqsluogmphzmbp.supabase.co",
  anonKey:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdheWpvb3Bxc2x1b2dtcGh6bWJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMwMzkxNzMsImV4cCI6MjA4ODYxNTE3M30.GLYvRy7NESdgNSxtttFAYwnDfuYuM7pLUlIEpRCy88U",
};

const MOTIVATION_FALLBACK_PHRASES = [
  "La disciplina aplasta al miedo.",
  "No salgas igual que entras.",
  "Hoy se entrena con hambre.",
  "Haz que hoy cuente.",
];

const DEFAULT_PREFERENCES = {
  goal: "Ganar musculo",
  split: "Empuje/Jalon/Piernas",
  sessionDurationMinutes: 60,
  availableEquipment: ["bodyweight", "dumbbells", "bench"],
  bodyWeightKg: 70,
  weightUnit: "kg",
  experienceLevel: "Intermedio",
  loadStrategy: "Equilibrada",
};

const GOAL_MACRO_TARGETS = {
  "Ganar musculo": { calories: 2400, protein: 170, carbs: 250, fats: 75 },
  "Reducir peso corporal": { calories: 1900, protein: 160, carbs: 150, fats: 60 },
  "Definir musculo": { calories: 2100, protein: 170, carbs: 185, fats: 65 },
  "Ganar fuerza": { calories: 2500, protein: 175, carbs: 260, fats: 80 },
  "Mejorar condicion fisica": { calories: 2200, protein: 150, carbs: 220, fats: 70 },
};

const EXPERIENCE_LOAD_FACTORS = {
  Principiante: 0.84,
  Intermedio: 1,
  Avanzado: 1.14,
};

const LOAD_STRATEGY_FACTORS = {
  Conservadora: 0.93,
  Equilibrada: 1,
  Agresiva: 1.08,
};

const GOAL_LOAD_FACTORS = {
  "Ganar fuerza": 1.06,
  "Ganar musculo": 1,
  "Definir musculo": 0.95,
  "Reducir peso corporal": 0.9,
  "Mejorar condicion fisica": 0.84,
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
    motivationPhrases: loadStoredMotivationPhrases(),
  },
  preferences: loadStoredPreferences(),
  history: loadStoredHistory(),
  performanceBySlug: loadStoredPerformance(),
  equipmentProfiles: loadStoredEquipmentProfiles(),
  completedRecipes: new Set(loadStoredArray(STORAGE_KEYS.completedRecipes)),
  shoppingList: loadStoredArray(STORAGE_KEYS.shoppingList),
  challengeRegistrations: loadStoredObject(STORAGE_KEYS.challengeRegistrations),
  plan: null,
  planInputs: {},
  restTimer: buildIdleRestTimer(),
  ui: {
    exerciseQuery: "",
    recipeFilter: "all",
    selectedFamilyKey: null,
    trainingScreen: "overview",
    selectedTrainingExerciseId: null,
    toast: "",
  },
};

const localViewerId = loadViewerId();
const appRoot = document.querySelector("#app");
let toastTimer = null;
let restTimerInterval = null;
let ignoreNextHashChange = false;
let queuedViewTransition = Promise.resolve();

window.addEventListener("hashchange", handleHashChange);
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
    const [exerciseResponse, recipeResponse, motivationPhrases] = await Promise.all([
      fetch("./data/exercise_detail_v1_seed.json"),
      fetch("./data/nutrition_recipes_mx.json"),
      loadDailyMotivationPhrases(),
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
    state.data.motivationPhrases = motivationPhrases;
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
    syncTrainingScreenState();
    return;
  }

  state.plan = makePlan(
    state.preferences,
    state.history,
    state.data.exercises,
    state.performanceBySlug
  );
  syncTrainingScreenState();
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
        intensity,
        preferences
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
      rationale(preferences, focus, adjustedDuration, focusFatigue) +
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

function makeProgression(item, snapshot, repsText, goal, intensity, preferences, equipmentProfile = exerciseEquipmentProfile(item)) {
  const baseline = estimateBaselineLoad(item, preferences, repsText, goal, intensity, equipmentProfile);
  const range = parseRepRange(repsText);
  const weightUnit = resolvedExerciseWeightUnit(item, equipmentProfile);
  const roundingStep = suggestedWeightStep(item, weightUnit);
  const equipmentClass = inferEquipmentClass(item);
  const progressData = transferableProgressData(item, snapshot, equipmentProfile, baseline.suggestedWeightKg);
  const snapshotSets = snapshotSetEntries(snapshot);
  const setFeedback = evaluateRepPerformanceFromSets(snapshotSets, range);
  const sessionSummary = snapshotSetSummary(item, snapshot, equipmentProfile);

  if (!snapshot) {
    return {
      suggestedWeightKg: baseline.suggestedWeightKg,
      note:
        baseline.note ||
        "Sin historial. Registra tus series para activar progresion automatica.",
      sessionSummary: "",
    };
  }

  if (!range) {
    const snapshotProfile = equipmentProfileFromSnapshot(snapshot, item);
    const timeBasedWeight = roundToNearest(
      Math.max(
        0,
        Number.isFinite(Number(snapshot.lastWeightKg))
          ? convertStoredWeightKgToDisplayed(item, Number(snapshot.lastWeightKg), snapshotProfile, equipmentProfile)
          : Number(baseline.suggestedWeightKg || 0)
      ),
      roundingStep
    );
    return {
      suggestedWeightKg: timeBasedWeight || null,
      note: timeBasedWeight
        ? `Base ${formatWeightWithUnit(timeBasedWeight, weightUnit)}. Controla el ritmo.`
        : "Manten ritmo y tecnica; esta variante se guia por tiempo.",
      sessionSummary,
    };
  }

  if (equipmentClass === "bodyweight" && !isWeightedVariation(item)) {
    return {
      suggestedWeightKg: null,
      note: setFeedback?.status === "increase"
        ? "La variante actual ya te queda corta. Sube dificultad o agrega lastre ligero."
        : setFeedback?.status === "evaluate"
          ? "Mantengo la misma dificultad para confirmar la siguiente sesion."
          : `Busca ${range.min}-${range.max} reps con control corporal.`,
      sessionSummary,
    };
  }

  const snapshotProfile = equipmentProfileFromSnapshot(snapshot, item);
  const representativeWeightKg = representativeStoredWeightKgFromSets(snapshotSets, Number(snapshot.lastWeightKg || 0));
  const convertedSnapshotWeight = Number.isFinite(representativeWeightKg) && representativeWeightKg > 0
    ? convertStoredWeightKgToDisplayed(item, representativeWeightKg, snapshotProfile, equipmentProfile)
    : Number(baseline.suggestedWeightKg || 0);
  const lastWeight = Number(
    convertedSnapshotWeight ||
      progressData.transferSuggestedWeightKg ||
      baseline.suggestedWeightKg ||
      0
  );
  const incrementStep = progressionIncrementStep(item, intensity, weightUnit);
  const strategyFactor = LOAD_STRATEGY_FACTORS[preferences.loadStrategy] || 1;

  let delta = 0;
  let coachingNote = "";

  if (setFeedback) {
    if (setFeedback.status === "increase") {
      const multiplier = setFeedback.best >= range.max + 5 ? 1.35 : 1;
      if (goal === "Ganar fuerza" || goal === "Ganar musculo") delta = incrementStep * multiplier * strategyFactor;
      else if (goal === "Definir musculo") delta = incrementStep * 0.65 * multiplier * strategyFactor;
      else delta = incrementStep * 0.35 * multiplier * strategyFactor;
      coachingNote = "La ultima sesion dejo margen real. Ajusto la sugerencia ligeramente hacia arriba.";
    } else if (setFeedback.status === "decrease") {
      delta = goal === "Ganar fuerza" || goal === "Ganar musculo" ? -incrementStep * 0.7 : -incrementStep * 0.45;
      coachingNote = "La ultima sesion se vio pesada. Ajusto la sugerencia un poco a la baja.";
    } else if (setFeedback.status === "evaluate") {
      delta = 0;
      coachingNote = "La ultima sesion aun no queda del todo consolidada. Mantengo la carga y sigo observando.";
    } else {
      coachingNote = "La carga sigue bien calibrada con tu ultimo patron de series.";
    }
  } else {
    const lastReps = Number(snapshot.lastReps || 0);
    if (lastReps >= range.max) {
      if (goal === "Ganar fuerza" || goal === "Ganar musculo") delta = incrementStep * strategyFactor;
      else if (goal === "Definir musculo") delta = incrementStep * 0.5 * strategyFactor;
      else delta = incrementStep * 0.25 * strategyFactor;
    } else if (lastReps < range.min) {
      if (goal === "Ganar fuerza" || goal === "Ganar musculo") delta = -incrementStep * 0.5;
      else delta = -incrementStep * 0.25;
    }
  }

  let rawSuggested = Math.max(0, lastWeight + delta);
  if (progressData.transferSuggestedWeightKg != null) {
    const blendedTransferBase =
      snapshotProfile.brandId !== equipmentProfile.brandId || snapshotProfile.loadMode !== equipmentProfile.loadMode
        ? progressData.transferSuggestedWeightKg
        : lastWeight > 0
          ? lastWeight * 0.68 + progressData.transferSuggestedWeightKg * 0.32
          : progressData.transferSuggestedWeightKg;

    rawSuggested =
      rawSuggested > 0
        ? rawSuggested * 0.62 + blendedTransferBase * 0.38
        : blendedTransferBase;
  }

  if (baseline.suggestedWeightKg != null && snapshot.sessionsCount <= 2 && lastWeight > 0) {
    rawSuggested = rawSuggested * 0.72 + baseline.suggestedWeightKg * 0.28;
  }

  const suggestedWeightKg = roundToNearest(rawSuggested, roundingStep);
  const loadNote =
    delta > 0
      ? `Prueba ${formatWeightWithUnit(suggestedWeightKg, weightUnit)}.`
      : delta < 0
        ? `Bajo a ${formatWeightWithUnit(suggestedWeightKg, weightUnit)} por ahora.`
        : setFeedback?.status === "evaluate"
          ? `Mantengo ${formatWeightWithUnit(suggestedWeightKg, weightUnit)} para volver a leer la siguiente sesion.`
          : `Mantengo ${formatWeightWithUnit(suggestedWeightKg, weightUnit)}.`;

  return {
    suggestedWeightKg,
    note: [coachingNote, loadNote, baseline.machineAdjustmentLabel, progressData.label].filter(Boolean).join(" • "),
    sessionSummary,
  };
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

function normalizeWeightUnit(unit) {
  return unit === "lb" ? "lb" : "kg";
}

function convertWeightValue(value, fromUnit, toUnit) {
  if (!Number.isFinite(Number(value))) {
    return Number(value);
  }

  const normalizedFrom = normalizeWeightUnit(fromUnit);
  const normalizedTo = normalizeWeightUnit(toUnit);
  if (normalizedFrom === normalizedTo) {
    return Number(value);
  }

  if (normalizedFrom === "kg" && normalizedTo === "lb") {
    return Number(value) * 2.2046226218;
  }

  return Number(value) / 2.2046226218;
}

function displayedWeightFromStoredKg(weightKg, unit) {
  return convertWeightValue(weightKg, "kg", normalizeWeightUnit(unit));
}

function storedWeightKgFromDisplayed(displayedWeight, unit) {
  return convertWeightValue(displayedWeight, normalizeWeightUnit(unit), "kg");
}

function formatWeight(value) {
  return Number.isInteger(value) ? String(value) : value.toFixed(1);
}

function formatWeightWithUnit(value, unit) {
  return `${formatWeight(value)} ${normalizeWeightUnit(unit)}`;
}

function machineBrandProfile(id) {
  return MACHINE_BRAND_OPTIONS.find((entry) => entry.id === id) || MACHINE_BRAND_OPTIONS[0];
}

function machineBrandFromLabel(label) {
  const normalizedLabel = normalize(label);
  if (!normalizedLabel) {
    return machineBrandProfile("generic");
  }

  return (
    MACHINE_BRAND_OPTIONS.find((entry) =>
      [entry.label, ...(entry.aliases || [])].some((value) => {
        const token = normalize(value);
        return normalizedLabel === token || normalizedLabel.includes(token) || token.includes(normalizedLabel);
      })
    ) || machineBrandProfile("generic")
  );
}

function isWeightedVariation(item) {
  const blob = normalize([item.name, item.displayName, item.slug].join(" "));
  return blob.includes("lastrado") || blob.includes("weighted");
}

function inferEquipmentClass(item) {
  const tokens = (item.equipment || []).map(normalize);
  if (!tokens.length) {
    return "bodyweight";
  }
  if (tokens.some((token) => token.includes("bike") || token.includes("bicicleta") || token.includes("rower") || token.includes("ergometro") || token.includes("cuerda"))) {
    return "conditioning";
  }
  if (tokens.some((token) => token.includes("maquina") || token.includes("machine"))) {
    return "machine";
  }
  if (tokens.some((token) => token.includes("polea") || token.includes("cable"))) {
    return "cable";
  }
  if (tokens.some((token) => token.includes("barra") || token.includes("mancuer") || token.includes("kettlebell") || token.includes("disco"))) {
    return "freeweight";
  }
  if (tokens.some((token) => token.includes("peso corporal") || token.includes("paralela") || token.includes("dominadas"))) {
    return "bodyweight";
  }
  return "mixed";
}

function inferLoadPattern(item) {
  const blob = normalize([item.name, item.displayName, item.slug, item.muscles.join(" ")].join(" "));
  return (
    LOAD_PATTERN_PROFILES.find(
      (profile) => profile.id !== "generic" && profile.keywords.some((keyword) => blob.includes(keyword))
    ) || LOAD_PATTERN_PROFILES.find((profile) => profile.id === "generic")
  );
}

function repRangeLoadFactor(range) {
  if (!range) return 1;
  if (range.max <= 6) return 1.08;
  if (range.max <= 8) return 1.03;
  if (range.max <= 12) return 0.97;
  if (range.max <= 15) return 0.9;
  return 0.8;
}

function suggestedWeightStep(item, unit = "kg") {
  const resolvedUnit = normalizeWeightUnit(unit);
  const equipmentClass = inferEquipmentClass(item);
  if (resolvedUnit === "lb") {
    if (equipmentClass === "freeweight") {
      const blob = normalize([item.name, item.displayName, item.slug, item.equipment.join(" ")].join(" "));
      return blob.includes("barra") || blob.includes("barbell") || blob.includes("disco") ? 5 : 2.5;
    }
    if (equipmentClass === "machine" || equipmentClass === "cable") return 5;
    return 1;
  }

  if (equipmentClass === "freeweight") {
    const blob = normalize([item.name, item.displayName, item.slug, item.equipment.join(" ")].join(" "));
    return blob.includes("barra") || blob.includes("barbell") || blob.includes("disco") ? 2.5 : 1;
  }
  if (equipmentClass === "machine" || equipmentClass === "cable") return 1.25;
  return 0.5;
}

function progressionIncrementStep(item, intensity, unit = "kg") {
  const resolvedUnit = normalizeWeightUnit(unit);
  const equipmentClass = inferEquipmentClass(item);
  if (resolvedUnit === "lb") {
    if (equipmentClass === "freeweight") {
      return intensity === "heavy" ? 5 : 2.5;
    }
    if (equipmentClass === "machine" || equipmentClass === "cable") {
      return intensity === "heavy" ? 5 : 2.5;
    }
    return intensity === "heavy" ? 2.5 : 1;
  }

  if (equipmentClass === "freeweight") {
    return intensity === "heavy" ? 2.5 : 1.25;
  }
  if (equipmentClass === "machine" || equipmentClass === "cable") {
    return intensity === "heavy" ? 2.5 : 1.25;
  }
  return intensity === "heavy" ? 1.25 : 0.5;
}

function signedPercent(value) {
  if (Math.abs(value) < 0.5) return "";
  return `${value > 0 ? "+" : ""}${Math.round(value)}%`;
}

function isMachineAdjustable(item) {
  const equipmentClass = inferEquipmentClass(item);
  return equipmentClass === "machine" || equipmentClass === "cable";
}

function supportsWeightTypeSelection(item) {
  return isMachineAdjustable(item);
}

function defaultLoadModeForItem(item) {
  return inferEquipmentClass(item) === "cable" ? "cable" : "stack";
}

function normalizeLoadModeForItem(item, loadMode) {
  if (!supportsWeightTypeSelection(item)) {
    return defaultLoadModeForItem(item);
  }

  if (LOAD_MODE_OPTIONS.some((option) => option.id === loadMode)) {
    return loadMode;
  }

  if (loadMode === "per_arm") {
    return inferEquipmentClass(item) === "cable" ? "cable" : "plate_loaded";
  }

  if (loadMode === "displayed_total") {
    return defaultLoadModeForItem(item);
  }

  return defaultLoadModeForItem(item);
}

function exerciseProfileKey(item) {
  return normalize(item.slug || item.id || item.displayName || item.name);
}

function defaultEquipmentProfileForItem(item) {
  return {
    brandId: "generic",
    label: "Generica",
    loadMode: defaultLoadModeForItem(item),
    unitOverride: null,
  };
}

function sanitizeEquipmentProfile(item, profile = {}) {
  const defaults = defaultEquipmentProfileForItem(item);
  const rawLabel = String(profile.label || defaults.label).trim();
  const matchedBrand = machineBrandFromLabel(rawLabel || profile.brandId || defaults.brandId);

  return {
    brandId: matchedBrand.id,
    label: rawLabel || matchedBrand.label,
    loadMode: normalizeLoadModeForItem(item, profile.loadMode ?? defaults.loadMode),
    unitOverride: WEIGHT_UNIT_OPTIONS.some((option) => option.id === profile.unitOverride)
      ? profile.unitOverride
      : null,
  };
}

function materializeEquipmentProfile(item, profile = {}, globalUnit = state.preferences.weightUnit) {
  const sanitized = sanitizeEquipmentProfile(item, profile);
  return {
    ...sanitized,
    weightUnit: normalizeWeightUnit(sanitized.unitOverride || globalUnit),
  };
}

function exerciseEquipmentProfile(item) {
  const stored = state.equipmentProfiles[exerciseProfileKey(item)] || {};
  return materializeEquipmentProfile(item, stored, state.preferences.weightUnit);
}

function resolvedExerciseWeightUnit(item, equipmentProfile = exerciseEquipmentProfile(item)) {
  return normalizeWeightUnit(equipmentProfile.weightUnit || equipmentProfile.unitOverride || state.preferences.weightUnit);
}

function updateEquipmentProfileForExercise(exerciseId, patch) {
  const entry = findPlanExerciseById(exerciseId);
  if (!entry) {
    return;
  }

  const item = entry.exercise;
  const key = exerciseProfileKey(item);
  const currentProfile = exerciseEquipmentProfile(item);
  const nextProfile = materializeEquipmentProfile(item, {
    ...currentProfile,
    ...patch,
  }, state.preferences.weightUnit);

  const inputState = state.planInputs[exerciseId];
  if (Array.isArray(inputState?.sets)) {
    inputState.sets = inputState.sets.map((set) => {
      const numericWeight = Number(set?.weight);
      if (!Number.isFinite(numericWeight) || numericWeight <= 0) {
        return { ...set };
      }

      const converted = convertDisplayedLoad(item, numericWeight, currentProfile, nextProfile);
      return {
        ...set,
        weight: formatEditableWeight(converted),
      };
    });
  } else {
    const weightInput = inputState?.weight;
    if (weightInput !== undefined && weightInput !== "") {
      const numericWeight = Number(weightInput);
      if (Number.isFinite(numericWeight)) {
        const converted = convertDisplayedLoad(item, numericWeight, currentProfile, nextProfile);
        state.planInputs[exerciseId].weight = formatEditableWeight(converted);
      }
    }
  }

  state.equipmentProfiles[key] = {
    brandId: nextProfile.brandId,
    label: nextProfile.label,
    loadMode: nextProfile.loadMode,
    unitOverride: nextProfile.unitOverride,
  };
  persistState();
  render();
}

function equipmentProfileFromSnapshot(snapshot, item) {
  if (!snapshot || !isMachineAdjustable(item)) {
    return exerciseEquipmentProfile(item);
  }

  return materializeEquipmentProfile(item, {
    brandId: snapshot.machineBrandId,
    label: snapshot.machineLabel,
    loadMode: snapshot.loadMode,
    unitOverride: snapshot.weightUnit,
  });
}

function machineBrandFactor(item, equipmentProfile) {
  const brand = machineBrandProfile(equipmentProfile.brandId);
  const equipmentClass = inferEquipmentClass(item);
  if (equipmentClass === "machine") {
    return brand.machineMultiplier;
  }
  if (equipmentClass === "cable") {
    return brand.cableMultiplier;
  }
  return 1;
}

function resistanceProfileFactor(item, equipmentProfile) {
  const equipmentClass = inferEquipmentClass(item);
  const loadMode = normalizeLoadModeForItem(item, equipmentProfile.loadMode);

  if (loadMode === "plate_loaded") {
    return equipmentClass === "cable" ? 1.08 : 1.1;
  }

  if (loadMode === "cable") {
    return equipmentClass === "machine" ? 1.08 : 1.12;
  }

  return equipmentClass === "cable" ? 1.04 : 1;
}

function referenceLoadFromStoredWeightKg(item, storedWeightKg, equipmentProfile) {
  if (!Number.isFinite(storedWeightKg) || storedWeightKg <= 0) {
    return 0;
  }

  return (storedWeightKg * resistanceProfileFactor(item, equipmentProfile)) / Math.max(machineBrandFactor(item, equipmentProfile), 0.01);
}

function referenceLoadFromDisplayed(item, displayedWeight, equipmentProfile) {
  if (!Number.isFinite(displayedWeight) || displayedWeight <= 0) {
    return 0;
  }

  const storedWeightKg = storedWeightKgFromDisplayed(displayedWeight, equipmentProfile.weightUnit);
  return referenceLoadFromStoredWeightKg(item, storedWeightKg, equipmentProfile);
}

function displayedLoadFromReference(item, referenceLoad, equipmentProfile) {
  if (!Number.isFinite(referenceLoad) || referenceLoad <= 0) {
    return 0;
  }

  const storedWeightKg =
    (referenceLoad * machineBrandFactor(item, equipmentProfile)) / Math.max(resistanceProfileFactor(item, equipmentProfile), 1);
  return displayedWeightFromStoredKg(storedWeightKg, equipmentProfile.weightUnit);
}

function convertStoredWeightKgToDisplayed(item, storedWeightKg, fromProfile, toProfile) {
  if (!Number.isFinite(storedWeightKg) || storedWeightKg <= 0) {
    return storedWeightKg;
  }

  const referenceLoad = referenceLoadFromStoredWeightKg(item, storedWeightKg, fromProfile);
  const converted = displayedLoadFromReference(item, referenceLoad, toProfile);
  return roundToNearest(converted, suggestedWeightStep(item, toProfile.weightUnit));
}

function convertDisplayedLoad(item, displayedWeight, fromProfile, toProfile) {
  if (!Number.isFinite(displayedWeight) || displayedWeight <= 0) {
    return displayedWeight;
  }

  const referenceLoad = referenceLoadFromDisplayed(item, displayedWeight, fromProfile);
  const converted = displayedLoadFromReference(item, referenceLoad, toProfile);
  return roundToNearest(converted, suggestedWeightStep(item, toProfile.weightUnit));
}

function transferableProgressData(item, snapshot, currentProfile, baselineSuggestedWeightKg) {
  if (!snapshot || Number(snapshot.sessionsCount || 0) < 2) {
    return {
      factor: 1,
      transferSuggestedWeightKg: baselineSuggestedWeightKg ?? null,
      label: "",
    };
  }

  const snapshotProfile = equipmentProfileFromSnapshot(snapshot, item);
  const snapshotSets = snapshotSetEntries(snapshot);
  const snapshotReferenceLoads = snapshotSets
    .map((set) => Number(set.referenceLoadKg || 0))
    .filter((value) => Number.isFinite(value) && value > 0);
  const fallbackLastReference =
    snapshotReferenceLoads[0] ||
    referenceLoadFromStoredWeightKg(
      item,
      representativeStoredWeightKgFromSets(snapshotSets, Number(snapshot.lastWeightKg || 0)),
      snapshotProfile
    );
  const fallbackBestReference = Math.max(
    ...snapshotReferenceLoads,
    referenceLoadFromStoredWeightKg(
      item,
      Math.max(Number(snapshot.bestWeightKg || 0), representativeStoredWeightKgFromSets(snapshotSets, Number(snapshot.lastWeightKg || 0))),
      snapshotProfile
    )
  );
  const firstReference = Number(snapshot.firstReferenceWeightKg || 0);
  const peakReference = Math.max(
    Number(snapshot.bestReferenceWeightKg || 0),
    Number(snapshot.lastReferenceWeightKg || 0),
    fallbackBestReference,
    fallbackLastReference
  );

  if (!(firstReference > 0) || !(peakReference > 0)) {
    return {
      factor: 1,
      transferSuggestedWeightKg: baselineSuggestedWeightKg ?? null,
      label: "",
    };
  }

  const factor = Math.min(3.5, Math.max(0.7, peakReference / firstReference));
  if (!Number.isFinite(factor) || factor <= 0) {
    return {
      factor: 1,
      transferSuggestedWeightKg: baselineSuggestedWeightKg ?? null,
      label: "",
    };
  }

  const transferSuggestedWeightKg =
    baselineSuggestedWeightKg != null
      ? roundToNearest(
          Math.max(0, baselineSuggestedWeightKg * factor),
          suggestedWeightStep(item, currentProfile.weightUnit)
        )
      : null;
  const profileChanged =
    snapshotProfile.brandId !== currentProfile.brandId || snapshotProfile.loadMode !== currentProfile.loadMode;
  const label =
    profileChanged && factor > 1.02
      ? "ajustada con tu historial en otra maquina"
      : "";

  return {
    factor,
    transferSuggestedWeightKg,
    label,
  };
}

function formatEditableWeight(value) {
  return Number.isFinite(value) ? formatWeight(value) : "";
}

function weightTypeLabel(loadMode) {
  return LOAD_MODE_OPTIONS.find((option) => option.id === loadMode)?.label || LOAD_MODE_OPTIONS[0].label;
}

function unitOverrideLabel(unitOverride) {
  if (!unitOverride) {
    return `Global (${normalizeWeightUnit(state.preferences.weightUnit)})`;
  }
  return normalizeWeightUnit(unitOverride);
}

function snapshotSetEntries(snapshot) {
  const rawSets = Array.isArray(snapshot?.lastSets) ? snapshot.lastSets : [];
  const normalizedSets = rawSets
    .map((set, index) => ({
      index,
      reps: Number(set?.reps || 0),
      weightKg: Number(set?.weightKg || 0),
      referenceLoadKg: Number(set?.referenceLoadKg || 0),
    }))
    .filter((set) => set.reps > 0 || set.weightKg > 0 || set.referenceLoadKg > 0);

  if (normalizedSets.length) {
    return normalizedSets;
  }

  const legacyReps = Number(snapshot?.lastReps || 0);
  const legacyWeightKg = Number(snapshot?.lastWeightKg || 0);
  const legacyReferenceLoadKg = Number(snapshot?.lastReferenceWeightKg || 0);
  if (legacyReps > 0 || legacyWeightKg > 0 || legacyReferenceLoadKg > 0) {
    return [
      {
        index: 0,
        reps: legacyReps,
        weightKg: legacyWeightKg,
        referenceLoadKg: legacyReferenceLoadKg,
      },
    ];
  }

  return [];
}

function planSetRepSignature(sets) {
  const reps = sets
    .map((set) => Number(set?.reps || 0))
    .filter((value) => Number.isFinite(value) && value > 0);
  return reps.length ? reps.join(" / ") : "";
}

function representativeStoredWeightKgFromSets(sets, fallbackWeightKg = 0) {
  const weights = sets
    .map((set) => Number(set?.weightKg || 0))
    .filter((value) => Number.isFinite(value) && value > 0);

  if (weights.length) {
    return weights[0];
  }

  return Number(fallbackWeightKg || 0);
}

function evaluateRepPerformanceFromSets(sets, range) {
  if (!range) {
    return null;
  }

  const reps = sets
    .map((set) => Number(set?.reps || 0))
    .filter((value) => Number.isFinite(value) && value > 0);

  if (!reps.length) {
    return null;
  }

  const first = reps[0];
  const last = reps[reps.length - 1];
  const best = Math.max(...reps);
  const average = reps.reduce((sum, value) => sum + value, 0) / reps.length;
  const belowMinCount = reps.filter((value) => value < range.min).length;
  const aboveMaxCount = reps.filter((value) => value > range.max).length;
  const drop = first - last;
  const signature = reps.join(" / ");
  const steepDrop = reps.length >= 3 && first >= range.min && last < range.min && drop >= 2;

  if (best >= range.max + 3 || average >= range.max + 1.5 || aboveMaxCount >= Math.ceil(reps.length / 2)) {
    return {
      status: "increase",
      label: "Subir carga",
      signature,
      first,
      last,
      best,
      average,
      setCount: reps.length,
      note: `Ultima sesion ${signature}. Te sobraron reps frente al objetivo ${range.min}-${range.max}.`,
    };
  }

  if (steepDrop || belowMinCount >= Math.ceil(reps.length / 2)) {
    if (first < range.min && belowMinCount >= Math.ceil(reps.length * 0.67)) {
      return {
        status: "decrease",
        label: "Bajar carga",
        signature,
        first,
        last,
        best,
        average,
        setCount: reps.length,
        note: `Ultima sesion ${signature}. La mayoria de series quedo debajo del rango ${range.min}-${range.max}.`,
      };
    }

    return {
      status: "evaluate",
      label: "Evaluar carga",
      signature,
      first,
      last,
      best,
      average,
      setCount: reps.length,
      note: `Ultima sesion ${signature}. Abriste en rango, pero la caida indica que ese peso sigue en evaluacion.`,
    };
  }

  return {
    status: "hold",
    label: "Mantener",
    signature,
    first,
    last,
    best,
    average,
    setCount: reps.length,
    note: `Ultima sesion ${signature}. Manten el peso hasta dominar ${range.min}-${range.max} en todas las series.`,
  };
}

function snapshotSetSummary(item, snapshot, currentProfile) {
  const sets = snapshotSetEntries(snapshot);
  if (!sets.length) {
    return "";
  }

  const repsSignature = planSetRepSignature(sets);
  const snapshotProfile = equipmentProfileFromSnapshot(snapshot, item);
  const representativeWeightKg = representativeStoredWeightKgFromSets(sets, Number(snapshot?.lastWeightKg || 0));
  const displayedWeight =
    representativeWeightKg > 0
      ? convertStoredWeightKgToDisplayed(item, representativeWeightKg, snapshotProfile, currentProfile)
      : 0;

  return [
    repsSignature ? `${repsSignature} reps` : "",
    displayedWeight > 0 ? formatWeightWithUnit(displayedWeight, currentProfile.weightUnit) : "",
  ]
    .filter(Boolean)
    .join(" • ");
}

function defaultPlanSetReps(entry, snapshot) {
  const range = parseRepRange(entry.repsText);
  if (range) {
    return String(range.max);
  }

  const previousSetReps = snapshotSetEntries(snapshot)[0]?.reps;
  return previousSetReps > 0 ? String(previousSetReps) : "";
}

function defaultPlanSetWeight(entry, resolvedExercise, snapshot) {
  const equipmentProfile = resolvedExercise.equipmentProfile;
  const previousProfile = equipmentProfileFromSnapshot(snapshot, entry.exercise);
  const representativeWeightKg = representativeStoredWeightKgFromSets(
    snapshotSetEntries(snapshot),
    Number(snapshot?.lastWeightKg || 0)
  );
  const displayedWeight =
    resolvedExercise.suggestedWeightKg ??
    (representativeWeightKg > 0
      ? convertStoredWeightKgToDisplayed(entry.exercise, representativeWeightKg, previousProfile, equipmentProfile)
      : 0);

  return Number.isFinite(displayedWeight) && displayedWeight > 0 ? formatEditableWeight(displayedWeight) : "";
}

function planSetCountForEntry(entry) {
  const inputSets = state.planInputs[entry.id]?.sets;
  const storedCount = Array.isArray(inputSets) ? inputSets.length : 0;
  return Math.max(1, entry.sets, storedCount);
}

function buildPlanSetRows(entry, resolvedExercise, snapshot = performanceSnapshotForItem(entry.exercise, state.performanceBySlug)) {
  const inputSets = Array.isArray(state.planInputs[entry.id]?.sets) ? state.planInputs[entry.id].sets : [];
  const defaultReps = defaultPlanSetReps(entry, snapshot);
  const defaultWeight = defaultPlanSetWeight(entry, resolvedExercise, snapshot);

  return Array.from({ length: planSetCountForEntry(entry) }, (_, index) => {
    const setInput = inputSets[index] || {};
    return {
      index,
      reps: setInput.reps ?? defaultReps,
      weight: setInput.weight ?? defaultWeight,
    };
  });
}

function ensurePlanSetInputs(exerciseId, entry = findPlanExerciseById(exerciseId), resolvedExercise = entry ? resolvePlanExercise(entry) : null) {
  if (!entry || !resolvedExercise) {
    return [];
  }

  const rows = buildPlanSetRows(entry, resolvedExercise);
  const currentInput = state.planInputs[exerciseId] || {};
  state.planInputs[exerciseId] = {
    ...currentInput,
    sets: rows.map((row) => ({
      reps: row.reps ?? "",
      weight: row.weight ?? "",
    })),
  };

  return state.planInputs[exerciseId].sets;
}

function bodyWeightDisplayValue() {
  return displayedWeightFromStoredKg(state.preferences.bodyWeightKg, state.preferences.weightUnit);
}

function bodyWeightInputBounds(unit) {
  if (normalizeWeightUnit(unit) === "lb") {
    return { min: 77, max: 485, step: 1 };
  }
  return { min: 35, max: 220, step: 0.5 };
}

function convertPlanInputWeightForProfiles(exerciseId, fromProfile, toProfile) {
  const inputState = state.planInputs[exerciseId];
  if (!inputState) {
    return;
  }

  if (Array.isArray(inputState.sets)) {
    inputState.sets = inputState.sets.map((set) => {
      const numericWeight = Number(set?.weight);
      if (!Number.isFinite(numericWeight) || numericWeight <= 0) {
        return { ...set };
      }

      return {
        ...set,
        weight: formatEditableWeight(
          convertDisplayedLoad(findPlanExerciseById(exerciseId)?.exercise || { equipment: [] }, numericWeight, fromProfile, toProfile)
        ),
      };
    });
    return;
  }

  const rawWeight = inputState.weight;
  if (rawWeight === undefined || rawWeight === "") {
    return;
  }

  const numericWeight = Number(rawWeight);
  if (!Number.isFinite(numericWeight)) {
    return;
  }

  inputState.weight = formatEditableWeight(
    convertDisplayedLoad(findPlanExerciseById(exerciseId)?.exercise || { equipment: [] }, numericWeight, fromProfile, toProfile)
  );
}

function syncPlanInputWeightsForGlobalUnitChange(previousUnit, nextUnit) {
  for (const block of state.plan?.blocks || []) {
    for (const entry of block.exercises) {
      const storedProfile = state.equipmentProfiles[exerciseProfileKey(entry.exercise)] || {};
      if (storedProfile.unitOverride) {
        continue;
      }

      const beforeProfile = materializeEquipmentProfile(entry.exercise, storedProfile, previousUnit);
      const afterProfile = materializeEquipmentProfile(entry.exercise, storedProfile, nextUnit);
      convertPlanInputWeightForProfiles(entry.id, beforeProfile, afterProfile);
    }
  }
}

function resolvePlanExercise(entry) {
  const equipmentProfile = exerciseEquipmentProfile(entry.exercise);
  const weightUnit = resolvedExerciseWeightUnit(entry.exercise, equipmentProfile);
  const intensity = inferIntensity(entry.exercise);
  const snapshot = performanceSnapshotForItem(entry.exercise, state.performanceBySlug);
  const progression = makeProgression(
    entry.exercise,
    snapshot,
    entry.repsText,
    state.preferences.goal,
    intensity,
    state.preferences,
    equipmentProfile
  );

  return {
    ...entry,
    equipmentProfile,
    weightUnit,
    performanceSnapshot: snapshot,
    suggestedWeightKg: progression.suggestedWeightKg,
    progressionNote: progression.note,
    sessionSummary: progression.sessionSummary,
  };
}

function estimateBaselineLoad(item, preferences, repsText, goal, intensity, equipmentProfile = exerciseEquipmentProfile(item)) {
  const blob = normalize([item.name, item.displayName, item.slug, item.equipment.join(" ")].join(" "));
  const weightUnit = resolvedExerciseWeightUnit(item, equipmentProfile);
  if (isWeightedVariation(item)) {
    return {
      suggestedWeightKg: roundToNearest(
        displayedWeightFromStoredKg(5, weightUnit),
        suggestedWeightStep(item, weightUnit)
      ),
      note: "Empieza con lastre ligero.",
      machineAdjustmentLabel: "",
    };
  }

  const equipmentClass = inferEquipmentClass(item);
  const pattern = inferLoadPattern(item);
  if (!pattern || pattern.ratio == null || equipmentClass === "conditioning") {
    return {
      suggestedWeightKg: null,
      note: equipmentClass === "conditioning" ? "Guiate por ritmo y esfuerzo." : "",
      machineAdjustmentLabel: "",
    };
  }

  if (equipmentClass === "bodyweight" && !isWeightedVariation(item)) {
    return {
      suggestedWeightKg: null,
      note: "Movimiento libre; registra lastre solo si lo usas.",
      machineAdjustmentLabel: "",
    };
  }

  const bodyWeightKg = Math.min(220, Math.max(35, Number(preferences.bodyWeightKg || DEFAULT_PREFERENCES.bodyWeightKg)));
  const experienceFactor = EXPERIENCE_LOAD_FACTORS[preferences.experienceLevel] || 1;
  const strategyFactor = LOAD_STRATEGY_FACTORS[preferences.loadStrategy] || 1;
  const goalFactor = GOAL_LOAD_FACTORS[goal] || 1;
  const range = parseRepRange(repsText);
  const repFactor = repRangeLoadFactor(range);
  const intensityFactor = intensity === "heavy" ? 1.04 : intensity === "moderate" ? 1 : 0.86;
  const brand = machineBrandProfile(equipmentProfile.brandId);
  const referenceLoad =
    bodyWeightKg * pattern.ratio * experienceFactor * strategyFactor * goalFactor * repFactor * intensityFactor;
  const suggestedWeightKg = convertDisplayedLoad(
    item,
    Math.max(pattern.minKg, referenceLoad),
    { brandId: "generic", label: "Generica", loadMode: defaultLoadModeForItem(item) },
    equipmentProfile
  );
  const machineAdjustmentLabel =
    machineBrandFactor(item, equipmentProfile) !== 1 && isMachineAdjustable(item)
      ? `adaptada a ${brand.label}`
      : "";

  return {
    suggestedWeightKg,
    note: [
      `Arranco esta variante en ${formatWeightWithUnit(suggestedWeightKg, weightUnit)}.`,
      machineAdjustmentLabel,
    ]
      .filter(Boolean)
      .join(" • "),
    machineAdjustmentLabel,
  };
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

function rationale(preferences, focus, durationMinutes, fatigue) {
  return [focus, `${durationMinutes} min`, `fatiga ${fatigueLabel(fatigue)}`].filter(Boolean).join(" • ");
}

function buildCompletedPlanSets(entry, resolvedExercise, previousSnapshot) {
  const equipmentProfile = resolvedExercise.equipmentProfile;
  const rows = buildPlanSetRows(entry, resolvedExercise, previousSnapshot);

  return rows
    .map((row) => {
      const reps = Number(row.reps);
      const displayedWeight = Number(row.weight);
      const weightKg =
        Number.isFinite(displayedWeight) && displayedWeight > 0
          ? storedWeightKgFromDisplayed(displayedWeight, equipmentProfile.weightUnit)
          : 0;
      const referenceLoadKg =
        weightKg > 0 ? referenceLoadFromStoredWeightKg(entry.exercise, weightKg, equipmentProfile) : 0;

      return {
        reps: Number.isFinite(reps) && reps > 0 ? reps : 0,
        weightKg,
        referenceLoadKg,
      };
    })
    .filter((set) => set.reps > 0 || set.weightKg > 0);
}

function completeCurrentPlan() {
  if (!state.plan) {
    return;
  }

  if (state.restTimer.active) {
    completeRestTimer(true);
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
      const resolvedExercise = resolvePlanExercise(exercise);
      const equipmentProfile = resolvedExercise.equipmentProfile;
      const snapshotKey = normalize(exercise.exercise.slug);
      const previous = state.performanceBySlug[snapshotKey] || {
        id: snapshotKey,
        exerciseID: exercise.exercise.id,
        exerciseSlug: exercise.exercise.slug,
        lastWeightKg: 0,
        bestWeightKg: 0,
        lastReps: 0,
        sessionsCount: 0,
        firstReferenceWeightKg: 0,
        lastReferenceWeightKg: 0,
        bestReferenceWeightKg: 0,
        updatedAt: completedAt.toISOString(),
      };

      const input = state.planInputs[exercise.id] || {};
      const parsedRange = parseRepRange(exercise.repsText);
      const defaultReps = parsedRange ? parsedRange.max : Number(previous.lastReps || 0);
      const previousProfile = equipmentProfileFromSnapshot(previous, exercise.exercise);
      const completedSets = buildCompletedPlanSets(exercise, resolvedExercise, previous);
      const fallbackDisplayedWeight = Number(
        resolvedExercise.suggestedWeightKg ??
          convertStoredWeightKgToDisplayed(
            exercise.exercise,
            Number(previous.lastWeightKg || 0),
            previousProfile,
            equipmentProfile
          ) ??
          0
      );
      const fallbackWeightKg =
        Number.isFinite(fallbackDisplayedWeight) && fallbackDisplayedWeight > 0
          ? storedWeightKgFromDisplayed(fallbackDisplayedWeight, equipmentProfile.weightUnit)
          : Number(previous.lastWeightKg || 0);
      const representativeWeightKg = representativeStoredWeightKgFromSets(completedSets, fallbackWeightKg);
      const representativeReps =
        completedSets[0]?.reps ||
        (input.reps === "" || input.reps === undefined ? Number(defaultReps || 0) : Number(input.reps));
      const normalizedWeight =
        representativeWeightKg > 0
          ? referenceLoadFromStoredWeightKg(exercise.exercise, representativeWeightKg, equipmentProfile)
          : Number(previous.lastReferenceWeightKg || 0);
      const bestSessionWeightKg = Math.max(
        0,
        ...completedSets.map((set) => Number(set.weightKg || 0)).filter((value) => Number.isFinite(value))
      );
      const bestSessionReferenceKg = Math.max(
        0,
        ...completedSets.map((set) => Number(set.referenceLoadKg || 0)).filter((value) => Number.isFinite(value))
      );
      const firstReferenceWeightKg =
        Number(previous.firstReferenceWeightKg || 0) > 0
          ? Number(previous.firstReferenceWeightKg)
          : normalizedWeight;

      state.performanceBySlug[snapshotKey] = {
        ...previous,
        lastWeightKg: representativeWeightKg > 0 ? representativeWeightKg : previous.lastWeightKg,
        bestWeightKg: Math.max(previous.bestWeightKg || 0, bestSessionWeightKg),
        lastReps: Number.isFinite(representativeReps) ? representativeReps : previous.lastReps,
        lastSets: completedSets,
        sessionsCount: Number(previous.sessionsCount || 0) + 1,
        firstReferenceWeightKg,
        lastReferenceWeightKg: normalizedWeight,
        bestReferenceWeightKg: Math.max(Number(previous.bestReferenceWeightKg || 0), normalizedWeight, bestSessionReferenceKg),
        machineBrandId: equipmentProfile.brandId,
        machineLabel: equipmentProfile.label,
        loadMode: equipmentProfile.loadMode,
        weightUnit: equipmentProfile.weightUnit,
        updatedAt: completedAt.toISOString(),
      };
    }
  }

  state.planInputs = {};
  persistState();
  regeneratePlan();
  setToast("Entrenamiento guardado.");
}

function persistState() {
  localStorage.setItem(STORAGE_KEYS.preferences, JSON.stringify(state.preferences));
  localStorage.setItem(STORAGE_KEYS.history, JSON.stringify(state.history));
  localStorage.setItem(STORAGE_KEYS.performance, JSON.stringify(state.performanceBySlug));
  localStorage.setItem(STORAGE_KEYS.equipmentProfiles, JSON.stringify(state.equipmentProfiles));
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
    bodyWeightKg: Number.isFinite(Number(stored.bodyWeightKg))
      ? Math.min(220, Math.max(35, Number(stored.bodyWeightKg)))
      : DEFAULT_PREFERENCES.bodyWeightKg,
    weightUnit: WEIGHT_UNIT_OPTIONS.some((option) => option.id === stored.weightUnit)
      ? stored.weightUnit
      : DEFAULT_PREFERENCES.weightUnit,
    experienceLevel: EXPERIENCE_LEVELS.includes(stored.experienceLevel)
      ? stored.experienceLevel
      : DEFAULT_PREFERENCES.experienceLevel,
    loadStrategy: LOAD_STRATEGIES.includes(stored.loadStrategy)
      ? stored.loadStrategy
      : DEFAULT_PREFERENCES.loadStrategy,
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

function loadStoredEquipmentProfiles() {
  return loadStoredObject(STORAGE_KEYS.equipmentProfiles);
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

function loadStoredMotivationPhrases() {
  try {
    const raw = localStorage.getItem(STORAGE_KEYS.motivationPhrasesCache);
    if (!raw) {
      return [...MOTIVATION_FALLBACK_PHRASES];
    }

    const parsed = JSON.parse(raw);
    if (!Array.isArray(parsed)) {
      return [...MOTIVATION_FALLBACK_PHRASES];
    }

    const phrases = parsed
      .map((value) => String(value || "").trim())
      .filter(Boolean);

    return phrases.length ? phrases : [...MOTIVATION_FALLBACK_PHRASES];
  } catch {
    return [...MOTIVATION_FALLBACK_PHRASES];
  }
}

function persistMotivationPhrases(phrases) {
  try {
    localStorage.setItem(STORAGE_KEYS.motivationPhrasesCache, JSON.stringify(phrases));
  } catch {
    // Ignore cache write issues and keep the runtime copy only.
  }
}

async function fetchMotivationPhrasesFromSupabase() {
  const response = await fetch(
    `${SUPABASE_PUBLIC_CONFIG.url}/rest/v1/daily_motivation_phrases?select=phrase,sort_order&is_active=eq.true&order=sort_order.asc,id.asc`,
    {
      headers: {
        apikey: SUPABASE_PUBLIC_CONFIG.anonKey,
        Authorization: `Bearer ${SUPABASE_PUBLIC_CONFIG.anonKey}`,
        Accept: "application/json",
      },
    }
  );

  if (!response.ok) {
    throw new Error(`Supabase motivation fetch failed: ${response.status}`);
  }

  const rows = await response.json();
  if (!Array.isArray(rows)) {
    return [];
  }

  return rows
    .map((row) => String(row?.phrase || "").trim())
    .filter(Boolean);
}

async function loadDailyMotivationPhrases() {
  const cachedPhrases = state.data.motivationPhrases?.length
    ? [...state.data.motivationPhrases]
    : loadStoredMotivationPhrases();

  try {
    const remotePhrases = await fetchMotivationPhrasesFromSupabase();
    if (remotePhrases.length) {
      persistMotivationPhrases(remotePhrases);
      return remotePhrases;
    }
  } catch {
    // Keep cache/fallback silently; the homepage still needs a phrase.
  }

  return cachedPhrases.length ? cachedPhrases : [...MOTIVATION_FALLBACK_PHRASES];
}

function loadViewerId() {
  try {
    const stored = localStorage.getItem(STORAGE_KEYS.viewerId);
    if (stored) {
      return stored;
    }

    const generated = globalThis.crypto?.randomUUID?.() || uid("viewer");
    localStorage.setItem(STORAGE_KEYS.viewerId, generated);
    return generated;
  } catch {
    return uid("viewer");
  }
}

function positiveModulo(value, divisor) {
  return ((value % divisor) + divisor) % divisor;
}

function stableHash(value) {
  let hash = 0;
  const source = String(value || "");
  for (let index = 0; index < source.length; index += 1) {
    hash = (hash * 31 + source.charCodeAt(index)) | 0;
  }
  return hash;
}

function localDayNumber(date = new Date()) {
  return Math.floor(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()) / 86400000);
}

function dailyMotivationPhrase(viewerId = localViewerId, date = new Date(), phrases = state.data.motivationPhrases) {
  const sourcePhrases = Array.isArray(phrases) && phrases.length ? phrases : MOTIVATION_FALLBACK_PHRASES;

  if (!sourcePhrases.length) {
    return "Haz que hoy cuente.";
  }

  if (sourcePhrases.length === 1) {
    return sourcePhrases[0];
  }

  const baseIndex = positiveModulo(stableHash(`${viewerId}:base`), sourcePhrases.length);
  const dailyStep = positiveModulo(stableHash(`${viewerId}:step`), sourcePhrases.length - 1) + 1;
  const phraseIndex = positiveModulo(baseIndex + localDayNumber(date) * dailyStep, sourcePhrases.length);
  return sourcePhrases[phraseIndex];
}

function buildIdleRestTimer() {
  return {
    active: false,
    running: false,
    remainingSeconds: 0,
    totalSeconds: 0,
    exerciseId: null,
    exerciseName: "",
  };
}

function findPlanExerciseById(exerciseId) {
  for (const block of state.plan?.blocks || []) {
    const match = block.exercises.find((entry) => entry.id === exerciseId);
    if (match) {
      return match;
    }
  }
  return null;
}

function syncTrainingScreenState() {
  const validScreens = new Set(["overview", "preferences", "exercise"]);
  if (!validScreens.has(state.ui.trainingScreen)) {
    state.ui.trainingScreen = "overview";
  }

  if (!state.plan?.blocks?.length) {
    state.ui.selectedTrainingExerciseId = null;
    if (state.ui.trainingScreen === "exercise") {
      state.ui.trainingScreen = "overview";
    }
    return;
  }

  if (state.ui.trainingScreen === "exercise" && !findPlanExerciseById(state.ui.selectedTrainingExerciseId || "")) {
    state.ui.trainingScreen = "overview";
    state.ui.selectedTrainingExerciseId = null;
  }
}

function scrollTrainingScreenToTop() {
  window.scrollTo({
    top: 0,
    left: 0,
    behavior: "auto",
  });
}

function openTrainingOverview() {
  if (state.view === "training") {
    runViewTransition(() => {
      state.ui.trainingScreen = "overview";
      state.ui.selectedTrainingExerciseId = null;
      render();
      scrollTrainingScreenToTop();
    });
    return;
  }
  state.ui.trainingScreen = "overview";
  state.ui.selectedTrainingExerciseId = null;
  navigateToView("training");
}

function openTrainingPreferences() {
  if (state.view === "training") {
    runViewTransition(() => {
      state.ui.trainingScreen = "preferences";
      state.ui.selectedTrainingExerciseId = null;
      render();
      scrollTrainingScreenToTop();
    });
    return;
  }
  state.ui.trainingScreen = "preferences";
  state.ui.selectedTrainingExerciseId = null;
  navigateToView("training");
}

function openTrainingExercise(exerciseId) {
  if (!findPlanExerciseById(exerciseId)) {
    return;
  }

  if (state.view === "training") {
    runViewTransition(() => {
      state.ui.trainingScreen = "exercise";
      state.ui.selectedTrainingExerciseId = exerciseId;
      render();
      scrollTrainingScreenToTop();
    });
    return;
  }
  state.ui.trainingScreen = "exercise";
  state.ui.selectedTrainingExerciseId = exerciseId;
  navigateToView("training");
}

function startRestTimer(seconds, exerciseId, exerciseName) {
  state.restTimer = {
    active: true,
    running: true,
    remainingSeconds: Math.max(1, Math.round(seconds)),
    totalSeconds: Math.max(1, Math.round(seconds)),
    exerciseId,
    exerciseName,
  };
  ensureRestTimerInterval();
  render();
}

function ensureRestTimerInterval() {
  if (restTimerInterval) {
    return;
  }

  restTimerInterval = window.setInterval(() => {
    if (!state.restTimer.active || !state.restTimer.running) {
      return;
    }

    if (state.restTimer.remainingSeconds <= 1) {
      completeRestTimer(false);
      return;
    }

    state.restTimer.remainingSeconds -= 1;
    render();
  }, 1000);
}

function toggleRestTimer() {
  if (!state.restTimer.active) {
    return;
  }
  state.restTimer.running = !state.restTimer.running;
  render();
}

function adjustRestTimer(deltaSeconds) {
  if (!state.restTimer.active) {
    return;
  }
  state.restTimer.remainingSeconds = Math.max(5, state.restTimer.remainingSeconds + Math.round(deltaSeconds));
  state.restTimer.totalSeconds = Math.max(state.restTimer.totalSeconds, state.restTimer.remainingSeconds);
  render();
}

function completeRestTimer(isManual) {
  const exerciseName = state.restTimer.exerciseName;
  state.restTimer = buildIdleRestTimer();
  if (restTimerInterval) {
    clearInterval(restTimerInterval);
    restTimerInterval = null;
  }
  if (!isManual) {
    setToast(exerciseName ? `${exerciseName}: descanso completo.` : "Descanso completo.");
  }
  render();
}

function closeOpenSelectPanels(exceptPanel = null) {
  document.querySelectorAll(".select-panel[open]").forEach((panel) => {
    if (panel !== exceptPanel) {
      panel.removeAttribute("open");
    }
  });
}

function handleClick(event) {
  const activeSelectPanel = event.target.closest(".select-panel");
  closeOpenSelectPanels(activeSelectPanel);

  const selectOption = event.target.closest("[data-select-id][data-select-value]");
  if (selectOption) {
    event.preventDefault();
    const selectId = selectOption.dataset.selectId;
    const nextValue = selectOption.dataset.selectValue ?? "";
    const selectElement = selectId ? document.getElementById(selectId) : null;
    if (selectElement instanceof HTMLSelectElement) {
      selectElement.value = nextValue;
      selectElement.dispatchEvent(new Event("change", { bubbles: true }));
    }
    return;
  }

  const target = event.target.closest("[data-action]");
  if (!target) {
    return;
  }

  const { action } = target.dataset;

  if (action === "set-view") {
    if (target.dataset.view === "training") {
      if (state.view === "training") {
        openTrainingOverview();
        return;
      }
      state.ui.trainingScreen = "overview";
      state.ui.selectedTrainingExerciseId = null;
    }
    navigateToView(target.dataset.view);
    return;
  }

  if (action === "retry-load") {
    loadData();
    return;
  }

  if (action === "jump-training") {
    state.ui.trainingScreen = "preferences";
    state.ui.selectedTrainingExerciseId = null;
    navigateToView("training");
    return;
  }

  if (action === "open-training-overview" || action === "back-training-overview") {
    openTrainingOverview();
    return;
  }

  if (action === "open-training-preferences") {
    openTrainingPreferences();
    return;
  }

  if (action === "open-training-exercise") {
    const exerciseId = target.dataset.exerciseId;
    if (!exerciseId) return;
    openTrainingExercise(exerciseId);
    return;
  }

  if (action === "jump-explorer") {
    navigateToView("explorer");
    return;
  }

  if (action === "jump-nutrition") {
    navigateToView("nutrition");
    return;
  }

  if (action === "jump-progress") {
    navigateToView("progress");
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

  if (action === "add-plan-set") {
    const exerciseId = target.dataset.exerciseId;
    if (!exerciseId) return;
    const entry = findPlanExerciseById(exerciseId);
    if (!entry) return;
    const resolvedEntry = resolvePlanExercise(entry);
    const nextSets = ensurePlanSetInputs(exerciseId, entry, resolvedEntry);
    const fallbackReps = defaultPlanSetReps(entry, resolvedEntry.performanceSnapshot);
    const fallbackWeight = defaultPlanSetWeight(entry, resolvedEntry, resolvedEntry.performanceSnapshot);
    const lastSet = nextSets[nextSets.length - 1] || { reps: fallbackReps, weight: fallbackWeight };
    state.planInputs[exerciseId].sets.push({
      reps: lastSet.reps || fallbackReps,
      weight: lastSet.weight || fallbackWeight,
    });
    render();
    return;
  }

  if (action === "remove-plan-set") {
    const exerciseId = target.dataset.exerciseId;
    if (!exerciseId) return;
    const entry = findPlanExerciseById(exerciseId);
    if (!entry) return;
    const currentSets = ensurePlanSetInputs(exerciseId, entry, resolvePlanExercise(entry));
    if (currentSets.length <= Math.max(1, entry.sets)) {
      return;
    }
    currentSets.pop();
    render();
    return;
  }

  if (action === "start-rest-timer") {
    const seconds = Number(target.dataset.restSeconds);
    const exerciseId = target.dataset.exerciseId || null;
    const exerciseName = target.dataset.exerciseName || "Descanso";
    if (!Number.isFinite(seconds) || seconds <= 0) return;
    startRestTimer(seconds, exerciseId, exerciseName);
    return;
  }

  if (action === "toggle-rest-timer") {
    toggleRestTimer();
    return;
  }

  if (action === "skip-rest-timer") {
    completeRestTimer(true);
    return;
  }

  if (action === "add-rest-time") {
    const delta = Number(target.dataset.deltaSeconds || 0);
    if (!Number.isFinite(delta) || !delta) return;
    adjustRestTimer(delta);
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

  if (target.matches("[data-pref='bodyWeightKg']")) {
    const storedWeightKg = storedWeightKgFromDisplayed(
      Number(target.value) || bodyWeightDisplayValue(),
      state.preferences.weightUnit
    );
    state.preferences.bodyWeightKg = Math.min(220, Math.max(35, storedWeightKg || DEFAULT_PREFERENCES.bodyWeightKg));
    persistState();
    regeneratePlan();
    render();
    return;
  }

  if (target.matches("[data-pref='weightUnit']")) {
    const previousUnit = state.preferences.weightUnit;
    const nextUnit = WEIGHT_UNIT_OPTIONS.some((option) => option.id === target.value)
      ? target.value
      : DEFAULT_PREFERENCES.weightUnit;
    if (previousUnit !== nextUnit) {
      syncPlanInputWeightsForGlobalUnitChange(previousUnit, nextUnit);
    }
    state.preferences.weightUnit = nextUnit;
    persistState();
    regeneratePlan();
    render();
    return;
  }

  if (target.matches("[data-pref='experienceLevel']")) {
    state.preferences.experienceLevel = EXPERIENCE_LEVELS.includes(target.value)
      ? target.value
      : DEFAULT_PREFERENCES.experienceLevel;
    persistState();
    regeneratePlan();
    render();
    return;
  }

  if (target.matches("[data-pref='loadStrategy']")) {
    state.preferences.loadStrategy = LOAD_STRATEGIES.includes(target.value)
      ? target.value
      : DEFAULT_PREFERENCES.loadStrategy;
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

  if (target.matches("[data-ui='selectedFamilyKey']")) {
    state.ui.selectedFamilyKey = target.value;
    render();
    return;
  }

  if (target.matches("[data-machine-field='label']")) {
    const exerciseId = target.dataset.exerciseId;
    if (!exerciseId) return;
    updateEquipmentProfileForExercise(exerciseId, { label: target.value });
    return;
  }

  if (target.matches("[data-machine-field='loadMode']")) {
    const exerciseId = target.dataset.exerciseId;
    if (!exerciseId) return;
    updateEquipmentProfileForExercise(exerciseId, { loadMode: target.value });
    return;
  }

  if (target.matches("[data-machine-field='unitOverride']")) {
    const exerciseId = target.dataset.exerciseId;
    if (!exerciseId) return;
    updateEquipmentProfileForExercise(exerciseId, { unitOverride: target.value || null });
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

  if (target.matches("[data-plan-set-field]")) {
    const exerciseId = target.dataset.exerciseId;
    const field = target.dataset.planSetField;
    const setIndex = Number(target.dataset.setIndex);
    if (!exerciseId || !field || !Number.isInteger(setIndex) || setIndex < 0) return;
    const entry = findPlanExerciseById(exerciseId);
    if (!entry) return;
    ensurePlanSetInputs(exerciseId, entry, resolvePlanExercise(entry));
    state.planInputs[exerciseId].sets[setIndex] = {
      ...(state.planInputs[exerciseId].sets[setIndex] || { reps: "", weight: "" }),
      [field]: target.value,
    };
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
    ignoreNextHashChange = true;
    window.location.hash = state.view;
  }
}

function prefersReducedMotion() {
  return window.matchMedia("(prefers-reduced-motion: reduce)").matches;
}

function isValidView(viewId) {
  return VIEW_OPTIONS.some((entry) => entry.id === viewId);
}

async function runViewTransition(update) {
  if (typeof update !== "function") {
    return;
  }

  if (prefersReducedMotion()) {
    update();
    return;
  }

  if (typeof document.startViewTransition === "function") {
    const transition = document.startViewTransition(() => {
      update();
    });

    try {
      await transition.finished;
    } catch (_error) {
      // Ignore interrupted transitions and leave the latest UI rendered.
    }
    return;
  }

  const currentStage = appRoot.querySelector(".view-stage");
  const currentShell = appRoot.querySelector(".view-shell");
  if (!(currentStage instanceof HTMLElement) || !(currentShell instanceof HTMLElement) || typeof currentStage.animate !== "function") {
    update();
    return;
  }

  const currentRect = currentStage.getBoundingClientRect();
  const currentShellRect = currentShell.getBoundingClientRect();
  const clone = currentStage.cloneNode(true);
  if (!(clone instanceof HTMLElement)) {
    update();
    return;
  }

  clone.classList.add("view-transition-clone");
  clone.style.left = `${currentShellRect.left + window.scrollX}px`;
  clone.style.top = `${currentShellRect.top + window.scrollY}px`;
  clone.style.width = `${currentShellRect.width}px`;
  clone.style.height = `${currentRect.height}px`;
  document.body.append(clone);

  update();

  const nextShell = appRoot.querySelector(".view-shell");
  const nextStage = appRoot.querySelector(".view-stage");
  if (!(nextShell instanceof HTMLElement) || !(nextStage instanceof HTMLElement) || typeof nextStage.animate !== "function") {
    clone.remove();
    return;
  }

  const nextRect = nextStage.getBoundingClientRect();
  nextShell.style.minHeight = `${Math.max(currentRect.height, nextRect.height)}px`;
  nextStage.classList.add("is-transitioning-in");
  nextStage.style.opacity = "0";
  nextStage.style.transform = "translate3d(0, 30px, 0) scale(0.992)";
  nextStage.style.filter = "blur(16px)";
  nextStage.style.pointerEvents = "none";

  await new Promise((resolve) => {
    requestAnimationFrame(() => resolve());
  });

  const cloneAnimation = clone.animate(
    [
      { opacity: 1, transform: "translate3d(0, 0, 0) scale(1)", filter: "blur(0px)" },
      { opacity: 0.22, transform: "translate3d(0, -18px, 0) scale(0.986)", filter: "blur(14px)" },
      { opacity: 0, transform: "translate3d(0, -24px, 0) scale(0.98)", filter: "blur(20px)" },
    ],
    {
      duration: 420,
      easing: "cubic-bezier(0.55, 0, 0.18, 1)",
      fill: "both",
    }
  );

  const stageAnimation = nextStage.animate(
    [
      { opacity: 0, transform: "translate3d(0, 30px, 0) scale(0.992)", filter: "blur(16px)" },
      { opacity: 0.72, transform: "translate3d(0, 10px, 0) scale(0.997)", filter: "blur(6px)" },
      { opacity: 1, transform: "translate3d(0, 0, 0) scale(1)", filter: "blur(0px)" },
    ],
    {
      duration: 560,
      easing: "cubic-bezier(0.16, 1, 0.3, 1)",
      fill: "both",
    }
  );

  try {
    await Promise.allSettled([cloneAnimation.finished, stageAnimation.finished]);
  } finally {
    clone.remove();
    nextStage.classList.remove("is-transitioning-in");
    nextStage.style.opacity = "";
    nextStage.style.transform = "";
    nextStage.style.filter = "";
    nextStage.style.pointerEvents = "";
    nextShell.style.minHeight = "";
  }
}

function navigateToView(nextView, { fromHash = false } = {}) {
  if (!isValidView(nextView) || nextView === state.view) {
    if (!fromHash && isValidView(nextView)) {
      syncHashToView();
    }
    return queuedViewTransition;
  }

  queuedViewTransition = queuedViewTransition
    .catch(() => {})
    .then(() =>
      runViewTransition(() => {
        state.view = nextView;
        if (!fromHash) {
          syncHashToView();
        }
        render();
      })
    );

  return queuedViewTransition;
}

function handleHashChange() {
  if (ignoreNextHashChange) {
    ignoreNextHashChange = false;
    return;
  }

  const requested = window.location.hash.replace("#", "");
  const nextView = isValidView(requested) ? requested : "dashboard";
  if (nextView === state.view) {
    return;
  }

  navigateToView(nextView, { fromHash: true });
}

function render() {
  const stats = buildStats();

  appRoot.innerHTML = `
    <div class="app-shell">
      ${renderHeader(stats)}
      ${renderMobileDock()}
      <main class="view-shell">
        <div class="view-stage" data-view="${escapeAttribute(state.view)}">
          ${state.error ? renderErrorBanner(state.error) : ""}
          ${state.loading ? renderLoading() : renderCurrentView(stats)}
        </div>
      </main>
    </div>
    ${renderRestTimer()}
    ${state.ui.toast ? `<div class="toast ${state.restTimer.active ? "is-elevated" : ""}" role="status" aria-live="polite">${escapeHtml(state.ui.toast)}</div>` : ""}
  `;
}

function renderBrandMark() {
  return `
    <div class="brand-mark" aria-hidden="true">
      <span class="brand-mark-base">
        <span class="brand-mark-solid"></span>
        <span class="brand-mark-grecas"></span>
      </span>
    </div>
  `;
}

function renderViewIcon(viewId) {
  switch (viewId) {
    case "dashboard":
      return `
        <svg class="view-icon-svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M6 18h12" />
          <path d="M8 18v-2.6h2V13h4v2.4h2V18" />
          <path d="M7 10.8 12 6l5 4.8" />
          <path d="M9 18v-2.1h6V18" />
          <path d="M12 3.4v1.8" />
          <path d="M9.4 5.2h5.2" />
        </svg>
      `;
    case "training":
      return `
        <svg class="view-icon-svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M4.2 10h1.7v4H4.2z" />
          <path d="M6.1 8.7h1.6v6.6H6.1z" />
          <path d="M16.3 8.7h1.6v6.6h-1.6z" />
          <path d="M18.1 10h1.7v4h-1.7z" />
          <path d="M7.7 12h8.6" />
          <circle cx="12" cy="12" r="1.45" />
          <path d="M10.5 9.2h3M10.5 14.8h3" />
        </svg>
      `;
    case "explorer":
      return `
        <svg class="view-icon-svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M4.5 12c2-3.1 4.6-4.8 7.5-4.8s5.5 1.7 7.5 4.8c-2 3.1-4.6 4.8-7.5 4.8S6.5 15.1 4.5 12Z" />
          <circle cx="12" cy="12" r="1.55" />
          <path d="M12 4.3v1.8M12 17.9v1.8M4.3 12h1.8M17.9 12h1.8" />
          <path d="M9.2 9.2 12 12l2.8-2.8" />
        </svg>
      `;
    case "nutrition":
      return `
        <svg class="view-icon-svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M5.1 16.8c1.8 1 4.2 1.5 6.9 1.5s5.1-.5 6.9-1.5" />
          <path d="M7.3 15.3c.5-4 2.1-7.1 4.7-9.2 2.6 2.1 4.2 5.2 4.7 9.2" />
          <path d="M12 7.1v7.5" />
          <path d="M9.7 9.2c.9.6 1.7 1.6 2.3 2.8" />
          <path d="M14.3 9.2c-.9.6-1.7 1.6-2.3 2.8" />
          <path d="M18.1 5.4v1.8M17.2 6.3H19" />
        </svg>
      `;
    case "challenges":
      return `
        <svg class="view-icon-svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M5 18.5h14" />
          <path d="M7 18.5v-2.1h2.1V14h2.1v-2.3h1.6V14H15v2.4h2v2.1" />
          <path d="M10.4 9.5h3.2M10.4 7.3h3.2" />
          <path d="M12 11.7v6.8" />
          <path d="M12 4.9v1.2M8.4 10.8h7.2" />
        </svg>
      `;
    case "progress":
      return `
        <svg class="view-icon-svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M6 19h12" />
          <path d="M7.6 16v-4.4M12 16V9M16.4 16v-6.8" />
          <path d="M7.6 11.6 12 7l4.4 2" />
          <path d="M10 4.8h4" />
          <path d="M10 19v-3h4v3" />
        </svg>
      `;
    default:
      return "";
  }
}

function renderHeader(stats) {
  const isDashboardHeader = state.view === "dashboard";

  return `
    <header class="masthead glass-panel ${isDashboardHeader ? "is-compact" : ""}">
      <div class="masthead-top">
        <div class="brand-line">
          ${renderBrandMark()}
          <div class="brand-copy">
            <h1>XibApp</h1>
          </div>
        </div>
        ${
          isDashboardHeader
            ? ""
            : `
              <div class="status-cluster">
                <span class="status-pill"><span class="status-dot"></span>${state.data.exercises.length || 0} ejercicios</span>
                <span class="status-pill">${state.data.recipes.length || 0} recetas activas</span>
                <span class="status-pill">${stats.totalSessions} sesiones guardadas</span>
              </div>
            `
        }
      </div>
      <nav class="nav-strip" aria-label="Navegacion principal">
        ${VIEW_OPTIONS.map(
          (option) => `
            <button
              class="nav-pill ${state.view === option.id ? "is-active" : ""}"
              data-action="set-view"
              data-view="${option.id}"
              aria-label="${escapeAttribute(option.label)}"
              title="${escapeAttribute(option.label)}"
            >
              <span class="nav-pill-icon" aria-hidden="true">${renderViewIcon(option.id)}</span>
              <span class="nav-pill-kicker">${escapeHtml(option.kicker)}</span>
              <span class="nav-pill-label">${escapeHtml(option.label)}</span>
            </button>
          `
        ).join("")}
      </nav>
    </header>
  `;
}

function renderMobileDock() {
  return `
    <nav class="mobile-dock" aria-label="Accesos moviles">
      ${VIEW_OPTIONS.map(
        (option) => `
          <button
            class="mobile-dock-pill ${state.view === option.id ? "is-active" : ""}"
            data-action="set-view"
            data-view="${option.id}"
            aria-label="${escapeAttribute(option.label)}"
            title="${escapeAttribute(option.label)}"
            ${state.view === option.id ? `aria-current="page"` : ""}
          >
            <span class="mobile-dock-icon" aria-hidden="true">${renderViewIcon(option.id)}</span>
            <span class="mobile-dock-label" aria-hidden="true">${escapeHtml(option.label)}</span>
            <span class="sr-only">${escapeHtml(option.label)}</span>
          </button>
        `
      ).join("")}
    </nav>
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
          ${renderBrandMark()}
          <div>
            <h1>XibApp</h1>
          </div>
        </div>
        <p class="boot-copy">Cargando...</p>
      </div>
    </section>
  `;
}

function renderRestTimer() {
  if (!state.restTimer.active || !state.restTimer.totalSeconds) {
    return "";
  }

  const progress = Math.max(
    0,
    Math.min(100, Math.round((state.restTimer.remainingSeconds / state.restTimer.totalSeconds) * 100))
  );

  return `
    <section class="rest-timer-tray ${state.restTimer.running ? "is-running" : "is-paused"}" aria-live="polite">
      <div class="rest-timer-top">
        <div>
          <span class="timer-label">${state.restTimer.running ? "Descanso activo" : "Descanso pausado"}</span>
          <h3>${escapeHtml(state.restTimer.exerciseName || "Descanso")}</h3>
        </div>
        <div class="rest-timer-clock">${formatClock(state.restTimer.remainingSeconds)}</div>
      </div>
      <div class="rest-timer-progress" aria-hidden="true">
        <span style="width:${progress}%"></span>
      </div>
      <div class="timer-controls">
        <button class="secondary-button" data-action="toggle-rest-timer">
          ${state.restTimer.running ? "Pausar" : "Reanudar"}
        </button>
        <button class="ghost-button" data-action="add-rest-time" data-delta-seconds="15">+15s</button>
        <button class="ghost-button" data-action="skip-rest-timer">Terminar</button>
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

function dashboardChallengeHighlight(stats) {
  return (
    stats.registeredChallengeItems[0] ||
    state.data.challenges.find((challenge) => challenge.isFeatured) ||
    state.data.challenges[0] ||
    null
  );
}

function renderDashboardExercisePreview(context) {
  return `
    <button
      class="dashboard-session-item"
      data-action="open-training-exercise"
      data-exercise-id="${context.entry.id}"
      aria-label="Abrir ${escapeAttribute(context.entry.exercise.displayName)}"
    >
      <span class="dashboard-session-order">${String(context.absoluteIndex + 1).padStart(2, "0")}</span>
      <span class="dashboard-session-copy">
        <strong>${escapeHtml(context.entry.exercise.displayName)}</strong>
        <span class="dashboard-session-meta">${escapeHtml(trainingExerciseSummary(context))}</span>
      </span>
      <span class="dashboard-session-tag">${escapeHtml(trainingEquipmentLabel(context.entry.exercise))}</span>
    </button>
  `;
}

function renderDashboardView(stats) {
  const motivationPhrase = dailyMotivationPhrase();
  const trainingContexts = buildTrainingExerciseContexts();
  const leadContext = trainingContexts[0] || null;
  const previewContexts = trainingContexts.slice(0, 4);
  const remainingExerciseCount = Math.max(0, trainingContexts.length - previewContexts.length);
  const challengeHighlight = dashboardChallengeHighlight(stats);
  const calorieTarget = GOAL_MACRO_TARGETS[state.preferences.goal]?.calories || 0;
  const calorieProgress = calorieTarget > 0 ? Math.min(100, Math.round((stats.macros.calories / calorieTarget) * 100)) : 0;
  const todayTitle = trainingDayLabel(state.plan?.focus || "");

  return `
    <section class="section-stack dashboard-home">
      <div class="hero-grid dashboard-hero-grid">
        <article class="glass-panel hero-copy hero-mantra dashboard-mantra-card">
          <p class="eyebrow">Mantra del dia</p>
          <h1>${escapeHtml(motivationPhrase)}</h1>
          <div class="meta-strip">
            <span class="chip is-jade">${escapeHtml(state.preferences.goal)}</span>
            <span class="chip">${escapeHtml(state.preferences.split)}</span>
            <span class="chip is-gold">${state.plan?.estimatedMinutes || state.preferences.sessionDurationMinutes} min</span>
          </div>
        </article>
        <aside class="summary-card hero-note dashboard-today-card">
          <div class="panel-title">
            <h3>Hoy</h3>
            <span class="chip is-jade">${escapeHtml(state.plan?.focus || "Sin plan")}</span>
          </div>
          <div class="dashboard-today-copy">
            <h2>${escapeHtml(todayTitle)}</h2>
            <p>${escapeHtml(state.plan?.rationale || "Ajusta tu plan para empezar.")}</p>
          </div>
          <div class="dashboard-inline-metrics">
            <article class="dashboard-inline-metric">
              <span class="label">Racha</span>
              <strong>${stats.streakDays} dias</strong>
            </article>
            <article class="dashboard-inline-metric">
              <span class="label">Semana</span>
              <strong>${stats.weeklySessions} sesiones</strong>
            </article>
            <article class="dashboard-inline-metric">
              <span class="label">Minutos</span>
              <strong>${stats.weeklyMinutes} min</strong>
            </article>
          </div>
          <div class="button-row">
            <button class="secondary-button" data-action="open-training-overview">Abrir rutina</button>
            <button class="ghost-button" data-action="open-training-preferences">Ajustar plan</button>
          </div>
        </aside>
      </div>

      <div class="dashboard-kpi-grid">
        <article class="summary-card dashboard-kpi-card">
          <span class="label">Sesiones</span>
          <span class="value">${stats.totalSessions}</span>
          <div class="accent-line"></div>
        </article>
        <article class="summary-card dashboard-kpi-card">
          <span class="label">7 dias</span>
          <span class="value">${stats.weeklySessions}</span>
          <div class="accent-line"></div>
        </article>
        <article class="summary-card dashboard-kpi-card">
          <span class="label">Min semanales</span>
          <span class="value">${stats.weeklyMinutes}</span>
          <div class="accent-line"></div>
        </article>
        <article class="summary-card dashboard-kpi-card">
          <span class="label">Recetas</span>
          <span class="value">${stats.completedRecipes}</span>
          <div class="accent-line"></div>
        </article>
      </div>

      <div class="dashboard-main-grid">
        <section class="panel-card dashboard-session-panel">
          <div class="panel-title">
            <div>
              <h2>Tu sesion</h2>
            </div>
            <button class="ghost-button" data-action="open-training-overview">Ver completa</button>
          </div>
          ${
            leadContext
              ? `
                <article class="dashboard-session-feature">
                  <div>
                    <p class="eyebrow">Primero</p>
                    <h3>${escapeHtml(leadContext.entry.exercise.displayName)}</h3>
                    <p class="panel-copy">${escapeHtml(trainingExerciseSummary(leadContext))} • ${escapeHtml(leadContext.entry.exercise.muscles.slice(0, 2).join(" • "))}</p>
                  </div>
                  <span class="family-count">${escapeHtml(trainingEquipmentLabel(leadContext.entry.exercise))}</span>
                </article>
                <div class="dashboard-session-list">
                  ${previewContexts.map((context) => renderDashboardExercisePreview(context)).join("")}
                </div>
                ${remainingExerciseCount ? `<p class="small-copy">+${remainingExerciseCount} ejercicios mas dentro de Entrenamiento.</p>` : ""}
              `
              : `
                ${renderEmptyState("Todavia no hay una sesion lista para hoy.")}
                <button class="secondary-button" data-action="open-training-preferences">Armar mi plan</button>
              `
          }
        </section>

        <div class="dashboard-side-stack">
          <article class="feature-card dashboard-side-card">
            <div class="panel-title">
              <h3>Progreso</h3>
              <button class="ghost-button" data-action="set-view" data-view="progress">Abrir</button>
            </div>
            <div class="metrics-grid">
              <article class="metric-card">
                <span class="label">Enfoque</span>
                <span class="value">${escapeHtml(stats.favoriteFocus)}</span>
                <div class="accent-line"></div>
              </article>
              <article class="metric-card gold">
                <span class="label">Racha</span>
                <span class="value">${stats.streakDays}</span>
                <div class="accent-line"></div>
              </article>
            </div>
          </article>

          <article class="feature-card dashboard-side-card">
            <div class="panel-title">
              <h3>Nutricion</h3>
              <button class="ghost-button" data-action="set-view" data-view="nutrition">Abrir</button>
            </div>
            <p class="panel-copy">${stats.macros.calories} / ${calorieTarget || 0} kcal hoy.</p>
            <div class="dashboard-goal-progress" aria-hidden="true">
              <span style="width:${calorieProgress}%"></span>
            </div>
            <div class="meta-strip">
              <span class="chip">${stats.completedRecipes} recetas</span>
              <span class="chip">${stats.pendingShopping} compras</span>
            </div>
          </article>

          <article class="feature-card dashboard-side-card">
            <div class="panel-title">
              <h3>Retos</h3>
              <button class="ghost-button" data-action="set-view" data-view="challenges">Abrir</button>
            </div>
            ${
              challengeHighlight
                ? `
                  <article class="challenge-highlight">
                    <strong>${escapeHtml(challengeHighlight.title)}</strong>
                    <p class="panel-meta">${escapeHtml(challengeHighlight.subtitle)}</p>
                  </article>
                  <div class="meta-strip">
                    <span class="chip is-gold">${stats.registeredChallenges} activos</span>
                    ${(challengeHighlight.tags || [])
                      .slice(0, 2)
                      .map((tag) => `<span class="chip">${escapeHtml(tag)}</span>`)
                      .join("")}
                  </div>
                `
                : renderEmptyState("Todavia no tienes un reto marcado.")
            }
          </article>
        </div>
      </div>
    </section>
  `;
}

function buildTrainingExerciseContexts() {
  const contexts = [];

  for (const [blockIndex, block] of (state.plan?.blocks || []).entries()) {
    for (const [exerciseIndex, entry] of block.exercises.entries()) {
      contexts.push({
        block,
        blockIndex,
        exerciseIndex,
        absoluteIndex: contexts.length,
        entry,
        resolvedEntry: resolvePlanExercise(entry),
      });
    }
  }

  return contexts;
}

function findTrainingContext(exerciseId, contexts) {
  return contexts.find((context) => context.entry.id === exerciseId) || null;
}

function trainingDayLabel(focus) {
  if (!focus) return "Rutina del dia";
  return normalize(focus) === "cuerpo completo" ? "Cuerpo completo" : `Dia de ${focus}`;
}

function trainingUniqueMuscleCount(contexts) {
  return new Set(
    contexts.flatMap((context) => context.entry.exercise.muscles.map((muscle) => normalize(muscle)))
  ).size;
}

function trainingExerciseSummary(context) {
  const parts = [`${context.resolvedEntry.sets} series`, context.resolvedEntry.repsText];
  if (context.resolvedEntry.suggestedWeightKg != null) {
    parts.push(formatWeightWithUnit(context.resolvedEntry.suggestedWeightKg, context.resolvedEntry.weightUnit));
  }
  return parts.join(" • ");
}

function trainingEquipmentLabel(item) {
  return item.equipment[0] || "Equipo libre";
}

function trainingBlockLabel(block, blockIndex) {
  if (block.type === "superset") return "Superset";
  if (block.type === "circuit") return "Circuito";
  return blockIndex === 0 ? "Ejercicio de enfoque" : "Ejercicio";
}

function renderTrainingPreferencesPanel() {
  const bodyWeightBounds = bodyWeightInputBounds(state.preferences.weightUnit);

  return `
    <div class="panel-title">
      <h3>Ajustes del plan</h3>
      <span class="chip">${state.preferences.availableEquipment.length} equipos</span>
    </div>
    <div class="field-grid">
      <div class="split-field-grid">
        <div class="field-group">
          <label for="bodyweight-input">Peso corporal (${state.preferences.weightUnit})</label>
          <input
            id="bodyweight-input"
            class="number-input"
            type="number"
            min="${bodyWeightBounds.min}"
            max="${bodyWeightBounds.max}"
            step="${bodyWeightBounds.step}"
            value="${escapeAttribute(formatEditableWeight(bodyWeightDisplayValue()))}"
            data-pref="bodyWeightKg"
          />
        </div>
        <div class="field-group">
          <label for="experience-select">Nivel</label>
          ${renderSelectInput({
            id: "experience-select",
            value: state.preferences.experienceLevel,
            options: EXPERIENCE_LEVELS.map((level) => ({ value: level, label: level })),
            dataAttributes: { pref: "experienceLevel" },
            menuLabel: "Nivel",
          })}
        </div>
      </div>
      <div class="field-group">
        <label for="goal-select">Objetivo</label>
        ${renderSelectInput({
          id: "goal-select",
          value: state.preferences.goal,
          options: GOALS.map((goal) => ({ value: goal, label: goal })),
          dataAttributes: { pref: "goal" },
          menuLabel: "Objetivo",
        })}
      </div>
      <div class="field-group">
        <label for="split-select">Division</label>
        ${renderSelectInput({
          id: "split-select",
          value: state.preferences.split,
          options: SPLITS.map((split) => ({ value: split, label: split })),
          dataAttributes: { pref: "split" },
          menuLabel: "Division",
        })}
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
      <div class="split-field-grid">
        <div class="field-group">
          <label for="strategy-select">Carga</label>
          ${renderSelectInput({
            id: "strategy-select",
            value: state.preferences.loadStrategy,
            options: LOAD_STRATEGIES.map((strategy) => ({ value: strategy, label: strategy })),
            dataAttributes: { pref: "loadStrategy" },
            menuLabel: "Carga",
          })}
        </div>
        <div class="field-group">
          <label for="weight-unit-select">Unidad global</label>
          ${renderSelectInput({
            id: "weight-unit-select",
            value: state.preferences.weightUnit,
            options: WEIGHT_UNIT_OPTIONS.map((option) => ({ value: option.id, label: option.label })),
            dataAttributes: { pref: "weightUnit" },
            menuLabel: "Unidad global",
          })}
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
        <button class="secondary-button" data-action="complete-plan">Guardar sesion</button>
      </div>
    </div>
  `;
}

function renderTrainingOverviewLead(context) {
  return `
    <button
      class="training-focus-card"
      data-action="open-training-exercise"
      data-exercise-id="${context.entry.id}"
      aria-label="Abrir ${escapeAttribute(context.entry.exercise.displayName)}"
    >
      <span class="training-focus-order">${String(context.absoluteIndex + 1).padStart(2, "0")}</span>
      <span class="training-focus-copy">
        <span class="training-focus-kicker">Ejercicio de enfoque</span>
        <span class="training-focus-title">${escapeHtml(context.entry.exercise.displayName)}</span>
        <span class="training-focus-summary">${escapeHtml(trainingExerciseSummary(context))}</span>
        <span class="training-focus-detail">${escapeHtml(context.entry.exercise.muscles.slice(0, 2).join(" • "))}</span>
      </span>
      <span class="training-focus-tag">${escapeHtml(trainingEquipmentLabel(context.entry.exercise))}</span>
    </button>
  `;
}

function renderTrainingRoutineRow(context) {
  return `
    <button
      class="training-routine-row"
      data-action="open-training-exercise"
      data-exercise-id="${context.entry.id}"
      aria-label="Abrir ${escapeAttribute(context.entry.exercise.displayName)}"
    >
      <span class="training-routine-order">${String(context.absoluteIndex + 1).padStart(2, "0")}</span>
      <span class="training-routine-copy">
        <span class="training-routine-title">${escapeHtml(context.entry.exercise.displayName)}</span>
        <span class="training-routine-summary">${escapeHtml(trainingExerciseSummary(context))}</span>
      </span>
      <span class="training-routine-tag">${escapeHtml(trainingEquipmentLabel(context.entry.exercise))}</span>
    </button>
  `;
}

function renderTrainingOverviewScreen(contexts) {
  const leadContext = contexts[0] || null;
  const uniqueMuscles = trainingUniqueMuscleCount(contexts);

  return `
    <section class="section-stack training-screen training-overview-screen">
      ${renderMachineProfileDatalist()}
      <div class="training-topbar training-topbar-overview">
        <button class="training-crumb" data-action="open-training-preferences">
          <span class="training-crumb-mark" aria-hidden="true">XI</span>
          <span class="training-crumb-label">Mi plan</span>
        </button>
        <div class="meta-strip">
          <span class="chip is-jade">${escapeHtml(state.preferences.goal)}</span>
          <span class="chip is-gold">${state.plan?.estimatedMinutes || state.preferences.sessionDurationMinutes} min</span>
        </div>
      </div>

      <article class="glass-panel training-day-card">
        <div class="training-day-card-head">
          <div>
            <h2>${escapeHtml(trainingDayLabel(state.plan?.focus || ""))}</h2>
            <p class="training-day-card-meta">${contexts.length} ejercicios • ${uniqueMuscles} musculos</p>
          </div>
          <button class="secondary-button" data-action="open-training-preferences">Cambiar</button>
        </div>
        ${
          leadContext
            ? renderTrainingOverviewLead(leadContext)
            : `
              <div class="training-empty-card">
                ${renderEmptyState("No se encontraron ejercicios compatibles con la configuracion actual.")}
                <button class="secondary-button" data-action="open-training-preferences">Ajustar plan</button>
              </div>
            `
        }
      </article>

      ${
        contexts.length
          ? `
            <div class="training-routine-stack">
              ${state.plan.blocks
                .map((block, blockIndex) => {
                  const blockContexts = block.exercises
                    .map((entry) => findTrainingContext(entry.id, contexts))
                    .filter(Boolean)
                    .filter((context) => context.entry.id !== leadContext?.entry.id);

                  if (!blockContexts.length) {
                    return "";
                  }

                  return `
                    <section class="training-routine-block">
                      <div class="training-routine-block-head">
                        <h3>${escapeHtml(trainingBlockLabel(block, blockIndex))}</h3>
                        ${block.rounds ? `<span class="chip">${block.rounds} rondas</span>` : ""}
                      </div>
                      <div class="training-routine-list">
                        ${blockContexts.map((context) => renderTrainingRoutineRow(context)).join("")}
                      </div>
                    </section>
                  `;
                })
                .join("")}
            </div>
          `
          : ""
      }

      ${
        leadContext
          ? `
            <div class="training-overview-footer">
              <button class="action-button" data-action="open-training-exercise" data-exercise-id="${leadContext.entry.id}">
                Iniciar entrenamiento
              </button>
              <button class="ghost-button" data-action="complete-plan">Guardar sesion</button>
            </div>
          `
          : ""
      }
    </section>
  `;
}

function renderTrainingPreferencesScreen(contexts) {
  return `
    <section class="section-stack training-screen training-preferences-screen">
      ${renderMachineProfileDatalist()}
      <div class="training-topbar">
        <button class="secondary-button training-back-button" data-action="back-training-overview">Volver al plan</button>
        <div class="meta-strip">
          <span class="chip is-jade">${escapeHtml(state.preferences.goal)}</span>
          <span class="chip">${contexts.length} ejercicios</span>
        </div>
      </div>

      <div class="content-grid training-preferences-layout">
        <aside class="panel-card training-config training-config-panel">
          ${renderTrainingPreferencesPanel()}
        </aside>

        <article class="plan-overview panel-card training-settings-summary">
          <div class="plan-title-row">
            <div>
              <p class="eyebrow">Resumen actual</p>
              <h3>${escapeHtml(trainingDayLabel(state.plan?.focus || ""))}</h3>
            </div>
            <span class="chip is-gold">${state.plan?.estimatedMinutes || state.preferences.sessionDurationMinutes} min</span>
          </div>
          <div class="meta-strip">
            <span class="chip">${escapeHtml(state.preferences.split)}</span>
            <span class="chip">${trainingUniqueMuscleCount(contexts)} musculos</span>
            <span class="chip">${escapeHtml(state.preferences.experienceLevel)}</span>
            <span class="chip">${formatWeightWithUnit(bodyWeightDisplayValue(), state.preferences.weightUnit)}</span>
          </div>
        </article>
      </div>
    </section>
  `;
}

function renderTrainingExerciseScreen(context, contexts) {
  const nextContext = contexts[context.absoluteIndex + 1] || null;

  return `
    <section class="section-stack training-screen training-detail-screen">
      ${renderMachineProfileDatalist()}
      <div class="training-topbar">
        <button class="secondary-button training-back-button" data-action="back-training-overview">Volver</button>
        <span class="chip">${context.absoluteIndex + 1} de ${contexts.length}</span>
      </div>

      <article class="glass-panel training-detail-hero">
        <div class="training-detail-hero-head">
          <div>
            <p class="eyebrow">${escapeHtml(trainingBlockLabel(context.block, context.blockIndex))}</p>
            <h2>${escapeHtml(context.entry.exercise.displayName)}</h2>
            <p class="exercise-subtitle">${escapeHtml(context.entry.exercise.displayTechnique || context.entry.exercise.muscles.slice(0, 2).join(" / "))}</p>
          </div>
          <span class="family-count">${escapeHtml(trainingEquipmentLabel(context.entry.exercise))}</span>
        </div>
        <div class="meta-strip training-detail-meta">
          <span class="chip is-gold">${context.resolvedEntry.sets} series</span>
          <span class="chip">${escapeHtml(context.resolvedEntry.repsText)}</span>
          <span class="chip">${context.resolvedEntry.suggestedWeightKg != null ? formatWeightWithUnit(context.resolvedEntry.suggestedWeightKg, context.resolvedEntry.weightUnit) : "Sin carga fija"}</span>
          <span class="chip">${context.resolvedEntry.restSeconds}s descanso</span>
        </div>
      </article>

      ${renderPlanExerciseCard(context.entry, false, { hideHeading: true, extraClass: "training-detail-card-body" })}

      <div class="training-detail-footer">
        <button class="ghost-button" data-action="back-training-overview">Volver al plan</button>
        ${
          nextContext
            ? `<button class="secondary-button" data-action="open-training-exercise" data-exercise-id="${nextContext.entry.id}">Siguiente ejercicio</button>`
            : `<button class="secondary-button" data-action="complete-plan">Guardar sesion</button>`
        }
      </div>
    </section>
  `;
}

function renderTrainingView() {
  syncTrainingScreenState();
  const contexts = buildTrainingExerciseContexts();
  const selectedContext = findTrainingContext(state.ui.selectedTrainingExerciseId || "", contexts);

  if (state.ui.trainingScreen === "preferences") {
    return renderTrainingPreferencesScreen(contexts);
  }

  if (state.ui.trainingScreen === "exercise" && selectedContext) {
    return renderTrainingExerciseScreen(selectedContext, contexts);
  }

  return renderTrainingOverviewScreen(contexts);
}

function renderMachineProfileDatalist() {
  return `
    <datalist id="machine-profile-list">
      ${MACHINE_BRAND_OPTIONS.map((option) => `<option value="${escapeAttribute(option.label)}"></option>`).join("")}
    </datalist>
  `;
}

function renderSelectInput({ id, value, options, dataAttributes = {}, menuLabel = "" }) {
  const normalizedValue = String(value ?? "");
  const normalizedOptions = options.map((option) => ({
    value: String(option.value ?? ""),
    label: String(option.label ?? option.value ?? ""),
  }));
  const selectedOption =
    normalizedOptions.find((option) => option.value === normalizedValue) ||
    normalizedOptions[0] || {
      value: "",
      label: "Seleccionar",
    };
  const dataAttributeString = Object.entries(dataAttributes)
    .map(([key, attributeValue]) => `data-${key}="${escapeAttribute(attributeValue)}"`)
    .join(" ");

  return `
    <div class="select-shell">
      <select id="${escapeAttribute(id)}" class="select-input select-input-native" ${dataAttributeString}>
        ${normalizedOptions
          .map(
            (option) =>
              `<option value="${escapeAttribute(option.value)}" ${option.value === selectedOption.value ? "selected" : ""}>${escapeHtml(option.label)}</option>`
          )
          .join("")}
      </select>
      <details class="select-panel">
        <summary class="select-trigger" aria-haspopup="listbox" aria-label="${escapeAttribute(menuLabel || selectedOption.label)}">
          <span class="select-trigger-value">${escapeHtml(selectedOption.label)}</span>
          <span class="select-trigger-caret" aria-hidden="true"></span>
        </summary>
        <div class="select-menu" role="listbox" aria-label="${escapeAttribute(menuLabel || id)}">
          ${normalizedOptions
            .map(
              (option) => `
                <button
                  type="button"
                  class="select-option ${option.value === selectedOption.value ? "is-selected" : ""}"
                  data-select-id="${escapeAttribute(id)}"
                  data-select-value="${escapeAttribute(option.value)}"
                  role="option"
                  aria-selected="${option.value === selectedOption.value ? "true" : "false"}"
                >
                  <span class="select-option-copy">${escapeHtml(option.label)}</span>
                </button>
              `
            )
            .join("")}
        </div>
      </details>
    </div>
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

function renderPlanExerciseCard(entry, compact, options = {}) {
  const { hideHeading = false, extraClass = "" } = options;
  const resolvedEntry = resolvePlanExercise(entry);
  const equipmentProfile = resolvedEntry.equipmentProfile;
  const weightUnit = resolvedEntry.weightUnit;
  const setRows = compact ? [] : buildPlanSetRows(entry, resolvedEntry, resolvedEntry.performanceSnapshot);
  const canRemoveExtraSet = setRows.length > Math.max(1, entry.sets);
  const articleClass = ["exercise-card", extraClass].filter(Boolean).join(" ");
  const trackerSummary = compact
    ? ""
    : [
        `${setRows.length} series`,
        entry.repsText,
        resolvedEntry.suggestedWeightKg != null ? formatWeightWithUnit(resolvedEntry.suggestedWeightKg, weightUnit) : "",
        `${resolvedEntry.restSeconds}s descanso`,
      ]
        .filter(Boolean)
        .join(" • ");
  return `
    <article class="${escapeAttribute(articleClass)}">
      ${
        hideHeading
          ? ""
          : `
            <div class="exercise-heading">
              <div>
                <h4>${escapeHtml(entry.exercise.displayName)}</h4>
                <p class="exercise-subtitle">${escapeHtml(entry.exercise.displayTechnique || entry.exercise.muscles.slice(0, 2).join(" / "))}</p>
              </div>
              <span class="family-count">${escapeHtml(entry.exercise.equipment.join(", ") || "Equipo libre")}</span>
            </div>
          `
      }
      ${
        compact
          ? `
            <div class="exercise-meta-grid">
              <div class="mini-stat"><span class="label">Series</span><span class="value">${resolvedEntry.sets}</span></div>
              <div class="mini-stat"><span class="label">Reps</span><span class="value">${escapeHtml(resolvedEntry.repsText)}</span></div>
              <div class="mini-stat"><span class="label">Descanso</span><span class="value">${resolvedEntry.restSeconds}s</span></div>
              <div class="mini-stat"><span class="label">Carga sugerida</span><span class="value">${resolvedEntry.suggestedWeightKg != null ? formatWeightWithUnit(resolvedEntry.suggestedWeightKg, weightUnit) : "-"}</span></div>
            </div>
            <div class="exercise-prescription">
              <p class="small-copy">${escapeHtml(resolvedEntry.notes)}</p>
              <p class="small-copy">${escapeHtml(resolvedEntry.progressionNote)}</p>
            </div>
          `
          : ""
      }
      ${
        compact
          ? ""
          : `
            ${
              isMachineAdjustable(entry.exercise)
                ? `
                  <div class="machine-config-card">
                    <div class="machine-config-grid">
                      <div class="field-group">
                        <label for="machine-label-${entry.id}">Equipo / identificador</label>
                        <input
                          id="machine-label-${entry.id}"
                          class="text-input"
                          type="text"
                          list="machine-profile-list"
                          value="${escapeAttribute(equipmentProfile.label)}"
                          placeholder="Technogym, Hammer Strength, generica..."
                          data-machine-field="label"
                          data-exercise-id="${entry.id}"
                        />
                      </div>
                      ${
                        supportsWeightTypeSelection(entry.exercise)
                          ? `
                            <div class="field-group">
                              <label for="machine-mode-${entry.id}">Tipo de peso</label>
                              ${renderSelectInput({
                                id: `machine-mode-${entry.id}`,
                                value: equipmentProfile.loadMode,
                                options: LOAD_MODE_OPTIONS.map((option) => ({ value: option.id, label: option.label })),
                                dataAttributes: {
                                  "machine-field": "loadMode",
                                  "exercise-id": entry.id,
                                },
                                menuLabel: "Tipo de peso",
                              })}
                            </div>
                          `
                          : ""
                      }
                      <div class="field-group">
                        <label for="machine-unit-${entry.id}">Unidad</label>
                        ${renderSelectInput({
                          id: `machine-unit-${entry.id}`,
                          value: equipmentProfile.unitOverride || "",
                          options: [
                            { value: "", label: `Global (${state.preferences.weightUnit})` },
                            ...WEIGHT_UNIT_OPTIONS.map((option) => ({ value: option.id, label: option.label })),
                          ],
                          dataAttributes: {
                            "machine-field": "unitOverride",
                            "exercise-id": entry.id,
                          },
                          menuLabel: "Unidad",
                        })}
                      </div>
                    </div>
                    <div class="machine-profile-note">
                      <span class="chip">${escapeHtml(machineBrandProfile(equipmentProfile.brandId).label)}</span>
                      ${
                        supportsWeightTypeSelection(entry.exercise)
                          ? `<span class="chip is-gold">${escapeHtml(weightTypeLabel(equipmentProfile.loadMode))}</span>`
                          : ""
                      }
                      <span class="chip">${escapeHtml(unitOverrideLabel(equipmentProfile.unitOverride))}</span>
                    </div>
                  </div>
                `
                : ""
            }
            <div class="set-tracker-card">
              <div class="set-tracker-head">
                <div>
                  <h5>Registro por serie</h5>
                  <p>${escapeHtml(trackerSummary)}</p>
                </div>
                <div class="set-tracker-actions">
                  ${
                    canRemoveExtraSet
                      ? `
                        <button
                          class="ghost-button"
                          data-action="remove-plan-set"
                          data-exercise-id="${entry.id}"
                        >
                          Quitar extra
                        </button>
                      `
                      : ""
                  }
                  <button
                    class="secondary-button"
                    data-action="add-plan-set"
                    data-exercise-id="${entry.id}"
                  >
                    Agregar serie
                  </button>
                </div>
              </div>
              <div class="set-tracker-grid">
                ${setRows
                  .map(
                    (setRow) => `
                      <div class="set-row">
                        <span class="set-badge">${setRow.index + 1}</span>
                        <div class="set-field">
                          <label for="set-reps-${entry.id}-${setRow.index}">Reps</label>
                          <input
                            id="set-reps-${entry.id}-${setRow.index}"
                            class="number-input"
                            type="number"
                            step="1"
                            min="0"
                            value="${escapeAttribute(setRow.reps ?? "")}"
                            data-plan-set-field="reps"
                            data-exercise-id="${entry.id}"
                            data-set-index="${setRow.index}"
                          />
                        </div>
                        <div class="set-field">
                          <label for="set-weight-${entry.id}-${setRow.index}">Peso (${weightUnit})</label>
                          <input
                            id="set-weight-${entry.id}-${setRow.index}"
                            class="number-input"
                            type="number"
                            step="${suggestedWeightStep(entry.exercise, weightUnit)}"
                            min="0"
                            value="${escapeAttribute(setRow.weight ?? "")}"
                            data-plan-set-field="weight"
                            data-exercise-id="${entry.id}"
                            data-set-index="${setRow.index}"
                          />
                        </div>
                      </div>
                    `
                  )
                  .join("")}
              </div>
            </div>
            <div class="exercise-action-row exercise-action-row-single">
              <button
                class="ghost-button"
                data-action="start-rest-timer"
                data-rest-seconds="${resolvedEntry.restSeconds}"
                data-exercise-id="${entry.id}"
                data-exercise-name="${escapeAttribute(entry.exercise.displayName)}"
              >
                Descanso ${resolvedEntry.restSeconds}s
              </button>
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
          <h2>Ejercicios</h2>
        </div>
        <div class="meta-strip">
          <span class="chip is-jade">${filteredFamilies.length} familias visibles</span>
          <span class="chip">${state.data.exercises.length} variantes cargadas</span>
        </div>
      </div>

      <div class="exercise-grid">
        <section class="panel-card explorer-list-panel">
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

        <section class="exercise-detail panel-card explorer-detail-panel">
          ${
            selectedFamily
              ? `
                <div class="field-group explorer-picker">
                  <label for="family-select">Cambiar familia</label>
                  ${renderSelectInput({
                    id: "family-select",
                    value: selectedFamily.key,
                    options: filteredFamilies.map((family) => ({
                      value: family.key,
                      label: `${family.displayName} (${family.variantCount})`,
                    })),
                    dataAttributes: { ui: "selectedFamilyKey" },
                    menuLabel: "Cambiar familia",
                  })}
                </div>
                <div class="view-header">
                  <div>
                    <h2>${escapeHtml(selectedFamily.displayName)}</h2>
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
          <h2>Nutricion</h2>
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
            ${renderSelectInput({
              id: "recipe-filter-select",
              value: state.ui.recipeFilter,
              options: [
                { value: "all", label: "Todas las comidas" },
                ...MEAL_ORDER.map((meal) => ({ value: meal.key, label: meal.label })),
              ],
              dataAttributes: { ui: "recipeFilter" },
              menuLabel: "Filtrar comidas",
            })}
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
          <h2>Retos</h2>
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
          <h2>Progreso</h2>
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
            <span class="chip is-gold">${state.preferences.weightUnit}</span>
          </div>
          ${
            Object.keys(state.performanceBySlug).length
              ? `
                <div class="table-wrap">
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
                              <td>${formatWeightWithUnit(displayedWeightFromStoredKg(Number(snapshot.lastWeightKg || 0), state.preferences.weightUnit), state.preferences.weightUnit)}</td>
                              <td>${formatWeightWithUnit(displayedWeightFromStoredKg(Number(snapshot.bestWeightKg || 0), state.preferences.weightUnit), state.preferences.weightUnit)}</td>
                              <td>${snapshot.lastReps || 0}</td>
                              <td>${snapshot.sessionsCount || 0}</td>
                            </tr>
                          `
                        )
                        .join("")}
                    </tbody>
                  </table>
                </div>
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

function formatClock(totalSeconds) {
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  return `${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`;
}
