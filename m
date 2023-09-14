Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E97E97A0ECE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsgG-000291-SH; Thu, 14 Sep 2023 16:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKy-0005Jh-P5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKx-0000kx-1v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fu8ktLm0OkYnObZYuT5ndv2RWlsc6KNoxE7MI7M9Gk=;
 b=QMXNXru/K++ePBnNziVKrE8DFRpMZfYbbGhz155aDhoKQyc6Oo6UEp9hCeWNLPsUteE+31
 gbKTpvC44fOR1iCKUIcKgqFTwualJHtwTJ7NR2oCwOdlZuJbhIVCgVXXi6eZi9A9ztGxBp
 rscYsvIq1AZkFga+HnnqDneFizPX0LY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-aYjBZBp2PRO-QTvDvQM1hQ-1; Thu, 14 Sep 2023 12:35:39 -0400
X-MC-Unique: aYjBZBp2PRO-QTvDvQM1hQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1d5b1fd98c6so1728341fac.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709337; x=1695314137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fu8ktLm0OkYnObZYuT5ndv2RWlsc6KNoxE7MI7M9Gk=;
 b=NYSHc/SvcVNkpbIAn9zVFNk2Lf+i/86zB/4yv67E3CH5xflRAzEwTq6GgDnjgVsMNj
 aUgUXcF+mXqnT4bfv8UfNDyPSa+s+YobKJTyQ63Yuy8vrI3X4ryghk0OMr3d6J9rA6YL
 DZJGewA9AkzH7l6rgIWZ3lVY+uIbHiHACF1MD+WCqOV06Md9g8HB3f3QIYUx8OJ1o6qM
 McqYUDurFZyJcGlx3uKLNQyPoZ5XtOTgdyIFe7v6ZAoot9sOv39iFGyZWz6ZGa5/v1cO
 SIHbxDJAZo0mBIvyjWfiV6S+WbOOdKYukxbb/UdZBh1T6vH23sIlqRJh3dMkS6OslrGb
 LX4A==
X-Gm-Message-State: AOJu0YwBXSz3DMxuG8KXTeaRNc9PyRPEeaoSfFXhOqMrqe39T394NALU
 lCzdqn9FA/ppt0pM8dhLlkjONkInlmy82Ghxo48UWSS+mYS0ydT48y6PVVYXjlxD2ip0WbCndHN
 OlTS+V/f5SYtR3zwXcCH1yhYUcX9Hw5pbfBx5cSzwxS1n2l7MliOAPgN75Vdl1ADlFf2aX1s9aL
 JsCg==
X-Received: by 2002:a05:6870:c152:b0:1be:dbd2:2bfa with SMTP id
 g18-20020a056870c15200b001bedbd22bfamr7003130oad.20.1694709337304; 
 Thu, 14 Sep 2023 09:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVrcmlLU2FcUggDqRidZDMLRmhoFWCAGB62xvDoEMGK7eDQFwAt7UrkgwHQQmyhwiLwDehSA==
X-Received: by 2002:a05:6870:c152:b0:1be:dbd2:2bfa with SMTP id
 g18-20020a056870c15200b001bedbd22bfamr7003100oad.20.1694709336876; 
 Thu, 14 Sep 2023 09:35:36 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 l11-20020ae9f00b000000b007677347e20asm577244qkg.129.2023.09.14.09.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:35:35 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 7/8] i386/sev: Replace LAUNCH_SECRET ioctl with sev
 library equivalent
Date: Thu, 14 Sep 2023 12:33:58 -0400
Message-Id: <20230914163358.379957-8-tfanelli@redhat.com>
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

The LAUNCH_SECRET API can inject a secret into the VM once the
measurement has been retrieved.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 105 ++++++++++++++++------------------------------
 target/i386/sev.h |   2 -
 2 files changed, 36 insertions(+), 71 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index f53ff140e3..a4510b5437 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -983,88 +983,44 @@ sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
     return 0;
 }
 
-int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
-                             uint64_t gpa, Error **errp)
-{
-    struct kvm_sev_launch_secret input;
-    g_autofree guchar *data = NULL, *hdr = NULL;
-    int error, ret = 1;
-    void *hva;
-    gsize hdr_sz = 0, data_sz = 0;
-    MemoryRegion *mr = NULL;
-
-    if (!sev_guest) {
-        error_setg(errp, "SEV not enabled for guest");
-        return 1;
-    }
-
-    /* secret can be injected only in this state */
-    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
-        error_setg(errp, "SEV: Not in correct state. (LSECRET) %x",
-                     sev_guest->state);
-        return 1;
-    }
-
-    hdr = g_base64_decode(packet_hdr, &hdr_sz);
-    if (!hdr || !hdr_sz) {
-        error_setg(errp, "SEV: Failed to decode sequence header");
-        return 1;
-    }
-
-    data = g_base64_decode(secret, &data_sz);
-    if (!data || !data_sz) {
-        error_setg(errp, "SEV: Failed to decode data");
-        return 1;
-    }
-
-    hva = gpa2hva(&mr, gpa, data_sz, errp);
-    if (!hva) {
-        error_prepend(errp, "SEV: Failed to calculate guest address: ");
-        return 1;
-    }
-
-    input.hdr_uaddr = (uint64_t)(unsigned long)hdr;
-    input.hdr_len = hdr_sz;
-
-    input.trans_uaddr = (uint64_t)(unsigned long)data;
-    input.trans_len = data_sz;
-
-    input.guest_uaddr = (uint64_t)(unsigned long)hva;
-    input.guest_len = data_sz;
-
-    trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
-                                input.trans_uaddr, input.trans_len);
-
-    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
-                    &input, &error);
-    if (ret) {
-        error_setg(errp, "SEV: failed to inject secret ret=%d fw_error=%d '%s'",
-                     ret, error, fw_error_to_str(error));
-        return ret;
-    }
-
-    return 0;
-}
-
 #define SEV_SECRET_GUID "4c2eb361-7d9b-4cc3-8081-127c90d3d294"
 struct sev_secret_area {
     uint32_t base;
     uint32_t size;
 };
 
-void qmp_sev_inject_launch_secret(const char *packet_hdr,
-                                  const char *secret,
+void qmp_sev_inject_launch_secret(const char *hdr_b64,
+                                  const char *secret_b64,
                                   bool has_gpa, uint64_t gpa,
                                   Error **errp)
 {
+    int ret, fw_error = 0;
+    g_autofree guchar *hdr = NULL, *secret = NULL;
+    uint8_t *data = NULL;
+    KVMState *s = kvm_state;
+    gsize hdr_sz = 0, secret_sz = 0;
+    MemoryRegion *mr = NULL;
+    void *hva;
+    struct sev_secret_area *area = NULL;
+
     if (!sev_enabled()) {
         error_setg(errp, "SEV not enabled for guest");
         return;
     }
-    if (!has_gpa) {
-        uint8_t *data;
-        struct sev_secret_area *area;
 
+    hdr = g_base64_decode(hdr_b64, &hdr_sz);
+    if (!hdr || !hdr_sz) {
+        error_setg(errp, "SEV: Failed to decode sequence header");
+        return;
+    }
+
+    secret = g_base64_decode(secret_b64, &secret_sz);
+    if (!secret || !secret_sz) {
+        error_setg(errp, "SEV: Failed to decode secret");
+        return;
+    }
+
+    if (!has_gpa) {
         if (!pc_system_ovmf_table_find(SEV_SECRET_GUID, &data, NULL)) {
             error_setg(errp, "SEV: no secret area found in OVMF,"
                        " gpa must be specified.");
@@ -1074,7 +1030,18 @@ void qmp_sev_inject_launch_secret(const char *packet_hdr,
         gpa = area->base;
     }
 
-    sev_inject_launch_secret(packet_hdr, secret, gpa, errp);
+    hva = gpa2hva(&mr, gpa, secret_sz, errp);
+    if (!hva) {
+        error_prepend(errp, "SEV: Failed to calculate guest address: ");
+        return;
+    }
+
+    ret = sev_inject_launch_secret(s->vmfd, hdr, secret, secret_sz,
+                                   hva, &fw_error);
+    if (ret < 0) {
+        error_setg(errp, "%s: LAUNCH_SECRET ret=%d fw_error=%d '%s'", __func__,
+                   ret, fw_error, fw_error_to_str(fw_error));
+    }
 }
 
 static int
diff --git a/target/i386/sev.h b/target/i386/sev.h
index acb181358e..f1af28eca0 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -53,8 +53,6 @@ uint32_t sev_get_reduced_phys_bits(void);
 bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
 
 int sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp);
-int sev_inject_launch_secret(const char *hdr, const char *secret,
-                             uint64_t gpa, Error **errp);
 
 int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size);
 void sev_es_set_reset_vector(CPUState *cpu);
-- 
2.40.1


