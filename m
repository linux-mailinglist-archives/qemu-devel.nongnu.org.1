Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 820CB7F1D25
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 20:11:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r59eV-00075s-0Z; Mon, 20 Nov 2023 14:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r59eQ-000743-Dx
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:09:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r59eO-00088N-81
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:09:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKIn2QY010589; Mon, 20 Nov 2023 19:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XFkApgFXSbzWALJTkpeYdFp6+vkFFo8p1KLU6n7Q+V8=;
 b=itUosmB3ZBN/EOQYtGTHbXUt8HJlTQv4gbWzO895C6NznGHoMwunH08ZxMykT6snQuAc
 TrMejPcllZgBQNX9eqM/S73wkjXT4Fbvtb0InChKVLu3yYQsq3VSPe4GB45ws+trCZvx
 ZKXXgpPwMZSvOWuG3eXFr6d4j8H/35EOqTug4M14qb/AKyn3nNmKXLByQOKz1v32gg23
 Qwl4NBHUtR7Ez1ArtB+H8rDa5MqJfyDYJewYHaje3fULFbY453KW8zTr4Zo6UDWIgWWN
 KOelsum2O8WmFc1VUMerwsl0TBn2ej7EQjRQeIftu5XilzVEuJHPot+uo94I5DsEmw7l 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpekedr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:09:36 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AKI5pir022682; Mon, 20 Nov 2023 19:09:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq5jrbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN8n/1QL+91HgSuS2Q1fM8sRQXgcKfeOjo1mOhmOXPOTZ/TeifCgnHMCgP+InBLhdUv+nJHnMVkl1KQPMXjTYq7hkFtkGPFJmYLUPYl/gIPyi6xjVl0dlJLggn7tftUYX3vbP266z+NnwBccfldHIGehQcxGsI/Gdhg1b5lZDPADm3hYIC+TQsJcsytOievtS9hWJoewBU8oOyDtccWeQRo8VQdzUlZ/K71fWiQIvhL1sYpvK+mMFCv3AVsqA6UGETIly2QFkk6AMZZTuSuZaXNhLRORcJ1xI0/GUL5UJp1QhOw6W2/P1G1jcx+JOwGfn+iMFUSzZb2sgSDDxfDP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFkApgFXSbzWALJTkpeYdFp6+vkFFo8p1KLU6n7Q+V8=;
 b=H1X9DHnV7Zjzvb4oWLtRHhg0hQ8F8133+vACSJUoOv6rvik16O3Wvnt7Ep6rwBa5BrvGc12MOOZ7uttwfU+k9FzKEUTCMmn0K9QrpCwaxHdlD5LEtH0Ts3lIFGb/jDaaKEAPuSCsppi0wpU0XozH4a39AT6OW7uWXLtv0h/aTXB8J96ntpRNKJJfP95xccRqNy6AZ/GjqlmPc8mElOznjMCXTL7MBtgebxFpL/TvHAN/flGyoCvpJOwgLbe+w9IzJufFiNxHLE7RKJ4mOnltfcoCAIQYgOMg+QNX4IS7VMBQIV52/MrpagslEEkv/S5zVBKOGfmmmtKjEl4hUPRMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFkApgFXSbzWALJTkpeYdFp6+vkFFo8p1KLU6n7Q+V8=;
 b=HeJM+KIu4yfm/4nSZVm0kF40Ftx0vr1w5lYyjiR1bd/G37peUlL/r5VTR4P9JcAOcahKKYA47sqUln1qYQ/G6mALa0IeRW1K8ACgENkJj6BWI9rPetXukoV4GS3WEOV+eOfIEQp81ewEsUPPNqJLWFUd1Nhf26a2+THaDP/3vgI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Mon, 20 Nov
 2023 19:09:33 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 19:09:33 +0000
Message-ID: <250d0338-d29d-4cd0-8e33-0520fd1fb354@oracle.com>
Date: Mon, 20 Nov 2023 14:09:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 01/12] cpus: refactor vm_stop
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-2-git-send-email-steven.sistare@oracle.com>
 <87leas5zlo.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87leas5zlo.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:208:32f::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4c95bd-d06c-4dd1-1924-08dbe9fc3aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpfpqAau+oMR/3qacbgC8AZ9hTo82goDLXNxaTy6m26y2eG5SR5BibRgUFz36s1cW97vE6xgRv1nazCyKnAFqEM2BjG2Xm8yd2N2y88RvkSKPHjAQX492tpATGSk7o+kntyhab+MRPqh4RrJjUDYRTfjx7rltqYy+6mzCMwtsQ05Z5HJtnanEFXUjZQflt6fuzCn6Of9GMWVSKK2QAID2B5PL7uyN5WKCnA9rRur3Nk5wbdnsLGsi0KGgBkCq27T8r+BsmuGePj3204UcM2y2A/h+JZ3V1/8FWtu96+DuaRmy7DIsx6giy8QK3T6xnt9LfhG/AdJYXV3zF84MjrmIOAFeJn7cMjwrb6WVOVr+fPqObsWJ9ILYRn4SLNkdNPHZ+zWewrXvcDZO40qFxEI31pG3S9g4FZFR53SbBZ7vu5rnZpoDGp7Hjj416PCJVOSGnfzRvhZa7TGk04WviXzuLPeSNjWO7XRHRd3ESoz5ZhZGj3qCtVFC5fJc3uXbOkd07QrJkTYi6U/LZm92QggUmd++la/wfMshBdcMG1gBJ4xKIE21xvRYLrsO1r1rZ7Zjs6QKpxEneuz8J1kXPoIOiLPbc2Uk3mMGUaVWxAC4cqmoiKHBQt9sG6l/nGqIV+LkhjqiQIdem1euyCMiF4+Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(2906002)(26005)(83380400001)(5660300002)(41300700001)(2616005)(31686004)(478600001)(44832011)(53546011)(6486002)(36916002)(6512007)(6506007)(31696002)(36756003)(8676002)(4326008)(38100700002)(8936002)(66556008)(86362001)(66946007)(316002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJOWDc4UTVpSHJmR3NvbWpXOTcyOWJYOTZmNWlSYjdBOXZKNTRLTFR3ZTA4?=
 =?utf-8?B?b2dXRnVLLzM3NWNqVFpBR3BDcm9rajczNUw1R3lzTXFCemwyakYwSEI4ZSt0?=
 =?utf-8?B?M2M3OG42dUNZT3dqSzdFYnBuL1RWaGgrZzlDcTdVcFNQb05lVzFaWm9RcG1u?=
 =?utf-8?B?OXVGcFo1VTlWQzFzc200ZmZ2NEh3SXdGV1hJbm1zQ2RkL21tU0RuRi8wbmlB?=
 =?utf-8?B?UkxXdi80ZS9LdU43Z0Z6ZFQ4V1NRdDhicDFsT09wU2V5aXJPd2JQMGlKa0hm?=
 =?utf-8?B?SkliaHRLNDF3eWZQTVQwTVJIeVNNL0ZuVFlubHV0STFPSm5jSkc4OEl2YmpZ?=
 =?utf-8?B?TE4yL0dIbGlqR2lPU2FUU2dxYnJXTHVNQVh0UVk2azZnQnZqUFNQSjdsNlBi?=
 =?utf-8?B?NmtLTzlxUTMrSlNBVnAzQ1ppNmUvMGNoTzZKZXdXK1JybU1jV0xONXV0TmpY?=
 =?utf-8?B?aUwrVkhqa1RFTWNpc0s1VXhPZG00K1ptQWlNbklmQldHZGpaRW1HaWpmL0RX?=
 =?utf-8?B?aEZIYUV5eWcyNWJCL0xoOWhkZWxWWEJ4QWNqRm9MN1hsQ2p3VVFpMFhTMFlR?=
 =?utf-8?B?UTJxdWkvTXN4QlErYzZHcFJadWwzV2ljb0hGWlk3OWR1eEVPbHN3MUVBa2kr?=
 =?utf-8?B?aDV3WGZIekJ5NGZLN0RDRVZFTW5UbHpNSmlnMEZ6SXdscllWZURoSXBkTTY0?=
 =?utf-8?B?cmVZRnI1RzVLTGlPRTRmUEdESTRvOHYyZUh1RjVqcWp5NFN0Yk9UZWJSbUN2?=
 =?utf-8?B?cnpyeUhpc2F3YTY0amZScXVlclpFQ1FWYU1FK0VhUllhd2Y1VmRQTkdiOTNP?=
 =?utf-8?B?MzVtcHZ3a013bzNjUXFUMEgzUHZvMjdDYlo4NGMwVGF6aWxxUXVLaDd0NTVH?=
 =?utf-8?B?WmhMcDhwbGhGNjVndzRyVDJ3QlFxaDdwVVlGODI0bnIxTTcwSzhhSk94ZFVO?=
 =?utf-8?B?UDl0NVdpUSszc3ZVSDFtdk15dDVzQXY1enNZZGJkaThyUENUcjRMQVhRUzFN?=
 =?utf-8?B?aGUzUnlKQVBxWTdoRmhhZWp5MU5RdlRjT3lZazVxV013MGFrRTFnbDNQTHpu?=
 =?utf-8?B?ZUduWTJ3NGFRL1l4K0dXbGlwSExLNHFvVDRUY2V1ZnBxcVFmem5OMk01NjdW?=
 =?utf-8?B?aTVKRU9EUEw4cjNDRWt0Q09QaVlCQUVjM0FURUxBNS9qdlpieE5hWmZVUkZu?=
 =?utf-8?B?dVNtcTdEMVRtUGxuT29XN0hvNGtwZUNDZEdMc2dyc2RpM00yOUVIUFFoSGVZ?=
 =?utf-8?B?NUlqdTIyWnpTQjJndDdvVndDUWlqajdTdmp0UG9NbEJqYzYrQWhuR3ZEQlhZ?=
 =?utf-8?B?UlR1RjArWmY4N3R0UVBQT1JScExUZG9za2xoL2VHYmRaaVM3dWlLL3pQOGxR?=
 =?utf-8?B?S1RvNVhFTkF0RkVrQkVhOEJISjZIdHc5VXNjTWFqUzhpQ0JXR09yS25rbXNj?=
 =?utf-8?B?ODMwdTA1T000ZkthOXM3ekVVMkhvcExoR0VmTnd1aVJFMFl5WVBXWmI1czlk?=
 =?utf-8?B?YnRHR3NHZDdyTU5mVG9lU3NUUTN4aGdpdGVQMHBTbW52RXdDM1pUWEM0USs3?=
 =?utf-8?B?WjdlcUVWNkRQUTM0RHlJdkpKdWJJYTB0R292OVBKYTZOYTI3Z1VHSXlNdE93?=
 =?utf-8?B?WEpudXhhRE1hQ2ZSUFdyOVQwWDc1czJXTFZUb3d0U2lzZDRlRUZ2SFNMZjZZ?=
 =?utf-8?B?YkEwekZFaXFQcmRIZS9BSy8rWXdMTW14RmN2Tjd0WThGOXNockRNaXhidFh6?=
 =?utf-8?B?MCtiT2M4bC9Pb2didjRLTVBnV1dyYjBMdXc1UmJqZGs3Q3F6NU4yeS82QmUr?=
 =?utf-8?B?UmVVUmFabUpWaTdmWGpBQUl4N1NZOXlwdGczSGxJcnNNMXlUOGRlVVZvVXVr?=
 =?utf-8?B?YU9VdTJnTFVkUTkzVnVhQUVBUjk3djJrd25uL1RueXE4S0hWQmNFYytic3hx?=
 =?utf-8?B?MUdHb1A0VGF1YTJMUSt2MWM0VHRod1dkRWhla3NlUHRJNHBqcTEydWQwTnpW?=
 =?utf-8?B?S0dGVFdpVytTV0JXODNPaVNnM3RHRnByakVwQmVud0lPRG11T1M0NFI5Ym1i?=
 =?utf-8?B?UWk4UUJuQ2FuT1ZBQVBIMEtjUkNiR0dJSzJTaGJUWEJtVWMyTGtDMXFWZlFE?=
 =?utf-8?B?c05mVlVHRmVkaVpoUTJvYy9yR092SCtPWXgzWnJjVGE3UE1TVXdtTGozQzJw?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YWqIjTzjv9gLVttuZZb4VSk5CUD4AOX0W7TGNFethER8VtEJV3zpfJJ1qfC+jKeSL5Gs/TYJ6vXclGuPNDwaUqlnw+d3wiW3nXp2ogQ3LOHjvAYX6zAtJVKZBWEBjZlqNcUfp4N7186KybQUtbsJZdUlQ8Uajn1m82ypJoZfoWmJUwfDBN+wx9AdJt72iXuzBQbYevZHkQ6lmy0oNRSfxaUZiq29+7KKOkZidbZV+ovEtsCSpZ2wFSLWZ2gWvVIzt35Ifav5FPPsPC6Vt4qdzImcUwD6S5FNzpaWtA4dFKQpt4FF22MnjfRl6sQvVmbDa0A7UZNwUqRZLEpGdqWWgGwYEPraehXMt2OieXR3ePZ9HS13vRZZRT6IzNAdD/IzjTC7tz5LKaQACgLXXbinJemgLGdISfgIcUxd9p7sLGt6iUta8rr0rmnFgJ8O/ZyGV/jHmwhdFQvVU41/f9YaBSFQb6YNSKJFIkHtdH1l4StO3912bNwTPhvN9e8GKSbi83YHFsHi8ssiGy9WQNkVuajLxSR/Cz3oZBP1HTRMYzxzCfak2iFVGluxlWw8q94Z5vZLLRbT8BLqpww0jhwcegyedexBO72nL6fDEXJsyHn0vsec0FZMMogl2e2mUMKxCE7ASyQncuLvbPLujhfVwyxAbw4uvRHPZTv7EIhYvCymI8u4SoqVMhsdQTADE9QdRFCo36Bb4PyvAE18e+dVCHjSTk09w+GgeCy1eY/yEUC+OvougaOUZJO0+9CC4I4HMX7MJnBCbby92j6exNCtNGQeSKgRoGQxWZgy+0QjZRU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c95bd-d06c-4dd1-1924-08dbe9fc3aae
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 19:09:32.9986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVRD6VJ624jL7zWAf3cYzMKUwCM5+cyTjLAI7/I9KORClcfXENndOM0ZaZxy8qcmYkFG3GS9MwtSdBPe+9BkIzuj8GPnkBaxet9VlCQ5ATQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200138
X-Proofpoint-GUID: dwYQvgGr29tWYWh9ccpfExcOPBu-rbKx
X-Proofpoint-ORIG-GUID: dwYQvgGr29tWYWh9ccpfExcOPBu-rbKx
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/20/2023 8:22 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
>> Refactor the vm_stop functions into one common subroutine do_vm_stop called
>> with options.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  system/cpus.c | 44 +++++++++++++++++---------------------------
>>  1 file changed, 17 insertions(+), 27 deletions(-)
>>
>> diff --git a/system/cpus.c b/system/cpus.c
>> index 0848e0d..f72c4be 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -252,10 +252,21 @@ void cpu_interrupt(CPUState *cpu, int mask)
>>      }
>>  }
>>  
>> -static int do_vm_stop(RunState state, bool send_stop)
>> +static int do_vm_stop(RunState state, bool send_stop, bool force)
>>  {
>>      int ret = 0;
>>  
>> +    if (qemu_in_vcpu_thread()) {
>> +        qemu_system_vmstop_request_prepare();
>> +        qemu_system_vmstop_request(state);
>> +        /*
>> +         * FIXME: should not return to device code in case
>> +         * vm_stop() has been requested.
>> +         */
>> +        cpu_stop_current();
>> +        return 0;
>> +    }
> 
> At vm_stop_force_state(), this block used to be under
> runstate_is_running(), but now it runs unconditionally.

vm_stop_force_state callers should never be called in a vcpu thread, so this block
is never executed for them.  I could assert that.

> At vm_shutdown(), this block was not executed at all, but now it is.

vm_shutdown should never be called from a vcpu thread.
I could assert that.

- Steve

> We might need some words to explain why this patch doesn't affect
> functionality.
>> +
>>      if (runstate_is_running()) {
>>          runstate_set(state);
>>          cpu_disable_ticks();
>> @@ -264,6 +275,8 @@ static int do_vm_stop(RunState state, bool send_stop)
>>          if (send_stop) {
>>              qapi_event_send_stop();
>>          }
>> +    } else if (force) {
>> +        runstate_set(state);
>>      }
>>  
>>      bdrv_drain_all();
>> @@ -278,7 +291,7 @@ static int do_vm_stop(RunState state, bool send_stop)
>>   */
>>  int vm_shutdown(void)
>>  {
>> -    return do_vm_stop(RUN_STATE_SHUTDOWN, false);
>> +    return do_vm_stop(RUN_STATE_SHUTDOWN, false, false);
>>  }
>>  
>>  bool cpu_can_run(CPUState *cpu)
>> @@ -656,18 +669,7 @@ void cpu_stop_current(void)
>>  
>>  int vm_stop(RunState state)
>>  {
>> -    if (qemu_in_vcpu_thread()) {
>> -        qemu_system_vmstop_request_prepare();
>> -        qemu_system_vmstop_request(state);
>> -        /*
>> -         * FIXME: should not return to device code in case
>> -         * vm_stop() has been requested.
>> -         */
>> -        cpu_stop_current();
>> -        return 0;
>> -    }
>> -
>> -    return do_vm_stop(state, true);
>> +    return do_vm_stop(state, true, false);
>>  }
>>  
>>  /**
>> @@ -723,19 +725,7 @@ void vm_start(void)
>>     current state is forgotten forever */
>>  int vm_stop_force_state(RunState state)
>>  {
>> -    if (runstate_is_running()) {
>> -        return vm_stop(state);
>> -    } else {
>> -        int ret;
>> -        runstate_set(state);
>> -
>> -        bdrv_drain_all();
>> -        /* Make sure to return an error if the flush in a previous vm_stop()
>> -         * failed. */
>> -        ret = bdrv_flush_all();
>> -        trace_vm_stop_flush_all(ret);
>> -        return ret;
>> -    }
>> +    return do_vm_stop(state, true, true);
>>  }
>>  
>>  void qmp_memsave(int64_t addr, int64_t size, const char *filename,

