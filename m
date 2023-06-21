Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AAC738486
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:11:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxbL-0006zl-Lc; Wed, 21 Jun 2023 09:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBxau-0006vL-Pg
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:09:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBxas-0000IN-Qt
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:09:56 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LBvZp4016036; Wed, 21 Jun 2023 06:09:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=3sKUhSa6noV8F/DMNMdsgEcTggGmIe0u5cNvyYIXADo=;
 b=DaCVcnujQmPRb7qIvdN0gXU7ZLkYFWvNmLPfQjHF2ACTrwo5jl/FSTHUCx3mQpscqNv0
 HDeqlU2eJON6IHokkCgtR/wfGhVeJncdeSKLpN/llv5jJFXMugHGR+2mQQMD/XAi8nPq
 /WvytYfgFpIHDOIK4d6VmGautks4rk40bjAZAaekLnFKMMdzmPpEysjggJghGK+ia6jS
 bNWLzl4TkCoQpj/sXmwjQGlS9Q7BIZ6TAr3xOjH6MnNTRKOdhP8YQ1RTtXECXR726Ksz
 HShgsMpmW+MpSMc6TF8D8UG5NmDvNPYhNw3dWjgpttDIk53mPqgbuOPzZRSgzw+ks6uC Mg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r995rfcdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 06:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTt+jY82Tb/eikCejW3oVSfq1pGhiVAEaw4QOqJt97NO4NZ4OMT8KB9pdgCR+xj5msVblZo+LMWXPfDRQvLUDmBCUwdDeL/FLx9v542UO1/vXbzD82jiy3csaQ21FVryTHH4bYISqq5ofYxii3OU/L+aJ4barNBpdo9ecW4JBVWS25DYyS1uR68H0NbkbKBQMIvS2uJaECrT+bAfqakmd78H5L9VuSE6TXzpjTTQ8UWdUJRoRsSmmxnBbZK8a56H6ajcTd1jC+F4UtAxEhE2oz/94zOX3P8SfYzrRaevS0JvSvR8ByDR8E44FwA3zK8URWnLV8Y85UKpP2uyT/GNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sKUhSa6noV8F/DMNMdsgEcTggGmIe0u5cNvyYIXADo=;
 b=RSXXpYLYjO1gG7rgNO+1epXW36N8B+H+EOr5VhfSXpY64JyojoMqNwu7BaqMN7zctmyzNiGBNJtw6BpO0hlELyEZnmAkDAk6dcAPEGuOYKpzEtIxh+/X91kpzu8EMjZxfskuY+qpxAQk7UJpHycly/Le/Xu8s99IOarAtK0suHsHzXo/7oMuVnkhR3HWalTL8dpayl3gydxa0Jpt+QGRk3lzXpwafRUeST61nQkkqi8TFsYBGFQK7M2OKdq4jQHsK07mQKjy8YNnK15/n5FLlX5DAPfGh6hVg80Y48NUZZmg+uOIbGhNwAHMgf1EQEGT6l6PIfnWlch0iZxy/iTrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sKUhSa6noV8F/DMNMdsgEcTggGmIe0u5cNvyYIXADo=;
 b=pwKx/uZrixrucWtmrlhV1MLOCDMIkkhQqb1N5WK3eSEFIUlGas/K9lInHCDFfUw5UiA+4H1TRFYatv3FXbiv4jejD2zZyvVs3XPTPqcgVEV5/8fcilYMrjQpmAly7MbxxucxTMU3+8FvplrD/+czqoj5Z23swBvhFXhPiA2OUWQ8UGI0rB1pn+3InZuY6wG/ZAmkYxhR1FSLr1W6imjBmSLna5ExwWQfjG5PCJNU47snqKVPIMNK6i1tnVfhqfZyUodYjGiXzLq3eg+n5N6aLMzZPJw6W14Kfpdnt1s5fIRy+0lvhaLEmIzQfqTikwJgQV+Dp36v6xeMm/Ln/nI1rw==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by IA1PR02MB8897.namprd02.prod.outlook.com (2603:10b6:208:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:09:48 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 13:09:48 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 0/2] Update error description whenever migration fails
Date: Wed, 21 Jun 2023 13:09:38 +0000
Message-Id: <20230621130940.178659-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::16) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|IA1PR02MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: d182b808-f384-48b3-787e-08db7258ca60
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fHld5m3c0RT21lNo5XHr35AzQz2gz2Z99ccZ/ScLPoHx+e49w1b/fakkoqfosUVfMA/lpb7F9nxXdS06iw9Z3a3FvQoInAZhQW+bW6OOa6XtAgEPAGuKmKgKhZpIuFpGqLN2r8BYBExt1ZMsQxTvu6A80ly5F2fUd8U5PmZSWdHxRzG2J28Cwfeu/h6FmJ16T9/rIisls4/8Wiq++MOepEw82+NVGMrhYzPyA92GqFviZUMHP/IeW/g4Z9INhKNMI4QfUoUGTdGiOq9szksHzXZT/FKhr2DPLsI0/82I4V+L/eSrDB1mZCjRaVPmCslrknxla20naNkvgCFj9u0mFdBx/22OM4czixt467g+n2xvjOtO9CU0Stxulr2joQBKw+uWbx5/x3lGV9wBr7QDrsKzzWisjJ2ceK3ziJR7VcE2g9QDWBM/xrzkJa7E49acYY21mhby+JMpRau1TReptV8+mUDzjBHNlQbYfN9G3rnRWwC6sW7FkihJ7ASN/39ZH1EBJQWBJtymYtbiNzHKjrSfmmYKJ1ZLvYaKCP5deZ78CFfMCuoWb86NX7iyhlxn5GflfCzF7JqavVQaG7oSsT//zhRKzjUfcps1Z24qSHQoWp3Qbqbqoyx/6ssoQzN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(86362001)(36756003)(38100700002)(38350700002)(83380400001)(478600001)(6486002)(52116002)(6666004)(316002)(66476007)(4326008)(66946007)(66556008)(2616005)(1076003)(6506007)(8676002)(8936002)(107886003)(41300700001)(6512007)(26005)(6916009)(186003)(2906002)(4744005)(5660300002)(15650500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnNDa1VkUWkwV1FSUHBHOGdIWXMwUnV4eU9TQlZXdHJjam5DK08ySXIyQnpk?=
 =?utf-8?B?ekJLOHliQ0V6MTdzTTBNVDg2MWFNWEswaU55Q1JMQkFQQlZESHN6S0hxS2cw?=
 =?utf-8?B?Mk9KUFJ3eE9sOTlSZnJYRytPOG9BUXBVOGxWbHNWb2ZvTDdBd2RaRnV3QXcr?=
 =?utf-8?B?ZDNEOGJSSjg3cVY3VVB1eGxJd0RZc3RwaVJGMWI4MzZLa1RjS2Y2QjJmcEE4?=
 =?utf-8?B?Mmg0WWZxWXBMNWUrck56Y2hZTjl6UFNpbU5aOEZVbElBK3FUcXlqam5tZStw?=
 =?utf-8?B?Rk5SaFRYOTVLSDdXdEFkTXpKWXNmQkxPQmtoSEZaSEEwSEl5K1ZMWm0xOThi?=
 =?utf-8?B?c3ZFUkdubTZQaDFqbFhzVW9RRHdDOTlmNDFkK2JPLzRBTk4xd0VvUFN0VlNk?=
 =?utf-8?B?SUNrMnFlYnhnM2Iwb0lya3JaMUVDemkzRVpXeFpPTEp1Szl3UHQyVWRxMDRG?=
 =?utf-8?B?OElMMlEvNjNXd3J2Q0VvcVJBbmcwcEZRdlZuU0lKY1VWNE0yQ09sK2hlSVgz?=
 =?utf-8?B?cG5DMEkrSVBRK0NGNjZRdGpvbUhsWlBCdVhXLzMwUS9ldGxOeENTOFg3enNi?=
 =?utf-8?B?RFNrS0RlREFTMGM1WHB6bHFUQkpqWnFIdFdramY4cHVUY21LaXM4TGlGYnV4?=
 =?utf-8?B?Q3NFOTFsMmo5OG1SVEVvU01vdUc3WE9DcHFBRjR1UURwS3l0QjRPZ2tFWmQy?=
 =?utf-8?B?QlZCU291VTloOHZjZ0xtYWVTTURYc0I1dysxMFRsaDdwdVJBNlBSa2xNV2xk?=
 =?utf-8?B?bGlhd3ZUeDNxcUtsNFVCdUNuUmo3cmFwY3JHU0Q5V0p2bVI2cUJHaHM2ZUtJ?=
 =?utf-8?B?ajlOZG12bnpFUDhBdVhBSkVHcVpxWHZNMXF4SitPVVdWYlhXbHNWa3ZNWW5P?=
 =?utf-8?B?TmJtU1kxSEVUazhOR1hhakRrVGtYanYybEdPbnIwcll2STRaVWhyMFNmZGRO?=
 =?utf-8?B?RnhvSUVqYnBMRlNWUXJyQ3gxMDVOa2Y0WEJWYjZLcEJ1Yzd6RnB2ckpENTFs?=
 =?utf-8?B?VGRiakp3K0FVSi9kbTI0REI1YnMybXRUWWNrRm03eklZMFg1MytCSFplNFcy?=
 =?utf-8?B?c2JtZ0tNbURxRXVZaGdzRG5KVXBWUEZEQStNU2VBa0hxSDJ0bTIwSzZacCtt?=
 =?utf-8?B?YldmTEEwbVdwbnRndUpCcmk1MzVTdGxUN3c1RWhvc2pVSENJeTF2OVE3bzdV?=
 =?utf-8?B?TW5oZFJnTXFnZkZRV3NCa3J6K1Qvbms0M2dpOUJENXZMZmwvU1FONFFxUFpG?=
 =?utf-8?B?dll2dUVsOE1NdEo4dy9wYTF5ZUJUb3E3STJyemNLZnNwdzRZMVgvamk0b0ZL?=
 =?utf-8?B?aG04WW95NVREdjNNK2FIQ0dWNDRGOTR0NnRKVmYxOXpMcDkwMU5IWW9Wb2s1?=
 =?utf-8?B?ZUk3Tzk1NGdsM055WE9EYW95dVIySldBUG5Pai8wSjBYMUcwVWVKOUZHSW9C?=
 =?utf-8?B?c091K2JkRk4vVlA5L0FheXB4clZwakVTTVdIMzVHSUZYd2RyZTNPNWVVdFF2?=
 =?utf-8?B?c1VjTDBmcVVsRFl5NStJNHFwZWdPQ0lRWElSbWE4TG1VVVg0dVVBWS9CYWE2?=
 =?utf-8?B?bFM2SU1uc2FYZnJxQnNxWHFEMnBwOXdzQjZZUXpQdHVGZm1oZzNiSVhkaVlW?=
 =?utf-8?B?L2RuMTZGMVJYbUxKKy9SVUJrL25vWjBPTDNOSE53ZHRKVENQbnhwMW92aWNM?=
 =?utf-8?B?OWNCZFkvLytUSVArRVl1T1NPRTJDNkJONG0yYk5nQmFtNTMxTWk1ZGpFdWhC?=
 =?utf-8?B?YXZIL2ZIeTVHbjFQNHZ4aXVPUnE3bDRQU1ZwVHJ2Um9GVmR6cnEyYVNPQ1hq?=
 =?utf-8?B?bEt2VTZmaklhRkRmcWF2RVdNQXZqQ2VXSkZTZkRZYkt5c2NwalNhbGNFT1p3?=
 =?utf-8?B?cDFIbnJHVUppSGg4dHlTQjNyZ05XalBHLzNLUktUM3kxNVg2Rk9ISkt0VXpC?=
 =?utf-8?B?bExYNy9ieGlVZ0Q2blJqZmQxcmt3dzhzN3pmcXBVWENCUXBsaUtxUi8yQVJt?=
 =?utf-8?B?YWNkRS95QWw5K0NRL2V0Z0xzUEFEbDhxZnJrTktQTFJ3bFlmZW1QUFRwZkpW?=
 =?utf-8?B?TndLQkx0d3VkYndvMTk0NjhxVlNHQ3lHMTVvRHdoQmZnVEhjWGowNEh3SCsy?=
 =?utf-8?B?Sm1uTjN6SVhGV3NRR1hFM3YvLytLYi9makcxaHA0Zkg3elRHZDRQRFFseERL?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d182b808-f384-48b3-787e-08db7258ca60
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:09:48.2857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KrZrKhXTBFtRKDkZvFcz9zz9dFOpZUwHuFmnc/FZo0GMeadKpjINY6RV/CejoeRyYXskWmL4vDBKyBQGmXhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8897
X-Proofpoint-GUID: m91xiKJb9cjrpO4hlTAPHPYFVF8MiTer
X-Proofpoint-ORIG-GUID: m91xiKJb9cjrpO4hlTAPHPYFVF8MiTer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
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

This is the v5 patchset which has been rebased on the current 
master. Requesting this to be queued for merge as this has already been
reviewed. 

Regards,
Tejus

Tejus GK (2):
  migration: Update error description whenever migration fails
  migration: Refactor repeated call of yank_unregister_instance

 migration/migration.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.22.3


