Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE377854D5
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 12:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkj6-0000ix-Et; Wed, 23 Aug 2023 06:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.henderson@nutanix.com>)
 id 1qYkj4-0000eS-GO
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:04:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.henderson@nutanix.com>)
 id 1qYkj2-0005uK-Md
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:04:34 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37N5SZQD027819; Wed, 23 Aug 2023 03:04:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=pTxqqBfkh9v
 iluVFSPw6c6KEamrmL+SlLu0mawruBSU=; b=JapYE4KBqquu1g3LiB8D5xVCUxj
 X8/n9il4jjOqpIrbnuzdntufPkNP2DbOyw+27OueCjqQwOxJacn7iFGuWtE/8w0G
 hQC8HcUi0kiAfYcFjs/9XQ/4cFnY0L5qGFDNFpQGDToJVX373cRf6SGNWCciJcTA
 G13cGOaBl4gA379voAPVhLlK6eiqmrRq7I6lihHdoSCXEuuU8/LWUZuM8MgfPf1/
 JN0ixaUS2phGSFYfhWJ6nzRwWhWk5tbh1IaFY+pXrWhC9wpE+ElLyHhFWhzSRab4
 oAqnoIaPgfPrnUF82DLSGr9Wu3uRn0ucoW7XZkO3cc0fnzB05ePw4G9yEHg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3sn213sexx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 03:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiRDP7PHrnSSwfyz4ne0BI4LK8uoAoZZKiR6KIxtprPaXQjMvIEOW097hTQJZFLOIi5cY905+HkoCTfnAac4/l+qW5h4ij3fEz4pCOWs9NhYNN+3ssO7xUYaXGj5suJoVyc+WNMU5RxNw5OVLipHXzK5wyhUslQDN5V8iP0qpJDdUWqm7rk+Po1F5vkDsicjxXAYn6WjI/kKpe7id6jzKrDZlbFMAA/QluW6TYnbp1ZymY4ShCVcb4ZcHEu4ZUi+LQRXWbmW70mqSvWSiSJFKilGhAetf+6cwNBcNakeYTHhgKp10JUhJfgFrIsBqNdLwmjfZww4w3neGiR5Jsqiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTxqqBfkh9viluVFSPw6c6KEamrmL+SlLu0mawruBSU=;
 b=dM57h/XLpLUiAYP8oPwPdsPhhWaLbq+A2tRHqB7AkhyuQK/z4SKsWDb7WFhh2x/KBIC4be1p091v5HrDO8jrgSRMGt0wo5q4e2owBg5rg1UGgWhMGBIFQBjwBxa0lxTNe/X7v8QMV0m98ftCqXLxBgcgk5+egNo152Kmti4M8TfO7nFsS/fVkifC3e9aKkQxea3J/HBjUjqXL4FIOTOcNT8nfOM7Net1Z9/08sbg/+T1MZbzWevIgPUUYzzInNhtH79Ahr+nATGttmMWe8fWfAgzxgDXVbSauEe+TlDwzyWN2V5PcSledYx3WUlS4jiz8M2VgNSskbH0CyXY51VrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTxqqBfkh9viluVFSPw6c6KEamrmL+SlLu0mawruBSU=;
 b=AlN9k/1ocDXK0F99ndq+3DJybC9TcMV7OTgVJlWb9AaXDrsPXIC5RY3UQNyXelhYvUUdZ3BOYo6GUtMtFX7GhAjVDwjE2xKj74jrCU7kuhajVipyicRaMxvAxMzqlP/VyVfh2MErUnQGvfWwyx9BRnV1CNsnzqjTrKmNoDwHXEXkSP9BzhrOmC8Ur70VNjn44VDINWHGBoGO5+5lpMvlFmPXtRL2IC6KwIDSlp9cBXKk+AZFAOuYWZLSanVy+FSmCTjVBihH1vahRZDO3DsbQ16T046VuxWnAxzwMOo+KU3QB2yl+dcbhvwN+fcGBr5bVfyMd5XRHWZ4QGVt7VGTTg==
Received: from MN2PR02MB6880.namprd02.prod.outlook.com (2603:10b6:208:1f7::12)
 by BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 10:04:20 +0000
Received: from MN2PR02MB6880.namprd02.prod.outlook.com
 ([fe80::20aa:33ec:7f5e:936a]) by MN2PR02MB6880.namprd02.prod.outlook.com
 ([fe80::20aa:33ec:7f5e:936a%7]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 10:04:20 +0000
From: William Henderson <william.henderson@nutanix.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 john.levon@nutanix.com, philmd@linaro.org, stefanha@gmail.com,
 thanos.makatos@nutanix.com,
 William Henderson <william.henderson@nutanix.com>
Subject: [RFC PATCH v2 0/1] vfio-user: add live migration to vfio-user
 protocol specification
Date: Wed, 23 Aug 2023 10:03:59 +0000
Message-Id: <20230823100400.152847-1-william.henderson@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::15) To MN2PR02MB6880.namprd02.prod.outlook.com
 (2603:10b6:208:1f7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6880:EE_|BY5PR02MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 125a20c3-c02b-4d12-7295-08dba3c05181
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yD5WZ+yde/DnhPubzA3iou5qxxpGzugDMIdVT1xWfoQYB9Mr8N7FXiCnw/h4pvubd10EBncLgkrdHLHV1p91yScUGPwTxC3hyQ9noRGfBfzYtnine2iP+PpaXXbXf1q6xJnoayHCtEwk217+ek/MWZmTQmSElqY+iJDPyxWz4hGnXJMHDCn5fiaabuuWTvjiq6rfUNktFhqWM/5sdBowRkrJtPZ948O/r3JCVrPA45UD2BC6OkHST9SZ0M1w9COSkZqo8In6eqqko0u7Vr6aywcjmfNAUzxA+H8mLzEXt/7Oi2VFNjPMBSFp9bL5WspYMfLasSFLON+udLpGrinehbSGwzkjssKFzxjBoVHLsBSKZcYYNMXGda8PcYi/B6tS2f0B2c66wKfjmaJKN3klAuNFd9VQMZh4Vr+uLveM9ATzuFG06b/YS1fO2GULBHlyJumSWUPAUQSp+zHr0CbLZKdRCqGiTiMjVoRP6DOyEXS5sUfy9Ou5rUfPN68fOg4j7xZStvDTZVanOVCJklxr0tG+Dxaha8SInCIm1IPf3lWrwxrUEs74uFSRm+MXmw5IDO4nApJ2SdFx0lhBqGBMq+lF1t+KTLft8KCaVTr1/HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6880.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39850400004)(366004)(186009)(1800799009)(451199024)(8676002)(8936002)(4326008)(26005)(86362001)(6512007)(83380400001)(107886003)(2616005)(1076003)(41300700001)(38350700002)(38100700002)(316002)(52116002)(6506007)(478600001)(966005)(66476007)(6486002)(6666004)(36756003)(6916009)(66946007)(66556008)(44832011)(2906002)(5660300002)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RX4QbrXGcJ72J8geF9Ciftxo/VM33iHijjiyV0fNZ8ljW7uLfz2WTZqvU1pC?=
 =?us-ascii?Q?K1UB5rs3D8VCYwi+HjXbyHYSBeetrwNylmNQTGaplR9EJG9JDQhKZv69Ap/f?=
 =?us-ascii?Q?78E3uf8h+NWMP15hx9P3RLTFt33CS7VJm9+lsolN+Mq+mMt1koaRqbSosEIE?=
 =?us-ascii?Q?/2idN8xRyXXp5b9XEywoNbZ7l0oudX98uKJUvIButIVpRvWcpxTRKcvQSAun?=
 =?us-ascii?Q?tw5XX26+wNx4tZGeHDtUp7WH8mY5clzpP3of4SgVwgkpL8gzRGedA32xWO+k?=
 =?us-ascii?Q?l4wHWRuTlppOUSjNdon0lTQ/21EhKNkOopE0+8xNtf50ulwfF1eSdMwTuoio?=
 =?us-ascii?Q?IwfJq/AC4ZTdpVdrTU0cTI2yJDlTfjLwwNZaGns1Gopz/2ywoEQIALV2SbPi?=
 =?us-ascii?Q?3AAusk0GspBnF1vr6AI4QsaboJFMcHWMBH9EiRxzo1luBmnzfgeez0Zg/qr4?=
 =?us-ascii?Q?mvGBwE5Mz1b7fTTnfXPVN6t86bCq0uVoke9OrqEpLo7Tp1wyU2Yrw7rHzv3o?=
 =?us-ascii?Q?c5xPEpU48Sifuw7lMhjWpA77nHwiV0oH86KoMCC6Gl7f9qBsysVwviYf3y0t?=
 =?us-ascii?Q?TZIEQa9CvT94X4sb3diVCzhT7pcfeDshmRd162VRr8WR0961Zh+leVyuPvCH?=
 =?us-ascii?Q?NJa6b4H4rEm7QZmyOr/PmLQSrhajfJtrT5VX7Jg2fFc1DZWfpDZ4qLFsk/Wc?=
 =?us-ascii?Q?N3TE7WIIXJNxyFg8ciDue0B4isBjCaN99ZXPEDUgG9vuHnKzTS055ugADt6i?=
 =?us-ascii?Q?rEEEVZ5+JyExinbjdxZr16l2KLK1gUDrs+sYlJ/9W7ABrWifOMIoxbTVOaZb?=
 =?us-ascii?Q?3ynvUwh4eTCO4R3xv7Bk+0kAixeiHa1YkGK1f30JZ5JCLk9YEo9KwyzyiBgA?=
 =?us-ascii?Q?hU8TSBLIXn0DRImaEdCxxeyLGheoKPYTq6nJryb3DRql4b4jiPf/BpnZ+jzi?=
 =?us-ascii?Q?3IgoCtAJ/8hELEhQK0R3q3jktDebYw4W/mfu+zJVCEVXbLM78AbNXJbe3+zC?=
 =?us-ascii?Q?G7eAB1qTMOhzjRHkJJUNrHIdOdFZrYlEetgPFD1dc+9OUYNXo+QTa8Rseh7T?=
 =?us-ascii?Q?ouGVzBre1np6t6aaYSMcnQ4IrAG1p/yOyaD+jM9UGZmXP8lBpc8FaN/SUdxR?=
 =?us-ascii?Q?Abj+0TqkTeM6UuORLxwA2+cAShJrBuTnSsjg4IJnpPDb48MBx74P1seNQ+TM?=
 =?us-ascii?Q?HJUJ78wx9OEn0qQO/hXf50eHyWfStLqt2Ds7AP6G/nnY/i7qk7GomoaH+bQK?=
 =?us-ascii?Q?dn+F6il1yVaRwcm5fY46XGWZvaPKKJQaevR9hTQR3Q8LrvnhfkGN9FlxONCx?=
 =?us-ascii?Q?0xFnlAS5zQ7reumnIl9mwRb7SEsL53wpeEg41lwWhnCnvwjsu+COlr3f2imB?=
 =?us-ascii?Q?3TvoF/LwHD++OSSW1r5lXx2X1t81NG9ON2cAzMiZCQDOAJofnw0qy8+bM62a?=
 =?us-ascii?Q?ebPZKp7nfvOizHSS3gqytxpOnqZIUCh7e+QlNoI0pz+qLLw0etH2iIcApPLJ?=
 =?us-ascii?Q?pqEjylgco9sNMCsCSBngG3q3Z0hCnA6eSF6nOWTctcYYLtWQ4RE3dd548V0k?=
 =?us-ascii?Q?VRJ81AEA4gM8amgOTPQcK4Hy3DOjZVDlnBMDQ58WaNIDRKPIHwUpjhZCPuZx?=
 =?us-ascii?Q?qb9tQ4ova0PWsuWlwnHf27c=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125a20c3-c02b-4d12-7295-08dba3c05181
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6880.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:04:20.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcO5MIogmLNKdeqETXdvnC1Szra/WcLEVEZ641ZsgPXYDmJ0i7Ztow7JATweC5rIzILE17ShEVX/jKxoqs3VMk+IQjLIvb1lDnCnYbOkMXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6770
X-Proofpoint-GUID: 4TAT7R3ckjdJejtwxRHGpri9gI05WDO7
X-Proofpoint-ORIG-GUID: 4TAT7R3ckjdJejtwxRHGpri9gI05WDO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=william.henderson@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This patch adds live migration to the vfio-user specification. There are a few
minor wording changes from v1 of this patch [1].

This is on top of Jag's proposed patch to add the vfio-user specification
document to qemu [2]. We would appreciate reviews of that change too if people
have the time.

[1]: https://lore.kernel.org/all/20230718094150.110183-1-william.henderson@nutanix.com/
[2]: https://lore.kernel.org/all/c55f5ea0290763724bca1677314f8e2218785743.1688051596.git.jag.raman@oracle.com/

William Henderson (1):
  vfio-user: add live migration to vfio-user protocol specification

 docs/devel/vfio-user.rst | 413 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 396 insertions(+), 17 deletions(-)

-- 
2.22.3


