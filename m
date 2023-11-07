Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 368807E38AF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:18:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4F-0000Ga-ES; Tue, 07 Nov 2023 05:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J46-00085d-Kz
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J44-0002fK-UN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ACyePYuwAqhNiNSLL7HwFgNEUdgIfSbmJfWFYv0Xilc=;
 b=aRgG2dJ/9pPPAZItMw5QTX9bRH6eFclBKJB+hkh/1XaluuGqAgV6kis2eH27uSQTz1/2Mo
 MAh0cUXhsoQo2v9YuTIxrAYzLqgsaNGZxQj1v0qgUtW+GZ+NDH+YfAdJmPS2F5cRnFmi6B
 u7S8Dpy8fFyQFjY6PaR3QFwyxLsGMM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-RH1CEjd1ObKc1P5n61UUZQ-1; Tue, 07 Nov 2023 05:11:57 -0500
X-MC-Unique: RH1CEjd1ObKc1P5n61UUZQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408524e2368so32854285e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351915; x=1699956715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACyePYuwAqhNiNSLL7HwFgNEUdgIfSbmJfWFYv0Xilc=;
 b=ejc7kJrfv/c6YmuEVQGaNIiXc+L9p2jww0cmR6pLyWleUinM6/jCYZxRRQxy9fq6db
 OdQoa1ZfH5NSUcHvpAI03Aspel9zQUKc6WGJNDdQ2eyvcuioLyzZme7pgobYriAlfkZV
 Ixks+tVLxDl1P7zjl1Bnod+/sbbpOJdRy0LRPShHP699t5zRy7trIHl+kxOOi1sQIinI
 BZJVH4tGHvfda1BjLKyqTWLvG0VsC6xXFiQ1JUdhgOV45JPrIb7b9X8qSIFwMGyPBNFO
 f3tMDf+n1FnFIrSi4BNGcsK6+9Y6ZXv3NOYWpbQwuf/kZ/fxljiHTiX52V0mA6C/kpbh
 rbDg==
X-Gm-Message-State: AOJu0YwX72F1Bm2URH3PoG2NVk9zRquj6OzOY9TwkoJui2Po1r08TE0K
 aKNc7aYDE/o4vRFZC0GT2DJMPOKoSrAdgnjT7YngProfUYtLW517uiu7eOqktdb342hI1k8en2E
 rOZxxswoM9aIdcecaOmyob0NpczCMiCFFbksWehk/QH0GoHrM+v1IMf6kjziTGDpOsupw
X-Received: by 2002:a05:600c:2d48:b0:406:84b2:67f with SMTP id
 a8-20020a05600c2d4800b0040684b2067fmr1886906wmg.20.1699351915302; 
 Tue, 07 Nov 2023 02:11:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvqmB7XloJac9+m8GkRrbHaCsFZGW4NOFSCcWoWXlfM4jwApS0WpWp+VcRxXF9Kj5tuVZqCw==
X-Received: by 2002:a05:600c:2d48:b0:406:84b2:67f with SMTP id
 a8-20020a05600c2d4800b0040684b2067fmr1886886wmg.20.1699351914949; 
 Tue, 07 Nov 2023 02:11:54 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c1c0800b004063977eccesm15365868wms.42.2023.11.07.02.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:54 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 32/63] tests: bios-tables-test: Extend smbios core count2 test
 to cover general topology
Message-ID: <6dc82e32226dd3455a1b82bb2ef37d938570084f.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The commit 196ea60a734c3 ("hw/smbios: Fix core count in type4") fixed
the miscalculation of cores per socket.

The original core count2 test (with the topology configured by
"-smp 275") didn't recognize that topology-related but because it just
created a special topology with only one socket and one die by default,
ignoring the effect of more topology levels (between socket and core) on
the cores per socket calculation.

So for the topology in this case, there're the following considerations:
1. cores per socket should be more than 255 to ensure we could cover
   the core count2 field.
2. The original bug was that cores per socket was miscalculated, so now
   we should include as many topology levels as possible (multiple
   sockets or dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the cores per socket
   encoded in the core count2 field is correct.

Based on these considerations, select the topology with multiple dies:

-smp 260,dies=2,cores=130,threads=1

Note, here we doesn't configure multiple sockets to avoid the error
("kvm_init_vcpu: kvm_get_vcpu failed (*): Too many open files") if user
uses the default ulimit seeting on his machine.

And the cores per socket calculation for multiple sockets has already
been covered by the core count test case, so that only multiple dies
configuration is enough.

The expected core count2 = cores per socket = cores (130) * dies (2) =
260.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-10-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c20f6f73d0..f3af20cf2c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1024,10 +1024,12 @@ static void test_acpi_q35_tcg_core_count2(void)
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
         .smbios_core_count = 0xFF,
-        .smbios_core_count2 = 275,
+        .smbios_core_count2 = 260,
     };
 
-    test_acpi_one("-machine smbios-entry-point-type=64 -smp 275", &data);
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp 260,dies=2,cores=130,threads=1",
+                  &data);
     free_test_data(&data);
 }
 
-- 
MST


