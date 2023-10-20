Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E06FD7D113B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 16:10:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqBv-0002cq-LL; Fri, 20 Oct 2023 10:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtqBr-0002aN-VU
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:09:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtqBq-0000Xf-59
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:09:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KD8Ghu031580; Fri, 20 Oct 2023 14:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ihmxUgQ/VXjRYOhMCXnSOV7/oYvoz+6u1yDseuBpFuE=;
 b=QK56xTMZv5d7YI16vw3VnUB0WaNMoE5+VrXfkOsjtiVJQbbpmdJJ/gEymGZb4gpIMjAn
 hBqJTrKBswKYqCN3OIy61W00XB+J3hNNnA0BFRb3iYx2FkvBrJpkY84etNKLfrWbl6y9
 zlmR2pifrfTCLX5FmTEKuIyPKtpFd2Ozbccktw+BiOm7DdT3OkBE7PtKKoEQutu21M8D
 jiq0Ks92tnVWIhFkiTapKzHi9jNVLlrJEXGPFY3y+grlkC2Uj6aiap5xz7UmfZ75vtNR
 +Xzzfr9b99ToOpQqok8nZsA35DKOMUvuguCCRu4ZxSAY73rRQHNbyWMVoOel6SVPRo1Q EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwdhw9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 14:09:23 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39KCKxMt031488; Fri, 20 Oct 2023 14:09:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tubwduy1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 14:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3nc84IRfpvniyvSt7fpA1aW40Rcv+N6RmgbAmvYR/L6sdYZsxNjlbfG5v09l0QFvsRarKukynR4fMU7CxcIqugGrqyosnc7WwICw8D/hzUge9KqQBxrw646bmEbSztGILr+kGOSR2yXzVq+Gl/v8vTS9AKEUGyS369GwAqmwiLJkcRdRyS6jhgUDtB5K4+RrOLW8e58dqgRe2hyUFIi81IwZB3Loq85WvackxqMYmSyDWAxw56c9eC0ZFW5uqSbBMR5mU/NK8YdCxsezjStzyB25eUPHZTGfRXKvheL2Tw4f9aj1LIywJlWUpqbwDqE3mPfD/5FBMyMYutWjQjKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihmxUgQ/VXjRYOhMCXnSOV7/oYvoz+6u1yDseuBpFuE=;
 b=jE1UYsd6nRCfV29WzVUT+46buuAtxj5vlev3W+j1+Av0eRE7DSLEzqV+Js+W/u+LPYlmSNpLYDSAmNeJEUBv8I5WT8oT3/jqe3kKpRo9fGEnWE2ss+dZr2zFFNNs5gx8wrare9DUQqscbIjDcMHSErifjURAFTL5rAvgCc54hduyWv+ArJLHWr/I86yt4SNUwUDuTL9rpsgc387SavoSFL/HTrhH58Hg8lPKFQeY7gih+7b9mPa5DM1OTgySmyjABa1UFdw0AUvCgDd/0+FfL+HqqNo7eW7+5BQV0Tz+/Td0fAS7AnTlRJsAkeVYVI1rlLERAItdsA1b5f2CXehRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihmxUgQ/VXjRYOhMCXnSOV7/oYvoz+6u1yDseuBpFuE=;
 b=p5ZUUsoFjb3dPwEa6LrmKA/M2CEHxpkyPm5JtD1it8AfUkpWIe+nDAJ4TU43Q05vh4+eFI5E9ioU7Eqe5u5u4z/kvKlWGuULdRvHBOUaV9rA3Ok0j+1PtuBmGJGk6svNzKRsiYdpSIa5dNWGwft+ZfWe5qXa412DplSE4gl3Em0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 14:09:20 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 14:09:20 +0000
Message-ID: <2814d5e1-76be-4d4e-a76b-25b2eabd2cfe@oracle.com>
Date: Fri, 20 Oct 2023 10:09:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <87mswdzkyj.fsf@secure.mitica>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87mswdzkyj.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: a939f343-07cc-46dd-4e32-08dbd17627bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEsL0z8h4zWRaSDgX8mijyPKyDIc/wMiIBRJXTVznKNLAPwInaoOam93K4O3pLAwWqsVKiOpoDe3lB9Giu2hpYRFZX7Y1y9Xhle+p8ti22NOjfR+e+iiWx2uBPapXTr0BzXN3LS7B/G3wu/SYXM+c9UXjK5mmfyA1XUBgHghgXmgCJxBnJDGBQCYfF4ZC5LqETy1inOE8XawU7FqhWYp7orb0GTTAo3IUFtHqTRZdNxWsc2SMDYHn9m5DCbHLJkPiOafSkRD9bsjolKYtDBIPiJ3lelMsqGt+bpl7Udu2I4UYchoCiDGhas6Hy0MAFQ6GmuIoXjZZmxo5aPJIhXpdVCVwcqlxrBjMafHw/NQcKolu7ZzDr9rOt6k47g3uyvMGczSSazxzGf4lfQ9qZfff2+3LIGW9aodB6gobmcy4YmaXDImDifIcrcvsYRGQwzr9V00QuNThpYNB/kx+7WxADPHPNL/pegIlew8OwYnBeVGRZwy1kunajFZauWj5U0ajS26hRNInk78zIEu1qnBxlSaPAixsQbsJSmGZJFQ7cZP8TqQUj4rw+SpS/ajZIdy5lq1Itb+QiTUAkez5Z9HfMRCmIYegWk5mUMSLMSH0Qk6raaBEqPaQlnrQ0efqdFa4KWTvmLiZclVbtXe/hlVcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(31696002)(6486002)(66556008)(5660300002)(66476007)(66946007)(83380400001)(31686004)(44832011)(54906003)(38100700002)(2906002)(36756003)(8676002)(4326008)(6916009)(316002)(26005)(2616005)(53546011)(36916002)(6512007)(6506007)(8936002)(478600001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hRZ0hqN0VWT00vSlp0UVZHWUtFcmxTMVdyTkFBNmJGMWxqeHAwamNNajBz?=
 =?utf-8?B?RkNzN2k1bUFZSXg2NGh2WGZxVzZST0czUnBMSzdzNUYvaXJNakRxdXhKdzU1?=
 =?utf-8?B?WmJFOG13SnN2Y0tyR3VGL2pMaUQyVG9iQytFd2ZPcWlndjB3bjloaVVUQTJX?=
 =?utf-8?B?cm4wbmNhVXIzQnBPLzU0WFlyNVRVL3lPcGZuOVROemdScllCalM2SFp0MjNH?=
 =?utf-8?B?MzBtVHZhNHFFamtQYmoxUUdjUmhZaUJTN1JFWGlvYzFncDNjcXhCNWxMMXhF?=
 =?utf-8?B?dDBQTG1zK0gzeXRFb3RTUFNWZlRhNFRmSkdhR1k1RC9YU1BoS0dMZUFML3lp?=
 =?utf-8?B?ejRsTys2bHhtYUlCR2FST3dMOXJHUHVPMjhJZkJ2dTRpMTNxeWR6M3NYZGFq?=
 =?utf-8?B?QVpuZFd0ZWg0UzR1T2pYQ0NiazBaaHQ1dXhpbE1NVHFra1Q5SFpkc3VwUWEw?=
 =?utf-8?B?b1h5bXBaWFNrcmhiRjlHYVNxVi8zeFRyS1hhenlEejdSRjFUTENNWkxCTVdL?=
 =?utf-8?B?RnU0eEpHazNKY1ZRQnJRRG9zRDNrVS9PcFNBT0h2UkdHNDVodlh4OGNKUWdC?=
 =?utf-8?B?NmtDcUZQQ0tCdzZIYkhIL29OazdYTkt5QkpYaE9Ld1g5aGFXbVlaQ0pLUDB5?=
 =?utf-8?B?L2hyb3lLM0FJOU82cVI2bjRKQ050dUpMMFlGaS9qeWZDNEJsQVJnaDd3SnBr?=
 =?utf-8?B?NndQcDhiVUFOSWRpR1NtVWVsTUdpRlVQc3ZWZElQbUQzUjVHWUd4QUNhOGV5?=
 =?utf-8?B?dlNrd3lZcnp0MXBrUzNkb1pjRXhib1h5bGhsSHR1TDBHOXNialFKOGY5eXNp?=
 =?utf-8?B?c2pKRDlXMnpBWFVHZ25jZzJ5Ynllcy9ySWtZNWkvZ09KQnljU1FDZFRTelVI?=
 =?utf-8?B?L2pFSkN1bmpwTytHd09KWW1idnVkbHZUOG11K3JPWjhCQ053WmlZYTQzZjZi?=
 =?utf-8?B?TXpUYmFhV1g4clJxN29ERkxtRmdNYjIvaFk0VXVZYi9pUFU4Tmp6SU1HbHFP?=
 =?utf-8?B?ZUNLWDJCMlk0dTRMdFdyRnJVcGNST0tRSTJuRnBtK3QxVU5RWkdzLzdUU3NN?=
 =?utf-8?B?ckI0d2FRN2pGdkxsQmJWWGV1RTduMDF4SGZYNzkyL1B0eXA1WDV0cEZ6RU1T?=
 =?utf-8?B?YlpOdStOM2RiRVpkbVRpUnVEbnYrZU5GZC9SSHVlZ3RxOURoWitwVEtOVVFR?=
 =?utf-8?B?RXBid1NnYXJLNnZMSGlQRFlkU1JCYWd1dGdxS09TN1dFd3laOHhKTFhVdndP?=
 =?utf-8?B?MExaYjZSeGxFOXpVZXplUFdQeFVJTFg0bmhuUXRneFdOakc1WVZZSE9zSGV6?=
 =?utf-8?B?RXhFU3Q4T05VOWN3SkxXRUR0VVgzbm1Fd3J4OUF5Si9pOTFpckM5UTBQZ1RV?=
 =?utf-8?B?UmxVVEZVWW54QXV4NFhoL2YyY0JSRHpndlhOMUZjUjVxblhHMVNyUGlEbnEx?=
 =?utf-8?B?L0FMbFVLc21JU2JjRjRQOEhDTGJkaTFsdm5pR3QxMXNubVkxeExnajRVanNt?=
 =?utf-8?B?b1AwbHJudUNDdjR0enYyUUFWYmlHcWhMM0Vpdk55NlVCZlEwOEhqczA0cHFO?=
 =?utf-8?B?enpKb3RFYkJ3cm5VbmFkUUJLeVU1MlpERG1JdDVlMmVoU3crQ2RqeDZIVjgy?=
 =?utf-8?B?MVVIdllQT1BkcjdEa1BwRmk4QUlKZnNOUTNWN0ZDNUs4b0FmcVRBa21rRy9K?=
 =?utf-8?B?Yzh4Y2xZZmJ2TlNSMHRpcm8zQjdkWXNjamxDdkhnTHhVcHFKaVpjclRwblhj?=
 =?utf-8?B?SmJlYlFTakljMC9QOTMvWXFRaUxlbkhJR05LYkwyU2lLbDgvTGhDaSs2RXVj?=
 =?utf-8?B?UDE1NHZzTGpPN0g0MVRhemp4azE5UlhRSWkwcEtaOXN0WjJrMGt6RGJQNkJZ?=
 =?utf-8?B?dUg2RXJEdFRtWmUvUzBEWEwwVjNjMEJpS05qUnAzRDhRdEpsTHFZY04wNEdS?=
 =?utf-8?B?R1hOU1JkY0N1ZGdHSjluc0pPZWtkR0xsa1R2bUxhd0c3UitTMzhKZzhQTU5m?=
 =?utf-8?B?SHRYT0xHOFVLVEdUU3ViTmpyY2dDM1hmRVJsU2JuZVNOc3NWSVBWMUNZUWRa?=
 =?utf-8?B?Sm9JWStXRDNxcVd5T3ZZTHdtZEVickhFUUI3c1pIdWJ1UWNoaHp2aXQzTmxM?=
 =?utf-8?B?YVpQa05hUEFaSW5KS0dFbklldFlBVHVsYnNJMTJSaVJNcjBZVlNaam5VVC9G?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JNIRU33J5HGJX0Xjcy9iTtsdyhmoJfRgxUUfzGLw5d4R/uru/QF/AWXKmtoyP5412xPJ26VLKw5/MdNnzg1WmBNR/+aXoLpRMC8vR0TXFCW4UwoTUKhgVhexPrA7pWnodw8ioAtRxbFynhWcf7pYqEkDY8O2FtPbY8CzqkOixBwlf0Jd8ta9DndPtDc+DjL6DJTwFegK4Wru84IU8KMPYrdBJIHI+ZI+9I2i68IF8ZAXA+fximlllMGVlkGZbdUry63f5CdV6eeSw6V078hhIRdvqY8V/4AoyoiPe1ETBC1Cb0EEPhYdMS08xK+M9qNaEF9m/VyHrdicwEd14J3ZyCULRJ1k4rUeU+I+OxeG71EmkxYAKxzZBLqbH67wkj/z3J2OLuzjD58zf6mmXCIae6O0ujK08M1RU6pIdbQfY3QZhpNcWiwVSU2VN/b3XgxjS+gJ1JDF+/1zp/ijH1vHeGftcQfOUIMw4fg5Mz5E4w4C22/edkJ5ZcWNuR7QhRRgaMtmTxh27R1/qUPUXkV0Asv8r0YGqyeAqizhdeFFxizGUvIydirUyPyM8kwnXYromYHu9XOZUL49Off1w+Sl1dg7D8bt1/7lckMov0Smmlq+DN4vuhiGn9iRpW3x2c1IuaI3xRy5PALYo7q1wEePGefH33aCtlbMnr+J0WJDGBWcxtLLxay9nbj0PJnhZUwQIlDI/JtoZIOUlc5Gesg1tijsndz2xNSNny3U/Ew5ACIi0z6ouM2S8qAt5moMvf+g7ls2dawo/xP3ktE9qVY9lcenqrGKYDyVyTQWwCBQePw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a939f343-07cc-46dd-4e32-08dbd17627bf
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:09:20.7198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsTWVZUHLhWmt4ao3+NPDrVr3lpIdCLtKkS+5+1HP/u8kznv0avek+n/vJZENa+hUSJttcr5wwNyUDcBsHjHTbRkg5G5eMLpzvdCe2MUke0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200116
X-Proofpoint-ORIG-GUID: wEFrejB98DctYgNjJl2Gbeg68we4VN_h
X-Proofpoint-GUID: wEFrejB98DctYgNjJl2Gbeg68we4VN_h
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/20/2023 5:45 AM, Juan Quintela wrote:
> Steve Sistare <steven.sistare@oracle.com> wrote:
>> Add the cpr-reboot migration mode.  Usage:
>>
>> $ qemu-system-$arch -monitor stdio ...
>> QEMU 8.1.50 monitor - type 'help' for more information
>> (qemu) migrate_set_capability x-ignore-shared on
>> (qemu) migrate_set_parameter mode cpr-reboot
>> (qemu) migrate -d file:vm.state
>> (qemu) info status
>> VM status: paused (postmigrate)
>> (qemu) quit
>>
>> $ qemu-system-$arch -monitor stdio -incoming defer ...
>> QEMU 8.1.50 monitor - type 'help' for more information
>> (qemu) migrate_set_capability x-ignore-shared on
>> (qemu) migrate_set_parameter mode cpr-reboot
>> (qemu) migrate_incoming file:vm.state
>> (qemu) info status
>> VM status: running
>>
>> In this mode, the migrate command saves state to a file, allowing one
>> to quit qemu, reboot to an updated kernel, and restart an updated version
>> of qemu.  The caller must specify a migration URI that writes to and reads
>> from a file.  Unlike normal mode, the use of certain local storage options
>> does not block the migration, but the caller must not modify guest block
>> devices between the quit and restart.  The guest RAM memory-backend must
>> be shared, and the @x-ignore-shared migration capability must be set,
>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
>> reboot, such as by backing it with a dax device, but this is not enforced.
>> The restarted qemu arguments must match those used to initially start qemu,
>> plus the -incoming option.
> 
> Please, add this message to doc/<somewhere> instead (or additionally) to
> the commit log.
> 
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  qapi/migration.json | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 184fb78..2d862fa 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -620,9 +620,23 @@
>>  #
>>  # @normal: the original form of migration. (since 8.2)
>>  #
>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
>> +#              quit qemu, reboot to an updated kernel, and restart an updated
>> +#              version of qemu.  The caller must specify a migration URI
>> +#              that writes to and reads from a file.  Unlike normal mode,
>> +#              the use of certain local storage options does not block the
>> +#              migration, but the caller must not modify guest block devices
>> +#              between the quit and restart.  The guest RAM memory-backend
>> +#              must be shared, and the @x-ignore-shared migration capability
>> +#              must be set, to avoid saving it to the file.  Guest RAM must
>> +#              be non-volatile across reboot, such as by backing it with
>> +#              a dax device, but this is not enforced.  The restarted qemu
>> +#              arguments must match those used to initially start qemu, plus
>> +#              the -incoming option. (since 8.2)
>> +#
>>  ##
>>  { 'enum': 'MigMode',
>> -  'data': [ 'normal' ] }
>> +  'data': [ 'normal', 'cpr-reboot' ] }
>>  
>>  ##
>>  # @BitmapMigrationBitmapAliasTransform:
> 
> It only works with file backend, and we don't have any check for that.
> Wondering how to add that check.

Actually, it works for other backends, but the ram contents are saved in the
state file, which is slower. I should spell that out in the json comment and
in the commit message.

> Additionally, you are not adding a migration test that does exactly what
> you put there in the comment.

I provide tests/avocado/cpr.py in the original long series.  Would you
like me to add it to this series, or post it later?  Would you prefer I
add a test to tests/qtest/migration-test.c?

- Steve

