Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155A82A18F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeei-0007Ml-3P; Wed, 10 Jan 2024 14:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeb-0007La-Hr
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeX-0002Dr-Ei
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso47091045e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916455; x=1705521255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5n6b/Kfb2q1nuszk7kQnrf8+ZzcUeVpd0islGk5jF8M=;
 b=P8u2pkKUDm9qusYFB0hPOw9BNkL0Mjmv/0Ha9QvvByjTVDjXCg1ziuVuDb6Ritcrj9
 y+iZv87SxJgQ+iIbLPazwTsDCUKLnNGHkKkPNFVn673fkaWvsKxAGqeVPTQ9E2TdcLR6
 fEFhUcfo1dIZS0sfjeIrRsb1EUYHqlrkLhsu6ycoCmQumFDSeGdoZExWhjjXpzuvZ4m4
 nBImjFNrpMZASrMAfHn4MueLbFEIkzBiyXogKtfyCSe56jB44wUO9pQ6/BJnrfCipYIM
 ZNp8tS5ZLMtV9YwEQ0811Hgqjj2GIDefLVsyHfdwoav6JfuhnuhLiUP3QH4bYSUf+G7c
 LFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916455; x=1705521255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5n6b/Kfb2q1nuszk7kQnrf8+ZzcUeVpd0islGk5jF8M=;
 b=wkuKAIIgKMpo/PTPOPsJdYNtZsZQKR7c9KAzAzvFYPqaHtgYp6h32qZXfwBqYBIDPp
 23UXShk8nhV8qT/kM8Ghh6opv6/nXaobLU5czeH0yt9LJrwyrsYwvQKdU76TbVhrOH5f
 VouzXNN3lPNUPuivbYFpR+h3L59CGFFhkeH01OC9ooQ+O1SVr81cHq6nd58YKbC6zMCW
 qgj/PSHcATqXnRCMwHridI8I77e5Zif7JsDTNBqKNtreTN63Ay0Cs6sveBEnGCRmxkHe
 uwH2jBPtgDItS8VOsZ1lJeTrGe96/HHnjgacjpFus1esatYTSMwGmfobqoTS/BgCg+u3
 +JeQ==
X-Gm-Message-State: AOJu0YwJ3Y7A4RUJvHeJg07t3mAIzN1DLh4OZIx2wCB7f6Pm8nlnm2gg
 FM09U01hWU744c43mZT2yJ6zBmITIk2gvryl66h9x4Pv+c8=
X-Google-Smtp-Source: AGHT+IH8sOsgTZDUqFMN3Ep1ODw2mDHry8n2BVIQjjK05VVGEZgLbzTvarQBOazX7WqS2O+WNNjfgw==
X-Received: by 2002:a05:600c:538e:b0:40e:5cf9:9826 with SMTP id
 hg14-20020a05600c538e00b0040e5cf99826mr4786wmb.127.1704916455452; 
 Wed, 10 Jan 2024 11:54:15 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c0a0600b0040e49045e0asm3209717wmp.48.2024.01.10.11.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/14] hw/arm: Prefer arm_feature(THUMB_DSP) over
 object_property_find(dsp)
Date: Wed, 10 Jan 2024 20:53:20 +0100
Message-ID: <20240110195329.3995-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The "dsp" property is added to ARMCPU when the ARM_FEATURE_THUMB_DSP
feature is available. Rather than checking whether the QOM property
is present, directly check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 8350267d96..0a7ad2b762 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -321,7 +321,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "dsp")) {
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_THUMB_DSP)) {
         if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, errp)) {
             return;
         }
-- 
2.41.0


