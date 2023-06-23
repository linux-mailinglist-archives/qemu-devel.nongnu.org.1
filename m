Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D873B78D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxW-0003JK-Jv; Fri, 23 Jun 2023 08:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfxB-0001vm-MU
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:56 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx9-0000jM-1K
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:53 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f8792d2e86so749637e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523509; x=1690115509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Aj+7Vhckjn7QgQCBHiXPLMCnaVGWCaLnkpclM6BwXm4=;
 b=s/9lN3EzzQrVkb6tRA0HpDJ9XM4TulHv0PyrbFbJajMqsd7qgTQzArXjiYrUeDh6te
 rMN2aPryQoLHJh+d5tzTWX1bz7g0up7xXY+JKe90oEIBTJ4MyNc7vRA5oCsXNGxEz0yW
 dzqww6zyWhzMrGEw7GPGWr1w57um6ugs7x3AzSN/5Nv9qokKt7vvqC4phSE8hxfypinh
 Ie0fRSjuV4EOQdz+64os8BQmlNtLMiWPORDvS+WuwKCzELIeuTUpJNlrs3z9CtbKt9Dl
 +pZrI88W4xzkaNmyY2Bg8IDwfM3GOmF4WAbFMgt9W0bNMf+un9cdPITpcTNcmdna/Rjb
 HsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523509; x=1690115509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aj+7Vhckjn7QgQCBHiXPLMCnaVGWCaLnkpclM6BwXm4=;
 b=irlvWUFydRGun98O/eN7IPY9pETQaVr3ZoQuRfAdDwEW7P5hg8doO7+yUQQgOsC5do
 RFFrgLKmpBBTdbFN4iP2NvGRbac2/ULEDLhQN6Gjn1EFXps1kGcAh4weV/SVLjmxGura
 gscqwlxl4EYAedb3GALFSKv+unlIJkT51IV3J05FMGNZ+e4bFWfOXnZB67CR0jeqT8Qe
 ghDkWcnIR0s2tj9OYWKjFXcB8kJtjlWPneTajQ6tq0ib6BlEPJfmYgWdcN8aVYnDDsfl
 F87ePe/JmJyK6RlxurKu1pYN631jq8MsXtY0HBC0mwqwzr9Fjn07L/0V11ttFtZbeC8+
 a41Q==
X-Gm-Message-State: AC+VfDzQCrekzxat+2hjt7GkTfipO0jHKIhaLyrsUk+wtr5aoC/uHPYb
 p3NjRahYOn6nsqEI6HkgUCzI35IlJjpPh4/mBoQ=
X-Google-Smtp-Source: ACHHUZ6Npk9HIax0jkvQPyCoWcnzbXQArhwum8oNiKrsWLMs7beZsFEE0Ge6i3YTBdPYe67lD0A32Q==
X-Received: by 2002:a05:6512:b94:b0:4f9:5ff6:c06a with SMTP id
 b20-20020a0565120b9400b004f95ff6c06amr5392560lfv.67.1687523509201; 
 Fri, 23 Jun 2023 05:31:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] pc-bios/keymaps: Use the official xkb name for Arabic
 layout, not the legacy synonym
Date: Fri, 23 Jun 2023 13:31:35 +0100
Message-Id: <20230623123135.1788191-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

The xkb official name for the Arabic keyboard layout is 'ara'.
However xkb has for at least the past 15 years also permitted it to
be named via the legacy synonym 'ar'.  In xkeyboard-config 2.39 this
synoynm was removed, which breaks compilation of QEMU:

FAILED: pc-bios/keymaps/ar
/home/fred/qemu-git/src/qemu/build-full/qemu-keymap -f pc-bios/keymaps/ar -l ar
xkbcommon: ERROR: Couldn't find file "symbols/ar" in include paths
xkbcommon: ERROR: 1 include paths searched:
xkbcommon: ERROR: 	/usr/share/X11/xkb
xkbcommon: ERROR: 3 include paths could not be added:
xkbcommon: ERROR: 	/home/fred/.config/xkb
xkbcommon: ERROR: 	/home/fred/.xkb
xkbcommon: ERROR: 	/etc/xkb
xkbcommon: ERROR: Abandoning symbols file "(unnamed)"
xkbcommon: ERROR: Failed to compile xkb_symbols
xkbcommon: ERROR: Failed to compile keymap

The upstream xkeyboard-config change removing the compat
mapping is:
https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/470ad2cd8fea84d7210377161d86b31999bb5ea6

Make QEMU always ask for the 'ara' xkb layout, which should work on
both older and newer xkeyboard-config.  We leave the QEMU name for
this keyboard layout as 'ar'; it is not the only one where our name
for it deviates from the xkb standard name.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230620162024.1132013-1-peter.maydell@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1709
---
 pc-bios/keymaps/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index bff30833137..0bd8ce00775 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -1,5 +1,5 @@
 keymaps = {
-  'ar': '-l ar',
+  'ar': '-l ara',
   'bepo': '-l fr -v dvorak',
   'cz': '-l cz',
   'da': '-l dk',
-- 
2.34.1


