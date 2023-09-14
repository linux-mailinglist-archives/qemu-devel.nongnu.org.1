Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90E7A0ECF
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsgN-0002NF-5C; Thu, 14 Sep 2023 16:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpL4-0005e6-Rb
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpL3-0000lr-6m
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sK9qSi08IdhuNBweHKbDKawtZ28B4JO2EvdjNn6LOA=;
 b=Od6iGU1aw4qAx/rxOkEhiS15wB9VR0nY+XNES95mpP/TBFTPiZAdwBliJB3LoDZNlJOPhP
 oM+ImyCn6HhN5HXixVHUDYz7Hgphv0zQ85JRUaqXHaOKhb8yAG5oT791xuZ0bohGAHkJKC
 9QNxsIJUA7gcmGiXFVAlE5HRbemaY1I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Vv8eU2sSMeKLSWnQNeU3pw-1; Thu, 14 Sep 2023 12:35:30 -0400
X-MC-Unique: Vv8eU2sSMeKLSWnQNeU3pw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-770f1f0e2a7so143475885a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709328; x=1695314128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sK9qSi08IdhuNBweHKbDKawtZ28B4JO2EvdjNn6LOA=;
 b=aN8e1kRnDwRfoIgw14sKjlL8fnm8B/qBJhVEdgpRaSvIvaHvmAhTlHUkdSkiubcpdd
 UHNzLT1NJsLkaniLmYLqsfOStwDOROdPRQAFXuw1D/GBcGhg7+5VjduzimOu1fHmhJUF
 vbJGxMP9OjsIRWSoqZUyf0XZhulZ0KdrSyLoslawQLipBHmjUPP7rRl4S358wDKo51Ti
 jHdO29ivUje4pTQ8c6vKpyDWm8rwqQ2HEtX9czyg6rknj4ecDhFdrW3BmxNALA5zFA/L
 hE/RzA+9td9XWs5k2Q6UDz5h4nlucSeNGf2OaJBm1jm5Lw1rt+aLOMdp7OHtSa5dUgbc
 AbJg==
X-Gm-Message-State: AOJu0Yx21ea+4lrtAS6YDPm/xqcze9T4mQhq0dw9tzIt56CEOjqHaLY1
 ZW63UrDX5aWTsQOV1/Qf57ukpCkVS2umkUuLrRDofYDS/+jCOB2iWF39mhXnxNWHIbkklBOvr3T
 Aki2Id3NHnxfGz6A0TnQ3Hyx8QFdlQQDED62+QjYEpiqGZF8Rric8ty2FyNajSIs3FJHeydiQz/
 urtw==
X-Received: by 2002:a05:620a:11b7:b0:76e:ef17:d37e with SMTP id
 c23-20020a05620a11b700b0076eef17d37emr4836696qkk.71.1694709328489; 
 Thu, 14 Sep 2023 09:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyNZnww/4D+om/YapBtyZAMFJtbkHdCeimc3UDhxxExL2KeBfhUQll/1+POnL+WCcAQcVMXQ==
X-Received: by 2002:a05:620a:11b7:b0:76e:ef17:d37e with SMTP id
 c23-20020a05620a11b700b0076eef17d37emr4836677qkk.71.1694709328200; 
 Thu, 14 Sep 2023 09:35:28 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 l11-20020ae9f00b000000b007677347e20asm577244qkg.129.2023.09.14.09.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:35:26 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 3/8] i386/sev: Replace LAUNCH_START ioctl with sev library
 equivalent
Date: Thu, 14 Sep 2023 12:33:54 -0400
Message-Id: <20230914163358.379957-4-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914163358.379957-1-tfanelli@redhat.com>
References: <20230914163358.379957-1-tfanelli@redhat.com>
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
index f0fd291e68..49be072cbc 100644
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


