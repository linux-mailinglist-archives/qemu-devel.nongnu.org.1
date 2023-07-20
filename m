Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F575B034
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTsP-0006ql-Ga; Thu, 20 Jul 2023 09:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs6-0006hp-OS
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs2-0007WR-Er
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689860345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jzMNYsmpSSZFcpUP3iC+N9RXlHH3VNA2UmQh/CesDEY=;
 b=dzSbttoZGm6bBp66PEyQw92nQdrHvCu81OVsJ1fJYdRTvV96SN5HQdyZBLRRGEtKEruj7G
 tKCnTVv/WJ8nqRJcOQGvwD6GNRxj86IKVpDGLFLUxcDM3DkfeHW7CrNTKbOnqRNAaRtNe0
 udDRS0vSl5SO6T4lJYBySsERFY9n9S0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-mLpWJkyfM96zFrc05F39jw-1; Thu, 20 Jul 2023 09:39:03 -0400
X-MC-Unique: mLpWJkyfM96zFrc05F39jw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8129F88D552
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:39:03 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBB184CD0E3;
 Thu, 20 Jul 2023 13:39:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH for-8.1 2/6] x86: acpi: workaround Windows not handling name
 references in Package properly
Date: Thu, 20 Jul 2023 15:38:54 +0200
Message-Id: <20230720133858.1974024-3-imammedo@redhat.com>
In-Reply-To: <20230720133858.1974024-1-imammedo@redhat.com>
References: <20230720133858.1974024-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

it seems that Windows is unable to handle variable references
making it choke up when accessing ASUN during _DSM call
when device is hotplugged (it lists package elements as DataAlias
but despite that later on it misbehaves) with following error
shown up in AMLI debugger (WS2012r2):
    Store(ShiftLeft(One,Arg1="ASUN",) AMLI_ERROR(c0140008): Unexpected argument type
    ValidateArgTypes: expected Arg1 to be type Integer (Type=String)
Similar outcome with WS2022.

Issue is not fatal but as result acpi-index/"PCI Label ID" property
is either not shown in device details page or shows incorrect value.

Fix it by doing assignment of BSEL/ASUN values to package
elements manually after package declaration.

Fix was tested with: WS2012r2, WS2022, RHEL9

Fixes: 467d099a2985 (x86: acpi: _DSM: use Package to pass parameters)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c74fa17ad..19d268ff59 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -362,9 +362,13 @@ Aml *aml_pci_device_dsm(void)
     {
         Aml *params = aml_local(0);
         Aml *pkg = aml_package(2);
-        aml_append(pkg, aml_name("BSEL"));
-        aml_append(pkg, aml_name("ASUN"));
+        aml_append(pkg, aml_int(0));
+        aml_append(pkg, aml_int(0));
         aml_append(method, aml_store(pkg, params));
+        aml_append(method,
+            aml_store(aml_name("BSEL"), aml_index(params, aml_int(0))));
+        aml_append(method,
+            aml_store(aml_name("ASUN"), aml_index(params, aml_int(1))));
         aml_append(method,
             aml_return(aml_call5("PDSM", aml_arg(0), aml_arg(1),
                                  aml_arg(2), aml_arg(3), params))
-- 
2.39.3


