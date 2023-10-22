Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F5B7D2259
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:32:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUkM-0002ao-UI; Sun, 22 Oct 2023 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjM-0001Ms-SD
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjK-00012n-UN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRc5fadVObBzSTIUVVUCoFqEpnBFobcqZOmUrCHqKqM=;
 b=Gy1uNPqAX5kvrUoxM6ehK3vnpRP9Crsj7q6DU2yCrvWPOAx3nUZ685Xy84QbP5boo2sfXT
 ZbKJjCSeZZMRfZ/1L2N3hTCAtD9FD5DKoNNEUDOcACKvL7VIfjFQkBzEUasIYIcbHi4+MN
 5MJllsYCkARQikfr4Dc/FqdSbQfAszE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-1F4PC9zAMTyjlXD_co5kHg-1; Sun, 22 Oct 2023 05:26:40 -0400
X-MC-Unique: 1F4PC9zAMTyjlXD_co5kHg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32dee12c5b4so336968f8f.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966798; x=1698571598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRc5fadVObBzSTIUVVUCoFqEpnBFobcqZOmUrCHqKqM=;
 b=qqUGRblIYzUEQkOXoG53Fhdi7CsiYhOpajsU7OVqpuFuBNMWyDTpZ6uWr/qF7YUHnY
 ztSv7s4Judpf7ZNJy2JQbSwmkEP+q8rXc/aMAYYxBmde6lcV1iKuIoJ3RDFsDcNtBXxt
 GzhiqC6xwxrMb+iJ22ZRWhq3kQKWy7yqJun/oHxdrxEZNQ7YuPbhuKMygHV0LMhhfxtc
 iXInpPttAaGRE8I3DqZ0CyoY1siLmfo8d+ExpgUz+ZiVjbgI/EJARbLap13Qol/TK+hW
 O2Sx3T0nYFgbTWTKC8Le8LXwMdZ3sAMoFlbjWHmrkWeuc+KCNeVQvXaYLvw7e2NGGGuj
 L9Mw==
X-Gm-Message-State: AOJu0Yxnb7YkB6Oa1thPzM17ArgWoRfLnYjYgUTG/tL+lPtHRB54F6Tk
 2baWmehXvpNo+VqUXlIHnZhbdYbPzm4BRAy97WwlUzKDyfqRTRgAhWB9KJgdN4VBMRtyT7PeQF8
 KgxRpJCBh30BBjwuMKhJfn5qgLPCldqnMUa01nue9PH4AsMdCi9g5H/0H2veYpRCxkf+W
X-Received: by 2002:adf:f891:0:b0:32d:b2dd:ee1c with SMTP id
 u17-20020adff891000000b0032db2ddee1cmr4469644wrp.5.1697966798644; 
 Sun, 22 Oct 2023 02:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR2yfemPItI3a1TC/MHokgMIVTtRZirLpVt25Qr5IV8xgTcdAuaMj7zm/61MDLTqbn6+19jQ==
X-Received: by 2002:adf:f891:0:b0:32d:b2dd:ee1c with SMTP id
 u17-20020adff891000000b0032db2ddee1cmr4469627wrp.5.1697966798204; 
 Sun, 22 Oct 2023 02:26:38 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 u14-20020a5d468e000000b00323330edbc7sm5301258wrq.20.2023.10.22.02.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:37 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:26:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 58/62] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <6cdd46f66ff91a9c13c5dc4d018ae53d2f28d74a.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

Add a simple _DSM call support for the ACPI0017 device to return fake QTG
ID values of 0 and 1 in all cases. This for _DSM plumbing testing from the OS.

Following edited for readability

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
                    One,
                    Package (0x02)
                    {
                        Zero,
                        One
                    }
                })
            }
        }
    }

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231012125623.21101-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/cxl.h |  1 +
 hw/acpi/cxl.c         | 69 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |  1 +
 3 files changed, 71 insertions(+)

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
index 92b46bc932..9cd7905ea2 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -30,6 +30,75 @@
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
+        /* CXL spec v3.0 9.17.3.1 _DSM Function for Retrieving QTG ID */
+        ifctx = aml_if(aml_equal(
+            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
+
+        /* Function 0, standard DSM query function */
+        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
+        {
+            uint8_t byte_list[1] = { 0x01 }; /* function 1 only */
+
+            aml_append(ifctx2,
+                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
+        }
+        aml_append(ifctx, ifctx2);
+
+        /*
+         * Function 1
+         * Creating a package with static values. The max supported QTG ID will
+         * be 1 and recommended QTG IDs are 0 and then 1.
+         * The values here are statically created to simplify emulation. Values
+         * from a real BIOS would be determined by the performance of all the
+         * present CXL memory and then assigned.
+         */
+        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
+        {
+            Aml *pak, *pak1;
+
+            /*
+             * Return: A package containing two elements - a WORD that returns
+             * the maximum throttling group that the platform supports, and a
+             * package containing the QTG ID(s) that the platform recommends.
+             * Package {
+             *     Max Supported QTG ID
+             *     Package {QTG Recommendations}
+             * }
+             *
+             * While the SPEC specified WORD that hints at the value being
+             * 16bit, the ACPI dump of BIOS DSDT table showed that the values
+             * are integers with no specific size specification. aml_int() will
+             * be used for the values.
+             */
+            pak1 = aml_package(2);
+            /* Set QTG ID of 0 */
+            aml_append(pak1, aml_int(0));
+            /* Set QTG ID of 1 */
+            aml_append(pak1, aml_int(1));
+
+            pak = aml_package(2);
+            /* Set Max QTG 1 */
+            aml_append(pak, aml_int(1));
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
index b0e1f074f1..80db183b78 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1417,6 +1417,7 @@ static void build_acpi0017(Aml *table)
     method = aml_method("_STA", 0, AML_NOTSERIALIZED);
     aml_append(method, aml_return(aml_int(0x01)));
     aml_append(dev, method);
+    build_cxl_dsm_method(dev);
 
     aml_append(scope, dev);
     aml_append(table, scope);
-- 
MST


