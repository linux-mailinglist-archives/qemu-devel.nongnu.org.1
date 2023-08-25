Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA16788892
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:29:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWri-0004K1-TS; Fri, 25 Aug 2023 09:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZWrf-0004IK-Cm
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:28:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZWrc-0002iB-5S
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:28:39 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37PDOERU024312; Fri, 25 Aug 2023 13:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jC2peN5K7GTQrj+qMIp0E3XdgflblMzLuXwlVPQE3r4=;
 b=0i45PYV0Bgu19Xn0dFwrUUUkailFB+J8l8Q84N8kdQWDBYGs6ozw5xwPEMBuXi1t9ZW7
 mbt5HNXXTt1UFsAIeW1zkPhhNaUfbaiWVXlp4EXAu0QgwJGL/LowLDeoprq7MFoQuApZ
 cKQyKZnq6xHVQWXRC8n/3XVRLmYJOWh98yE33AJ3fJICkQ0bWHAIcIqzw98DRx9M2JU4
 Ry4r3cqMoC/eS+2BkriwRmblLivKIs5NUEeVnS8gO2hXVq9yqwI1+l7rZ3ALnLk2Qzll
 L7uxVkuFNivGVH1IAKd57zsBP8eJfWMg5buJyz0MIvJuwov0MzduYdHPTMzNH4oP7gQS qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cp9v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Aug 2023 13:28:33 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37PD97K0002114; Fri, 25 Aug 2023 13:28:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sn1yy41ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Aug 2023 13:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjxCPSJOu+WMx4mSlJ6K4A4IkCMO5KCaxGRkDQTaOTYD6NN7o7WgcRk9C7yJJt3zzEyWa/9THnk2cQn0eh5Iqjxq76WEq2rqcRSYXrLVo1w73/XoIxhfr6HNM6z4Zpa3AaupyooiAQugJHso3GryqKfZt6jW/0/X0H1pUHPFj/Q+jwt5kcPpwrE6r/FjoQQlVycIJUzBzo6cH9SaBUVU7pnG6H8JbPYA0iBFL3tbpOf+JBemDfNQ8yKuYNncHxEUkhcgzvpw5BvOkrMtEeDLkyAlUIUfcWaDT8wAHdjrZTjdX6ksu6Yl4ly5hK74fMHQnNzPYDiK38IcKBOAQ13RPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC2peN5K7GTQrj+qMIp0E3XdgflblMzLuXwlVPQE3r4=;
 b=LzWrRU7cn2m+3A5NowrTgRkMnN+jkx/+0q9vEt3FTth1c61pTf/gBaWzqL3bUb/dUVw2JSnm8tRtSRovz8kSsPs4AHTMSevqW1d4b8JC0hK9Qf5EIQAH1vWjLnUVEatN/6Y8kzZk0hscKHjMpNf6NtnUoMr+GSsMuu+/XKOdrYl+bFOZeh4n9s+9ipJ3VSgwj2JVt/IpDNfY4tP/kswzBqWbQSummpVi0DnFuAuFFGJYE9DL/1Fmn7SSgk8Sa7OsU/U1jnx/IiJFLbnhlIqnAuNuR6f4OjZvZ4MdLU17ORxohGKQDg2ODAJ73335dU3aqSnDeezRlCxRdi3Jw16fvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC2peN5K7GTQrj+qMIp0E3XdgflblMzLuXwlVPQE3r4=;
 b=qOHqVA5+igntlU/yTzyeaC5VgAVru7iNGZ1sOvINhAd/Vjj/dVN27RsnWFNeMOEL9E24MCGtIuXLQ6Bs/0WhgI4TjDRstwskmPNb4dCJ1oz5+ENG9I//lTY1hga8y1mjq+MFaIfu7uf5qoIn3yHp6VjlNRptmZhft5SZ2s0iKxY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 13:28:29 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6699.032; Fri, 25 Aug 2023
 13:28:29 +0000
Message-ID: <964c8871-174d-b94d-eb1c-a84f0882a351@oracle.com>
Date: Fri, 25 Aug 2023 09:28:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 00/10] fix migration of suspended runstate
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
 <ZN5lrPF9bY4acpvM@x1n> <f26b44e5-ef9a-60fc-1172-559ff5ea70de@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f26b44e5-ef9a-60fc-1172-559ff5ea70de@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa7e894-51fa-454c-5c59-08dba56f2b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzjYA+F3H4hm05b1HxJ4Q9g5vkfxrmq6xsBo/Cn+yGI6Up2cDMrcHkMcFUsN5vx7BEyda4OCQpY0dndsbz/vCwMmeJs9RuHmbrW39UY6m3/c233fpZiHVwzy/CaXWCMa8gZ4/7Z3Lf8U5xWVsLePA2k5cvWwx0I7TtED2pGYmmrHdtRLaaaoFf/6X2WITrpO7O98/hakfWkKLf9UzR9+dKmPVr4SQd5P5Kejp/yUT0jUbHxPgFox8bdO2KrCOO1O6Ay67F3cdEhuYsy6LgMOzXJNtKYslsw9unAOMLiIVg7GgMjvtwnWsNredCLwAbM5/W9nLtu2XH73oMOZ8yIE6b2c4SY/mc17BaELAjme/CrB+BkqXbeQ/0gSxtTgkXlDIZUEgm6PBeoTF8PWHJO6wOIZgt2fjs1FKZkmjA19oyxlZKDA6Q53KsYandx/H+Isbw49yC/uWtzmgN20IHvik4heavMl9VGU+uM2arlbf+fTzR0iIovT75v9E0fCi+8DZW+EmJ7lFyJKjKyPW3Xj554hCHUxwkRIJURTBfhmCiUbWt2VpmaZ21qmnWAGHtwB1sMuXPgcoCd2E4d5Oh+I658fZMoc/BSULueKYClEHxPTD4h6azUxWLPDzig3vH0eMpAUEiNKNmhiE5DyfG1/+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(451199024)(186009)(38100700002)(8676002)(4326008)(8936002)(6506007)(66476007)(54906003)(36916002)(41300700001)(31696002)(6486002)(53546011)(316002)(36756003)(66946007)(6916009)(86362001)(66556008)(6512007)(26005)(478600001)(44832011)(83380400001)(15650500001)(2906002)(31686004)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVWc3hpbkg5dG9RMHZpTlJXeTFBYWlXWDE1ZEpJeVVnQjYwdC9ReENYVUdq?=
 =?utf-8?B?Ky9iL1hOZy9jckxheG5lUTFGYnBZd0NmT2g2ellzUTZhMjA5Zmd2aFU5NDVK?=
 =?utf-8?B?a1g3ZXo5RWIyUFd3S2lkUFJDRzVDTUxJUlpPNVZmOGtnWjl2Tk1vRzZybWg1?=
 =?utf-8?B?MExMTDJWVHlZNVpGQzIzYlJhMXhXSzRqQklCc1FlajRPZ1JqMUdYYU5kVmgx?=
 =?utf-8?B?Vlg2Y2RYYllzZmU2RjNiTVA2S2hsY0FvY01FcFFvT1YvRHpQcjIzZS94M0lM?=
 =?utf-8?B?SWtPQWlERnVTOG5mTkV3VGY2amlYaURxeG5JbDhFeG5WVFNML0hEdThNSS9t?=
 =?utf-8?B?QVJyM2VHSmt2NHUzeXFGWnp6alBZd05kYzNVV29uVWFYWXJNbWdWSUVtVXJq?=
 =?utf-8?B?Q096clBjd29NS1lsUG5XUG90ZVkwUXZWeGpxTHFwdE03VDVIa1dic1VIbkpw?=
 =?utf-8?B?ZzRVNGlrTXM5M0EyalNCeHRYVFlZOW1XNytQUk5naUdIWEI2Ny8wK2ZpRllz?=
 =?utf-8?B?NmE2Nkp6R1VNdTVMM2VKOXo3THJiZW9LZnNIR1BWV0RTZStIbkk0UE9VT1VN?=
 =?utf-8?B?dTkzS2EwQlZiR0dJYVRWTlBZbDM3aDR3MlNrSG94emxXQ3pRVjFSSjZOa2Jo?=
 =?utf-8?B?NUY4NWVLTVN4Sk5iMUIvemJCM3U0Qkw1amhyTGFlMGk1dituOEl0cWhIWVhu?=
 =?utf-8?B?bjYxOGdQVjlnYWtxOXdNTmVYOXQwOVl5b2RPUTZ3MmVzeEZ4aURQZUxEZ241?=
 =?utf-8?B?MktDU3Y3SHFQaVc2RVlRNlJvTjJGbGcwQkY5VGlCblJaNmk1Q2JiQnpNdy9H?=
 =?utf-8?B?eXlob05qTk5iY2pRWkZqanplaXBpQUhQMXhscmNlcHQ1c0FPT2pFV29DNHZP?=
 =?utf-8?B?Rkwra3EySjI3OVJMUkNTQ1NpMkphVjFIN2JPa0VkSEJNWTRLUnc3U0dwdnA3?=
 =?utf-8?B?NDRmcTl2V3VpWWV4b2xZVElVSUNNS2hZK013dWl2akNBYUUxMG80ZDUzblpB?=
 =?utf-8?B?MU5sYVZuOXV6YWNnVm1sVTZkS1JISU02TGxldVdpbGdyek5tSURjRFAyMkhl?=
 =?utf-8?B?TmxSemZuUmpCY0htUUpxeGR6Sm5xcUJJSmlodDJ6TXByNldzMUdCQmhhNHFC?=
 =?utf-8?B?UCsxVzFLNm5YMDVUUFV2c2xHZHV5RGx2Tjk1MU5jQzZ3UVQyUDAxcHVDWmRT?=
 =?utf-8?B?ZENDQ09qdU45Mk1RR09rSXFlZ1JSc3ZkQUFpWHpJOXVMU1VwSVhJMW9kOVRO?=
 =?utf-8?B?a3d6Tm9kMmtacS9RZnh1QXlNWStud0NJZkQ3UjR2T1lQVkJ2VHlRK3Nmc2sx?=
 =?utf-8?B?aEgvWUtHTExYS0FrL0loNmFRTWxZYmc2RGNsdHdSMG5JVE1OVkdXTEtrdHdw?=
 =?utf-8?B?Wmpvemhrcmh2UGppcHkzTWx6TTlQSncwMzVCckt3VldQTlJmRk5ON2lRbG8y?=
 =?utf-8?B?U2ZJQUV5YXBnbkgvZzZzaHU1T0lyV2RkVzlrYjhVbnlQdTliYjhJNjJoWmhE?=
 =?utf-8?B?UzRzSzBjVDB4NGp1TG5CL2tHWmlvS1ZlZXAySENYVXZya1FCZE1hcHRzdGFV?=
 =?utf-8?B?OXhOSXBNSElDa0RsQ0xQZk5WSkdXVFFWZE9WbWVnWjNPckxGZm05MG5DdDN3?=
 =?utf-8?B?ZjhDdWU1cDFCbzRlN0FUQy9zTm02R0NWTE5GNFE1T1VGUXRWcmMyZ1plTFNa?=
 =?utf-8?B?cnlXWWpKRk9RVU54RzlFTUYxZHZ4cm1qL3FjQlZ2bmEyRFRIbjRjWnhBTlpt?=
 =?utf-8?B?S3RBVG1MQU9GaktzTkJGUmlQOUtrSmJVQ3F0ckpPaFEzamRFbG9IaU1kZHlW?=
 =?utf-8?B?MDFzbmg5QnZIUEVyOW5xY0habDZsMnU3UDRoVFdBaEdEamRCaytwOGRESnlB?=
 =?utf-8?B?NnNSakZ5eVZNVktuai9RU3NneG9uUGZoTytVNzVlZTlJeHBNODQ4QUZVTE9n?=
 =?utf-8?B?K3pGaGFNQ2xuSkJsaGc3ckRPamVTSUpBSmZTbkRpWE12YytQSEJ4UThLZW1j?=
 =?utf-8?B?bC8vVi82ZnpGRk9FZ3llTnVrZjQzNS9Fd2ZFYXVlVkhuM0Nxd24remp0U3lJ?=
 =?utf-8?B?TUxib01UcnpoYTkySzhyT3lIMWtzTUJmNlJlam5QSmFQL3F5bjA4UFdMdUN6?=
 =?utf-8?B?MTNBbVF4MEhxd1VHbkgxWGJURkd3U3djRnU1dm11b2M3MFZIRU0xRi8xckRW?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /Zpt0IzUL9/06W32Lg87DjlnrDysbRe5o+a07KMu2+q0kHd7niDXg8uyk06Pzct3u4xCg5YTODpy8IAhUnxiS5tDnGwyOFsP+OgaVtomg3WmFGhr7+n7zN7P9i36RhfGF25WSPwhgqBqG6NdK9LSrTKhtqw8nEYafgcnknKdq/F6ioMF6UZEwJ7MErn9GRaVO7Czy1qtzWUlasz4XhvtfYU4KDCK6DFn6g8qgxnOP+vT91wqISIB6FPMk5FVWF2AXFTn0qtqJVw/hpffvZTQf8WIBx34ew4ETRrBp4k4G5V9w5zMEVg7RbAuqMtMzdFTMWchtXq2v8JwVv5N5ZUSxzXzXQT25zXTnQl/Ugu+7HQ54r1FmY3dYJE7kdljFnfAGnDxC8hnq4fcGANBmxzcpMgXgxExdcLOUUQRPw9KDJRzxVhlSFsfwtiRuOM7O/2BogphcRVrr90miQEZb+yzsr8zxygHO/hO/XYkbafyc/EVVAX1kDnJ927G1SdiU6FS1K7cmh1CXy4vdeqh/mQzoTCBbzi2Nd65PiGX2GB3wFjBy+Ajd2rgoKfnvXmN5LfKXhtc8o+ERB0lMd9A4yo21yTKzMP1qKwA2Opjo9nweB84aUj/v7HzzPbvoa9NoNntjoMymPvqc6aCEJHzELy5yyHM2Dl7ztvL+JidFy9XG+/cTIvatDxLEQO+DWOvFwaGLe+Y/bcc6RUOJbBP3vwizC4xYiipEEVsN9X8SiwQyCsCLodUMytK9m40Fe78ZCNN0rQXi5oJEkCReYC3pO63Fg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa7e894-51fa-454c-5c59-08dba56f2b80
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:28:29.3898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /W8ZgN3Nlk9ivgXAO2BNmmPoMPOI8rO4xbjDktd4rfJRjL5HoCsu9lwtXWFkH9C6QouyWF9KoFZ6t4e4qa2TBa/SpHFI5g4Jf2BniDRjEM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_11,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250119
X-Proofpoint-ORIG-GUID: EOAQwW5dxAvzrweDH5lm1bVPXUDc-YEu
X-Proofpoint-GUID: EOAQwW5dxAvzrweDH5lm1bVPXUDc-YEu
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/24/2023 5:09 PM, Steven Sistare wrote:
> On 8/17/2023 2:23 PM, Peter Xu wrote:
>> On Mon, Aug 14, 2023 at 11:54:26AM -0700, Steve Sistare wrote:
>>> Migration of a guest in the suspended runstate is broken.  The incoming
>>> migration code automatically tries to wake the guest, which is wrong;
>>> the guest should end migration in the same runstate it started.  Further,
>>> for a restored snapshot, the automatic wakeup fails.  The runstate is
>>> RUNNING, but the guest is not.  See the commit messages for the details.
>>
>> Hi Steve,
>>
>> I drafted two small patches to show what I meant, on top of this series.
>> Before applying these two, one needs to revert patch 1 in this series.
>>
>> After applied, it should also pass all three new suspend tests.  We can
>> continue the discussion here based on the patches.
> 
> Your 2 patches look good.  I suggest we keep patch 1, and I squash patch 2
> into the other patches.
> 
> There is one more fix needed: on the sending side, if the state is suspended,
> then ticks must be disabled so the tick globals are updated before they are
> written to vmstate.  Otherwise, tick starts at 0 in the receiver when
> cpu_enable_ticks is called.
> 
> -------------------------------------------
> diff --git a/migration/migration.c b/migration/migration.c
[...]
> -------------------------------------------

This diff is just a rough draft.  I need to resume ticks if the migration
fails or is cancelled, and I am trying to push the logic into vm_stop,
vm_stop_force_state, and vm_start, and/or vm_prepare_start.

- Steve

