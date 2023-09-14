Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F213F7A0C18
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqc9-0003LV-IH; Thu, 14 Sep 2023 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc7-0003LD-IW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc6-0002Fm-0h
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sK9qSi08IdhuNBweHKbDKawtZ28B4JO2EvdjNn6LOA=;
 b=TVPu+mF/2+HY0apeHOwRLEaV1R/RsybzfN5oWj+Eg+q7tmT/ykEtteGZlsTVwwbRBXVYUS
 7R96lzr+cfq/gnhevQBnSvMOo1s8Sbonj/3Wy5eczGdjr5GmKgSKCFLrrGUJWLHNc5tIji
 azjXA5oGv9tf76wMwpnZJLUnVNMt63E=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-NN_NtLURN26ln2MOCgnpDw-1; Thu, 14 Sep 2023 13:58:48 -0400
X-MC-Unique: NN_NtLURN26ln2MOCgnpDw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7a515393474so467219241.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714326; x=1695319126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sK9qSi08IdhuNBweHKbDKawtZ28B4JO2EvdjNn6LOA=;
 b=g/br0QGTIcWtiJF3BD1i1qiwKFMvywvrw2W1gArSVrzy594jxoEKWTDQ4/O++/C53e
 LpJiX5mIRY9MwkYmBlh6qsIOgEsGf/atvP+aIgSHxjU1VBys/vVuEmqtCddwWU1fUQpu
 hYveHheO2raYF1UVRoyIKV+Xdn9KHh+32hMHWwznYN6x/wVZ754XntY3DGojiF1bMU3Z
 cXFmUNUtW1ZfV3vyvJbaUfOBCWOS3XshgSKoptWXOTu4FUt/55+np+f6Cg5YSkZFq6+O
 odxUR/wvfH1D05qUCRVyaoosT+ozxhzFf5iHWaI5HLcVRCLLlNoR/72VKTowk7SR8qNR
 0FGw==
X-Gm-Message-State: AOJu0YzFE+yW4oqzijndEzwL293/hd6bPARBM6EOstGYARofRx9RHBUk
 8Ssq3y3nME0v7swhIPZi5O4gcK7GKoh5LdjmX5LHsHxHO5qKCwUuPBm3T5zb0DEqi7KfLPxWK4W
 g/+F3YkT6xIWg2cjigZjLEGuKdrh/33pk+0jyWtSYeegTXc2VRl+Dt0s8rkQp1Xrq0zSSCMt8AA
 BUWQ==
X-Received: by 2002:a67:ea88:0:b0:44e:9c7a:949 with SMTP id
 f8-20020a67ea88000000b0044e9c7a0949mr6004357vso.30.1694714326224; 
 Thu, 14 Sep 2023 10:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOEMGoUr16zI6c1HLnM0MEFWL6G1/5xzBumzVNh+/MxGyqaXgK7Kw4IbzsJ68LnmuwXyqnZA==
X-Received: by 2002:a67:ea88:0:b0:44e:9c7a:949 with SMTP id
 f8-20020a67ea88000000b0044e9c7a0949mr6004342vso.30.1694714325954; 
 Thu, 14 Sep 2023 10:58:45 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:44 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 3/8] i386/sev: Replace LAUNCH_START ioctl with sev library
 equivalent
Date: Thu, 14 Sep 2023 13:58:30 -0400
Message-Id: <20230914175835.382972-4-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914175835.382972-1-tfanelli@redhat.com>
References: <20230914175835.382972-1-tfanelli@redhat.com>
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


