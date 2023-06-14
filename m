Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6724272F1EB
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FD8-0006EA-Nv; Tue, 13 Jun 2023 21:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCz-0005yE-J0
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:03 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCx-0004hS-Tr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:01 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-75b14216386so147024385a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705719; x=1689297719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCZE+laJ3hlR96Fn3PkdeaFvGqGJtZJXcAaXUjNGoK4=;
 b=mpAqkSeBSLy9P2S3hffDuU8492cM4A++aB0g87kZM6YpI+Xshm5pyS95kez3FOXD82
 S/DOym/Iv9Dq1NaJJJT81zdPc6EVEXkwFBf1YQ4rKi6JSQY3pQdk3rowEkImDCEWl1pY
 PRJidZdqQXwreqAtMKOw8/NuUZ/iBZHjX+v3giPPCeTwqfQqWCvgr7AWXCmCyHABer7j
 6z14v/dCukk0NMvyl7K8zYgEOEZMZicSZdIVLmgjWXP6RObgB4bAAhlhp7XvZxaI9vlA
 /Jb89sD8iP6RhAaB9wwpCrDu3jYhJfz+/JHDid+rhSZFTk3OGeiMxhYFn0wHMYVqb+mj
 pcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705719; x=1689297719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCZE+laJ3hlR96Fn3PkdeaFvGqGJtZJXcAaXUjNGoK4=;
 b=YpO3eR6lLX8w2SLxhLfoagapgh//XBtqa6kjbfn97InizBuE5288HaZwzmgB92db6r
 wiJrtEAmJzn03/xF7XtVy0ODLzOYR76GK+UZtlEYtLrX3ozAh0IesRXjbPor954xExN3
 tnHvvAQSMbfpb96Y21avAv+BtUv3rJgkkwm3m+yhPhG5E9Ao3XfBYzmCAiIJOnlVrpWI
 NBzaWM0WXhyuuBWXWomy9sN2rWCOcxhbLwYCMUi/swN+ajj8d3vrpqQ6shIk3gV9d/TU
 9glqmJISQWyv1ahMbdOUF1cptzBR+ykS4wdh8Llk+Fi5aqmavyg+b3dHfDFR/n9Ls7t1
 ACKA==
X-Gm-Message-State: AC+VfDz9Rv5Kz8eQ+fFg1nmvZDnBLhXs9DCzfXe5U/GenwXMwrjcZmPy
 vILugZgtpX53qG618foskRtTXmD4x0Kq2Q==
X-Google-Smtp-Source: ACHHUZ4H+/3Plw/ZdakrPRHlXx9EOI6uwlNtfJGLVCaJWeK4PjpKp2cocMojkwjRw2oZ+jagoVnCrg==
X-Received: by 2002:a05:620a:4d91:b0:75f:7199:4004 with SMTP id
 uw17-20020a05620a4d9100b0075f71994004mr10298817qkn.15.1686705718893; 
 Tue, 13 Jun 2023 18:21:58 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/60] target/riscv: Update the next rule addr in
 pmpaddr_csr_write()
Date: Wed, 14 Jun 2023 11:19:38 +1000
Message-Id: <20230614012017.3100663-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x733.google.com
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

Currently only the rule addr of the same index of pmpaddr is updated
when pmpaddr CSR is modified. However, the rule addr of next PMP entry
may also be affected if its A field is PMP_AMATCH_TOR. So we should
also update it in this case.

Write to pmpaddr CSR will not affect the rule nums, So we needn't update
call pmp_update_rule_nums()  in pmpaddr_csr_write().

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-9-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 4d62dfc732..48a3e44a77 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -507,6 +507,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val)
 {
     trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
+    bool is_next_cfg_tor = false;
 
     if (addr_index < MAX_RISCV_PMPS) {
         /*
@@ -515,9 +516,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
          */
         if (addr_index + 1 < MAX_RISCV_PMPS) {
             uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
+            is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
 
-            if (pmp_cfg & PMP_LOCK &&
-                PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg)) {
+            if (pmp_cfg & PMP_LOCK && is_next_cfg_tor) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "ignoring pmpaddr write - pmpcfg + 1 locked\n");
                 return;
@@ -526,7 +527,10 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 
         if (!pmp_is_locked(env, addr_index)) {
             env->pmp_state.pmp[addr_index].addr_reg = val;
-            pmp_update_rule(env, addr_index);
+            pmp_update_rule_addr(env, addr_index);
+            if (is_next_cfg_tor) {
+                pmp_update_rule_addr(env, addr_index + 1);
+            }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpaddr write - locked\n");
-- 
2.40.1


