Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA377148CC
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bML-0004bq-GB; Mon, 29 May 2023 07:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bMI-0004bL-Nd
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:18 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bMF-0004Tx-TO
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685360895; x=1716896895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jETI+qQxHBYMtZWHhHXZXr25jC60wBqEVHFHPtj/ht4=;
 b=IySuOq3d0KCpO2MyZnfwooH4nBfAbzz8XBXC01KLM1vZfiPzDVuJoNIc
 qsKyvprAG3SODQVH+bLSKztPeITufZ9iXzRGf7VzzXWDSHZl3yK8G+2Ym
 hrCGknO/61wGdPMrsKK48p/sJ09xBKRx2s8Alvaogjhb7MoE9HZucAhii
 N826gSjgdA/oIrNfjqcKN47bqgY4Gbo8eQhcfJ2bT/DWjkOfO0ftGN1QF
 p4lUc6HGk62RtPm1Y8LR4aWX+u33dyCs3hum+LI4e723eAORmUH8R1e00
 fOzYpBBRZu8wt0Qz2+wYD+2Lq1rC3FV3ViCTJuBTIn6QnaXGRwLgK5Ygu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357939614"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357939614"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 04:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="683554412"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="683554412"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga006.jf.intel.com with ESMTP; 29 May 2023 04:48:11 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v13 01/10] accel/tcg: remove CONFIG_PROFILER
Date: Mon, 29 May 2023 19:49:38 +0800
Message-Id: <20230529114947.2123652-2-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529114947.2123652-1-fei2.wu@intel.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=fei2.wu@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

TBStats will be introduced to replace CONFIG_PROFILER totally, here
remove all CONFIG_PROFILER related stuffs first.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/monitor.c           |  25 ----
 accel/tcg/tcg-accel-ops.c     |  10 --
 accel/tcg/translate-all.c     |  33 ------
 include/qemu/timer.h          |   9 --
 include/tcg/tcg.h             |  25 ----
 meson.build                   |   2 -
 meson_options.txt             |   2 -
 scripts/meson-buildoptions.sh |   3 -
 softmmu/runstate.c            |   9 --
 tcg/tcg.c                     | 208 ----------------------------------
 tests/qtest/qmp-cmd-test.c    |   3 -
 11 files changed, 329 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 92fce580f1..e903dd1d2e 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -80,36 +80,11 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
-#ifdef CONFIG_PROFILER
-
-int64_t dev_time;
-
-HumanReadableText *qmp_x_query_profile(Error **errp)
-{
-    g_autoptr(GString) buf = g_string_new("");
-    static int64_t last_cpu_exec_time;
-    int64_t cpu_exec_time;
-    int64_t delta;
-
-    cpu_exec_time = tcg_cpu_exec_time();
-    delta = cpu_exec_time - last_cpu_exec_time;
-
-    g_string_append_printf(buf, "async time  %" PRId64 " (%0.3f)\n",
-                           dev_time, dev_time / (double)NANOSECONDS_PER_SECOND);
-    g_string_append_printf(buf, "qemu time   %" PRId64 " (%0.3f)\n",
-                           delta, delta / (double)NANOSECONDS_PER_SECOND);
-    last_cpu_exec_time = cpu_exec_time;
-    dev_time = 0;
-
-    return human_readable_text_from_str(buf);
-}
-#else
 HumanReadableText *qmp_x_query_profile(Error **errp)
 {
     error_setg(errp, "Internal profiler not compiled");
     return NULL;
 }
-#endif
 
 static void hmp_tcg_register(void)
 {
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 58c8e64096..3973591508 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -70,20 +70,10 @@ void tcg_cpus_destroy(CPUState *cpu)
 int tcg_cpus_exec(CPUState *cpu)
 {
     int ret;
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
     assert(tcg_enabled());
-#ifdef CONFIG_PROFILER
-    ti = profile_getclock();
-#endif
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
-#ifdef CONFIG_PROFILER
-    qatomic_set(&tcg_ctx->prof.cpu_exec_time,
-                tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
-#endif
     return ret;
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c87648b99e..4e035e0f79 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -203,10 +203,6 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc)
 {
     uint64_t data[TARGET_INSN_START_WORDS];
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &tcg_ctx->prof;
-    int64_t ti = profile_getclock();
-#endif
     int insns_left = cpu_unwind_data_from_tb(tb, host_pc, data);
 
     if (insns_left < 0) {
@@ -223,12 +219,6 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
-
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->restore_time,
-                prof->restore_time + profile_getclock() - ti);
-    qatomic_set(&prof->restore_count, prof->restore_count + 1);
-#endif
 }
 
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
@@ -291,13 +281,6 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
     tcg_ctx->cpu = NULL;
     *max_insns = tb->icount;
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&tcg_ctx->prof.tb_count, tcg_ctx->prof.tb_count + 1);
-    qatomic_set(&tcg_ctx->prof.interm_time,
-                tcg_ctx->prof.interm_time + profile_getclock() - *ti);
-    *ti = profile_getclock();
-#endif
-
     return tcg_gen_code(tcg_ctx, tb, pc);
 }
 
@@ -311,9 +294,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_page_addr_t phys_pc;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &tcg_ctx->prof;
-#endif
     int64_t ti;
     void *host_pc;
 
@@ -365,12 +345,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
  tb_overflow:
 
-#ifdef CONFIG_PROFILER
-    /* includes aborted translations because of exceptions */
-    qatomic_set(&prof->tb_count1, prof->tb_count1 + 1);
-    ti = profile_getclock();
-#endif
-
     trace_translate_block(tb, pc, tb->tc.ptr);
 
     gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
@@ -425,13 +399,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     perf_report_code(pc, tb, tcg_splitwx_to_rx(gen_code_buf));
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
-    qatomic_set(&prof->code_in_len, prof->code_in_len + tb->size);
-    qatomic_set(&prof->code_out_len, prof->code_out_len + gen_code_size);
-    qatomic_set(&prof->search_out_len, prof->search_out_len + search_size);
-#endif
-
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(pc)) {
         FILE *logfile = qemu_log_trylock();
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index ee071e07d1..9a91cb1248 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -989,13 +989,4 @@ static inline int64_t cpu_get_host_ticks(void)
 }
 #endif
 
-#ifdef CONFIG_PROFILER
-static inline int64_t profile_getclock(void)
-{
-    return get_clock();
-}
-
-extern int64_t dev_time;
-#endif
-
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 072c35f7f5..083cbd6580 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -522,27 +522,6 @@ static inline TCGRegSet output_pref(const TCGOp *op, unsigned i)
     return i < ARRAY_SIZE(op->output_pref) ? op->output_pref[i] : 0;
 }
 
-typedef struct TCGProfile {
-    int64_t cpu_exec_time;
-    int64_t tb_count1;
-    int64_t tb_count;
-    int64_t op_count; /* total insn count */
-    int op_count_max; /* max insn per TB */
-    int temp_count_max;
-    int64_t temp_count;
-    int64_t del_op_count;
-    int64_t code_in_len;
-    int64_t code_out_len;
-    int64_t search_out_len;
-    int64_t interm_time;
-    int64_t code_time;
-    int64_t la_time;
-    int64_t opt_time;
-    int64_t restore_count;
-    int64_t restore_time;
-    int64_t table_op_count[NB_OPS];
-} TCGProfile;
-
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -569,10 +548,6 @@ struct TCGContext {
     tcg_insn_unit *code_buf;      /* pointer for start of tb */
     tcg_insn_unit *code_ptr;      /* pointer for running end of tb */
 
-#ifdef CONFIG_PROFILER
-    TCGProfile prof;
-#endif
-
 #ifdef CONFIG_DEBUG_TCG
     int goto_tb_issue_mask;
     const TCGOpcode *vecop_list;
diff --git a/meson.build b/meson.build
index 2d48aa1e2e..f08280bc8b 100644
--- a/meson.build
+++ b/meson.build
@@ -2141,7 +2141,6 @@ if numa.found()
                                        dependencies: numa))
 endif
 config_host_data.set('CONFIG_OPENGL', opengl.found())
-config_host_data.set('CONFIG_PROFILER', get_option('profiler'))
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
@@ -4110,7 +4109,6 @@ if 'objc' in all_languages
   summary_info += {'QEMU_OBJCFLAGS':    ' '.join(qemu_common_flags)}
 endif
 summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
-summary_info += {'profiler':          get_option('profiler')}
 summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
 summary_info += {'PIE':               get_option('b_pie')}
 summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
diff --git a/meson_options.txt b/meson_options.txt
index 90237389e2..bbb5c7e886 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -345,8 +345,6 @@ option('qom_cast_debug', type: 'boolean', value: true,
 option('gprof', type: 'boolean', value: false,
        description: 'QEMU profiling with gprof',
        deprecated: true)
-option('profiler', type: 'boolean', value: false,
-       description: 'profiler support')
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=*) in slirp networking')
 
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5714fd93d9..7dd5709ef4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -39,7 +39,6 @@ meson_options_help() {
   printf "%s\n" '                           jemalloc/system/tcmalloc)'
   printf "%s\n" '  --enable-module-upgrades try to load modules from alternate paths for'
   printf "%s\n" '                           upgrades'
-  printf "%s\n" '  --enable-profiler        profiler support'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
   printf "%s\n" '                           getrandom()'
   printf "%s\n" '  --enable-safe-stack      SafeStack Stack Smash Protection (requires'
@@ -401,8 +400,6 @@ _meson_option_parse() {
     --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
-    --enable-profiler) printf "%s" -Dprofiler=true ;;
-    --disable-profiler) printf "%s" -Dprofiler=false ;;
     --enable-pvrdma) printf "%s" -Dpvrdma=enabled ;;
     --disable-pvrdma) printf "%s" -Dpvrdma=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 2f2396c819..bd50062ed0 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -728,18 +728,9 @@ static bool main_loop_should_exit(int *status)
 int qemu_main_loop(void)
 {
     int status = EXIT_SUCCESS;
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
 
     while (!main_loop_should_exit(&status)) {
-#ifdef CONFIG_PROFILER
-        ti = profile_getclock();
-#endif
         main_loop_wait(false);
-#ifdef CONFIG_PROFILER
-        dev_time += profile_getclock() - ti;
-#endif
     }
 
     return status;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ac30d484f5..47befdfcae 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2983,10 +2983,6 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
-
-#ifdef CONFIG_PROFILER
-    qatomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
-#endif
 }
 
 void tcg_remove_ops_after(TCGOp *op)
@@ -5856,102 +5852,6 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
 
-#ifdef CONFIG_PROFILER
-
-/* avoid copy/paste errors */
-#define PROF_ADD(to, from, field)                       \
-    do {                                                \
-        (to)->field += qatomic_read(&((from)->field));  \
-    } while (0)
-
-#define PROF_MAX(to, from, field)                                       \
-    do {                                                                \
-        typeof((from)->field) val__ = qatomic_read(&((from)->field));   \
-        if (val__ > (to)->field) {                                      \
-            (to)->field = val__;                                        \
-        }                                                               \
-    } while (0)
-
-/* Pass in a zero'ed @prof */
-static inline
-void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
-{
-    unsigned int n_ctxs = qatomic_read(&tcg_cur_ctxs);
-    unsigned int i;
-
-    for (i = 0; i < n_ctxs; i++) {
-        TCGContext *s = qatomic_read(&tcg_ctxs[i]);
-        const TCGProfile *orig = &s->prof;
-
-        if (counters) {
-            PROF_ADD(prof, orig, cpu_exec_time);
-            PROF_ADD(prof, orig, tb_count1);
-            PROF_ADD(prof, orig, tb_count);
-            PROF_ADD(prof, orig, op_count);
-            PROF_MAX(prof, orig, op_count_max);
-            PROF_ADD(prof, orig, temp_count);
-            PROF_MAX(prof, orig, temp_count_max);
-            PROF_ADD(prof, orig, del_op_count);
-            PROF_ADD(prof, orig, code_in_len);
-            PROF_ADD(prof, orig, code_out_len);
-            PROF_ADD(prof, orig, search_out_len);
-            PROF_ADD(prof, orig, interm_time);
-            PROF_ADD(prof, orig, code_time);
-            PROF_ADD(prof, orig, la_time);
-            PROF_ADD(prof, orig, opt_time);
-            PROF_ADD(prof, orig, restore_count);
-            PROF_ADD(prof, orig, restore_time);
-        }
-        if (table) {
-            int i;
-
-            for (i = 0; i < NB_OPS; i++) {
-                PROF_ADD(prof, orig, table_op_count[i]);
-            }
-        }
-    }
-}
-
-#undef PROF_ADD
-#undef PROF_MAX
-
-static void tcg_profile_snapshot_counters(TCGProfile *prof)
-{
-    tcg_profile_snapshot(prof, true, false);
-}
-
-static void tcg_profile_snapshot_table(TCGProfile *prof)
-{
-    tcg_profile_snapshot(prof, false, true);
-}
-
-void tcg_dump_op_count(GString *buf)
-{
-    TCGProfile prof = {};
-    int i;
-
-    tcg_profile_snapshot_table(&prof);
-    for (i = 0; i < NB_OPS; i++) {
-        g_string_append_printf(buf, "%s %" PRId64 "\n", tcg_op_defs[i].name,
-                               prof.table_op_count[i]);
-    }
-}
-
-int64_t tcg_cpu_exec_time(void)
-{
-    unsigned int n_ctxs = qatomic_read(&tcg_cur_ctxs);
-    unsigned int i;
-    int64_t ret = 0;
-
-    for (i = 0; i < n_ctxs; i++) {
-        const TCGContext *s = qatomic_read(&tcg_ctxs[i]);
-        const TCGProfile *prof = &s->prof;
-
-        ret += qatomic_read(&prof->cpu_exec_time);
-    }
-    return ret;
-}
-#else
 void tcg_dump_op_count(GString *buf)
 {
     g_string_append_printf(buf, "[TCG profiler not compiled]\n");
@@ -5962,37 +5862,12 @@ int64_t tcg_cpu_exec_time(void)
     error_report("%s: TCG profiler not compiled", __func__);
     exit(EXIT_FAILURE);
 }
-#endif
-
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 {
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &s->prof;
-#endif
     int i, num_insns;
     TCGOp *op;
 
-#ifdef CONFIG_PROFILER
-    {
-        int n = 0;
-
-        QTAILQ_FOREACH(op, &s->ops, link) {
-            n++;
-        }
-        qatomic_set(&prof->op_count, prof->op_count + n);
-        if (n > prof->op_count_max) {
-            qatomic_set(&prof->op_count_max, n);
-        }
-
-        n = s->nb_temps;
-        qatomic_set(&prof->temp_count, prof->temp_count + n);
-        if (n > prof->temp_count_max) {
-            qatomic_set(&prof->temp_count_max, n);
-        }
-    }
-#endif
-
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6021,17 +5896,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     }
 #endif
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
-#endif
-
     tcg_optimize(s);
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
-    qatomic_set(&prof->la_time, prof->la_time - profile_getclock());
-#endif
-
     reachable_code_pass(s);
     liveness_pass_0(s);
     liveness_pass_1(s);
@@ -6055,10 +5921,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         }
     }
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->la_time, prof->la_time + profile_getclock());
-#endif
-
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6097,10 +5959,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
 
-#ifdef CONFIG_PROFILER
-        qatomic_set(&prof->table_op_count[opc], prof->table_op_count[opc] + 1);
-#endif
-
         switch (opc) {
         case INDEX_op_mov_i32:
         case INDEX_op_mov_i64:
@@ -6195,76 +6053,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     return tcg_current_code_size(s);
 }
 
-#ifdef CONFIG_PROFILER
-void tcg_dump_info(GString *buf)
-{
-    TCGProfile prof = {};
-    const TCGProfile *s;
-    int64_t tb_count;
-    int64_t tb_div_count;
-    int64_t tot;
-
-    tcg_profile_snapshot_counters(&prof);
-    s = &prof;
-    tb_count = s->tb_count;
-    tb_div_count = tb_count ? tb_count : 1;
-    tot = s->interm_time + s->code_time;
-
-    g_string_append_printf(buf, "JIT cycles          %" PRId64
-                           " (%0.3f s at 2.4 GHz)\n",
-                           tot, tot / 2.4e9);
-    g_string_append_printf(buf, "translated TBs      %" PRId64
-                           " (aborted=%" PRId64 " %0.1f%%)\n",
-                           tb_count, s->tb_count1 - tb_count,
-                           (double)(s->tb_count1 - s->tb_count)
-                           / (s->tb_count1 ? s->tb_count1 : 1) * 100.0);
-    g_string_append_printf(buf, "avg ops/TB          %0.1f max=%d\n",
-                           (double)s->op_count / tb_div_count, s->op_count_max);
-    g_string_append_printf(buf, "deleted ops/TB      %0.2f\n",
-                           (double)s->del_op_count / tb_div_count);
-    g_string_append_printf(buf, "avg temps/TB        %0.2f max=%d\n",
-                           (double)s->temp_count / tb_div_count,
-                           s->temp_count_max);
-    g_string_append_printf(buf, "avg host code/TB    %0.1f\n",
-                           (double)s->code_out_len / tb_div_count);
-    g_string_append_printf(buf, "avg search data/TB  %0.1f\n",
-                           (double)s->search_out_len / tb_div_count);
-
-    g_string_append_printf(buf, "cycles/op           %0.1f\n",
-                           s->op_count ? (double)tot / s->op_count : 0);
-    g_string_append_printf(buf, "cycles/in byte      %0.1f\n",
-                           s->code_in_len ? (double)tot / s->code_in_len : 0);
-    g_string_append_printf(buf, "cycles/out byte     %0.1f\n",
-                           s->code_out_len ? (double)tot / s->code_out_len : 0);
-    g_string_append_printf(buf, "cycles/search byte     %0.1f\n",
-                           s->search_out_len ?
-                           (double)tot / s->search_out_len : 0);
-    if (tot == 0) {
-        tot = 1;
-    }
-    g_string_append_printf(buf, "  gen_interm time   %0.1f%%\n",
-                           (double)s->interm_time / tot * 100.0);
-    g_string_append_printf(buf, "  gen_code time     %0.1f%%\n",
-                           (double)s->code_time / tot * 100.0);
-    g_string_append_printf(buf, "optim./code time    %0.1f%%\n",
-                           (double)s->opt_time / (s->code_time ?
-                                                  s->code_time : 1)
-                           * 100.0);
-    g_string_append_printf(buf, "liveness/code time  %0.1f%%\n",
-                           (double)s->la_time / (s->code_time ?
-                                                 s->code_time : 1) * 100.0);
-    g_string_append_printf(buf, "cpu_restore count   %" PRId64 "\n",
-                           s->restore_count);
-    g_string_append_printf(buf, "  avg cycles        %0.1f\n",
-                           s->restore_count ?
-                           (double)s->restore_time / s->restore_count : 0);
-}
-#else
 void tcg_dump_info(GString *buf)
 {
     g_string_append_printf(buf, "[TCG profiler not compiled]\n");
 }
-#endif
 
 #ifdef ELF_HOST_MACHINE
 /* In order to use this feature, the backend needs to do three things:
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index a58de48d2a..73a670e8fa 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -46,9 +46,6 @@ static int query_error_class(const char *cmd)
         { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
         { "query-hotpluggable-cpus", ERROR_CLASS_GENERIC_ERROR },
         { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
-#ifndef CONFIG_PROFILER
-        { "x-query-profile", ERROR_CLASS_GENERIC_ERROR },
-#endif
         /* Only valid with a USB bus added */
         { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
         /* Only valid with accel=tcg */
-- 
2.25.1


