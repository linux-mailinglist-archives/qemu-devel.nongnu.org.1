Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8172F1A5
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FD9-0006Li-GM; Tue, 13 Jun 2023 21:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCp-0005kC-Fu
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:56 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCn-0004gM-DQ
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-655fce0f354so4824880b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705708; x=1689297708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTZQx+1x1pZieYls3VrgE8Pox7PQlrNB2T1Nc6XL9Dc=;
 b=Ensb3hRYutyOJmqU9hNsZ2Vhd31/tdwEB11sISxrmFtD4wrwd8P+nrF2pMDzjV5gjS
 ADeZUO0KdOkIPXQvUNI5lxlF+EHzFuD/Qq8NkJba+iJ0BtI6NGW6oAYm7hn9ca6SnrpH
 FDywMpoBog9Bs1pJjWYInF7U8mCaJcLhUfUWHh31SCorqtFGxm8QBzjMLSkvtbE0HlAF
 ozYg6oe6RKUZ5xsmn1SCPrRaSaTBQsFd4GywnAlouNlWM3k3fIVF/bKuUxK+mpLfolRc
 Nh/DK7JbXbMxfAe0d6TTSnIL+doQUhVaG9ceRUOf8QrOay4i2T0aXeU2WtzxPBaCWYb9
 kaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705708; x=1689297708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTZQx+1x1pZieYls3VrgE8Pox7PQlrNB2T1Nc6XL9Dc=;
 b=Mwuvd54oBRKpp3XOoC8KTJ8/xhTOscJY4Y4N3GIwER2n9VHz6J7ILm5O61eKkX1V/W
 36yCTrEi3V33XbqI2a1dgQZmU2N8pMGT+FbHP5IxowlvX0/OXxqfVSnpUYmIkjcs95JB
 lNUY0A8ulD1Sa5WGVi7L730tDkIK3PxZuguSBgu1owSc3fzYmcVoTkm3g8W4T5OROqPJ
 hDSbk0mo49bTYReBWBS2jrLmc/jE1+6sbSVU2gcj6gBVPb4WB5mps+pQ9j9xsNCYDfRE
 B3c3xAkh8WmI7z2HJ0Wi16I+NbaQFwiZHjDwOfUNemXmx3CZjcso6UcTUPzZMJSDm7YN
 HIxw==
X-Gm-Message-State: AC+VfDybKdm83SEnwuFFus/EOGmAh28wjEbAWzKia5ZFQUBKeYN1i/Nu
 WUO3ziE5D7dhzmwORgHrXsgUe/Fi6qfGkg==
X-Google-Smtp-Source: ACHHUZ5iI9y55gWu0Xj9fFmWCAOlrxOtY5m3ZMoPU2n3jH4jmtez9xMHzT6OOg7jUbNwZvUtTu9Mhw==
X-Received: by 2002:a05:6a00:13a6:b0:662:3964:ee2f with SMTP id
 t38-20020a056a0013a600b006623964ee2fmr515690pfg.18.1686705707779; 
 Tue, 13 Jun 2023 18:21:47 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/60] target/riscv: Make RLB/MML/MMWP bits writable only when
 Smepmp is enabled
Date: Wed, 14 Jun 2023 11:19:35 +1000
Message-Id: <20230614012017.3100663-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

RLB/MML/MMWP bits in mseccfg CSR are introduced by Smepmp extension.
So they can only be writable and set to 1s when cfg.epmp is true.
Then we also need't check on epmp in pmp_hart_has_privs_default().

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-6-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 50 ++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 0684047b86..9a6e04cda0 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -243,30 +243,28 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, target_ulong addr,
 {
     bool ret;
 
-    if (riscv_cpu_cfg(env)->epmp) {
-        if (MSECCFG_MMWP_ISSET(env)) {
-            /*
-             * The Machine Mode Whitelist Policy (mseccfg.MMWP) is set
-             * so we default to deny all, even for M-mode.
-             */
+    if (MSECCFG_MMWP_ISSET(env)) {
+        /*
+         * The Machine Mode Whitelist Policy (mseccfg.MMWP) is set
+         * so we default to deny all, even for M-mode.
+         */
+        *allowed_privs = 0;
+        return false;
+    } else if (MSECCFG_MML_ISSET(env)) {
+        /*
+         * The Machine Mode Lockdown (mseccfg.MML) bit is set
+         * so we can only execute code in M-mode with an applicable
+         * rule. Other modes are disabled.
+         */
+        if (mode == PRV_M && !(privs & PMP_EXEC)) {
+            ret = true;
+            *allowed_privs = PMP_READ | PMP_WRITE;
+        } else {
+            ret = false;
             *allowed_privs = 0;
-            return false;
-        } else if (MSECCFG_MML_ISSET(env)) {
-            /*
-             * The Machine Mode Lockdown (mseccfg.MML) bit is set
-             * so we can only execute code in M-mode with an applicable
-             * rule. Other modes are disabled.
-             */
-            if (mode == PRV_M && !(privs & PMP_EXEC)) {
-                ret = true;
-                *allowed_privs = PMP_READ | PMP_WRITE;
-            } else {
-                ret = false;
-                *allowed_privs = 0;
-            }
-
-            return ret;
         }
+
+        return ret;
     }
 
     if (!riscv_cpu_cfg(env)->pmp || (mode == PRV_M)) {
@@ -580,8 +578,12 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
         }
     }
 
-    /* Sticky bits */
-    val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
+    if (riscv_cpu_cfg(env)->epmp) {
+        /* Sticky bits */
+        val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
+    } else {
+        val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
+    }
 
     env->mseccfg = val;
 }
-- 
2.40.1


