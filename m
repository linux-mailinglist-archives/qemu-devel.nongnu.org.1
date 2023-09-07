Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 873AD7972B9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:13:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeb-0005pE-Sl; Thu, 07 Sep 2023 09:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdw-0004WH-8b
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEds-0007VP-Lv
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIq/O9qNMjpRAveEr93SV2nGg4KhrTDskMws53vhy7U=;
 b=c3CQQ1dWLUmAR2Bd+ulPlyQxNA9YCgfOOTSNrsRct1Rq+W0ct9qdOHLsJxwo0V6pxUwvKM
 MKxc1KGkJS2kxGjLbHn7DX+uw0L6NakWGezSImKv4Uxcgxe8nME31MN/OZXnxZJLqTSIrX
 97VBWnGqCEL4xPaJmCrhwKSk7BCnRgk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-hJAO2njFM-yE4Va-O-Cnaw-1; Thu, 07 Sep 2023 09:01:48 -0400
X-MC-Unique: hJAO2njFM-yE4Va-O-Cnaw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c5adb698aso574687f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091707; x=1694696507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIq/O9qNMjpRAveEr93SV2nGg4KhrTDskMws53vhy7U=;
 b=LI2CQRGCOHmtZQHgmE31XTvzigY63YjcCq3IEPimB/XrCSPz3lrd/NhoT0HaPr/zqP
 1FjlL4JJPRQUlkCzUtG3xy71YoTtBzEfrjLo+W5KFL+7x40d+spKvjQCEK6jQp7SEhXg
 q6uBXKiVeQLpCpYmA0AnaVbjolWes18N8UEqRdrBShbyPQ4ps+76Fv4oKLmPWcOBZS9h
 vlnunzz2w/T1BjsIHTWLMufizpwljgcZtG9QukEhs9aXtAcSIocLrq3fYx7w1CuvE63x
 1FALEgBhzicEyFKta8HoxSvB88fL6F7egXfo6WxbR4uIIQAt8RMwj7N7PL32pUjq29Fi
 hcqQ==
X-Gm-Message-State: AOJu0Yw3E7qh+IQgM4rDLCBsGYKONPARYmVqUQEYO/85SC0Z11RxXQvN
 Y8Hc6cOPcdVINqPajRu7zWFxiOwpmzQKJbq5wxdrHivpxIVcCARjqBGJ/pZdA/AbSDSeC8B726l
 AYHEDo7u6DZfdNn7KmA9UR776om/qB0cMGQpuO1Bpwhczu0oib0RQ6saKhjmAlq1WQZzQULWteD
 0=
X-Received: by 2002:adf:ce8c:0:b0:31a:d112:954e with SMTP id
 r12-20020adfce8c000000b0031ad112954emr4891376wrn.46.1694091707203; 
 Thu, 07 Sep 2023 06:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEavfOSa+12a7Nq8+fQGDEAoqWOA1Si4cgOyqLyV8Tx2AdEJ7xyK6AYBAlDbdlIH4bDjGWhA==
X-Received: by 2002:adf:ce8c:0:b0:31a:d112:954e with SMTP id
 r12-20020adfce8c000000b0031ad112954emr4891356wrn.46.1694091706860; 
 Thu, 07 Sep 2023 06:01:46 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a056000104100b003179b3fd837sm685464wrx.33.2023.09.07.06.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 44/51] target/i386: Allow elision of kvm_hv_vpindex_settable()
Date: Thu,  7 Sep 2023 14:59:53 +0200
Message-ID: <20230907130004.500601-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Call kvm_enabled() before kvm_hv_vpindex_settable()
to let the compiler elide its call.

kvm-stub.c is now empty, remove it.

Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-9-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86.c               |  2 +-
 target/i386/kvm/kvm-stub.c  | 18 ------------------
 target/i386/kvm/meson.build |  2 --
 3 files changed, 1 insertion(+), 21 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-stub.c

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3e86cf3060f..f034df8bf62 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -421,7 +421,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     cpu->thread_id = topo_ids.smt_id;
 
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
-        !kvm_hv_vpindex_settable()) {
+        kvm_enabled() && !kvm_hv_vpindex_settable()) {
         error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
         return;
     }
diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
deleted file mode 100644
index 62cccebee4f..00000000000
--- a/target/i386/kvm/kvm-stub.c
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * QEMU KVM x86 specific function stubs
- *
- * Copyright Linaro Limited 2012
- *
- * Author: Peter Maydell <peter.maydell@linaro.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-#include "qemu/osdep.h"
-#include "kvm_i386.h"
-
-bool kvm_hv_vpindex_settable(void)
-{
-    return false;
-}
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 40fbde96cac..5d9174bbb5d 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -1,5 +1,3 @@
-i386_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-
 i386_softmmu_kvm_ss = ss.source_set()
 
 i386_softmmu_kvm_ss.add(files(
-- 
2.41.0


