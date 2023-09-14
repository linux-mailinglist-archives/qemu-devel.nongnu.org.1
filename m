Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A183D7A0ED1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsgG-000292-BY; Thu, 14 Sep 2023 16:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKe-0005BO-Va
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKd-0000hu-Fi
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2NK0kTh0JhgbuxHuwB20u7hC6VkkacylDJv8O/TVLI=;
 b=AlZpGDutNz/d4dMaTLWjvqgFz6sz6M+yKUrHpTV87JUs8NDrmK/ZLapbxR53pUJrWSIvHU
 lmYIcoYcT1f9oserR9NkZNbTtMpCwinmtZ0ztqOPdNrf41JfHzMydjFolwp2MlOgOfB9IR
 EYhbVzljjEfJNUExzRWTJMz8zoMQEx8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-9pzypvL_M2qAMA92tdOiNw-1; Thu, 14 Sep 2023 12:35:34 -0400
X-MC-Unique: 9pzypvL_M2qAMA92tdOiNw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76ef4ff3aecso138573785a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709333; x=1695314133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2NK0kTh0JhgbuxHuwB20u7hC6VkkacylDJv8O/TVLI=;
 b=bVWF0HoYrlUtKEbZGKDtZ4Wm8zFT5cCfESH+u1sT5dLiFbvEEd0/TSl1CSi2G0vlf6
 cBA9T97csG3L/cspRvK9NuZrqSq9HSipQvSj4wJFr3BAW1N/4yIddujuADBggXgRJPi/
 lbYlaxSHr7xDwndjk/rW4ST1sHWQtDiCjO41l4o/pSuc611A9x3NnVpqMc8gBHSDR1CU
 u+vEJOl5HG5F/VsQoVlZjHAQGczKy3rUnygcxsQqOsYK32POCgw8YE0Qn5J6mOrixzOS
 wsBVs4RHDGjTbYncI3sSIKxRkNmdIEPm2/CYMccnObyzcteTF4IqS2vKbMB9dyQs55Ok
 ajpg==
X-Gm-Message-State: AOJu0YxBcsWuVq+RaIrNmMlzIQab/QxKwBcJGoWlzgg52rEvkt4aJdTw
 XVRUcOnsyfkhUKrJG0q36yhdl0Ecoo1ITqRlFtP/D8ZZJel2x9w8u4x75bnNW94P+BQ0+/hXTMs
 B35+Cmr3RqpednkFlRVpuftfYWzyJjJk6KpxYZF2TVrt95dr2oQxTUR3RfyH7WcbPMoqpaI/k31
 L1MQ==
X-Received: by 2002:a05:620a:1590:b0:76f:2214:e2c3 with SMTP id
 d16-20020a05620a159000b0076f2214e2c3mr5650541qkk.64.1694709332794; 
 Thu, 14 Sep 2023 09:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/RUQfyYwpOI3s5M6Cw9SiaHPPnHvFFkpRt1oq9wIseUtMNFnTFClG2ZW3/wE6FcN/3KKoPw==
X-Received: by 2002:a05:620a:1590:b0:76f:2214:e2c3 with SMTP id
 d16-20020a05620a159000b0076f2214e2c3mr5650521qkk.64.1694709332496; 
 Thu, 14 Sep 2023 09:35:32 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 l11-20020ae9f00b000000b007677347e20asm577244qkg.129.2023.09.14.09.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:35:30 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 5/8] i386/sev: Replace LAUNCH_UPDATE_VMSA ioctl with sev
 library equivalent
Date: Thu, 14 Sep 2023 12:33:56 -0400
Message-Id: <20230914163358.379957-6-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914163358.379957-1-tfanelli@redhat.com>
References: <20230914163358.379957-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


