Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8737125F4
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Vxv-0001x6-Te; Fri, 26 May 2023 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q2Vxp-0001wn-Ts
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:50:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q2Vxo-00081a-3t
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:50:33 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QBlDdF017613; Fri, 26 May 2023 04:50:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=q5Y0kHgGMEB8VuXBLDgH9ppx6/xGEE8y6phXlD7ugcE=;
 b=sdHMwaCnBowQIugIWXWOkzDYtMdmzuTIGk6xQO8gyeQZywmo+fh/KS8f655qVjImC2sV
 Abm/3mYuVZS1+XdPoyFnFrx0qguPwzGYebOyn3B9XknYxbESD2WuquctMUJq8Zk1xZL5
 BTzy91v+mT0lvPrHTRDYrTsZnU1uWOXNh5P39YHVGZzT9FhpsuI1M/O7PYW8Q5ZAcRCD
 tFFA0O12LKj9B3E5lfN5CzXv2A0QWRe4q8FB3PvrXJ2mbhx9fo7mMTAVYEOmcy3v/PSt
 TJA7n3bmPokDQp46rC2jjkEchW7IrBvKepimQo+pejvksjMG6AWCejRJAB+To/v4E/bu FA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qt58gauqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 04:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0pDaNf0IHMHbmqcR1hqvnl4H6oAhBBezevhg4Pg3737nfFMcXCX6ypnSXeR/8Z953bsGwiPe1/w/e//+z8buguDSpFRgWCDtQUHOtZyk1c7x7ABF2+GJSmU7m5u3ooBoml8dQKDYuphYhrWMyiWQLx68v/lJoBGvQNnTwz3/qtphd6dic141w5Ds27qViuRI1sFAgRdub8vT/RwyGjibfSzt7C93oJECwERkO8bo4PoYdTerWOpsY7blL7ql4wGfhfvYX9shr/bT9MFnC9sMxUCCWIbuzQdGHTrpUKGvJ22Z7wpsF9yv/mkczMHJjS7hbJnWHptAiAIcr76oWQZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5Y0kHgGMEB8VuXBLDgH9ppx6/xGEE8y6phXlD7ugcE=;
 b=CZY3ptvkCGJlp+LfLTSoQSoJ7NdYz6LwvikOfl56RNrWAgmBnjTnrqHn8EPd4EHJVp/UhjaO5lPjGGEyZ1sTAdPcHj4MwNjgIow4TZtR98NkxmIYydYfmYmldSRKZm1k7Fvd5ws6jaJ5nP1VScyerzEBSsfG7U4S7hrF0CtooQbsfe0pZecQSrPVsehjwQiVxFD/i95HgpKQvkRg4Ps66fW4OzvFnnJXCzOvkCfZHvU+Z27s4X7P78IAaJFqj31o4tW7rU/v+s/ovZ1phXUmpug6JxBHadq1WSDkagTvrVAxYajMn/2QxKk/G8tkQIn5GplXgJLCPJ7smPzhLEncYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Y0kHgGMEB8VuXBLDgH9ppx6/xGEE8y6phXlD7ugcE=;
 b=JHqsebSO+zhoiFhy7jHrjiNhys8tsLEjrcTwauQPGrscsKfdaBB9cIv/fgNAtMmOyNk7ihBb8NdVbwqyOZ8LWI0BF+ILGbDNbdz1zXf02QwQ4BBkTm4WdW+gJDTRuelJldHDX05JisNFgdibYlXYw7lwKqge3u4BsFTXswgNnmHsJ8Kj/vl3svi3ECbQ9YeZoQqWO1y/f7KagInakYt1rGafjQRQEjB/IlDULwxx5xyCD9D4l079pHLmpkevr+xOyU1qD4qKnWtqSsG6VjxdOgZfFB1H34oLuXiy4CWMJrS5a8ycdSN6Zy6IC4DTc+OaJpgWP7lVyyj3H3CDICaxzQ==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CO6PR02MB8738.namprd02.prod.outlook.com (2603:10b6:303:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 11:50:25 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 11:50:24 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [RFC 0/2] migration: Update error description outside migration.c
Date: Fri, 26 May 2023 11:50:01 +0000
Message-Id: <20230526115003.212004-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CO6PR02MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: c37a4d64-dba1-4adc-ff50-08db5ddf644d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oEhs0MeHtzXxPWJGAkmHpl7E9kR0reuwpfNiPfz9usg1hFsH42iuZFy8yRL9ozGFNYlzxvpmWkeYsn0q3qb7eTwHQ2/jBvgkna3C1CH+JO2+7xcf17uZT0dmM5UYTdBk4+WGF/JhVhI//mnFVo/a2TpMFq3JPHWPi4QxD4n36Qmqtyhrf4telXUJAGZqE5RivzNqFAcNOevLBKw1b2V6slMsJ0huB+Nkock+FYc1uShhhKSMdmgCuXYSKFO+jU1qJVwPzA7elIQqG10yOF+T9ea46EhnjAuqy7C2jMpXVSTEs3LIJ0xmf0KY1/xcqty4lqH8h6oabn9VhR9X6qPDuhtN7ENgLWMJfQZdAxBDUMFscik/36uEMQTiyukHD7TqYqFH5OlphFc2tYdGfJeMNYUPcpQolWtasHr3CsRd4MaojVoHlo749HhkwgVwVQtkHJ7OvNhPguV75LHVnb7LFfdE15AhyJUV60bhX5GgYf87ZGYK2THa7xiO+DQQCQwKvCltvFFlPFNnkG8bDMJkk9ke6lTjZo/KbK3W+LazpBr74KflAA6ezD69B9J1bgIdI4NX/hgvYHZ1c1plZBUPgn+2KgMZUmwZVmyKPVqsY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(316002)(6666004)(1076003)(26005)(6506007)(6512007)(36756003)(107886003)(66476007)(66946007)(66556008)(6916009)(4326008)(966005)(38350700002)(38100700002)(5660300002)(52116002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(86362001)(478600001)(186003)(15650500001)(2906002)(4744005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gCSY3tYAfSonPz8NTz1btS8o6F4b614NtwhfYHHsAc+wdLdqUzYNULuG0Dz+?=
 =?us-ascii?Q?ECvHpH0k2GY3Wlqp8SO2AM7Ux4RjYpGHKX6dCQcvyydL9w+qtCsCsAVnifKS?=
 =?us-ascii?Q?+JRzF66Kv5b0LKbiI18js3Axe1jFdTocZSAjRIeFIXclOIP125zXF9ad75nk?=
 =?us-ascii?Q?jxLBPCwzqSVjV/652HhG6DickknBBzvPv+8fQ3cKltVQcXQWEMoZ3tawZ7Fk?=
 =?us-ascii?Q?+SkEYRXMep2TKiky049Z5xYhxwPEY5OyzYH6Zho4N+LQ+ap8mn196sojquI2?=
 =?us-ascii?Q?n+MnLRftscpJx2Ke7c4iXPi2Gt+pK3CT0FqM+tV6MmNvcrffCTHf9e++NsxP?=
 =?us-ascii?Q?aW8ql0XqTf9bjQdEGKrefCX3Fn1rdkLCKWw+s3uCrD9IkPYKlzFgXxSy8jhT?=
 =?us-ascii?Q?0Ux28RAHZ3oUY75JxbkbWU16+apf6Sav5yLIaAbBrsGD61pPgaZUA1rXeAHC?=
 =?us-ascii?Q?gRAkaL35AngQj+IpxPJleL2Mo1Sbn6pKi8ShWMsUogDX57cHpgbE222qjy+b?=
 =?us-ascii?Q?MoK0+j51wvQhnSuFTMgekTYEJ5sjtOor9jajoTgPKjiV7tU6x6JSrgI/ZLQk?=
 =?us-ascii?Q?ZRjx+7x9RfGwOCOxPMKmhgYQ5Sq5ZtomUE+SnSlNu272MLER96DnVP0Rnsyz?=
 =?us-ascii?Q?K5kvXRyLSg8yWQ3bd8eICMfdq9K+0qhVC3MB6AYsRU4/VaPx4B0bSZwkSs5w?=
 =?us-ascii?Q?5TOG/q8FGRZr7fIGoCzrfgvA0E+XzJDmc0L/6j3oGZjI3EXxgi2C35qQllvR?=
 =?us-ascii?Q?g6ktC27TQE2xtrpQ/VoOPdHVdY7CuL39R9Ybeus+dp+d0axaXiv+6lAQxFt5?=
 =?us-ascii?Q?w8dHnWyho9aUlncaFkR4ZwFD4vK+N4D3Q5GM3mBXR5KyyVv7K1of+76NJWWN?=
 =?us-ascii?Q?o4Y5r9ckMsQAIj3dP27f5pvCXL/F8Mp4UX3j6f4LvuhBg3cgQJPgfiduATkq?=
 =?us-ascii?Q?Ayx1dhPP71cxtuleij/mE/aZuCofE04gd67AmOLh4/apaPguGiut3sKHND4t?=
 =?us-ascii?Q?thpz+6UAwwO6MufsbA7vmFyc+u4NK5DXaO6avDIGHht4vymz6TxUNkegU6RZ?=
 =?us-ascii?Q?ItHKkh8CdfhE2xeFWb4L2JSu0xT/8x71HGrhbRZGtWkbcI0dnkS+aTJ/PFx5?=
 =?us-ascii?Q?OabPpkQrP4KQpHh8qwrupjoxfw/v81yBbpb8e/oWUp3l/YIoS41CU+Jpnsig?=
 =?us-ascii?Q?dJIwHmfGSkjJCY9pXSqI8HH27vjOOonB1dXVsXZTC6dmP/ZeRYXZPXPSjgbL?=
 =?us-ascii?Q?Oinc9KNo+BvmtSS1mUrAhdGijC+Z8qjRl8PmiDQptExv+GFGioUCNqgoPFUt?=
 =?us-ascii?Q?uv5ao+K1C2OZo07lefdfHSb2cVVIqakdidzHMMhRjWSQO3LU1myaF4UecPCs?=
 =?us-ascii?Q?mLTKjebpzphHAfIjS7F4WqxefJm5Okb/dvEGwjOn9PCJzqCGVFh4VqYO/OZS?=
 =?us-ascii?Q?G4S0zd4psfWj6tkwSZpu/Ko7e9LhrWIZZDVc/ms+15A0BEXfyG9ky5DQzIvR?=
 =?us-ascii?Q?T4UDK99hvMl3qHzVr1TvSJbHBbxF5tXbNNOx54cNYYzmFVj8X0wlLYOtzDCr?=
 =?us-ascii?Q?QAOqw5TFj4OpUWXXqx/MQF/8KCbwvM3wIxGjaV4b?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37a4d64-dba1-4adc-ff50-08db5ddf644d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 11:50:24.7342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36Rbu/wkZBDRhYZU7Ep3Hlo3VOnMqYC8OdZhSAgR4IkV3nUYZiQVxujB6UTGX0IlxtwabamiPkmnOVYG4NChfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8738
X-Proofpoint-GUID: RbKkBzxwrKe4NDczS70NhqZFtYpE5Plu
X-Proofpoint-ORIG-GUID: RbKkBzxwrKe4NDczS70NhqZFtYpE5Plu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi everyone,

This patchset aims to cover code paths in the source code where a 
migration is marked as failed via MIGRATION_STATUS_FAILED, however the 
failure exists outside of migration.c, and without a call for 
migrate_set_error at this place. 

This patchset has been split out from the patchset sent before which 
covered cases of such gaps in migration.c aswell.

Previous patchset: 
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04463.html 

Regards, 
Tejus

Tejus GK (2):
  migration/vmstate: Introduce vmstate_save_state_with_err
  migration: Update error description outside migration.c

 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          | 19 +++++++++++++++----
 migration/vmstate.c         | 19 +++++++++++++------
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.22.3


