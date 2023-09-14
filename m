Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0016D7A0C22
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:00:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqcL-0003OT-OU; Thu, 14 Sep 2023 13:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqcJ-0003Nk-Mv
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqcI-0002IU-Ao
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubf6Ym3Oq8P1zXfUv1TaYbk1/ksNBIfco122yAwkkCU=;
 b=KvmncdtTbYoxV0WJ2Eku79aEeei0dPSxO2ObwN0aHxAkYdCgCgUl4/y+FEgGPIxwRiTUHE
 at/cfaDSjxBqubd6wqDijvhHEP38KMOU04HAd138ZM3b+mZ3DiGCEECA8h29BdX1sect55
 GZnlYS9WF7GGJYttQcsWJmbA05sgt8o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-8ZDP6eGPOo6nk-W9rfSNUg-1; Thu, 14 Sep 2023 13:59:00 -0400
X-MC-Unique: 8ZDP6eGPOo6nk-W9rfSNUg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-655d3c7e27bso14374456d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714339; x=1695319139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubf6Ym3Oq8P1zXfUv1TaYbk1/ksNBIfco122yAwkkCU=;
 b=IHNEgdgjsbl/Ko0oUBhGm5H2qdC6z1pf7d04l++KsolQxshl1sctBaqeegU+1HQv6i
 azdWDzJdbJD3UyHZzdVDIrlAyJotbbcm9xJVVuY/GwacOYKyNOCUA6FI6jil4sbk0RJV
 dn5yzxcdStQ5qixcjQ7xHbh0cXjIeX6Uybt+aygOP19+An9OiCa8fEz0ln+PDOdNJjnd
 pwykGmmVzn+VzjyKdAgeUNeca5uDeFBx41zfNeTvXt9cG9W/uscXi8riQL0QyRHwO7ip
 q/sWe0v/91betHkQXGZOEx5TPaAFeRljpozVbowaP4Pb2AMADzzo7A+iwA74QsS/o7jG
 KA5g==
X-Gm-Message-State: AOJu0YzM0NSLbjohpjPCpr3M7LyGYYqZr/YquXoST2lsrHppymZCHoyv
 AhLJ4TZAzQr4eAY7r8mKXkxgKYgzVKJhwGzaAKql/MWLWOPn8qLVdkd+3isGjqivQvHYANJaV8h
 /wJ49qKTca58C397maAmcI/nIwoYLtp4d6uYxcPyqjc20lFsGN+DbNBgjtKnAuuTYJTanjKcytA
 6hXQ==
X-Received: by 2002:a05:6214:4a90:b0:64f:92dc:3de2 with SMTP id
 pi16-20020a0562144a9000b0064f92dc3de2mr6784207qvb.53.1694714339196; 
 Thu, 14 Sep 2023 10:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0d0qkKXvyyHs1MRiX9eIp0V1nRA4A5Z5QxKY6W4kB32tHimgTImPWpQehxpTp9NFkLh6vWw==
X-Received: by 2002:a05:6214:4a90:b0:64f:92dc:3de2 with SMTP id
 pi16-20020a0562144a9000b0064f92dc3de2mr6784197qvb.53.1694714338996; 
 Thu, 14 Sep 2023 10:58:58 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:57 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 8/8] i386/sev: Replace LAUNCH_FINISH ioctl with sev
 library equivalent
Date: Thu, 14 Sep 2023 13:58:35 -0400
Message-Id: <20230914175835.382972-9-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914175835.382972-1-tfanelli@redhat.com>
References: <20230914175835.382972-1-tfanelli@redhat.com>
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


