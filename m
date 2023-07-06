Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B47499A6
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMTh-00080A-Lh; Thu, 06 Jul 2023 06:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qHMTc-0007zi-Af
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:44:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qHMTa-0002VK-7P
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:44:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31441bc0092so425838f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688640280; x=1691232280; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B3Ur0zzlzOnzb5S7VWa/S8Fe98v4oA8RwZL8za0nRoY=;
 b=XQaAHvTU6KxGdI4zRVsGOVCykjmgNaXot+EhgZ8s7s/3HzxPImOn6ef3NtaZSCZS/y
 5PmNxQOsMbwS6jW3SizLunWj0UyiCcvt5riY3lXZApONAW+/i3SHXHCQp1vVN+e98ASG
 AL++aW33FKYv9q40Edc/loyPe7WaBseHZTZ5Lxred+NZkC1KTUjhKUdaYO3jKfvhT8kI
 Sy+l/KhnKlJFrvj29UrAvgg4+YLxQ5Ov5I8hVMe2RXxrAaatYnYgsMFUFI4KlbwfCfvo
 goAesLW4SszuacWkBRzms4NlgNfKJTTmK7wMz+NG2Fr65JBlcYwP7iwont62i6pf9Pac
 gTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688640280; x=1691232280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3Ur0zzlzOnzb5S7VWa/S8Fe98v4oA8RwZL8za0nRoY=;
 b=fV7nEyZ5RS6XBYzUGaqGvjG7w67Hqc/BtZvjGyqjLapEuyxn8xNwKoThBbBwOFhNq1
 oxnTBiTTr+DRHjGdkIct3y1O8jeNFpyT/MQBhVxC6uZFfiPkme8w6KQ3rU9ld/RL/oxI
 GXzxXzx7XcAsSqe4Iao37HJInFyTtbtx9to5kP4sIMQvUGAvACoE2Ucu3s815KjoQrE1
 +eHo+W7EvmuLJsBLOvckeI/ZkP8DeBy/LQ/c9hF2Z9lcAbf4LYpgC2srPuh0juG5b+Uv
 E+xvt56S3Z2D9TlraH4PTi80gDVbBZRxqHUMaYyFejksYjhQEZCvl1sLeZKQKpTlrdyy
 Fwtw==
X-Gm-Message-State: ABy/qLYM24mGtb3fIJlHNGOcCRJgcgWirgdsbVxCktI8PMFcVNiZaqHf
 5FrGVfWNlKbmXwXuV5zsgK0bN2ic91g5paJ8CAKDKw==
X-Google-Smtp-Source: APBJJlEs49v69wkyS1+1O821Yuq6jkLDQ9gOHOp5cNVhLyHqzPx2msdjQOoYw7Ezs2k9v9robwBmUw==
X-Received: by 2002:a05:6000:92a:b0:314:c01:2e76 with SMTP id
 cx10-20020a056000092a00b003140c012e76mr1131422wrb.64.1688640279678; 
 Thu, 06 Jul 2023 03:44:39 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 a12-20020a5d508c000000b0031438257aa9sm1548971wrt.36.2023.07.06.03.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:44:39 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Rob Bradford <rbradford@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Fix LMUL check to use minimum SEW
Date: Thu,  6 Jul 2023 11:44:33 +0100
Message-ID: <20230706104433.16264-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The previous check was failing with:

ELEN = 64 SEW = 16 and LMUL = 1/8 (encoded as 5) which is a valid
combination.

Fix the check to correctly match the specification by using minimum SEW
rather than the active SEW.

From the specification:

"In general, the requirement is to support LMUL ≥ SEWMIN/ELEN, where
SEWMIN is the narrowest supported SEW value and ELEN is the widest
supported SEW value. In the standard extensions, SEWMIN=8. For standard
vector extensions with ELEN=32, fractional LMULs of 1/2 and 1/4 must be
supported. For standard vector extensions with ELEN=64, fractional LMULs
of 1/2, 1/4, and 1/8 must be supported."

From inspection this new check allows:

ELEN=64 1/2, 1/4, 1/8 (encoded as 7, 6, 5 respectfully)
ELEN=32 1/2, 1/4 (encoded as 7 and 6 respectfully)

Fixes: d9b7609a1fb2 ("target/riscv: rvv-1.0: configure instructions")

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/vector_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1e06e7447c..8dfd8fe484 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -43,9 +43,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
 
     if (lmul & 4) {
-        /* Fractional LMUL. */
+        /* Fractional LMUL - check LMUL >= ELEN/SEW_MIN (8) */
         if (lmul == 4 ||
-            cpu->cfg.elen >> (8 - lmul) < sew) {
+            cpu->cfg.elen >> (8 - lmul) < 8) {
             vill = true;
         }
     }
-- 
2.41.0


