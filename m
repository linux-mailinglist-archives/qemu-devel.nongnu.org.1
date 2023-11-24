Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70B7F77B8
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2h-0004hF-B7; Fri, 24 Nov 2023 10:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2f-0004h3-Fu
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2e-0004Ay-1k
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtFo/B8xEGoyrSgNCfhRFu5ifrwebiHFtXFyMhpJy0A=;
 b=M9LtCLO0JVej3VTAdbBIxGD/pDVuKKOm4lVVHMAAos7/ctdJ4eGBorfX0G3teBaAgoOXA0
 JfUrS2nIeAS812Q5kjXNGUI3UR2uYAyPLi7UIHKCQ2ae7eUq+3QpIHUyK+DmFI/mYcIxbF
 qk3qzUu64qfKOPWTOFTjPAWepapIkfc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-FpPuOUWJOa-exYUWgJhYlQ-1; Fri, 24 Nov 2023 10:24:26 -0500
X-MC-Unique: FpPuOUWJOa-exYUWgJhYlQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41e58a33efaso20633001cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839465; x=1701444265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtFo/B8xEGoyrSgNCfhRFu5ifrwebiHFtXFyMhpJy0A=;
 b=s6yX7ZdaF6mWCPOGNORhsGIp4ZfocdOc8k1P7yAR1mBJ28gny9gMGFnVNoBfROO48t
 sFaO0ohsK1tVtZH3E7E0Jd7cuJa39EvmGT7WnZVSJafr67bmPAGySbccAgkcIQ+a63wc
 iA7pu6ROTzVR6jjAHi3R4bfB97iMLKkZ0hvYubQiZW0Tjmv5O7PgmHik3vTM7D0HgavV
 Y+bWRpczJkKSqt674zmvduohszpvEyujurIELfiO0+aDt7Bip2z1eLNRRC9tIIa+Vn4P
 EmGWl/IcuYfh2sl/p3R2Jyl7GW4EWdk4dg1JIeg5NzqIEeztwyZDbWYFv3ea/8CIPnwy
 nsKw==
X-Gm-Message-State: AOJu0Yy89vsf6cJOLPHproTYLEV8mh1gwa8ZC6qeba5ySZbIZhi6oVD/
 1JpzHViMq/K3RiZGpRcJpvKL/5YL2Mg/uW9HbpIYmhCIIj9JgFjKWXXczOYPchtCg0GSgxMqIzG
 3lR/26B7vxFxVB9JGW62mypD/6+sFZZNW+QUTI81ej0zYpI6wH/xQGeP5/EjnPigBDftwpKTKLo
 w=
X-Received: by 2002:a05:622a:1821:b0:421:c6ef:4b0b with SMTP id
 t33-20020a05622a182100b00421c6ef4b0bmr4119257qtc.17.1700839465164; 
 Fri, 24 Nov 2023 07:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExNFtjHzw112K/xwDb+0o4b4NY0Vfb34g4hUo7i9WZ6PuxyGylNq+BEXNaYpHWs5qCnzTFbQ==
X-Received: by 2002:a05:622a:1821:b0:421:c6ef:4b0b with SMTP id
 t33-20020a05622a182100b00421c6ef4b0bmr4119225qtc.17.1700839464762; 
 Fri, 24 Nov 2023 07:24:24 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05622a029600b00423907c8ce4sm1091091qtw.33.2023.11.24.07.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/10] audio: Free consumed default audio devices
Date: Fri, 24 Nov 2023 16:24:04 +0100
Message-ID: <20231124152408.140936-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Failed default audio devices were removed from the list but not freed,
and that made LeakSanitizer sad. Free default audio devices as they are
consumed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20231120112804.9736-1-akihiko.odaki@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index f91e05b72c9..8d1e4ad9227 100644
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
2.43.0


