Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE372F20C
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FD7-0005z9-E5; Tue, 13 Jun 2023 21:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCm-0005cR-E6
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCk-0004fz-J8
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-66643830ab3so232130b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705704; x=1689297704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoytVRM6SdDLLB9qFO/ThNu8nbAhc13XpFCg5V1u6dE=;
 b=AdYcpCDZbOoLH3ddRTlw7XB/b2T5kej/rzGB7XW/lS0JI0DGNW+kI1yBkW69FozwxN
 NdYgH43vXMGotL+V5c9c7BZ+x0WbqkT2MJAfTPWmkBnoy4c36KmY09z02UxVihhiRElh
 zKtJjsBxDJGpqLe02uDLrhdv8/NDMQxE48GCkA6FgXXtBM8EFTdyHfs/AfZrOewiEJ+W
 VIda3/Z8sYht9WhgfMJIlDINkLW83E2a7G8EjmJY1ktK7oJ/1RmG+wjHjxqvmcxVS61N
 0uoNvdT6AklnCQ8tl2qZepY+4cTb0zoTkaKY/H+dDzO8EDte52GN98yAEVu/bvAwYj/f
 0UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705704; x=1689297704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LoytVRM6SdDLLB9qFO/ThNu8nbAhc13XpFCg5V1u6dE=;
 b=OMmEoi4btEKcAqzfxUBql3jSbbyI1ARjozeWki+LCNX740P4rWqP8SOAYQ/kYKobmF
 zOhU3Y1LX5psAcsjFmZ8XqazbIeTg1h0+VbXqiSWV/OfKu7pTQwGZtgaZ8NoEQA+8qIQ
 itgKBiuf8mHTW7yk3VL4ly2x+z42s8hWasL/YXXboq5KGpoH01qtSVsjFbbwkKLqBEcO
 KKSNVaYOOGpZJMxQa91i0yPYWFUPRu44LKGHD81yKjl55cKQvgD1C236Ht5c5DV4j2e/
 hML+rZbIvctnwAVjHSi16rQIVOE9Qm99bmhDyrvkT4Xf523RC5P1RfvJ/IuBJOn1+gix
 /ooA==
X-Gm-Message-State: AC+VfDxRDqU2uXmop0NCwsWaunlpzyL6GwkqYAekp7QUuae60iPIgwfK
 RQfatTqCtY401NGDljV+I1JlMVj/s/8Gzg==
X-Google-Smtp-Source: ACHHUZ7SapA/yvMKp24KTNpI8tDQ/Nx9v/fr76Srzdfy+7e/upgegTuImiUq6ySvugGATfXe4Mkxgw==
X-Received: by 2002:a05:6a00:194a:b0:654:ab4:305 with SMTP id
 s10-20020a056a00194a00b006540ab40305mr846767pfk.2.1686705704366; 
 Tue, 13 Jun 2023 18:21:44 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:43 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/60] target/riscv: Change the return type of
 pmp_hart_has_privs() to bool
Date: Wed, 14 Jun 2023 11:19:34 +1000
Message-Id: <20230614012017.3100663-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

We no longer need the pmp_index for matched PMP entry now.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-5-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.h        |  8 ++++----
 target/riscv/cpu_helper.c |  8 ++++----
 target/riscv/pmp.c        | 32 +++++++++++++-------------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 0a7e24750b..cf5c99f8e6 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -72,10 +72,10 @@ target_ulong mseccfg_csr_read(CPURISCVState *env);
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
-int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
-                       target_ulong size, pmp_priv_t privs,
-                       pmp_priv_t *allowed_privs,
-                       target_ulong mode);
+bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
+                        target_ulong size, pmp_priv_t privs,
+                        pmp_priv_t *allowed_privs,
+                        target_ulong mode);
 target_ulong pmp_get_tlb_size(CPURISCVState *env, target_ulong addr);
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 52d0b043df..35ddd0caac 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -697,16 +697,16 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
                                     int mode)
 {
     pmp_priv_t pmp_priv;
-    int pmp_index = -1;
+    bool pmp_has_privs;
 
     if (!riscv_cpu_cfg(env)->pmp) {
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return TRANSLATE_SUCCESS;
     }
 
-    pmp_index = pmp_hart_has_privs(env, addr, size, 1 << access_type,
-                                   &pmp_priv, mode);
-    if (pmp_index < 0) {
+    pmp_has_privs = pmp_hart_has_privs(env, addr, size, 1 << access_type,
+                                       &pmp_priv, mode);
+    if (!pmp_has_privs) {
         *prot = 0;
         return TRANSLATE_PMP_FAIL;
     }
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3c90562d55..0684047b86 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -296,27 +296,23 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, target_ulong addr,
 
 /*
  * Check if the address has required RWX privs to complete desired operation
- * Return PMP rule index if a pmp rule match
- * Return MAX_RISCV_PMPS if default match
- * Return negtive value if no match
+ * Return true if a pmp rule match or default match
+ * Return false if no match
  */
-int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
-                       target_ulong size, pmp_priv_t privs,
-                       pmp_priv_t *allowed_privs, target_ulong mode)
+bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
+                        target_ulong size, pmp_priv_t privs,
+                        pmp_priv_t *allowed_privs, target_ulong mode)
 {
     int i = 0;
-    int ret = -1;
+    bool ret = false;
     int pmp_size = 0;
     target_ulong s = 0;
     target_ulong e = 0;
 
     /* Short cut if no rules */
     if (0 == pmp_get_num_rules(env)) {
-        if (pmp_hart_has_privs_default(env, addr, size, privs,
-                                       allowed_privs, mode)) {
-            ret = MAX_RISCV_PMPS;
-        }
-        return ret;
+        return pmp_hart_has_privs_default(env, addr, size, privs,
+                                          allowed_privs, mode);
     }
 
     if (size == 0) {
@@ -345,7 +341,7 @@ int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         if ((s + e) == 1) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "pmp violation - access is partially inside\n");
-            ret = -1;
+            ret = false;
             break;
         }
 
@@ -453,17 +449,15 @@ int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
              * defined with PMP must be used. We shouldn't fallback on
              * finding default privileges.
              */
-            ret = i;
+            ret = true;
             break;
         }
     }
 
     /* No rule matched */
-    if (ret == -1) {
-        if (pmp_hart_has_privs_default(env, addr, size, privs,
-                                       allowed_privs, mode)) {
-            ret = MAX_RISCV_PMPS;
-        }
+    if (!ret) {
+        ret = pmp_hart_has_privs_default(env, addr, size, privs,
+                                         allowed_privs, mode);
     }
 
     return ret;
-- 
2.40.1


