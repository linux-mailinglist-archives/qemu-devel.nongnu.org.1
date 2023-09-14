Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B97D7A0ED4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsgK-0002Ez-K2; Thu, 14 Sep 2023 16:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKw-0005Ix-PW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKv-0000kj-9Q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubf6Ym3Oq8P1zXfUv1TaYbk1/ksNBIfco122yAwkkCU=;
 b=HwkWgNlvwcMEbODZr6uyLZyYLKI61Vs4e38i3zaVpwRsoFGiTFT6qYXX77NtkMD4/Iir8L
 O5F+oZVb4eu4Q0Y4GLSJoqkih2gEM3t2IEtJVst8SCieLKwq/BOOOg4z4fsu9jVAPQj+id
 UATEJWn+VQUp6LfCVdfXLb812svnQeo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-6KGUs6JIPTmLVLp7Q5ez_A-1; Thu, 14 Sep 2023 12:35:40 -0400
X-MC-Unique: 6KGUs6JIPTmLVLp7Q5ez_A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76ef205d695so165717885a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709338; x=1695314138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubf6Ym3Oq8P1zXfUv1TaYbk1/ksNBIfco122yAwkkCU=;
 b=NZzIZiFMynPv7NlIgxSSWqjCHwhfHA2Z0/5ce/pBLCPoMgPZx++RXeG6cGAHwMIqPo
 3U2AAkoppATZu9inodQLrr5pKpgYTdiKKWsIhONzwBKU8fN6L5eNo4AvSpkI0+fQZvAo
 wg8DSwgNUi33KVms0a8Y+n4qd+fd7RqmEHXcQTKlGFmiAKkC5qgfgVZ2XpqQ/JY/yeer
 8QEJoMxVHQhx4mvFdY8gBmRBBqftW6x+lrzbcTxwUvIXHjj7ociWtzL3X/0umZgl1FOZ
 lEUSI/jRXdL6OYrISD6uvpb64Wbr41Lqv6/Cxhq64quYBYdaWHmF9YBjTvVLV1jKXusf
 Puzg==
X-Gm-Message-State: AOJu0Yxu0VR+649x7fBjacmmeNESIFFBnT6gcP3yTC4YmUbcrUGlsbx2
 nQbDmX2gFwiPdhRdKLN0RAk1eKEAjjodIjeWkwpzIqtgEvgX1xjY0bFqlw1tmKc11D1vlT0Yawx
 uDM88CDyiNFQ1FRffZkPd+tKIZTTSY/YNjo4tTufGdWm6g0kyLKFv4+1qisiTI/xn+YaPDxg/ki
 cFgA==
X-Received: by 2002:a05:620a:25d1:b0:76d:312a:e89a with SMTP id
 y17-20020a05620a25d100b0076d312ae89amr2796325qko.19.1694709338243; 
 Thu, 14 Sep 2023 09:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH13uC8O5NCcnCjOIAmr7FJj9ogJcBC3IIm3A2bL8w6acFHJ1yern3oXoDcnPRP7xLfAKZq5g==
X-Received: by 2002:a05:620a:25d1:b0:76d:312a:e89a with SMTP id
 y17-20020a05620a25d100b0076d312ae89amr2796302qko.19.1694709338005; 
 Thu, 14 Sep 2023 09:35:38 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 l11-20020ae9f00b000000b007677347e20asm577244qkg.129.2023.09.14.09.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:35:37 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 8/8] i386/sev: Replace LAUNCH_FINISH ioctl with sev
 library equivalent
Date: Thu, 14 Sep 2023 12:33:59 -0400
Message-Id: <20230914163358.379957-9-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914163358.379957-1-tfanelli@redhat.com>
References: <20230914163358.379957-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Sep 2023 16:11:08 -0400
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

The LAUNCH_FINISH ioctl finishes the guest launch flow and transitions
the guest into a state ready to be run.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index a4510b5437..e52dcc67c3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -785,35 +785,29 @@ static Notifier sev_machine_done_notify = {
     .notify = sev_launch_get_measure,
 };
 
-static void
-sev_launch_finish(SevGuestState *sev)
-{
-    int ret, error;
-
-    trace_kvm_sev_launch_finish();
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
-    if (ret) {
-        error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(error));
-        exit(1);
-    }
-
-    sev_set_guest_state(sev, SEV_STATE_RUNNING);
-
-    /* add migration blocker */
-    error_setg(&sev_mig_blocker,
-               "SEV: Migration is not implemented");
-    migrate_add_blocker(sev_mig_blocker, &error_fatal);
-}
-
 static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
 {
     SevGuestState *sev = opaque;
+    int ret, fw_error;
+    KVMState *s = kvm_state;
 
     if (running) {
         if (!sev_check_state(sev, SEV_STATE_RUNNING)) {
-            sev_launch_finish(sev);
+            trace_kvm_sev_launch_finish();
+            ret = sev_launch_finish(s->vmfd, &fw_error);
+            if (ret) {
+                error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
+                             __func__, ret, fw_error,
+                             fw_error_to_str(fw_error));
+                exit(1);
+            }
+
+            sev_set_guest_state(sev, SEV_STATE_RUNNING);
+
+            // add migration blocker.
+            error_setg(&sev_mig_blocker, "SEV: Migration is not implemented");
+            migrate_add_blocker(sev_mig_blocker, &error_fatal);
         }
     }
 }
-- 
2.40.1


