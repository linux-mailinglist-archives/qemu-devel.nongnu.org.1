Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81673E3C4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoL7-0001kJ-8S; Mon, 26 Jun 2023 11:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJx-0000KQ-CK
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJp-0002rJ-0T
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-311099fac92so4749284f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793995; x=1690385995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+aVWP+CAtLL2j3nJ0aiawnmHOpp3zcbopr65NkD4ZQ=;
 b=rpMWiqKE/LmJrmX4VuK7InbL1AJZAvtRVP/ZsMhlqi23H2HDSVLW1HdksXlZWyO35t
 J/aF+TRL5muUdeTaigQ0TTpbekk1uiivn0jmN+QhQhivLz1sHSNG+dsPusc3BsBeRt1o
 +qvmf4ny/NqicTCvfA8ch0NkmffqXZgdm4+6qcIFxZ3+mDM/jV3G1f3wSvWPcwTzZ2iv
 3o6smZlc0FfgissJgfHbE3vRyDnUZOHuQGx2R2ua+NSkTlzz5cd5yYT8+fxbclEEBFN/
 WPClCeDjQ+av0kfpNFRIpk6EyvrF8W3faZW8hbHrmPqn4oEmusUVk/35H3pFNaLYVdUj
 f4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793995; x=1690385995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+aVWP+CAtLL2j3nJ0aiawnmHOpp3zcbopr65NkD4ZQ=;
 b=hJPpHFeIofCQD9rb48yTFMWc6PbUttz156cO73pdq+0XTVaFy6W9JOw9wUw2qEKWyK
 j5/ZhrswTG4GIcwoeDEhHzaGDNCtRHrY34lGlNCUt1qtyGQ4H/tHqulpdMKQm+7Wu0Hv
 s/60PTlBD9l4Ap5+CuoUj0IZNy4Y6uqm9oUFTJvRu9U6BFNo+zPHr+tHJImWHJCFMNIf
 v9MqhdIj+wxbQKfZtex9eeqZl1c1IbW8KybYfxQlHpTwyDUWPSl7khCtRD6GI1LqLwgf
 7dKivwJRMtLVLhOc1MZ3srvEzlfvURvyV5DrZ4/wRXmgEn+L0nYXIpBUtSATbyxaEjZo
 bLfQ==
X-Gm-Message-State: AC+VfDzr2cqcbPdubgqDWlzXPgUS1H6Uundai0w3D7ZxaLbHZbzA4l2N
 MCh9pcxrhFrey9cusWV+6h7byw7abKK23cfiTZr8/u8g
X-Google-Smtp-Source: ACHHUZ6fs8P76TmZhzUFYG0PecVkVhntyRAh+0ueC9wmwodFuxSNxbm6Vnwy5+BTg21JKtCp8Fglfg==
X-Received: by 2002:adf:fa06:0:b0:311:15e3:e09d with SMTP id
 m6-20020adffa06000000b0031115e3e09dmr25604549wrr.36.1687793995352; 
 Mon, 26 Jun 2023 08:39:55 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 14/22] accel/tcg: remove CONFIG_PROFILER
Date: Mon, 26 Jun 2023 17:39:37 +0200
Message-Id: <20230626153945.76180-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fei Wu <fei2.wu@intel.com>

TBStats will be introduced to replace CONFIG_PROFILER totally, here
remove all CONFIG_PROFILER related stuffs first.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230607122411.3394702-2-fei2.wu@intel.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build                   |   2 -
 qapi/machine.json             |  18 ---
 include/qemu/timer.h          |   9 --
 include/tcg/tcg.h             |  26 -----
 accel/tcg/monitor.c           |  31 -----
 accel/tcg/tcg-accel-ops.c     |  10 --
 accel/tcg/translate-all.c     |  33 ------
 softmmu/runstate.c            |   9 --
 tcg/tcg.c                     | 214 ----------------------------------
 tests/qtest/qmp-cmd-test.c    |   3 -
 hmp-commands-info.hx          |  15 ---
 meson_options.txt             |   2 -
 scripts/meson-buildoptions.sh |   3 -
 13 files changed, 375 deletions(-)

diff --git a/meson.build b/meson.build
index 3e3d38badb..b409788832 100644
--- a/meson.build
+++ b/meson.build
@@ -2121,7 +2121,6 @@ if numa.found()
                                        dependencies: numa))
 endif
 config_host_data.set('CONFIG_OPENGL', opengl.found())
-config_host_data.set('CONFIG_PROFILER', get_option('profiler'))
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
@@ -4087,7 +4086,6 @@ if 'objc' in all_languages
   summary_info += {'QEMU_OBJCFLAGS':    ' '.join(qemu_common_flags)}
 endif
 summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
-summary_info += {'profiler':          get_option('profiler')}
 summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
 summary_info += {'PIE':               get_option('b_pie')}
 summary_info += {'static build':      get_option('prefer_static')}
diff --git a/qapi/machine.json b/qapi/machine.json
index 37660d8f2a..a08b6576ca 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1575,24 +1575,6 @@
   'if': 'CONFIG_TCG',
   'features': [ 'unstable' ] }
 
-##
-# @x-query-profile:
-#
-# Query TCG profiling information
-#
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
-# Returns: profile information
-#
-# Since: 6.2
-##
-{ 'command': 'x-query-profile',
-  'returns': 'HumanReadableText',
-  'if': 'CONFIG_TCG',
-  'features': [ 'unstable' ] }
-
 ##
 # @x-query-ramblock:
 #
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
index a498f31967..95541e9474 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -478,27 +478,6 @@ static inline TCGRegSet output_pref(const TCGOp *op, unsigned i)
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
@@ -528,10 +507,6 @@ struct TCGContext {
     tcg_insn_unit *code_buf;      /* pointer for start of tb */
     tcg_insn_unit *code_ptr;      /* pointer for running end of tb */
 
-#ifdef CONFIG_PROFILER
-    TCGProfile prof;
-#endif
-
 #ifdef CONFIG_DEBUG_TCG
     int goto_tb_issue_mask;
     const TCGOpcode *vecop_list;
@@ -871,7 +846,6 @@ static inline TCGv_ptr tcg_temp_new_ptr(void)
     return temp_tcgv_ptr(t);
 }
 
-int64_t tcg_cpu_exec_time(void);
 void tcg_dump_info(GString *buf);
 void tcg_dump_op_count(GString *buf);
 
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index f171bc6f5e..d48de23999 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -81,37 +81,6 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
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
-HumanReadableText *qmp_x_query_profile(Error **errp)
-{
-    error_setg(errp, "Internal profiler not compiled");
-    return NULL;
-}
-#endif
-
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
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
index 03c49baf1c..d3d4fbc1a4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -202,10 +202,6 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc)
 {
     uint64_t data[TARGET_INSN_START_WORDS];
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &tcg_ctx->prof;
-    int64_t ti = profile_getclock();
-#endif
     int insns_left = cpu_unwind_data_from_tb(tb, host_pc, data);
 
     if (insns_left < 0) {
@@ -222,12 +218,6 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
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
@@ -290,13 +280,6 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
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
 
@@ -310,9 +293,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_page_addr_t phys_pc;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &tcg_ctx->prof;
-#endif
     int64_t ti;
     void *host_pc;
 
@@ -371,12 +351,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
  tb_overflow:
 
-#ifdef CONFIG_PROFILER
-    /* includes aborted translations because of exceptions */
-    qatomic_set(&prof->tb_count1, prof->tb_count1 + 1);
-    ti = profile_getclock();
-#endif
-
     trace_translate_block(tb, pc, tb->tc.ptr);
 
     gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
@@ -431,13 +405,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 1957caf73f..a9fbcf4862 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -727,18 +727,9 @@ static bool main_loop_should_exit(int *status)
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
index 3fcd0d9f32..a0628fe424 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3033,10 +3033,6 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
-
-#ifdef CONFIG_PROFILER
-    qatomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
-#endif
 }
 
 void tcg_remove_ops_after(TCGOp *op)
@@ -5906,143 +5902,16 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
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
 }
 
-int64_t tcg_cpu_exec_time(void)
-{
-    error_report("%s: TCG profiler not compiled", __func__);
-    exit(EXIT_FAILURE);
-}
-#endif
-
-
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 {
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &s->prof;
-#endif
     int i, start_words, num_insns;
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
@@ -6071,17 +5940,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
@@ -6105,10 +5965,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         }
     }
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->la_time, prof->la_time + profile_getclock());
-#endif
-
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6151,10 +6007,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
 
-#ifdef CONFIG_PROFILER
-        qatomic_set(&prof->table_op_count[opc], prof->table_op_count[opc] + 1);
-#endif
-
         switch (opc) {
         case INDEX_op_mov_i32:
         case INDEX_op_mov_i64:
@@ -6249,76 +6101,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 47d63d26db..f5b37eb74a 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -360,21 +360,6 @@ SRST
     Show host USB devices.
 ERST
 
-#if defined(CONFIG_TCG)
-    {
-        .name       = "profile",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show profiling information",
-        .cmd_info_hrt = qmp_x_query_profile,
-    },
-#endif
-
-SRST
-  ``info profile``
-    Show profiling information.
-ERST
-
     {
         .name       = "capture",
         .args_type  = "",
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
-- 
2.34.1


