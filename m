Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C10097B9D24
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNwj-0008Uz-5v; Thu, 05 Oct 2023 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNwL-0008KB-Rs
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNwE-0007mU-6c
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK8oUM8hm4yPhQMS2p7Odq2IdFPCpWtmlwx4Agl7pVs=;
 b=Q7PO2OBNnyl/4nwvadZooGgry02FCd+e0nb8qvymwKdwdkSKeTuUCROCZHsiLKFScm9l5i
 /HprHYc8ldkd/97Qf8gNTwUFuXDaWVE5vxvP3J2dmfcbSp7hPLUsj0AxcpwS5+puf8kcMe
 fmCxGgAlRUS5xLzIqT/lQCnqkgU8K3s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-_QE_P2cCOeCxz0yvE4F91g-1; Thu, 05 Oct 2023 08:58:32 -0400
X-MC-Unique: _QE_P2cCOeCxz0yvE4F91g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b2cf504e3aso82210866b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510710; x=1697115510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PK8oUM8hm4yPhQMS2p7Odq2IdFPCpWtmlwx4Agl7pVs=;
 b=RbfQob4/wyB/qhsNNL24BZU0+j7VjSfeAozwc5oi8RVnRckMAz5iGViv7sz7+xLQ8+
 wHKmUaSeYBdc7aZux4YKrzT1oIYSWwy+m6ZH49IgcxLk+g4qmoOC/XEY18oByHW3CRj4
 axKCYviJxbpGFltTKOWX9vNH01/c8ZAIl+niIaKDIIFN6oN500ycWgNb2++A2XrOGOA6
 AMznLkQYbBzJ9jt2sLsW0VL0B8m/fUrRGHp2lLBBb0FCl8rodZkO2ZeBUFtCthNbU77R
 UlwnCaECX7KlrDL/75kDN2AAFA3y55SVd1dYYpQmi4Xf7+PkqXzNwOujw/dFWTvAWmfI
 KzDQ==
X-Gm-Message-State: AOJu0YyOa2M5LQhqsH9xbASgSRcNlhBhp88BRxCIinzVh9aFXnSSKgNz
 b+MKzKYUo0s9C2uc6AnyoDhR8t3UTiZqolycG1dDxWQ1V9JCqDfIVZGAk6QQZI/WGj+5S/vbFjV
 1/rvKGZrTJMNX7C3LjwyapI6fbKqT0YID2oF/7AaXNnOddykl9x+GXCYD5FwP1dDvHZ3A5J2DmR
 Q=
X-Received: by 2002:a17:907:b12:b0:9b2:b763:8d6b with SMTP id
 h18-20020a1709070b1200b009b2b7638d6bmr4432347ejl.50.1696510710356; 
 Thu, 05 Oct 2023 05:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6AFhJMET+8Wtjb2BrrjQFRWziDmohRwiPppoVeegmaqolEYMUpygAR+zjOE1ZSIS3obkgqQ==
X-Received: by 2002:a17:907:b12:b0:9b2:b763:8d6b with SMTP id
 h18-20020a1709070b1200b009b2b7638d6bmr4432327ejl.50.1696510709959; 
 Thu, 05 Oct 2023 05:58:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 rn18-20020a170906d93200b0098ec690e6d7sm1168365ejb.73.2023.10.05.05.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 7/7] audio, qtest: get rid of QEMU_AUDIO_DRV
Date: Thu,  5 Oct 2023 14:58:15 +0200
Message-ID: <20231005125815.66082-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005125815.66082-1-pbonzini@redhat.com>
References: <20231005125815.66082-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index ca0df29555a..feecbc1889a 100644
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


