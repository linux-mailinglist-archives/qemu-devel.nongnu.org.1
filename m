Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F27F74842D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:30:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1cb-0005nZ-S5; Wed, 05 Jul 2023 08:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1qH1cV-0005n3-VQ; Wed, 05 Jul 2023 08:28:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1qH1cT-0000x5-IF; Wed, 05 Jul 2023 08:28:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3655uP8e018975; Wed, 5 Jul 2023 12:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=C1/tYLvV3idKTnFH38kTH+ZBFmWm4aEpT+/QS+G171E=;
 b=ZG6KTsRsFcTW+3VD4N0+meaaxoSwFaWXOVb9liXnG+tV1qNb/bWBHKy+6XpvhNRs2RNC
 pkYGjBECDheSKifv4hnccfKUaK2byzdS/zVPSWnFq1MXAqfSKQjUROC5pNFLLI7LGAF4
 EKoSZtShKBWtvQYUiWfiu56wBDu/e4X0pTTRTDhelhNeO58g/NTEdWQ9eOzO9GRn3ReB
 73afGrzPs1s45/cW6d46t5DKeV0MNpQu4Sp9cVjEImO6V3w7Us/hJZ9/AmWrkbIIpqOe
 LLl+lIzRuAt5bOe1SiMfBwP4x+Y8Byiopb2PlJq/xEtMMOyLinbqwsUDeal0WwxiqXfo AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjajdea28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 12:28:17 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 365BUXfO040312; Wed, 5 Jul 2023 12:28:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjakbjbgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 12:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhIDb8+R5cG+HVB9/WHUtUxtVTtorTjfCNDtiEuMGkehLMqJgbSUW4BmFgbXf/PgooTizy2c86KZtFrrwF7vnccnVWZOzIe6rUIQWgb040tkSqda14s9AEW7yhM2JbukuI2jZpgSJJqiDEUrFoBd7tzqWpbFaewQ6nweJIkvPnA/UUfaa3YbFsenhoBCwDwc+7QVNKxDOeMlzZpQOlscjM3mfWl9kdZqMiVt4PehVz11tg0V/kXS6JdV9OP1GDrcMleY5JpqL1lKCHEb2d1Lh9JmjZlXkkeSKVbDDr2txDbtlbE2AMLqy0Kta9lmSokiIPQ72lAsJVafFjiSaOptcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1/tYLvV3idKTnFH38kTH+ZBFmWm4aEpT+/QS+G171E=;
 b=BAWUtiF4tVgCIVqsPW6TenMapNraYMkCtvwAmEmDdleTc/+rh9Gkxy9OjJgzrNV8imOPLKQ0qQIJad/+au2ZY5Ykmfo6a0K10GmZV4wGB5czurGYQCVOabvUPN3n8pcDF375e0/MTFaLvGcbzIK67Jukw7pQonJ9LpPrq+RIMltXVYjKT09Q7MDgPnun93WECvphWLsjp3KpEX33MxRrs7lH/51+q/BGM5VtCtxLo53U/9nSL4WwBptYWRx6kVwEAQCkCfio4ulIwcUNsj5qy/Lz+nsAziS1dhVubqvUmUxV0jPHMATB23/zJW2Ft6nxdI1DA8r1IghCQOlzAQh1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1/tYLvV3idKTnFH38kTH+ZBFmWm4aEpT+/QS+G171E=;
 b=vqo4XWbPLjqHiV4rCJGQiVLIaWLmN5+uzQuvmYG8WHmJxRfsdzrTjbnseqexh703uxR0mQh6zT90mEge+V86XQI8T9UzivO7DOtxziZe4euHzqqnrTL2QZJAF24cQ2xUTk7ulji5kqHgRysm7qVFHrnK4JstjEb23hD0atS+TPA=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by DS0PR10MB7320.namprd10.prod.outlook.com (2603:10b6:8:fe::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 12:28:08 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::915d:8c59:a23b:7b42]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::915d:8c59:a23b:7b42%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 12:28:08 +0000
Message-ID: <3adcc3c3-c0ba-0810-10b6-b13ac36a5de9@oracle.com>
Date: Wed, 5 Jul 2023 07:28:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org
References: <20230705071523.15496-1-sgarzare@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <20230705071523.15496-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::6) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e41276f-a4d7-48b4-edd6-08db7d534a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuAkCT/XF2ycfcAk1JqNj72aLUKHEwTT1+aHa/lnF1wXinHsemY/n0wTqglIH7BGVVw0FTH7Sq0zMSyHJL1ACmq8EdAFDukRbPZOzOEL4t6Zp3CnRX9oqom4D23j9GZhjv+pvaXGWnnJmpplUmThoxGTkxmyrYduyIXxO3tHqQSHYXuR1neCHubfaG7Nz9XcBw7HIpQzVM8s8JlxIxZf7P6n3AfuwbzKEsZFoEo1DYM670B9FPi0PygwSzWD6zGlQnfZMYsuyX4dTgVwz+cWozlJjfj5+0KqHRsJMAubAeWs0d8nOst+edWuXcMMmT30Vmw62WojBd21y7SHWxD23A9dTtYx2cbhZahRawAzOA9E4aSB08HjC4S6TFLptH2YouwiD8AMqdXnTOOPfQxqLqvMM42Hk0/Ocm6NdkQz9LRep8kQVVBYPsesz7PaNmqq6LXTqbF0WvlvMSIxJNWW3GJUOnPL6f1AVemyMpNuDLKFG89mAmT/If0hJest27vWRYxqGh01NnE+iV22VZEHSYByTi7uE5IGIRsMkor1JT0VkqFg0Q2kV91THWOaQWDEAcoaiymwfWRNm2e3kpNSSLTgKcCnNz6fNYbiU8197HOhRxLampHSsx1y2Fdx992Vyvzns9tzgTn0LG2uQTcbQCw0f4F4E1WeFYGxADTcFhLPm7xJ0je2xVUOny57XmQt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(36756003)(31686004)(86362001)(31696002)(44832011)(2906002)(5660300002)(6512007)(966005)(186003)(83380400001)(6506007)(26005)(53546011)(6486002)(54906003)(4326008)(66946007)(66556008)(66476007)(38100700002)(2616005)(316002)(478600001)(6666004)(8936002)(8676002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3RnZWhhUzlTYXdHWXgweHc5bEhoWGV1SUpMTHJoM3FNd3ZVU1JoS3dNaHoz?=
 =?utf-8?B?Uzh4Y1dPWDcwQ2JXbnlHVTVBNTdWaHozUkVxREJiYlNyeklWUGdwQ3dvbGFs?=
 =?utf-8?B?YnVSblMrUnhJcmo1WVU2U2FPckt4Z0lXVElNUWR6ekh3dFg1dzdaWDRSbS8r?=
 =?utf-8?B?b0RwZHF3azVYYXptNzRWN012RDBpemlJRUM2RUR2WHIzYmpIUjN0Y2dlNHRK?=
 =?utf-8?B?TjRmdnl0SGdIZ1YrNVFsR2FFakllVDU2WXpnOUpSNXdvTWdCcUhWcTVQa0Ns?=
 =?utf-8?B?aFFURWdPTUtuODFqTXZuRm8zcktRTEpqMDlaTUtrVEQ1T1BFQkQrMFROSkwv?=
 =?utf-8?B?VVF0WmcwTHFRUm5nYWMzOTBSd1kwUHlTcHhSQjViQjF4SGV2Q2NQaDBHWGRM?=
 =?utf-8?B?SVRqU2xiSmRnZkdHNnZtWm9MUGR5RzdTcUVZWSt0MHZmN3RhNjlyQUFQMjFS?=
 =?utf-8?B?RGlHOE81U1hvMTE1Ym1JajNBQlNjQVBkL0VjTmhhaDRwL0ZSMG1rdHp0bVBE?=
 =?utf-8?B?L3UyKy9HY3JYSXc1UGVKT2prR1BOZndYemdpZFhqZEpzRWt6OFNQVkxJSElW?=
 =?utf-8?B?RlB5YWt1MzNmV3N4SDNzTzN4b0RidjdXWUdEeG1pVlNOTWRIdnRjUmZyS3ZI?=
 =?utf-8?B?ckR4NXFMNVpTK05VRUlDQmJTd2Joc2cxZU5sM295VStVZDFYTndzMmtpd1FJ?=
 =?utf-8?B?WlpsV2FyVktUTUZ3d0FaVlhMYU9wRXpXTVc4TzNJU0ZFVkw5a3c5VVBBZW1i?=
 =?utf-8?B?WjVJQ2tyUFIrMDdFa0ZSNTFyUCtzZVdxblNTSHAyeEsvZ1o5d243Nm0yME5U?=
 =?utf-8?B?YmJEY2ZOWFZvejdsem5Ca1YrdS9ZWXJETU9jNlVUeHZTZktMbmExS2loMUla?=
 =?utf-8?B?NGdRQndPQnJmdkw5ZTdoRjdWYlBKWk90dWRVVDhGUVpmV0hMdjFRRFlMSUZH?=
 =?utf-8?B?OW4yUDdkT25vbThwTm54UXdtQ01SbG9DNW9KTjN3bHBLbG9mUmV4MWcyRWRS?=
 =?utf-8?B?L1BLc3hGbVNhNXJZRC9SUHUrcU5UWS8reS9Jcngyek9vSUdxWmx1cWVkKzE5?=
 =?utf-8?B?bUxETmxsSTlKWmQ3U0czS1Q5S0xGVVdRRUppamkxRDVseVplQnNrSmlHT1BU?=
 =?utf-8?B?aFJ5WUVaaFV5V1NhWHQ1NkdzQWJCc20yVTFVYzM1NkVab2VxdW1IVkxVZnFK?=
 =?utf-8?B?N21LZzlpa3BlRzRRODh0SkhCRTNQS0FvcTdYNGdyQlVJdERwVDYxYXR1MVpk?=
 =?utf-8?B?OFFJcCtNREFiVTF0cXdOdHJSakUzTmFCdFFJT0QybWxhdTFqRDhmaWxmcE9M?=
 =?utf-8?B?V05kL2dzcFNBUjEyRGtNbEFZaGd3aHV5dzhWWVVYd0JHanZNNTQ2Y1c4QWg4?=
 =?utf-8?B?TVQzd1RyMjQxVTBKQ3A3MHdsaGlwdTRLZ1I3eFpONE5zbGgwNVhCbGZ6U0ht?=
 =?utf-8?B?dEdkVU5NVGJtQlNLMXh6VUNnV2lKaUFZNG42UzFtQUIrTHRhM1VYQzUzck5F?=
 =?utf-8?B?dTVER2ZaSXlYWTFaak90V3d2WDM3YjBIdjR2Tys0bmpqTTc4UUUzTkl6ZzRH?=
 =?utf-8?B?MHVIOWNXNWtvclBHT0g0Y1BSMjNyR0NJSENTQ3phN2JCUUJmMlpLenNGSE5o?=
 =?utf-8?B?V1U0U21NVEZISXZWdjFvTzJubTR1WUJabm9QQi9kMFNLdzNGZ1Nic2ltbXli?=
 =?utf-8?B?Vzh2N3JlL09ZR0ppbU5JUk5PYkZSa0tuME0yMk9PL1U1VXRKbGVLcDVZb2cr?=
 =?utf-8?B?RzRuR3FRZjEvZVM1OHRGdUdKcGovTXV5enRYNmVTZ1RrUmIvdlZ6UmJqeUNK?=
 =?utf-8?B?M08yU2Z3WE5Hd0Jld21hdHZWRW5NZmlUWHNkV1Y1d0tycllzZUlSQzg2eDZK?=
 =?utf-8?B?Sk5mUksxamQ2eHB6V0ZPZEdmdTZmMWVYa3U2bmFyaU5ydWdsOWc4Y2kyN2to?=
 =?utf-8?B?bklHcWVtaFAySE5KUDl4Sk1Icnp5RGVTR25lcWRzbVJFM25JaE9rSmtsMGUx?=
 =?utf-8?B?dEpOZHIzVHA1clNhd3lJRUZRTkxHTmg0ZlQ3SEI2enNBK3ZVY29pMGxFVDlH?=
 =?utf-8?B?OUFxQkJVVm01WTJVeXpBNURBUGVheUFJZU5FTGswTURGN2cwWGpHdEVGMWZt?=
 =?utf-8?Q?tVsUGskY2Lt9eg3oQEa+BY2/k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CQBq/fwchxdVlRmpHN/gnKhg8Db+jm5Q3ceRZas9jRblh3zI6wha6+Y1gEUD/M+ufnd+j6lMB9eAgSQPWkcnZnigjcgNanYXddpqTFEQNFojJyhYt9+rG4hYFQH8Sw3hKCnyv60D8C8eYpWoH4nDx5ubefSCGPPHte+rtPAlFrkUhcB5h1V/bbh53GBkabO1kF3LTS8nIthZj24memWTDgV4sVHr/nbNW7ok2OLqcYnRXEo7vfeGBNzWIvj2khpx/8s9sZvDvOCh1wyKuGBKOHEOk0tzpqCSkMUAzQsP5NYsot2TkUfoe3Ic7jQZcV40VWeVXm5aErOMkbv2MEVJU7ZL95/4dewNvU7opBildarNdtgmH62a4ukNXTqnFkgXXqicHqeuwdhW0f2vjjHkJcuSvwisXjR+W3S5KJCWxN14X9qVo87kfqI+zBKCAZcaCzzQXoSd7lJRbt7ouqf0fs2mBcXAd8ATDOkIf38sA7aiR7Jpbj1ukwvlvCryIiHPjqs9efTavLu+ceW2RSM9+QhMr07UnFBgvAwNINVG7ADqN3EmBeNuCbgVj9FwqCm0Q9mlSwMVIFjnGSEHiPVay8XgBwTb4w0a9xmoWQz6lfUumEOOHKGNW+b8rkONMlCcXnKtjDvmMoHQmzeB/6knZouTp+UhL2Ca3QROy5KjEEWLlssweudilZ4KHbTg1VwDfpvUlvinD+bmJQpr9B0JLkJaq+1LLKFcTriXMjHBJRlfxxiv+hUza6WuBiY66YqLW+tGI8WsECr+UD6sWJCx4gEksZyTDvrktxL3Op04n3rFS1CUzkOSE2J2Y29J2vFX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e41276f-a4d7-48b4-edd6-08db7d534a1a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:28:08.3578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44tCtmHU5U04LpmNYqW+/8Kh2RgGdKwKsQx2UTLnUUqP/jXBmBjyMIfpK5mbEqxSlZoyqHJFV9pFTZfjpPQiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_05,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050111
X-Proofpoint-ORIG-GUID: e75nuGT2JJ7W8wyEJhFXYVmDjVUkbQ65
X-Proofpoint-GUID: e75nuGT2JJ7W8wyEJhFXYVmDjVUkbQ65
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/5/2023 2:15 AM, Stefano Garzarella wrote:
> This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
>
> That commit causes several problems in Linux as described in the BZ.
> In particular, after a while, other devices on the bus are no longer
> usable even if those devices are not affected by the hotunplug.
> This may be a problem in Linux, but we have not been able to identify
> it so far. So better to revert this patch until we find a solution.
>
> Also, Oracle, which initially proposed this patch for a problem with
> Solaris, seems to have already reversed it downstream:
>      https://linux.oracle.com/errata/ELSA-2023-12065.html
>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> Cc: qemu-stable@nongnu.org
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>

Thanks/regards,
-Mark

> ---
>   include/hw/scsi/scsi.h |  1 -
>   hw/scsi/scsi-bus.c     | 18 ------------------
>   hw/scsi/virtio-scsi.c  |  2 --
>   3 files changed, 21 deletions(-)
>
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index e2bb1a2fbf..7c8adf10b1 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>                                         BlockdevOnError rerror,
>                                         BlockdevOnError werror,
>                                         const char *serial, Error **errp);
> -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
>   void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
>   
>   SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index f80f4cb4fc..42a915f8b7 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
>       return (sense.asc << 8) | sense.ascq;
>   }
>   
> -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
> -{
> -    int prec1, prec2;
> -    if (sense.key != UNIT_ATTENTION) {
> -        return;
> -    }
> -
> -    /*
> -     * Override a pre-existing unit attention condition, except for a more
> -     * important reset condition.
> -     */
> -    prec1 = scsi_ua_precedence(bus->unit_attention);
> -    prec2 = scsi_ua_precedence(sense);
> -    if (prec2 < prec1) {
> -        bus->unit_attention = sense;
> -    }
> -}
> -
>   void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
>   {
>       int prec1, prec2;
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 45b95ea070..1f56607100 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>   
>           virtio_scsi_acquire(s);
>           virtio_scsi_push_event(s, &info);
> -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>           virtio_scsi_release(s);
>       }
>   }
> @@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>           virtio_scsi_acquire(s);
>           virtio_scsi_push_event(s, &info);
> -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>           virtio_scsi_release(s);
>       }
>   }


