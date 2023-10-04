Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 997FD7B8E24
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8aD-0004Pf-4G; Wed, 04 Oct 2023 16:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a9-0004ON-RR
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a8-00021y-Dr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PrRv3m4bZGPyTAiy7BNkJo2MZlnYWNKA3gLTKlAQBJY=;
 b=aKtY/Yk+hr2C/tim/fb9tec+rusaWS+AVWDvs5uF7nFbYptrjO7AyZp6ejCFDA/oTxU24x
 MNneGmX8RyGqJgFa/pn6s75aRPJJrLXDAtyNzA5SFAUj/PJ5fxbjesrTp7RpinRlAxn5Lk
 eUkpNQONyd7liiN1PxZOXNyLCtXKZv8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-CzEo7hYCO9OCQJPEIE4Jgw-1; Wed, 04 Oct 2023 16:34:54 -0400
X-MC-Unique: CzEo7hYCO9OCQJPEIE4Jgw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1dd691b1037so300166fac.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451692; x=1697056492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrRv3m4bZGPyTAiy7BNkJo2MZlnYWNKA3gLTKlAQBJY=;
 b=YSNSrOy2GQDAtZCU9185nbSgavBSLckPQSPsiJloiuRv+GXNRKgIkGxjXb+sbZt5CD
 dS/WyQV9XKIcBgPXlPlL3L78g+5TJ9A2+nGF1Wjt2SbBW28bUlFKEfQU5DnS9b1SjDg7
 2WUV+B05yiTv6i97nGrTSQo5fhKQsHiNcEy8ayY63qZsqMC5onxfWKU/HZYyHExUdzmQ
 46XIQjCIWNvS+57k3bd9OqzE8YK84DpZ1jrYfriJG2JsAMaE7i7c4IOBtubSi/RxHywk
 ucET/AxVRLBeqOYgz/sakkmo6pYETCKA4aCdfYhXghARBf2PHM4LHCB//l1u7Ze5HXIK
 2WgQ==
X-Gm-Message-State: AOJu0Yy5bP6cbXnwTv0Hp0rSzJ4Gca2ws92DSVIjPbwZSLrcvGba+FnY
 w2wUJUy1vjphWLt+jOcy+/J69+xVV8KCKfzMf7SPuIyzdy+sA4bb/g+fSlZ8EdJ2pilKCkqPrIa
 MiCNZwVG2/XKNYHtTfPyj9iTIi6iI/5hzqxKJu1H1xAk8AKnPQY3kPJ0Zy8IFBep0UPpJ4371NE
 qO+w==
X-Received: by 2002:a05:6870:5492:b0:1d7:503:1502 with SMTP id
 f18-20020a056870549200b001d705031502mr3842050oan.59.1696451692726; 
 Wed, 04 Oct 2023 13:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgC6mhG9+MbWxiRb9At+VwcptAU8qp64tzyENOc4gpMInXsSCdd4RY0q7aKz371VkaKL5XCA==
X-Received: by 2002:a05:6870:5492:b0:1d7:503:1502 with SMTP id
 f18-20020a056870549200b001d705031502mr3842029oan.59.1696451692418; 
 Wed, 04 Oct 2023 13:34:52 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:51 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 8/9] i386/sev: Replace LAUNCH_FINISH ioctl with sev
 library equivalent
Date: Wed,  4 Oct 2023 16:34:17 -0400
Message-Id: <20231004203418.56508-9-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004203418.56508-1-tfanelli@redhat.com>
References: <20231004203418.56508-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tfanelli@redhat.com;
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

The LAUNCH_FINISH ioctl finishes the guest launch flow and transitions
the guest into a state ready to be run.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 38a90d4f00..764a89d3a4 100644
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


