Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFC7D66DE
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaGH-0007EP-FC; Wed, 25 Oct 2023 05:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaGF-00072i-75
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:33:11 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaGD-0002WK-6L
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:33:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so35875485ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698226388; x=1698831188;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+QyMRpoF2P9v4uLl2dBxK8RnwHGNaAXLitnhk9wjEE=;
 b=iWEzl28H52aBWAmjrNaTmSZYpTZq/KeIuqgdXggLeXu0s/7ssY6W1PpxsI6sxFVeCQ
 zwuDWuBkwtfKoqwq9L/+QJJaJZ551zJTDUJ52X7JaSBjldSlWzKPNUYOw+23cvarIDnf
 uu1XyLHA6IyXmPeNwjZk5MscBJxJAJQPTetKmxe2SKvLSkvWhX6me+OToNFf+pFn/0a4
 OnWCUwB8VT+5a03KHdgpwfm5uZARNbbMv5maRDOn4NT6Jzl6HwRfPAAbiFAHjGgY2U9V
 NA19AX957Qi6+TNxKzADXuEiSYHcBAro5yBPBovUos61hDZXIip+/yNmKkmsONQXQ1RV
 7UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226388; x=1698831188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+QyMRpoF2P9v4uLl2dBxK8RnwHGNaAXLitnhk9wjEE=;
 b=MCa+3hm/BQyTOcamuCvCr40PhogvRC9UXCqw9Nxikd+6c03slx7urbjDGySj+2QcTH
 ZLDxIntSbXmkT2euD6nX4FAuCsilAJscUgx5RKC0vKAe5ZzFBTsLE8gkCPyD4saRqVTh
 OwK1ZyKMtviA4r9hiYJgTTZ0GgINj6J3ajkqh+gtxFoTR5IDswJnJAjca1uE8uV6aS+h
 MtgTcKWPqGLBJbMbm4V/oUSnmyWn7/fCaXd1CUhcYb21Qlsqav8nMcB2JIQdvbq0ZSZc
 BumS9u5BaHXAC0IF8GpwRI5a/dMzrqqyajnufxZIId/b49OKZxZeFCvsNnxR0TPO5d7R
 tKgg==
X-Gm-Message-State: AOJu0YxAohPPvMG9aKGP2Vg5VK+/Sc09W+rw3ti8wqHGKxJfX9/1q7Vz
 FrCJPu+CTroROjFER2bOKNl6zQ==
X-Google-Smtp-Source: AGHT+IG/d7goE/EtUXk/NZt571vPi3fxs5JVCbov+XW/oB/ITnxwXkDURHpUN41a1kTDt+xiUwrIUA==
X-Received: by 2002:a17:902:e80f:b0:1c9:fdbf:296a with SMTP id
 u15-20020a170902e80f00b001c9fdbf296amr14946214plg.8.1698226387720; 
 Wed, 25 Oct 2023 02:33:07 -0700 (PDT)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 jb14-20020a170903258e00b001bc21222e34sm8765724plb.285.2023.10.25.02.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:33:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v16 16/18] plugins: Use different helpers when reading
 registers
Date: Wed, 25 Oct 2023 18:31:16 +0900
Message-ID: <20231025093128.33116-17-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093128.33116-1-akihiko.odaki@daynix.com>
References: <20231025093128.33116-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This avoids optimizations incompatible when reading registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 accel/tcg/plugin-helpers.h |  3 ++-
 include/qemu/plugin.h      |  1 +
 accel/tcg/plugin-gen.c     | 43 ++++++++++++++++++++++++++++++++++----
 plugins/api.c              | 12 +++++++++--
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
index 8e685e0654..11796436f3 100644
--- a/accel/tcg/plugin-helpers.h
+++ b/accel/tcg/plugin-helpers.h
@@ -1,4 +1,5 @@
 #ifdef CONFIG_PLUGIN
-DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, ptr)
+DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_wg, TCG_CALL_NO_WG | TCG_CALL_PLUGIN, void, i32, ptr)
+DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_rwg, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, ptr)
 DEF_HELPER_FLAGS_4(plugin_vcpu_mem_cb, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, i32, i64, ptr)
 #endif
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 7fdc3a4849..b0c5ac6829 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -73,6 +73,7 @@ enum plugin_dyn_cb_type {
 
 enum plugin_dyn_cb_subtype {
     PLUGIN_CB_REGULAR,
+    PLUGIN_CB_REGULAR_R,
     PLUGIN_CB_INLINE,
     PLUGIN_N_CB_SUBTYPES,
 };
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 78b331b251..b37ce7683e 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -79,6 +79,7 @@ enum plugin_gen_from {
 
 enum plugin_gen_cb {
     PLUGIN_GEN_CB_UDATA,
+    PLUGIN_GEN_CB_UDATA_R,
     PLUGIN_GEN_CB_INLINE,
     PLUGIN_GEN_CB_MEM,
     PLUGIN_GEN_ENABLE_MEM_HELPER,
@@ -90,7 +91,10 @@ enum plugin_gen_cb {
  * These helpers are stubs that get dynamically switched out for calls
  * direct to the plugin if they are subscribed to.
  */
-void HELPER(plugin_vcpu_udata_cb)(uint32_t cpu_index, void *udata)
+void HELPER(plugin_vcpu_udata_cb_no_wg)(uint32_t cpu_index, void *udata)
+{ }
+
+void HELPER(plugin_vcpu_udata_cb_no_rwg)(uint32_t cpu_index, void *udata)
 { }
 
 void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
@@ -98,7 +102,7 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
                                 void *userdata)
 { }
 
-static void gen_empty_udata_cb(void)
+static void gen_empty_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_ptr))
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_ptr udata = tcg_temp_ebb_new_ptr();
@@ -106,12 +110,22 @@ static void gen_empty_udata_cb(void)
     tcg_gen_movi_ptr(udata, 0);
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
+    gen_helper(cpu_index, udata);
 
     tcg_temp_free_ptr(udata);
     tcg_temp_free_i32(cpu_index);
 }
 
+static void gen_empty_udata_cb_no_wg(void)
+{
+    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
+}
+
+static void gen_empty_udata_cb_no_rwg(void)
+{
+    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
+}
+
 /*
  * For now we only support addi_i64.
  * When we support more ops, we can generate one empty inline cb for each.
@@ -192,7 +206,8 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
                     gen_empty_mem_helper);
         /* fall through */
     case PLUGIN_GEN_FROM_TB:
-        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
+        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
+        gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
         break;
     default:
@@ -588,6 +603,12 @@ static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
     inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR], begin_op);
 }
 
+static void plugin_gen_tb_udata_r(const struct qemu_plugin_tb *ptb,
+                                  TCGOp *begin_op)
+{
+    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR_R], begin_op);
+}
+
 static void plugin_gen_tb_inline(const struct qemu_plugin_tb *ptb,
                                  TCGOp *begin_op)
 {
@@ -602,6 +623,14 @@ static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
     inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], begin_op);
 }
 
+static void plugin_gen_insn_udata_r(const struct qemu_plugin_tb *ptb,
+                                    TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+
+    inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR_R], begin_op);
+}
+
 static void plugin_gen_insn_inline(const struct qemu_plugin_tb *ptb,
                                    TCGOp *begin_op, int insn_idx)
 {
@@ -721,6 +750,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_UDATA:
                     plugin_gen_tb_udata(plugin_tb, op);
                     break;
+                case PLUGIN_GEN_CB_UDATA_R:
+                    plugin_gen_tb_udata_r(plugin_tb, op);
+                    break;
                 case PLUGIN_GEN_CB_INLINE:
                     plugin_gen_tb_inline(plugin_tb, op);
                     break;
@@ -737,6 +769,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_UDATA:
                     plugin_gen_insn_udata(plugin_tb, op, insn_idx);
                     break;
+                case PLUGIN_GEN_CB_UDATA_R:
+                    plugin_gen_insn_udata_r(plugin_tb, op, insn_idx);
+                    break;
                 case PLUGIN_GEN_CB_INLINE:
                     plugin_gen_insn_inline(plugin_tb, op, insn_idx);
                     break;
diff --git a/plugins/api.c b/plugins/api.c
index 5521b0ad36..ac39cdea0b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -89,7 +89,11 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           void *udata)
 {
     if (!tb->mem_only) {
-        plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
+        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
+                    flags == QEMU_PLUGIN_CB_RW_REGS ?
+                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
+
+        plugin_register_dyn_cb__udata(&tb->cbs[index],
                                       cb, flags, udata);
     }
 }
@@ -109,7 +113,11 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             void *udata)
 {
     if (!insn->mem_only) {
-        plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR],
+        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
+                    flags == QEMU_PLUGIN_CB_RW_REGS ?
+                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
+
+        plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][index],
                                       cb, flags, udata);
     }
 }
-- 
2.42.0


