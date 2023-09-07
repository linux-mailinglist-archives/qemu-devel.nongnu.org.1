Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB47972A1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEcm-0002k4-Gp; Thu, 07 Sep 2023 09:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEci-0002hK-Sh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcd-0007Dm-T7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFc/BqGdfw0tOBKRYWZej0aZEHYoNuS3b5fNkajvzKI=;
 b=LaZUuf4VxFqUpr0Hfuo608yiP1SPCrdnwqMpRSooJdJ+K5Mdk+H2E8e3depEyI7sUmAIhn
 b0th0FY48OP899/eDSH7JtF8XtwU9VMT+LyXUj3lTIQNJ6RkwrFoikH+EznzVdlCc9VT7U
 e5qqlfIN/jk5yeqqU28mkkmRRF+r1DA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-31kPkkS3N4mftT6YNDtueA-1; Thu, 07 Sep 2023 09:00:33 -0400
X-MC-Unique: 31kPkkS3N4mftT6YNDtueA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fefea09bd0so6264685e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091625; x=1694696425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFc/BqGdfw0tOBKRYWZej0aZEHYoNuS3b5fNkajvzKI=;
 b=M65AVMywun6xJGdaOLr7Kck3QMxHG4LB6nQkbGREDVXSm6Q1xbRmcJBzK98cMWkhwC
 cBM55CKr9YH7yN2NNBM3E6EKoLtzTfmq1PWIQ3RRtbhgJAGm/wyPLKJlZw4qssXq7K17
 K50/ueLjQAWlbh1+TunBk0ZlRoYpy5rpgxe3iAmC3BhUzNL9guhLw+uYUHb4f5+CU3eX
 px7Irgt0IjeHqG4IUrF1P67VP8TGVat7sZiGVqwFUKKF39YG4xnT0hLuUCa3Boo0eu6X
 IkbvRpabnedy2TNGL5gB7/uuqp8OtsJ4SguFbloDtDQPJbBtdPhzDw5b5PbvIYY/agJG
 ZBbA==
X-Gm-Message-State: AOJu0Yyij6rETMd94KSBgmMFcSVAl1PW7QEgvUFqhQriDZDeps595eHg
 EEOYt7ot2Vml2u6a4aPide8FqaxVs2KS6DKsfVa83Xjqww342teIENqoA58PCTCn+f/bJ6DkK+u
 qZkG1J7g+N+ZfVRV3jEnav0QrQazjsylBDuSlLBVTRiS2F4oljOQg6u8Rlf/mLgKTsaBz1y3LE8
 c=
X-Received: by 2002:a7b:c389:0:b0:3ff:28b8:c53d with SMTP id
 s9-20020a7bc389000000b003ff28b8c53dmr4592326wmj.33.1694091625478; 
 Thu, 07 Sep 2023 06:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFbZcpkSC3JKCV1b7jchYVsp4YqnGbzzW72o8bXkXfiRqPEOfBNxvmMMHVOk0gvFeh0egU3w==
X-Received: by 2002:a7b:c389:0:b0:3ff:28b8:c53d with SMTP id
 s9-20020a7bc389000000b003ff28b8c53dmr4592305wmj.33.1694091625168; 
 Thu, 07 Sep 2023 06:00:25 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a7bc042000000b003fbc30825fbsm2438452wmc.39.2023.09.07.06.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 08/51] os-posix.c: create and export os_set_chroot()
Date: Thu,  7 Sep 2023 14:59:17 +0200
Message-ID: <20230907130004.500601-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230901101302.3618955-4-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/os-posix.h | 1 +
 os-posix.c                | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index d32630f9e76..8a667633953 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -51,6 +51,7 @@ int os_set_daemonize(bool d);
 bool is_daemonized(void);
 void os_daemonize(void);
 bool os_set_runas(const char *optarg);
+void os_set_chroot(const char *optarg);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/os-posix.c b/os-posix.c
index f0ee5c8b002..ed0787ecfd9 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -159,7 +159,7 @@ int os_parse_cmd_args(int index, const char *optarg)
         break;
     case QEMU_OPTION_chroot:
         warn_report("option is deprecated, use '-run-with chroot=...' instead");
-        chroot_dir = optarg;
+        os_set_chroot(optarg);
         break;
     case QEMU_OPTION_daemonize:
         daemonize = 1;
@@ -184,7 +184,7 @@ int os_parse_cmd_args(int index, const char *optarg)
 #endif
         str = qemu_opt_get(opts, "chroot");
         if (str) {
-            chroot_dir = str;
+            os_set_chroot(str);
         }
         break;
     }
@@ -232,6 +232,11 @@ static void change_process_uid(void)
     }
 }
 
+void os_set_chroot(const char *optarg)
+{
+    chroot_dir = optarg;
+}
+
 static void change_root(void)
 {
     if (chroot_dir) {
-- 
2.41.0


