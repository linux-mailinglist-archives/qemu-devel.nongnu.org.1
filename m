Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 841447D1139
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 16:10:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqBe-000217-7m; Fri, 20 Oct 2023 10:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtqBb-0001qH-6g
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:09:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtqBX-0000Nf-QN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:09:10 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KD8enW017965; Fri, 20 Oct 2023 14:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VMMmjVGZBhCu+PkjLromxY1FE475ZeWiE3dcfSV7hyo=;
 b=SGVsZJcDTpMZwEszYEBjtVqVpS4zLp2l/GpjeV52vE95XlTpVNZx0jiywAvQOrzMjGo4
 Z96LbSyGKmZC8HK53jWumUHbmnUsPkU4Pattiwrl4AUMRbMK8imwcGHvVaIHcysBvjOD
 NTHxcJWuVhA2+gMCR3eours4TQl2HPZobBJhg+NsDv8YODyrGcah+JZnSd3V72xtdjbM
 bFa/ITB0GmSFijFF4uxK5OmObt4CLxRxoXlNWSgbWcOboXtlUFolFbmEO6LXq/eeRplQ
 me/FGIYtLBD9CU2Y4MzqyyzMsAOVZIeq6rwB9ZJ4CUr3ydQx7CEpvLvtvvg6G8BC/zwM yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubw81y0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 14:09:04 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39KCAdiL031303; Fri, 20 Oct 2023 14:09:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tubwduxrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 14:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2MZQ39ZFIaSreZOpXiDEgvDe+EpBN0HRANeRQLHmFllk8MLN8wJISrf5A98GfQ+lN/W1HyGIuWTHti6sn3qhuDguHLkQ6TEoaYWHJ0BfyO3HW7Ppj/Yd4rWQx020uW0XLfNfBv/QE2KRLoEIL4gR7WKPEiRA4Zzht9cxaG3c7F31w+TW580COGhhKoW/KNGtXRymqsGmwKRVGCNhGpsbTMuj4VZTl7kL1e0/z5GaH8Jz1T2DEIYeWUr4BeOoxXD+9jnTMcT/aar7ESvDChvHM8OYfNJLjeeAM9IniSINKT/+RaaBmdgXwntfQ14sRdNDyIOHjRs6RbOL7aQwvEpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMMmjVGZBhCu+PkjLromxY1FE475ZeWiE3dcfSV7hyo=;
 b=A1jaol+sAG3gwu3Ln2b0yvENQY1WJmfmXDL62WwYcqndvHjnZpF0wY0bhSG99mrJwkmZTl1EqTx8i3dpwpdJGt4baVtIMGuMivW4QJhLCX7oxsTabyKyv5a3rUklgHQQMBpqKPnz5Jdd5GlJld6dGdyjki2bnFxbOjPQacs6aMcDFq4nM0T5ts24+WJyQnn+E5aw4BQScNDUSs11i/O87zdDVT1zE5ckFSeLcBA157Uib7Nj+Sdb1fpBM48NyAUQC9MRxfIlFAXC+Wv8q27312Gj/8FVx4dyCvnSb0DILHm9rhw70uuTmdE9JRaUWMnEId+gO7XcC8LHY0pIbyjJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMMmjVGZBhCu+PkjLromxY1FE475ZeWiE3dcfSV7hyo=;
 b=OZprAFyS69lXqUyoow0CaWcEJ0IayUdOB2zAs0kB6Z5rsNyOy+n6pmY0FX+cdEwsEIKYWHLv5P+3RE0ralsSQvZCqOLqM5LuxZIR6zZWyNaZWRyVwviAE2F/RDFDj8+j4KlYSMszedVNm1kGZsdtlc40OvnOgnCzcmUSR0ICFvE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 14:09:01 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 14:09:01 +0000
Message-ID: <6ef2d943-0822-47fb-84d7-bb9c39260670@oracle.com>
Date: Fri, 20 Oct 2023 10:08:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/4] migration: mode parameter
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-2-git-send-email-steven.sistare@oracle.com>
 <8734y51w1h.fsf@secure.mitica>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8734y51w1h.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1112e4-71b3-4272-2cee-08dbd1761c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSNypoxU38gy90ybsBLFliAgsTfv406nCH9xkKjD5NF+e1wqOL3TgWeYDKB5u1UtLhHeat2ae2SVdy7+Od2shFB/ATAAg8kR4NlpcZbFy+u1fT+PJME/qSKJOVuXsdVwz7SKWIwJOnol6W10L35g7/MwXWbAJsCh2Bc6a+CYUdLTtJSJxlWFRbBQHvHD+CQNaACeyS5GWN5b1LZMchcAeNERkJvQ4rUwYPi8usRC38deNfSGesinPEbOfB90hS5XSNk3h13K5rZGtFC26yE3iNkTiMQy6wUDhzmKnETLikQ+hnYZvOqmDx95WFbplD+bWm+1CosuH2KTvyLFApe4vGaKR/vKzNJIkYT6zKWVNpGzm7DVn1+fHLkvUhJ98aTMRBdpJkrSGtEucuDBuneHWDqhrTqE4OFxizmQ6uZKVJyCfVXy2lhsYUv1YfBTyT0UUR1P+L7gaIQLxTLbxG66pSOGy2PWyyAQYRcQ8Ub9klGKkmYv+TYe6Eug7bpDm6XTUpOtxgvC/HuXlsj001RqqWCYsZCjaWRtA1fyyRLwiGm68J8aLtDtb2FLsYnPLLWsQ/rRhR4wjFV5VLQSDTQ0X38pbaHDJ+KO2qKwKC49009MAbtylmQqLC2Kfa6xAMvyq+l9rxNLrosd+p5ATuiETA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(31696002)(6486002)(66556008)(5660300002)(66476007)(66946007)(83380400001)(31686004)(44832011)(54906003)(38100700002)(2906002)(36756003)(8676002)(4326008)(6916009)(316002)(26005)(2616005)(53546011)(36916002)(6512007)(6506007)(8936002)(6666004)(478600001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ti9BTU1vdDRLVWZyM1NXS0dZZjdFZXFBOW5ERG9NVkVPdWhUc3V0WElFK1ZP?=
 =?utf-8?B?RXI2Y2w2U1R2SEhFRWlQZTBHV3VHZzdDMjZEWGRUeWI0S21PZkxiL29lN2lL?=
 =?utf-8?B?Y2oySFd3WTRPRFI4aTBHQnpmV0ZsMWtTbnM2YXFxS1pxaVNzNEpDcDBtUTNK?=
 =?utf-8?B?NUh1ZmhZa1pBallydWVWbDJLT2VuTUZpay93ZUMzTTRLWHI2cTFDNDFzcFRw?=
 =?utf-8?B?YVBXUUxkNnd3aUNqajVUb3F4aVIrWTZsdTlqT3JGZjd3cndsdzE0NTNnSDk4?=
 =?utf-8?B?RDVkYWlPaVZjK0FWTEdoWUZtVzh3VWkwYUNpQXBzQ2g4ckw1UUdiVUIwSTMw?=
 =?utf-8?B?dXArdnhXK2NrYzBaOGRmdUpWVko2REtwRWdwaTVhUjNDQTc0Z25HaUVMNFB4?=
 =?utf-8?B?bzErMitlTkpQNXB2Yzc1RVhzTUpGYlovT2RsazV4U1p6eU1USnlBK09zbmZx?=
 =?utf-8?B?a3M4SUxNaW56amhTTTZ3YjV0dTJZWFFZV3M3aXVpdGRPWUhFZWhVaHFXdkF1?=
 =?utf-8?B?bUhJSWJhcXp2QkJRaktSRGszc3lGZGE1bWlxSm1BbEpEeXpjOEIvUkZxVzlv?=
 =?utf-8?B?OGsrSUxLMWkyaWFFMTNpbVhPU1pnbmdiQjFzdWFmd3ExUGNIdXkxN09OdS8y?=
 =?utf-8?B?NGtVdjl2amkvVHNkeit3U0o4dFhmVzRQMWdCRFc4Y2l3WFRMOW42b0RJRHFF?=
 =?utf-8?B?bGZQT1lnVzJ5MGlsNllEek94RGYrZ2NEL0RvMFJrUkVHd3QzdnN1aDIvWUUx?=
 =?utf-8?B?eHV0aGQxVUUzbUd1em5GbXliMCt0WG8vNDJqOStPT0VOM0tVRzg2aDAxNWh6?=
 =?utf-8?B?Yy85MVFKM0cvdTdzMHJjR0ttR2pjTEdsZ3BpNUN3ZW9WSUpEQ0d0WWhhTGZ0?=
 =?utf-8?B?c2Y2czd4Z1luZUlhMWwwaWN1R0VTQndRQU9PWmZlT2JvOGE0M1dXM0J3T3pW?=
 =?utf-8?B?Qk5tQ2wrOGpWOWk5RVEra083dis2M3VLeGpPVFdJb0x2Z3BQV0ZOcW9EbFN3?=
 =?utf-8?B?cFNRNEozUk1WNnMrT29WNmk4eXBMRUFFOVNUME1yVThMYlp0MGEwckt3dU81?=
 =?utf-8?B?TUlBNDZ2ZTVDZ2lWeW1PMXJ2cW5STGNybVdWcmpzUjF6RjRqSURJNUxiMnhs?=
 =?utf-8?B?SXdrWUxHNDhORlhwVlVoYVV5YmQ3ZXliVGxXL05xRjlpcUU4RjBxdTBXM1dH?=
 =?utf-8?B?UVBuSk9aZjZYMUY3VTJ4NW1mb2JQa0MxR1NMOW9YeWZtTGFrMEU4TVQxSXlN?=
 =?utf-8?B?RmNjRVhyNzRFNmcwUU9OR216MmVmSm95MVkwOGVXcDdiaTdUbFNUT1FoYnNV?=
 =?utf-8?B?aldJY2IyRVhOTjNJM3AvUzBaQ3ZLeUV2RElLR2t1TXZPTGJuVnhCdDY3YUlN?=
 =?utf-8?B?VXBKcE5HWlIzelBBVUwyMVB1aE50eWVCNi9SakM2aFE2M1JDd0I0S1RiWU0z?=
 =?utf-8?B?OWxzMTdrdG1EN2RSYmVqWXczSWtyY2FCbG42SjY0UDIrUTdiZXZ5bVpCbWsv?=
 =?utf-8?B?a0hLQlV2ZFNkYmFrTzNNcVNEelBpejJEYUZITTJoVWxRVlNvQXdyQ2srODZq?=
 =?utf-8?B?TE9yNjZsNVZBbkZvU0MzVFBNeVVyZGlCWDFyVW5HUVJ4bG54ZEgyOFRKQ1FG?=
 =?utf-8?B?c2g5YkdqMjNFaHBEazduSmFkUWl4bVl4VkJNbThoV3NHeWJCdWVyM2lxY3pS?=
 =?utf-8?B?eHVFenpUS2J6V1lFNnJTQXo5ekJ6ckhSUlN6azhSdldqeUp3NFdUY0U5cjJn?=
 =?utf-8?B?QlJPM2JMU3FUaXpYOVZHV2VJUGNobm1Xa1kzTW1RaUoxc3ZJM3lGZ2hreUxU?=
 =?utf-8?B?L25oYnh0Ym1MVWtHNlY1aGROLzZVc0dibTFzNVdpVk5VYXQ0YlhSc25GZ1hL?=
 =?utf-8?B?OHhvKzFYbXZhY0RKcVYzWWFHMVVCSnQ1UVlMVURCZmhJanQwZnk1N0JqVE5I?=
 =?utf-8?B?MGlLOTRpVnpVb1JZVFhVdythTkV2OXM5d0JzZk95TmdwbWdqa1MwY1Y1UUJv?=
 =?utf-8?B?bHR6QjRHUXhMc0Vuc05oUDJ1N3ROZlJwUGc1QisvZUgzQWFidDlIcnJaOW1q?=
 =?utf-8?B?amRrWml3dlM2blR5SVBxejhtTHBEWGlOSk9xL09GdHhiblZ4c0prc2x1MzdG?=
 =?utf-8?B?OWNYcFRza3pnaHRVczBiV3FrNUpJRzN3MVdOUmxxaHg5dDVJVWlqbmloMkFx?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KI+ODAbCYsDDqUdMPRVUeEez9o7n8HMw71xNRN9a2Vr/U5pm0eRaSSoFLg+oAUPc6R+ko/+LiJFwglAFAtksAk11fmmLFgXWftcPdS0tFJ4dF/2gd0zGwzHDnSY4GE3BDGpCqbr2LSg6crPPeJieWUw6a59f91dO8wiNLFg+iUfkmrXSM4pTXW+hsAfohdAuFNEl3sU15v1XKZ0mjb+gwROQmCisKToyLSExc0idsAHUn1gZq+a0kprpSw8w8E3MJh86J9gAXlV9gifu34CyVXBxX0QQgyNu6Hd81lpaBvXQIRUIGBdIIZ9JAn1lRq+rrMEanTIxxR/5pHxxYKJq9kQX30Gvwg9zLyr0ql4rCERW0YqQdPOkAGpc6NJP4XjDvbGC30ln6isrdIqkvVKrSRUTp0+1kO0WwaJ9ZTsKV6ZuvVXwdSA0hgjjOHQ0bn9xTMwUFbTOQnSPamhMGy5gpCZvP59z4MMm3oUUR1wcBQNMgZQbsdO00fyQM/feC/bHGm1mXMdDU/KB25K9ZBlTed8uo+4mu+YkJrQDjiJ4rVogAc08+tVwEjs7mSq9GaMIfraGmVn+kJenE5VoowgGXA04TNpiF8XSpBf546edYawPRX18dFFVsuTYlb0zoJ+ZXkTEGdJP09A5GHQmURYwtpgS5HKIeuGT5cdeHF73jIHTSplCR5yKLRXVIoXEk5PlnHpKteFbzdMUBN5AIZ/bSFMJ9s+K3+4N4kKw4cL5imSnYG97OhfGBiuOISitMdOmgN4gDcd8jY732glX9QwAWzAmYKPimggeqOv3ioS7WGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1112e4-71b3-4272-2cee-08dbd1761c67
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:09:01.7113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zksI+uGLWSs/GS7uQHRa9M+fIZwnDGojBwPzGTXF9MSNagmPpe4FUd5y6JrenLiY6N4iqWyuD087EtamKUzAjfm00HWoRq2U0gIS0fsBVCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200116
X-Proofpoint-GUID: Qndkwo9chRzw4sLUp07wQwnLQuS6HHKT
X-Proofpoint-ORIG-GUID: Qndkwo9chRzw4sLUp07wQwnLQuS6HHKT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/20/2023 5:29 AM, Juan Quintela wrote:
> Steve Sistare <steven.sistare@oracle.com> wrote:
>> Create a mode migration parameter that can be used to select alternate
>> migration algorithms.  The default mode is normal, representing the
>> current migration algorithm, and does not need to be explicitly set.
>>
>> No functional change until a new mode is added, except that the mode is
>> shown by the 'info migrate' command.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [... qdev definition ...]
> 
> Looks legit, but I am not an expert here.

Nor I, but I copied a similar definition line for line, see
  qdev_prop_blockdev_on_error
  DEFINE_PROP_BLOCKDEV_ON_ERROR

However, I now see I am missing:
  QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));

I can ask Daniel Berrange to review this part if you prefer.

>> @@ -867,6 +870,13 @@ uint64_t migrate_xbzrle_cache_size(void)
>>      return s->parameters.xbzrle_cache_size;
>>  }
>>  
>> +MigMode migrate_mode(void)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    return s->parameters.mode;
>> +}
>> +
> 
> Inside parameters, I try to get the functions sorted by name.  the same
> for options.h

Sure, will do.

>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index db3df12..184fb78 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -616,6 +616,15 @@
>>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>>  
>>  ##
>> +# @MigMode:
>> +#
>> +# @normal: the original form of migration. (since 8.2)
>> +#
>> +##
>> +{ 'enum': 'MigMode',
>> +  'data': [ 'normal' ] }
>> +
>> +##
> 
> Here you only have normal, but in qdev you also have exec.

Good eye.  I will remove exec from .description in this patch, and add
cpr-reboot to it in patch 4.

>>  # @BitmapMigrationBitmapAliasTransform:
>>  #
>>  # @persistent: If present, the bitmap will be made persistent or
>> @@ -675,6 +684,9 @@
>>  #
>>  # Migration parameters enumeration
>>  #
>> +# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>> +#        (Since 8.2)
>> +#
> 
> You normally put comments and values at the end of the comments and
> sections. Your sshould be last.

Do you mean, add the mode parameter at the end of the existing parameters, 
after vcpu-dirty-limit?

> Feel free to use a single line in the json.  More than one value for
> line make it a bit more compress, but makes changes more complicated.

Like this?

{ 'enum': 'MigrationParameter',
  'data': ['announce-initial', 'announce-max',
          ...
          'vcpu-dirty-limit',
          'mode'] }

- Steve

