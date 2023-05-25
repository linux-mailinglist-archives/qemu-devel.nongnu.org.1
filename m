Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10829710D52
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:37:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2B92-000531-1c; Thu, 25 May 2023 09:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q2B8x-00052Q-81
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:36:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q2B8m-0007b9-BS
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:36:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PDEn9u009186; Thu, 25 May 2023 13:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2UG25+ba87yJ/TYVS4V/FkDvXWQdVAy1vCMgTMOHsYQ=;
 b=dijhTZaCGztmfLsWIpOiOgesiYr5BpUqu/FV11zS1v56K0lIDt0yiHjlS0xIYYb92bO5
 EBNinB3BrlHnMNhj+IDKWAqNz+5K6bcPfY9CN73c5EdX4bGl8ht/XFkAqMWtfpAwg4ID
 d6eI9KHOYxboXqN701tipKz8Uc3E+S00Fw13ofw7gjI7XrXzQnCn8YhC8wBvvs1Dtk+4
 RI2hXOQLWnk1jpz5CBPaOU1LUhRqK3Zb+eZoD1IYGG5xz1Y8u6QlBQ6qcYzc9Garsjaz
 CSaXMR/vGjjY+UwQixYlTGDzFdqJQXUnoQrqq/OErW9fOWFIYYVsASte+JS5DV9pzoLJ iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qt8csr290-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 13:36:24 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34PCuHNc028934; Thu, 25 May 2023 13:36:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2dmxnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 13:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj1cf+BjUHnysGvY7lwXVTjnUGYe1QOdpof6Dz/t/vCUcp8d9Y9iovqsPXB4HarHdNtwuYoCvlAu8i7x0XggXXnm/GO6IULHbiIRUxz6SF9Src+R0OHvmflwxvtsKqK63M9nSNHlRu55AUi1B2UIve9BcthZWG1NGqA5fQn1IMBlZttPbtYoGdfPLRcxLMEzdxIR4/4Fg9snjD5Z8OFOubRHiDa8dvnLGhbTlX3Qlt6zx/IjkanJYV07m6Q0YWL19zJn+ZjiR6tyQ/xVOp1SNXkmhnX2ffZ10464YMzGCXVB1IAzt1fPnreSX8iUms63IsnbGm/jDziIiHWgExR7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UG25+ba87yJ/TYVS4V/FkDvXWQdVAy1vCMgTMOHsYQ=;
 b=I1OjhQKKsxPupHMgf2GZT0Tj11IeNUXLNpuWBxNaVeVLwtsHKFGVW32y3O+zp3uNb88e09j9gMBQiye+2kw281fjzdPlQjQiOpbdB3Wf84dLdGwIGwCsiOoyupGtsd9xz5BT5PduoeJ8ZksoeW4hsBKfU18Ja/mQQGVmNDkuGnZxTpY12jC8Ee/H5M3OlLeXgiJbVvpCzEx6TzZAzv09aQCUSA+TSkPrTQrDWa9Pd6DV8hrE6gbhzWdYTYitMUPOTXKhNrS8uCBHN0HPjK7fcMi/DuhtsE2picQRV6CmSiOOdfLsf9QfDntAJKJeee2rHmSoaM0igJkZlhptHNEJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UG25+ba87yJ/TYVS4V/FkDvXWQdVAy1vCMgTMOHsYQ=;
 b=VPMspRdjSOEtvV7rf7kQ8G/bUfQknM8K8fkaLnhthLCJIt1Wywr+68iu/rnABA6bosUvwf2/8ZV8NpJiXRuYa383iIZtJ8t2WwYPN9xgODATUCUPe+iqTDJzZtNeDzTe3EAVrLP+l24O2ih4eJNU7KavGZV21nseUefjbNuui0Y=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH0PR10MB5227.namprd10.prod.outlook.com (2603:10b6:610:c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 13:36:21 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%3]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 13:36:21 +0000
Message-ID: <d7ad37a1-37d4-6ff9-2168-3a4ce2aeb59c@oracle.com>
Date: Thu, 25 May 2023 14:36:15 +0100
Subject: Re: [PATCH v2 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
 <20230525114321.71066-3-joao.m.martins@oracle.com>
 <f161aafa-6613-1f4e-4f0e-f426f760787b@linaro.org>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <f161aafa-6613-1f4e-4f0e-f426f760787b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0234.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::11) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH0PR10MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6d0e20-ae4e-4ae1-e6a7-08db5d2506aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wal8VU6kC72+wgP/4RQqBI8AyPqY5fFlioXSAWUKGsCtCxw+D58iR1ZphyML6M7cafJZtMl1rO2fXnq9SlAk7ITCfdbAyX9adlDTAvgLwSU9IdXgmLRrFjK5ana1+lln9JE3NYOH09VG4z7z3kfNcE/CU/WZQtu8Fclx+avw8uPLnx+jSLspW0YbelONeyEiwjLSvjcHFwIjLRV4YYOZRii7KXxzAaccPzTCNnrf1i9HCQlHDHQVErAu3iosYguieToV1ibFo9V5BxO9JrejTrOuIVicQsnQWJzlYdSMsFCd97DOg6jU5iIRlLigeigs/Nu68GvLbDEUI0jzjeTGIWeq085da19JOftIF7RxOuXcP6RGQJn0JEcjUeI8kZ8FrjwuFFUGAa76R6wxL504BSPL5PQy5F/WZMYgX0MZM25PoZqhMlYDNhObOLZD3/K1bT73mFhv+qTY35gKHnRM/liTDkgyInBuR5ZJsN5uA6M45Iv8dfRRTLojbBHSNPeUAt0ESavEf1pg2U3SL1JtruLzcUjiBLY8U9PRMQvHXp6O+0DWw9UDJfC/rubxAnRENbGXpHl1fHXGOn5DVWFNa2mv0keV+g95Ztn0QxWWRPhS1PTHJ3mJPRVPOhRH5xuLCZZPJoQzaQ6bP2ckUD0yMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(31686004)(6506007)(6512007)(41300700001)(8676002)(8936002)(186003)(2616005)(26005)(53546011)(86362001)(36756003)(4326008)(2906002)(478600001)(66556008)(6916009)(66476007)(66946007)(5660300002)(54906003)(316002)(83380400001)(31696002)(6486002)(38100700002)(6666004)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dNaXVyNktqMS80QW9ndGsxUHVxRXpQZzF6MFFQY1YyMVZhZ0QyQ2ErQ01B?=
 =?utf-8?B?cU9hN3YyNlFlRVFCeEs3bTFwcFUrdkpicUMrMzJRRkxrVkVRdllaRmtUNkRN?=
 =?utf-8?B?S3paVW05alc3dzJFRHdPOVVldk5ycXpaa3FRbllrc0tkeFVLK0pzVXUyQUtO?=
 =?utf-8?B?UXprTzk1aWlPZHkyNmk2ZFF3ZkJDVVJSQmhOaTUvZFBnbFdaS0o2bmNsazNL?=
 =?utf-8?B?dWF1VHRFcVRnRUdQMWNiU0JNQ1pGZkdTZEVtYnJraVNVdVozQ2JrbitlQkxS?=
 =?utf-8?B?dXo5cW1TM1NSV3R3a0FBVW1xdVk2ODhxUVIxVElCSGZVRnZwNlNVelZyUDNn?=
 =?utf-8?B?ZEZNZ1MxNHNvSDI4TDE4cU95WVYvTlZzVGdDOVZBd09saE5DSFkxQ1BRWEp3?=
 =?utf-8?B?ZjlHell0aTBpYk8xZXpqTW1TdzIxa1JMeExFdFRtNVFVaUovd0RudWEzVnc1?=
 =?utf-8?B?Q1ovdzV1c09kU2RBV2tjakgxeDgwcXNiaFBNb2UyN3htMjVTRDFFbkRJVG1K?=
 =?utf-8?B?QzV4d0FCTmNxQk8xQXMrSldzaVBXWERTMGdLZFRPZjR2VEVGaUN2S3AycmRC?=
 =?utf-8?B?K3QzZ0l4ZzRwMzJzeVV0bzhQWTZBZUttclNxRmNoZUY2ejJSd0ZUNHQzZjNJ?=
 =?utf-8?B?bWVWanMyaktjN1pkOGNwUE95TTlUM2JwWW1lWWE0MUNSOTlVclQ1dlVOcHgr?=
 =?utf-8?B?TnluQ1BNcDRtd21CRHpQM2k1S1k2dlJFVXB0NHBTVGdoeS9CTTFscVBqcVJv?=
 =?utf-8?B?c1Q3UDUzS0p1SXI0VEZTaEJqMmtOdkpGSXJ6VjFZUzA3QXVsRlRBMjIxVFBL?=
 =?utf-8?B?M3Y0RzVUdnhqUG5TejFtOUNQK3NxUHZxSjdhQnRUL1AwN0M3dnRwQWhOdVJS?=
 =?utf-8?B?MDlDZ0dnMzZoZW1wNm5HWnR0TWExYVdKdXNHWjdnY2VtZGtrLzNFOWhVdjNy?=
 =?utf-8?B?RnRxbDFFeW9DcDNSZlViTWpaRFlRSmdtNWozUGpiSjhVZkV3dTRwdmZhVmRi?=
 =?utf-8?B?OU1tNjdvTjlvckpSU2JkcWk5dklhc3pGdHBpY3MveVNDZm9TZkNvMjJnOXB0?=
 =?utf-8?B?LytzUmxFb3ZWdnZHQmJzOHBvTC9KMDRRRWl2VFJsZFcrdnUyWlh6aTY2WjFi?=
 =?utf-8?B?ZHZqcEh1aE91ZkhVUDRxWGlObDZScysrRUNtYjI2Y2ZYdHhhTUVIZEhzUUMv?=
 =?utf-8?B?M1pMV0Rlb0tOSkVCakdWLzdWcUpmZnkyMEhHdXk2Z20wTUkxV09jVG1IQ2JD?=
 =?utf-8?B?ZWdRY2ZiMW4yV050aHlsc1B6K3ZrajBFTTV1VDhrbEJpRnJObTI4ODNDbm9l?=
 =?utf-8?B?MjdFNU9xNXdmaE5NUW95VnREc1I5WDJhcWpFM2lHdnZQcVY1MHJwMUVQY2Vw?=
 =?utf-8?B?RUFyZVl2UVZsa3pnckJRTEYzbjRVWjVJWGxUVTJNazBUUWRPMDQyRWFCOUV2?=
 =?utf-8?B?VlIzcVVrNlNMMU5mUXN3WXB5ajFMNWZzN2hvUVZBeFlVUzhRL1AydkZtQnk2?=
 =?utf-8?B?YzJXbjVuZEp5QWoyQzJRKzdMdUZrMVJNdGNPSnlCcGxPU1IvNGpXeHBXYnpa?=
 =?utf-8?B?MWUvbXZZWVdrb1V0TUk5aTdvNFJDd1hBMmhnR01aRHhyQWpUN09DNUxFRGdv?=
 =?utf-8?B?cEZ1L2FKb2dpWU1aUFAyYjVGM1hrOFJBZ1p5ZkUyZGtCSW4wRFlydGhDQUhL?=
 =?utf-8?B?d3d4U3M0Y2s4WGJtcE9LMGgvVXIrU1dSQThkTGN6SVFnL25zNVJEcm5nR0tn?=
 =?utf-8?B?UVBCTkN0OFZsZzRxMmp0RVBBZ1RkWWUrWko1RXZ2K0dKWUZHNk9tS3IrVDU1?=
 =?utf-8?B?L0s1Q1BnRFg0WTJBUGJpbkxpa1R1VTFiMGc3RFNkMGZVWVppYkloUFBwanN3?=
 =?utf-8?B?RlpXUDVaN1lkV05TVE5jeFNSZnc0Qm94ZmZDWWNUaDUxMkpySENnYkxmV3pu?=
 =?utf-8?B?OXBGbUxodGgzM1NNM0U4dXFReElXTmVPd1BnNkVERGFIUEJTaG5wbXRibHJS?=
 =?utf-8?B?cjlpb09ybGlvL2FFc1JrWDNMWEEzcUpsdjhTYkVoMVFrb1ZpcVdqYzJEc3RL?=
 =?utf-8?B?UkJNRFRqUURvWitqYmVRait4OVRCM2duaXpmL0JrNDN3T09qbDZjRzNIS0ww?=
 =?utf-8?B?bHJxOFEvNVRIb09Vc245RGxSbUhjSEZ1OVZ5WDMrWFZNRll4Z2RqV3FNVTRL?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y6SKY6bPECLk9NsDMuPFE1uCzcAlyg/nTD9OpvWCmMHdGRo1D26VBPdcc2MZOd2SFjdxV4kUUcgXcG1ae+cF4z54WXTjyCKKzq+TzU8V+jyQjBO5NwTU5E1tiLffe/2o29NRwm4YmYloLD2Ccl7tQZrG86vKJYyhAAX4hYM3NRyzgDhhJzedOJF6SFv1rsz1hbbRHa0aKzeRubhIeze4dLA2fRIu3PVEIWhmg5ZmHfL5NjGi1unmCr36Z+NoSUntUEFP8UZEEIN+/iYnylV6DYPF+2VHVia85CYyI+aZ7/QR6k0Sdbw0TjsHBp8oQFHtwW0H/s84SpMqqrtpS6+oattcQP7QbikBi5pKw5lklKtyvyQ+7O2w6pm3GpVLCgEAGIOx6XoE7TVyw8mh9iv9mOS0KclvCelje9A18HvsvhumBpMa/b80ygGPnWrq00z1xkGsfejxXdEoh/OaR/WOdl3O0rjiGYIt/MZkezzlPvAKcc8mlF3fAZkaOLQmDh86qUfUIHXHewCmjkz3zWzDR3b7j0vWv3imGjvCFX3rabOw/yhKuN8xhDmrK2GDzYKanVhQSKamN5DmFjNV2B1Tes72AJgZqb3TihWMCtZlkHTR0Igj2FUNu+LOO24+uWNSQP/FXrwVqoeVZ4h9kq44snuDIpeowll2snCqdbQP1nYTHD/nlzCL14hAf2aLoO3byqG6IGGesUgLH5wr5oKtUNPyWGC0nh5Fg3CABfEauHYxUJdBwYLdJYwCuGvtRcfJcMgPhwm1Ry/dsHoR/UgxX3yZ/sVxoWKPnPCeqI1MZTWESLPNJ+dj/sfPmhZAkN2g3Lny+s+CDoNFF0u9gZ5fWA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6d0e20-ae4e-4ae1-e6a7-08db5d2506aa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 13:36:21.2966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggNhNrHcOfAX0MIyHjngFhWhlX7Y+Y4IgBPjTGnfiAdy3MqGTcUO1Y6KX1MUxuA99BumtuFKXRNwGz+1URaeO81EjFtExKzXQ4MnhevKZEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250112
X-Proofpoint-GUID: 9kbj5c9sd6YdW8ykwNh6j9epHcg2jhAL
X-Proofpoint-ORIG-GUID: 9kbj5c9sd6YdW8ykwNh6j9epHcg2jhAL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25/05/2023 12:52, Philippe Mathieu-Daudé wrote:
> Hi Joao,
> 
> On 25/5/23 13:43, Joao Martins wrote:
>> Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
>> These are fetched from the newly added return value in
>> cpu_physical_memory_set_lebitmap().
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/common.c     | 7 ++++---
>>   hw/vfio/trace-events | 2 +-
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 4d01ea351515..3c9af2fed1b1 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer
>> *container, uint64_t iova,
>>       bool all_device_dirty_tracking =
>>           vfio_devices_all_device_dirty_tracking(container);
>>       VFIOBitmap vbmap;
>> +    uint64_t dirty;
> 
> Could we rename this 'dirty_pages'?
> 
Yeap, will do.

>>       int ret;
>>         if (!container->dirty_pages_supported && !all_device_dirty_tracking) {
>> @@ -1771,11 +1772,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer
>> *container, uint64_t iova,
>>           goto out;
>>       }
>>   -    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>> -                                           vbmap.pages);
>> +    dirty = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>> +                                                   vbmap.pages);
>>         trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
>> -                                ram_addr);
>> +                                ram_addr, dirty);
>>   out:
>>       g_free(vbmap.bitmap);
>>   diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 646e42fd27f9..9265a406eda1 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int
>> index, int nr_areas) "Devic
>>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end)
>> "sparse entry %d [0x%lx - 0x%lx]"
>>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t
>> subtype) "%s index %d, %08x/%08x"
>>   vfio_dma_unmap_overflow_workaround(void) ""
>> -vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t
>> bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size=
>> 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
>> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t
>> bitmap_size, uint64_t start, uint64_t dirty) "container fd=%d,
>> iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64"
>> dirty=%"PRIu64
> 
> Ditto.
> 
/me nods

