Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6C7ABF0C
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQN-0002x0-0n; Sat, 23 Sep 2023 04:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQK-0002w6-Jp
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQH-0000YE-16
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=P2yZikTg5iN04G/w4ecVdxOOF1JZziyRszjAsxNlnDsepd0LwcgsvoT5yIpKAfx9vjHSAG
 wX35M+t7P8373XgskiAa5QXLQf5rkPzxV2V27W778pRszAeS77mE5YgwisCUxvNEK4O7kx
 pqAwilbWrOFZbf/JE45ce8ntD+zIoOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-CDU6GxJGMhOeCtaqVxeLMQ-1; Sat, 23 Sep 2023 04:55:30 -0400
X-MC-Unique: CDU6GxJGMhOeCtaqVxeLMQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so26868005e9.3
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459328; x=1696064128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=vpUpyYICxfqMYqi30ZsOvgbiiyfTxAF9y3k3gBdpK97wY8/h/BDNyckmIA3DunOBjd
 pzLQlCiA9pXfv7zVEtqjr4gK2Pq8feymmTfScBaCwrvPNKt0wVvqKoaZbTHK0g853V/l
 3MmFbqzGxsJpmE78+zTKvVW9rvb5rGax7082Inya+Jr3NmL0tsWrX94J5R/ylUaDfDxj
 jzNBPADaf2lc/QZNkk2oRnTnARULL2Mm4jtxXQSzPRkcr3q3jTwD+zX1mExFR+/ZzXir
 fZkvUs0u9vjil0RDnn309zQR/pePdcERZebYWaqO66I4OgPIdX3/aU1tbnU32KcxcVql
 oM+A==
X-Gm-Message-State: AOJu0Yw/cfNto/p+6yD13kqoOrKmSnBxFxIO3cMgDnzlIeRUq80Vafji
 bX08xY9QowRI5xPdyHhjKvX1vsSF9r7u9UpU7qW2JWeMKRleKKMp5OnS1p4P1KGl5zq5j4naTug
 bpSO5dUyhU/wHbz/Mipbwu1nVAchOzHJnH6lsVsoqp65tShJMhWanXurBOTCUSLjk9DFbLRSpaQ
 Q=
X-Received: by 2002:a7b:ce93:0:b0:405:3ae6:2400 with SMTP id
 q19-20020a7bce93000000b004053ae62400mr1270645wmj.23.1695459328682; 
 Sat, 23 Sep 2023 01:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG99dLGvM9KyFf+pHPA+1u8E1hzV47sWyTWqSMO+pYFMbKO3UNEV8YEVZ1DiPzwNy2IQC3reg==
X-Received: by 2002:a7b:ce93:0:b0:405:3ae6:2400 with SMTP id
 q19-20020a7bce93000000b004053ae62400mr1270631wmj.23.1695459328351; 
 Sat, 23 Sep 2023 01:55:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c240c00b003fc02e8ea68sm9526563wmp.13.2023.09.23.01.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 10/13] hw/ppc: Support machine-default audiodev with fallback
Date: Sat, 23 Sep 2023 10:55:03 +0200
Message-ID: <20230923085507.399260-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
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
 hw/ppc/prep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index f6fd35fcb9e..137276bcb92 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -45,6 +45,7 @@
 #include "trace.h"
 #include "elf.h"
 #include "qemu/units.h"
+#include "audio/audio.h"
 
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
@@ -310,6 +311,10 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
+
+        if (machine->audiodev) {
+            qdev_prop_set_string(dev, "audiodev", machine->audiodev);
+        }
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
         isa_dev = isa_new("pc87312");
@@ -426,6 +431,8 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("40p", ibm_40p_machine_init)
-- 
2.41.0


