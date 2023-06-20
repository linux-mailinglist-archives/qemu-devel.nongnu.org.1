Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBFF737158
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:21:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBe5r-0000PU-CC; Tue, 20 Jun 2023 12:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBe5p-0000Oj-8A
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:20:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBe5j-00050y-TR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:20:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f9b37cd58bso19579825e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687278026; x=1689870026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2jNanxy9DKkZnidqmoGWGTJx5cQVfzXmYG+LVV4faIw=;
 b=w5zYNA31mQIxjH0P3Z04seIIOs/h8X3torhdjcbKeJZehGZqvGocPU2xZIEAF3iwE2
 K/LgzAuyK4tCnLjVFN1JCXG1xRz9l6Ag482lId4ehb78D+tMBFFZNVvnJS+k/TkkE0Lb
 lkrhppifW1+1iCFmC5UJZWVdySt2lKSMrpCLOQfa+LB1/ZhzJB797twEL5yx7GnPj1gi
 2O+q7YwM+6Psd4c9X6S7g8C3ZQF3t4bdMoyjTuvvwARLpPlAm7eBiJXq3aTA+64OkvAN
 mMYRV2MxCoy3SnpqwKqaBYcluhQp91D5UYYQNR7DQm8bmwcYidALtU7CnCR6+mk4mRgj
 YVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687278026; x=1689870026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2jNanxy9DKkZnidqmoGWGTJx5cQVfzXmYG+LVV4faIw=;
 b=jYt6aP0AZyPRomLczxvOcY8gV22fhcycrGdOxLZpXPkrSZ+KEYMyoywYC0YkA8GhzS
 ukZ6Z628fkqsdNYj1MUUfJ63q4+g3o3axOIxZpmfdT9D7/kavUZX7hnZ6eu/eOTP04xO
 fKvksu2ZchvOKSnsdlEwC0BwjDfagFUPoUygD4HcXwNG+ZrsWbmtRslxcfLFMRrfDXYd
 Dqx7Zedz81N/5YT6/lmlL0Wzk7YybLBt1MzbS81yfWc4lb7eeVI18Lg2O0X0ngEVSyWp
 ljTTywQOZ+attmajiVROjfTHCstbFh8xPNzg8iNFpzz2A5UqM/tOIYpgSszvFRdGcE2N
 VMAA==
X-Gm-Message-State: AC+VfDxxp6yKrZuzx48IEsq8eaeniKmpnBl3Y+OMri1nTk4mpX4x1UTV
 LKVJb46CNnpHsj3nKLNFUVySEpQJLkadYDRDwR8=
X-Google-Smtp-Source: ACHHUZ7a/LjC6vaL1IoQ+hYbOUGFNIQ269/6ZNGNiTakflDStsnnG0KyR51UYA6OhQRWmVMff6BU2A==
X-Received: by 2002:adf:fc4c:0:b0:309:33c4:52e1 with SMTP id
 e12-20020adffc4c000000b0030933c452e1mr8377718wrs.64.1687278026149; 
 Tue, 20 Jun 2023 09:20:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k10-20020adff5ca000000b0030ae87bd3e3sm2355743wrp.18.2023.06.20.09.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 09:20:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] pc-bios/keymaps: Use the official xkb name for Arabic layout,
 not the legacy synonym
Date: Tue, 20 Jun 2023 17:20:24 +0100
Message-Id: <20230620162024.1132013-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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


