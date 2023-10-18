Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3866A7CEB3B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:28:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzN-00081e-0x; Wed, 18 Oct 2023 18:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzL-00080x-QM
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzJ-0002Rm-IX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9bca1d96cso51281615ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667960; x=1698272760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AA7L0NLzkIrOUcDjlwriga27ooiuuZ7zo9pLt3rHark=;
 b=zmkPL5OA1S6jdra2yNnmMm0dKIRUn1ZypS31Nzrdvn8vjTa90Yzm1nQqZu52+ilyfu
 5hwZi2RnhTRYppRiUq7F9jbc9T4GGthHe/c6tOluAvECYvwTNV/2PFc74IKQNkh9Qevc
 nPMHLtnPKAxSX16Yb2t6XFQHwlJ9ZSw6kz0dkUimxbNEenk1bUYTXLhFtWPe7O4OQa19
 8fiK41aFPnY7sjiphwU7WCSuQ1/yg0p51AOC/iEoyOy2oosgHMi7mXNC4IahKYH00CUS
 E6JU1C+68ntAL5bz71fJgIULcqPUVQvEXv5IeJtGSiNuos/sHp6rXbTapLnvtJSOD26S
 8tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667960; x=1698272760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AA7L0NLzkIrOUcDjlwriga27ooiuuZ7zo9pLt3rHark=;
 b=QSr9B7iP+MipmpQXMBTjXxWeXEJYLFMWqhIOvvXWJF+waYSoDCuQFsf53kAxPumTPy
 f2Z1XEnPAMJ+9nV3DrgkjsNoK3VJD0e5ilIpLIZaFj1kfi7vd7sjnyruNqaeEkKE8Mji
 Gpw+yU48CQQmdQ2aPOWYO8scyWoNkecyieGKAXAnVKB2MoxJtFwpn+Jx7GDNaRx1q6ZR
 shjMNkNAzaQDmzKJkbwd76x7zyqFhblGyeMPfARJ59OGKzpqCi259HXcj03WGDLPGQs5
 sEdobmZvbTCQf0H+rvM/D8wwexXW2/flIzn1pdfBu8adhLVBo/a7RRniwHOSKcTdz/S+
 l9Yg==
X-Gm-Message-State: AOJu0Ywb/bl8QqSyKntDYRMSZpFQvESuyLPE+NolhAp+UyxpAVV6Y1nR
 SYBVzcMb99K4B/TAltTwFbL4HKeMFRvPnYEsjX0=
X-Google-Smtp-Source: AGHT+IHLdK61NbS2DIT9DoR2X/pUn6j/gXjvFXOLFQYkFSkuVQ/iFQ+idDNtB/KToVWkMciirviIdg==
X-Received: by 2002:a17:902:d4c4:b0:1ca:59bf:6cc9 with SMTP id
 o4-20020a170902d4c400b001ca59bf6cc9mr636816plg.57.1697667960093; 
 Wed, 18 Oct 2023 15:26:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.25.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/29] tcg/ppc: Untabify tcg-target.c.inc
Date: Wed, 18 Oct 2023 15:25:29 -0700
Message-Id: <20231018222557.1562065-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 5c873b2161..5cecc6ed95 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -221,7 +221,7 @@ static inline bool in_range_b(tcg_target_long target)
 }
 
 static uint32_t reloc_pc24_val(const tcg_insn_unit *pc,
-			       const tcg_insn_unit *target)
+                               const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(in_range_b(disp));
@@ -241,7 +241,7 @@ static bool reloc_pc24(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 static uint16_t reloc_pc14_val(const tcg_insn_unit *pc,
-			       const tcg_insn_unit *target)
+                               const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(disp == (int16_t) disp);
@@ -3645,7 +3645,7 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
                   tcgv_vec_arg(t1), tcgv_vec_arg(t2));
         vec_gen_3(INDEX_op_ppc_pkum_vec, type, vece, tcgv_vec_arg(v0),
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1));
-	break;
+        break;
 
     case MO_32:
         tcg_debug_assert(!have_isa_2_07);
-- 
2.34.1


