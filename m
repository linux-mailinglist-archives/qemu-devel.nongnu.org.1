Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236827B151B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaX-0004ml-1G; Thu, 28 Sep 2023 03:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaV-0004mC-Rm
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaU-00068e-DF
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=aNYqGItu9RUmVKiIZEnyG0H6EhqgQoxLYXkVGQXslqa+Zraceb0+Z5yG4JvqIQKoOibmfG
 S8kXKL/kjgJtDyA9+7ZGTiZsI/Iw5p3InuDV8FZ1P0gn+EK0/lDfy92WVEbCv7hhCyjCzP
 i0LB608Hd2Judx9/wA+a6BhZL0HuYfw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-3eoAC1LaMVyrShpSgQH3SQ-1; Thu, 28 Sep 2023 03:37:28 -0400
X-MC-Unique: 3eoAC1LaMVyrShpSgQH3SQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9aa20a75780so1074761266b.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886647; x=1696491447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=hijHP0dR7e4A15AiyS2xPL/rHM1sBCT+56w2tCLXCkCVClu9h6DUU4zquZRHwFDhfd
 uvfX31H7SIgFhNQx+GYbp3wIuZt0aDbm19T9K2cF0ZC8ZhGUhhK9LgLGi5ks9lha31l+
 HIS5YVFU/mvELG4M+swORrfoQJD43w4q7LET+dl0YubOylDNVRsZHIYOMkdSoVGkhvCF
 QiWiP+onnITf/bTvcVBCy78dc2CXxFmKg8J3vGoh1tysVoHAQdqwTNnXWCQYPv0G5VR3
 izRnfCxeZdq+1zvCkBMH2QMGljB7e0m5Jllu2p7RG0EU2cK0RbZKQtHMp2gVlaif7dtu
 H2KQ==
X-Gm-Message-State: AOJu0Yw5GwMwg2Y4TqxsFH/xL5bqXEtpZ7XLnbHMwqZHZcPutQR01IMV
 OyposIHonBvX83c9EcL02arH/En3Nd1a1C7lBWiTcvuZm7nq9UH7i/mugYug4/PnXa7p6JJbgsh
 ICx38J9JItNp/h68tsihowD4kRPbrQ0ZEr7EHQKfd+P++/5b2CpwqpgOyX+nBo5ZEeoBrMkz+gG
 s=
X-Received: by 2002:a17:907:c205:b0:9b2:89ec:7fca with SMTP id
 ti5-20020a170907c20500b009b289ec7fcamr566553ejc.34.1695886647259; 
 Thu, 28 Sep 2023 00:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYd8ZG9irIv/FXFssVTJGNWnE17uhWdnsxu2dgoPuMaZRtx0UnQ23A5C8i2xXYtA8SfLLfng==
X-Received: by 2002:a17:907:c205:b0:9b2:89ec:7fca with SMTP id
 ti5-20020a170907c20500b009b289ec7fcamr566540ejc.34.1695886647034; 
 Thu, 28 Sep 2023 00:37:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 va1-20020a17090711c100b0099d9dee8108sm10524646ejb.149.2023.09.28.00.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, balaton@eik.bme.hu,
 Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 10/13] hw/ppc: Support machine-default audiodev with fallback
Date: Thu, 28 Sep 2023 09:36:54 +0200
Message-ID: <20230928073705.871327-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928073705.871327-1-pbonzini@redhat.com>
References: <20230928073705.871327-1-pbonzini@redhat.com>
MIME-Version: 1.0
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


