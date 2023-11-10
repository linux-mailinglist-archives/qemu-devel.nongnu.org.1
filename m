Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C2C7E7A8B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:18:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NdE-0002SR-6A; Fri, 10 Nov 2023 04:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1NdB-0002SC-SZ
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:16:49 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1NdA-0002nx-26
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:16:49 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso23833191fa.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699607804; x=1700212604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeFgcUrkNeVKboCpBXlqzidVzZtMesg9/1Y5VQkDHfk=;
 b=i0c1uFUD2hp/LoozObvIuM36cT6TFPb3dZ+Pm3DnvSjeB9J1aCxD/JZ41WHIyuZ1tl
 nXesEx3omxNKeUzY7GRfm9Dix+ZLpRdKcEzF/5RgVdXwJdzfN/yL046ICYZHq9OvdULH
 undNBgWhNtiKuhYDaCZES0BKdkNt31yUYppso6J+7WOQX/oLoABSxmlVX6Bs+xazA2Nf
 vD/MsVarKBGo6kXS9cmPhOb1sZ6ud0svP3n7/Oi3+5suEJjK9PD9ubuxcSITYivZJK22
 BebX6As9umEkPlK3QenJXmicY5gPmH1JjDMHlfjJQVSGt80ggbIVyEaty+72wuEgmaOK
 W9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699607804; x=1700212604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeFgcUrkNeVKboCpBXlqzidVzZtMesg9/1Y5VQkDHfk=;
 b=i0MBdOKZ3whsp1Fktop8d0ORtVUBsoE4+OVBo32TAemIjuZOvgv8VtJhZcnLVtJqo3
 M/oHhepkhBOfk106mKU1dNZPxuySPH1dabwNLw83kG4hf48ehmPSL0RpSi9vr/O2t7ZD
 wDXIOa5I9TtF7Jqj9ibtup1DZFNko6/LtkgtoTsfIY+o7kiNBTQwirtSNio1lZF5vBAl
 UV1UWcK26JvJkhO3FiQ9FFNhVCQY+ICxBofrIhqFYGFp/HsbZZ5LPoieujT8OziXVw0D
 j5BxVTgBevL6fC22Z1COtn9xf0kEPc91O2uZGxbmHuJDu4XEDKCdbLNnxHtBhpLLUk+G
 qpHA==
X-Gm-Message-State: AOJu0YyE0OkCe5AISLP+/0fUCt7s/DCwJ9C9pleKzUd0/xa/ZrqsLdCs
 gJOpLVY1zaVeWk1z+mvJHlp6leIB0Y0YUlXF+QLE3A==
X-Google-Smtp-Source: AGHT+IHOaRjRFsMXrSp5gqbRRGQmJhqE5M59fIDTMgTheqMecik0BlntJiOT+zjHqRpdchbx3+KS4A==
X-Received: by 2002:a2e:3315:0:b0:2c5:2182:48db with SMTP id
 d21-20020a2e3315000000b002c5218248dbmr5774670ljc.20.1699607804405; 
 Fri, 10 Nov 2023 01:16:44 -0800 (PST)
Received: from localhost.localdomain (adsl-205.37.6.2.tellas.gr. [37.6.2.205])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c359600b004080f0376a0sm4537493wmq.42.2023.11.10.01.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 01:16:44 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org (open list:OMAP)
Subject: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
Date: Fri, 10 Nov 2023 11:16:39 +0200
Message-Id: <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Ignoring the return value by accident is easy to miss as a bug. Such a
bug was spotted by Coverity CID 1523899. Now, future instances of this
type of bug will produce a warning when using GCC.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 audio/audio.h      | 2 +-
 hw/arm/omap2.c     | 8 +++++++-
 hw/input/tsc210x.c | 8 +++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index fcc22307be..b78c75962e 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -94,7 +94,7 @@ typedef struct QEMUAudioTimeStamp {
 void AUD_vlog (const char *cap, const char *fmt, va_list ap) G_GNUC_PRINTF(2, 0);
 void AUD_log (const char *cap, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 
-bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
+bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp) QEMU_WARN_UNUSED_RESULT;
 void AUD_remove_card (QEMUSoundCard *card);
 CaptureVoiceOut *AUD_add_capture(
     AudioState *s,
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index f170728e7e..59fc061120 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -614,7 +614,13 @@ static struct omap_eac_s *omap_eac_init(struct omap_target_agent_s *ta,
         s->codec.card.name = g_strdup(current_machine->audiodev);
         s->codec.card.state = audio_state_by_name(s->codec.card.name, &error_fatal);
     }
-    AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal);
+    /*
+     * We pass error_fatal so on error QEMU will exit(). But we check the
+     * return value to make the warn_unused_result compiler warning go away.
+     */
+    if (!AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal)) {
+        exit(1);
+    }
 
     memory_region_init_io(&s->iomem, NULL, &omap_eac_ops, s, "omap.eac",
                           omap_l4_region_size(ta, 0));
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 950506fb38..003c664b56 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -1102,7 +1102,13 @@ static void tsc210x_init(TSC210xState *s,
         s->card.name = g_strdup(current_machine->audiodev);
         s->card.state = audio_state_by_name(s->card.name, &error_fatal);
     }
-    AUD_register_card(s->name, &s->card, &error_fatal);
+    /*
+     * We pass error_fatal so on error QEMU will exit(). But we check the
+     * return value to make the warn_unused_result compiler warning go away.
+     */
+    if (!AUD_register_card(s->name, &s->card, &error_fatal)) {
+        return;
+    }
 
     qemu_register_reset((void *) tsc210x_reset, s);
     vmstate_register(NULL, 0, vmsd, s);
-- 
2.39.2


