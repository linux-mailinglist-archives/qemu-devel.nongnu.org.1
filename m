Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD39C7B5591
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKMv-0008Dw-IB; Mon, 02 Oct 2023 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMt-0008DY-Lx
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMs-0003fy-Av
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=FHAECAISjX2rWrF+Vi1yTshK1OBNmETZfawOxsbEBY4dHiR2vKNLPbK56JEnS5q/MR7TCo
 AGKidovyLkDdEPjdsu0LVK/JWGdiUsJBohSzb2JiFMfNNh4+D0BaEM1tntiYo9+EI3+Moa
 WHDS/V/JlTWnROgl/B2Y2UtneV+j5lw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-GoObLt0oM-WgmsPz4jvvuw-1; Mon, 02 Oct 2023 10:57:52 -0400
X-MC-Unique: GoObLt0oM-WgmsPz4jvvuw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso1422641366b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258670; x=1696863470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=I77rxlEzluGTmLyszR5Ks38XsLS4/zUpy71fn9JqWmw9joJgduFV1j16gVf1g+d81R
 3r77cbz2h2jqvSyyGQdESsvgGWXpHeMESfOTYkeX+ODAk+VinBzpNoS2CtnRgqaspZz8
 mKnbaiw5k3FBCNPjG5tzW7uHwyelYNR3ADtF27bHlou/0TiIIw/jtI4BbmSmE04Pqe6K
 o9EVYldWSWbRxAApYR2wQbk20/5D5nTN1pfkEQsp6c/GfnXAlQ0D68KyE+o3J6v4IglD
 GibZkKBakkxczvcTmwZgycJqOvqvz+xybmSM2mRgOWoIYhjiM/kxkfeLIMWyGdor3i3T
 t0bg==
X-Gm-Message-State: AOJu0Yx9w/613zwuEK11Q9FpJEp0Qm7TCUDOttga7YhILT3xWeo9JkV4
 y0yuQEwsVnij8l84PpsUEgvl0/SpUumUZ5njiTKHN/NnpAVhkJjvjwkPxnpbI7Trsco+2Y9qA0f
 eIDHUifCguYU2OTbpxKEQoHiuBpCd9f2zhN7VM0ev5yZtorTSTeaSsW+IgmhgC5pRxu1P85Q3Yr
 A=
X-Received: by 2002:a17:907:2cd5:b0:9ae:68dc:d571 with SMTP id
 hg21-20020a1709072cd500b009ae68dcd571mr10313131ejc.46.1696258670556; 
 Mon, 02 Oct 2023 07:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb8JDPAoVtLuasUZ/hf7q9+mpBn1PidpmU3WyY62PvHWT1sb2gzH08wVwrkfGjwIpab35Bdg==
X-Received: by 2002:a17:907:2cd5:b0:9ae:68dc:d571 with SMTP id
 hg21-20020a1709072cd500b009ae68dcd571mr10313115ejc.46.1696258670230; 
 Mon, 02 Oct 2023 07:57:50 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 lw13-20020a170906bccd00b0098884f86e41sm16920492ejb.123.2023.10.02.07.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 10/13] hw/ppc: Support machine-default audiodev with fallback
Date: Mon,  2 Oct 2023 16:57:24 +0200
Message-ID: <20231002145728.87958-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145728.87958-1-pbonzini@redhat.com>
References: <20231002145728.87958-1-pbonzini@redhat.com>
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


