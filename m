Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3765D7B7A83
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxVg-0007WA-1e; Wed, 04 Oct 2023 04:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVD-0006wn-N7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxV7-0001vy-4w
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9u8canphjwrzMlilDGdNcWlp6q3G+6VeDv27FGg6EqY=;
 b=IHblSUGKCowtOQ8fqvn9AorCaQJoDQq1a4B4e7NnjnB5UQ/tEL992muhGrcU3feE3dlWJ2
 lpxxUvsFLrwFm4/0v449E9fMq5AySfkWN8VhEDozxEx5Qb0u8plqK1gHe5dwPW0/Zt2bN9
 dhd48/4dOmmOBpd/5qAv5kEtpeWhFfg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-VykSZEoGOYKgcuQiECUPSA-1; Wed, 04 Oct 2023 04:44:57 -0400
X-MC-Unique: VykSZEoGOYKgcuQiECUPSA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-405334b0873so13622725e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409096; x=1697013896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9u8canphjwrzMlilDGdNcWlp6q3G+6VeDv27FGg6EqY=;
 b=HPr07rG01v3h7rNnHSPFTWuqZfnbxRq9BjgCL5yJZ/9lLpfvqKkrQy0LVq72pzGjh0
 SIIcjETmk7t0PooBjYW5p2myRa3hBKZs3x4ejPCMT9mqFfv8W7+vUoU75/g2mtUUmoon
 myPdpvYeU0or2wKfH8BKmNt+ISL+KRjwISWg/HEE8LwlfTGL5SkmU4/v3fL5kAEKed6H
 OyZytBfVcWNjQg5O7okFcNQg2HBKxF8LrlgAup4KVaflUIaAfU+v8Vn8PSYwE5jopRAV
 zqx+1jRg3AsxpUFjISUQ9Znaq9YwQTnNUAEBFkukSGLS7rUxo6Eb1riBH8VgJvVdrHvj
 kvgg==
X-Gm-Message-State: AOJu0YyktdF3yxEvZax5LdH5xE9XhCFRLXlXg8Z9qavfiEXjM5Yy8naJ
 dfoISe+qbNwptVam1t81CKU20dfTIt60U5fVhHWd9ItgKNMxLipUU54RSfECSj0GyQk8ujZtXok
 Pq8mjtSVp6vI4d4VrEjJykgWlBCcbSeqK1rza0R/F4L6GAhPMK09p147BTIoV7gnokdlE
X-Received: by 2002:a1c:4b12:0:b0:405:4a8c:d4f8 with SMTP id
 y18-20020a1c4b12000000b004054a8cd4f8mr1743091wma.30.1696409095617; 
 Wed, 04 Oct 2023 01:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxgeEf/cP5NDmYrP+JA1nVTPC+4ygYs7V4HMiPMuGoClK4MnLqmzjxPzFKfuHKbsUaTryxPQ==
X-Received: by 2002:a1c:4b12:0:b0:405:4a8c:d4f8 with SMTP id
 y18-20020a1c4b12000000b004054a8cd4f8mr1743076wma.30.1696409095352; 
 Wed, 04 Oct 2023 01:44:55 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c11-20020a7bc84b000000b0040648217f4fsm935641wml.39.2023.10.04.01.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:54 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 33/63] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <0bae0aebf44ac89b47ef11c5d101323dd5540951.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Dave Jiang <dave.jiang@intel.com>

Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
ID value of 0 in all cases. The enabling is for _DSM plumbing testing
from the OS.

Following edited for readbility only

Device (CXLM)
{
    Name (_HID, "ACPI0017")  // _HID: Hardware ID
...
    Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
    {
        If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
        {
            If ((Arg2 == Zero))
            {
                Return (Buffer (One) { 0x01 })
            }

            If ((Arg2 == One))
            {
                Return (Package (0x02)
                {
                    Buffer (0x02)
                    { 0x01, 0x00 },
                    Package (0x01)
                    {
                        Buffer (0x02)
                        { 0x00, 0x00 }
                    }
                })
            }
        }
    }

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
v2: Minor edit to drop reference to switches in patch description.
Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/cxl.h |  1 +
 hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |  1 +
 3 files changed, 59 insertions(+)

diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index acf4418886..8f22c71530 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state);
 void build_cxl_osc_method(Aml *dev);
+void build_cxl_dsm_method(Aml *dev);
 
 #endif
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 92b46bc932..5e9039785a 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -30,6 +30,63 @@
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 
+void build_cxl_dsm_method(Aml *dev)
+{
+    Aml *method, *ifctx, *ifctx2;
+
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    {
+        Aml *function, *uuid;
+
+        uuid = aml_arg(0);
+        function = aml_arg(2);
+        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
+        ifctx = aml_if(aml_equal(
+            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
+
+        /* Function 0, standard DSM query function */
+        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
+        {
+            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
+
+            aml_append(ifctx2,
+                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
+        }
+        aml_append(ifctx, ifctx2);
+
+        /*
+         * Function 1
+         * A return value of {1, {0}} inciate that
+         * max supported QTG ID of 1 and recommended QTG is 0.
+         * The values here are faked to simplify emulation.
+         */
+        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
+        {
+            uint16_t word_list[1] = { 0x01 };
+            uint16_t word_list2[1] = { 0 };
+            uint8_t *byte_list = (uint8_t *)word_list;
+            uint8_t *byte_list2 = (uint8_t *)word_list2;
+            Aml *pak, *pak1;
+
+            /*
+             * The return package is a package of a WORD and another package.
+             * The embedded package contains 0 or more WORDs for the
+             * recommended QTG IDs.
+             */
+            pak1 = aml_package(1);
+            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
+            pak = aml_package(2);
+            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
+            aml_append(pak, pak1);
+
+            aml_append(ifctx2, aml_return(pak));
+        }
+        aml_append(ifctx, ifctx2);
+    }
+    aml_append(method, ifctx);
+    aml_append(dev, method);
+}
+
 static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
 {
     PXBDev *pxb = PXB_DEV(cxl);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4d2d40bab5..4fb18fee3c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
     method = aml_method("_STA", 0, AML_NOTSERIALIZED);
     aml_append(method, aml_return(aml_int(0x01)));
     aml_append(dev, method);
+    build_cxl_dsm_method(dev);
 
     aml_append(scope, dev);
     aml_append(table, scope);
-- 
MST


