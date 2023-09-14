Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958A7A0ED0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsgJ-0002FE-FX; Thu, 14 Sep 2023 16:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKc-00059S-10
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKY-0000g7-2U
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VBskaJXZziliJm4qr2RVmqGx7fudPW2YJcT+hAMbW0=;
 b=ghLSFwx82CyX0EI+xDzYnW1WgiHoQL644f790BX9JjUbDHG+t2c9pifonMDnJm7cGQzTG4
 43SAD55VHvfffsInLGTxU3qgfNNRwt0M3YzW8/fgVNTrkqAVOKsp0CEMUOjURrRwUihgNi
 DtNSTdpBcyE4ULhyL0z/SNAwTG8eWWU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-_NlEfQKfPkqDroKc4RSaAQ-1; Thu, 14 Sep 2023 12:35:27 -0400
X-MC-Unique: _NlEfQKfPkqDroKc4RSaAQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77055ad7aa8so144509085a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709326; x=1695314126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VBskaJXZziliJm4qr2RVmqGx7fudPW2YJcT+hAMbW0=;
 b=PxJXDIxPNidJtWyh+y3e8uqqtFFxdIoo376yBYfmsRSM50PfZxwstta2MDNPsVrUaT
 07iSdA3HR7eIcd+KZ9JnAoO2vCGJX8L+N9ogE6CwS7k0mmfG8dCqsrkCzbaMrY+yLdZo
 WgdZ17X4dY/K+Qldv8XFJa8JecxOD7Re1kMaPBgD6XcEoJ4AKc1YEmeNHHJSpQThI3FR
 2tI8gStryMb+zXqprXfLl8EgKDxYIeEw7znlo2YtOcv6YkXZ51a4Oh3rN+WECw6XWwSj
 O7vmPyoP0erxYTmnq8ydOT7w98n5lGtzwXuPuRUqFhVqeS+gVIVVtHtKDW/alS1IzYVc
 NLJg==
X-Gm-Message-State: AOJu0YzLfv3fd47c9zdynS2w5V4K/8uxdSBiYZ9hwB/Jnc0ULDHpq4pQ
 yTDD9SqwWvrTuXTttrPoL7Dkf01rdaY/A5i2zTNNaBNymCAzT2ZnqT2Jt5lEV7aQZLmJOANfAut
 QdIU0ZwLfi7+TqogxnebceteFyKzrFU/A/I36Vk1K9grfi6fM8mm/MLXUIdksK2gj/CnNCUS8tR
 za8A==
X-Received: by 2002:a05:620a:4555:b0:76d:aa66:f7b4 with SMTP id
 u21-20020a05620a455500b0076daa66f7b4mr8296655qkp.11.1694709326438; 
 Thu, 14 Sep 2023 09:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM2Zom4nf3jj4jWOd4J6g//BybRoS0Lvau5hA2ltJfW/O/m+zePoXwAiIoIhmzNQHfKThUwA==
X-Received: by 2002:a05:620a:4555:b0:76d:aa66:f7b4 with SMTP id
 u21-20020a05620a455500b0076daa66f7b4mr8296633qkp.11.1694709326177; 
 Thu, 14 Sep 2023 09:35:26 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 l11-20020ae9f00b000000b007677347e20asm577244qkg.129.2023.09.14.09.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:35:24 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 2/8] i386/sev: Replace INIT and ES_INIT ioctls with sev
 library equivalents
Date: Thu, 14 Sep 2023 12:33:53 -0400
Message-Id: <20230914163358.379957-3-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914163358.379957-1-tfanelli@redhat.com>
References: <20230914163358.379957-1-tfanelli@redhat.com>
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


