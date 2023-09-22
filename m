Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2637AAE9E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjciu-00021F-0t; Fri, 22 Sep 2023 05:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcir-00020d-7q
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcip-00066c-ML
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TCItK66JDIU77N/PqYhs/8wtyNXVpZ98siSsNIqjGs=;
 b=VM+hT1LNb/LdEGtpcpdMchkUYb0bOxg4Azn7fkdAH6ayegUuLt/6H+wx8pX/Rsx8QrWCOY
 RVQJYwgEGMYt1boTuV+Z/cIKR3qd4lddpFA8HUKuhKrxsQZSnb7ECJCvu+q/S5vi/BGDzC
 aZreLRc7n7+LBUeJP5vIkjKOJhdsFUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-_qIEVIYlN4u3f34KoPdd4g-1; Fri, 22 Sep 2023 05:45:12 -0400
X-MC-Unique: _qIEVIYlN4u3f34KoPdd4g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4053e4195c6so3194885e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375910; x=1695980710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TCItK66JDIU77N/PqYhs/8wtyNXVpZ98siSsNIqjGs=;
 b=NWv2uk6k8COYf0rPaTk9KQ6Vv6/QbkAYKLMcZGgz2TbX9yphriledSsC9BEdeBmOcC
 if5sOuxbNASqFshQAbVr8vwWwf7rR+q8JA477YJbddhxNfSJa6qh9cL9BO2wz2sWFfnO
 jStiq4uZz2G3Af6ACu2C3gZbJBjs6TavHvDvzeplWSInMkDNH9J5y8UhDOjlAM+wvdtk
 pcW2bvPK8otc/+IkQ74ejRffu+Actdlm+r8RujGGFKQKrqTMoYhQvcbmRhiQtv9IWm0r
 nS/EeLtkPtIuK4GuJxWhx6yAIJBH0XoS/IS7Jv51tz9omYM6MYFEh+5lWXsGN2tq61gm
 HNpA==
X-Gm-Message-State: AOJu0Yy5yCkKpGG77q2TVBbu4PZMT790Dp8avA0XRq8X4my7lU1K2Qj5
 lWHVlcumheAASfqy3vqvMS36jAMq+ONZJnEbFLQwAWTwRuu1Urgu9ankVfM7+Vcd5pKWLIuKgL/
 1aiN2cLnFF8YAErzhHX/yWzElXQgROUQVQ6B7RXtymnGlvKsf5NfWEbtKIR8Vdiwvj6yPESO8Ch
 o=
X-Received: by 2002:a05:600c:444e:b0:405:3d04:5f53 with SMTP id
 v14-20020a05600c444e00b004053d045f53mr1286681wmn.39.1695375910642; 
 Fri, 22 Sep 2023 02:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENp6xX/eLcWGACqNm29esafxvr3Q76HIiTEF1F+5HphYAID6YnCg748KE+cF7PAZovSBn4hg==
X-Received: by 2002:a05:600c:444e:b0:405:3d04:5f53 with SMTP id
 v14-20020a05600c444e00b004053d045f53mr1286661wmn.39.1695375910158; 
 Fri, 22 Sep 2023 02:45:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adfd0c8000000b00317a29af4b2sm3992269wrh.68.2023.09.22.02.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 5/9] hw/ppc: Support machine-default audiodev with fallback
Date: Fri, 22 Sep 2023 11:44:55 +0200
Message-ID: <20230922094459.265509-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922094459.265509-1-pbonzini@redhat.com>
References: <20230922094459.265509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Martin Kletzander <mkletzan@redhat.com>

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/prep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index f6fd35fcb9e..739ff0ea8ad 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -45,6 +45,7 @@
 #include "trace.h"
 #include "elf.h"
 #include "qemu/units.h"
+#include "audio/audio.h"
 
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
@@ -310,6 +311,9 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
+
+        qdev_prop_set_string(dev, "audiodev",
+                             audio_maybe_init_dummy("ppc.defaudio"));
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
         isa_dev = isa_new("pc87312");
@@ -426,6 +430,8 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("40p", ibm_40p_machine_init)
-- 
2.41.0


