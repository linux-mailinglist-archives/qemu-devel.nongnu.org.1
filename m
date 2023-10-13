Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A986F7C80BC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqT-0008RE-Hm; Fri, 13 Oct 2023 04:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq5-0007mE-QQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq3-0000vK-PB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so1541419f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186885; x=1697791685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+U4VlGmHX6c8t63nXRvGK6khwZhK7FvvA0drXVMUAPw=;
 b=V3zsIqKANXqqsBX+Fftrz5lGYFq8bt2g1RlKL4JJbFNUks3/075gosBigjsguWVHpy
 snnr/70s8Dy7hGZ/ouBQxJdFymmOsYxJdT4hZtobJ8JcO3WLlWpSVOWOIMRPM8YOMjLI
 Sjf5QzG+RplLIIv+5KCvAS+/mWA/MbYl84m00/6nsPh3bNJyKjK4zQxNavD5z6hK7+X0
 DXZ7iadB+r1MXv+lbq+GrfxlHwKhwt7K/KuD/NpDkqfe5kWgbJQLf57QaeD9XRDBqk21
 DHiW4AVLD4TG40JHzMoUApjeJcP720fHMfoFCLID1L86Vd6n/QvwGRJX3pe2jwhjBtrD
 4TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186885; x=1697791685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+U4VlGmHX6c8t63nXRvGK6khwZhK7FvvA0drXVMUAPw=;
 b=BWP8hXt/DwLsRT03mKNlzEXQwFn2o1Upb3RjInWPik25p01H2h6Zupl8saCCmAVnCs
 0R5KJ2wR8wRpIpSPjQ2PFAqS7d/rCcwK/Li7cEdLYOPloZC8NCwj9dpOh1ugl4nI2Fey
 N+MRMPOmp74LETmWuoS02OGneE1OltgTUA2PXYc3Sw6Ir7QF+gYxFV1rulVPYt6tMIWN
 Ra9i49P4lqFR6N9SHGCcNTv2ZYEmFEAaYJDGgPHuNl7CkKOmUXVuWpvztkIqHOtY23Ht
 t/4mGAgT75Pwv4029jhjSXyurhy36wNVFb/HxjDKl90WdiPtkR4n/7M4S1fvfAutHHJh
 SBkQ==
X-Gm-Message-State: AOJu0Yz4QVsqGsuPxegP8xe6+GMd7FAyC/E8UJ+gzy2ts4TEPBu1IrQn
 c0jZ6f6SZvlPa7uItRRs9EI80P20vl4npyQlnVI=
X-Google-Smtp-Source: AGHT+IHdodlBSZXFwqWQgN74v4VlNmt7SKuxlA91FfdV04yW4q+ubrPGOgvs2Jmw372BU9iNktSUzw==
X-Received: by 2002:a05:6000:22b:b0:32d:9a8f:6245 with SMTP id
 l11-20020a056000022b00b0032d9a8f6245mr1139634wrz.68.1697186885199; 
 Fri, 13 Oct 2023 01:48:05 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:04 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [RFC PATCH v3 30/78] target/nios2: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:58 +0300
Message-Id: <351c2c52f47be506c3708806ee0080761a970bea.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/nios2/helper.c    | 6 +++---
 target/nios2/translate.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index bb3b09e5a7..b44e73768e 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -198,7 +198,7 @@ void nios2_cpu_do_interrupt(CPUState *cs)
 
     case EXCP_TLB_D:
         tlbmisc_set = CR_TLBMISC_D;
-        /* fall through */
+        fallthrough;
     case EXCP_TLB_X:
         if (env->ctrl[CR_STATUS] & CR_STATUS_EH) {
             tlbmisc_set |= CR_TLBMISC_DBL;
@@ -220,7 +220,7 @@ void nios2_cpu_do_interrupt(CPUState *cs)
     case EXCP_PERM_R:
     case EXCP_PERM_W:
         tlbmisc_set = CR_TLBMISC_D;
-        /* fall through */
+        fallthrough;
     case EXCP_PERM_X:
         tlbmisc_set |= CR_TLBMISC_PERM;
         if (!(env->ctrl[CR_STATUS] & CR_STATUS_EH)) {
@@ -232,7 +232,7 @@ void nios2_cpu_do_interrupt(CPUState *cs)
     case EXCP_SUPERA_D:
     case EXCP_UNALIGN:
         tlbmisc_set = CR_TLBMISC_D;
-        /* fall through */
+        fallthrough;
     case EXCP_SUPERA_X:
     case EXCP_UNALIGND:
         tlbmisc_set |= CR_TLBMISC_BAD;
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e806623594..2cfe77c90a 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -649,7 +649,7 @@ static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
     case CR_IENABLE:
         /* If interrupts were enabled using WRCTL, trigger them. */
         dc->base.is_jmp = DISAS_UPDATE;
-        /* fall through */
+        fallthrough;
     default:
         if (wr == -1) {
             /* The register is entirely writable. */
-- 
2.39.2


