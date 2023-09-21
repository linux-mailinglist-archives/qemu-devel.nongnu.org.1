Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09DB7A95A8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 18:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjMDD-0004CI-Do; Thu, 21 Sep 2023 12:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qjMDB-0004Bv-2B; Thu, 21 Sep 2023 12:07:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qjMD8-0007Uh-PH; Thu, 21 Sep 2023 12:07:28 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38LFFTns012492; Thu, 21 Sep 2023 09:07:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=oy3NoGWNeXsHVciH9QBTbBaBCx/yKKEdERzpkVtWY
 Cg=; b=daDcdeEqU1wUv+rcwpEkE837PEDBDiAvdIc0a5d2nXqJXVfsiSbsWb/t4
 /DPckdgSJfrgrVSNJhW4Nz7f3NeuTCbL4XmrXHNne1SutUmLbPzUxrhuDzQMbb2Q
 A3pcq8DXdzAWK0zCdrh+RUfXVlr46QQNK4K6zz7IXVGuWXa+2vm0ewiv6Kq/MPYr
 r/shthqdUI4BagMHYB6aFOfcNB40700UN5/zKEnUJ2PNGtGxrJfowgw6ISCS3KTt
 J40fcUhhicgIKl3+1HzDyn7aB6lDW7PxqZ8W4CDhd/OYQnr1sxJ3HgUNWFFFcY0i
 GF2kSDAdnUIDcUrwySXNGwrXVRTgg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3t5bpc3qr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 09:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBZhH5AZBUaeE8GpYQytpKL7LyHbx5TOe4udoUfPbLI2hOjfB++Euy1/AUA41dDRlP1qFn8udgypACnJem6q+E6DiH9Nrwy0gYnBm3Tc1a0mECEidOPZL/fhq606OJEfigt7bcY4rjB05Y/jTXDUmkmZ/lCS8UG/E6Dr+sogXFLmXQYcSWbBpe8B0jEJ75ukjAaQCY8VCgGwgm1hcDc7pO1O17Ku2hsnixYXhVrSmv3oxU9jxedvarBgfmoMoPhVe8OUsG+U8MqchnpoMienDcU3YUiUHkgiPMtWsuTGQnAe9gJ/DnLSnm0X1V+O/hEpqgl7ZpzsHCbQtWxiwTHiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy3NoGWNeXsHVciH9QBTbBaBCx/yKKEdERzpkVtWYCg=;
 b=SOjy/CHUJrPSofVHZhGNYlCDNWEmsHz83MrukjiB4yvN3cGqKvyJbeOPY5U0OlAVqdrfzvOzmWGecdv9DrKVSiZIR7EQZromsBPu+0eb7l9Bzt5JynVTCRbPTrJC1LQD2XZqjJGqVawnlYt8Vp3xi0ywBCF1V+Sk5s3q8CGU244IVOVFPvBzbKhf+vjTWCLcdpP7lOAudRCsY+ItrA8PUg1LuIR5H7Z7+5enZbaUzx1kiw1/tsPP9qOmidKrZngLRu+k4coYxjSCDY9UNIA9P4iVi6/d/El0EWXXBMJJvfe61d2w5D4Cq1so43PyQrrzfmvJIZAz5I2cN+MwN8uBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy3NoGWNeXsHVciH9QBTbBaBCx/yKKEdERzpkVtWYCg=;
 b=d7Z87oIXV1OlT62+G8QINqLUGS7+YALaVlxmsDgRyoJlESTVcbAMWdzGUe6k65uUVRXzM+xvAGd1sxNmODSee4EMqH/XI2ADwgXKo+iQDSkDk3hvfW/37M9CKJ8rxeZ5aFkM3Q2YWuXueyGTV/j2DTgAlonTgiNmYS6sHEskNG7ShlaLFi17iO7bxS6tuZk5R4sQgMHUSpje3j0pixkPY514TFMrc//y8QCMebsmEj7Va4Hl4x5wZU4xJF2lrqC5uGJLjUIoxgKOIxW1CM2E7QoW+8DJ3zcaf2aBdNEh52EYlZVmaESWnr0VAnKYWhQfgLUfpbvTmyWxETm4ImvVXA==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 MN2PR02MB6878.namprd02.prod.outlook.com (2603:10b6:208:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 16:07:19 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 16:07:19 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, f.ebner@proxmox.com, 
 Simon Rowe <simon.rowe@nutanix.com>, Felipe Franciosi <felipe@nutanix.com>
Subject: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Date: Thu, 21 Sep 2023 16:07:12 +0000
Message-Id: <20230921160712.99521-2-simon.rowe@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230921160712.99521-1-simon.rowe@nutanix.com>
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To DM8PR02MB8121.namprd02.prod.outlook.com
 (2603:10b6:8:1a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR02MB8121:EE_|MN2PR02MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bda1d5-93f1-4f3d-b864-08dbbabcd50c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7UdmX04tS0sgQikV9YranEqktBlDXpSepI8QnummtmR4NeXFuwG2SOdV5gL4190Dc1S/qKPS00pg9M9Oe9tcc9wcIDMand0fODj7ufBfLCkQiXeuBYg7y0XCWWIvVsGtGbNxnt0MOYHcxRgjJaqDeZhA0y/g1pzaJMlgvS5IXM9nyLpZzM1do6gfRig66/3j4DWOWNE/NM2TfOXC3jCwrh7ngfn0Ta/C942DwRbhAi4kuK1lly2eefbFAFBKQLFinhnOB3KYpJ23WWMxAWdHZF5bOvG1KsUzE2QH0F2Rbzh31kSh9CZbRut+cD4RNogBLHi4fcVb0FTUs4dcWj71BDDhpJWP3eYusky7+kgFIxEjOtkmO6PANEZzYlQzjk2KoJEzyYhkzTXeVlZSir4rFo/yA7Ige5M2CBNdARspRthaIC0vHJbyZsdqrB6g8IhJTu8e/UkxPz0tUK0avtD0CGdYpPoC0K5wP8QFs8D4Xriesk7g6XiMA1BBxeSae5pDGG+oPySCn2zvo3wehoOKZN7klQ2stcPoqRfzkYpFHKqXJ+VIgiWJYD/nTFzlNQ9NGVqiM83tqWj0NJkyBn+exHsOImFbrGkSlBlx7HRErZyTtY8JeFakfHRhfPLyA6Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199024)(186009)(1800799009)(26005)(107886003)(1076003)(2616005)(2906002)(83380400001)(8936002)(66476007)(44832011)(5660300002)(8676002)(66556008)(4326008)(6916009)(41300700001)(66946007)(86362001)(38100700002)(478600001)(316002)(38350700002)(36756003)(54906003)(6506007)(6486002)(6666004)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ob6bhLB36Q5ZEgDGzOsXIA5YR/vcsHm3e13sEW1+zf87BwAJWd+dtYzG9OYk?=
 =?us-ascii?Q?akKKqxSRPbRQmWAdtmQ+dfPU3ziryZPxplPqoPq5sjhnv1k+YdD91qUbkjiU?=
 =?us-ascii?Q?CAapjt4yWEdemmGJxktxoupsOEPhieYYCp4gjsNqaBtT66BCgeYHiiiURT4m?=
 =?us-ascii?Q?BPeCBSuyXMgCTIglFGG+R1hoJL8XAR85VTyUUMquPNz93GChEzVs5VH8o4OU?=
 =?us-ascii?Q?MjiWUYawM70TwqQ7CBWuv7GQKRJiTay9ycjglR3OlF755n751IW8zmHbwqss?=
 =?us-ascii?Q?ougmf6oZxPd5wdAIguCTL/cIY2f86oFFKyXz38BvxB6+/ZDAHmf/BegI5GOx?=
 =?us-ascii?Q?b4gPTXIP635R3YIxCRkPWIgSfb5l8gCGk/aHPn4nFz8OKDIrtXawmBsnp/Ps?=
 =?us-ascii?Q?OKqfzMAEx9t2cAp9CnVkDHBZBuWnk4+5fF+sAhVfjx6LJRuZNixgjKl3nYIC?=
 =?us-ascii?Q?58yKSzHHnxQczBLa91S+BtRPDP7mL8Bxu0D/Rlx39Mun5EN4qqgcuCKfnBZH?=
 =?us-ascii?Q?Y6FgPmaGFfxPN87dhy9d6u7jvs7ECDWZMVgLSUSX1ozRRa47UI6aCKu6eWGb?=
 =?us-ascii?Q?btDXjKtF3zAjyYKVe+Z/QjAWV0WLqzbfuy6szuS9Fqz06c2phIoBbhbXRWqR?=
 =?us-ascii?Q?c/fxxfRgFh/muW6dary2DWowy/BX0Zamwe0UGXvt77wQYvJT18tghjBfh56D?=
 =?us-ascii?Q?NBWREGEhQlaAsuvAg9zvs4u8RcaS3JXXqgcRem34iZHYaLG5B3UCuXlZMh/5?=
 =?us-ascii?Q?k1bCrEt47QXM3bu97AAFkZYl8op0EPtVlaHK0cUzNeC/lDpEZv9sVEVIAMu7?=
 =?us-ascii?Q?fH8SHOs9BxhMrIL4LBoJ+f+LzkWAkgok8al1kF7bi6FamXqd4fdHwSVAT/zF?=
 =?us-ascii?Q?c/gw8GBdIBhqLIXBMqwfbejI9x6w409h2odppS1LHzh5zHZOFUaf7wVL/+kr?=
 =?us-ascii?Q?3HHR7RNcc6+pUnaS5W3u3EFgW81HQluqllKEd0o8qBvRtH+Qsyc9e6X4GBtJ?=
 =?us-ascii?Q?S4J5bHv0wfI5pwjqCmuqTj5UfHaJ+pzLM16MI4LM0UQkrZ+WbQ82W1fI1SJn?=
 =?us-ascii?Q?ill89nj+ni/b6BlAW7rE3UosLyOZGUmuN4bdln3hgxSHqZzilkZU/1jQRQii?=
 =?us-ascii?Q?tfWNvCf8LKvDDQ4t/4utzZnnsOUTV+w1pzVS1xyiWq9ylzCclQcrWFiLWdfi?=
 =?us-ascii?Q?aNd0egobWBOHpUcLRQt2pcmH1xjWBOBEZjtc1sJKCWRXljMFgiWIZ1a3AwTH?=
 =?us-ascii?Q?PivMKz4O6VLzx1Ec1LrQmzfwpn2f3f2GUokVwGIvwnT125BVjX77WO2x64kI?=
 =?us-ascii?Q?NTnI9l4RJ7iJS37PSJjuoaGo5OW/jwhZbHViRtGq8GSeE8ZpBiPhCd2zqkQk?=
 =?us-ascii?Q?WAhZCCgIrinttE+w10B7p7QniXgbuS6NstuLsyWhga+L4of0ikPDdaBWnXiR?=
 =?us-ascii?Q?/PXNGJd2HKVPOa7bZec3/p8bQwhkBFs+m7Gr5nisFZFJFto9bhD2f+YuR4V5?=
 =?us-ascii?Q?vAy1GmhxuZPyU1jDN/+oAzLPzSUnnzGVKXkHYNeQumK4L08EzC5YiBudGVw6?=
 =?us-ascii?Q?aXDH7GAHZ4qRovrIaKl0wi82WnWmcOd5JTJo6rRuGKGGixmgiK8wm14q59Nh?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bda1d5-93f1-4f3d-b864-08dbbabcd50c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 16:07:19.6250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCzXXnhI4KLhXtLBuRsJK6GDOfi1nXhWil+Fc277i75tISU0wKQb84MQj0/y9SaSkSW5AXgsiHzwcWCRMTh1Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6878
X-Proofpoint-ORIG-GUID: S0DTXmZCuZRrTx_DErTgx9j9TzCYhZJT
X-Proofpoint-GUID: S0DTXmZCuZRrTx_DErTgx9j9TzCYhZJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=simon.rowe@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When an IDE controller is reset, its internal state is being cleared
before any outstanding I/O is cancelled. If a response to DMA is
received in this window, the aio callback will incorrectly continue
with the next part of the transfer (now using sector 0 from
the cleared controller state).

For a write operation, this results in user data being written to the
MBR, replacing the first stage bootloader and/or partition table. A
malicious user could exploit this bug to first read the MBR and then
rewrite it with user-controller bootloader code.

This addresses the bug by checking if DRQ_STAT is still set in the DMA
callback (as it is otherwise cleared at the start of the bus
reset). If it is not, treat the transfer as ended.

This only appears to affect SATA controllers, plain IDE does not use
aio.

Fixes: CVE-2023-5088
Signed-off-by: Simon Rowe <simon.rowe@nutanix.com>
Cc: Felipe Franciosi <felipe@nutanix.com>
---
 hw/ide/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index b5e0dcd29b..826b7eaeeb 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -906,8 +906,12 @@ static void ide_dma_cb(void *opaque, int ret)
         s->nsector -= n;
     }
 
-    /* end of transfer ? */
-    if (s->nsector == 0) {
+    /*
+     * End of transfer ?
+     * If a bus reset occurs immediately before the callback is invoked the
+     * bus state will have been cleared. Terminate the transfer.
+     */
+    if (s->nsector == 0 || !(s->status & DRQ_STAT)) {
         s->status = READY_STAT | SEEK_STAT;
         ide_bus_set_irq(s->bus);
         goto eot;
-- 
2.22.3


