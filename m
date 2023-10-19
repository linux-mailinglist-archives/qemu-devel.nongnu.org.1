Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD07D01A0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXi7-00022r-7C; Thu, 19 Oct 2023 14:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhF-0000Ec-K5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhD-0002fp-Nl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRc5fadVObBzSTIUVVUCoFqEpnBFobcqZOmUrCHqKqM=;
 b=R8eG7eWO0wqdnlW1dpYH9LoaUCYcoJyluHxT/SQJjDjaFnXxi5XjwWNRHHwuZVnM28BSaq
 ABxtI6UA2Qn4vZovPktfRAGWeau0WNMFrv8eySB55wQZhp1dENc2FzNXeCiS9zk0xyKUsS
 Of8Mmju/rjQfa1z7K0rLQ52mn1CxqPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-GMFneEkkMYS7Z957uD7vGQ-1; Thu, 19 Oct 2023 14:24:32 -0400
X-MC-Unique: GMFneEkkMYS7Z957uD7vGQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so14839f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739871; x=1698344671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRc5fadVObBzSTIUVVUCoFqEpnBFobcqZOmUrCHqKqM=;
 b=MN9zwwMa6mr34R98Bq1cTKK34NuaqfrPYXavV0eq7ucsbPid5I4dFWfjW8gDRMVleR
 MDpIxowKFyl0SBSzXzO7vfhXElem4kjiN0tqnQYWR9c2jR8g7CpuuiK2W4ISbUWqOHie
 x0MgVCjOEC47wftatZ06gduRhUlnyh+ONG7zq4oq5M3GvVA6Zr/IZnX1zgzgVUeFCrR9
 Ibtphz4H74rw2pxkhcSRBEVlS9PR3ScUJHMIElaWClj+h1mbrtA/bSKf4q816iS4LJos
 7vVBv1bB8PZdKD7JBG+/9n7eA71LxND174zsdgnFeCz0W9fbIpTIIZCS46pJd87hPTud
 /Q3Q==
X-Gm-Message-State: AOJu0YzDE8aImQtO+tBKkMaFf7XxHX6JTptOej8TVTV/5Ka+Riywl2H3
 nzaPgwwcF1tt5EPlAznXqPklnW5zkCpXXTly19a3piFi/2nqjlbqORqHlJIFb3GbVk9pwvgtZDR
 abFUbD/q53RIitf6XgU1NNlTznh/HvGIdRl839A/UHMtSCTEqcjgZqNRoEQyP9NM1d2NH
X-Received: by 2002:adf:978c:0:b0:32d:c5da:d4c0 with SMTP id
 s12-20020adf978c000000b0032dc5dad4c0mr2811278wrb.3.1697739871378; 
 Thu, 19 Oct 2023 11:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Ah4u3Yv2bgNrAL+qK2HCA9ibDYo4vnrgEPc5rUtFI7SiY8mVog29mVLWq+5bvUq3iramVg==
X-Received: by 2002:adf:978c:0:b0:32d:c5da:d4c0 with SMTP id
 s12-20020adf978c000000b0032dc5dad4c0mr2811263wrb.3.1697739871108; 
 Thu, 19 Oct 2023 11:24:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm5020626wrv.66.2023.10.19.11.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:30 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:28 -0400
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
Subject: [PULL v2 74/78] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <5485c304d89dcfba243c0d6b94bee91c1eed2c0f.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


