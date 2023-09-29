Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA37B2E7A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EK-0006J5-Vn; Fri, 29 Sep 2023 04:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9EC-0005iH-Io
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Dp-0005n3-Te
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=dcyxyfmae33IcjCCpnAuSye7DhgBm2ywDlLIldX8aKu8sslAB1uyf4cozkhSkR2H1MIaOF
 Zpun7eoOmVRme6UTcArMguopM2FK3xK/1Cu/ALKS5wPqHuNA4eQhnT85PRaM7RB9DG0Zku
 Xge1DJ+FSfyoKM4bKtAF92NQn+YzVnM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-NHGGtPyPP-yTG3pp-YRfEA-1; Fri, 29 Sep 2023 04:51:37 -0400
X-MC-Unique: NHGGtPyPP-yTG3pp-YRfEA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a348facbbso1166096766b.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977496; x=1696582296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=QZedNbLtd+NxwGjzQyCiELH1xu0FP/wRY8eqjxC5TqeCxZG/Sjcthi7s5/Ds9I0Ay9
 gp/PLUqn13iHee+sqIkTC7ZJKVNonP8qL0PBhw74CVgOwlDIzETs5IH7Y/l1z0Hp/Cns
 UDUcCSRard2lQ4NhfdVf8h2gvHIS+Q3ALyn44pgHKKnrLrVyNNtw2ES/nbgi3WqOJS8k
 bZoUFDSOJ2ofwoZ3mlfS/OGDM9/9EqE2Nc5yPutjjXxvjXh9ZVivOJX7bRgJGaevyIy2
 qNPNURbcnQKLu2GnbWF2I9GMyouy7hSXlCmLrSKMdd6bGTR7q0vogAW9pnKWImeUPrcP
 40Tg==
X-Gm-Message-State: AOJu0YxQdBMNLfULBtwGoYQ0bvZe6FnuoTHdGilMTDzkvGJ1X1vydePY
 4AS9BiXoQfkAYaNFxmzX/DnuA3x//i4HhA3FX49mjnOfC3veB9BfeWPdrfaOW9vOu3+1nC9m0wL
 X/jyY19rwwl2Bj1JYVUioac8Da/JK5DyybUJRVanpPvNm8QaCGVbkCj052MqbTiIDXeaEjdgI0Q
 s=
X-Received: by 2002:a17:906:210a:b0:9ae:6ad0:f6db with SMTP id
 10-20020a170906210a00b009ae6ad0f6dbmr3181186ejt.71.1695977496359; 
 Fri, 29 Sep 2023 01:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEoADWa7rZuEBSK115eDxt6qrzUqhsEZVzFkSSoysX5OkSVhNR5ZDHBLBmz5c3gdCw0eHZdw==
X-Received: by 2002:a17:906:210a:b0:9ae:6ad0:f6db with SMTP id
 10-20020a170906210a00b009ae6ad0f6dbmr3181173ejt.71.1695977496035; 
 Fri, 29 Sep 2023 01:51:36 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 z27-20020a1709060adb00b00993cc1242d4sm12111608ejf.151.2023.09.29.01.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, balaton@eik.bme.hu,
 Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH v3 10/14] hw/ppc: Support machine-default audiodev with
 fallback
Date: Fri, 29 Sep 2023 10:51:03 +0200
Message-ID: <20230929085112.983957-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
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


