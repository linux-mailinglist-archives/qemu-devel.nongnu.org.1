Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A62804361
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:27:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJHS-00089S-VT; Mon, 04 Dec 2023 19:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJHS-00089I-1m
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:27:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJHQ-0000sf-IN
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:27:17 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B4NwpNj026929; Tue, 5 Dec 2023 00:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=8DQYeLE9GTop3qEXcvfJJI8/PQfWomnhWt5rRThfLDw=;
 b=G5BhGePVLRLjY8ul2/dIDeLnxWtgfZMXhTAUfbRifHnqWRBifQ3ocpNunPd1Zx89P/Jv
 Y9KCtO4FjQlYqHPbo/0I/NOY8DSo4BnvVNjJRLWZeAXPsWx6OLJdAc5+wsabvZDUYNOT
 uNt3Pom8Ix1Kh9+/7K4D8/W7BFHJ8zzjh9pye1YBKLAkK+6JQ7O//L/62xVuVwiJzhMn
 NbIghVLwywBC4+VhpD/ff6TW1tO/tbH9DH8GiYu01SfktiCcRmmBH6PWqIQGgDfzHKQG
 4LtmQN15+JlXQmGIYJBxHifmqy8VY2Gw3LR0lCnCqTYMTtmmkna7XoHrvedB9UquxgU2 SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usrkrg2cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:27:14 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIYvE004983; Tue, 5 Dec 2023 00:27:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16dd1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:27:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50RDGn015366;
 Tue, 5 Dec 2023 00:27:13 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16dd07-1; Tue, 05 Dec 2023 00:27:12 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 04/11] acpi: Support Control Method sleep button for x86
Date: Tue,  5 Dec 2023 00:27:07 +0000
Message-Id: <20231205002707.217-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.30.1.windows.1
In-Reply-To: <20231205002143.562-1-annie.li@oracle.com>
References: <20231205002143.562-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_23,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050002
X-Proofpoint-GUID: DQm6Kn40_n-YrGv-ql8OCrEp7ExnqSBy
X-Proofpoint-ORIG-GUID: DQm6Kn40_n-YrGv-ql8OCrEp7ExnqSBy
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add Control Method Sleep button and its GPE event handler for
x86.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/acpi-build.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 80db183b78..75985e1423 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -40,6 +40,7 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/input/i8042.h"
 #include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/control_method_device.h"
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
@@ -1537,6 +1538,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
     aml_append(dsdt, scope);
 
+    sb_scope = aml_scope("_SB");
+    acpi_dsdt_add_sleep_button(sb_scope);
+    aml_append(dsdt, sb_scope);
+
+    scope =  aml_scope("\\_GPE");
+    acpi_dsdt_add_sleep_gpe_event_handler(scope);
+    aml_append(dsdt, scope);
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
-- 
2.34.3


