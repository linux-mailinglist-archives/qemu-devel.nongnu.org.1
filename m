Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26207A0C17
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqc6-0003KY-7G; Thu, 14 Sep 2023 13:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc4-0003KG-VZ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc3-0002Es-Cc
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VBskaJXZziliJm4qr2RVmqGx7fudPW2YJcT+hAMbW0=;
 b=M8Q8yucXe7XIM1tZsgankyagWiZha7t4MDFEFtwEWC/Yc823lFEIfR4a8IYUIj9hHe68EV
 6jYtkdhVicb0ULNRw+iDyKbcmrLb2B9ptR323rl0iynFyIMMaUPolPuLE6lxc1138uK9sL
 RyUVNFZerIfAx/NjY9TMmr6Pwv3+hf4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-JLQtxqIPOImShJvJSLwAog-1; Thu, 14 Sep 2023 13:58:45 -0400
X-MC-Unique: JLQtxqIPOImShJvJSLwAog-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6562fff4a2fso2912166d6.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714324; x=1695319124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VBskaJXZziliJm4qr2RVmqGx7fudPW2YJcT+hAMbW0=;
 b=hX7leFd+Sf17JRD/wPE2bVkkxOUqO+DMqKEAaebtKn+f6jAek7WiANnV5XHaW7ib7e
 VXtmCzLaFsMu2GQKP+VDVrK9g9znQXdMRWIh85WN5EfeIsnUsEu1XlewL7EWTvb99pnU
 VkFSU5Dw5Gx1NfL33nuZKla35BmZhaLfLcwtzM360Jo80IicJOAJrevub2IlbxuQRYLN
 Br3g3YqhhDOv1Tk9JD/nx8v/AMzWzkEckaFEHk7We075AA2ns0WnAYpDuUcuHQ19r6tI
 mBYTWbMEdTq9hTj/WkDNXxfPsWaYxzpzqGqJcGbmytGX7i4XFbTspCDD6v8NTidjCL8c
 OfzA==
X-Gm-Message-State: AOJu0YxjelJg/0VmOlwlxHm1NlUGLqPPSwjERPZRmddrmrs2QWTQTNIF
 dDXjsPf9wg+koQKjCOESQw7zy38yuuk9776yCKKxaB0aO9luYsFS+wjBsXyx5LcWVs29WrdFAXw
 XOJE/V/3IJONPDGEzWr3mmgkNT8/0EfL2MoLUFgDWB7XtidunK8nZ0JbuqZT7gZ/WDYHOgHND4T
 fAKw==
X-Received: by 2002:a0c:f10b:0:b0:651:5b77:1ab5 with SMTP id
 i11-20020a0cf10b000000b006515b771ab5mr7275951qvl.22.1694714324084; 
 Thu, 14 Sep 2023 10:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/C3ZzQf/VrPFSK1890wSlPyBMkHQsQpaVv3m+QuVGKsDzg0cvU6R2E5puh2W7fBe2LDq4gg==
X-Received: by 2002:a0c:f10b:0:b0:651:5b77:1ab5 with SMTP id
 i11-20020a0cf10b000000b006515b771ab5mr7275928qvl.22.1694714323765; 
 Thu, 14 Sep 2023 10:58:43 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:41 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 2/8] i386/sev: Replace INIT and ES_INIT ioctls with sev
 library equivalents
Date: Thu, 14 Sep 2023 13:58:29 -0400
Message-Id: <20230914175835.382972-3-tfanelli@redhat.com>
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

The sev library offers APIs for SEV_INIT and SEV_ES_INIT, both taking
the file descriptors of the encrypting VM and /dev/sev as input.

If this API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c        | 14 +++++++++-----
 target/i386/trace-events |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index fe2144c038..f0fd291e68 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -18,6 +18,8 @@
 
 #include <sys/ioctl.h>
 
+#include <sev/sev.h>
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


