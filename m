Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0100F7A0C1B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqcJ-0003Nd-6n; Thu, 14 Sep 2023 13:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqcG-0003N0-En
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqcE-0002Hy-Ht
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ug4FqkMiYbFT/Zpgx7iTP8cWdhAiF2GO+LZBA3MJDko=;
 b=FX61t6c9TxZ4Q7/0HYmskJreSZz5hBH4ksu/mAaPtL9YmuuWXlcVToyqx6CMRg4cER9E5m
 LgRl72kU0WQKSQIIfoh0jbhYMNavfssNViqA532wAIsbDyYf6SQsnKv+gq6xu2zMEnVOj1
 XnB4H1a6wvDWefggKwGZmZq8tFmgiHY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-xAh1yKg-NTqjex_7o121XA-1; Thu, 14 Sep 2023 13:58:56 -0400
X-MC-Unique: xAh1yKg-NTqjex_7o121XA-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-44d4c4ff288so554998137.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714334; x=1695319134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ug4FqkMiYbFT/Zpgx7iTP8cWdhAiF2GO+LZBA3MJDko=;
 b=K65P8BAEJNVn5xijQJGx8c3Q/ZlpYOi2ec90jwQZSzlT0ddhKbwVvbkRFBf8/D3Scr
 Xnnvw56atyRp2n4Yo936V3nf/CVMed3RX9uLvbaHaUsDIIEohqTEUKKotYhrtKcjoQoy
 TX8mx41pXpoIs9VtUOuUoJj+JukkXghogXOw8i9wEQZ+qM02s1SgqdGX7BKjuaeBGKCR
 z77cOGDsYsXIWqv0nabenQqluCe3Y+welhRH/gjtS2G/tI/kRIq4kuGTAu4EtecQi0lW
 9L1YBqiSCH3zRim0AvMQKYxowhXVck76q5ueRN1D+8hADBRjjwgPZe8NDeh0C2+9kjPI
 2mkQ==
X-Gm-Message-State: AOJu0Yxfmp6bPtPJist+tfBnE1nlXInamlDlMQ8LXIiw61RH6LiCESfc
 j6TmDEVYLaov1WD/0DzTpVgVO04ASCE+69ET23Qs8ouNN6yqv0QBvpmzKZ5V5Cso6bIU+OJmQCZ
 PQO7jHhU2fUCXUKwkoDpoi2907zCxiZXq9SzyhtlR8sM7g2ncgeouQiFrDpb5V5slq6FAuQ2W0B
 stHQ==
X-Received: by 2002:a05:6102:443:b0:44e:bf83:4a19 with SMTP id
 e3-20020a056102044300b0044ebf834a19mr6118993vsq.15.1694714334656; 
 Thu, 14 Sep 2023 10:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaUcsIKRimpihSQX9ffH+ZFEFGMu+EBmaX5dty4FQTdDeaOMktKG+MAhQaM27QoXdzcVNCNA==
X-Received: by 2002:a05:6102:443:b0:44e:bf83:4a19 with SMTP id
 e3-20020a056102044300b0044ebf834a19mr6118979vsq.15.1694714334419; 
 Thu, 14 Sep 2023 10:58:54 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:51 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 6/8] i386/sev: Replace LAUNCH_MEASURE ioctl with sev
 library equivalent
Date: Thu, 14 Sep 2023 13:58:33 -0400
Message-Id: <20230914175835.382972-7-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914175835.382972-1-tfanelli@redhat.com>
References: <20230914175835.382972-1-tfanelli@redhat.com>
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

The LAUNCH_MEASURE API returns the measurement of the launched guest's
memory pages (and VMCB save areas if ES is enabled). The caller is
responsible for ensuring that the pointer (identified as the "data"
argument) is a valid pointer that can hold the guest's measurement (a
measurement in SEV is 48 bytes in size).

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 24 ++++++------------------
 target/i386/sev.h |  2 ++
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index adb35291e8..f53ff140e3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -721,7 +721,6 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     SevGuestState *sev = sev_guest;
     int ret, fw_error;
     g_autofree guchar *data = NULL;
-    struct kvm_sev_launch_measure measurement = {};
     KVMState *s = kvm_state;
 
     if (!sev_check_state(sev, SEV_STATE_LAUNCH_UPDATE)) {
@@ -738,31 +737,20 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
         }
     }
 
-    /* query the measurement blob length */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
-                    &measurement, &fw_error);
-    if (!measurement.len) {
-        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, fw_error, fw_error_to_str(fw_error));
-        return;
-    }
+    data = g_malloc(SEV_MEASUREMENT_SIZE);
 
-    data = g_new0(guchar, measurement.len);
-    measurement.uaddr = (unsigned long)data;
-
-    /* get the measurement blob */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
-                    &measurement, &fw_error);
+    ret = sev_launch_measure(s->vmfd, data, &fw_error);
     if (ret) {
-        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'", __func__,
+                       ret, fw_error, fw_error_to_str(fw_error));
+
         return;
     }
 
     sev_set_guest_state(sev, SEV_STATE_LAUNCH_SECRET);
 
     /* encode the measurement value and emit the event */
-    sev->measurement = g_base64_encode(data, measurement.len);
+    sev->measurement = g_base64_encode(data, SEV_MEASUREMENT_SIZE);
     trace_kvm_sev_launch_measurement(sev->measurement);
 }
 
diff --git a/target/i386/sev.h b/target/i386/sev.h
index e7499c95b1..acb181358e 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -38,6 +38,8 @@ typedef struct SevKernelLoaderContext {
     size_t cmdline_size;
 } SevKernelLoaderContext;
 
+#define SEV_MEASUREMENT_SIZE 48
+
 #ifdef CONFIG_SEV
 bool sev_enabled(void);
 bool sev_es_enabled(void);
-- 
2.40.1


