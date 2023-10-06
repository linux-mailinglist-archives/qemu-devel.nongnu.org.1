Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088027BB627
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoioN-0000rU-Tq; Fri, 06 Oct 2023 07:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinY-0000Wi-1A
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinT-0000ZO-A8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t7PXu2o9STYkD4Ove8P8ngjPUeCmULu2g1anj2DDGQ=;
 b=QbRiPgzvdfEBi5UH11VLT89MnDp+bzcjMZYsL+F++W4709SITZjvg2QYg17je2iCJ/5wrI
 ++nsk7+D+GTh7f+GuOQbFRpTzz4Jbfdf5g8fFPXw84/FhkAOUjdYM4UbPxb1fygIp7GO8s
 xcKdk37dW+3hGcxfas7O5Mp59NFIho4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-5f_lXw0kOg6Um8W2faM08w-1; Fri, 06 Oct 2023 07:15:03 -0400
X-MC-Unique: 5f_lXw0kOg6Um8W2faM08w-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-533f8bc82a8so1788121a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590902; x=1697195702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3t7PXu2o9STYkD4Ove8P8ngjPUeCmULu2g1anj2DDGQ=;
 b=pc7jAhOquPjNwkYOO5MXnAhpl6o3bZCqcFcKqPsA+pLYqjQIPoxd0zt2ksDsQxoOgX
 YBXIESDLjh9t0VLmwFj0sPu5eDXiDCIMjp8ZLkVcnXLRrV6infJL6nAF+Dmrw+OiHHtb
 +8VczmY0Iy7FDkJjoDieIemP4c6xD6fjJuT+DtXl3zro1B7oIcHzXNn3VeoO97oJPQQS
 WTW8sYGAH6yQEaZe3uBfBiCSSRMSi2J7w0xwRKTxpjaUeaKNpQRHaSqS/602b/j2uvoE
 ILZKVwRnU15xu97mJk8hyKZa5EWcZkEcCyf6M+45UG/f9RHS3NZJay+qrvm6vp9PXBAT
 km/w==
X-Gm-Message-State: AOJu0YwEVQrZ18Z88zruc/sGKbGVp3gs9znI7aW6ne0nKOeswOcb690x
 wRBqCpFmDY1+RgRLOKE2LKum0BxKkg2ohynHw2qeOUG9lZCHRip2hPwVc6IAq532RHqZBwmP+8V
 xisLXQoECRy1ltoUdoC+5dxDvW1a2jEqkWOvmjyeFwwvrbUPB8pUFU0tv/keWtfz44I0Wvz29sr
 o=
X-Received: by 2002:a50:fb94:0:b0:52e:86b3:a4a6 with SMTP id
 e20-20020a50fb94000000b0052e86b3a4a6mr7142412edq.29.1696590901825; 
 Fri, 06 Oct 2023 04:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6EbP2XHGzx0g9RoCqd4r6jdFNHqNj7iRo3iAjSK83fQOGlZZdMaacES+km8i5CQSPbCngiQ==
X-Received: by 2002:a50:fb94:0:b0:52e:86b3:a4a6 with SMTP id
 e20-20020a50fb94000000b0052e86b3a4a6mr7142400edq.29.1696590901504; 
 Fri, 06 Oct 2023 04:15:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 n10-20020aa7c78a000000b00535204ffdb4sm2438746eds.72.2023.10.06.04.15.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:15:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] audio, qtest: get rid of QEMU_AUDIO_DRV
Date: Fri,  6 Oct 2023 13:14:12 +0200
Message-ID: <20231006111412.13130-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Default audio devices can now be created with "-audio".  Tests for
soundcards were already using "-audiodev" if they want to specify a
particular backend, for the others remove the last remnants of
legacy audio configuration.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c          | 12 ------------
 tests/qtest/libqtest.c |  4 +---
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 73b65dc3b9b..e9815d68121 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1690,19 +1690,7 @@ static const VMStateDescription vmstate_audio = {
 
 void audio_create_default_audiodevs(void)
 {
-    const char *drvname = getenv("QEMU_AUDIO_DRV");
-
-    /* QEMU_AUDIO_DRV=none is used by libqtest.  */
-    if (drvname && !g_str_equal(drvname, "none")) {
-        error_report("Please use -audiodev instead of QEMU_AUDIO_*");
-        exit(1);
-    }
-
     for (int i = 0; audio_prio_list[i]; i++) {
-        if (drvname && !g_str_equal(drvname, audio_prio_list[i])) {
-            continue;
-        }
-
         if (audio_driver_lookup(audio_prio_list[i])) {
             QDict *dict = qdict_new();
             Audiodev *dev = NULL;
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index b1eba71ffe5..3f94a4f4773 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -421,9 +421,6 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
         int sig = SIGKILL;
         procctl(P_PID, getpid(), PROC_PDEATHSIG_CTL, &sig);
 #endif /* __FreeBSD__ */
-        if (!g_setenv("QEMU_AUDIO_DRV", "none", true)) {
-            exit(1);
-        }
         execlp("/bin/sh", "sh", "-c", command->str, NULL);
         exit(1);
     }
@@ -464,6 +461,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
                          "-chardev socket,path=%s,id=char0 "
                          "-mon chardev=char0,mode=control "
                          "-display none "
+                         "-audio none "
                          "%s"
                          " -accel qtest",
                          socket_path,
-- 
2.41.0


