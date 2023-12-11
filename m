Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A580CB13
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:32:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgNv-0007nO-D9; Mon, 11 Dec 2023 08:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rCgNe-0007fL-5x
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:31:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rCgNb-000255-T4
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:31:29 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BBC2pJx002466; Mon, 11 Dec 2023 13:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LmgbdSY8p8tOa9VIbYDiK5Z0Xyn89c8Iml3a7h6BFuE=;
 b=YaFA9AxUt/5i2HtT3rGwBKXVQgRr20j1ir+LAfROAZ8Ryl0Nf8lCwgo0mUjFQgUN+rmv
 Y6PU1JHxIyeWaKKHXFrxSygYOFBfV08FbaQ+jo6Xtqu/RQ0zqYu4nYAkXl1yf9ck9ZO6
 aYqTmfnnp8EIDelWpelgb6Tzk5CFVFFEiRcueM8Kb3SWKqfJhcbq2Q6AbruZi9SHQg2i
 l+Gvdupjvo1WqKqJYz/j4T8cq3rr4Q2O2qo2T8fiYM9bJ86ITQU0xVyU/2rH76K4lFv4
 YuHW6HMxMaBz83SybvxbBAzNqAk2ggRa+UiNoJ2D2oyhcRIKUbHFsulErk9hKbpUTYQx eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsuaxt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Dec 2023 13:31:25 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BBCKwwN024461; Mon, 11 Dec 2023 13:31:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep4wp81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Dec 2023 13:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brU6iANSWDgpUkPsDRdJ1gJFtpn4LrE+3XX+et/H2tbMJTaGl7VLBBwiJfJzenhWR+o5kFQLphKqREdXY+x++req7xjv4cPOQ6Gp0AYeeMSWJHO9yoTZuW3FcPdz8NsL00kk+E3xM61BIWbYBFKu7xYGhK/36CMhG8y/ghuzK5NquNLuPQxGZcRKNUp47KHTraiJ9vgzfnd0yMO7sXcEhvyRtr01kBtKMWr13Hta/Uh/cSSSIovW58lchBwURwsUwRTQMySDBNGAI04XX6+sCbtlWIsq7SruTV3YwuBHSLhipnzl2VqsNTxUGOpSovFyHfQycfZyCITEGATwzRv4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmgbdSY8p8tOa9VIbYDiK5Z0Xyn89c8Iml3a7h6BFuE=;
 b=NejmRn8T2DJT+4tc+7cqRfsndZH/Do3M3Z6656Kj/BUnJRqU7GKNJe7fevxXyLE4IOb3BcJuRc+LsTsGlkRamaPgshLhDcDVvQE+UnvlrqvoW2vJUUdbVj4ma1Rxw06ZZcwzSKAOPFc4WatFHcEGkj7Yx1Z0x5o7jbfkqw+aJXdmBey+yaVLNQzkRs2Lvl1LOOfqftuhgT1XfRZPOFe2yTJbOq3d5WcKAQZphRMsnsWTDlsAyf8VqJJYBqR2sV+Y2j0q4KLc+yrCh74+dptl4bwXKnjlGSnGPOAx4dTryOomEzgRiKnCmau4vh+4oxqvyEYY4XUyVDHI09ybSj0g4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmgbdSY8p8tOa9VIbYDiK5Z0Xyn89c8Iml3a7h6BFuE=;
 b=LAznOjPJmSaNCHuzPij/EDfIcUlH9zcx56UUO4HRNAYpY55OfOf45CgBA/TyUPzj7+JzjdXQnZPGo2V7TK4w9eYbo/siZMyLd/8RwZv4mWtV300ezdbt5tUGTajyrdMxW+13wrNhL/XutFc/m/ewKTcjlAZSGVDLBZa//d5ugWU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:31:22 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:31:21 +0000
Message-ID: <e96986f5-6e7a-4c78-a016-057a98d9a3f5@oracle.com>
Date: Mon, 11 Dec 2023 08:31:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 00/12] fix migration of suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <e7b55ad1-88a0-4d0c-9f4a-2df92ee4ff16@oracle.com> <ZXaytc6glZWRC8O9@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXaytc6glZWRC8O9@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:208:35::22) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd1377c-4ba2-4742-7b96-08dbfa4d769b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+cAPkjg7iW7biLAYchRphUIdlxW7QzRRDymjXL9cQKQ6VAtq8DB3iEaQAWQcKALlqxe3hmO7rXQ18Uq84oYUNehSK56R+2BivGiRE1GOlWBisxgXAyE8aXUyGX1E3UFvA5W6j0Cgi26JSQYn5pG5u9uVGXG4Ql5UQhccjbPl/J7fWFIre8YZVUo4ylV94JeNXv9tgrBR0iF1vy/FcvT47Y7WuYkdBBQhmU6kleyk2Y05Rjf3fan7O3u8LDUVAlcKy8X8Zarn0BQEraVPvQtIdXJm8JMxt/Lp4oOjQx7dcSRJpjDtoSHSHLY8X/zIK/Apn+waQbQIOakcqYra19pB+i7hN3FuvMbUkTdJWulOdyhQnkaUAEOkOAaBwYRSif6W6wlsbmCfdJRa/RIowbUvIwl9M+zQlVcZ9j3KxvKH0JUr8iXdhMPV7pQNcF/mZR1NFvKTMNh+rjWkAHDf8T8I5f+ZYwox0BuNyQsEXA9InSbNbyUry9X9P3p/q8Fu2Ykb7C6yyicoyE9bLBWZ8gY9BObj2QWCdKhvISPMCOL6Ep+K6i1Z/TorOciCnQT7BaN8pyYn2eVHYc8M77GLG4IU9uM6ay8IF4ZI5aC/mXh9186yBASfPmnSaqhyAEWm5clLNUAR3OJ+S8vaqj8yD8NXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(44832011)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(4744005)(2906002)(83380400001)(31686004)(41300700001)(478600001)(86362001)(36916002)(8676002)(8936002)(4326008)(31696002)(15650500001)(316002)(38100700002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnZMb2ZVajRDZmJBcEtXbmMvVmc3SXpYMFVtaTlkSHhIc0NXeEtVdlVGK3or?=
 =?utf-8?B?S280TlBraXVHSUVEMmNaTENTVVlET3U1U3hSM1AvS0Jad0l6Uk5Vb1paMzFn?=
 =?utf-8?B?Mlh4ZnJNbGoxbUwvc0dsWmVXcWF3VS9NOUNCT1BHVWc3WmlISDdHZ0c3S3g5?=
 =?utf-8?B?aDF6SU42ajJtbFJiNm9ielZjNzF5aFQwV0dXZldDL1ppWkF2RVcvdkRpdTJP?=
 =?utf-8?B?aXUzcFpGS1pncXMyVU5WTFRrSWRHZDdWUkU1RElOUnVoZituczQ5aFJNRFJo?=
 =?utf-8?B?Z2puajdMeHRVQXdEN0cza3JKRks5eThmVnJXZ1ovRGxDeXM3aEpsYnBqN0ow?=
 =?utf-8?B?WHNVTlpVdmYzZlFTcmR5NXlLa2VSRmtBUlRkR1F2VDljV0JYei94VGUrRDhU?=
 =?utf-8?B?Y1ZiYjJ4WGFqTVgrT0tkdmdHSXd5R2FlR0dyZ1NiRE01ZGE2NmEyR1owbWZz?=
 =?utf-8?B?bFlPeUxvZjRYU3FpeG5OMkFRaTNRN01CSWZBaVluS1ExU0kvS0dOcmNvL2p2?=
 =?utf-8?B?VjlvOUN5d291TXFxWDdrdE83QTlRMkdQUXhxc2c4YTdnbzgwemZwNVVVQldS?=
 =?utf-8?B?eFptNzRHa2dWYm5BeG5KMWJMdVNFd1RXKytRcHFUd3dBc1hHaTNKRVFSa3Ez?=
 =?utf-8?B?RnFSSXBTTzh5YUhlTk5XTmw3QWVZWG1CVUYwbDM0VERjbUZXVHNDR1JpQ3V4?=
 =?utf-8?B?MVhIanRWd210UDY2VkxtbnpRZmt4MVEzS1RpdlNlQ2I1UlhHRTJIdnhnVHRO?=
 =?utf-8?B?TXMvNFJjOEtzL3JVb0FJT2RmOW5Qc1B2cStCTk9KYUROVC8rbGNaQ1lJUDZi?=
 =?utf-8?B?TllJVFc1R0JoYldCQ09adGdTcVdsc1EwcEVHQmdyM0dqUE0wdlBWRzBYdkNa?=
 =?utf-8?B?b2FlZ093cmRqRkxKamhEU0wwZUdoN0t2dFNjWVNXQ0w0MXR3NHdMd0g2Qzdu?=
 =?utf-8?B?aDJ1T2RJWkk4aHhQeHJwb0w4dlBiVXo1V2FId3JJdDluUGkzeU5BWHpMckQy?=
 =?utf-8?B?N1JYcVhhTEJ6cjJxUm0vT0o0U3d0bkx0b3YwVkVZNXpOTjA4SlJTTEQrU3lu?=
 =?utf-8?B?OERuaXpvYUpGNGNTalVoZVVhZFE5aGh5RVVLQmhkVk90a3FmSEl5cVBNL0FX?=
 =?utf-8?B?Zm9wWmxBbHg0Y2dYSjc1emxINEpNY3hEdXBIS3RPMmloczNtVVBjbEJ1dVEv?=
 =?utf-8?B?bnVKWUlKUUNQUVVTam02WEtKSDRBSTJRUmJ4aGl3VktoNU5YdEFUWFh3dE5U?=
 =?utf-8?B?TUY4V2NDN1pQbVBVY0lqRHNIQVdwazNRbjB3Ylc1K1ljWjJkNTV6NlZWRUUx?=
 =?utf-8?B?RXVTb3dMcGtrWnhkRXZkYWxKMFUvNU16UUtodG11Zm1FbjNlNGgwdjhOV2VU?=
 =?utf-8?B?aXZUb3A1a2pXeURIcXdBYlEvNk45TlhTTnJqcm5YOWppbVYybWcwYlNCMmNx?=
 =?utf-8?B?Q0hJbDNlUXJSQjZWdzRCTmJVL016SjhMTk0yLy8wT3M2eXpDNGQvc2l3WXAw?=
 =?utf-8?B?MHRwM2pQY3VhOGZmM2QzRWptU2s5ZXp1NlIxaEdxNEIwZ1pqOVJUeFhuQmsy?=
 =?utf-8?B?SHJVd2g1THloWTlkMnNVSVNKcllTM2pvRmtoYmNERklXODRhcE1XMTV6ekFU?=
 =?utf-8?B?Sjg2c05Valg0TVBYVFNxcGR3SXlFbGNSSm15UGI3eTY3cUVtSVV5SnVlc0tB?=
 =?utf-8?B?R2NyM2JhcENxS3lybHA2NWFVaHZNaXNMYXZGU3JvMXdsaXhobzRSazZwMkZ5?=
 =?utf-8?B?M3k2Q05hbzVlaTI1U29vSjNkWHN3bDhOZXBIdEJPVWpYZ2d4Y3NtbDMrRlJC?=
 =?utf-8?B?SzFkRHZyaExoSHRLMU15R1d2TFR2bXRIdXEwV0sxa3Y2UlI5T0wxV1dLcFd2?=
 =?utf-8?B?WWlLMWxoU0pCT3ZndVpDc21zcG5NeVl6OHdMUE1yQS9VTTlXczNWaURQVkt0?=
 =?utf-8?B?bkZTdjYzdHM0bU16a1JES0RHYXZQbzRjVXB4VVo1bnc0SUlVMWdZNGxKZmht?=
 =?utf-8?B?c0xHQW9xaWp4Z0pCY3hwaERmNWhxYXMxWkRWdGVUTnI0WXNleVRReE1KN0F0?=
 =?utf-8?B?cDdGaTlRRFZkNFBzbVhvN3QzbTkzMGhhUVRDVWliYnp0TUFrSmFPU2ZnY290?=
 =?utf-8?B?SW5sSlo4dlo0WFZTWkYwVzFDeGc3RXRMMXdvVzNYRzZBR0RuRjdRMlh4R2NR?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TLc3agnq2B8eEvobzu4+pNmll/9dLt8tHLvL7WMjlUBPB7wI0cwzhEjwqKoBpMDuREiGgETm9Uert5kMXuxQBYO2QMsrNKUexKFMYFByveM05s1EQiHWKnV682YVYTN+BvqUlYQWK/yurgNH9p1CsBcoVUx4JpBGICpHqgwg4tLzbaLCoDLHi6QQqAcXylhUhfOB/iJi6U/1RT6OMvKk3R5ZGGcSsRSHOdJ7Jwd2Zot/idwG/Lw4qiho/gMJTDdjvEAtQoXgOai1Ko+bR1kKq0jyeTB1Tvp8SfFGNX2bg2dN7qHTHCw2v05X9x6zpVncdFdp4U2HmwzRw0ruqB5Ug8J1RZp/Peq758wz4XG8D4BQNgCkFHh3uoPxr9qkwa5/Ft04ZF9+vS9OViT/ZHkdU4If83ugbXKLzmp8/svLtWlrclDx2vB2p515/Bat5w0ou3ArIIxa5Hp22ssPmiyO6usxP+mlXnhXGhQt1H8dRU0JjycCPXrhsLIqxCyiVsIBty3gpvlfjt/EMEA960jJkoX+W/GXdX6LZwNZZm5dJNg2KVfTYjo96hodsqM/qH2UuvxymmZfzZiIOV8cicVCkHIN2Gsr4cKPqPmcGWFK6J6RXEC7P6gRJsE5sPiPv78dNiVxq6n7JiUpMi+kSRI+VXCFKPOzr/Wke1nuYZkEj/hnn5GagN7CUyc/wsPIfbixhKFMLmZerXUyUL30gKce7TOKQA1VBD87FYrXlSyZzCFktY16R1BcKiV2rHESFnnVnrkSy6eM3mywpM1ZR+/awsZGXSrLcIjg6U+3F+qRNHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd1377c-4ba2-4742-7b96-08dbfa4d769b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:31:21.3770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP/WIcl5+J9Bcqw4d/j8MGmKdzWMAd24ZE5SSN282rWKCMjbt2aHUaQQz8WlYocHuj8/4KZA0eBvLka1hxSJ2k+jEqzrh7SUIMKV2zQQa94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=744 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312110110
X-Proofpoint-ORIG-GUID: vYxMX3a5Fs91_EcFpa4LakrdAVOqflKU
X-Proofpoint-GUID: vYxMX3a5Fs91_EcFpa4LakrdAVOqflKU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 12/11/2023 1:56 AM, Peter Xu wrote:
> On Wed, Dec 06, 2023 at 12:30:02PM -0500, Steven Sistare wrote:
>>     cpus: stop vm in suspended runstate
> 
> This patch still didn't copy the QAPI maintainers, please remember to do so
> in a new post.
> 
> Maybe it would be easier to move the QAPI doc changes into a separate
> patch?

This was intentional.  I did not cc them for the whole series to spare them from
excess email.  You cc'd them for "[PATCH V6 03/14] cpus: stop vm in suspended runstate" 
they had no comments, and there is no change for V7, so I assumed we are OK, but I will
cc them again for that patch to be sure.

- Steve

