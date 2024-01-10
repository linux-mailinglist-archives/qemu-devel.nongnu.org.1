Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE3829C98
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 15:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNZaH-0005fb-B9; Wed, 10 Jan 2024 09:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNZaD-0005ee-8i
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 09:29:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNZaB-0006pz-7p
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 09:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704896966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u1vTmAYwDciV6ex5vbs1z39Yr4FvloUltiRphVR6l/k=;
 b=NBxwCZt1beBnX7cerH6FVUwkw/vqC8CAgMc6GfGK1bm9SDiR7oAsOI0gC/pHOxJCxeIYe8
 V9chpPV03sS8hMfW6c09yTMurlgfezhidGNsYF9hSmOnW081gLkH3ShUxPa1KsSL6nRVMk
 dRudmtFRedApXH97ZRqaRXdOFxWe4KQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-xjKsDV3gP52ZtBO3bMkv8A-1; Wed, 10 Jan 2024 09:29:20 -0500
X-MC-Unique: xjKsDV3gP52ZtBO3bMkv8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41746868902;
 Wed, 10 Jan 2024 14:29:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F11CD1121312;
 Wed, 10 Jan 2024 14:29:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>
Cc: qemu-devel@nongnu.org,
	Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v2] target/s390x/kvm/pv: Provide some more useful information
 if decryption fails
Date: Wed, 10 Jan 2024 15:29:16 +0100
Message-ID: <20240110142916.850605-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

It's a common scenario to copy guest images from one host to another
to run the guest on the other machine. This (of course) does not work
with "secure exection" guests since they are encrypted with one certain
host key. However, if you still (accidentally) do it, you only get a
very user-unfriendly error message that looks like this:

 qemu-system-s390x: KVM PV command 2 (KVM_PV_SET_SEC_PARMS) failed:
  header rc 108 rrc 5 IOCTL rc: -22

Let's provide at least a somewhat nicer hint to the users so that they
are able to figure out what might have gone wrong.

Buglink: https://issues.redhat.com/browse/RHEL-18212
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Print the error in s390_machine_protect() instead of doing it
     in s390_pv_set_sec_parms(), report the text via Error **errp

 hw/s390x/ipl.h             |  2 +-
 target/s390x/kvm/pv.h      |  2 +-
 hw/s390x/ipl.c             |  5 ++---
 hw/s390x/s390-virtio-ccw.c |  5 ++++-
 target/s390x/kvm/pv.c      | 25 ++++++++++++++++++++-----
 5 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 7fc86e7905..57cd125769 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -107,7 +107,7 @@ typedef union IplParameterBlock IplParameterBlock;
 
 int s390_ipl_set_loadparm(uint8_t *loadparm);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
-int s390_ipl_prepare_pv_header(void);
+int s390_ipl_prepare_pv_header(Error **errp);
 int s390_ipl_pv_unpack(void);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 7b935e2246..fca373a826 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -42,7 +42,7 @@ int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
 void s390_pv_vm_disable(void);
 bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms);
-int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp);
 int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
 void s390_pv_prep_reset(void);
 int s390_pv_verify(void);
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 76110e8f58..e934bf89d1 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -702,7 +702,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
 
-int s390_ipl_prepare_pv_header(void)
+int s390_ipl_prepare_pv_header(Error **errp)
 {
     IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
     IPLBlockPV *ipib_pv = &ipib->pv;
@@ -711,8 +711,7 @@ int s390_ipl_prepare_pv_header(void)
 
     cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
                              ipib_pv->pv_header_len);
-    rc = s390_pv_set_sec_parms((uintptr_t)hdr,
-                               ipib_pv->pv_header_len);
+    rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
     g_free(hdr);
     return rc;
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1169e20b94..eaf61d3640 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -391,7 +391,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     }
 
     /* Set SE header and unpack */
-    rc = s390_ipl_prepare_pv_header();
+    rc = s390_ipl_prepare_pv_header(&local_err);
     if (rc) {
         goto out_err;
     }
@@ -410,6 +410,9 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     return rc;
 
 out_err:
+    if (local_err) {
+        error_report_err(local_err);
+    }
     s390_machine_unprotect(ms);
     return rc;
 }
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 6a69be7e5c..7ca7faec73 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -29,7 +29,8 @@ static bool info_valid;
 static struct kvm_s390_pv_info_vm info_vm;
 static struct kvm_s390_pv_info_dump info_dump;
 
-static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
+static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
+                         int *pvrc)
 {
     struct kvm_pv_cmd pv_cmd = {
         .cmd = cmd,
@@ -46,6 +47,9 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
                      "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
                      rc);
     }
+    if (pvrc) {
+        *pvrc = pv_cmd.rc;
+    }
     return rc;
 }
 
@@ -53,12 +57,13 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
  * This macro lets us pass the command as a string to the function so
  * we can print it on an error.
  */
-#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data)
+#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
+#define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
 #define s390_pv_cmd_exit(cmd, data)    \
 {                                      \
     int rc;                            \
                                        \
-    rc = __s390_pv_cmd(cmd, #cmd, data);\
+    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
     if (rc) {                          \
         exit(1);                       \
     }                                  \
@@ -142,14 +147,24 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
     return true;
 }
 
-int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
 {
+    int ret, pvrc;
     struct kvm_s390_pv_sec_parm args = {
         .origin = origin,
         .length = length,
     };
 
-    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
+    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
+    if (ret) {
+        error_setg(errp, "Failed to set secure execution parameters");
+        if (pvrc == 0x108) {
+            error_append_hint(errp, "Please check whether the image is "
+                                    "correctly encrypted for this host\n");
+        }
+    }
+
+    return ret;
 }
 
 /*
-- 
2.43.0


