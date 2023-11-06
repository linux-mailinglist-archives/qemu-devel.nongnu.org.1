Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F0A7E1FDC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:24:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxVM-0004Zx-Mp; Mon, 06 Nov 2023 06:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxV4-0003NS-4T
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:10:36 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxUw-00062J-JA
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:10:33 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so5576452e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699269025; x=1699873825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBR3Oh8zClbS1YQ62m6eKxWZ4Ons8qsU0E4Liv4Rvg0=;
 b=zDz4nNo5FL6bSGxz/w7Y1ZzyqgQeZyT8agZ0kj2Ph+LdVGEtqCTaubducvlUccLevD
 jtCJFJA2bshvH4Mx5bZ8N5KCU/TGyV1YhdkaerZpxZB4pOguv4Qpg3IwTmrVHPhjR3fz
 INSRywOwGDLfehMVYjMUqUKotgATzDrRRRQu3Bqk9FL0n4gAY5NsMKw1txCTs/euXVH2
 36vjXGkUFiNnFtUfIirZlO4yZPnIn0awl1NsS4uy+jQeaWcEt3rJMkog6xw8EsVijplA
 iNRqXl9dqNYuJBGD7LxBToITK1bfu0h/6iE4e9RP27qlFYv9tRX6c7aVTk9p2XooDgX7
 cK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269025; x=1699873825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBR3Oh8zClbS1YQ62m6eKxWZ4Ons8qsU0E4Liv4Rvg0=;
 b=fbfev3DlKRbsFTD6mx6/jf7pBSvwOzHYaZQLqtAkSj2UN+h8uj61wcQCZyVi+/B6Ia
 zBcRC6m9pmV7FnyLjz7G0ISCho0jimFwPn/K67DLimTD6bvD0cva/gPczcl7/b+cuGIa
 ZYlbntmUvIrhnNNns/zJ1J2tgFWQLHcXQYqpDEBB30Q+uRcXurIEHh8IwBy8NtuOPNG0
 mbILnz60iwye9EVsFVsAnpw4sDNi1zk3U1bkGA/QuKaGxBdIOD89sMGAXlWqW3duQZSZ
 SQOtknYiEa5a7bV9WF1+LKweo5JM70lS9vT5zHk+OCeikuYDl52+oX4TG3Wz+mfz3y99
 oM/A==
X-Gm-Message-State: AOJu0YyH9bWlgqa0N93B7zzmw4kx24WbYBip3/7lNp3wUdq/KoJROC7h
 ywQ0CBt0lt6g1qOTYO1nEo5Q7Pvtvb30mKYeCT8=
X-Google-Smtp-Source: AGHT+IFMIKgYKaG2x26tSZ+5foWBGqKNS7CQHWd9OLbklpXVybTTE5AVAduGsFeWircKlsRiiuVWlA==
X-Received: by 2002:a05:6512:318f:b0:509:45ed:1083 with SMTP id
 i15-20020a056512318f00b0050945ed1083mr12662290lfe.40.1699269024745; 
 Mon, 06 Nov 2023 03:10:24 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 bh7-20020a05600c3d0700b00401b242e2e6sm11965729wmb.47.2023.11.06.03.10.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:10:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Adrian Wowk <dev@adrianwowk.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 60/60] ui/sdl2: use correct key names in win title on mac
Date: Mon,  6 Nov 2023 12:03:32 +0100
Message-ID: <20231106110336.358-61-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

From: Adrian Wowk <dev@adrianwowk.com>

Previously, when using the SDL2 UI on MacOS, the title bar uses incorrect
key names (such as Ctrl and Alt instead of the standard MacOS key symbols
like ⌃ and ⌥). This commit changes sdl_update_caption in ui/sdl2.c to
use the correct symbols when compiling for MacOS (CONFIG_DARWIN is
defined).

Unfortunately, standard Mac keyboards do not include a "Right-Ctrl" key,
so in the case that the SDL grab mode is set to HOT_KEY_MOD_RCTRL, the
default text is still used.

Signed-off-by: Adrian Wowk <dev@adrianwowk.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231030024119.28342-1-dev@adrianwowk.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/sdl2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index fbfdb64e90..4971963f00 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -172,11 +172,19 @@ static void sdl_update_caption(struct sdl2_console *scon)
         status = " [Stopped]";
     } else if (gui_grab) {
         if (alt_grab) {
+#ifdef CONFIG_DARWIN
+            status = " - Press ⌃⌥⇧G to exit grab";
+#else
             status = " - Press Ctrl-Alt-Shift-G to exit grab";
+#endif
         } else if (ctrl_grab) {
             status = " - Press Right-Ctrl-G to exit grab";
         } else {
+#ifdef CONFIG_DARWIN
+            status = " - Press ⌃⌥G to exit grab";
+#else
             status = " - Press Ctrl-Alt-G to exit grab";
+#endif
         }
     }
 
-- 
2.41.0


