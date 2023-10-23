Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B587D3BD0
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:10:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxV5-0000Do-9C; Mon, 23 Oct 2023 12:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxV1-0008Rl-A1
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:09:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxUz-0001Kt-JG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:09:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so29815285e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077387; x=1698682187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=432n4xQzBSP8lJH0hMQFD/7+8DUyL3Vy3V7TxS2yWU4=;
 b=OUAe/QStp2ZbgG+W80/DhrGe0RyJCaQax+dY1VfQ57CIJwj2DdpDmmpgMHk+4IaCr4
 beefWCvuXqS0EE6SDhZgQIRgJoLdffp3xeZwPakD0rcRovHGiCEpK7cXljQLzOLQV1+s
 EYtL0owj1Sz8pL2y2eW+D2hViWuZ2h9rZvUXTs7iDdU8/HBhSjhRDZDHokHWcBWyPpBS
 Kzf2A/hT4lyrqd+8RLXdJHRSm4sDAPh0w6jITkI3pMwV5eEKEeawcWPIH57+qhQGeytf
 /lEBFYBypZJb7H1kF2pXfR+c3YzTdJNOBuwc9+CnP9fr/MQogrmLasWQByn2FqKQlt/X
 pafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077387; x=1698682187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=432n4xQzBSP8lJH0hMQFD/7+8DUyL3Vy3V7TxS2yWU4=;
 b=MuDdzUDqmDyQkkSpGvLm3sksiStZpBnPvZ1GA+FJhXmdtOZZC0mA+6phbgPjIFtBoW
 1noFEDwGuZB0tbqudPk3m3mC0Pk4h6piAAzCe+LRkNepWILWzYs3a8gCPCjavhweCbpb
 NDfU6OyN8ArQO/Y7OPdcVIyF52BGWXoGEonLMkdcbTwL3z2jXrglwdltid+K8nIdDSKz
 d25ZsufzLOZhoUPNyKavFVvQ/0PO/iOeJLHlt5Z6tfEKlFEJz9XdcL6vFQMlHf2muIS6
 mD+Y/0sGMEl2sLoAkOJKldalPeH7NF1RIpOb9BovFZH9iQLvboppcboDo4Mnt10PmMlb
 l6gg==
X-Gm-Message-State: AOJu0YzdaqpATTCmYl7wTa1sbjnnqcPlDDbnbRWPRPNgb2dI/995FMMU
 4qn32jtMDNAcdXSNOqOimHmcbkXn2i3+/ZdnrqA=
X-Google-Smtp-Source: AGHT+IGf++9weWY46f/CQQgs97kf91yqDe+JvfMgoQTXGBZl4tF4bPAn7Kup0GsL9kftR8iV8jndiQ==
X-Received: by 2002:adf:e551:0:b0:31a:d4e4:4f63 with SMTP id
 z17-20020adfe551000000b0031ad4e44f63mr6031463wrm.18.1698077387468; 
 Mon, 23 Oct 2023 09:09:47 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 e16-20020adfef10000000b0032d8354fb43sm8120053wro.76.2023.10.23.09.09.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:09:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] tcg: Use tcg_gen_[s]extract_{i32,i64,tl}
Date: Mon, 23 Oct 2023 18:09:35 +0200
Message-ID: <20231023160944.10692-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Based-on: <20231019182921.1772928-1-richard.henderson@linaro.org>

Philippe Mathieu-Daudé (9):
  target/avr: Use tcg_gen_extract_tl
  target/cris: Use tcg_gen_extract_tl
  target/mips: Use tcg_gen_extract_i32
  target/ppc: Use tcg_gen_extract_i32
  target/sparc: Use tcg_gen_extract_tl
  target/xtensa: Use tcg_gen_extract_i32
  target/mips: Use tcg_gen_sextract_tl
  target/cris: Use tcg_gen_sextract_tl
  target/ppc: Use tcg_gen_sextract_tl

 target/avr/translate.c          | 18 ++++++------------
 target/cris/translate.c         |  6 ++----
 target/i386/tcg/translate.c     |  9 +++------
 target/mips/tcg/mxu_translate.c |  6 ++----
 target/mips/tcg/translate.c     | 12 ++++--------
 target/ppc/translate.c          | 28 ++++++----------------------
 target/sparc/translate.c        |  6 ++----
 target/xtensa/translate.c       |  6 +-----
 8 files changed, 26 insertions(+), 65 deletions(-)

-- 
2.41.0


