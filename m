Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 674487B8E23
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8aD-0004Pg-41; Wed, 04 Oct 2023 16:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a9-0004OA-Nv
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a5-00020W-3d
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNWpsxDSOTDlAAXKt/5aQAuznyKUCgqDD8DtB37PvfA=;
 b=gdOdP2kIL0EOtus1w4hZcj3f5xKcPg/mEnvKAK0+4IsEQMNCOFGt/T1nVbIlPZIjN65lRZ
 xIlf64xi2pg4zNCq3uTFnM3QwJXhkyphFLRG8Swvnkf5YYRI/Ijv8Ldt8wWepuGniuHnY9
 GV5ta+n5L0MvTII5wb2lRoFHEjS8m1g=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-N6lNKty6Mvmipe_pDTeMsg-1; Wed, 04 Oct 2023 16:34:45 -0400
X-MC-Unique: N6lNKty6Mvmipe_pDTeMsg-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3af5b5d816aso490748b6e.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451683; x=1697056483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNWpsxDSOTDlAAXKt/5aQAuznyKUCgqDD8DtB37PvfA=;
 b=CIkmcxL/uB7MK2msXFdRA2TRUDjxcMeBE49DS9F3a3xppv6x47u5El7jOstIAKc4aD
 rxdSdbCZE0ENQ5I+s+4OqQQsEC/nZbN6OsIlruhXAlGtkhDz4kfHGTZKVIkSNLVZB71H
 lat0oOonYkhhuu2K5J1RkBJZlxwvqtrYAJqRZtP+1S5W15ve8ubgSkVpbSkAmmIRN6mn
 tfoHZIRhJ9s93k+dQcrJnPFgy/NRxwH0THU8FlhsjqL0IlLFJbvFXnsMyvoB+DLYv+ec
 QMFoUaytekP6aWUVOeX8rc78gSrrZGhjeybRr+5C2UpT0RGVCRm16xE6ALWjmemMbq64
 HSNQ==
X-Gm-Message-State: AOJu0Yxvc17a0ML3Mzh+8MwHDLcIUiI9GzVrE+270Y8//k0Y0QSe9FSP
 RA1weVh+UjMrUUHXLUY2ECTQL5jTrlBVUzCqPjfOrI9Us4Es7oICFdSTmZ9pIg4GSq6QWfPEsfN
 +lJnLzN8cRLvuTxWNsO8gpNzAjwLCYE3etTFNiu7iAw1x+wvKg1W8jb0//Rof7cgKzGj7Sd2Nm7
 8frw==
X-Received: by 2002:a05:6870:4710:b0:1d5:cba4:a6f6 with SMTP id
 b16-20020a056870471000b001d5cba4a6f6mr4261521oaq.6.1696451683438; 
 Wed, 04 Oct 2023 13:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYKcCtoymYzzE6MGDmeJm/mFH/vx69u7ug7zg9WFg1JTXo5McnhTDEcFnelRQz2hCePJOjmg==
X-Received: by 2002:a05:6870:4710:b0:1d5:cba4:a6f6 with SMTP id
 b16-20020a056870471000b001d5cba4a6f6mr4261496oaq.6.1696451683115; 
 Wed, 04 Oct 2023 13:34:43 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:42 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 5/9] i386/sev: Replace LAUNCH_UPDATE_VMSA ioctl with
 sev library equivalent
Date: Wed,  4 Oct 2023 16:34:14 -0400
Message-Id: <20231004203418.56508-6-tfanelli@redhat.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 73d3820364..a5bd1653ef 100644
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


