Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA37F04D5
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 09:41:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4dLm-0003Fx-QH; Sun, 19 Nov 2023 03:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4dLk-0003DA-K4
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 03:40:16 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4dLi-000689-85
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 03:40:16 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cf5901b4c8so3767935ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 00:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700383211; x=1700988011;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FA/5Bi7G0NWzKyGaCdZ2k3FjRDwQqnhhFEZvbR4rPX4=;
 b=yK4Ro606NT1xldONgSZecG2XXn8dwwKCBKLxQeqpNu0ahYjNOf68HFGDfIoVswVPVg
 oRyoxECkIBavopbqxq6Wv8Gwla9mCQcTdcx5EqBmM+8eRE1hqTLtlwcsCNF70G4ou0zY
 CXDPQbNYyeqjmG541/mXN0o3cjCQCZGM2wNdOuQNN23Lte4H6NHd78MK3tXp9dZINRBZ
 5OS5X/HCAlJUdLvG/RzEjV7XdqIN8UEM13PXvAWjzRFmM4SKsH7xlATdQER0MKKlNy81
 yuFw0mNEDecJohm79CJYOxMz7zM75wZAJqgjM38+ilwupu736EvN6CjZ8EnWoWtMyRis
 tu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700383211; x=1700988011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FA/5Bi7G0NWzKyGaCdZ2k3FjRDwQqnhhFEZvbR4rPX4=;
 b=YI/ZKIYbvzEw+L7hw3fIzStrNkvuXqgOi1lzF9ILDTQViVtc2JfCTNjenJh8ZS1J+E
 s/BX0Mojee8jxu5/UyIk1wEuzETZoqje1tIBKTGD9MM7R3z3J+TAcMdlhsVwWK44TEJw
 1MKBpIYiEuP8JOaXF0TeNH8Uiq6uhAF6sA3yHJTOuDcMnaVyGBsUeqjsyhp4wZK7mEWG
 tlKX86cyrT7IM4E1XoRfHuIHObzFe6oU/iTKBylZ4Wjd3L1jwb5hdb3q0yTmUGZydIQy
 jq/OpYr5/rmsUWzMH24Tj/miPz4EGkXPYutZJxm0OE91Kvsty44AmagUC/30GFrkukkR
 CHZg==
X-Gm-Message-State: AOJu0Yzwi5IIFDppP69t6Rupx6kXGjGJOOVCl44xYl7dftBhtsiI4gID
 CDwa1lw9IWKyDfxh5h+xU86bXA==
X-Google-Smtp-Source: AGHT+IGRmDNQt1zR+KXGlRu+eMD2m+EcA5IYpLXy2ECqsMggEcDclcVleHpF2gUiInbNJe+SPJd9yw==
X-Received: by 2002:a17:902:da88:b0:1cc:3fc9:7d09 with SMTP id
 j8-20020a170902da8800b001cc3fc97d09mr5801252plx.15.1700383211622; 
 Sun, 19 Nov 2023 00:40:11 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 b6-20020a170902b60600b001b86dd825e7sm4018691pls.108.2023.11.19.00.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 00:40:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] audio: Free consumed default audio devices
Date: Sun, 19 Nov 2023 17:39:38 +0900
Message-ID: <20231119083940.20558-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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
 audio/audio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index f91e05b72c..becf6cdf46 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1758,12 +1758,14 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
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
         }
     }
 
-- 
2.42.1


