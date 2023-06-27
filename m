Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F273FCE2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8nh-0008JV-GV; Tue, 27 Jun 2023 09:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qE3SR-0002px-Hg
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:49:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qE3SP-0006Aa-VN
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:49:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b7f68f1c9eso21224935ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687852188; x=1690444188;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9EpieEvbwRuonLUO4ZFLZ77OR4kXPqxojCQI1x4UU4=;
 b=aP9L6RdMnqgJU8Fw7Ig8f4ynFw8Kcn5UIgz8vI0/uMQHvlJP0CCWwRnRZkA08/4rhW
 xm1k3OnUhRpqpUMAmMBD3fHX5U7Cm4o7BXcaer2MVchV2fZTSDJ32tKYZeck+coUrdyA
 +KDz+S3qWRwe0RoN1J7chN7jRdqxdBO94pHZ5lSRU5ksMji4BX9rzwEiIH4VrdZ6KL4j
 CWgPe25NyTMhQSsp3eo3SOMVH80fR9+FXo8hgCW3GNtxgPqKJK4CXeFMOxf1m8qIVUN+
 /7P5qirEteYyUH6kRc3ZhJaevk0b9hl7wbWS5E6N/R5QcQ7kDpmwhShUlDoHfGiBP9M8
 k4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687852188; x=1690444188;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9EpieEvbwRuonLUO4ZFLZ77OR4kXPqxojCQI1x4UU4=;
 b=RfCgf4BlF55aoxzGg7HVcgS/azm0deCwbnHXuNTtTCqFFkTuw89uEOsj3SiH10Tw4W
 7JtNehh2zAUNB/8Dyblj/U3uYhY2mEMKRY8RXlPnG4fu165md7/bRJbu/7qifMGsmfrC
 1X5KMPfnaPAS2YarfFaGw+nfWTsOywnBufVI4PPXOpwLlrZPLy1lLnm0OPoqTq3XH4YB
 vxWePx+runf7FnW0pOEOvGEYUHZN/EKGnKW071WaBKOhygLA99uoMk/z40TD97XSZ2G7
 7GorwBVROfZzEbfWw3sfoVURHJ2Cnd4YubhKMMgdIMTn3BrM4zVm9XkeZO8/twoig7NU
 IMVw==
X-Gm-Message-State: AC+VfDwuawk5XWNWli3o8vIUSl5FI0zvriYhIfnCYElVoqxptO0B+yH3
 Z2L8ZUxK1+NDI7EDbE6cZU+zhh2dd1rAS+scVXt2/Exz/dYXXa015qgEqvwqO/6IQuoUZL+peBl
 lPG7Q+P1zn3S+c1Ns1Rkk13SCj02ESGDw7KkJgnbircLQzDL4N+/PXdKFb7xmAD1XoCaQgmV5LS
 E68dTt
X-Google-Smtp-Source: ACHHUZ7Bjc6I4sweo1EVoVgYZjkfWzbVAnfoGXNoaf7fatDXg2lsYjOPGdZlfDQHyB6VNCgmaf99jA==
X-Received: by 2002:a17:902:b497:b0:1b7:f73d:524 with SMTP id
 y23-20020a170902b49700b001b7f73d0524mr5935185plr.43.1687852187851; 
 Tue, 27 Jun 2023 00:49:47 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a170902a5c400b001b077301a58sm5360714plq.79.2023.06.27.00.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:49:47 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Set the correct exception for implict G-stage
 translation fail
Date: Tue, 27 Jun 2023 07:48:52 +0000
Message-Id: <20230627074915.7686-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Jun 2023 09:32:05 -0400
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

The privileged spec states:
For a memory access made to support VS-stage address translation (such as
to read/write a VS-level page table), permissions are checked as though
for a load or store, not for the original access type. However, any
exception is always reported for the original access type (instruction,
load, or store/AMO).

The current implementation converts the access type to LOAD if implicit
G-stage translation fails which results in only reporting "Load guest-page
fault". This commit removes the convertion of access type, so the reported
exception conforms to the spec.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/cpu_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a944f25694..ff2a1469dc 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1277,7 +1277,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         if (ret == TRANSLATE_G_STAGE_FAIL) {
             first_stage_error = false;
             two_stage_indirect_error = true;
-            access_type = MMU_DATA_LOAD;
         }
 
         qemu_log_mask(CPU_LOG_MMU,
-- 
2.17.1


