Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873C74B4C0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnqV-0004up-Tu; Fri, 07 Jul 2023 11:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1qHnqT-0004u4-Mm; Fri, 07 Jul 2023 11:58:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1qHnqR-0000cM-Mf; Fri, 07 Jul 2023 11:58:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 367FYm0s014709; Fri, 7 Jul 2023 15:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bXB3jLJEb71hKjW2ONq5QVWT5IKqLpqni0xQeX2aUEE=;
 b=Npja7N1ATYuBk81JTa6Tio7dk646QFlxRLFDaXUBvqvCWAp6YsZvFWjGrnw1W+qIp5Zr
 WGbXDy5qCmKfwTa/yGzcIrb/UT/Rn5XFkI+7NmqHzl63+31yFRCpfBUdzfIZOp+OSkiD
 99x54WOp+1MBv6SVgFG9XILUph9HKkIqkeTGjR1L2rgchCc68lx4BVK8SDlSb1bT+zL6
 UxD3DRmm5XDUQsawe7RkOjZaXrsfr0zAOrMSKG12qFrSPVA+iv2pNyxkxFPUloAmUmJk
 wu7m3391xdI9k6Areu0X8ivZ9D3Ps9wYVNumOuV3M8ahzLwISGVndiXNgAjD+/xpMVw/ ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpfhprrm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jul 2023 15:58:00 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 367FKN7u007264; Fri, 7 Jul 2023 15:57:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjakekjdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jul 2023 15:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0ZOvp3leNoc2+vFG8TnCj/rSXcQ3QzSsLHUexRqiAAjCu9zpC/w3JDKg0FTGhjskiFLF5EPMLaDjf5qI/bFbnrTuQempWlrzH5/uwIe9EsTaiVOzcg57nhxHUnQzQBQqMc4ftatd5Wz4Ak2hCiD4zyfC4cG4O61pVCJn9u3Emgj4iWLCPyNUMvyae1UljRN6pKqg9Tq7QfGYFMOeycKM6tHi2GpypYdOjkrt4tyGpGq++ezPXVET00f7z5NNNI5ad9CrBdAHJANfCSMCYkkowt7PnyrYj+T9fLRL+1FeJzqyIatB5QRf7zQI4ieJTrIkdXr7bYR0SJpkP/qDPTi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXB3jLJEb71hKjW2ONq5QVWT5IKqLpqni0xQeX2aUEE=;
 b=UnwenDe4JojcZn1kCOImQbDqTMZLXzvCa6m0fUSSlRRA3khLjvQKCi/Otb4D5jxliEdBoq7a00fADFe0u9+41F4lEoYiGNJdEUBjW5BhnEEokN/L7/FdleCnxwh81SX3xReC8cBAw884nDnqK6iqp6xeM6zEJWNghM0Lo8FvkTfBO6fqbpZgAk3rmKhlczXFFulR6wXTyO5r+L72/YIfZeKeM8Aktnv98yj9QF6RXUCPoGN+8pD6VN6itYYQUpHAcbs5NI6V+vxTqWsTFVaneMNhvLyaFOuWOT0CVV5CDKgtkz8jirKxyy7j3nYXw0fjpLWUmu4PchhATy7s179TYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXB3jLJEb71hKjW2ONq5QVWT5IKqLpqni0xQeX2aUEE=;
 b=nYB3n3amVXEExi3zWi/JALEMZjt70FRbfvO9coZreyQYS2T5Frur200Ijuw2kq+gIjKaUgqRzX6CAxowSTNFL2AzVpltwci4lAmbShruaF0n2bRhyckB68e31bWNfC5aa3FHlW69hF05rG3B0v9NhlLLrP1WTUhaLFD6jCDDCSQ=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by CH0PR10MB5097.namprd10.prod.outlook.com (2603:10b6:610:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 15:57:56 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::915d:8c59:a23b:7b42]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::915d:8c59:a23b:7b42%6]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 15:57:56 +0000
Message-ID: <0e79c985-32a2-4d43-17d9-abed49b553f8@oracle.com>
Date: Fri, 7 Jul 2023 10:57:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <3adcc3c3-c0ba-0810-10b6-b13ac36a5de9@oracle.com>
 <ujzth6z2w5cha3h4hbw6jufgux3phaaqc67zdn6obypwnmbxd2@qqssco2tgvwk>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <ujzth6z2w5cha3h4hbw6jufgux3phaaqc67zdn6obypwnmbxd2@qqssco2tgvwk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::20) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|CH0PR10MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1bfc08-b6d8-4075-f5b4-08db7f02edc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAcV072q+bI2Fcxqca31Xzi/eFTDpL4UjRspokKAFO8WFf6KRGneXJUEYVGUMuxlM49vFr1pMg/s9k4xX7hwNB4g99Mg19T2FOI9gTiMU2J6bXnywKd5vkjRROfJnqlJgHG60kEwnNwdF9d8GmeckpbYWBTY20R/mnMceNUoBXrF/focPkwk8RIpDGbVFZKsOvJ5lWmf19z976mRanhnK0aodViCjQNdoUpuvCG9kyP33Ol/FLLtq55grD+7+9fisYSdvKKYy9zFWaC7LEmVTUhYnzD3MpF6MduHg9oTiWGauDn0Atpd0pQp1VZLLHGLhutfNwDwxIU4Hf/2/lqzXmgtsoK1ExKSGVv2mRdXopM8lPo7CoqBPvshAFO2JAkruXAxgp4Rqmx7cPrFctBq7MdzhqbLBadakPyqqOT+W3ZbCAyzS3+OnA88vfwjRS9vmxJHpGO9F7sOvQOxcB9LmabpMivyh3yKm5gHcDecDz9Mby37nqkLl6rNNYONQZWpDq5UCJ7aiPos2T4U7dUuRjnySFEhA/3GjNe9LlFQfusUuDHwvKX7Q6hY66ZLL7O19wMKUATzhYeGEemRpH2XOTXbjkP5B2ulH1AFEivZFQlo8Qj9VDvz6q4BsrJZfitn5TlAvU6pKYoJZMaUkvDlRZUiMgC6HnEIkpGbEvNsmVX7QhUPb+LAU7vSsOk3wvi3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(5660300002)(8936002)(478600001)(44832011)(8676002)(66556008)(66946007)(4326008)(316002)(6916009)(66476007)(2906002)(41300700001)(54906003)(6666004)(6486002)(966005)(6512007)(2616005)(26005)(53546011)(31686004)(186003)(83380400001)(6506007)(31696002)(38100700002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1hGQlcySVNSQlA4VG9zekhvMkhuL1l0TE9OSS9DNndSUmhqeHJHMVRqWmJD?=
 =?utf-8?B?ODUrbUozMXBvUzJEcDVraXZXL1BSczZoaHFBS3QwbnhjaHZzWC9PUXF5b2ZG?=
 =?utf-8?B?cVE5QjNjZzIrclhEWHJxSlZqU2NqTWtTemNmTTBpbGZrV2h6NXdpN1ZSaGdS?=
 =?utf-8?B?dTZxd29vWlBsbjgzeU9DVHJkRUdlajd0R2dnb1ZaZ25xVE9jY2VVSDRHWUtm?=
 =?utf-8?B?RGR1WURmZFpnR1BnYllqbGQ0OHVickpJc0xZTXphVGwxMGl3a0QybzRmMldD?=
 =?utf-8?B?a2FsT1M0VVJPTlFlYlNPeEd6dmFQaG1mTTBWejgyL25KZW9MR2RGTnBJRDFj?=
 =?utf-8?B?UnNsR2pjTmFvckJYcGdhekxhMGtKd3Flbi96bHExTEhoNnRyWXMzTlp1VEpN?=
 =?utf-8?B?WUIyOTRJYkxBbUw4b2NCSEF1ZFFTa295SVBpVW1HSXdIWkFoN0grOTBWZTJw?=
 =?utf-8?B?L1dxalhoT1ZOaWcxRnNwVVhZSUhTaXA3RDUwMlpVRUs3TTRkTW1DbVdNNFlI?=
 =?utf-8?B?V2c5dTk3c21Oa2llbU5RR3B2c3ZBdGcvVWluVFhoNmkzNlJleDFNcEJPS3Nv?=
 =?utf-8?B?TUJhcGRuR3FyVG1xUjJlTHoyUUtEZFYxTTJhTGY5UW5KSlVSQ2dVLyswWEh2?=
 =?utf-8?B?M3NRZkZoL24wNmU0clJSRE1FUDBKb1hmUWxOUjJYM2EwVUI2cTJibjhkTFo1?=
 =?utf-8?B?WnBwbEMyUlpHL2ZCcUt2aGFCZE9CK2xPSnU3THVQZSt5cjZEYWFFRnZ6WlJ4?=
 =?utf-8?B?bDRXK3Bkck1UVDJpTGl4dUNDZFdwUXc4OTZ5dFNsT1RqNzMzSTJEckRDQ1Bn?=
 =?utf-8?B?UHUrTHJZQzJOUFZjUEJZdFdTVXc3UlZLdGQzNEpNZ2hXcFZZWHhjSCtKVjJO?=
 =?utf-8?B?UC9vc0NVanNnN1BZMXozZGxncDAxWHdMYW9MRCtobVZWblBvUTd4cnNxZWcw?=
 =?utf-8?B?Tm1BcXh5TE5CZVV1OHlFQXJmS3ZGUithMHdoNERGMjRDKzh1cGw0ZmhtWnNL?=
 =?utf-8?B?N3VZS0xxV1N3eXZPTVFzU3RJUWpZZGVVdTRIck9kaDJxOHdWV1FjVnI2SW01?=
 =?utf-8?B?Z1B3dFJzYnRKa2JNMFVad0RIeVM1dW0vTzFPNzRPR29qcy9IREswZXJHK2hM?=
 =?utf-8?B?WHN4REtmMmE0QWVDaHd4R2szdGVKaXZ5U2VXanlyT0wvdlNPbW9vTVNxZm1C?=
 =?utf-8?B?cVpJeG5SdGZraFF5djhXN29yejI0Z3c1VHgxb3dMbFc3RHRIdExjUXRVaWgx?=
 =?utf-8?B?UEprWFRYdGI5cjRaWndhdllZaHpucGlaaS9yNEFna0FKVEYxd1gzc3RNZzRr?=
 =?utf-8?B?aVVkSUREUnArTjY3M0gxRUt4L3VGdUpvN2xFUWhUaW9KcnI5SkJjK1gyVTl4?=
 =?utf-8?B?NGtEQk5pK3o2UXhpZEQrWTRPaEMzTFlXYlFXeDZuM28xN2JIdlN5TDR1RUJF?=
 =?utf-8?B?QTFFUytKUEZtdnU4dVE5N1BaWG11ekZzMk1naUNFOFhkTVFWMSttMERzY3Ni?=
 =?utf-8?B?R3BTZnNsSjNyQXFFZ0pPNWV3M0NpZ2Q2MEJuWFdsMHQ3Z3A5R0Z6bElPb1ZT?=
 =?utf-8?B?TFovaXJxQ051UDdqajB0NWx2TFRRelhldVRDQjJGZmtyYk5KdmNlNDNaZEZE?=
 =?utf-8?B?SS9HaUxQVjErR0Z5NzROZ0lyaVlsLzUrd0JsYXIxaGE5WmE5WFlCT0pPdDBG?=
 =?utf-8?B?SjErL3grczAyUnYvLzZRbDgybk5ObGpOK0tPT0dOSWJjdlhLMEhtdGk1WHYr?=
 =?utf-8?B?cGI3b2gxOWxSckJaRXZCK1F5WGl3VUQ4WUxrYkF4MW43enExSnA5MTlNKys2?=
 =?utf-8?B?czBrZXlkQzd2SlpxbXN5QSt6NnZ2SWNnVC9lU1E0ZFJDeFd2b0kzRnpvdytk?=
 =?utf-8?B?OHErNGJtcWwxYWlhWHN4dnQzcnZKMkl5dVltN3NQODk5NnByQkhSb2JTdW14?=
 =?utf-8?B?bk1Ec1pWSTU3UllSRFZRTDVtSC9ETGtjSUUzNGU5YTlkZXUyL2p1TEtuN1VI?=
 =?utf-8?B?MTFEaUF6M3NUSjBPcmRCVlpVaWM2UEtyWnhzTXRzS2FhTmdSRm1naEVXNUdS?=
 =?utf-8?B?U0pKV3hKSkl3QjV1SjMzQXpJdWRYY0RtUTlMNGJ2dm1NVU9Db2Q5NzlaVjNr?=
 =?utf-8?Q?HxKFb5u58scGOC1wbC59D4N82?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rEt0I5yKBDyxgCzUyzzft6YYmshIHCwkdpHS4vHF04Ag9dDvD08tY/dfAXiAg2nLljpPZ3nDUIs5R0hmVPmLDlmq9jQFM5nu15ZYrQVTvjRSqL0d1sBLUEtB6d07WpWG4m6e4uUBYHa4xGn//+LvdXab+a6hOCr772Aq3ZQVApQZb7TfH0JocsZSywjw2XVklTHbMGuzswdffKEFVl5qE/ASpEqw00TMOLGLnKdq8FkQk1Rz2uDnc+4sKYtc8aPo/98TA1v/L+hc8vAFeIvcEiX5DznmtHkkChXxuM0PZkTfPZ9QaTuLrGHqxsviklFAHO9G3Mw7he/G2BXUXk4a8y+QGwjxlrIVbx76Acg6RdFxIg4Yuz+OU246wdthwzdEJKJmKttR5X6+bfHh1301lwZGD2lZSsbtc1Z/qfsG7hlmrGZ64kNlVgJx+wHcyFEYB0Tk0CAwwn+dlngdzWIBjhnERcCTkqDZQWBjIjcAX0o2s+S9KBMNlcY4hIJrYCBJxMmYKnomiYOqpKmI1+PN0ahfb4NVXHiMAhMg6GjQIBtymMCQdoFmBOiVANR2jpaYpnGlkq/1/pWKAp7/Hzz4LNOvMca5OG7zGt/BWUrX9JjZF27sWEXQ2XL/eVKdrF4ARs6oU7Rz+fXaJQHbubDukMG0MYs5h6l4ETuztGTWuNULBnCB2BzOAMJ4nJskG9LrW2cT/J5ncj/5YhqTYDEaOeVxTjxTVxQUoaP3nmcWI7n33Fi3sjAALrG08gYEOcCSU6HlXia6d8Y5jFmpfBPbI441oTH70Ml8/s67E3KJbL1VcfW9vunbfybv6EytB9th
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1bfc08-b6d8-4075-f5b4-08db7f02edc4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:57:56.4991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWEDodXT+R/GSNeguT++GPm/eZaJi0OrP7VE8haObwV1phoZfzwqgO4KC2Va0Qi47nggVB+TWduF8yCzeOZxSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070147
X-Proofpoint-GUID: ycANkYL5sl_Q3KK_d0W4p4CJQeU5uhcJ
X-Proofpoint-ORIG-GUID: ycANkYL5sl_Q3KK_d0W4p4CJQeU5uhcJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

Hi Stefano,

On 7/5/2023 7:36 AM, Stefano Garzarella wrote:
> Hi Mark,
>
> On Wed, Jul 05, 2023 at 07:28:05AM -0500, Mark Kanda wrote:
>> On 7/5/2023 2:15 AM, Stefano Garzarella wrote:
>>> This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
>>>
>>> That commit causes several problems in Linux as described in the BZ.
>>> In particular, after a while, other devices on the bus are no longer
>>> usable even if those devices are not affected by the hotunplug.
>>> This may be a problem in Linux, but we have not been able to identify
>>> it so far. So better to revert this patch until we find a solution.
>>>
>>> Also, Oracle, which initially proposed this patch for a problem with
>>> Solaris, seems to have already reversed it downstream:
>>>     https://linux.oracle.com/errata/ELSA-2023-12065.html
>>>
>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
>>> Cc: qemu-stable@nongnu.org
>>> Cc: Mark Kanda <mark.kanda@oracle.com>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>>
>
> Thanks for the review.
>
> By any chance do you have any information you can share regarding
> [Orabug: 34905939] mentioned in the errata?
>
> I'd like to better understand why this patch created problems in Linux,
> but solved others in Solaris.

Apologies for the delay. I unfortunately can't provide any useful details. We 
had a brief internal discussion about whether the Solaris or Linux driver was 
technically correct per SCSI spec (I'm not sure we came to a conclusion). In any 
case, we ultimately decided it didn't matter because we cannot tolerate a Linux 
regression, and therefore Solaris should change to behave like Linux.

Thanks/regards,
-Mark


