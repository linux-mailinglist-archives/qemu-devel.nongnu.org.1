Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB3780EB4
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX18F-0006Em-EB; Fri, 18 Aug 2023 11:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17x-0006D5-W3
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17u-0007Z6-C6
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so932212f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692371461; x=1692976261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/CzseP/nBu8pN/GQVFjtldZXEr+/vmXlEOW5UPs6jA=;
 b=wd7Guxr0ygLOg3+poBIP3JKja1g1B3L2OaB8tTkje5frXy+aiQ20kfDdzvG3dANLzI
 YsWVt4G9bbO5ihHHdRl4iRNub6kPny8bU6j4VsCoHMm8NG3rtdZPiyg3MgyLMpvRSk/B
 q4Eo8KAkUpsMA9PbIBtyNyJeuWXRMYiDluhKd9jtUyrvcqmF2oxC6Ham59KYeExRkDt5
 iqsN2CPLmaPWRkRCEcRoHe55Ot7w4SqiV4SYl8WrbrbCb1BQ/q/PbHMqJnbgriYsCpHh
 qF8WSBPDEiL46Njg8lT7K5udZwvb4sQycNQ8juLCIxgjAKFTLXPcVRbcHI1JaNaU7sib
 GkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692371461; x=1692976261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/CzseP/nBu8pN/GQVFjtldZXEr+/vmXlEOW5UPs6jA=;
 b=mAHbR7bMXvytGN5EcR6Opbf3WIAh5eStVKfjbroy1qV+c5g8/5+aY9qiW14w0HBver
 2KbnMWRZDDzfk61DwSrGKeQDPWN8OO5HjZKpIjVcPoTO9ePFKEvhXb1Fs8cuFcXVWT6Y
 M7PBi3FbOKo23QuH9Z5+LOdsrgtet3+ENXyN3KFaR8eXlspy1H4AIlX+RIs4borN6K7w
 wlrKgDF92LnGXp7BdX3d/fOHV7S02hTrM4sQ/CM4XEj4SkRl0fPZpMVpOr5kOji30gmo
 NWXS/cOgalX2KW3OWVpkgKFgYW7LjPvdaP9lbxvoS5HddwcR4z16RQN4oeMQaalEL/1B
 xefg==
X-Gm-Message-State: AOJu0Yw5olhCAyOuZ2aNaYXnhhQN9LXutvy7T2yxvDFch2SCi7LR26cJ
 82or73bFcE5DufbnbQrTO8AZB67g5im2Yzh7dro=
X-Google-Smtp-Source: AGHT+IG4INTg7bltPGOEFC9n144eRMSljfHpaChb+b8UQtFGFKUwZ93ndc9K6wahIM/usaRTyV2g0Q==
X-Received: by 2002:a5d:548e:0:b0:315:ade6:a52d with SMTP id
 h14-20020a5d548e000000b00315ade6a52dmr2190542wrv.19.1692371461066; 
 Fri, 18 Aug 2023 08:11:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b00316eb7770b8sm3097631wrc.5.2023.08.18.08.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 08:11:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] ui/vnc-enc-tight: Avoid dynamic stack allocation
Date: Fri, 18 Aug 2023 16:10:57 +0100
Message-Id: <20230818151057.1541189-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818151057.1541189-1-peter.maydell@linaro.org>
References: <20230818151057.1541189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use autofree heap allocation instead of variable-length
array on the stack.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMM: expanded commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/vnc-enc-tight.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index ee853dcfcb8..41f559eb837 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1097,13 +1097,13 @@ static int send_palette_rect(VncState *vs, int x, int y,
     switch (vs->client_pf.bytes_per_pixel) {
     case 4:
     {
-        size_t old_offset, offset;
-        uint32_t header[palette_size(palette)];
+        size_t old_offset, offset, palette_sz = palette_size(palette);
+        g_autofree uint32_t *header = g_new(uint32_t, palette_sz);
         struct palette_cb_priv priv = { vs, (uint8_t *)header };
 
         old_offset = vs->output.offset;
         palette_iter(palette, write_palette, &priv);
-        vnc_write(vs, header, sizeof(header));
+        vnc_write(vs, header, palette_sz * sizeof(uint32_t));
 
         if (vs->tight->pixel24) {
             tight_pack24(vs, vs->output.buffer + old_offset, colors, &offset);
@@ -1115,11 +1115,12 @@ static int send_palette_rect(VncState *vs, int x, int y,
     }
     case 2:
     {
-        uint16_t header[palette_size(palette)];
+        size_t palette_sz = palette_size(palette);
+        g_autofree uint16_t *header = g_new(uint16_t, palette_sz);
         struct palette_cb_priv priv = { vs, (uint8_t *)header };
 
         palette_iter(palette, write_palette, &priv);
-        vnc_write(vs, header, sizeof(header));
+        vnc_write(vs, header, palette_sz * sizeof(uint16_t));
         tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h, palette);
         break;
     }
-- 
2.34.1


