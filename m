Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD427D79A3
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2t-00079n-J4; Wed, 25 Oct 2023 20:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2l-00070s-Fe
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004rS-M5
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cbf47fa563so2273905ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279361; x=1698884161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhJv02LeNSNRi9K7QfhBZ5XwbuSGXoIYziudXEjPl7w=;
 b=dexLZLnG8XlB4nwE91iyK5LfQE+ksa6jswIdG2J/GHtuzYXQjur9Qwk+wKi6fkl+jd
 ltD0zqjwfHDFvmU4ZhihH2AOZCq8GLKJdAPDuOXmSu0jpZ7UJ0c/oYFYt2gWGpvOkipG
 kOzj/EjZJQXHSFx0XC/ggTDzKhDPPe5/IWioGd+s9CP8Xv+MoAMDnif/IEjAWV1pGwn1
 KkHjkftQzU4BDR84P7zG4ow74hOJ0WXXCTFeIVlWu8+90zhPhGZoUHy9d7zKI8TiIpAQ
 fv87pLf7bb3X/VYzaSsnm7Xty1KAeFRBGUSnYQO3tVvuJv/3tht/vG9kISml6gzqOZA9
 f+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279361; x=1698884161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhJv02LeNSNRi9K7QfhBZ5XwbuSGXoIYziudXEjPl7w=;
 b=XwybAS7lKVjHE0D6NiG5Tk2KIeeKOGxWeiwqcq1cMY7SteWQaNwPaRUVXlvNzsG9jO
 DT0vsuui8HtgrYVHSaaZ57Y2o9tllsWo0Sl/OCV/PPg4J0JTWvQJp0qH2lhqofDyRrSH
 6pzXsvrVnW8cfIRcAEC9u5c1ED9ORc3DJBX4cYT8u5JziuA7BYNfN8h1C1le/4odd5UM
 xVrQLNiXBGKzbUnFmlswFQVFXzOIkARXBNhfMytE0WIb9ECPaMVXGSa4M4lbUHurX+HS
 mU+d0Hu4H8SpOAgmqjk8+oIUs4lKDHHTvpFR262YC0Vcxhj0ICISWSpPtTKliy99rSDd
 6UXg==
X-Gm-Message-State: AOJu0YwFL4Q+XSaVMh5V3k+NyHeTTdwYeA6z8NnGk8JwFiH4s8UrHwQI
 dYH4MEvHsIx0YQkY2gqhG4EJrX68J4t7pLt298k=
X-Google-Smtp-Source: AGHT+IH5f5FVZZvIATnlBQgaPUWXCFOeeZF8s5S1Z8R4RtljZyszVtOCpKYx7WRN1e6o9yhCajRxkg==
X-Received: by 2002:a17:902:db0c:b0:1ca:7909:6ee6 with SMTP id
 m12-20020a170902db0c00b001ca79096ee6mr14908654plx.61.1698279361374; 
 Wed, 25 Oct 2023 17:16:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 11/94] target/sparc: Define AM_CHECK for sparc32
Date: Wed, 25 Oct 2023 17:14:00 -0700
Message-Id: <20231026001542.1141412-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Define as false, which allows some ifdef removal.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 080bc5f8a2..9eb2b7e52f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -268,20 +268,21 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 #endif
 #endif
 
-#ifdef TARGET_SPARC64
-#ifndef TARGET_ABI32
-#define AM_CHECK(dc) ((dc)->address_mask_32bit)
+#if !defined(TARGET_SPARC64)
+# define AM_CHECK(dc)  false
+#elif defined(TARGET_ABI32)
+# define AM_CHECK(dc)  true
+#elif defined(CONFIG_USER_ONLY)
+# define AM_CHECK(dc)  false
 #else
-#define AM_CHECK(dc) (1)
-#endif
+# define AM_CHECK(dc)  ((dc)->address_mask_32bit)
 #endif
 
 static void gen_address_mask(DisasContext *dc, TCGv addr)
 {
-#ifdef TARGET_SPARC64
-    if (AM_CHECK(dc))
+    if (AM_CHECK(dc)) {
         tcg_gen_andi_tl(addr, addr, 0xffffffffULL);
-#endif
+    }
 }
 
 static TCGv gen_load_gpr(DisasContext *dc, int reg)
@@ -1366,11 +1367,9 @@ static void do_branch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
 
-#ifdef TARGET_SPARC64
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
-#endif
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
@@ -1406,11 +1405,9 @@ static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
 
-#ifdef TARGET_SPARC64
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
-#endif
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
-- 
2.34.1


