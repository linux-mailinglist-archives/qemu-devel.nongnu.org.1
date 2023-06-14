Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14772F1AF
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FCf-0005X7-JZ; Tue, 13 Jun 2023 21:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCe-0005Wj-G8
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCc-0004fR-PL
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-665a18f5643so1802896b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705697; x=1689297697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8T3G3gsoC6zwG1Ido0iRgV/LB4XR7JdgXKT9l3Z69yw=;
 b=WzBCL2jmiPJ8K/gOMJ5RquD+/SpFTgWCz2coJ/kPDT/vI/JkZ0+EC+yPSf+BnSlv4T
 roI2Po1KVbx3Qxz8QxPpFJ+s1aJTotSg1sItYnoUyH3FXUoxxG3naTjcIzuocxS16817
 HkvWLt1xQy1cWU0H94zs9cuuD1NZc8pgkEEuhlSelM2URIghKn1u1W4jY++J+tsP47FD
 4bhtWfz+k4tBizK9wXAlHctWAPotXgEAIgL6jBDwCUhyRPtbNCHU3HSAewa1taJ4o8ls
 Py2u7Uw/auW8yqrfuYHZ1GXFOPavzTqBUJ7fDU+G2g+wSf/ZpiPYORXTpYItQXnOv6NJ
 91aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705697; x=1689297697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8T3G3gsoC6zwG1Ido0iRgV/LB4XR7JdgXKT9l3Z69yw=;
 b=A8716GPFgtrQPWQOwkVI1ILzF56UKaSYQqbzKGR1SciNdhGoBnMPdtWWOW6Wl9wBmI
 MLd6Evrk+iKqwt6f4xpOAiOgfkPqBhDJttoT0Ou0B621RWOanlY/7EM2b252aiUZe5Eu
 xAqQ6nAAeeeTdPQI0LHuo7AeZzLJqpwIfFNDowlZwYjc59cpZY9r2kH+e6ULRWyybuXW
 BJougXe+51eVLShd76Ht9ny33UnMcrNZRB7Hl1hNyA6r7VrEmNyB+Y6TEvKcq6I3OwGp
 yxJ15R14/S7yvjMxSMHSjNDNMXdJBi/sXZx7QsimZcYkyuW+XTKRMJV8wBYqu/8DI6Mu
 surw==
X-Gm-Message-State: AC+VfDxuS2jbUUThKYRoJeCK1zXr4SJuw86tv5osfLXCi1dG8/oHYfYT
 P3DeWT0tarG1KwGBm12kPd4MVmRKWRQTng==
X-Google-Smtp-Source: ACHHUZ5FkdTRbd7of/AJnaLlXkLyG3E05L02G+DaoHjXE2MH7BdXdB0OLeZuZ+ASV6AjqUEpN6diNQ==
X-Received: by 2002:a05:6a00:2994:b0:662:9bf:7572 with SMTP id
 cj20-20020a056a00299400b0066209bf7572mr338355pfb.0.1686705696787; 
 Tue, 13 Jun 2023 18:21:36 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/60] target/riscv: Move pmp_get_tlb_size apart from
 get_physical_address_pmp
Date: Wed, 14 Jun 2023 11:19:32 +1000
Message-Id: <20230614012017.3100663-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

pmp_get_tlb_size can be separated from get_physical_address_pmp and is only
needed when ret == TRANSLATE_SUCCESS.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-3-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 065b433b88..52d0b043df 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -688,14 +688,11 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  *
  * @env: CPURISCVState
  * @prot: The returned protection attributes
- * @tlb_size: TLB page size containing addr. It could be modified after PMP
- *            permission checking. NULL if not set TLB page for addr.
  * @addr: The physical address to be checked permission
  * @access_type: The type of MMU access
  * @mode: Indicates current privilege level.
  */
-static int get_physical_address_pmp(CPURISCVState *env, int *prot,
-                                    target_ulong *tlb_size, hwaddr addr,
+static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
                                     int size, MMUAccessType access_type,
                                     int mode)
 {
@@ -715,9 +712,6 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot,
     }
 
     *prot = pmp_priv_to_page_prot(pmp_priv);
-    if (tlb_size != NULL) {
-        *tlb_size = pmp_get_tlb_size(env, addr);
-    }
 
     return TRANSLATE_SUCCESS;
 }
@@ -906,7 +900,7 @@ restart:
         }
 
         int pmp_prot;
-        int pmp_ret = get_physical_address_pmp(env, &pmp_prot, NULL, pte_addr,
+        int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                                sizeof(target_ulong),
                                                MMU_DATA_LOAD, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
@@ -1302,8 +1296,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             prot &= prot2;
 
             if (ret == TRANSLATE_SUCCESS) {
-                ret = get_physical_address_pmp(env, &prot_pmp, &tlb_size, pa,
+                ret = get_physical_address_pmp(env, &prot_pmp, pa,
                                                size, access_type, mode);
+                tlb_size = pmp_get_tlb_size(env, pa);
 
                 qemu_log_mask(CPU_LOG_MMU,
                               "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
@@ -1335,8 +1330,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
 
         if (ret == TRANSLATE_SUCCESS) {
-            ret = get_physical_address_pmp(env, &prot_pmp, &tlb_size, pa,
+            ret = get_physical_address_pmp(env, &prot_pmp, pa,
                                            size, access_type, mode);
+            tlb_size = pmp_get_tlb_size(env, pa);
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-- 
2.40.1


