Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8CE7A95A7
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 18:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjMDQ-0004EP-4m; Thu, 21 Sep 2023 12:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qjMDM-0004Dn-QK; Thu, 21 Sep 2023 12:07:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qjMDL-0007W1-5O; Thu, 21 Sep 2023 12:07:40 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38L6QTdV008538; Thu, 21 Sep 2023 09:07:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=mOQNiuE/xYM
 aP7ncEORxSFicyZRE6+kOo/jkma2fLQw=; b=pxJxjZtbw2kV14t5EsmFd4lgl7c
 xKsjJjmurIz7QHUYXyuVpHyA3ljmAXHlfxEzeSYkXkUy1WBlHGBbt/O2eLFCGzEU
 lLmAV7OaoVXcdQLa95e2DXuIfVTKwFMiDA++dkifnsRIjQNpij7dNuh0jcVIUEdu
 6Kt4QXPomwk7sDwJOozDyYLPM47O2Dr6ZboETYDPvizJkD17HIDswv5L/OGXuX2Z
 +xfXELkxIZpAY9WE3A5u8voqtUqo1uL0soKwGoMhZn15evw0eCegTk8UFwjvPCDh
 RF8VuGXiqXCqpcurrrwi4shh1vIzrIXrOP05odPF4/61CbvwzcN99VSxsRA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3t59w6kqjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 09:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA/PfkvuBhOpDGo9vg78qBLndq8op2tYf+011jupTky2iPvsBwrshjIQ+ICL9udnW6PzO5pv0uoQm26To3FAls31SjSt92MDg7gz4FAcIqxGXO2id1/iwgTDU6/jhZ8EP+Bu5g7j2xtsoThLxra0pJsfU5CSUerFcwkeHSEYdalsas6xdfsmzqV3lLie5O/pY8XQ14j9RBuyfV+kz6eK/vZr2peNMuRluM22zh+gxuTMVuDPd9XMsbGWIeiQD3DGAcmaz0DxPSvv9MvsNXcnpxv1RBoFvlFgkYjtFbMEHxDZ15RETrwRtoZW1wsdZXcC6TYS4MnllJwINEmvymvqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOQNiuE/xYMaP7ncEORxSFicyZRE6+kOo/jkma2fLQw=;
 b=F75e6F7s4dZs1yOi4vp6refAEVANnPGgdhVvgj9NuuTJKzjsXURYjlwYMEdT1B0GogXVTsx4w8uV1mVV8A9xGoS6DsJHUpRb23M79smrb67MWfB5xhyyFoFcQbaNAI/k0/ClDH4csKH9kmm7jEStTJ8A+vWOh61AiDRYezPvqdXIlIGNWh8F2jPDlAiUA6jgDOybrshktm0IqryKP0Zyehrg87Vp6cL0hFISwAeAMwq0lQdt/TNPzeSAUUmOf//h+QkZFXstJ+9sDpUGpGfAkEQxDpH6fy6QljKAofoV7sef4WPzGziSJ0q5wEZ+U32JFFW0pP4l5JNuPQAz4T+Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOQNiuE/xYMaP7ncEORxSFicyZRE6+kOo/jkma2fLQw=;
 b=q8lWWBdXj0rTAFCn9ONKBU0/ax23dKSkRPo48Y2aOfAYoNBivJ50xYwkG+MWfxL0YFJsHsPHCaSZtPlPwtC2cj7xElzV2DCMEUY1+xNzWsalPwVWYdJHudZX5kW7UbkDYLBtwJWzXx1MkkA2zmAiSnjqPNEjUzYsof3ZyM3GboNVnc95BlGPqaB75vl442wP4pUNNUwjJL9txjvt6R3TWTQqti2+sBgBFGNYAiQYPzGOI8b3ZVZX266MNrR6qCAtW+i3yrC1VAeaS2Z/YECkDu3hGL2SrgJQjwGYu6QCM4KOaAazpcrDxUbrtOsgIPb4+z4rTUnRTtz/SrOeYFy28w==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 PH0PR02MB8663.namprd02.prod.outlook.com (2603:10b6:510:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 16:07:17 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 16:07:16 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, f.ebner@proxmox.com, 
 Simon Rowe <simon.rowe@nutanix.com>
Subject: [PATCH 0/1] CVE-2023-5088
Date: Thu, 21 Sep 2023 16:07:11 +0000
Message-Id: <20230921160712.99521-1-simon.rowe@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To DM8PR02MB8121.namprd02.prod.outlook.com
 (2603:10b6:8:1a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR02MB8121:EE_|PH0PR02MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1690fb-74e4-4f76-6a73-08dbbabcd364
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+i2ud2Jun6wCOQMGcevTizZitLg5Gh9uG1RpYmHVsGAgrzJDIWIDu/J+YFmKNXdy1LSq1zWbqaN8OVPGwWNQ2kgiYKWJJm9Gaa4y6qLw9Qd/skU7JTL4d7jmC31O8q+IuPZT0kv10KLd0LhpimR8iGPCzzuzSDqmaGoqcrmNEJuyTa2tbLc3sgcpboBk/sv47jzNg39mxpT+CTrsIhwIUgUz3oYZLECO7QmGHqLFqgbl/v+CGCCE1PgF2wkQoRoXeBn0o51Y28kKJl+TWcr3Oi4HpTyPv9oqo75ACbk+cNROroxWG6h5j5GZXJUw0+Qn7mM35tW4gap2ln9q3YIWHcgd7lA9ti5LomRq6cOw1VD0mWAqhJljA95EvQwHsvSlFXq3OG4DQ6V/VeHHusvt5g/uf11Jr21Zuf/lKT6NsZOvhaW99sVPGJqi8cTvNn4m6N39d6sfqo5UJWSVg8i2afL/4CWanswxYxZsaJ04pTyWa23d7APiR6hylYUlfHzLXjw3tUtyslChyeUx00TggxnHWeu/SIBpyTbL5XMexAczP6Ep2yvGEkMYD2GyE0Nwx3+pKbA5jHmDiFKpAeQEj4Jd6cGHwNsashhw5TcSv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(186009)(451199024)(478600001)(6506007)(6486002)(52116002)(6512007)(6666004)(8936002)(44832011)(8676002)(83380400001)(66946007)(66556008)(66476007)(54906003)(966005)(316002)(6916009)(5660300002)(107886003)(2616005)(1076003)(41300700001)(36756003)(86362001)(38350700002)(4326008)(38100700002)(4744005)(26005)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8oT2QTBSnwhK3i6InIWdeAW3NFEIo/WsDikOnmgOE8HfwkxnmTZaA1C1rL/X?=
 =?us-ascii?Q?iYLePZtBySmQtI7A4WYt4SdiBm4n9g1fIS5531s30+tDwKcVRZfcugRzPaCO?=
 =?us-ascii?Q?MisNIPUBDq4Zt7ggaYPOhtYP/FpIexasXJW1VWk5jhPsWhPeyBj/FxlkCo6J?=
 =?us-ascii?Q?ruF1jYE8DaxQ9i7HpPP0zw+evk6y5lUAn2UAXLfefCtO6PA5Tx0jU9q466PF?=
 =?us-ascii?Q?PwovHq1lfwzEbPO+FgRidKej2klpZN2XzrLCxEsJ2MFNedyyK2K3gLwXkpYp?=
 =?us-ascii?Q?naCKv7zu1Xq38X0yOTYMd5XpvwsVIw5NlodeB1mWyqQDDFWT5Ct6Vz5lbP7Q?=
 =?us-ascii?Q?dCY1PtHoFFHODc4yEJEvJ11V7n7wlr/RdJuVWLZ2ScNlFa+tah8ZMcchAEDU?=
 =?us-ascii?Q?Ahjuavezmz8yqo1hZxs3aNNkfOmsQW9SrqHo0lscom94twUvglUWRsyjAmoj?=
 =?us-ascii?Q?Y0ouh7rXkHDF14lcc3B7I4UyS/4moNnNZCqgZIjkC10UG4t0H9D7ImyPXO0/?=
 =?us-ascii?Q?l9bcIzcyfnhpx1GZUbF32uA0+hsJcz/3yz+kLFhazAtne28xxn2gQNR10rXp?=
 =?us-ascii?Q?dZNZaGfM+VmBIwmEeLiAmnu5tBufHqIsha52Rky6W+CzOls0S4Xwxz3tE8TH?=
 =?us-ascii?Q?gz31zZz4jR6NJfe4Xsi30C2qs66pzeZExIA2CMLIr+fDkHpe8s+f3BhI+2A+?=
 =?us-ascii?Q?CSa6qCHHaGcK7cYtHYsr2p2a61g7gkHup/olAINkWWN0Y4Er45CMLOu/f+Ha?=
 =?us-ascii?Q?dFB/E1QnyFB7Nb5HIPa0B2FfX8HUGZrlA06JV2KXeN01C89GAjhpIk/Ap/l8?=
 =?us-ascii?Q?2btivNe3QXOplhlNZObxx9fru3nmWngL8IBr8P0Om5Vnm78XdJArnM50nr0M?=
 =?us-ascii?Q?axW5L8BrWHwTIUOhM8Oyw4U4OAFm0VMtQazZxXBRlHZvC5uajOHK956WHna5?=
 =?us-ascii?Q?oVJWPQf28ISWX9Ml2gqDTZX77KVGskxmku765eCoM/B3FjrGfmcZ8/ppLSS9?=
 =?us-ascii?Q?2b8pKQPy2kD4qbt/NrlXA1IWbCYT3go25SYxTPDUKq9FGjmHfl0twjN06A+v?=
 =?us-ascii?Q?z7UmsAqqQuP4AD+3X6UvfvOilqJVAyH7bXdPfPbqaN0fwroVv9KHvk1bIY3d?=
 =?us-ascii?Q?XfRI4DjnL0NDm5yXg6viHNrMEvkUEz0kYrDoMguCikwLrP8+KAfdV8NREnzN?=
 =?us-ascii?Q?GCzZlC5yeZbJF+cv78bfDfGBm9vB4vYabIifDlYtvp2DeCI4+vYt1eLBUJdA?=
 =?us-ascii?Q?YooWSGqVfugUamQLGntdqPxQGrpa39OwHp5lvEVS0uh9dWewDXnkEPr1VEvb?=
 =?us-ascii?Q?o7Nhd0wFvpuF6l2u8gJlE891VnwQx116ZZ5NfGqQ+ZYKLzU4O9JaaRs9EMbj?=
 =?us-ascii?Q?dQkoHPrRzWKrEz8opr5vpiPf0xYdqLHGE22C+uFGj0eURo+CwBv9Pnhd9cat?=
 =?us-ascii?Q?VmkoBa3PNVG5QXwOXp7pHW6tKW/sSU2zR7LBzS6fOpoWUDdcWrSCKelVePTh?=
 =?us-ascii?Q?DaznEwW3CmsUDbpV5d5Sm2BE4QFvZPUnHTl6vW88SnenG/MmRX4Ke5uwkUYt?=
 =?us-ascii?Q?uWHfn4xnJQHxoG7n9nzT0SqUyInaWos1wyIFOx+ZMy2VemAcTewqmYAiex8E?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1690fb-74e4-4f76-6a73-08dbbabcd364
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 16:07:16.8051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXYHNkGRvJruNJffm0OyLBAyuMb+pXzLpenhwfu5WQqBLoM1Ygjt0dLM8vnyLCuoI+1Dza2IQmKvOnVsLHwO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8663
X-Proofpoint-ORIG-GUID: PmPKiq4Jgrp48WnDaRNnNqN57yuyit3m
X-Proofpoint-GUID: PmPKiq4Jgrp48WnDaRNnNqN57yuyit3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=simon.rowe@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5 autolearn=no autolearn_force=no
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

The attached patch fixes CVE-2023-5088 in which a bug in QEMU could
cause a guest I/O operation otherwise addressed to an arbitrary disk
offset to be targeted to offset 0 instead (potentially overwriting the
VM's boot code). This could be used, for example, by L2 guests with a
virtual disk (vdiskL2) stored on a virtual disk of an L1 (vdiskL1)
hypervisor to read and/or write data to LBA 0 of vdiskL1, potentially
gaining control of L1 at its next reboot.

The symptoms behind this bug have been previously reported as MBR
corruptions and an independent fix has been posted by Fiona Ebner in:

https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg03883.html

Simon Rowe (1):
  hw/ide/core: terminate in-flight DMA on IDE bus reset

 hw/ide/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.22.3


