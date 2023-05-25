Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B57710F01
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2CTx-0003s2-Bg; Thu, 25 May 2023 11:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q2CTq-0003rJ-Af
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:02:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q2CTo-0002PJ-8o
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:02:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PEiOej025514; Thu, 25 May 2023 15:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CFhrzQx8oxSgyNON836ZV6IKgcUR2TdeJQOchKipaHk=;
 b=WGFcKQrEGkGcS4bKZBQ/ujORnINktBdaL0Xs4W4rNBYPvsokR546M+mBCcv46Jaz6miv
 xQQybRlqxtjFh1tl629/M1WrlWN6KnCHGHN/SPlJTt812Bi7b0Nc2VxXG7yGYjBlYfO+
 RBJWO4Dshsc67czcwN+BLUQvDa0nHDfz0O4Kwl1joZjVQVeNRvyc/p9ivrJzrVNkihQx
 pI1PRUzKotXvF2Xuavn4PGXwpfr4GBxpin0TqsFFu/1LR7VTw2HFKnQJn4K4QuO01BGa
 /NpBRawXXEaZAJ2ZDmu444JQnUmtBpNOKfmryk+qrowe1L7pqOqUQfvBdwHMUev6AJJw 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qt9px01xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 15:02:11 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34PDUaQ4028672; Thu, 25 May 2023 15:02:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2tyvse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 15:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGPQVxqliYL62QXaVURvME2/DorEKGkHM+ZHNYl+ROGwhjYoAJAE/VOkjLCPsgAV32Xv4UoP0CYcgzzwR1yC3sqDU/qA4PwVV77a7jb8J7+p5G0pLnfw3oK2tZ9QGizP/JPkEthfLn/MqwM3bRtRv0/HQ2F5/mb8R+NcRFeeSJV6F94QM8bUnwJhAHtD6H7V1jX/HLC21cmXvjCTQhVqG7OO78kLkt8qRKA9SVQ79AS5c2kyJY+kEyh3Uopvrls3BMeSYkrTKIEr2kC4kJ1N5Q+3i3VYDsdwGAZR01+MVfNxpL2ubmmVK/ZQdLTTShZDGHSslqwUzCC7IYOh0lDeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFhrzQx8oxSgyNON836ZV6IKgcUR2TdeJQOchKipaHk=;
 b=LrL31Rrk9Xa8XO4VmIkUwatuYZwwDGXD0jYacR+ouTu30XdqCmf6DQbBhB0NxpcEDSZtvNVC1JlgeshHqPfW2FIMhbXYFPxzXWZSq/qRUWe3PDI8Iim49qnm3WdGAoIFshzhuzONbteSSiBLK8+ouUrqTZvu/PDUy+4J9C5k+fqw0l3h0IPphpEv+zD23xx82faLPgsB/ZH/kQ+ubowvCGsfChi7nDdRDsJUvJH1edd1b9pwjQljlbGn29a9UB/nkWWcZecdNa/K7hXFaU+0bGk+hcoB5M9ipi50e2LdpDOZbhNmVk8dXZd029A1ufnc2cSp90v7VLnMcJJYZAaGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFhrzQx8oxSgyNON836ZV6IKgcUR2TdeJQOchKipaHk=;
 b=q/d+S5ZB6Nme3rpHON8rV3Ltmizf3ovgWf6GiWOTa9Kzn2fMCPRFyTFoDhBegjxF1swBrNx765abYVNGxOBoCCb5Vh4lIRY+tLCNybKEQqWbY7rZtqiyskGeRaWQtPWktZR+KpxjauaqLLK9q3H72qBfsxK+QPjyfuMvmTjm9bk=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ2PR10MB7788.namprd10.prod.outlook.com (2603:10b6:a03:568::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 15:02:07 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%3]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 15:02:07 +0000
Message-ID: <b275c7b8-efa0-c8fc-bc27-c02f3dd0442c@oracle.com>
Date: Thu, 25 May 2023 16:02:01 +0100
Subject: Re: [PATCH v2 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
 <20230525114321.71066-2-joao.m.martins@oracle.com> <ZG9fungk+x/F0vD+@x1n>
 <4e8a19de-f56a-0dd5-6eed-5a9d8caa270e@oracle.com> <ZG9oqfEr8qig2QhQ@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZG9oqfEr8qig2QhQ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ2PR10MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 07053d04-d582-4de8-f160-08db5d3101b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUiTwW3pSQpEo/88ML6WvK0BcUT40ULHDXNag+mHFfUjbA9UAlRPjrkC5wkDVAFC9FR8AQveCQA7eqZqawnnanjZVQWIK0c2wU9okox1gfbrqzh5wK7mvt6AG6dG8VCz3pd0cjjBKW+kaslY5ECrIKw0qQbQXgBVrW2TvrmDqHI4XjcXOp0vZmKgLlJXQLYp2lS6c8XcE8z5Pg4HPXCP/eps7Hgn5lEPOrdTN0/T8ukMe6Z2ttjxCKIsc9wL0h5fytZsiwCxrU4Gkl39JPxyjhQ7nTeNHjT3JXBp86mU4TgmELc/krp3LtoL9wSh0XsFxy1bqeeUsOB0+lP316AH61Xfn6VhqOGfeT1W+4H6UdTMrfY1mVKde2Ccb2GzkrtGnJXYEabRh5+nXNRzPfp20MudDp4bNhuBUMn4jlqwdMMBBryfEXYPmEyneCutRLP/ex+yxOGukQ3FfdCA8PXq2BeJcN3feX7OYUAe/gskdkCp1YQ7fL7/RAohHl6oPQEWXPUTYK+NSCeTH3jAI+v9VXtxN7l0VUzDyYemn+R4ihlH6Xkb4dgq6c6zOzxEJT0o95Z6DpgKR0KyrWzZ3L83BUfR2J1D7GDwu2xBhupw2cFP2ChrMXW6e0KGS3NsXlBcJpBAz0M6in22lwWqrPx9ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(5660300002)(31686004)(54906003)(478600001)(41300700001)(8676002)(6486002)(66946007)(6512007)(6506007)(66556008)(6916009)(6666004)(66476007)(316002)(4326008)(53546011)(26005)(8936002)(186003)(2906002)(2616005)(4744005)(38100700002)(31696002)(86362001)(36756003)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNsQUloTjVWUE1HRXRoWEJ6L2dlSGhoaTZPcndYTTBZUjRoWmt3MEc4VVow?=
 =?utf-8?B?V2E1N0JFZzFBNWRDaXhQVnpaTGNBWUxDbmtnWnhnZnNJQXV3OENLcmpFOWU4?=
 =?utf-8?B?WnhDcUZxK2Y5MUkzN3dlcEkxaUdQZlJpSFV6V01BSUpUSlRkanNJb2huaFlH?=
 =?utf-8?B?dFU3dWdTdmFBUnYweDBTUnRNK01mdU80REdSRDY4MjlSckxQUHJJdkNoWmtX?=
 =?utf-8?B?N3ZDUjY5MUpGays0TitaeUw3QloxVGd2MDVtc0l6OGZLOFFKU0dJZGVPM0RX?=
 =?utf-8?B?bjhnSEp2azBKNldkb2I5NCttWUdIeDlQbTc4cEhkZWlJUUdQVitJdk13dFpS?=
 =?utf-8?B?RExkbU91Yis5Ti9oakU3NFJ4eExqRmlsS3ZUeWs3dDllL1AxZS9sS0tOdVNR?=
 =?utf-8?B?SzVCZjVzSFJ5K0Rib2tUVTEvdGNZWUNLRlhtV0hacjh3MVg2ODRFNmVwcTkx?=
 =?utf-8?B?SjZjKzVpU1VYU1pRRHlWTk1CL2RNcFdOUjA2N0dXRmNGcWMvZWxKY0J6czhX?=
 =?utf-8?B?dlozRUIzUEVlcDVlcjJIZm05VzRsS0NPTkhtTWNDNVQrUW1oMzc2bnpIV1VG?=
 =?utf-8?B?ODFzcFRpMlA2MElDWm0rNm1BbkVrRVl3TmNWTFRSaEpINnlrS0NSMDVjZU9r?=
 =?utf-8?B?aUtobGRkTE5oR2hQd3FHR2ZGdE5mMWhhdzNBZmNqLzhuYTk4Q2JPQ2kwUXE4?=
 =?utf-8?B?NWFhM1JwQzExQWh1MzVDZUJNWDZGRDhIK1ZMaUZQelhSWURZdFhGcDZ3RHdU?=
 =?utf-8?B?dkIrOFphOFc3Qk5yTC92cXF5SEMvOVpwZlk1bHdjZzdUTi9PenVLdDd4eGJj?=
 =?utf-8?B?UE5xa2dqTklFY2hzVnlxQWJXMnVac0RnYmp5VDRlQVdKdHpmZ1J4c3NDYk1a?=
 =?utf-8?B?aTAzSUtZNm5iOHBmVFJHUVJtdTVmUzZNWkMySWlUdEZzY0ozS1pzWUFMTVVz?=
 =?utf-8?B?ZURkRlVyVDg3Ui9GNGZoWFRaa0lyNkdSYWtwT1M4ejRUQTNMUGhZOXFQSWkx?=
 =?utf-8?B?N09VeTlzRDYwckIwY213ZDN1WHI5R2JaTUFnMGp3VS9ZNzRMcnJhamZJaGRv?=
 =?utf-8?B?ZDVuNm00UWFWRGI0RXBXTjRCV0pEbGdVZkwrTVpzQVJLSlE1TG5ZWmdXUFFW?=
 =?utf-8?B?QThNdS9uWWJlQ2YwWFBvdTVOQ0xmNjB4MSt2YjhXeDF2UUQ0T0ZmL1Q1Y2RL?=
 =?utf-8?B?MEVNa3MxQ2YvS0FSek1McnNYY1N2N01MNW8vUGppUHo0RXQ1ZGdYRml3bFJX?=
 =?utf-8?B?T1JsRGtNL3FyUng1WXlxY010dGs2TkJoaTM5NC9BYXJ2NmZqSWtGaXR0WERh?=
 =?utf-8?B?a3MyQTUweTREbUV0NlBjVk5JKzlHNzJpVjhRWVV5SlpvNXFNUEMzV3ZreXdI?=
 =?utf-8?B?ZWdIanlhbmlRSmlEaXBBVWUvelQwVnAwRlRNQ0lJK1h0bCtEZklRdXdDMmNC?=
 =?utf-8?B?WW03RUxaa3duL2lKMG5sSkpCd1AwL1kwU0NWWUxzL0IyaGdPUERXUmZ2R2Zl?=
 =?utf-8?B?Q0wzTVAwMEppZUt2SS9tQ0NGd1czTHZDcS9PbHpKMzN1VjM2ckxQTzFpcUF6?=
 =?utf-8?B?UmpNdW51Ymg3OWxjbDQ5blNiZnJJSVNDQm5MdUt1blkzYXVOSDRLTUVvM2to?=
 =?utf-8?B?akFaeWo4WVJiTDc4TWUxcEJDL2FyNmY4ZDV6MnpWdEFJTTlJUGpJd0VYWW8v?=
 =?utf-8?B?T3d0ZU5oYmgxYXJKeGlxTU5SbWYwMEdMYlJXU3lEcnNNWi9zbjFGWitCTlE1?=
 =?utf-8?B?aHA3Nm1zV1RRa3l3MnZvemlISkNodmtPOVZESlAxbUJENkhxM3JrRTFJc3Yw?=
 =?utf-8?B?RkQrZ21NZmQ4aDFaTGxSRFZzZEEwTVQxc3VTV0dOK2xvOUVPanRaYVVXb1I0?=
 =?utf-8?B?bDliL2puRnVlUUZrUURlekF4cVZISDJyTXduNC8xM3hMWjRxMHVYQXNQdC8r?=
 =?utf-8?B?Vlk0eTRmMFA5Z0svY0dvKzk0U3gzK3FMSUNPWnd4bHRob3JFdGQxaWFtbnI2?=
 =?utf-8?B?R3F4Z1ZFWHFxeVRMWXphU1l3Nng2YUNUemh2Mk5RQmlIMjllbkRIaVJkOGVY?=
 =?utf-8?B?WHNrRTgrYUowZ0gwZXJ2ZGVoWGs5K2ZveWRzaW95bHNkWndqdTBEYlhFVmVq?=
 =?utf-8?B?TmwyUmlzWXZmYXFza2Y1RUY5SXM2aEphMlVaOXVOUGQ5RVJMY1RQTFlpVVpj?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SW1WnNvE0gDL4na9/MfR+xoLU3osdB4o1qCiWgv6i4XUuULyRL+nyhkdhigQHweAa+ITcMDpguui6oM68pNQdGD/uIreMdIrehlpJ8HlBNwEbpRL5di2Nl4i081Rx7Tbdex0gqAstrPTHFVWvTUsIFC1OjFfaUw0kLEs+gpOOtYbl0ndsi0eUvT21Dyxs+MbJaC4l8SsCbGKxIq5ACFa7EajETAhYKp032m+tgZaN61Sm5rdF2U5rGliC0vzLuDYlJDH/Kyr2k9S1vriAHGeudVo2C1FUNiFfcFwqkcBsdSNUC3fZnP2oSPZncBVfOiHZfP/Jx30JZU3H3hhZNmJ3wcj9g6ZEKEJK8H2hq8W5G1ljcfrT2ea36smxdA8PMNRTR9sA39/2Z56sZibcneogKdlysD5NDnPG3YEWMv1YAfR2ZVRoWktJDK7N8NoldtcxLfJDFSClX6bdA7dKRKP+x757nssIzNBvL1jU5dmwBUGCbaLtmVy4lsU+zwiqcjJ1P9qXBLLCdseRhG6TkxtxZ3/nsLzqqzL4ZipaGNSwjGhLKJifL/0gRj+rbMLMtWGgmTC1HwGsG872lIZBWnrARGGGPLfNBVlTG5/mBmpxIz9V+yPB5S2LSGu2HXFuFjB8Wg2XKW7lyd3Z4KpZv2D/tgG4WuZjBdln+MIgzjZ45fyIKLnztt8odWO1xfwqzJxFjEGKtSODFxPKkhX2Po6ifwcnAhmz/iPLASDTlv/ibpfc6mKwLKbyGeCApbxfK3Dj1anLzPJj9H25j2NaNM56FOGNV1qlfZIPFrN+ObjxOrqjzu69uE/c4V4yMPAU/5+oAwTxsRkkfyZSuuo7t2jKQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07053d04-d582-4de8-f160-08db5d3101b9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:02:06.9824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUOISW31OrLATDvZvEzjEuO2J8PNGAmD78wi0kwIPi/JileDsq1hker4RgZ66eV303ljAYUzXm21d3ERzzLmVpNHKdHGMr8yOR6MfpdN91A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250123
X-Proofpoint-GUID: V0UCO7Sh9ZBn9QoTXf8vHSRZeCCD2mKb
X-Proofpoint-ORIG-GUID: V0UCO7Sh9ZBn9QoTXf8vHSRZeCCD2mKb
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 25/05/2023 14:54, Peter Xu wrote:
> On Thu, May 25, 2023 at 02:47:26PM +0100, Joao Martins wrote:
>> Yeap, Something like this?
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 8b8f271d0731..deaf746421da 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -333,6 +333,13 @@ static inline void
>> cpu_physical_memory_set_dirty_range(ram_addr_t start,
>>  }
>>
>>  #if !defined(_WIN32)
>> +
>> +/*
>> + * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
>> + * the number of dirty pages in @bitmap passed as argument. On the other hand,
>> + * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
>> + * weren't set in the global migration bitmap.
>> + */
>>  static inline
>>  uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>                                                  ram_addr_t start,
>>
> 
> Good enough to me. :)  With that, feel free to add:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
Thank you!

