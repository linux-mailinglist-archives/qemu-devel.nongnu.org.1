Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 658857E3320
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:36:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BsP-0004ra-6O; Mon, 06 Nov 2023 21:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsL-0004Yz-4N
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:33 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsJ-0002t5-D5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:32 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc58219376so47275345ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324288; x=1699929088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0QClBWgpnBsKraO8tbwMKztJuQNjsgsB7iXfkinXQU=;
 b=ItuGUHyBg7JEB6YrntvoPMvMysoWxMOyukjl//Xl8xgtOthB28L3VGVQx4WY0RJqhN
 yihRDNTvFsBMcO1ruqOFMn7Zu6O+R0ArTbtrJIgYYmEPFvFFGeaoPYA12XtFfSVHf2kf
 0mYxHejEw70DBYVrjnAahteaGPYNmTTWTCckeGj10ucuaZZ9uUlFHxfQtjNHXwy+l3fc
 KKm9Lj2j0lydk31rTN4f2qlhF5MUOUeThRbLNd6dvI+0YAumm1ssVqcswAxNiyhgxupJ
 l8g48VFxsuf5FLjvJ/n0zkZFQ2Yf6hZmorRxP/9nkAQbrnbnHihvz/mzx/jIlPgCytHj
 qNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324288; x=1699929088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0QClBWgpnBsKraO8tbwMKztJuQNjsgsB7iXfkinXQU=;
 b=nx/3b9AUEs6EgMy1jTa7kzg5OeE6tBt+p372V7izZFJuxmirTTYQea3vZi9/WIr9dM
 eHryIvAyAnu5BtA6KgMTJ0U8G0WnzqrA5gLlYRPHntwSQq/EehbNfU2bLAjKjjZnp8i9
 CAOE24b267E7Rnl3jojnjw8aC0Z+D6hkTIL9vB0sI4yOVyOn3VjFDYrA6MdGDm6zuenR
 5nqR1klmLeprm2XJJ/4ihjK5XXmj8rPkHiDnWp5nDyYJ0fq5JYMyl6uXWWSawkWhqLHA
 obP0mxBfmIdMgq8CwqKRsuijfwHe5ngq0G8KxAT7Oc6JgnPYNxFD+8Y3o87yFcHxU87J
 8Afw==
X-Gm-Message-State: AOJu0Yz+MAzYCewsAuVnm8kGChSVNjXU5IEodo9rSKjngL2mQ570+8z0
 WnzURmazP/kFPWD7iZfKMuX8bva3GlnA0w==
X-Google-Smtp-Source: AGHT+IFFQOEAsRBum1tKRCrOBRv0NX2m4ct/OOTFTjdsQ2GRAVxXegd70bAFjyNZJW152nXFQKt2eA==
X-Received: by 2002:a17:902:d4ce:b0:1cc:d981:a3a4 with SMTP id
 o14-20020a170902d4ce00b001ccd981a3a4mr4465949plg.31.1699324288408; 
 Mon, 06 Nov 2023 18:31:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/49] target/riscv: correct csr_ops[CSR_MSECCFG]
Date: Tue,  7 Nov 2023 12:29:23 +1000
Message-ID: <20231107022946.1055027-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

The CSR register mseccfg is used by multiple extensions: Smepm and Zkr.

Consider this when checking the existence of the register.

Fixes: 77442380ecbe ("target/riscv: rvk: add CSR support for Zkr")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231030102105.19501-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4ca96ddd1d..fc26b52c88 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -528,11 +528,14 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static RISCVException smepmp(CPURISCVState *env, int csrno)
+static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->ext_smepmp) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_zkr) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -4766,7 +4769,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIPH]       = { "vsiph",       aia_hmode32, NULL, NULL, rmw_vsiph },
 
     /* Physical Memory Protection */
-    [CSR_MSECCFG]    = { "mseccfg", smepmp, read_mseccfg, write_mseccfg,
+    [CSR_MSECCFG]    = { "mseccfg",   have_mseccfg, read_mseccfg, write_mseccfg,
                          .min_priv_ver = PRIV_VERSION_1_11_0           },
     [CSR_PMPCFG0]    = { "pmpcfg0",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
-- 
2.41.0


