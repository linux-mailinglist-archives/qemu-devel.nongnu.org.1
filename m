Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FF70DCEE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RQV-0004kk-KX; Tue, 23 May 2023 08:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q1RQG-0004gr-W5
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:47:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q1RQB-0004bJ-1j
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:47:27 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34N8Astf032137; Tue, 23 May 2023 05:46:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=UGDulmIbwHU/XSbfa1DyCqvsB8pM0nGoENZMiFJRg9U=;
 b=I5CL/ZdW2cfGcgcNAtyS6Xt6Rm4OMECC6pEF3W24b7xbAmaaxTcZXS/a7ral5sKFBaPC
 PYRLff8/52apPWsW1LTZqG0ybpGj9YCWhAxZ9uzoMvhAJXAdsMPRGlEOxBmbWpxi5DOw
 yTeMo8uTZEDZVZrXTLd0BN2UTT6+A124nNxUqktr51TtwG10hzPD4HX+wfTGfeWGRiTe
 5We5LozShy4/1AQ5XkUnz561GOXCuTqx3fDDGzzecEnCTn7Y4GmSejrybOzJ2NSi4ZaA
 w5tan8RuUCXA+xawpLZijyDzuF0O8o9HOikCgxrEC6fODozjgB88eccNJDxsj7O01Aei xQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpwhce0bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 05:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsaoVWE6dKxJF4BCrRjDw3jN8f4OYx5YX/g1qMvfoTgfZa1fW8AXDRAshUflMdgOt/pSB4TQohXWTyIP0o0Z0GAj2IEjAsqtBnzTGHrI5gnVEZAy3eDpcA7S2pdXFEcF9AXhc2n4J60nw9HHvTO3RWzrqJ46zhM5j5T7L3POPVr9Kub6UHvj1sAGnoOhjEOge17d8y32kM057MlKyTBiCuYQbTIS+kV8DZNFIo1eXeGNz0LrwoeoH0f54txwlD1PfzGsso0LEF7NFsKEGaNwR8Yhxwnyx8FiGlBkUB8WEgsJb8q8hIBKCsqHAFyUXitW+gm0TkNBT8VIjogIE+TMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGDulmIbwHU/XSbfa1DyCqvsB8pM0nGoENZMiFJRg9U=;
 b=JWMahfbgoeYNKjplaDfTWz7EiJe6HsIQU+o1k5nP9fT9Vzhxo/aMVdUM7QdL5AUqP6jRk5MTTSlPxuxiYXS+3B8ioMKrIrt7pCLLbs62mhe/c2usAFWpTJw/yohhKD+QGSW26govh+LvfU7wGtCkk7eM/YBsX7AF2KRXGA/XhBhLDcYViILb7WkBUDe/sfWS8NF4j8H9mIyY4jMdSg3+P0qqDAko+sDXIIfMwzWoeNxXFBLkmryZ44b6ZO9MLsmW/0NaaODLUh5b7l3SxKet3n1gIPNcfE9RQ9Ydaur0dAo0G0ZQDYNyzJ840g8VsPOO91/LrkYoJfNg29xtuTq+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGDulmIbwHU/XSbfa1DyCqvsB8pM0nGoENZMiFJRg9U=;
 b=hH4fZM2BXM4aItHBwidqrVpzSBG3/7Pjd1qUySnkRLYk6HiVmtqw73ZxoijOiBOMPrbSDTQ1BPYjNI62cmswuybDaOgbQmnV2Blp1/C/YL3QI9x7pomsTBQk3IO4N9x9gDxjpE0e5/hErGtsb/NMxxJlhGNgDNGp1Ek1OvA9cgIQhxRwdYm0IMpkJXFvFzG1BXZsJyZQ7FGJRwVYxG7PaKx0iIbIkdzcVdbfzEY0SQe19ZS98PxycsrnwK+VFYf0h6rmPicx/ODY0wzOfzJlxPHblPSJhaje0rIXixmSTdG8qSOt/waFGS7NL3gCczNuJ5FLr2hE7OtFWS0EwvJstA==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CH3PR02MB9516.namprd02.prod.outlook.com (2603:10b6:610:12a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 12:46:53 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:46:52 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, ahv-india-host@nutanix.com,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v4 0/2] migration: Update error description whenever migration
 fails
Date: Tue, 23 May 2023 12:46:36 +0000
Message-Id: <20230523124638.16270-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CH3PR02MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: aaba78c9-e2ba-4789-86e3-08db5b8bc89d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vzYg53u3iQxs1AqW18AUsra57nl7eaPl6Gs+bgrpU52/TAwQJrLN7FlDpHbkuJPyot8PFG5s3/Zdq+bYSqY2Nf+1nzdZntlyH+HXZeLLYl9C/db8NlpKEAX54h0UJHMBD7Bs9MdVAOnj1HcaUS104svYM/rJGAxiJAw/AXZDGTmGx++fFvKTiNPBtDycROePVzPRI/toJFwiR/q8NMHhEkAQJvNTDkKt3UELRHMaCi+Yr69nLxI9clUppnE0nNme4ShTrv+Em9kYik6JxZxyD0TiPmvyjSfF+8Ia3gArKtzmJCCmlCHGZL1qUj2FmG3vLoZCTDlhG1cuc2y53SwHquBtjA+kBGq2101XxSwJI7fI/zEkSbe1j2xbu91Ek4Zy1YUYldz3V1W7mksaxmIL/8cfDiOjfutcI541nUXFCe+Yzkgas1Cxm7iyYjSbHtK7NE/Su7Q+YQ3mlxPpc09Gl/0ZU37Tlr25WKIA1BUxskh3OLmI+O31+WE5rKc/ZJ9Zpd1UDaraoO3VhTMO+xpepPcq1R2Z2p7Q+0kxFI8npGK14aPHs20b2HnzVclV3ZFJ6NhZvpIzBNmyHHfNGkZ6wYmj+GWOhBDpGEBixoZZSiZ3CPuovHYmxK5rVM4qY+IsE2DF8dlQYrXOj31W00olg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(52116002)(8676002)(8936002)(5660300002)(966005)(86362001)(6506007)(26005)(1076003)(6512007)(83380400001)(2616005)(2906002)(36756003)(186003)(107886003)(15650500001)(66476007)(66556008)(4326008)(6916009)(66946007)(316002)(478600001)(38350700002)(38100700002)(6486002)(41300700001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnlRLzRqNklwU25tNTg0RDJ5Z0p5cUZobEdBRkMzOUdyclJzbE54MkxnZHBt?=
 =?utf-8?B?Nm1TWTF1WkVzcTBDRXlrcktkY1RPZTRxeHFzQVN6MVVxUW1SdFdYalhZcXpl?=
 =?utf-8?B?enp1c2tCQlNEZitsYTJnSmpkWUhSeUVBbFdTc2l5T2ZKVEl0aTZEeHJlZGJv?=
 =?utf-8?B?OUw1VEQ1a2FqL2FhdkxuTG1BZm9TZzIvYTk3RndTSG51N00xOU50QmU2YWlh?=
 =?utf-8?B?QkNLWjBqaE9aQlVDMGFrQUVLL0lId2g1dmZsUDJ4VHp6MHNBL0FsZHZBbmp4?=
 =?utf-8?B?Q1VzMm4zdjhQY3E0ckFaNVpzT00rSi9pSjFxRURCbnZuUWgyZkI5OEI4ekln?=
 =?utf-8?B?b3RPTEkxV3ZjdXUwbk5nMHlvVTN4ckFSUTA5U01Qdk0wRTNNK3YyVlRUUXBG?=
 =?utf-8?B?UmdHM0x1bEdaSUdMZXA2ME5VdTNkL3RoU1MzTFpXaUE2cE1HbExyaWNTS0VJ?=
 =?utf-8?B?dVkvNzZ6RDhTUStCMmFhUE9JQi9PSjhtZUZldUR4NURDSTQ0Yk1XbEd2dkVs?=
 =?utf-8?B?a0hmcGtUVmRuaXF2OWczZHBMa1V2aG9HNm5Nd01PRkh0RkQwSm9WS3Nvd05B?=
 =?utf-8?B?TUwxK05YRGRkY3cxZTZ0dE8rL3RpenU3K3ltV01lcGJPcDQ5QlBRMWNoWnZX?=
 =?utf-8?B?ZFBSUjlINkx5M29ZZGp3WGpnU24wY1dWUDVOUWx2YkkyVVk1K0ZxdmY3Z0Rj?=
 =?utf-8?B?MngyTXRxekV3V1lsVjNnNFVoNzg4cGVXc0dxcVBZc2JWbDZ0TlhSSklMQVA4?=
 =?utf-8?B?dk5XSGlJeWVhTVlETFlrNkpGOG5mVUNaZW9yRFpRVGNweGZsb0p4d04yOWtu?=
 =?utf-8?B?OEEybHpnWExtd0VNMU1PSmVFa1ZqWG5tUFArcnFYU2I1UHYxN1R6NW1Pcndt?=
 =?utf-8?B?MUdvNFJhOUdVVlB2bDJubFZHYXRkTzFUcXlPK3d2M1prZWZsL3plSnB0dUlJ?=
 =?utf-8?B?Mi9KNXAzZVZjblp5bkIrUys2VzlYV0l0TUZKWnZ1WXdmbjdaaWErYWE5bWNL?=
 =?utf-8?B?WGdBTHJFWm1LWTA4TmY4cUdsbUFtNGNVcnk3ZzhPd2VsWlMzWkVZYm4veTdT?=
 =?utf-8?B?dFlCR2hpeUI0Q0VRSzYyV3FrOWFodW13djkrS0NsNFBySURvZytiQnZGQURN?=
 =?utf-8?B?RWFYY3BGMXR2c0kvWURqSGMybE05QXlDd21HT28rUVdOYmVSVGVXWGlrdWJp?=
 =?utf-8?B?TjBTNHBmYVlJMVVwd1l3K2FCOWdhbkNlQldONVdaM1hYSEt1eElVV0ZNdVcr?=
 =?utf-8?B?MUE0Y1lUTi9uQ0p2MFAvb2ZNdkxQYUIyZzJFU1ZDcFNsWmsrODJ2WlhNai9O?=
 =?utf-8?B?K3oyUFUxUEN4d0w3VU1yeTV0RzNjLzI3aFJ3MThOZHZKNmhCVWV3U2JDOWRK?=
 =?utf-8?B?M2s1Mkh6eHN2UTJnNnhtYTBBUVhnbjkxODF5NFl1RjdnS0t5ZWRaZWNVL1J5?=
 =?utf-8?B?eUpqQ2FjVnY5bXdtZmtwdlNVUTR2NzliMkx6c3k4N29VcThNRnhGZjdDaXRn?=
 =?utf-8?B?aTB1cGtlZ1Y5VW1lamxNQm1SMWZ6L2E0WkwwR2ZVNFQxeW1XZkRBYU5sVGhw?=
 =?utf-8?B?eFVOaFNFSEpHR25lSUYzWjJxc3pNcXFIdkduS3lyN0VhVmtuWXQwbGM4R2Yw?=
 =?utf-8?B?WDJvRmVEZXRsTjhWdVBhOHJQd0g2OWFEOU5QdHprTVdPVXlhM0QrNVlyOSs5?=
 =?utf-8?B?c01wR0lGVHVWUVNYNnJYSmQ3ZE5NY2ZBZU9vNEl3cFdSMGdFNzcyZGFDS2Iz?=
 =?utf-8?B?cjBCbmxVUE92NWdtSUl0VGg5ZXZkQys4Vlh6ZHM0V1crL2l1MUZMaDBzQVQy?=
 =?utf-8?B?cmNleVIybTlXci9uZURBNTBiTVVtcjNFd291dU1jbjVGNHNiOGY3T1M2bU5r?=
 =?utf-8?B?OEVOdmgrTjEveEx3UklCMThuNUdrbHNMaldPQmVPVWZ3RHNobTY2SW41SGhv?=
 =?utf-8?B?eWpGY3BuazdxaFJvdnpidDhqcnoyMllxSU9kbDUyVmZ4b1dSdWRTcUxVUzdC?=
 =?utf-8?B?RlIvS0FEUGwzSDB0bEE3WWFicmI3R3RoelpYd2ZHb2xOZCtzMlJWZ0tJOGNZ?=
 =?utf-8?B?Z1d2VDRuZWNWcnY0VUROcFUxS2I5ZmpZbWRFWTdtM1hkNXdYWmp5ZjgwMC84?=
 =?utf-8?Q?vKOH4Fh15LWaDCj5ATcGdAPWV?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaba78c9-e2ba-4789-86e3-08db5b8bc89d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:46:52.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWbg4r+4Y1hIrexnHuS0BQyQ3ru28z7QbpVor8iP2aq+D1LAWDm4xtCwY8+ESoAqBK7c17zP6feZtDiXyerKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9516
X-Proofpoint-ORIG-GUID: s47lEiryG2gn9n3QT8pBG-SjHfvjryqD
X-Proofpoint-GUID: s47lEiryG2gn9n3QT8pBG-SjHfvjryqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_08,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

Thank you for the reviews, this is the v4 patchset based on the reviews
received on the previous ones.

Links to the previous patchsets:
v1: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00868.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg01943.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04463.html

I've broken down this patchset into two	parts, the first, which updates
the error description in migration.c, and the second which refactors a
repeated call of yank_unregister_instance(). I've also added the 
reviewed-by as asked. 

A thing	to note	here, in the patchset previously sent, the second patch	
which handled the updation of error descriptions outside of migration.c,
was breaking a unit-test and hence breaking the build. I've removed that 
patch here and will  be sending that out as part of a different 
patchset.

Regards, 
Tejus


Tejus GK (2):
  migration: Update error description whenever migration fails
  migration: Refactor repeated call of yank_unregister_instance

 migration/migration.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.22.3


