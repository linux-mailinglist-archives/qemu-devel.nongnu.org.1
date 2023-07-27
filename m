Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D937652B8
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:42:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOz3B-0005hc-Pt; Thu, 27 Jul 2023 07:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qOz35-0005fd-Jl
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 07:20:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qOz31-0005A0-1r
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 07:20:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36R0s7Dp016829; Thu, 27 Jul 2023 11:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : from : to : cc : references : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=BlBFSaK8fUGgea7HeEi7M7qXQxZqKnRlhw8L2EAGPh8=;
 b=xd8Vy+77Vzx+lCysSPdZmUiQGmFUMwUyR+Fi1+LjDMp1O50Nv430ybrJwPhdNPDhita8
 dgQjWcoVsKkOtSyslkSGpdGfrxOf0Je4WIIclU55+swtKUkHsBHeDAh8okes5ie1HGfu
 k3B1wjKPLDzCCauAlEFkIrdr5jsvkVjCOR3XJXfPSQZNC8Aik7PWQDoS3HB2e3/vtaX9
 JjV12IY0msD70Jy+M0OIhPQL1oVpknAgLTDSIQmEeuX2Z6Lqogs/tgaRa/3WThFsREKb
 ykUuJGRmC+VRpWPAprUgyUTpswGkhX1BQQzNFgheG0+U9VtY/VuwsQaR0JvJBOVX4x/C yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qu1ek5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 11:20:33 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36R9bT3Y023017; Thu, 27 Jul 2023 11:20:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3s05j7g8f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 11:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVkuXvngDFjHt6tBHxQUy1+zac5ZcRUphi3r5uHY5eaUhHejEbVU4jvRiBujpTyXn1Du6PcrEZfSixoyl4qvU/BZ8PZ5IX+l03xVmKZ5RKrnFC34W9TCiTYZXIlVpIV41AlzVBRWlzZKMnq4zUBo1PncdskzDFU82/CT3lAsX78gVc/+RomAFIlkUxoO0BSorm26WT+Aw5JTBzOmR9rQej9ws3XlVcT+Ox9RMnh6WAimpXWpYDXcA1/dyHg8e42GdjZBC9QLEuxl4S8zg84SdcdHC+CTEVQfgQfCoVLPZX/G6Sv3Lbn8E9Lhqb4Hi+hWZEJELnbMfMTnCmx7Zs189w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlBFSaK8fUGgea7HeEi7M7qXQxZqKnRlhw8L2EAGPh8=;
 b=KVcHpZ/X32mow3Z2sL/jF5GooMFTnPFT7wuNhYU514TZKffCJRYFd5mW+NB1TUTdvPlA7pTc6qsTcOUgmJc/L/0in4YpjPSJa6Oqzs9FtsKeosv0VVO4WM0euKwzIba8ebJrm0XtbHqKCxlVoU1FOB5GrjBnTQtCkPwpuaLQzcWqbbWNpc4tOWFIDL+YFM+8o14y7Gi4YnV4GEpe3UC45JsFVukvCNYAhzMBldJThjGhPIzxz/cFZ0uh3VWnjffrdT/md+SEjFl1VIEJYM4tTyGLU1cbDlDIt9mremLOhQa7IJy6UrnEm/+VKDlt91rGJfHLAffTSm+ALByW1dgIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlBFSaK8fUGgea7HeEi7M7qXQxZqKnRlhw8L2EAGPh8=;
 b=suuB8WfcAh7McSSB5WbvcCDIRdjdCWTYdzLATOjuHQzcKcF8/EBPgSO3trOKope7PsxmYNvsDB7iB5hM1J7NU+rnV2kvQI19kZ4qa4RBXbqBeJy9hHWHYcuQnU7Av656RNxmx4CiPC/LUQEBUp+6zLmU3DRin5bq/34EF/gRz0s=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:20:29 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::8912:968:6292:45b8]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::8912:968:6292:45b8%5]) with mapi id 15.20.6565.028; Thu, 27 Jul 2023
 11:20:29 +0000
Content-Type: multipart/alternative;
 boundary="------------xiUhlLjWCohfxmaOO0alWmsg"
Message-ID: <2e44596c-337f-1210-3e69-b16d8fc5769a@oracle.com>
Date: Thu, 27 Jul 2023 07:20:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] qmp: remove virtio_list, search QOM tree instead
From: Jonah Palmer <jonah.palmer@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-2-jonah.palmer@oracle.com>
 <20230623014315-mutt-send-email-mst@kernel.org>
 <49f01bcc-eefa-d277-93fe-e3bcbc2ccd42@oracle.com>
 <20230626081522-mutt-send-email-mst@kernel.org>
 <006e8923-d73b-b6be-fccc-a26b3e98e811@oracle.com>
Content-Language: en-US
In-Reply-To: <006e8923-d73b-b6be-fccc-a26b3e98e811@oracle.com>
X-ClientProxiedBy: BLAPR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:208:32a::27) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MN6PR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b372c30-3ff9-47b3-f281-08db8e937bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9H+KT0bfTICAxk1kOdTh0wmQ3cZHIkhq11ERngcZKOL46Yh8mLOmdqo2jUtZikLoA8xLT+2T21/FDOdlZMD47gtWVyj7tugLf9XUm6HhLZOyILLv7UKDDETsSKRiPr5HHnRhQ8i7KiYU1mH9/1zp+z+wquz7RXIMDmQyy+B+EgLU8Avq6rja+c4NS7Hbfn/3BuGSI0RIgN4OX+C67QXKlMgrEmwQMhO9owccfb+Aucv0afflWXA3ik+u+vNc3Cm1FTlcJYU89EiHoMC7V7O7uSX97BKWadh1FakSDaLiIjUQg1LFOygg19FELAJSfrU1UrBCxCgRunIGUGj2V2RTM+uurzcjUdJX51f/pRN7V8PdMjV/1lfjxXCyUvdjo5n2rc9tZxlZyuiHXXvutBCvRsQHhAI9BXO6ed2m3UrQfhgggFrq0YL4YgYqTRjKoPkcIRaozZ549fG7FbmJdZNbfBwnEGXIrsdkXE0l9sYngchYCLEhMU7AgZE/j6Jp0x8DQ1oJh+abN7GEQCr9HV3U67oo6JfVn5X6Wu89WjeBqNte3nK713nUBgS9wIbKkRFXq6RqNmBKwjg7Pf8Wbx5l03o9J/yX+73a7GUaLK8MzJCsD2spx7svl/EOETzc0gqvRUY6sOO7iwgLmKPNCXPoQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(33964004)(6666004)(6486002)(478600001)(83380400001)(53546011)(26005)(6506007)(6512007)(38100700002)(6916009)(66476007)(66556008)(66946007)(4326008)(186003)(2616005)(31686004)(5660300002)(7416002)(44832011)(41300700001)(30864003)(316002)(2906002)(8936002)(8676002)(86362001)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9vNzNZanlwbWlpT1VrR05JaHQ2NFZkdmx4eCtqTFNpSGkrUmg5OFkwb1RM?=
 =?utf-8?B?NFN3ZHE5Zzlpb2t3aWVBTUdHRjNyRmNUTWE0V3VnazFWNVJXdnVhQ1RhWXps?=
 =?utf-8?B?U2FIWmhlWncvVzY3NWlaVGR5aGNiV0Z1M0xPbUtLdmNKd3hUSWtXbnU5SXlm?=
 =?utf-8?B?ZHl2NzNQMGtvSEEzVk9zSHlqRFpzaFpnaFJTQ3pSOGpHU0t4d2ZrcVpGSWZ6?=
 =?utf-8?B?b3lUY3NrS3NvZEVXbU5NN0FPSDJxOGgxUHFuR1RoTzN2WWx2ckhiM2NqcGxn?=
 =?utf-8?B?QzB4L2VyYmtHSkJSdDdKZHU3RytpRzVVNkMvdU8yY2E3QjByejZYQ2pYMjZm?=
 =?utf-8?B?bmQvZGxiRFlnQjRvTmd1dVM5VUJaMnQvUWlodUpVbURBU2VBMC9Ka1ZhQjc1?=
 =?utf-8?B?eXpFNlhWYXRvbjdCT3M0MUdPVFIvVDdrWTlxZkdYalhoeXp6YS85S0djQkgz?=
 =?utf-8?B?UEpiK1hnWXo4QllwRG5QQkVGU3V0UmYrQmxOenZ0eklBZ0hscmo1MXZZM0ZF?=
 =?utf-8?B?Mm9FNkNtcXJ5Sks0Z2hXbURmYXptMlY4YzBtbUZMK3BlZjZjbkZZL0oxdGtm?=
 =?utf-8?B?bUs2RHBET21EamVJVWh5bHhJd0pPYkxycWNuT1RKZHZCeWlMam01YnVtTXFO?=
 =?utf-8?B?ellrNDBwVjdkUnJPekNyWjRkU0JVOVhGUkE2RmZ5dTBsSForQUlDYzd6S0Zz?=
 =?utf-8?B?NUJwajB5UVhxVSt3TjU4SEUwc1MxcHIzdTF0ZGpici8yN2RYdlE4SVllZ081?=
 =?utf-8?B?amZCK1RUS1RrSFcvM0xCV2xtd3ladEJHYlhkcjFvdkJEU1JLNm9sQ3lMR2lh?=
 =?utf-8?B?WVd6aklFNEgyNXhnVDk2bFVYcUZpVm1HanlNaC91VjlteVh2MWY0THFYL0ZP?=
 =?utf-8?B?N0FkcUpFUXI5L2ZlSStFNFRub3lCZHltdnZDVFA2d0dNWm5ldlExRVZsZmNw?=
 =?utf-8?B?dmlHaHhFMWR6R3dVRm4rVmFzeXdHN2pUSmZ3UHI4K1RwSHlyMm5SdSsxamFV?=
 =?utf-8?B?STVPWnNZdEZIT2JSMUhBYkJjTUxNWXhmY3NwY0hpQ3FmclM5ejFhTm1PdjBh?=
 =?utf-8?B?SWVUM1JUS0graW9ZVU16L2N1SDZ0ZjJUeHRFSzFGRHd4M1BqOHhTbmZWMEhN?=
 =?utf-8?B?TXRMRlNrbHgzYndtWlhaV0xQU0E4NU1qSnBmMWoxRWhjaXFaQVlrSjVSVzRV?=
 =?utf-8?B?c1pVMjlxSHBGLy9IT0Z0WFZYcW83amUrY1ozTU5TZTF3NElBV0JvYndXbm1x?=
 =?utf-8?B?ZHArdU9tMmF3Z0x6TXNpTjlobG1sNUNsS1NDZmo4UUUvOXBIWWlLdk85VUFB?=
 =?utf-8?B?WGY1ellRSytJdDVybTAxTUFuYm94WXowcHhNSTZDSTQxV0tEWkViTEx1OHNX?=
 =?utf-8?B?amZvNmhlTkg2SXVMQ3RzNEFENU5XYkltVWZtQmFYYmxNbDNjdE53ZFBZdlNR?=
 =?utf-8?B?UmhtL253dmF1cno1Mm9Kclc3WmIrTFc1cUtQcFpqVXUxTlFjelMwNTc4RHNt?=
 =?utf-8?B?WlFhSTlkZDJjVVZNWUF2VVNGQVBKOEtFbnlOU09ZcUN6TlZyNnk3ajV4VHp1?=
 =?utf-8?B?bGFKblZWSENyTmQ2dmtlSHNLNW8xT0tDYXR4Yi9YVGludVhwTEtZT0RUSVk5?=
 =?utf-8?B?M2QvREJPMUt3bnNRSEtxWWhNSVBzeG5Wa2M3aVQyRENtRlVReU1lQ3NyRGx1?=
 =?utf-8?B?ZW9YN09jakcrVUZLZXBBVklydzhlRzBISGZkcXhJVllRVkNUc1NHWGRCbmFh?=
 =?utf-8?B?UWZrSDBOc3RteWhPTmhoMW1odittVlh3REljc1Ezb1dYUlBPQkozWEgwRXlH?=
 =?utf-8?B?SktGNXArNHhxYXZ6dG5mNFdEbHdnaUY4Y0dObVNRMUx5eG5pOVV3UzBlemQw?=
 =?utf-8?B?eFp2M1I2TjZoMHVNSmRHdWswMXB4K2lkdUswTmplVG9VRXNtSU0wdzJoQU1F?=
 =?utf-8?B?angvRlJDMGZFaWU1ekFub1Nac2dJZVozSjQ0azIxa0dWcUgvZHJJMzFlU0JB?=
 =?utf-8?B?U0NVdk1WVC8rZ2NxajhCTmZvNkdpejV6cm9Xa0RyZjFycTNpcFFmVUIvZGZE?=
 =?utf-8?B?aWxHaFRyZHVOTkZLMjI0ZHQzUXE3ZlFhbjdsczdzVDBNM3hia3UwS3BGU0FL?=
 =?utf-8?Q?WPI77atQhORu0/4rW88qeG20C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2MAWXOiuqk4xSlpsz9QqXJLPcG1+qB31jwpdL1OJm2MJuNT0ZIyAfSHn31QMokrCCcvzO2swNpAlzww3fybBLJFjpTpwD7cKBcD5WNo/8hypGvNZVq7F/NnNXt3LEEFXcp9i9KazptH620aO1QEAeZ3AYCwDq4XzB4+bYZEUETuq1L3xb23N+Y00dIeBpzlJuJ2VYFhM3RpQH3yXyAGz57NuW5bnKfNOxTvuepAqoqkYTjJkRS55gjxp/pN+Ami3lTpKqSj1SRvHbjrvkU/PWygjdM/XIjixk0oKr4vaZy10SkQjv9kU84kp/gozt4Xvurh1h/gpRuwr4LrQjaOa8KVmzHTesVect1zLjJMK6s6nTubCTEZlcZpwHmOvQst3uX0UtBBsKUcObK3XGODXKhOtDE6EqUvIQm128iEXLtmezRHCara73Pqjc9OUNum/p16QfPD4FMRCU84NDuNMQSvm/mbuVLVDz5swXIdXWmekUua7ZNQkf7E0zlx5LwDEwiuf5yo9EiepkCcxsBoXkMwDDseYlvXIpgzupCwW2k8qPsBjaC/VW08Co0nWY5RHE+ZVP157Zc3rdOUfh8hbY4atAH6MVOdFR5qDVI594ciiqN0TGKIX/PeMZp/heD+11qe+e14WBFpSLN3a66mmk6eTatcxHhqLZp1izGomEvN1znydtSNeD2VmETvPVxBASq7BvnZwYPDSKC20U5rBRwu6uNePdQYDhXIFR6uahPRlPOhfcytijSw51J6n3TytXog0fRpYB91V5NOTYHotgQZPJVFYkGs7TzFHffNViwPcYB0eM0eX06cAJalF9wimIRhp6QyKTw4AmtTJbCH4+ZinSSkPW+96WzGNWQ1C52RbWNp9JoJHmZIpLd8Beb32
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b372c30-3ff9-47b3-f281-08db8e937bd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:20:29.4045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1OnHPFSvZnWJcu7+R/KTYru2s5Z2+eNTy6RqwB5ZRdmIb5MseSET9Srza9PJ14efmQIj/XRI+lPecCNSQXXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270101
X-Proofpoint-ORIG-GUID: JALz8aW60LHq500R7sEhWQaKuet1umH5
X-Proofpoint-GUID: JALz8aW60LHq500R7sEhWQaKuet1umH5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

--------------xiUhlLjWCohfxmaOO0alWmsg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/23 07:23, Jonah Palmer wrote:
>
>
> On 6/26/23 08:16, Michael S. Tsirkin wrote:
>> On Mon, Jun 26, 2023 at 08:08:28AM -0400, Jonah Palmer wrote:
>>> On 6/23/23 01:47, Michael S. Tsirkin wrote:
>>>
>>>      On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
>>>
>>>          The virtio_list duplicates information about virtio devices that already
>>>          exist in the QOM composition tree. Instead of creating this list of
>>>          realized virtio devices, search the QOM composition tree instead.
>>>
>>>          This patch modifies the QMP command qmp_x_query_virtio to instead search
>>>          the partial paths of '/machine/peripheral/' &
>>>          '/machine/peripheral-anon/' in the QOM composition tree for virtio
>>>          devices.
>>>
>>>          A device is found to be a valid virtio device if (1) its canonical path
>>>          is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.
>>>
>>>          [Jonah: In the previous commit I had written that a device is found to
>>>           be a valid virtio device if (1) it has a canonical path ending with
>>>           'virtio-backend'.
>>>
>>>           The code now determines if it's a virtio device by appending
>>>           'virtio-backend' (if needed) to a given canonical path and then
>>>           checking that path to see if the device is of type
>>>          'TYPE_VIRTIO_DEVICE'.
>>>
>>>           The patch also instead now checks to make sure it's a virtio device
>>>           before attempting to check whether the device is realized or not.]
>>>
>>>          Signed-off-by: Jonah Palmer<jonah.palmer@oracle.com>
>>>
>>>
>>>      Could one of QMP maintainers comment on this please?
>>>
>>>
>>>          ---
>>>           hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
>>>           hw/virtio/virtio-qmp.h |   8 +--
>>>           hw/virtio/virtio.c     |   6 --
>>>           3 files changed, 82 insertions(+), 60 deletions(-)
>>>
>>>          diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>>>          index b5e1835299..e936cc8ce5 100644
>>>          --- a/hw/virtio/virtio-qmp.c
>>>          +++ b/hw/virtio/virtio-qmp.c
>>>          @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>>>           VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>>           {
>>>               VirtioInfoList *list = NULL;
>>>          -    VirtioInfo *node;
>>>          -    VirtIODevice *vdev;
>>>
>>>          -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>>>          -        DeviceState *dev = DEVICE(vdev);
>>>          -        Error *err = NULL;
>>>          -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>>>          -
>>>          -        if (err == NULL) {
>>>          -            GString *is_realized = qobject_to_json_pretty(obj, true);
>>>          -            /* virtio device is NOT realized, remove it from list */
>>>          -            if (!strncmp(is_realized->str, "false", 4)) {
>>>          -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>>>          -            } else {
>>>          -                node = g_new(VirtioInfo, 1);
>>>          -                node->path = g_strdup(dev->canonical_path);
>>>          -                node->name = g_strdup(vdev->name);
>>>          -                QAPI_LIST_PREPEND(list, node);
>>>          +    /* Query the QOM composition tree for virtio devices */
>>>          +    qmp_set_virtio_device_list("/machine/peripheral/", &list);
>>>          +    qmp_set_virtio_device_list("/machine/peripheral-anon/", &list);
>>>
>>>      How sure are we these will forever be the only two places where virtio
>>>      can live?
>>>
>>> A virtio device will always be considered a peripheral device, right?
>>> Since peripheral devices are input and/or output devices by definition.
>>>
>>>          +    if (list == NULL) {
>>>          +        error_setg(errp, "No virtio devices found");
>>>          +        return NULL;
>>>          +    }
>>>          +    return list;
>>>          +}
>>>          +
>>>          +/* qmp_set_virtio_device_list:
>>>          + * @ppath: An incomplete peripheral path to search from.
>>>          + * @list: A list of realized virtio devices.
>>>          + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
>>>          + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
>>>          + * to a given list of virtio devices.
>>>          + */
>>>          +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
>>>          +{
>>>          +    ObjectPropertyInfoList *plist;
>>>          +    VirtioInfoList *node;
>>>          +    Error *err = NULL;
>>>          +
>>>          +    /* Search an incomplete path for virtio devices */
>>>          +    plist = qmp_qom_list(ppath, &err);
>>>          +    if (err == NULL) {
>>>          +        ObjectPropertyInfoList *start = plist;
>>>          +        while (plist != NULL) {
>>>          +            ObjectPropertyInfo *value = plist->value;
>>>          +            GString *path = g_string_new(ppath);
>>>          +            g_string_append(path, value->name);
>>>          +            g_string_append(path, "/virtio-backend");
>>>          +
>>>          +            /* Determine if full path is a realized virtio device */
>>>          +            VirtIODevice *vdev = qmp_find_virtio_device(path->str);
>>>          +            if (vdev != NULL) {
>>>          +                node = g_new0(VirtioInfoList, 1);
>>>          +                node->value = g_new(VirtioInfo, 1);
>>>          +                node->value->path = g_strdup(path->str);
>>>          +                node->value->name = g_strdup(vdev->name);
>>>          +                QAPI_LIST_PREPEND(*list, node->value);
>>>                       }
>>>          -           g_string_free(is_realized, true);
>>>          +            g_string_free(path, true);
>>>          +            plist = plist->next;
>>>                   }
>>>          -        qobject_unref(obj);
>>>          +        qapi_free_ObjectPropertyInfoList(start);
>>>               }
>>>          -
>>>          -    return list;
>>>           }
>>>
>>>           VirtIODevice *qmp_find_virtio_device(const char *path)
>>>           {
>>>          -    VirtIODevice *vdev;
>>>          -
>>>          -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>>>          -        DeviceState *dev = DEVICE(vdev);
>>>          -
>>>          -        if (strcmp(dev->canonical_path, path) != 0) {
>>>          -            continue;
>>>          +    Error *err = NULL;
>>>          +    char *basename;
>>>          +
>>>          +    /* Append 'virtio-backend' to path if needed */
>>>          +    basename = g_path_get_basename(path);
>>>          +    if (strcmp(basename, "virtio-backend")) {
>>>          +        GString *temp = g_string_new(path);
>>>          +        char *last = strrchr(path, '/');
>>>          +        if (g_strcmp0(last, "/")) {
>>>          +            g_string_append(temp, "/virtio-backend");
>>>          +        } else {
>>>          +            g_string_append(temp, "virtio-backend");
>>>                   }
>>>          +        path = g_strdup(temp->str);
>>>          +        g_string_free(temp, true);
>>>          +    }
>>>
>>>      I don't much like the string operations. We should be able to
>>>      check object types instead.
>>>
>>>
>>> I don't either but in order for us to check if the object is a
>>> virtio device type, we need to use the device's path ending
>>> with '/virtio-backend'.
>>>
>>> If there's a better method to checking this though, or perhaps
>>> checking a different type, that doesn't involve string
>>> manipulation, then I'm all for it.
>> TYPE_VIRTIO_DEVICE ?
>>
>>
> Please excuse my ignorance, as I'm probably missing something here,
> but how can I verify a device is of TYPE_VIRTIO_DEVICE without using
> a canonical path ending with "/virtio-backend"?
>
> Initially, when the query begins, I use 'qmp_qom_list' to generate a
> list of devices under "/machine/peripheral-anon/" and
> "/machine/peripheral/", e.g:
>
> 	- "/machine/peripheral-anon/device[0]" (virtio-serial)
> 	- "/machine/peripheral-anon/device[1]" (virtio-scsi)
>
> Without appending "/virtio-backend" to those paths, which are virtio
> devices, checking if the path is a device of TYPE_VIRTIO_DEVICE would
> throw an error and fail via. the following:
>
> 	Object *obj = object_resolve_path(path, NULL);
> 	object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE);
>
> With these path (without "/virtio-backend"), we could check if it's
> of TYPE_VIRTIO_PCI, but not all virtio devices are PCI devices
> (e.g. virtio-mmio).
>
> This can also be seen when qom-get'ing the types of each path:
> --------------------------------------------------------------
> {"execute": "qom-get",
>   "arguments": {"path":"/machine/peripheral-anon/device[0]/",
>                 "property":"type"}}
> {
>      "return": "virtio-serial-pci"
> }
>
> {"execute": "qom-get",
>   "arguments": {"path":"/machine/peripheral-anon/device[0]/virtio-backend",
>                 "property":"type"}}
> {
>      "return": "virtio-serial-device"
> }
>
> So, in short, I'm not sure how I can check if a canonical path is to a
> device of TYPE_VIRTIO_DEVICE without its path ending with "/virtio-backend".

Any updates on this?

>
>>>          -        Error *err = NULL;
>>>          -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>>>          -        if (err == NULL) {
>>>          -            GString *is_realized = qobject_to_json_pretty(obj, true);
>>>          -            /* virtio device is NOT realized, remove it from list */
>>>          -            if (!strncmp(is_realized->str, "false", 4)) {
>>>          -                g_string_free(is_realized, true);
>>>          -                qobject_unref(obj);
>>>          -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>>>          -                return NULL;
>>>          -            }
>>>          +    /* Verify the canonical path is a virtio device */
>>>          +    Object *obj = object_resolve_path(path, NULL);
>>>          +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
>>>          +        object_unref(obj);
>>>          +        return NULL;
>>>          +    }
>>>          +
>>>          +    /* Verify the virtio device is realized */
>>>          +    QObject *qobj = qmp_qom_get(path, "realized", &err);
>>>          +    if (err == NULL) {
>>>          +        GString *is_realized = qobject_to_json_pretty(qobj, true);
>>>          +        if (!strncmp(is_realized->str, "false", 4)) {
>>>                       g_string_free(is_realized, true);
>>>          -        } else {
>>>          -            /* virtio device doesn't exist in QOM tree */
>>>          -            QTAILQ_REMOVE(&virtio_list, vdev, next);
>>>          -            qobject_unref(obj);
>>>          +            qobject_unref(qobj);
>>>                       return NULL;
>>>                   }
>>>          -        /* device exists in QOM tree & is realized */
>>>          -        qobject_unref(obj);
>>>          -        return vdev;
>>>          +        g_string_free(is_realized, true);
>>>          +    } else {
>>>          +        qobject_unref(qobj);
>>>          +        return NULL;
>>>               }
>>>          -    return NULL;
>>>          +    qobject_unref(qobj);
>>>          +
>>>          +    /* Get VirtIODevice object */
>>>          +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
>>>          +    return vdev;
>>>           }
>>>
>>>           VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>>          diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>>>          index 8af5f5e65a..4b2b7875b4 100644
>>>          --- a/hw/virtio/virtio-qmp.h
>>>          +++ b/hw/virtio/virtio-qmp.h
>>>          @@ -15,13 +15,7 @@
>>>           #include "hw/virtio/virtio.h"
>>>           #include "hw/virtio/vhost.h"
>>>
>>>          -#include "qemu/queue.h"
>>>          -
>>>          -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
>>>          -
>>>          -/* QAPI list of realized VirtIODevices */
>>>          -extern QmpVirtIODeviceList virtio_list;
>>>          -
>>>          +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
>>>           VirtIODevice *qmp_find_virtio_device(const char *path);
>>>           VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>>>           VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>>>          diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>          index 295a603e58..83c5db3d26 100644
>>>          --- a/hw/virtio/virtio.c
>>>          +++ b/hw/virtio/virtio.c
>>>          @@ -45,8 +45,6 @@
>>>           #include "standard-headers/linux/virtio_mem.h"
>>>           #include "standard-headers/linux/virtio_vsock.h"
>>>
>>>          -QmpVirtIODeviceList virtio_list;
>>>          -
>>>           /*
>>>            * Maximum size of virtio device config space
>>>            */
>>>          @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>>>               vdev->listener.commit = virtio_memory_listener_commit;
>>>               vdev->listener.name = "virtio";
>>>               memory_listener_register(&vdev->listener, vdev->dma_as);
>>>          -    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
>>>           }
>>>
>>>           static void virtio_device_unrealize(DeviceState *dev)
>>>          @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
>>>                   vdc->unrealize(dev);
>>>               }
>>>
>>>          -    QTAILQ_REMOVE(&virtio_list, vdev, next);
>>>               g_free(vdev->bus_name);
>>>               vdev->bus_name = NULL;
>>>           }
>>>          @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>>>               vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>>>
>>>               vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
>>>          -
>>>          -    QTAILQ_INIT(&virtio_list);
>>>           }
>>>
>>>           bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>>>          --
>>>          2.39.3
>>>
--------------xiUhlLjWCohfxmaOO0alWmsg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>
</pre>
    <div class="moz-cite-prefix">On 6/27/23 07:23, Jonah Palmer wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:006e8923-d73b-b6be-fccc-a26b3e98e811@oracle.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">
        <pre>On 6/26/23 08:16, Michael S. Tsirkin wrote:</pre>
      </div>
      <blockquote type="cite" cite="mid:20230626081522-mutt-send-email-mst@kernel.org">
        <pre class="moz-quote-pre" wrap="">On Mon, Jun 26, 2023 at 08:08:28AM -0400, Jonah Palmer wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 6/23/23 01:47, Michael S. Tsirkin wrote:

    On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:

        The virtio_list duplicates information about virtio devices that already
        exist in the QOM composition tree. Instead of creating this list of
        realized virtio devices, search the QOM composition tree instead.

        This patch modifies the QMP command qmp_x_query_virtio to instead search
        the partial paths of '/machine/peripheral/' &amp;
        '/machine/peripheral-anon/' in the QOM composition tree for virtio
        devices.

        A device is found to be a valid virtio device if (1) its canonical path
        is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.

        [Jonah: In the previous commit I had written that a device is found to
         be a valid virtio device if (1) it has a canonical path ending with
         'virtio-backend'.

         The code now determines if it's a virtio device by appending
         'virtio-backend' (if needed) to a given canonical path and then
         checking that path to see if the device is of type
        'TYPE_VIRTIO_DEVICE'.

         The patch also instead now checks to make sure it's a virtio device
         before attempting to check whether the device is realized or not.]

        Signed-off-by: Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com" moz-do-not-send="true">&lt;jonah.palmer@oracle.com&gt;</a>


    Could one of QMP maintainers comment on this please?


        ---
         hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
         hw/virtio/virtio-qmp.h |   8 +--
         hw/virtio/virtio.c     |   6 --
         3 files changed, 82 insertions(+), 60 deletions(-)

        diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
        index b5e1835299..e936cc8ce5 100644
        --- a/hw/virtio/virtio-qmp.c
        +++ b/hw/virtio/virtio-qmp.c
        @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         VirtioInfoList *qmp_x_query_virtio(Error **errp)
         {
             VirtioInfoList *list = NULL;
        -    VirtioInfo *node;
        -    VirtIODevice *vdev;

        -    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
        -        DeviceState *dev = DEVICE(vdev);
        -        Error *err = NULL;
        -        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
        -
        -        if (err == NULL) {
        -            GString *is_realized = qobject_to_json_pretty(obj, true);
        -            /* virtio device is NOT realized, remove it from list */
        -            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
        -                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
        -            } else {
        -                node = g_new(VirtioInfo, 1);
        -                node-&gt;path = g_strdup(dev-&gt;canonical_path);
        -                node-&gt;name = g_strdup(vdev-&gt;name);
        -                QAPI_LIST_PREPEND(list, node);
        +    /* Query the QOM composition tree for virtio devices */
        +    qmp_set_virtio_device_list(&quot;/machine/peripheral/&quot;, &amp;list);
        +    qmp_set_virtio_device_list(&quot;/machine/peripheral-anon/&quot;, &amp;list);

    How sure are we these will forever be the only two places where virtio
    can live?

A virtio device will always be considered a peripheral device, right?
Since peripheral devices are input and/or output devices by definition.

        +    if (list == NULL) {
        +        error_setg(errp, &quot;No virtio devices found&quot;);
        +        return NULL;
        +    }
        +    return list;
        +}
        +
        +/* qmp_set_virtio_device_list:
        + * @ppath: An incomplete peripheral path to search from.
        + * @list: A list of realized virtio devices.
        + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
        + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
        + * to a given list of virtio devices.
        + */
        +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
        +{
        +    ObjectPropertyInfoList *plist;
        +    VirtioInfoList *node;
        +    Error *err = NULL;
        +
        +    /* Search an incomplete path for virtio devices */
        +    plist = qmp_qom_list(ppath, &amp;err);
        +    if (err == NULL) {
        +        ObjectPropertyInfoList *start = plist;
        +        while (plist != NULL) {
        +            ObjectPropertyInfo *value = plist-&gt;value;
        +            GString *path = g_string_new(ppath);
        +            g_string_append(path, value-&gt;name);
        +            g_string_append(path, &quot;/virtio-backend&quot;);
        +
        +            /* Determine if full path is a realized virtio device */
        +            VirtIODevice *vdev = qmp_find_virtio_device(path-&gt;str);
        +            if (vdev != NULL) {
        +                node = g_new0(VirtioInfoList, 1);
        +                node-&gt;value = g_new(VirtioInfo, 1);
        +                node-&gt;value-&gt;path = g_strdup(path-&gt;str);
        +                node-&gt;value-&gt;name = g_strdup(vdev-&gt;name);
        +                QAPI_LIST_PREPEND(*list, node-&gt;value);
                     }
        -           g_string_free(is_realized, true);
        +            g_string_free(path, true);
        +            plist = plist-&gt;next;
                 }
        -        qobject_unref(obj);
        +        qapi_free_ObjectPropertyInfoList(start);
             }
        -
        -    return list;
         }

         VirtIODevice *qmp_find_virtio_device(const char *path)
         {
        -    VirtIODevice *vdev;
        -
        -    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
        -        DeviceState *dev = DEVICE(vdev);
        -
        -        if (strcmp(dev-&gt;canonical_path, path) != 0) {
        -            continue;
        +    Error *err = NULL;
        +    char *basename;
        +
        +    /* Append 'virtio-backend' to path if needed */
        +    basename = g_path_get_basename(path);
        +    if (strcmp(basename, &quot;virtio-backend&quot;)) {
        +        GString *temp = g_string_new(path);
        +        char *last = strrchr(path, '/');
        +        if (g_strcmp0(last, &quot;/&quot;)) {
        +            g_string_append(temp, &quot;/virtio-backend&quot;);
        +        } else {
        +            g_string_append(temp, &quot;virtio-backend&quot;);
                 }
        +        path = g_strdup(temp-&gt;str);
        +        g_string_free(temp, true);
        +    }

    I don't much like the string operations. We should be able to
    check object types instead.


I don't either but in order for us to check if the object is a
virtio device type, we need to use the device's path ending
with '/virtio-backend'.

If there's a better method to checking this though, or perhaps
checking a different type, that doesn't involve string
manipulation, then I'm all for it.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">TYPE_VIRTIO_DEVICE ?


</pre>
      </blockquote>
      <pre>Please excuse my ignorance, as I'm probably missing something here,
but how can I verify a device is of TYPE_VIRTIO_DEVICE without using
a canonical path ending with &quot;/virtio-backend&quot;?

Initially, when the query begins, I use 'qmp_qom_list' to generate a
list of devices under &quot;/machine/peripheral-anon/&quot; and
&quot;/machine/peripheral/&quot;, e.g:

	- &quot;/machine/peripheral-anon/device[0]&quot; (virtio-serial)
	- &quot;/machine/peripheral-anon/device[1]&quot; (virtio-scsi)

Without appending &quot;/virtio-backend&quot; to those paths, which are virtio
devices, checking if the path is a device of TYPE_VIRTIO_DEVICE would
throw an error and fail via. the following:

	Object *obj = object_resolve_path(path, NULL);
	object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE);

With these path (without &quot;/virtio-backend&quot;), we could check if it's
of TYPE_VIRTIO_PCI, but not all virtio devices are PCI devices
(e.g. virtio-mmio).

This can also be seen when qom-get'ing the types of each path:
--------------------------------------------------------------
{&quot;execute&quot;: &quot;qom-get&quot;,
 &quot;arguments&quot;: {&quot;path&quot;:&quot;/machine/peripheral-anon/device[0]/&quot;,
               &quot;property&quot;:&quot;type&quot;}}
{
    &quot;return&quot;: &quot;virtio-serial-pci&quot;
}

{&quot;execute&quot;: &quot;qom-get&quot;,
 &quot;arguments&quot;: {&quot;path&quot;:&quot;/machine/peripheral-anon/device[0]/virtio-backend&quot;,
               &quot;property&quot;:&quot;type&quot;}}
{
    &quot;return&quot;: &quot;virtio-serial-device&quot;
}

So, in short, I'm not sure how I can check if a canonical path is to a
device of TYPE_VIRTIO_DEVICE without its path ending with &quot;/virtio-backend&quot;.</pre>
    </blockquote>
    <pre>Any updates on this?
</pre>
    <blockquote type="cite" cite="mid:006e8923-d73b-b6be-fccc-a26b3e98e811@oracle.com">
      <pre>

</pre>
      <blockquote type="cite" cite="mid:20230626081522-mutt-send-email-mst@kernel.org">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">        -        Error *err = NULL;
        -        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
        -        if (err == NULL) {
        -            GString *is_realized = qobject_to_json_pretty(obj, true);
        -            /* virtio device is NOT realized, remove it from list */
        -            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
        -                g_string_free(is_realized, true);
        -                qobject_unref(obj);
        -                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
        -                return NULL;
        -            }
        +    /* Verify the canonical path is a virtio device */
        +    Object *obj = object_resolve_path(path, NULL);
        +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
        +        object_unref(obj);
        +        return NULL;
        +    }
        +
        +    /* Verify the virtio device is realized */
        +    QObject *qobj = qmp_qom_get(path, &quot;realized&quot;, &amp;err);
        +    if (err == NULL) {
        +        GString *is_realized = qobject_to_json_pretty(qobj, true);
        +        if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
                     g_string_free(is_realized, true);
        -        } else {
        -            /* virtio device doesn't exist in QOM tree */
        -            QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
        -            qobject_unref(obj);
        +            qobject_unref(qobj);
                     return NULL;
                 }
        -        /* device exists in QOM tree &amp; is realized */
        -        qobject_unref(obj);
        -        return vdev;
        +        g_string_free(is_realized, true);
        +    } else {
        +        qobject_unref(qobj);
        +        return NULL;
             }
        -    return NULL;
        +    qobject_unref(qobj);
        +
        +    /* Get VirtIODevice object */
        +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
        +    return vdev;
         }

         VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
        diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
        index 8af5f5e65a..4b2b7875b4 100644
        --- a/hw/virtio/virtio-qmp.h
        +++ b/hw/virtio/virtio-qmp.h
        @@ -15,13 +15,7 @@
         #include &quot;hw/virtio/virtio.h&quot;
         #include &quot;hw/virtio/vhost.h&quot;

        -#include &quot;qemu/queue.h&quot;
        -
        -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
        -
        -/* QAPI list of realized VirtIODevices */
        -extern QmpVirtIODeviceList virtio_list;
        -
        +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
         VirtIODevice *qmp_find_virtio_device(const char *path);
         VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
         VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
        diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
        index 295a603e58..83c5db3d26 100644
        --- a/hw/virtio/virtio.c
        +++ b/hw/virtio/virtio.c
        @@ -45,8 +45,6 @@
         #include &quot;standard-headers/linux/virtio_mem.h&quot;
         #include &quot;standard-headers/linux/virtio_vsock.h&quot;

        -QmpVirtIODeviceList virtio_list;
        -
         /*
          * Maximum size of virtio device config space
          */
        @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
             vdev-&gt;listener.commit = virtio_memory_listener_commit;
             vdev-&gt;listener.name = &quot;virtio&quot;;
             memory_listener_register(&amp;vdev-&gt;listener, vdev-&gt;dma_as);
        -    QTAILQ_INSERT_TAIL(&amp;virtio_list, vdev, next);
         }

         static void virtio_device_unrealize(DeviceState *dev)
        @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
                 vdc-&gt;unrealize(dev);
             }

        -    QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
             g_free(vdev-&gt;bus_name);
             vdev-&gt;bus_name = NULL;
         }
        @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
             vdc-&gt;stop_ioeventfd = virtio_device_stop_ioeventfd_impl;

             vdc-&gt;legacy_features |= VIRTIO_LEGACY_FEATURES;
        -
        -    QTAILQ_INIT(&amp;virtio_list);
         }

         bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
        --
        2.39.3

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------xiUhlLjWCohfxmaOO0alWmsg--

