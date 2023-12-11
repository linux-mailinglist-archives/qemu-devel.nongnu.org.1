Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242580C460
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:21:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcTt-0000Gh-IO; Mon, 11 Dec 2023 04:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTU-0000GA-E1
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTE-0005vK-Qy
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:16 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so11093495e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286457; x=1702891257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aqd0pfIovAzzjPlAx4oEmpXI090Lp7qY6On7DWG3S3w=;
 b=UKCmXlgXsAK0g99t71Sm2+ADEWaZvCCg57pdSE+P7pQGOcrhHVgiBG7EAbpRI14Hud
 k4mEzvx9HYwhDB6U42b5PdQo1Y+jq++/AViXn7YD1qMcbJH/TT2mQyc6jdq2iahXB+D2
 xDNHumvNzbwr/CafwDcS3srLGXt7O7wz63dGyyQuePPccglYrW1aHVSIm7p3nOrvWHbP
 SporDZrAff7E0x0pB/pWa5GEfANY0Ric/ghPuHyIpYbce5p2F4kMNoxckweHlHvTPmTl
 zG9NjU7gm/uHB56/+OIrt4p0lWIfedigW5KX1Ucb+4mzUp2e49rOnpiYBAwSaBUqA83K
 aixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286457; x=1702891257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aqd0pfIovAzzjPlAx4oEmpXI090Lp7qY6On7DWG3S3w=;
 b=ALS7IcIlpn/Uv2h9X2OA+cT8+tr3imOl1vWXWhPAokK3Cywe6nng1Nlti2bWvombmX
 ZOK68rNZ2/OXii4ezXoOlSj0KP4eRFyYvsHDPG+6/zSZw0MZtEiVv2wTYuot/5jdY7VO
 d9ZQpk71PTe3Y56wzLEWtT7teB38+PiVMjBRflOH6sFhwihiqN/sJdY56pbD4qu3q7Kg
 XI/35FC65TyPqJ1GqBYRGX4wkfguouGE3rWOwIcl3GHpHPNr8GdwytKDy8VKf3EvUFsm
 yIqZ58sVoSlREtPckb47sw5G3Re+t6SkeaO5qiLmFhs8tWbHMefl7mck8C636UwX8hXr
 FXOA==
X-Gm-Message-State: AOJu0YyCjjgrcJTYa0i2RXL3r65gvOjICgacpoh6tzc+CKkTo2miev+h
 MqH1O1krmrsDmkthW0gBo1+LyA==
X-Google-Smtp-Source: AGHT+IFPfdlMrtV9myvAKRErqFuQJ7JYn9P0M4z1qgz5Cd53FMH9CsdGniszkXLfiN5IABE5QTWVdA==
X-Received: by 2002:a05:600c:3d1b:b0:40b:5e56:7b6e with SMTP id
 bh27-20020a05600c3d1b00b0040b5e567b6emr1926390wmb.183.1702286457498; 
 Mon, 11 Dec 2023 01:20:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b0040c1d2c6331sm12343122wms.32.2023.12.11.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:20:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2AA165FBD3;
 Mon, 11 Dec 2023 09:13:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 12/16] chardev: force write all when recording replay logs
Date: Mon, 11 Dec 2023 09:13:41 +0000
Message-Id: <20231211091346.14616-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is mostly a problem within avocado as serial generally isn't busy
enough to overfill pipes. However the consequences of recording a
failed write will haunt us on replay when the log will be out of sync
to the playback.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2010
Message-Id: <20231205204106.95531-11-alex.bennee@linaro.org>
Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add explicit if REPLAY_MODE_RECORD leg with comment.
---
 chardev/char.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 996a024c7a..48f28881c2 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -171,6 +171,18 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
         return res;
     }
 
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        /*
+         * When recording we don't want temporary conditions to
+         * perturb the result. By ensuring we write everything we can
+         * while recording we avoid playback being out of sync if it
+         * doesn't encounter the same temporary conditions (usually
+         * triggered by external programs not reading the chardev fast
+         * enough and pipes filling up).
+         */
+        write_all = true;
+    }
+
     res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
 
     if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
-- 
2.39.2


