Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E97C80CB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqv-00028a-Bt; Fri, 13 Oct 2023 04:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqj-0001T0-RY
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqi-0001AL-5N
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso1681390f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186926; x=1697791726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+axG+8jMpP3JUeMY5SI6Tpq3BCcAFNQzdxrSiz9WHc=;
 b=ukJZXVU79CczHdqIeyI9dE0GtdYncznRH2mK4QZiZ67C8oIMPIKiz6GDCpBPm3XvJO
 x8enmAYUO5o+WfHtmlJS2y0I8oH3NQ2eThA3a/Mf7ybhY6yXVnMOYZe7eyAqzpp1j+UB
 Bt81xdvOgy8QRD6joUwYVBhWue0cUP6TN+VsztnwSE9b5DzAj9pbqOgUjmQuXoCTwEDL
 v0DbOYQan7EzE3hxEQLF+MFUc49puBhSW5Q2v5WiozT2nCYXhwppoyo48ydKWgyAnLBK
 cWMBDmvOKWcQy8ltYucRxiSVFFJOXZIsmaCVyYvEbQqXEV82jKx6wcKnIQC/2qQ9eX9d
 rqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186926; x=1697791726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+axG+8jMpP3JUeMY5SI6Tpq3BCcAFNQzdxrSiz9WHc=;
 b=Xdib2bVc5hy8s/HjN2O22MMJD+PwX23xJuN3TWwoZGIdrJJVGUrzmfnhefs79LTjMS
 U4rAPHnV7Ux2zqyVSI/Zhvj1F5o3AtxIicJsIP37z9XP2ohmcvowT2mMzsIk8aLqdT+A
 Q5j804HjtOyNX/0ij7xkIGj2q5uCSlwkrs0GTpiqeAPlSROXIjJcq5ZXLEIfuCifvKDJ
 1886EyLQt79NdUiQ5jv1P7ZHhiKBlL836+4zBXms017VWeJ/v581uonO4jbk7iK14pQa
 khuh0sEAo2x0NALm9qLHvZVaSrHdTbB1GPes4V1E5Ss/ZG6+s3G+oqrxXlQeoMPo00Y3
 5wtw==
X-Gm-Message-State: AOJu0YyRjoMm7/AhMYXILMCgjsmRSBXDPMQwByjbQvyk7ZkHVh5vGQjC
 PnTj/v+vZz8Ydk+mMdCOA3Hx9pW7HYI4/b4h7Fs=
X-Google-Smtp-Source: AGHT+IFcRmF0OORu1YAwY0/V6SdusLOTY+Swn6IKDZrZajluiQvjlXA6oRHv61U9H+jNVWmhJ65A5Q==
X-Received: by 2002:a05:6000:1250:b0:32d:9d66:5742 with SMTP id
 j16-20020a056000125000b0032d9d665742mr682344wrx.10.1697186926509; 
 Fri, 13 Oct 2023 01:48:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:45 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:nSeries)
Subject: [RFC PATCH v3 56/78] hw/input: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:24 +0300
Message-Id: <bcc863c7f9f081a2bbf2e7b50ba22cbe89346c30.1697186560.git.manos.pitsidianakis@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/input/hid.c     | 3 ++-
 hw/input/tsc2005.c | 4 ++--
 hw/input/tsc210x.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index a9c7dd1ce1..15fffc5dfb 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -283,6 +283,7 @@ static void hid_keyboard_process_keycode(HIDState *hs)
             return;
         }
         /* fall through to process Ctrl_L */
+        fallthrough;
     case 0xe1 ... 0xe7:
         /* Ctrl_L/Ctrl_R, Shift_L/Shift_R, Alt_L/Alt_R, Win_L/Win_R.
          * Handle releases here, or fall through to process presses.
@@ -291,7 +292,7 @@ static void hid_keyboard_process_keycode(HIDState *hs)
             hs->kbd.modifiers &= ~(1 << (hid_code & 0x0f));
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0xe8 ... 0xe9:
         /* USB modifiers are just 1 byte long.  Bits 8 and 9 of
          * hs->kbd.modifiers implement a state machine that detects the
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index db2b80e35f..4f3f1d9d12 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -262,7 +262,7 @@ static void tsc2005_pin_update(TSC2005State *s)
             s->enabled = false;
         if (!s->pressure)
             return;
-        /* Fall through */
+        fallthrough;
     case TSC_MODE_AUX_SCAN:
         break;
 
@@ -271,7 +271,7 @@ static void tsc2005_pin_update(TSC2005State *s)
     case TSC_MODE_Z:
         if (!s->pressure)
             return;
-        /* Fall through */
+        fallthrough;
     case TSC_MODE_AUX:
     case TSC_MODE_TEMP1:
     case TSC_MODE_TEMP2:
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 950506fb38..9ae426e1a6 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -809,7 +809,7 @@ static void tsc210x_pin_update(TSC210xState *s)
     case TSC_MODE_Z:
         if (!s->pressure)
             return;
-        /* Fall through */
+        fallthrough;
     case TSC_MODE_BAT1:
     case TSC_MODE_BAT2:
     case TSC_MODE_AUX:
-- 
2.39.2


