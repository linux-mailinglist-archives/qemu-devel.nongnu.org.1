Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D237B8E1D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8aB-0004Of-Fn; Wed, 04 Oct 2023 16:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a8-0004NR-6R
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8Zs-0001y0-T2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scWxnwDjrmK6aQsu5oW07E6oYDERanbs9KZaHEKVF9Q=;
 b=Cnk7DlyRPIgb74jKcrMTD6ujV49jGLNobz2faqwmTzM6Tib/6mnEwVX7nQEPLpxrq69c37
 1jVabvHFAh/xPNGx3R2Dj8Ast5Fv9QhWXXhZvZt3tpZsC9x+Q9LmhgODBgZDBxHgSH5IlZ
 xOm3d6rG7M6fOidpFUeYlYHowTSoip8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-mdcUPKDJPF6as3bQkhSHOg-1; Wed, 04 Oct 2023 16:34:38 -0400
X-MC-Unique: mdcUPKDJPF6as3bQkhSHOg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1d6fdbe39c8so213301fac.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451676; x=1697056476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scWxnwDjrmK6aQsu5oW07E6oYDERanbs9KZaHEKVF9Q=;
 b=NyGr2IAXDkq4HsnebFZNstyGR4cIFg4I756XELcKdogIzhFiQxtGhsyefL5HgA/Hxq
 90bBxksRdVxK23RBxAWWkRGLPze3aw1NlohNHXydj8sK9ksyhVVUz+/PFGmzK5vGyyDa
 6+8LvhLcrZNoTM9wuuxEWnTa172BvhAjNockz+P7dHIUQWQP4BuFglrF6QMzCo0IgLTV
 7qvTrVQsJg9NZswe+XXp7T/bSrdSv3gQ42kogGbsH7ytVGuOE885GMXRc3MzN2Fy4BQb
 vsPJjk1K8RSVbMQ3fqB9cUwRVvHceX/8/+HKN1UusrLFarIZwUc7Bavsx4AuVEfKOLiU
 SBxQ==
X-Gm-Message-State: AOJu0YynbdHU6O7p9PageGx0J3gp+FmKDLfh03Rg5oddjNclLbdXB1tL
 9wws1ihg78gNknCI2AEm0kCayP56WicgImC4yDz3qiF0XY9oLuFvf9uFF1hJX4kKFWS5J7tuSEJ
 N7OMF4CJWOS+JiMLhLVUrML0PMFh0i/9quYqzBA5j7GpFq3FtRFf0NkHvTpwM5G2vW353K1WBUa
 lOzQ==
X-Received: by 2002:a05:6870:9721:b0:1d6:5fb5:1541 with SMTP id
 n33-20020a056870972100b001d65fb51541mr3936365oaq.35.1696451676265; 
 Wed, 04 Oct 2023 13:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHkG66hlImlPuhBj44N4kcOXd4S1W1Eh3/u73GUVcqVO8TBPTnqTHpTcNXI/SViEsCq+3CpA==
X-Received: by 2002:a05:6870:9721:b0:1d6:5fb5:1541 with SMTP id
 n33-20020a056870972100b001d65fb51541mr3936341oaq.35.1696451675855; 
 Wed, 04 Oct 2023 13:34:35 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:34 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 2/9] i386/sev: Replace INIT and ES_INIT ioctls with sev
 library equivalents
Date: Wed,  4 Oct 2023 16:34:11 -0400
Message-Id: <20231004203418.56508-3-tfanelli@redhat.com>
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

The sev library offers APIs for SEV_INIT and SEV_ES_INIT, both taking
the file descriptors of the encrypting VM and /dev/sev as input.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c        | 14 +++++++++-----
 target/i386/trace-events |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index fe2144c038..97388f5fa2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -18,6 +18,8 @@
 
 #include <sys/ioctl.h>
 
+#include <libsev.h>
+
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
@@ -27,6 +29,7 @@
 #include "crypto/hash.h"
 #include "sysemu/kvm.h"
 #include "sev.h"
+#include "sysemu/kvm_int.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
@@ -911,10 +914,11 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     SevGuestState *sev
         = (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
     char *devname;
-    int ret, fw_error, cmd;
+    int ret, fw_error;
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    KVMState *s = kvm_state;
 
     if (!sev) {
         return 0;
@@ -990,13 +994,13 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                          __func__);
             goto err;
         }
-        cmd = KVM_SEV_ES_INIT;
+        trace_kvm_sev_es_init();
+        ret = sev_es_init(s->vmfd, sev->sev_fd, &fw_error);
     } else {
-        cmd = KVM_SEV_INIT;
+        trace_kvm_sev_init();
+        ret = sev_init(s->vmfd, sev->sev_fd, &fw_error);
     }
 
-    trace_kvm_sev_init();
-    ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
     if (ret) {
         error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
                    __func__, ret, fw_error, fw_error_to_str(fw_error));
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 2cd8726eeb..2dca4ee117 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -2,6 +2,7 @@
 
 # sev.c
 kvm_sev_init(void) ""
+kvm_sev_es_init(void) ""
 kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%zx"
 kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%zx"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
-- 
2.40.1


