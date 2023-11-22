Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFDD7F3D76
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:39:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5fwZ-0002fW-EQ; Wed, 22 Nov 2023 00:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwX-0002f8-DM
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:33 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwV-0007AN-Rq
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:33 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc394f4cdfso47538345ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700631510; x=1701236310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiA82anXAb6GFv8v+4BJl2QNe9543bv58UGYFn8y2Jk=;
 b=Bciz533nJfIgOdaG8cXF9P4f8Ce/y9MoVyt26uHAqAh0LOz/TjLLSwRgGhqqWsauVy
 zTdRj1XxL4Je44qkw79KPmFiPeKLVHn+jv5lcZfW5dY526gIKWlXgMs/z4hDa7jPBLC5
 kCDTPF4cXdwjhx9+DyjV18+CiF2dgUmBn65WarVYfrLpQMykPXK0pkq7ZK+mgIoQwwpC
 2/ulEAZx/C9UyTjBscwP8Wx5JGouQEwoWRLiCUYzW/tbptmJfVAFN0eM8hHr4J5M1VLI
 pGfHwa3xELXlnMmDAWpowfAQiaP9Cqq6juQ+W9lOBI8jJbqsR+UjxHvuZyyD4D4iBY8I
 UDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700631510; x=1701236310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiA82anXAb6GFv8v+4BJl2QNe9543bv58UGYFn8y2Jk=;
 b=OS8FOIMhmfyxOOu2i/XQiu1zvaK2MlKctdp2CpRKUgBf0vn3TS6iHT0hd0Nf1Uv8Fg
 qHwuevfijFIjmKg9QwXqAv74VlaRwTFa2RpNYlIvh8XN0dZCmKxPsaKoT9+SLlL1bDIF
 uaXtQ+S7geYJt70B2CCNRyrQzapQhwOLrW0kvVGhKGPfbMOZUYjXPjRTAcf6dJ2JKQaZ
 6N/OjnBRUPt2eUrrBqBoTidpEZKb+N9dPAB9UHzVHhG7BlLx/Av88G9eScDqpG4o3Hi4
 /qAN2E2vjuVRyC9WOkWiwwpr4AqTtACmpzj0EFBaCj7baqB40963T1LZyJpLO+ZjGTn4
 0BXw==
X-Gm-Message-State: AOJu0YxJgehBoMlXMXfw0MoAWZxqRyMSccAySioTx4C7OT3a0qrZ+VMn
 L7zDi9SaCnLWHrKLE2nOM/JEdQl+gNUdNg==
X-Google-Smtp-Source: AGHT+IFk9skq27AH5cRDmyFKc+Ks94tA3ZOAN5bYWhBeu+U3nsDQEge4JCsNRiwMB/3aYtv6hwOv5w==
X-Received: by 2002:a17:902:7002:b0:1cc:29ef:df81 with SMTP id
 y2-20020a170902700200b001cc29efdf81mr1134765plk.41.1700631510050; 
 Tue, 21 Nov 2023 21:38:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001c0a4146961sm8923952plh.19.2023.11.21.21.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 21:38:29 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ivan Klokov <ivan.klokov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 5/6] target/riscv/cpu_helper.c: Invalid exception on MMU
 translation stage
Date: Wed, 22 Nov 2023 15:37:59 +1000
Message-ID: <20231122053800.1531799-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122053800.1531799-1-alistair.francis@wdc.com>
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

According to RISCV privileged spec sect. 5.3.2 Virtual Address Translation Process
access-fault exceptions may raise only after PMA/PMP check. Current implementation
generates an access-fault for mbare mode even if there were no PMA/PMP errors.
This patch removes the erroneous MMU mode check and generates an access-fault
exception based on the pmp_violation flag only.

Fixes: 1448689c7b ("target/riscv: Allow specifying MMU stage")

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231121071757.7178-2-ivan.klokov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b7af69de53..9ff0952e46 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1143,47 +1143,31 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 bool two_stage_indirect)
 {
     CPUState *cs = env_cpu(env);
-    int page_fault_exceptions, vm;
-    uint64_t stap_mode;
-
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        stap_mode = SATP32_MODE;
-    } else {
-        stap_mode = SATP64_MODE;
-    }
-
-    if (first_stage) {
-        vm = get_field(env->satp, stap_mode);
-    } else {
-        vm = get_field(env->hgatp, stap_mode);
-    }
-
-    page_fault_exceptions = vm != VM_1_10_MBARE && !pmp_violation;
 
     switch (access_type) {
     case MMU_INST_FETCH:
         if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
         } else {
-            cs->exception_index = page_fault_exceptions ?
-                RISCV_EXCP_INST_PAGE_FAULT : RISCV_EXCP_INST_ACCESS_FAULT;
+            cs->exception_index = pmp_violation ?
+                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
         }
         break;
     case MMU_DATA_LOAD:
         if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
-            cs->exception_index = page_fault_exceptions ?
-                RISCV_EXCP_LOAD_PAGE_FAULT : RISCV_EXCP_LOAD_ACCESS_FAULT;
+            cs->exception_index = pmp_violation ?
+                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
         }
         break;
     case MMU_DATA_STORE:
         if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
-            cs->exception_index = page_fault_exceptions ?
-                RISCV_EXCP_STORE_PAGE_FAULT :
-                RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+            cs->exception_index = pmp_violation ?
+                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
+                RISCV_EXCP_STORE_PAGE_FAULT;
         }
         break;
     default:
-- 
2.42.0


