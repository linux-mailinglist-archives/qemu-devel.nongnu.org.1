Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD17F11F6
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 12:28:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r52S3-0005Zs-Iv; Mon, 20 Nov 2023 06:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r52S0-0005Zb-CZ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:28:25 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r52Ry-0000w9-Sa
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:28:24 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so29086445ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 03:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700479701; x=1701084501;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3EfKbgzm6zbLpJMfXMO0+9ezmggL4KqRAur7OyZvOtM=;
 b=qOWrJ9PnZca2sUknuqtL5z+WltRzkGhxaK397TlJtSDxp7TKKMih124AaqQFITAnAQ
 LYcfNByE/KN8Y6qXQj5A9g99zMbmcaofyl7cjPFuw5MNgOJe/2PisO0cP6z/GLdznzUA
 LesDwaHEW4ovhLTiX7Fd9EsrolyXu1Y5uSGssVhogDwhTibZI1eWRlDyfBrjIJn9C5ob
 Qhv29eqNDQDuk7nTY9RjOwBzlXmZU4jjyvKrqipYbUzXMaQA0oyxWoKCQv4z/28wdLtT
 69ip1/NNc8A0HlND/y9AX/1uqGMAZR3bBvO6IkFB72HWxPKCp4iCCMdh9H5QhEJ+BLAO
 FRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700479701; x=1701084501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3EfKbgzm6zbLpJMfXMO0+9ezmggL4KqRAur7OyZvOtM=;
 b=GFCZJ4NvL7Iom+dzOnmzWvkGP5FxsaIO8drplS0QC/muK+VCxF0kSt6L+9db6CYC6x
 UIuAILdvP1PaNr1m6c3YYc4r1oQ00pBvpBBtHMYj+MQA9l40ErzgQwFTuL0Tq/ORydcN
 D1TYuqAS+UkSKSjA8vheSwotuEXIy0VLCMbl8jFtReYvPNxAzGX9iSEY7B63dQc0fzU8
 3ThohHh2h/BDC19qaVEUnxRS0nDxm+XtDlH7YHAFs9qTtWto7GSwBuADYYc+v4BH4yT5
 NAmWwINHVF16jQ3EHYt9Z87HBgMrTLWcWAb/lA4ovigOh74Ryxhv48ok1UMN375KaeHn
 H1FA==
X-Gm-Message-State: AOJu0YzeMsoWNAu9rSzlxqJgUZFsYr9R2vR1jf24e7Y3p+o71iwOh8sZ
 xwq5nEPiDXkWDPr/G46LIQx9jA==
X-Google-Smtp-Source: AGHT+IFnfnEKoMb7koq1Kz8eDOJgVhUZ3ZVfWag5jYXfkinILAJoX6HcLea1ta7WgsMTrwzo2gVv/Q==
X-Received: by 2002:a17:902:f54c:b0:1ca:b820:74ed with SMTP id
 h12-20020a170902f54c00b001cab82074edmr6638327plf.14.1700479701529; 
 Mon, 20 Nov 2023 03:28:21 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 d12-20020a170902cecc00b001c73f3a9b88sm5874696plg.110.2023.11.20.03.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 03:28:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2] audio: Free consumed default audio devices
Date: Mon, 20 Nov 2023 20:28:02 +0900
Message-ID: <20231120112804.9736-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Failed default audio devices were removed from the list but not freed,
and that made LeakSanitizer sad. Free default audio devices as they are
consumed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V1 -> V2: Set s->dev NULL after free (Marc-André Lureau)

 audio/audio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index f91e05b72c..8d1e4ad922 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1758,12 +1758,15 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
                 goto out;
             }
             s->dev = dev = e->dev;
+            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
+            g_free(e);
             drvname = AudiodevDriver_str(dev->driver);
             driver = audio_driver_lookup(drvname);
             if (!audio_driver_init(s, driver, dev, NULL)) {
                 break;
             }
-            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
+            qapi_free_Audiodev(dev);
+            s->dev = NULL;
         }
     }
 
-- 
2.42.1


