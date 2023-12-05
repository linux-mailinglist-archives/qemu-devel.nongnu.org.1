Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81680436F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:31:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJLJ-00034R-NZ; Mon, 04 Dec 2023 19:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJLH-00034B-Tw
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:31:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJLG-0001cS-9v
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:31:15 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B508ZbL027538; Tue, 5 Dec 2023 00:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=yMwjAub9+1KHYiieejFgLR3tmFcx5/8qKqcboFkhuks=;
 b=lYXGoOT5M6qHlYmNpBUgmytBwxRSCGhr6AZ1LPL3Mbz95cqcXw8K5EZZ4i+gUQHc7N82
 iriZF/lpJVpxd6dYPgDuexb1xVgmQfc+ZlCAP//Tl8o/RjTFEo5ovjTt49XcR0gt3Lav
 HZJgx/JTwCWdYxeZahQgYshU6h9iCA/4fYc/ID3Xe1YlAkm8JWJXf9K/yKQPESu2bzlk
 RMbXpwjnPeeLUmFoBBkhhR8Wap0wdtgUr+5ELn1YFyUEQAGEUuVD1Ujt661flsQx/sMk
 keqpo45iG5o+OcT/ZIa+3vuaYV3WFPijJSaj+ZqhYKPAyVj6YtNXiDi2anN8XTmcTo7z SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uss28r1g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:31:12 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIXgZ004891; Tue, 5 Dec 2023 00:31:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16dheu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:31:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50Rjkd016626;
 Tue, 5 Dec 2023 00:31:11 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16dhc0-1; Tue, 05 Dec 2023 00:31:11 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 11/11] arm/virt: enable sleep support
Date: Tue,  5 Dec 2023 00:31:06 +0000
Message-Id: <20231205003106.1297-1-annie.li@oracle.com>
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
 engine=8.12.0-2311060000 definitions=main-2312050003
X-Proofpoint-ORIG-GUID: BIvWiSmTp9OTJPAjEEKRM47fCitC9MvF
X-Proofpoint-GUID: BIvWiSmTp9OTJPAjEEKRM47fCitC9MvF
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

From: Miguel Luis <miguel.luis@oracle.com>

This is for reference that qmp_system_sleep relies on wakeup support delegated
by qemu_wakeup_suspend_enabled() hence the need for calling
qemu_register_wakeup_support().

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8b9a328360..6407734105 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2309,6 +2309,7 @@ static void machvirt_init(MachineState *machine)
 
      /* connect sleep request */
      vms->sleep_notifier.notify = virt_sleep_req;
+     qemu_register_wakeup_support();
 
      /* connect powerdown request */
      vms->powerdown_notifier.notify = virt_powerdown_req;
-- 
2.34.3


