Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AE7DE1CC
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 14:58:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBix-0004N9-7G; Wed, 01 Nov 2023 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qyBiv-0004Mj-60
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:57:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qyBis-0003V4-VJ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:57:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A1ATNt7011709; Wed, 1 Nov 2023 13:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HL7UBcp57Ek8qxHYw2z/pU+uaUvgnxpkDszvqWp2FBI=;
 b=l9bKLmRiMh4swkDo7dOhYGIk7+s+f3YaTtFKFJS1Vjo9QEymBB2UHGRohIrkXZa0Oc8C
 nmnK6b38p9HT3Jcr6o7fPtcH5cDZoxO09pXfgsq4CWueMAj99tn7Bf5h1hI9vvMmvWGJ
 H8MU9k19DcOe6QbQ3nzdRJyUEBcktlDWiV/Cx14CILgRlutgbjg5tkaWgQkCmObA5+bu
 gMYoerd8cCMqZyvvWSyasPfsiNSibWrJr7WiUUuvREuEcrc4M5VQqyShOkyQM02hCjwo
 GaGO8YUMzb6JngR0lYDxT2RvfzdGwk1NhsQsB1i7EPDiEUNcHSntvQX2gmhKcskMx3S4 Og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33yk7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Nov 2023 13:57:27 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A1DL8ib022484; Wed, 1 Nov 2023 13:57:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rr738u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Nov 2023 13:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF0DfCQspNwGJd5X/Hf6NrswLV2uoL9LKRybMK5PFjxWADvzsB31YXVex1CIQxcnKP3XU0Fl8c5I6TGYWGcNapsmycNHWADmlyTCcANYrTZWNVW20sDNYJ5rgmHd/FxhCoz7REW8kyzIO+lb4InlPQOQs4nCqU6xe2fCPm/waPCpywVhhklHDshb0uYVfOM0KvZmfs3syLC1TG1udVDGwgBdforRS0BQJqHO49NnGuwl+LT0ZHg2YjoccDo1yHhxaHzuEsnneE0S9Qqb1Arh6aFXglLqmY1LYT8FhmfxXw1+tp3OUEmyYOk4KUb3rRkkCiA7MOqP2enJerWf0PY5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL7UBcp57Ek8qxHYw2z/pU+uaUvgnxpkDszvqWp2FBI=;
 b=Ir+6+9gN6VzpzR6PyzxAzn9/Nij2IfhScXHBH/SsNDPjGNOqdV/xYlsdIxRZ/fjwf0eak3xlyOM38PJoOe4Rcr1YUFRXvFyP7aZ8SesO9zBZDnCv7AFY4Sh8RiexKBsJ9S4juEP2RfGL0eBZogCBt3dw6ykwTCqM0YJXv3G9IHZdN5hHwnn8NQgNxV7OjWFxEUQTweTUGjt4PmVzgGnDj6NptuLbuvU9jeeMcLHHXU34VxRPE+Ox7ZLrIN9cO/6gKQTfi4t2cdNrZQYWDkpq0E094ZGA4aKYkp/qUlRpeank3ARTY1zzmaRtRgMRmrdGTQXHRsbaqckIBNjcLfdfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL7UBcp57Ek8qxHYw2z/pU+uaUvgnxpkDszvqWp2FBI=;
 b=pt4uy8h8DdErej21kLKn27mTjl8SuDpQFkHhzQyGE/D2DnfZ43u3BpYpDZxx7boj1pw08FdWQF9NDz7N9ImohR+qfqOOB+63hqAZ1zzjZ5BcQwXCo+Ht+fyFWqfn6NrgXWwrJPqRtPCp/ng8QNTw0Hr4E/mH5smZWHpTPf9FpgI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB6517.namprd10.prod.outlook.com (2603:10b6:806:29c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Wed, 1 Nov
 2023 13:57:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 13:57:24 +0000
Message-ID: <19355543-0534-4f9e-b85a-54b8f46e73b6@oracle.com>
Date: Wed, 1 Nov 2023 09:57:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/6] tests/qtest: migration: add reboot mode test
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
 <87ttq5fvh7.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ttq5fvh7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9103b60c-4f57-4a7e-7c07-08dbdae2799d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vv/hw5x+Fhvoxqng6M7xOGCSJmvu/n4htYwEsl55rl8Gvn43Bu+sEXYz/nifM90IBdQ1H3VgPvYbIqsoI2JxbA9Gznr4QPZHLWXze7CZXtDR30FD4QVCDwLZHxRYPHUfVUdb7jqBnk6nMfvDLqRS2LgPWIKc/4W3ZuGZHRpaCWoEiagEXQPggXojwIh2HxucFq2e77D02BXsK9kqg2rzAKAq5t+WFqVBPbHYgqHa2Mx4AynIqM7tIneYJOCsNJc4Bm1b84v+qipKZLnF8iIyVaRI8IgZs87HkZRBo+HMnG35BSqLAu77Homt4XDtsB0cF1xuhQMPhEDVwzAk/fTxn6iso/FCFqQwG1178hivrGYuZ3H382VsZAIGx3Vtixlb1PEfzR6OMT8uYodYPe2P7nRFm+9u7bC1HUNhO+QzNASri3aSmHQ8fnb1gYe9g3xo7bssZKGPkzIJL4ZKzv0C4bsGyaEoHwvP8qivA62IwQLcSt+atUcjaT0Zoabu0pgueupbL4F4hQDO7vt04a8zepdIaj4iMK28K9cbWx82G0dhNrOG69b3Ddbym+p7VtV+piVPIxK5qkNo135vxIJdCtm1xCg0ivRVpG/3ge1wtMv+/odTaCZEXafvgH/zrvj8M92nrjRFQZjZzdQzHJg5Cd5NDErsm5C+VX+9j8tYf8RSm0XPN46k9PfBabYqIqOH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799009)(451199024)(64100799003)(44832011)(5660300002)(66946007)(66476007)(478600001)(36916002)(316002)(54906003)(6486002)(83380400001)(38100700002)(6512007)(6506007)(66556008)(26005)(6666004)(53546011)(36756003)(2616005)(41300700001)(8936002)(4326008)(86362001)(8676002)(2906002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1RkcEYzU2VuVDM3KzF2SG1ESmVDNnBmM29yclg3ZFNKUHpwejBOTDIySXRP?=
 =?utf-8?B?UXRNWjk5V3FaSFhkT1dYYXBkek45U0Rpc0RMVlArcStLNlgwYnV3UWVBK1Nh?=
 =?utf-8?B?dnpiaXdpejVtMCtKbmh1Vk5nczg2cTZ1a3FTMUxYUzcxMlErdlVCWWhtbkM1?=
 =?utf-8?B?eE9lRHZsUDRRQ21adTE2Sm1MbE84N2drOUl0WGFMSUhhcnArT050VGpqTk5Z?=
 =?utf-8?B?dkxMK1ZiaitiVkluV3dsTnZ1c0tKb1ZKaTVmN0VlZmR4MzJhbnJoWkFtbjZ2?=
 =?utf-8?B?ZTZJZ1RIYzVkUWhzMzdDYmkrVCtiQVRJYTBuYlhISmRsU1FsN3h2bEM3b0JV?=
 =?utf-8?B?SEFLM2d0UlQvcERPREIyRHFBRElrWTR5SUFnQjZmMzRQR2RZNmVVd2V0NGZT?=
 =?utf-8?B?bmhVMEwvWjh2MVpHNWZZRHBncVBtbVk4T1JVa0RkNkVmc25hdFYxTUNDRHFG?=
 =?utf-8?B?QUdIcnk1K29PMDBqRTd3VmZYcVJHYVRiVEdQb0hnNERYa0d6L1hqUlZVNUhW?=
 =?utf-8?B?bVV1aXJpcm0wbC9VNlh2dk5TMkxtVHNXdXJ3V29wNVArTVFFOTB2ZnhrbDZt?=
 =?utf-8?B?b0xhMXhJSDFNTm1GNHNzL1FyT2w3MURKNUJJOHRlZWdLZUY1clBDQzNoS093?=
 =?utf-8?B?cW1IZFBXc0I1NDZER0pHVEJ4Rmg2NDB6OW1IMW1PNDFyejRtcTg2bkx1NW82?=
 =?utf-8?B?M3ZpeEo5ZG5uTEJuTk4vNDU3QzQ5cTZJZG4zUVpRTFdyTVBIYXQvT2VCVjRo?=
 =?utf-8?B?QkVUZW5IbnYvcXBLTVlqQ000dmw1U2JnTjMxSzcrQWVVb25xc1RJYUo4T2VU?=
 =?utf-8?B?dFgvclpRQUpzNmFjRUFOcVEwc1Z0QmV2OXdUdmtORC9NNUo5WkN0R3Y2UTJP?=
 =?utf-8?B?MDVvQVg3YTB0RHd4ajNmbjMrcytQV0x2NnY5MGthd0xtRXdiellNaU52MlQx?=
 =?utf-8?B?NDdUVndYL3o3cm9YMDJuR2kvbjhuM1YybkFieEw4QlczNkI3U2VpWExCV2Jk?=
 =?utf-8?B?Qlc5TS9jNU1uYjBlYkdSSzRnOVhJNms2M0tDcWhNOEhnZy9XbnBrcmR5Tmcz?=
 =?utf-8?B?eVA2ODduNzQ1RjNkNkZ3RkYrUFNNQkdKVlNaZGJaSnpUNmxJaVJBcnNQQjNK?=
 =?utf-8?B?b20vQ1NOdmw1cTFOT2ZyYzJ4YXV5dk1zeXU5KzlaOVdiT2xZQ2htcW9DdUpR?=
 =?utf-8?B?ei9wWEYyVkFBZU94T0p1dVdTYkUrZWZmUHBPdHcwdy9wQWRXT2V4Y25xV2g2?=
 =?utf-8?B?NnB3YmFZS3Vib1dMSlVzUXI5dzJUenh0Z2h5Q0dnVlBYOUpnYTZnUHE4ZXpt?=
 =?utf-8?B?SWlaaUZOVGM4SThHTTMySzRFRnVUSEZBNTlocnhpRXprK1NOdENIb2E4d3Rt?=
 =?utf-8?B?RDRYUDBock1KZEVUM1FPUndWOWE0dnpuejRmdUhTbHRQQW41dFNJcFZrbHpB?=
 =?utf-8?B?SkVpVlNpNWNQNVB1L240czRTOFk1Ym16M3JLR2dwR3BvQ2R0d0ErNVljcmM1?=
 =?utf-8?B?TGNsZEZFTGQ3cllUdnZHczNxc2pESHFwVFVCWnppSEJXZUozS0E5TmVpTk9G?=
 =?utf-8?B?M0JHaHBkVGRmUnNiWkZEcHREV0xTVXZ4d0hEMDlJMFRFV3hCWW1CaytEZVFN?=
 =?utf-8?B?RXJ0alJiRnRUQmFsM21DYWtVNDVYd3ZPZnJrck45d3hxd09pTXZZbWhpbXp0?=
 =?utf-8?B?VGRVRUVwdVhmcmh0Rk9zM0M5QmV2VkRPakhZdkRpcHBuMHFCWCtNMVpnaTFa?=
 =?utf-8?B?RVBWdnhPNkpVUzVOeVBHRmcwL0FSblA3cmYwcTh0aExwa3VxZ3dmSnVvbnI2?=
 =?utf-8?B?NlduVFR4YnN3UXdHN0hFck5IUExOVnZNdHdZT0xVVFVPQ2doNWEzVGw1MGFZ?=
 =?utf-8?B?bXlEN1dTTnp4a3NiaTJPNXkzN1V6d0FBcDBBbFpvdjAyWGZPOXJQcU41YnRX?=
 =?utf-8?B?VXcyWSswR00zOFVGYVJZZU9paUFNMFlCLzl6YXIxbGwweWk1Q0lUNzZVV0pY?=
 =?utf-8?B?TGFmZ3VtSkp2Wi8zSEwxM09FWG82dnVkQ05TRlROZzJEck1BVUNLTWduRE1l?=
 =?utf-8?B?K1pGb25OUGR0M2huTWg0N0dTbHVyYk9CbFlzNHVFb1F1Q2VxRUprWFA1R1Rs?=
 =?utf-8?B?d1crTUpRK2pnMC9lb0RLWkpYb1VxS1k5U212bk5LTkFhak5UTmcxMjRDYmFH?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kKez4bTVX+R4HglKVLaeNF1ULIM81QhrsQO+cZ8/XUb+sRCPs9TKRAtGK4XY+BH/Ht56xj5tAu7vlwCVoEjyWw7sB1Z/5JTa17AP3SyqFk/hcgQus64FD9cmUFCStIFmCt4c5sbRhgYDTXx/lyflW+KEP7iORUiHlUjcMfXnWVaLb1c8BgNvQryBDAY7hm6KImsahDwjx3bYRi1eE5Inamg+fa4A9S8BpXBtSN1evknf00AJNo+5VGO4Yilw0SRmyUuoIdfB8Ae7vuw5ZQf3geUkoBdo+jpe7BV5IU2SL1Mnd9QRh+qgtPGR/l4Q34KNyOo+KPkGm9oVjZmJHdyL520MjXKjv187m4LKKjfhpGSJe2tOkXAWaA8tSMbCux6FhrhUOWlVmk6P+VcZe1PFpEzySGQpS3i9ZOI+ZLibqJPjAN0/IqJgExSCUDZ7NKwZ7hyQ73LEmZbWoLfffwFE+lrL4vOM7Y1ntnO7wizmpHVSBEpIWy2s2LxjMCDwFFkcNiHb2sD9aauQ5kSt2rO7GqQY/26wvvCvU4JrOSSWXLyeeCgtyV9J7WwCG2P/1GrSIJlzUu8iMpiTteVIR592at5ZNeHjpdRdkubJk4A2Dqv9NnHoQSb9ePuAQezoDE1tiMuVKAqNynuxGUDuO+SZQFQXbS5/ozIw2PDtLEQxp6oWlDGuHqer4IYsQt9QfR+18Gb4YjP/bmVJnwxfi9LUflyHpcyzvI8rBzwdtqGGReYlP2yzHAWsQaKK/q254UbjutJAMALwpBnPA6VpPgUBa/WoxghqC8OVFrmnOsa9nso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9103b60c-4f57-4a7e-7c07-08dbdae2799d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 13:57:24.2818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCUee6hPziO/yu4QBh2cDw04SVeMxuwGeldRRK1Y4zASwznChp8SN6DO/4OwnJ2TVf+sDkgVyqh0Y0v2C3DDiC5qeh+RqxYiIgE/OnBI2vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_12,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010117
X-Proofpoint-GUID: eQAQr53bpdjXR_zV5b_VfWr6TSSlgEb9
X-Proofpoint-ORIG-GUID: eQAQr53bpdjXR_zV5b_VfWr6TSSlgEb9
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

On 11/1/2023 9:34 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  tests/qtest/migration-test.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index e1c1105..de29fc5 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -2001,6 +2001,31 @@ static void test_precopy_file_offset_bad(void)
>>      test_file_common(&args, false);
>>  }
>>  
>> +static void *test_mode_reboot_start(QTestState *from, QTestState *to)
>> +{
>> +    migrate_set_parameter_str(from, "mode", "cpr-reboot");
>> +    migrate_set_parameter_str(to, "mode", "cpr-reboot");
>> +
>> +    migrate_set_capability(from, "x-ignore-shared", true);
>> +    migrate_set_capability(to, "x-ignore-shared", true);
>> +
>> +    return NULL;
>> +}
>> +
>> +static void test_mode_reboot(void)
>> +{
>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>> +                                           FILE_TEST_FILENAME);
>> +    MigrateCommon args = {
>> +        .start.use_shmem = true,
>> +        .connect_uri = uri,
>> +        .listen_uri = "defer",
>> +        .start_hook = test_mode_reboot_start
>> +    };
>> +
>> +    test_file_common(&args, true);
>> +}
>> +
>>  static void test_precopy_tcp_plain(void)
>>  {
>>      MigrateCommon args = {
>> @@ -3056,6 +3081,8 @@ int main(int argc, char **argv)
>>      qtest_add_func("/migration/precopy/file/offset/bad",
>>                     test_precopy_file_offset_bad);
>>  
>> +    qtest_add_func("/migration/mode/reboot", test_mode_reboot);
>> +
>>  #ifdef CONFIG_GNUTLS
>>      qtest_add_func("/migration/precopy/unix/tls/psk",
>>                     test_precopy_unix_tls_psk);
> 
> We have an issue with this test on CI:
> 
> $ df -h /dev/shm
> Filesystem      Size  Used Avail Use% Mounted on
> shm              64M     0   64M   0% /dev/shm
> 
> These are shared CI runners, so AFAICT there's no way to increase the
> shared memory size.
> 
> Reducing the memory for this single test also wouldn't work because we
> can run migration-test for different archs in parallel + there's the
> ivshmem_test which uses 4M.
> 
> Maybe just leave it out of CI? Laptops will probably have enough shared
> memory to not hit this. If we add a warning comment to the test, might
> be enough.

in test_migrate_start, I could set memory_size very small if use_shmem, and adjust 
start_address and end_address. Can you suggest a safe size?

- Steve

