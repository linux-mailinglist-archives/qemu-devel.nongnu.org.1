Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB582B536
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:30:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0jv-0008Ey-HK; Thu, 11 Jan 2024 14:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1rO0jq-0008Db-5N
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:29:14 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1rO0jm-0005ov-Ne
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:29:13 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40B8jp1f003854; Thu, 11 Jan 2024 11:28:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=E2I4rJbY2zO
 wxSx1nQpMAtgZ0GxdRxPQegu6D+24q8U=; b=WQzBdViYTZivJXG3ziNZi2Z3+lb
 YnBVpiLec1gvVoXe0I1CU0BCXEMqbPcmqxkCkpbwAT2whw6R+CZHe4xhDDd4/eUt
 d5Bv8crjVZaY9WxUhXdoACWvdfBmru78vf0TyTwF02B3opQHg+hhkeyPGltV5w+l
 BdrurhpLzPPv6JsHmfY5RsvePZ1+h4TqNi+qEz/kTEKs9oJFmui/JV/66dAVlOFw
 MG/Sb37yV8/SWgROK7q8oTTlrxqQeZqqibraXne1A3IcdlvxGoS3uiN+po1Ltcb6
 i/0xvzHMdtTIoQ0AkV5xi5PpB/fabxATVamGBMI4Bh5vNv2S5DnflvtqEvA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3vf42vjxat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 11:28:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO5Wm0Zaa0N+0AHufjQQTtkCb8JsahhupOiYXzRWP1YrJzYX1+1C1KvqfIlpCDu0jkgsBLMPyFQkXrlMP+cO9pMihRuxr2Ne2fAW8wGdQjV4Z1C0IaHRX3smBpMX5CIVw+lreg2ApYihnhGvrwCQzGzlVCeAwl8MVQL5fII/pYIsTrI4EjCozneBNROrJ/EYLkZ6WLvKKo4ZxcV71sLPZQEpWh0JGpZ8SKwn+Z5h3OfuV39Xjnoodwp0XvcgZVlslsz/4nNq3M+azFccJy5Sfvr1OR9XpY8T6VfZKATh841X00arvKa9nHNOTWC0/7OINAYzzXdwySf0KiJMiZusug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2I4rJbY2zOwxSx1nQpMAtgZ0GxdRxPQegu6D+24q8U=;
 b=ULFDLeIZkwMhsoJ6oxxHaJ/jeVnl7/9G2IR+5qjcHYRkwnMiSr22m4xul3jJO3bkVM8185rw2FJ7AZMgcVeBE++UUmwzmqwFw20QanROwayjhXuAzNoSO9Ur6BMyEjFC+8EnnVSmKEMJnkt4KCeR3DoyGcwqmg7iJFRWwxmjhzUk08O6WSrOFwazmOKj+kVVancMG9AMopF6V95nz9r7SeCZqvj37fQ8+CxcnZRhp1SV4xwRw4g1WqHvsSOE7BWIeYR9266yFt3gUHXRSO1cSo93+Sg5y9eg+V6I9kzhZjryGd0rf51Nn4kHLaBZIMfl9Zw1hpkyNGMaJ7kpqXSnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2I4rJbY2zOwxSx1nQpMAtgZ0GxdRxPQegu6D+24q8U=;
 b=bxK0UDtjRVO6ohBH0mydt+IbQQONeZaRxvucBz7U2Argb4Qz9GquYxm/6bzfDEF/x9ZQSdA1p+4wXv1bIpFIGV2FooA3NNgSVIwIkQlSvJutamF5V12gydoo/ww3IHY3OZAQ4h88yf1peRuOHk+EJpbrkZlrYKkNNeAXqMUcL9S5Kde6ja6HEriqLf6b/Fi96cQAsGfFV+YsAUwFc/H0Q30+EIGs5dKXBDG+xy/ErFsKaIy6MW9ZWQAKkyAPMNylrEECxO288inRLCFlOrhYEvWqVobm9c7CNJXFV10RJ1kx/43DMAoxOGiUKltWUXwqyAuYHRISpsnjLChOo4wXdA==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by DS0PR02MB10222.namprd02.prod.outlook.com (2603:10b6:8:1a8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 19:28:53 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::904c:75c4:cf57:bb95]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::904c:75c4:cf57:bb95%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 19:28:53 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: raphael.s.norwitz@gmail.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH] MAINTAINERS: Update Raphael Norwitz email
Date: Thu, 11 Jan 2024 19:28:46 +0000
Message-ID: <20240111192846.111699-1-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To BL3PR02MB7938.namprd02.prod.outlook.com
 (2603:10b6:208:355::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB7938:EE_|DS0PR02MB10222:EE_
X-MS-Office365-Filtering-Correlation-Id: 62931e6e-ede6-4c31-7682-08dc12db8bef
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEic9TxLNhh6balF8jrP890BO5mq83ob/lW1sNrmJJ+ukL7nCJyN6bvCVHFRQfwM/lE/s3XcZWVgUDHr0X0uJT1vEhKpqCcL/vGcDLxp3bnqiRNXaTTFx+BO0eWvl8VSmjkn9/ISuNdIfJ5dA24HKciHawgRw/VDYPULBTXnU77gfGwhmyCBr8mt3kcARbxchWOrL+a1Bp06OfDWMB0uCc8epZOvaESjQ64BWoPMJKkQr4Z6J9c4/J2W1W5BgQVRGL5uxluI1Wxwcg4kCtqgcwYIQKMCGjenpeMZRthXNXDjWMPsoWzm8E7rgJOvSK5OXCFGd0W7Jbim1wBNesQKLKLZX8uyzKm9zVwU5FtMalkOGywTbaKM0pEgcg9r5L6MjKuaX1Ffu6gntML6CCqosnxP+1oFBSPnLCNW14D5FizdOBmG+QLdCRSaKEvyVjnnAEqo8aX0Hp5YVJVuw25VEi5FvujlrvZlEqW68Q22ct43cbAa6TX0/EFtEmKuwLjylMMJ0PnsgJY8t+omTVlF+AeYHYQ+AbZe9Q3NEVdQnyIcJYcYoVCVANXNubUGI+hPLLGxaQwc8pLsDS4qWcFS3prZY+LIuef8d48uTGUSpnKLes2uh8JpKwW6mTiiu/WH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(36756003)(86362001)(66946007)(38350700005)(38100700002)(107886003)(2616005)(316002)(1076003)(6512007)(26005)(52116002)(66556008)(478600001)(4326008)(6486002)(6666004)(6506007)(2906002)(66476007)(8676002)(4744005)(44832011)(8936002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDB4FO9fnE+vDBvLON9uDiI+5n0IfdqmkW8DkuwwGcvJqTR4gcbfl+91SZbM?=
 =?us-ascii?Q?ILKrD7rSQG43lNOy8VTSGNBzXol9kY88FOLy/VNE4M0OVGOQiFAYF3JfYCDs?=
 =?us-ascii?Q?UXl5Ia9fHsrurXpO3vTWqYMd1mjWBqad7ItmmDmI/BnnoZ2q1o53H8VXWi8H?=
 =?us-ascii?Q?H21GLUlhN+dEPddXkMy4b4IA5KFjbwrW8Q/76r6ucnjv1H1pEiNAWydynNXw?=
 =?us-ascii?Q?7YlLFdFgLS6VJO+l+K/Bh8s42UBBQv9sLL4dY5x+wv5yCbZaJw4PygVPCFhi?=
 =?us-ascii?Q?VXpJkRaH1uPgeMFtMnyF6kfBjEh4k/XeptSCjYTVdyS7VwbSze6T7WnnVDI4?=
 =?us-ascii?Q?PD6rzyyc7sZl+XuAtxj+CHKWRSzI5hk1WnKXw5fU3Y0+yVQetISiFF31F+tF?=
 =?us-ascii?Q?AnGgtbahwYTr23TUO4IZJmknUCTwoZXEc0Bzx9fqDswQoaI1XkMNTY7tMXgl?=
 =?us-ascii?Q?RD6z1/DnX2oWpZfrBVd4L55mMMrlYFFTrnStdUdkAw7JOG+uTatwCGV4KwXg?=
 =?us-ascii?Q?yAuGjbZSXI8+id7x2uFLts+jSNIyXL5NWgcj4W3tJS/wQbo9G0OGFYIjGHQP?=
 =?us-ascii?Q?nCLdwy0U02Oufgg8Kxqdo9duRXmEZK9HwKQ8urwlt+or83h+Kao6sLZA/46L?=
 =?us-ascii?Q?ojyFgd8TilXqe5xUFvbkX8XsGSPjy/JPzBTGK+Q0wEboW8EgxhkI6puZG7Ie?=
 =?us-ascii?Q?PpQRKzdl/5qIlrdQiiqjQ/J7Ssjph/sJ//CAI3gE6Kakf6h35TEsV4FfUXjR?=
 =?us-ascii?Q?cS8LSIHlaWgXLkyu26GGVxMclym/lSg+per6oMPDWFova/p5Q2P4r0nf1nkN?=
 =?us-ascii?Q?mhClz0gCtXJHe/shtokUr0cJOe7x3C7KJGtHnjuCHk61ALc2Fy0Tscws5W+E?=
 =?us-ascii?Q?heDWmIEn7XQP2cfA5NbhTTlu7O+FKxjA71aoovZwIM+dsyiYhZsCRGh1eLou?=
 =?us-ascii?Q?bk0fyOvdIRXAGJnnQ27ZHGXGGMA25pnukDvNb/46ZYB1UG9VGxqVcBS/D6UE?=
 =?us-ascii?Q?/9Szmw0vPSsYktLN3pjPncSFe1WlP2FGVCZqV6DVzCDap4IxUEotuBWIzL7/?=
 =?us-ascii?Q?E4QQY8c/NIQW7V9uGAFBsHse5KWWjwdNjE8cd04tKn+gzfose4vBqTiT4lsn?=
 =?us-ascii?Q?cBeGuliclndN5Yl8mcxafczYvt+N/qyLRTSOZmjHIp+zert6aQfLaZ+TZmen?=
 =?us-ascii?Q?U775DguDKwlNap/oeZwYnx4KEfO0EDC1AQSRfEMk6xB22UHpdefjViBHlcba?=
 =?us-ascii?Q?iz0tqUKaTJzRDpN1+FF40t9QgvCavIqgr43d3rcAPA/l+dzaL59OrO4mUTr5?=
 =?us-ascii?Q?BIFUwPcupEZY1IEzdzuNmvD39kwwW/bcZ2jWBCtIztRMHB0cwEXjXibjIEyu?=
 =?us-ascii?Q?SNhhNkbG3ul+CRPjnCEhGBw5yxK4NHLiScstCA9XC5f/6F1dXKJSygLEzuD9?=
 =?us-ascii?Q?mXeCGLIfpw2b+EJIJjPhx4S0WTcREwjkyXLRhJDRgQnuFjpjwmqB8Cdlm2em?=
 =?us-ascii?Q?BJkNjMpyto9norK1fYWb6Y2R2TETy3u9DMibaEbxRzoyqQ6TX9E3obEySgGb?=
 =?us-ascii?Q?KSi4b4ZfbnHkdScLpkUACzvcZZsmDVqGEQoKAJJ/ps0eY5hhOJiB7+n7YY6L?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62931e6e-ede6-4c31-7682-08dc12db8bef
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 19:28:53.6953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCNDY8ebltbuviZNhfNcCdsWbw6zfhzRlRPqBzrj04alSOS8YxU3Gn17O/vqo11Xz5VCtkoYodYMzgXv6REaeEfFM84CXITSzhLuMOCMRLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10222
X-Proofpoint-GUID: 9m3tYwVHBaWB3WVX7KwwNScPjovpqfxb
X-Proofpoint-ORIG-GUID: 9m3tYwVHBaWB3WVX7KwwNScPjovpqfxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I will be leaving Nutanix so updating my email in MAINTAINERS to my
personal email for now.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00ec1f7eca..d7bb52bfd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2540,7 +2540,7 @@ F: include/hw/virtio/virtio-gpu.h
 F: docs/system/devices/virtio-gpu.rst
 
 vhost-user-blk
-M: Raphael Norwitz <raphael.norwitz@nutanix.com>
+M: Raphael Norwitz <raphael.s.norwitz@gmail.com>
 S: Maintained
 F: contrib/vhost-user-blk/
 F: contrib/vhost-user-scsi/
-- 
2.41.0


