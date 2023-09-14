Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C282E7A0C1E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqcE-0003Mm-MA; Thu, 14 Sep 2023 13:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqcC-0003M6-ED
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqcB-0002HV-03
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2NK0kTh0JhgbuxHuwB20u7hC6VkkacylDJv8O/TVLI=;
 b=OiCkkwwSkaQZqdQXaeWQxb7HcrszKJcX85tafxkEFicVBtP2cGI5ioyDCJ7zt44Ixb2gp7
 Xd63NlybV9LlLtN3/aXsRFKeCFm31wUMjhpMbt7BFLl1JfYLowlAz4uY+zecqovYSMgkHb
 eafrqOczLYNiHjScBLWxbCSariLL5NE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-EZ_CAyhBNxWXNsvLiA5Csg-1; Thu, 14 Sep 2023 13:58:53 -0400
X-MC-Unique: EZ_CAyhBNxWXNsvLiA5Csg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-64943195f29so13168356d6.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714331; x=1695319131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2NK0kTh0JhgbuxHuwB20u7hC6VkkacylDJv8O/TVLI=;
 b=dNxZHmXseqyIbpWVVlKM7saravOWU3LzI7YlAsdcmKp+3fOFv0eOA/x9Q31rdeK8Pf
 aT1THKy1oGjCxMLQnpphCpb6Z9TRSDNLHkN+5OxmFqDz4DG9gsWvWOB+Tgy4IFFKeZEc
 36UUa5wnIAfO6Wtd+ioiBQbjDOzm5gxQBUcUhetPonGZbUwQ8ZR1qfoQOxVmStN9cnAc
 zI7vcNIl0Q7A1BbOV4xaDuarypRNXOgZLOBSvX3rF2b3kk4cU2FEq5ik2NtfTN07uIBL
 29tzY7o3A2yzqbYQ/5rJgIMMQNug/45B8vWgdBzwQxfIqFtSDgNftxiJODXmbywojJVf
 bWzQ==
X-Gm-Message-State: AOJu0YzlSbjGotJAAF+l0Yki9UlWSldxscgbmMVd3VNi6VqwoTTs/d3M
 sG9ZM6gjEU9LzGwW2xliXyENsCk3Ldg1rOHDZmTH0vwjeWRGGYzHaEe9kzIyyzC2bsD5sp4SioW
 OclAAnwYferX8aToh2tkpd0qIkE1Z4NqrUcUUUnW3TfZ9uedrQYnWGx45s8wvzwZh/uA24G24sg
 AADQ==
X-Received: by 2002:a05:6214:808:b0:64f:7d13:3757 with SMTP id
 df8-20020a056214080800b0064f7d133757mr6208135qvb.11.1694714331553; 
 Thu, 14 Sep 2023 10:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyktXMUFZV4CX2wfMtgCaT2t+6wAFrWNvyKXODckkpmvOWMvdpPUN+Xa2E7yarq7j0cz9ORA==
X-Received: by 2002:a05:6214:808:b0:64f:7d13:3757 with SMTP id
 df8-20020a056214080800b0064f7d133757mr6208122qvb.11.1694714331282; 
 Thu, 14 Sep 2023 10:58:51 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:48 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 5/8] i386/sev: Replace LAUNCH_UPDATE_VMSA ioctl with sev
 library equivalent
Date: Thu, 14 Sep 2023 13:58:32 -0400
Message-Id: <20230914175835.382972-6-tfanelli@redhat.com>
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

The LAUNCH_UPDATE_VMSA API takes the VM's file descriptor, as well as a
field for any firmware errors as input.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 615021a1a3..adb35291e8 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -715,27 +715,14 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
     return 0;
 }
 
-static int
-sev_launch_update_vmsa(SevGuestState *sev)
-{
-    int ret, fw_error;
-
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL, &fw_error);
-    if (ret) {
-        error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
-    }
-
-    return ret;
-}
-
 static void
 sev_launch_get_measure(Notifier *notifier, void *unused)
 {
     SevGuestState *sev = sev_guest;
-    int ret, error;
+    int ret, fw_error;
     g_autofree guchar *data = NULL;
     struct kvm_sev_launch_measure measurement = {};
+    KVMState *s = kvm_state;
 
     if (!sev_check_state(sev, SEV_STATE_LAUNCH_UPDATE)) {
         return;
@@ -743,18 +730,20 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
 
     if (sev_es_enabled()) {
         /* measure all the VM save areas before getting launch_measure */
-        ret = sev_launch_update_vmsa(sev);
+        ret = sev_launch_update_vmsa(s->vmfd, &fw_error);
         if (ret) {
+            error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
             exit(1);
         }
     }
 
     /* query the measurement blob length */
     ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
-                    &measurement, &error);
+                    &measurement, &fw_error);
     if (!measurement.len) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(errno));
+                     __func__, ret, fw_error, fw_error_to_str(fw_error));
         return;
     }
 
@@ -763,10 +752,10 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
 
     /* get the measurement blob */
     ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
-                    &measurement, &error);
+                    &measurement, &fw_error);
     if (ret) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(errno));
+                     __func__, ret, fw_error, fw_error_to_str(fw_error));
         return;
     }
 
-- 
2.40.1


