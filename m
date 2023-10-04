Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BA77B8E1C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8a6-0004N5-NR; Wed, 04 Oct 2023 16:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a3-0004MY-RQ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a1-0001zf-SG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HmyiL+0Vk4O8wUU4c+YaK7cVCigjWlx+T3yj2O2AriQ=;
 b=esq05+DTihrJZgb1bv63g6XLAF7qjKXDjdE9tS4oM32SQp56LUAHpSRESgdV/9G0HZZAjS
 SxgKtX7OsDQ2deH6bH7vDiOmghkOGwIDprd/mYvW2kMVAZfiU4d7E6dT9I8Ja0WnCUkPBl
 sxPlIi/AnnHjAv5xO08g983BMK9Y4zo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-PwGRnMCZOj2mlUwNkIfK9g-1; Wed, 04 Oct 2023 16:34:48 -0400
X-MC-Unique: PwGRnMCZOj2mlUwNkIfK9g-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-187959a901eso219855fac.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451686; x=1697056486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmyiL+0Vk4O8wUU4c+YaK7cVCigjWlx+T3yj2O2AriQ=;
 b=bdICZsF8gWB76i8y4aBTNzj4O9QtoSr7oRvj3iIxqgIQKSmIEpG4ke1IE7HhyCL6Dj
 KPEVsIA3PTf1DKWTdhXBhFjlRSVqjiWwGnBxnsDpXdATTVPvnspHfYGoxMwshAMFyk/z
 ryw475QTURDZegJJqeFiucIgmzcF7Clg0Voh+oXUBrOEqRG19/fMa8aSBZF8TjIqpTBd
 1ftGTpmQYmSveVbesFbVwB9hx+X1G8kZQk/ZB1rxK1W+z9OUWnowIWwBNreZEiNe+vMK
 h05P+wxkJwtXgiSn/IioA4psFOCvMhKIIWCvLEQnUQ+bL9AcpNXuYLKk3SO3b396e4jn
 uzsg==
X-Gm-Message-State: AOJu0YxJXnF6AKx6Cn24tCuz7WerjnSPeFZR9HQrqlusfl2eZRVrI53z
 nhR/YBSX0FL/w7aQwNbDPzhAExNCl6hK007b9rwZ5dRoHxuIBDBhevKdcHnKgV4DUuDZa9jUpmF
 iON+xePj/iBOll6no2UxWG99HSSdVIqps9myMidTPQAnKCBRj1Dtk9NjX54TxaO9hPjMIdpr0kP
 kbRQ==
X-Received: by 2002:a05:6870:15d5:b0:1d6:5561:7e1d with SMTP id
 k21-20020a05687015d500b001d655617e1dmr4023040oad.44.1696451686191; 
 Wed, 04 Oct 2023 13:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3TBNaB7ZtNXIhB/ErYq9YUdyQWuqYEntPyUS872kalh5NRrkRbpGyaVp4fXe/EiHiLXkSDg==
X-Received: by 2002:a05:6870:15d5:b0:1d6:5561:7e1d with SMTP id
 k21-20020a05687015d500b001d655617e1dmr4023018oad.44.1696451685873; 
 Wed, 04 Oct 2023 13:34:45 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:44 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 6/9] i386/sev: Replace LAUNCH_MEASURE ioctl with sev
 library equivalent
Date: Wed,  4 Oct 2023 16:34:15 -0400
Message-Id: <20231004203418.56508-7-tfanelli@redhat.com>
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
index a5bd1653ef..3e2a3e07a7 100644
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


