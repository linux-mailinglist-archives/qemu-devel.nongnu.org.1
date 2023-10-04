Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2927B8E1B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8a1-0004Lt-5K; Wed, 04 Oct 2023 16:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8Zw-0004EI-3P
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8Zu-0001yQ-MM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBzjprgJ1bZ7gzci2vd9rFrED9M9PnaSbeaupz96L54=;
 b=L6pxQkqEPz1NI7aNbNlPaVUMqpfmleVosoGcIf4/3ikiNPKnQQOS1xu1jL5JqEhE+GGOwF
 qm/VJnMBPvNTkTg7leSn6g/yjhYV51bXbXJdJfbjPlYYdoRixTsk9aFRQOuwGqOKAmBcHZ
 CcO7lbsk8uk6GV6wME1XVCC1dis6R+k=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-lboOQWJpOIyfJGiBgYD7hw-1; Wed, 04 Oct 2023 16:34:40 -0400
X-MC-Unique: lboOQWJpOIyfJGiBgYD7hw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6c4b9cab821so302162a34.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451679; x=1697056479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBzjprgJ1bZ7gzci2vd9rFrED9M9PnaSbeaupz96L54=;
 b=ob4msvscDZRpwYR8rOzcy0V3auFXXvYb/4tr/tuZXxP8tPiRFGjebCArnP+qIgbk6A
 YHuS12NdaEiknkbgZ4Z4mMwK9eDMOCqPtLkOmM1F2tbpTE887h6IFWuvU/2bqKQ4NLvv
 gMFXIkEszctUb9YBQGTuamsVZCbmbvatmSUg2L8nmNRD6s2FPlNhh1jKZIKznTtiyVOj
 +IxREGPmtx1E90YuzxhGzVUq780efgf68ENPh4gDePI6NaHmQnU8ZxpQT2A4tnea2Nyl
 EbW8gfF1tKA9qdQjZv2r7pbYANk0y/3YVk5TuhONx8IZPhTMVncCHo552vkIZJVs03YA
 6luQ==
X-Gm-Message-State: AOJu0YwZkpSUUtvdEfjHnTBCHFcN6RltcZQo1g78gldOznnKKBDCCgtE
 7cXeluWsncucRsgfGHuZg0W7a1BPvrTWrGzA9trzi3CCx5b4ytLjrEZoCuHxMd+CsYKak4swT7u
 toX/sDiw9SY7gtDp+50ztorehI6s7oR1f3JC6j+9xkM2AlwUQ+/EiaifCCzRD2FP3mD5WYWJ39t
 o2QA==
X-Received: by 2002:a05:6870:14c1:b0:1bf:df47:7b5e with SMTP id
 l1-20020a05687014c100b001bfdf477b5emr3544949oab.16.1696451679022; 
 Wed, 04 Oct 2023 13:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlKbVSN/WBQbVgm/vd4fX99HW52s2CGCZ88USgdfqrUkt8aOB40SROFbOgm/aW6SrrWUCpmg==
X-Received: by 2002:a05:6870:14c1:b0:1bf:df47:7b5e with SMTP id
 l1-20020a05687014c100b001bfdf477b5emr3544931oab.16.1696451678713; 
 Wed, 04 Oct 2023 13:34:38 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:37 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 3/9] i386/sev: Replace LAUNCH_START ioctl with sev
 library equivalent
Date: Wed,  4 Oct 2023 16:34:12 -0400
Message-Id: <20231004203418.56508-4-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004203418.56508-1-tfanelli@redhat.com>
References: <20231004203418.56508-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The sev library offers an equivalent API for SEV_LAUNCH_START. The
library contains some internal state for each VM it's currently running,
and organizes the internal state for each VM via it's file descriptor.
Therefore, the VM's file descriptor must be provided as input.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 80 ++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 50 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 97388f5fa2..4c888fa77f 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -715,51 +715,6 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
     return 0;
 }
 
-static int
-sev_launch_start(SevGuestState *sev)
-{
-    gsize sz;
-    int ret = 1;
-    int fw_error, rc;
-    struct kvm_sev_launch_start start = {
-        .handle = sev->handle, .policy = sev->policy
-    };
-    guchar *session = NULL, *dh_cert = NULL;
-
-    if (sev->session_file) {
-        if (sev_read_file_base64(sev->session_file, &session, &sz) < 0) {
-            goto out;
-        }
-        start.session_uaddr = (unsigned long)session;
-        start.session_len = sz;
-    }
-
-    if (sev->dh_cert_file) {
-        if (sev_read_file_base64(sev->dh_cert_file, &dh_cert, &sz) < 0) {
-            goto out;
-        }
-        start.dh_uaddr = (unsigned long)dh_cert;
-        start.dh_len = sz;
-    }
-
-    trace_kvm_sev_launch_start(start.policy, session, dh_cert);
-    rc = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_START, &start, &fw_error);
-    if (rc < 0) {
-        error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
-        goto out;
-    }
-
-    sev_set_guest_state(sev, SEV_STATE_LAUNCH_UPDATE);
-    sev->handle = start.handle;
-    ret = 0;
-
-out:
-    g_free(session);
-    g_free(dh_cert);
-    return ret;
-}
-
 static int
 sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
 {
@@ -913,11 +868,13 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     SevGuestState *sev
         = (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
+    gsize sz;
     char *devname;
-    int ret, fw_error;
+    int ret = -1, fw_error;
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    guchar *session = NULL, *dh_cert = NULL;
     KVMState *s = kvm_state;
 
     if (!sev) {
@@ -1007,23 +964,46 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         goto err;
     }
 
-    ret = sev_launch_start(sev);
+    if (!sev->session_file || !sev->dh_cert_file) {
+        goto err;
+    }
+
+    if (sev_read_file_base64(sev->session_file, &session, &sz) < 0) {
+        goto err;
+    }
+
+    if (sev_read_file_base64(sev->dh_cert_file, &dh_cert, &sz) < 0) {
+        goto err;
+    }
+
+    ret = sev_launch_start(s->vmfd, sev->policy, (void *) dh_cert,
+                           (void *) session, &fw_error);
     if (ret) {
-        error_setg(errp, "%s: failed to create encryption context", __func__);
+        error_setg(errp, "%s: LAUNCH_START ret=%d fw_error=%d '%s'",
+                   __func__, ret, fw_error, fw_error_to_str(fw_error));
         goto err;
     }
 
+    sev_set_guest_state(sev, SEV_STATE_LAUNCH_UPDATE);
+
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
 
     cgs->ready = true;
 
-    return 0;
+    ret = 0;
+    goto out;
+
 err:
     sev_guest = NULL;
     ram_block_discard_disable(false);
-    return -1;
+out:
+    g_free(session);
+    g_free(dh_cert);
+
+    return ret;
+
 }
 
 int
-- 
2.40.1


