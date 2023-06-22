Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4740373A0EB
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJQs-000782-Vl; Thu, 22 Jun 2023 08:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCJQq-00077G-Ky
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:29:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCJQo-0004CY-Jf
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:29:00 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35M7pmZD019900; Thu, 22 Jun 2023 12:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Zu9iv6NxnV8JQLIP2B03oKGPkhs5p9N785HPFonnZ6A=;
 b=XQpouJ1vlkiQeOHDNsirwA63MOsGuXOl0b3jRDrUWlflH0yjcec9qt9lPtZTe+0JBNCl
 bglWrQ9e+UA4fXv9LGnE94EoXSZLI8RvcE8hAGtYkVP1GsWM5FAz8biR1+/+Tsk2UdQm
 4EwoSD33eNyPTywZgLUB3pssrBR7CmuVvoahCLcfyo0RmkNm6q8Hxw0YdXFNSUr2tNgv
 dquEePcRi+zIQklSr+3jUVeDRkUzWe48Qffko8LRdWdWsDnwrYHGuDVGuVYv0LLdIm+x
 m4b6zHzjvXc/HzWDEJtlSzXwMT7O9Yi54qfIhazISln4nqZiVPzYsE00ni5SSbtDyDRs mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3ss6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 12:28:55 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MBLhQg007962; Thu, 22 Jun 2023 12:28:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9w17u30p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 12:28:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNDu3pOhLpjRfoKTu1YtDpTlAVYZPZAgGWEVTHN7t96KjmDKITeN+DWJT7w5sX8IIZ95cz/phn/3AuTYhJFiXDFM014Y0QjT7Wq5BXm19KtD0uN/P17K1nZbTfQrenvie6+jGWMt8Fh+v9NUSpi9ZvGHIODtVRDXgf8p5Z0i2WstD1osYb5Px2dI0o2uzq36PrcrX5NGWNZftVAIwlLFL50myhHCF+J91RymlQbb61a54ygFC3QKxsCDAb5puBkEHjgALfEHvRDlxpm00g6X2u2pcSLfbiaOaeenAH8Bq5coueKS8cuV6cfEq+dPY7/m9JbtAWbEYSqQRjNZ2llgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu9iv6NxnV8JQLIP2B03oKGPkhs5p9N785HPFonnZ6A=;
 b=MFlIsdn/XAoxy+cP3hSVGhGUyyhwfAJlfD28MLkXSeu+ZHJ5v89BL7/2M7Wck7OsMo8oBbuH2smp37p5MBj2lcznO64xOHSqvTpFd58BGsqm9MYVewwISsib+9jXyQc1LrFF5Optfp0zWkxqIt4v0ASVV4A80cE1XUJdIbEND+slFLl2hzJVmX49il5ammxwgQE2P8tv/NfisdJ2+M9L+zLsrXUL/+X8esK1W6aG+lmFrPCVTYsPD5t5jk5bs8WVPIgQL+vew1hOFslro2cjr2CbfDsFsQZh1EMmrJR3Ujh+LQ5yudYyNTLtp+G0d483aA6JMvWBEqdcgQgL1ZS5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu9iv6NxnV8JQLIP2B03oKGPkhs5p9N785HPFonnZ6A=;
 b=h/a1qxPb/G3G8x2hDoFMSR2HaFNj6XDMOTrew4HSBf4CIAF3jLh/d5BoVgWT58eeYEOzMbaquDtN46kJdkbQpVrbjasv4HFlCiEkKRdZ7PQv07yK7OhFYl0MzNlhk9bM540rrcT8tHBkv5/awl3N/ehYt41iPabCVwI8ccWd0Y4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB5404.namprd10.prod.outlook.com (2603:10b6:510:eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 12:28:40 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 12:28:40 +0000
Message-ID: <0632be05-6184-eaf8-7bd6-fd986ffe1e35@oracle.com>
Date: Thu, 22 Jun 2023 08:28:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2] migration: file URI
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZJQenKR1aMJzaLCu@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZJQenKR1aMJzaLCu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00016411.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5da107-e948-4372-fb25-08db731c3584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLMXbqtxcpmFBYyssuOAOJU76FmC6jmVlTYRagueNzh3PitJJMTEXiKPwDCZaDX4SNW122UOrTBFm4TM13cnPbf2l5onK8CEaKJyJV7it2FTBhrhdroMWnZxk8lSDdYCTQZjS1QDjPgPgQDCkcgoKLA0n748E0dZ+TWeiYuk3ahUNXgboC0qbGTOjd0GwwkAz1nT9P9o3Wrz0sjJ99srYw8T6LGq6ubUU2GyO5UdJNSDQgntdiBkVYRdXKi8UJWwjL4XtiFObQE1Nws3eA9X0NGCCZWbG6NVXVIZptfMKyn2X3vtVPA2CbaL5SbvnCGAo49jkOuizUDaukPgV+cZx6znEH7TXWMj888tiQtCovKjCeE4wvAbEbJo8tVd9KlmpVdtcww2z3RRE5kW0VLYTmXM4GVQYEWlVYSoEngcTIKPSQvuwY2L/ZaaBAgS0zeqbomzuUFKt5br2eIfqQ89Y8fGB3tV+YjjswmFep9QRVsSATIX+xX3UJQ+jF47R68dbhSnMHQqxaY4XhGouZee1qmKevOS/4ZW7s6PEbyJNILn5mRCOe6bNrDx2gXoKAaBh9ukjp/2epN2+PygKxHuSR7b88LOO6W0JXVYwf/YjbBINpd5KvGT/HK/9KTjoqgZ2Ub3NCmTyqTXq6RbsnLe+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(83380400001)(86362001)(2616005)(478600001)(2906002)(186003)(31686004)(6512007)(26005)(6506007)(53546011)(31696002)(6486002)(36916002)(66556008)(36756003)(6916009)(66946007)(44832011)(66476007)(4326008)(6666004)(54906003)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2tIczBqS0F5Y0lJQ05oVm53ZnJqZm83ZmNDMnR5SitzRmxuMFJzd2ZSYWhm?=
 =?utf-8?B?UWdWcVBmK2U2dUdpWWt2eGN6dGpGVjBaQ2JuVDZNMFB2NGxVRk9aVU1Xdmdv?=
 =?utf-8?B?VE1QeVVWSHhiQ2pFUHBESkovSTVBSm11MnJHa0grUnpDRUhBSS9valhGM05k?=
 =?utf-8?B?OTY5QnlrZWU1QWhOQUlRY0RjOXMwL3h0R29ENTJDNjVEdCtNN1NMRTQ0d2NI?=
 =?utf-8?B?d0hXRXZMeHg1cEJHdDZuZXZNekVEQ2pDTVdIbjN5eng0UWovR2NMczIvUUx5?=
 =?utf-8?B?UHVWUlR1alpRbyswWGtHdkxkMEVRSmp3d1lGSWJJdE9xYUIxb3hRdVlFYXFq?=
 =?utf-8?B?dkhMaUkzQjNDZHZvNzIyYW5teWwyMFQrL0pkVSsyMjZTT3A1YnhHaXhYN2k1?=
 =?utf-8?B?V0Z1dzdtSk95TFRIVmx4MkpVWkQ1ZDVRSm9JZnRpelZQcEV3RHo3Y0lZWW1l?=
 =?utf-8?B?cmFDRVdyTklCV1ZZUlBtZ2V4eWxZSDQrZ3hua1E4NmE3MVQwbXVqd2wzTVhP?=
 =?utf-8?B?RFBrVUs5N09mc00xRmlobVY2Z0hSa3hzejhOSjBlK0Z2TWlmQ1YrVUR3NmhD?=
 =?utf-8?B?ZXZsYkhHeVVlUjdRZGdzYkc5V3hLMlhMSFc5ZDBLWXpwbTNlcVJSekRPVU43?=
 =?utf-8?B?OGdjRXNwdlBFM3FLQjhNTlJJNU1NY210TEpTeEwrZHI3VW1adU5YV0ZwdUZM?=
 =?utf-8?B?TEZxWFhWOFROMG53Nlg4MFpOTXdzNWlnc2F3RFJHc1BKUkdhejVwaUlMaCt0?=
 =?utf-8?B?SHRDUkVFcnRGbUN2RWJXNHRDUnlxYWFNWnoxUEVNSnVhZ3dBRE1ybFUvYjYy?=
 =?utf-8?B?ekdZdmxBZlQxbTl4bm14YVY1MUl2WG9uejU0TkZwQnhDdUkzcm1lemtjb0xH?=
 =?utf-8?B?U1Jkb3dTSTFCTVJDdmUrRFlTdHNhUGdxbGxwdDExVUQrMkJwT3ZCTFQvbUJC?=
 =?utf-8?B?U2hmTnpyVGczSW01VmRabjhKajBLemJFb0FVV2ZIUVJubkwwRlNFN1RsS1NT?=
 =?utf-8?B?RnBxK05XMGZpNXhXUmhwQ3BGZjlIQUdlWVNCalB4ZnNleEg2WWR5Z1crM2hl?=
 =?utf-8?B?Zk81VGdCdGwrajYyck1yUFh6T2R3Qk4vM2o4bVc5aEJKSWNLME8vY2RWLzF6?=
 =?utf-8?B?dk9IYThGczZkMEMzZytGOEFWc053aTIvY2xrNk04U2VwejJ1aFNCQzdIbG9y?=
 =?utf-8?B?WWlVbnJ5R0JHVjZxVkk3bm9BOXc4OEQwMGJDdmhaUi9JdnV0WVAzSVdiV2Rn?=
 =?utf-8?B?L01obUFQeStMTHVDdU1HZUFXaTEyS2Q2QTArTkYvNTZlZEtnUDBCQ3BWUUpl?=
 =?utf-8?B?WEFJNnBlSWtoWjRCMEZPcENNRnhrU0UvbzdDQ3RxaHJ6TmNvM2t1Z1lDNU9v?=
 =?utf-8?B?bHoreEdNMndXM3JraDBRRENLcEJzV3JlQ2R6YXVXU3cvT2JuQ0RTejBwcnU1?=
 =?utf-8?B?U1hyT2JUcWtoaHY4SHR2RkZXS05vRTdyNlVGZ0MvSGhxNGh6VGJEQVhOdlFS?=
 =?utf-8?B?VDNZMGIyQnlxWWlOS1pxbVhacXpVMlFlUDhWWFM1bXBOTTB2SFUzR0x5MEt5?=
 =?utf-8?B?V0tOSmdweENqNHIybXF3NHhhbVdRSmlCTVZza1VkY1FTaFA0YTFyK3RkOEVS?=
 =?utf-8?B?Y2hCMk44cGQ0RTNRaUdna0dTQjdMQWllMzU1c00zVmR4LzdlbXBvYnpaMW9r?=
 =?utf-8?B?MVRIU1lFdGx4S2ErQllhcHFsWjVTODArNW9Rc3gveDZ6UGNGdXJaSEEyRVpD?=
 =?utf-8?B?cU5pRVRyTjZObktMVWJmRWdSeklGazVXMmNLOHk0ZlZGb3d4S3FJZ3FCZGUv?=
 =?utf-8?B?NUs4VHJ1K0xOcTRXVkxaZEZVWVB2QkdDQVFZOUttNWMvdlB6YU5GZlIyelly?=
 =?utf-8?B?NEdpa3VDT3Nob1ZPN2JQLzZXd2ZpTWlRUVM0MWVaM2VxUEoweUc2aGRCSGZj?=
 =?utf-8?B?RDhYeTNQQnZ6SzJQRUI0TnlCVHUzSG9MVEtuZ2xFUUxoZithaEhIVlRucWNw?=
 =?utf-8?B?anZDRVpqN2p2Q0tndkxQbElDM3hGbnNpcTNLVVF4alVmKzhmZVRjUWFCdDNx?=
 =?utf-8?B?bGdDVWVIUk9EVEZyZ2wwZkExT1c3dTQ0WjdJTVRNTmYycWFvajI3bGdZZ3Fn?=
 =?utf-8?B?Rk9WbjRVT21KektHK3Uyc3VtclVVY3E3aDRKSEp5VWRFbmRza1RYZVFuZmFW?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F++kgGLfnosYLAaMeovOfPVLh3lop7ccUvHLqg7R0JzdC1rxf4iRktfSQ+jX03+Znd6RINAjX5V9KVyvLWfJCXiZ9593Jxkjw2FAkMiZZeX94B3Xuz+k6/CC68Qz7mF5JYzdnKXLS/9QKJDncYfJ6PHq5XEjxkLncB4J+tunPxO3L/eRnVu/7jYVRtvm8R0uYW92L9CgoQwHwxawYagpAt+FzqSg26WGVZWAc33YQd5id3yti4tXxKTfMLg0KcQmSgubL4HRP4zETKq+TppWxVMK9CB99+SQ6W14dwl0BlJJXTsy16WP7Vpx3ESeHyw6R+iUJAhqREKQr5cSO61fU8+0YYihH8OWLhGucEP2fuEwi+9keydMGVRaZr7BzW/7aFYgCdJvc5Bj4RO5EzQB3aYbdhCsdpxxrDzIUs7VUI5Kl2L+ltOA1Arjhq08OVclkvUvU4uRGJ/egQ+NG89/pJaEwmC6y6lCNe4RSskO6IFXp095sDu25HktAQx+V+LgllgdFtBPSMeyFmGTHQcFKtfPHTC3AunAMASe8aLBS4hVhaKabyk2uygT4Ya1C7YCxDBUXjnFs8gEwe7egfF2zTu4Yae1X5oD1fiB22MApF5qyBLHZVrBfdhkW28QEtmzNYe1Rj8Ze+3wjXLbtcLr+pHi1OLbc9s8WoNyhNVmj4fUhCxi/SA19BnMauYrwV+FkynCwZ1/3TtaGOVNeJzihWIzF8EXh4dfOBWh9KVtKXWIn5ZCrFKWm6kaaUppoBt93tE7wEUPtVHzqlgPNfGbCZiXnKxMlu5ImhTFT5UWwHoTaMweEgvUTPFT7R9dbQxo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5da107-e948-4372-fb25-08db731c3584
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:28:39.8786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfSTWaW2DSnALFRVCN7IvNgpTw3FDWCpz9ODNciBsaIM1NaxxycSBR54+F+w6VtwWbLudWmuUi4qH4zNfX/0OJrjA0+666xkfD66mGZ+d1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_08,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220104
X-Proofpoint-GUID: FKXZCDejjOgBA8uHcYwAJsV58oPHRyTx
X-Proofpoint-ORIG-GUID: FKXZCDejjOgBA8uHcYwAJsV58oPHRyTx
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/22/2023 6:12 AM, Daniel P. Berrangé wrote:
> On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
>> Extend the migration URI to support file:<filename>.  This can be used for
>> any migration scenario that does not require a reverse path.  It can be used
>> as an alternative to 'exec:cat > file' in minimized containers that do not
>> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
>> be used in HMP commands, and as a qemu command-line parameter.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> In the cases where libvirt wants to save/restore QEMU migration state
> to a file, we also need to have libvirt header and XML document at the
> front of the file.
> 
> IOW, if libvirt is to be able to use this new 'file:' protocol, then
> it neeeds to have the ability to specify an offset too. eg so libvirt
> can tell QEMU to start reading/writing at, for example, 4MB offset
> from the start.
> 
> Should be fairly easy to add on top of this - just requires support
> for a URI parameter, and then a seek once the file is opened.

Will do, probably today - steve

