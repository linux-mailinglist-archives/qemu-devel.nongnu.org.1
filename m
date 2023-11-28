Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3787FBBC1
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:38:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yI5-000211-HI; Tue, 28 Nov 2023 08:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yI3-0001zx-C9
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:15 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yI1-00087X-Of
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:15 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a02d91ab199so749211066b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178692; x=1701783492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTMVhitieSJNZvrttwpbFm3rdYpSlAZIyeSRfKEX9cE=;
 b=ArAKQ7vpO1RhuyIn3poB/u+rL+XcRgg/oFG/DjICEuEFQVxgaaRuzwF/XSHbc7g5hM
 ow/KoUFdKhpaiUGFxinahBA7Gie+ITN3Vnu5SUIfpMSz6xxsw/3iKAbRSz7xwKFs8EGM
 zSAFeatRMVqXyLg0Gr1CsZvbwXNhmZFxMoWJjjh3UxA8knv/OEfrxqw4RKCOPlBDM3hW
 hZmrjCpgBkRo7XkJ8wH1S+Ioni84l0uYmszDgVH1+h9v5JSvOitq+1UCTckiVo/4x4rq
 qZq+m8vkEXXupm6CD0enleGKHD26DHnddZrBfHVVFEYiDnH+lWCb5rwoqE8mrsHj5UCq
 Oedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178692; x=1701783492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTMVhitieSJNZvrttwpbFm3rdYpSlAZIyeSRfKEX9cE=;
 b=kL+SmDBUqlRdltqDV3wae8K6Nf3TihUuv4kzHICD8m0EAMbuFSbHG7i4rbteH7tsKp
 rpDTIBMX1QDys2StTLZ4Px88VOiBDHktb+N2zlf1qJJPJdlCl9XIHsDxa5qiUCtgdLEE
 r6e0N2JOkC2uy7GQTzdyapd5Ln+l1WThh29hBpMSN9RLE4NJ+BjivQoengjBTgCg0FcP
 nSgx0T0QXHqYWN3OP6oK0Hnq/m3owjTa+/lIbV65hcOJ77sGmPZcA5Xz59qI0IGsRyk+
 Mf458kSKAqbn8PAoY3aiybObHs3tsgQUfAOdUTIIkbdpg5/xWAMAgRuyHqbDidOmPzuN
 njDg==
X-Gm-Message-State: AOJu0YyWOoPULXTGVTPLTEEGLTHGnSXdg5+io/VvjUBju/I5MINWlqYH
 iStgY0Xi9WSJW/oIPqsDVLTH65jzBgl9cUHAFLA=
X-Google-Smtp-Source: AGHT+IGFTktVv509/Xn1us4Zntg7l7ytNYzzZNufxod4L5ytUjErq3eZCr/oqAzvhkz1k3iC6bWmHA==
X-Received: by 2002:a17:907:6d06:b0:9e5:2c72:9409 with SMTP id
 sa6-20020a1709076d0600b009e52c729409mr13673712ejc.43.1701178692301; 
 Tue, 28 Nov 2023 05:38:12 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 h18-20020a1709063b5200b009fdd2c6d042sm6955414ejf.148.2023.11.28.05.38.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:38:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 5/7] hw/audio/via-ac97: Route interrupts using via_isa_set_irq()
Date: Tue, 28 Nov 2023 14:37:38 +0100
Message-ID: <20231128133740.64525-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This device is a function of VIA south bridge and should allow setting
interrupt routing within that chip. This is implemented in
via_isa_set_irq().

Fixes: eb604411a78b82c468e2b8d81a9401eb8b9c7658
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <5329840e4be6dd8ae143d07cbfe61d8d2d106654.1701035944.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/via-ac97.c | 8 ++++----
 hw/isa/vt82c686.c   | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 30095a4c7a..4c127a1def 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -211,14 +211,14 @@ static void out_cb(void *opaque, int avail)
                     AUD_set_active_out(s->vo, 0);
                 }
                 if (c->type & STAT_EOL) {
-                    pci_set_irq(&s->dev, 1);
+                    via_isa_set_irq(&s->dev, 0, 1);
                 }
             }
             if (CLEN_IS_FLAG(c)) {
                 c->stat |= STAT_FLAG;
                 c->stat |= STAT_PAUSED;
                 if (c->type & STAT_FLAG) {
-                    pci_set_irq(&s->dev, 1);
+                    via_isa_set_irq(&s->dev, 0, 1);
                 }
             }
             if (CLEN_IS_STOP(c)) {
@@ -305,13 +305,13 @@ static void sgd_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         if (val & STAT_EOL) {
             s->aur.stat &= ~(STAT_EOL | STAT_PAUSED);
             if (s->aur.type & STAT_EOL) {
-                pci_set_irq(&s->dev, 0);
+                via_isa_set_irq(&s->dev, 0, 0);
             }
         }
         if (val & STAT_FLAG) {
             s->aur.stat &= ~(STAT_FLAG | STAT_PAUSED);
             if (s->aur.type & STAT_FLAG) {
-                pci_set_irq(&s->dev, 0);
+                via_isa_set_irq(&s->dev, 0, 0);
             }
         }
         break;
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index a3eb6769fc..9c2333a277 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -622,6 +622,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
         break;
     case 2: /* USB ports 0-1 */
     case 3: /* USB ports 2-3 */
+    case 5: /* AC97 audio */
         max_irq = 14;
         break;
     }
-- 
2.41.0


