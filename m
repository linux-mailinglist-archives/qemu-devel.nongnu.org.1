Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B802CA4F425
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 02:56:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyS-0005bH-A1; Tue, 04 Mar 2025 20:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdy7-0004wD-4s
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:44 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdy2-00005z-Dy
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:42 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223785beedfso79519315ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139676; x=1741744476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hu7CDHfLgBRdr82MdBZgMyZ5V8YylLwoAe+D7hfRTgE=;
 b=PxfOe8ImSvq8RJilvCu9NrQygMh2m0qQqexxC/8UeG2AeJbZr9m+CQtaicG/ui201+
 1IJx+NNJJoXxay2Oj3AHi6zJr3Fn+gMTRdz90TjGjLOWxwbc7H3pX67I9eod+jEMLmzo
 7LS9mzRMC5cZzDY6wLqSvnLDWMuAZzjz9fCACWpGcazDmK674TI4z8LTzAOnhYF+oL6Z
 ig6HFhN8mH5X3UUbcvgD//5Tdk7DcepDyT9Ywvh8XGQWRESwPCOB07ZtXOPMyf31fkFe
 1txoG0UBhYpB3TPhktOLviXDRPsSW7f7zezeYWvp/EViuJQnM6H2/4yJAMm/Ntxx21n5
 OtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139676; x=1741744476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hu7CDHfLgBRdr82MdBZgMyZ5V8YylLwoAe+D7hfRTgE=;
 b=Hyuc95MQp8UAJtflBM+tXH2FGvmzDZ5OJm7EhIWp6RYGhy/N14SA3FqM4UwumNfPwC
 o9/lWgt9rj/8csID3J6ukZ38hE76rC/nsRkmldxcXtCWXUdHHLSGOFRCKj2N0I94Zwc1
 yFsm2abPOF5UOqFekY3xrhBppkXPjpe89NQId3d1QZCnFTG+PqGx42KH8suraEfjiWkJ
 iGKIdoBVc91VtjHYGncoMJrGge5Z0dck1rEVn6K0xvjEV7uGFfjj5BIrzkEp5W+4wDWB
 Pv+dnF1ri/d8u0ex7aHXpq2bS+MRCuP/6068g9FnhvqyKgxwbl75AM9NJrFQEb14snv7
 C6kw==
X-Gm-Message-State: AOJu0YyYEzglxkkbI4TbtvRMYIZ9X6F17+DiktfAwlwDNsOJyN6Sy6lM
 QHhgG1re3w2gi8CeMPEFzv4aD2W5AnxpGJntAB8T861a8t+awhKi2r+LGa6Q4/0=
X-Gm-Gg: ASbGncss7hTqmE3T260m17sPROUk8bsdzp25zChdVQAMTj1aqh3ddu6oSqjvqeCzd5S
 HO2MFZzAZkUHMgNU+ov52syVqavFCNiUoryJiw/T1GxuFpBRmtaibvy3esi/RmK1EJfpo6jJqHT
 FdPkimVHSXYk1ytchfzq34KqYNnfg3XpMP2a/auQ9rTRk25XQ9GLw03Bj/2cvPdUZRwpjlQvhOE
 1FxrV2h4901e4TJgHlyGPglL6suc70zBntRDuxu6kX9TRyOuFKWQp49D3Co/piiARe/X9Dky1Wb
 Gsq0b5NSogaOWaiz6gBS9DEx0vpugDBRLw+Sv5MyeI21Jj6MSf/PQOiap2Flof2xbyA9tDierr9
 rb8lRTuihjyHSJ6+qqc5EJ0yjEE9P4ThRCepnw/FHRyALB0M0gBY=
X-Google-Smtp-Source: AGHT+IGtfA0MWDZxAWSFcl0UtV1NUGAZVizPxrgrshK0KnIfL8i4WRMQESQF7EBJJrRxvLv/z355Nw==
X-Received: by 2002:a17:903:174c:b0:220:d601:a704 with SMTP id
 d9443c01a7336-223f1c95062mr18432765ad.18.1741139676547; 
 Tue, 04 Mar 2025 17:54:36 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:36 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, julia <midnight@trainwit.ch>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/59] target/riscv: log guest errors when reserved bits are
 set in PTEs
Date: Wed,  5 Mar 2025 11:52:36 +1000
Message-ID: <20250305015307.1463560-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: julia <midnight@trainwit.ch>

For instance, QEMUs newer than b6ecc63c569bb88c0fcadf79fb92bf4b88aefea8
would silently treat this akin to an unmapped page (as required by the
RISC-V spec, admittedly). However, not all hardware platforms do (e.g.
CVA6) which leads to an apparent QEMU bug.

Instead, log a guest error so that in future, incorrectly set up page
tables can be debugged without bisecting QEMU.

Signed-off-by: julia <midnight@trainwit.ch>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250203061852.2931556-1-midnight@trainwit.ch>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 356e84b9a2..3f5fd861a8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1472,14 +1472,27 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             ppn = pte >> PTE_PPN_SHIFT;
         } else {
             if (pte & PTE_RESERVED) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
             if (!pbmte && (pte & PTE_PBMT)) {
+                /* Reserved without Svpbmt. */
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
+                              "and Svpbmt extension is disabled: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
             if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
+                /* Reserved without Svnapot extension */
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
+                              "and Svnapot extension is disabled: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
@@ -1490,14 +1503,19 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             /* Invalid PTE */
             return TRANSLATE_FAIL;
         }
+
         if (pte & (PTE_R | PTE_W | PTE_X)) {
             goto leaf;
         }
 
-        /* Inner PTE, continue walking */
         if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
+            /* D, A, and U bits are reserved in non-leaf/inner PTEs */
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: D, A, or U bits set in non-leaf PTE: "
+                          "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                          __func__, pte_addr, pte);
             return TRANSLATE_FAIL;
         }
+        /* Inner PTE, continue walking */
         base = ppn << PGSHIFT;
     }
 
@@ -1507,10 +1525,17 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
  leaf:
     if (ppn & ((1ULL << ptshift) - 1)) {
         /* Misaligned PPN */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PPN bits in PTE is misaligned: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
     if (!pbmte && (pte & PTE_PBMT)) {
         /* Reserved without Svpbmt. */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
+                      "and Svpbmt extension is disabled: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
 
-- 
2.48.1


