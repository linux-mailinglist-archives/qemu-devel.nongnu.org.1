Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01A832040
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:09:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgo-0006YM-BM; Thu, 18 Jan 2024 15:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgj-0006Ia-4W
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:33 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgh-00077S-HB
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e884ac5c8so255615e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608510; x=1706213310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zozAuekXsv7RqlLM4guzPZsrXewV7KaaXnf3wtjaQAU=;
 b=kvd3tq+eapbpCngaN3Dko77VjREW5ZPXaosP/QTIDOmgoBt3YR3tgtI7OUedWpZhF9
 9bYMjM/oqfkt09JPJwj7ixwubDMpIs1x23TeW/2c/3R/bvCXJkPscf81yGC7C5/AlU3Z
 Y+ycgmlPCfKRbWcAfVE9e+uLUUaTH4XAF4YgVVIgl2zOa6MdHh2Fmg1SwYkhBAd1xZOb
 gUOJGPG87pj8rRY41DYNReCGm0QoFr3L07GsBirJD2POAmixXh+sc1vCY7jCX5FIULR0
 Jn5Jz9l/55feaw1kkHPj6hFHW2TKuBB/jXlgVzJjC5p6RzD2gjj0uMkp42Pha0iF7BzV
 tVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608510; x=1706213310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zozAuekXsv7RqlLM4guzPZsrXewV7KaaXnf3wtjaQAU=;
 b=qswuxycYzjV9GfTPISR044z9jkGR/br7clUSqwu2A+LdrC6ViCYRSduWCzQ5VXNcFd
 xpSGwVJeE1gEpjDMLLCHY+LLSS2WS24hDuZ+MNGKaBgufnkbu8i3LeWMySshzoYNcIR+
 54FQyaUQ7N+Mrep+yqlA3oQ4IqaJFfyGM+kufI5zI250gyQ1UPZBq+vDMO51gRDvNoF1
 e1UJTV0B+2O802wTdf0QHhqAKA4ZndYZ+jIRkZzHThR6A+Z6Ep8+LDCxf2x+SnOhxuZ+
 d3A5pnyGL0/K+gPAXRdbzpjzKyD1sZKlyyAABw53PpGQVzlD8XFlS/kSL5+Z4UfjYzyN
 7cXA==
X-Gm-Message-State: AOJu0YyKAYi2ooUB/sQ+y1OLWpeyo2PWmo9q3rHPEZwtCxKBl0N3CZ4v
 jWXiEye1pSr7duro0+XFmuFeug32y9t5HoHivpOTL5Vxyrblfoz242hAMRq5887CgvHZEHPbNjE
 6x1fE/mGO
X-Google-Smtp-Source: AGHT+IHAXWZlDPgGCKUoszcIliwZOjZQQesvvlbj+f+1ULrIP3kcqYXjYGbM42jIhneojIogmfSl3g==
X-Received: by 2002:a05:600c:4216:b0:40e:4a71:e140 with SMTP id
 x22-20020a05600c421600b0040e4a71e140mr430671wmh.342.1705608509862; 
 Thu, 18 Jan 2024 12:08:29 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 jg1-20020a05600ca00100b0040d4e1393dcsm30281752wmb.20.2024.01.18.12.08.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:08:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH 18/20] target/arm: Move e2h_access() helper around
Date: Thu, 18 Jan 2024 21:06:39 +0100
Message-ID: <20240118200643.29037-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

e2h_access() was added in commit bb5972e439 ("target/arm:
Add VHE timer register redirection and aliasing") close to
the generic_timer_cp_reginfo[] array, but isn't used until
vhe_reginfo[] definition. Move it closer to the other e2h
helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc8f14f433..1ef00e50e4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3342,20 +3342,6 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
 };
 
-static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 bool isread)
-{
-    if (arm_current_el(env) == 1) {
-        /* This must be a FEAT_NV access */
-        /* TODO: FEAT_ECV will need to check CNTHCTL_EL2 here */
-        return CP_ACCESS_OK;
-    }
-    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP;
-    }
-    return CP_ACCESS_OK;
-}
-
 #else
 
 /*
@@ -6543,6 +6529,21 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        /* This must be a FEAT_NV access */
+        /* TODO: FEAT_ECV will need to check CNTHCTL_EL2 here */
+        return CP_ACCESS_OK;
+    }
+    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
 /* Test if system register redirection is to occur in the current state.  */
 static bool redirect_for_e2h(CPUARMState *env)
 {
-- 
2.41.0


