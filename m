Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A37B8E20
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8a7-0004NK-HT; Wed, 04 Oct 2023 16:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a3-0004MZ-Rm
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a2-0001zn-0z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otx00toCbl4WuO6Wk0uUrBjrbYfmsKzeXoKLEHMJPHg=;
 b=a5zQ9tq/1iRjlDDpQSxbBkDY0Bj7F1wzVOdAPnfibWWlkZjZ2w/85OTnb2EHtPSBUpgnPz
 1qvOCJ+yRcFtBKpnw93OGEbyCIrUKfEUs6+EyD3xTHwZpQg7vi/YZ/cbBF3EvKWdJmVWo8
 GIxlbt9UQfg4Q+cL9UachDw44epzQr0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-MFNCKBAfM3KVnTAj5snV7A-1; Wed, 04 Oct 2023 16:34:43 -0400
X-MC-Unique: MFNCKBAfM3KVnTAj5snV7A-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3ae4cefdee5so596722b6e.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451681; x=1697056481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otx00toCbl4WuO6Wk0uUrBjrbYfmsKzeXoKLEHMJPHg=;
 b=W2R95gEWV5SOk3fnhjikaecpZsDyBpoChpXwj9ZxIzh/eo6VZfxrC7nNOP5EUe8XV+
 qSFLGj/tz77LPMAys1Ks0HZtBDkPoJh78hAkke4J8ct/QyuvD185/XynaYGgy6Kyhier
 E8x0WXGYJQGu41Cl5kTnpNnt/d+ek2AfFk2Yscav9Klm/wkyAATFUMX/FczbM2PpPirm
 6Tbp5bC4lpQB+a0Hne+PBIepHrKY+b1n3euVPasa4K5JEFWL4jFwXhcJIi+SAPJA9uX5
 HbWgkxrdzmD/2NReFJLn7qhecoG+uQj3hJkF+IcgRofswvLU9UlHoDfv6jyWp5T9JcyW
 Hprg==
X-Gm-Message-State: AOJu0YxfJ3OuDkTwfSAcwnYpupYSUFEhyUEKCRK2iBpUrTL0REDpYWWM
 2vzd4uuhyeU0yV19FmPfuW8cIXmjADLshAMXd1hO/T/DzfZOJ1tDOoTQY03bjsn/VFVpH32reLf
 7NZQ7WPdyQ8N0EfarbXJoc0AB+zQ4DuwmrHB7S3OIKjeLospzIXOvDK3a8Y+05XdqiJPNWGt/4w
 c4SA==
X-Received: by 2002:a05:6808:2187:b0:3a1:bfda:c6d2 with SMTP id
 be7-20020a056808218700b003a1bfdac6d2mr4219537oib.11.1696451681348; 
 Wed, 04 Oct 2023 13:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHho/hqSZH+PCWkEUA+V9tqsuhmgyRGhyZkhOzhJR+GadG7zZubCkJz1cG5zkR6u3UqBbZlWw==
X-Received: by 2002:a05:6808:2187:b0:3a1:bfda:c6d2 with SMTP id
 be7-20020a056808218700b003a1bfdac6d2mr4219521oib.11.1696451681040; 
 Wed, 04 Oct 2023 13:34:41 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:39 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 4/9] i386/sev: Replace UPDATE_DATA ioctl with sev
 library equivalent
Date: Wed,  4 Oct 2023 16:34:13 -0400
Message-Id: <20231004203418.56508-5-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004203418.56508-1-tfanelli@redhat.com>
References: <20231004203418.56508-1-tfanelli@redhat.com>
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

UPDATE_DATA takes the VM's file descriptor, a guest memory region to
be encrypted, as well as the size of the aforementioned guest memory
region.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4c888fa77f..73d3820364 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -715,29 +715,6 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
     return 0;
 }
 
-static int
-sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
-{
-    int ret, fw_error;
-    struct kvm_sev_launch_update_data update;
-
-    if (!addr || !len) {
-        return 1;
-    }
-
-    update.uaddr = (__u64)(unsigned long)addr;
-    update.len = len;
-    trace_kvm_sev_launch_update_data(addr, len);
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
-                    &update, &fw_error);
-    if (ret) {
-        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
-    }
-
-    return ret;
-}
-
 static int
 sev_launch_update_vmsa(SevGuestState *sev)
 {
@@ -1009,15 +986,19 @@ out:
 int
 sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
 {
+    KVMState *s = kvm_state;
+    int fw_error;
+
     if (!sev_guest) {
         return 0;
     }
 
     /* if SEV is in update state then encrypt the data else do nothing */
     if (sev_check_state(sev_guest, SEV_STATE_LAUNCH_UPDATE)) {
-        int ret = sev_launch_update_data(sev_guest, ptr, len);
+        int ret = sev_launch_update_data(s->vmfd, (__u64) ptr, len, &fw_error);
         if (ret < 0) {
-            error_setg(errp, "SEV: Failed to encrypt pflash rom");
+            error_setg(errp, "SEV: Failed to encrypt pflash rom fw_err=%d",
+                       fw_error);
             return ret;
         }
     }
-- 
2.40.1


