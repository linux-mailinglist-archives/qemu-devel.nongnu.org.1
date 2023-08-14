Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4821C77C016
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 20:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVchh-0005Tm-KE; Mon, 14 Aug 2023 14:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qVchf-0005Te-UD
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 14:54:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qVchc-0007pl-Lu
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 14:54:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37EGTXga027431; Mon, 14 Aug 2023 18:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VR2uYfBHpre2l7/e9NuV9S3Tk5I10VayJgot0LuODSg=;
 b=Tf41FGfzXRYjg5IC1/qWpRjDmM5EbIey04EgXLlystpdZt9qTMH0IFOxqie7ErmARiYC
 tXfY1IM3JuiyevEoar4MawMNOlPl6og/gIz40BoZdjRwFdqWq3JJeHwi4kb2Xp81qLcW
 1R2OOPGXe2wERxRvOtYdALHEoxqLZMN9Zh1Nsbuc5Y3z2Wb/gPtrnqeIVwtG4ppSR9UO
 Jr92ULuCq1uzfYyr+xOSLuqQp1tmxUGISKd8PPRU/rh4waH+KO5FlT9Vv5TWHeNiYg6Y
 wnoGz1dPmsdvlme0lDPUaMsTsTN/R5IaroMJEp8W0t/AFqejnGqhnNpncBWUYVnpVXtI tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2ubwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 18:54:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37EIi7AF006771; Mon, 14 Aug 2023 18:54:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey2c8whp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 18:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhuX+8O4JcI/rOlTpenDAGfbE0iO/uncGBfd2GeCPn36umUq+4cBqUOXQ40qSt023vpVLTeFIRSFaar/t64p0bse0ajcDh2iDYiGFfgKJ+sKVf5SxcqSkL5p2za1R/1Hq6ssNWUnGwPBschUGX2/SFzKE51d1HNm1HKxvw165K65FFEqH0UJudSWWY+41iaHToRmgYtxf/OszB3hkNvb7jb8rVuP5Q16Ut1AkZuFY0VTAQA8ej/StmWm/fq6gxJ+ztEUwdxGP7JDAHzmmW69cbQWy0mvEVhS6vzveGXSVRuXFJ2uFcF946M/wy1CBt+JLQWfPvtFaoe2KVZELV6vPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR2uYfBHpre2l7/e9NuV9S3Tk5I10VayJgot0LuODSg=;
 b=acCZzkdT50BtC2NlRF45hVsgRnAZBog4wiQq0Rsz9j8fXkpSLh+qSyO87T20TBLWHwcIgTLqO3l6h/n7CG0SlyjTRo5aa5SYy5cS4DZfgRP6EmQrEsEhYhp6JwYigj5ESnqOAP53oVM54MJ+bByjVlrN3qWjGCgoR0B/MfMtKyeM05zzcu50DoJOeP9rgVoy0ztSqGt6kJ7LxdGqEWqmrxFtFFjYsFNFXVgSAr//y2R7aiud3p+nbJJ6vlCI1EZSgFXmmm+xVKq8G+REBHgsmkYWy3lt2BGURMJVDyOA4KL1+FOf6lkJwcabjZbDQFoZzufF62rHcHAp1c84+Ic4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR2uYfBHpre2l7/e9NuV9S3Tk5I10VayJgot0LuODSg=;
 b=dDDBdkPy627iH96EvDT3T/MVwbCG2UIvNVruJNmL9qs+rK+HiEmFRPKkDBLXdrc6NSqUla8ZBVW55R56yEFw8BARKruD7rox4fkyzZyHsWuqDD0NodjD67nO/F4Uebbjzo3k7Ow4aPUlgKsifeuHSVF9MJFzl/pd0peTCfebWcM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB7002.namprd10.prod.outlook.com (2603:10b6:806:344::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 18:54:00 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 18:54:00 +0000
Message-ID: <9383f79e-561a-aeab-5df9-0501e8d0a831@oracle.com>
Date: Mon, 14 Aug 2023 14:53:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n> <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n> <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
 <ZJnYlApmsQLXBK/3@x1n> <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com>
 <ZMF/ly/FyavT9AMJ@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZMF/ly/FyavT9AMJ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::25) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 725ededf-80b1-4e4b-2623-08db9cf7d257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPrOHytX/Dk6r9xRo89qaX9bWSeQdVdjQUX/Do53uHi8wm52byJSgkttplxN6uKfe4wr8aNNFVfKtMvYnzA9kDDLSlVjH5nhhj3Nz06iNfXc4JvIjA1FbJNl57kkvFsdSaaQbiCSfsKjWeRsnhSAJI6AU5bUS0Wnxi3LQEypWxcfKkS+HRf9BhDuozYglpVGp6V30WBhE7GdnrNV7839VRWhViKiMJ5iUSpV4a+jg+UqAXkif7VHT1XNuKi0Rb0vV3Afk6/Mq6SNtN/GJndDR8eYUxjHE9j2CjUHzS13u2FIcfcFXDWW7uyB7UR6jjlrX1HEBCV7lam3MgYM88CCgTmryELwOVLyGRkp8BLOhllRsKDMji0d8VB94VQY1usHzx9mOPXUqtvPjfeqt+btMOTz5aY1SsB1DkaMwZWRyFAI2YDzgP/Xd7cXzp3/z4Zcf1vAuj7sCbsD7TihwBkxbcxKPgWfsX0KZbefFxV10+1aHM0jmPlI4MAcAsOUdbqk/ko2WqUDgmMY0060LUvIrmatRPe6N6DdU/ZSGhgvg5pZH36wgv92Q+Vzkmm+kCGxPMH3+nfiL881pd+Dsp/bdAATimGBpQjmvTAJ/wo0w1pbRP2db6EM3P0ZTyh0b4XjgTCpOpeCY8G+8FOobHXBew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(396003)(346002)(366004)(136003)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(86362001)(31696002)(41300700001)(478600001)(66946007)(66556008)(66476007)(54906003)(6512007)(6916009)(316002)(8676002)(5660300002)(4326008)(44832011)(8936002)(38100700002)(2616005)(15650500001)(26005)(6486002)(6666004)(2906002)(6506007)(53546011)(36916002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitVMSs2Y2pqMUlhVWFRMk1hRjQxNFV6WjRhanczMmZISHhpZmxXeFhQNk1s?=
 =?utf-8?B?czc4ZTBKYTd1RVVBT1JaSitwL2RaZUw1bWhwZGRYY1lHdnZCTk11ZWNrWFQ2?=
 =?utf-8?B?YjFQU0dKb3NldnZDTDdzUCs1akw2ZGFIdDdTbEhKVFlMQ3M2VDVuSEd5VStL?=
 =?utf-8?B?ZUJQbUNURkpoSjlCVGxzUWNzWVJPZEl2L3YrTG56QWcyRzQ0MFlsa2hOUVJv?=
 =?utf-8?B?RUwzc0swVExYOURiVFdJUVNZQVQ4OVZEUGtuUWNHUU94d0twR0lJalBHWFUx?=
 =?utf-8?B?RkRkMFhDVnY1TWFHcDlsZWRjM1RFZ3VDQ0tLZkZFQ2dIZFhna1FtS092ZFRz?=
 =?utf-8?B?eXhBU2FxUExKSjhleWFLelVuajU3K1FYQ3k3alJJdVBSRUgzUkdYa3RsZFB4?=
 =?utf-8?B?cGlHeHRrODcrSjl1MlZxaDZuWThGT0MzTE4xY2N0VkRJa29lWXRvOXlhNXUx?=
 =?utf-8?B?bHQzL1Q2MEU4cFNnL1ZhaU5zZVhxODI3TWp2bFo5LzNxTTFsRS9RSTI1cm9o?=
 =?utf-8?B?OWJkQTgrbkoreDV1L0t3Wmh4TlV4SzJWYzhZNTMxNHNZNFpQcGRwbTZlcm1Y?=
 =?utf-8?B?SzFqZjYwUmZXaTh6cytpOVRQbk1CV015QkNRaVh6TjVjMk9HcDJGVFJPWTU3?=
 =?utf-8?B?aFNWc21XdHFjN1ZpZU1lc2h6ZVhqdE54Vkg4ZjRHS2VSdzZKL1pDcTg3Z1lP?=
 =?utf-8?B?Vzc2MnRwbkRWNjM5bzllV2pFM2RvWlZXYXdhS2hNTUpBcC8wcFU1aGJHVlNL?=
 =?utf-8?B?RU9EVjF3OGZBeDV5b3o5cGVTOVppL1BpZ1pMQ0NnUzFKVHl1cHVFeTJJQjhR?=
 =?utf-8?B?eHJreTBTZUdxd0U1anJsVUJFVUlLb3lRYXlIaUFlQlNHY3N1ODBidmtmYU1Q?=
 =?utf-8?B?b1dGZzMyOXdNc2hFMjlXMVZYM0xnb09kTm10Rkt4OFlPTWhUS1dNSkJqMnlN?=
 =?utf-8?B?U2NZRXBFRFg3RDc4Uk5tMDlsa2YxRmVjalVBenZtd083RndWTUhsOGZJUTBG?=
 =?utf-8?B?TDJtS3JKYi9YbEp5akhQOXdhcWJtcGw5emM0RXdLUjRPRVpISlZpa3NWeUxv?=
 =?utf-8?B?aXJmMFpBa0liVWZVc3lwVkRobHNDNEZpS0ZZNHpUenVoTDZ6cFl4UU1mNjlx?=
 =?utf-8?B?ZytidU1NeDlDY2ZYVmlVZWhtUzBueC9UZ3dDSzA0VnBDVWhVRktDbEltK29t?=
 =?utf-8?B?N2UwT05sQjRiZnBjUk4wR0w1cHB6VnpCdlhzRjVCZlZJMTdTYUJDdXNOeDdr?=
 =?utf-8?B?L2JaM1lJSFdwVGhOK3JYTjhHZ0E3NzVIYy9DdHp2RXpTM25ZSjNOVklRL3BN?=
 =?utf-8?B?YktKVFQ0TnUxcXhJNWdUREJFSmh0a1hDdHdGTDRHQndhSTFjMS83MlVHV3V6?=
 =?utf-8?B?UzBjTkZwN09iczBUdEd4RXQzbURvRCtORyszcHA2dUF4RFpYNVRkSkxWZU52?=
 =?utf-8?B?R0tsbEh5SjZvRVd0d1lqZzVxUTVwVEhKajdKdHFjRWMrdm1zdU1YdTlwYkN1?=
 =?utf-8?B?NFRVaUJZa3puQ3l4SkNCL25nZ3lDR1c5eUk4ZFpYcFNMMWFRbHljbEhiZUdK?=
 =?utf-8?B?ZTNoNHhpUVUzUkgzb2hvRGtwcjV1U29LZzNHa0RIdzVWVTlXTFQzK3F1bXpU?=
 =?utf-8?B?WFlkcXJ5OXZxUE5wTmNIc2dVcG51L0xTOVFyYVJtYUdvMUIwdk5jNnRuUWd0?=
 =?utf-8?B?WXFmQlh2Ungvc3VyRVBmTVRFM1g4ZGNwbGgwQWNyYlJYZ1RBSHIwRkREMlZa?=
 =?utf-8?B?dTIvMTVPa3paNU1iVlUzZ3dVdk05WmlTNWdKYTF4cS9sMDNGN1piRlNWQUFX?=
 =?utf-8?B?eTF0QzJJdWc2S09tWTBLY2p6STEwTEVFNW9uS0RrL3BadmV2M01OTlJ3L2w4?=
 =?utf-8?B?U2dvcGRwKzRkNThrcXBIb3B5UUdBMHhtaUhhbEZnYjJRNEF5V0xyRTFpR0x1?=
 =?utf-8?B?NlgwT0JxRTQ5VUlOTVZOVHNtSTZGN0gvNEN0bGt0ZWJheFkzWFNjNGswUUJq?=
 =?utf-8?B?U0RnRUpFMlhLT3NXT1NGWVNWL2NHbURLaGszL3MvTnhpelZycEFSbGNtSjVs?=
 =?utf-8?B?TkdhNEZ6aTc5K0E3andEU2dvdVVSVEZBMC9seE9sVEg4Q3RKUWZoOEVhVDhG?=
 =?utf-8?B?Y3pONStGUzVzamg5QXRyZzJ1S2MyMGI2OFQzcFVIV3dudlB3R2pHbWtUVmNX?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TvBcuJfAQAHgIDMWgJTk1UKM7dvcdNbBXH2IKJIxqGuabPp0o089aWpRRClwfguYEz/9/wocbXOrDNLm1KvrapTE0mfPoRAXt4yqdQq4pjgYyigNZCBuqL0Z7WyCWyEQlmyyvif2Xlb7OQxjJm9cAFE6HBq4Y9A94pDwi9DN5yI0T7olmzXnWzjMooPm8+fdXgl+GziMP2dTZQLcxmnjunNTwzPLrQVJ0l8s1jBl9OpdhMSLrmtZMLeIEMriI65OmdG0RZ1lPM9CNWVZ1GKDojLLGEQQN1uTdaY1TUHRVw8AK3y6iNMn8Jkrb8okdWsZLe9xaoNW5TiiZ/YUhA0dK35jWh5p89s/Qagzfm6ykRc4MlJ3W8FWUUGx/jCPoYn0CAqm/EpLfGLYERRJCQd/z5Vndbi2T/FlIk5klhY4j3T8ps3x1Eh2Qe7HWD2uPJv+BCCkkWR0lEH0dau8+/PfC1UT83gZVoFzlHorMmwbYBmRpEjx2KMU1S8so/plRWue68Hn55b4YIf/uhNvBa4PnJbJbZL59CQln17DMt37JR3/ybTrc4EtQ7dio/++PCNoBFeukXRKH7rr+73I6tvDjAlI0Xh1QL9hgkrrGte5v5dnWxG6d2MHMd8WK/auxD7ajEbw+zSP1943W1R4ULqyVLt7Hnwm3neS11C6JMa7nw6gC/dSrwpRrcpCDu09MK2wdFsP6LSp8msLzrKtjMXLTRNp3mfkyH+dRsgAkWgjBBTiC6lQZFB0tD9XMpxMOpyF4FakFev2Sm//fjwFh9yAaA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725ededf-80b1-4e4b-2623-08db9cf7d257
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 18:54:00.3909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYrFJ2uxzSffzS+6aK3VeXXP25tlMJ0CSMv0YGxJVXWbyWtN3Rrbs4J+qU8rjyGp7iZfW14lQ8vT7hwJlgELdfEmerVkt7HO51sA3a6AsBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140175
X-Proofpoint-ORIG-GUID: xf8kwKddGikNy9wOx1qW4vubv48JNnf2
X-Proofpoint-GUID: xf8kwKddGikNy9wOx1qW4vubv48JNnf2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.265,
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

On 7/26/2023 4:18 PM, Peter Xu wrote:
> On Fri, Jun 30, 2023 at 09:50:41AM -0400, Steven Sistare wrote:
>> On 6/26/2023 2:27 PM, Peter Xu wrote:
>>> On Fri, Jun 23, 2023 at 02:25:05PM -0400, Steven Sistare wrote:
>>>> On 6/21/2023 4:28 PM, Peter Xu wrote:
>>>>> On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
>>>>>> On 6/20/2023 5:46 PM, Peter Xu wrote:
>>>>>>> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
>>>>>>>> Migration of a guest in the suspended state is broken.  The incoming
>>>>>>>> migration code automatically tries to wake the guest, which IMO is
>>>>>>>> wrong -- the guest should end migration in the same state it started.
>>>>>>>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
>>>>>>>> bypasses vm_start().  The guest appears to be in the running state, but
>>>>>>>> it is not.
>>>>>>>>
>>>>>>>> To fix, leave the guest in the suspended state, but call
>>>>>>>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
>>>>>>>> later, when the client sends a system_wakeup command.
>>>>>>>>
>>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>> ---
>>>>>>>>  migration/migration.c | 11 ++++-------
>>>>>>>>  softmmu/runstate.c    |  1 +
>>>>>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>>>> index 17b4b47..851fe6d 100644
>>>>>>>> --- a/migration/migration.c
>>>>>>>> +++ b/migration/migration.c
>>>>>>>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
>>>>>>>>          vm_start();
>>>>>>>>      } else {
>>>>>>>>          runstate_set(global_state_get_runstate());
>>>>>>>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
>>>>>>>> +            /* Force vm_start to be called later. */
>>>>>>>> +            qemu_system_start_on_wakeup_request();
>>>>>>>> +        }
>>>>>>>
>>>>>>> Is this really needed, along with patch 1?
>>>>>>>
>>>>>>> I have a very limited knowledge on suspension, so I'm prone to making
>>>>>>> mistakes..
>>>>>>>
>>>>>>> But from what I read this, qemu_system_wakeup_request() (existing one, not
>>>>>>> after patch 1 applied) will setup wakeup_reason and kick the main thread
>>>>>>> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
>>>>>>> the main thread later on after qemu_wakeup_requested() returns true.
>>>>>>
>>>>>> Correct, here:
>>>>>>
>>>>>>     if (qemu_wakeup_requested()) {
>>>>>>         pause_all_vcpus();
>>>>>>         qemu_system_wakeup();
>>>>>>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>>>>>>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>>>>>>         resume_all_vcpus();
>>>>>>         qapi_event_send_wakeup();
>>>>>>     }
>>>>>>
>>>>>> However, that is not sufficient, because vm_start() was never called on the incoming
>>>>>> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
>>>>>>
>>>>>>
>>>>>> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
>>>>>> guest, which sets the state to running, which is saved in global state:
>>>>>>
>>>>>>     void migration_completion(MigrationState *s)
>>>>>>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>>>>>>         global_state_store()
>>>>>>
>>>>>> Then the incoming migration calls vm_start here:
>>>>>>
>>>>>>     migration/migration.c
>>>>>>         if (!global_state_received() ||
>>>>>>             global_state_get_runstate() == RUN_STATE_RUNNING) {
>>>>>>             if (autostart) {
>>>>>>                 vm_start();
>>>>>>
>>>>>> vm_start must be called for correctness.
>>>>>
>>>>> I see.  Though I had a feeling that this is still not the right way to do,
>>>>> at least not as clean.
>>>>>
>>>>> One question is, would above work for postcopy when VM is suspended during
>>>>> the switchover?
>>>>
>>>> Good catch, that is broken.
>>>> I added qemu_system_start_on_wakeup_request to loadvm_postcopy_handle_run_bh
>>>> and now it works.
>>>>
>>>>     if (global_state_get_runstate() == RUN_STATE_RUNNING) {
>>>>         if (autostart) {
>>>>             vm_start();
>>>>         } else {
>>>>             runstate_set(RUN_STATE_PAUSED);
>>>>         }
>>>>     } else {
>>>>         runstate_set(global_state_get_runstate());
>>>>         if (runstate_check(RUN_STATE_SUSPENDED)) {
>>>>             qemu_system_start_on_wakeup_request();
>>>>         }
>>>>     }
>>>>
>>>>> I think I see your point that vm_start() (mostly vm_prepare_start())
>>>>> contains a bunch of operations that maybe we must have before starting the
>>>>> VM, but then.. should we just make that vm_start() unconditional when
>>>>> loading VM completes?  I just don't see anything won't need it (besides
>>>>> -S), even COLO.
>>>>>
>>>>> So I'm wondering about something like this:
>>>>>
>>>>> ===8<===
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
>>>>>  
>>>>>      dirty_bitmap_mig_before_vm_start();
>>>>>  
>>>>> -    if (!global_state_received() ||
>>>>> -        global_state_get_runstate() == RUN_STATE_RUNNING) {
>>>>> -        if (autostart) {
>>>>> -            vm_start();
>>>>> -        } else {
>>>>> -            runstate_set(RUN_STATE_PAUSED);
>>>>> -        }
>>>>> -    } else if (migration_incoming_colo_enabled()) {
>>>>> +    if (migration_incoming_colo_enabled()) {
>>>>>          migration_incoming_disable_colo();
>>>>> +        /* COLO should always have autostart=1 or we can enforce it here */
>>>>> +    }
>>>>> +
>>>>> +    if (autostart) {
>>>>> +        RunState run_state = global_state_get_runstate();
>>>>>          vm_start();
>>>>
>>>> This will resume the guest for a brief time, against the user's wishes.  Not OK IMO.
>>>
>>> Ah okay..
>>>
>>> Can we do whatever we need in vm_prepare_start(), then? I assume these
>>> chunks are needed:
>>>
>>>     /*
>>>      * WHPX accelerator needs to know whether we are going to step
>>>      * any CPUs, before starting the first one.
>>>      */
>>>     if (cpus_accel->synchronize_pre_resume) {
>>>         cpus_accel->synchronize_pre_resume(step_pending);
>>>     }
>>>
>>>     /* We are sending this now, but the CPUs will be resumed shortly later */
>>>     qapi_event_send_resume();
>>>
>>>     cpu_enable_ticks();
>>>
>>> While these may not be needed, but instead only needed if RUN_STATE_RUNNING
>>> below (runstate_set() will be needed regardless):
>>>
>>>     runstate_set(RUN_STATE_RUNNING);
>>>     vm_state_notify(1, RUN_STATE_RUNNING);
>>>
>>> So here's another of my attempt (this time also taking
>>> !global_state_received() into account)...
>>>
>>>     RunState run_state;
>>>
>>>     if (migration_incoming_colo_enabled()) {
>>>         migration_incoming_disable_colo();
>>>     }
>>>
>>>     if (!global_state_received()) {
>>>         run_state = RUN_STATE_RUNNING;
>>>     } else {
>>>         run_state = global_state_get_runstate();
>>>     }
>>>
>>>     if (autostart) {
>>>         /* Part of vm_prepare_start(), may isolate into a helper? */
>>>         if (cpus_accel->synchronize_pre_resume) {
>>>             cpus_accel->synchronize_pre_resume(step_pending);
>>>         }
>>>         qapi_event_send_resume();
>>>         cpu_enable_ticks();
>>>         /* Setup the runstate on src */
>>>         runstate_set(run_state);
>>>         if (run_state == RUN_STATE_RUNNING) {
>>>             vm_state_notify(1, RUN_STATE_RUNNING);
>>>         }
>>>     } else {
>>>         runstate_set(RUN_STATE_PAUSED);
>>>     }
>>>
>>> The whole idea is still do whatever needed here besides resuming the vcpus,
>>> rather than leaving the whole vm_start() into system wakeup.  It then can
>>> avoid touching the system wakeup code which seems cleaner.
>>
>> The problem is that some actions cannot be performed at migration finish time,
>> such as vm_state_notify RUN_STATE_RUNNING.  The wakeup code called later still 
>> needs to know that vm_state_notify has not been called, and call it.
> 
> Sorry, very late reply..

And I just returned from vaction :)

> Can we just call vm_state_notify() earlier?

We cannot.  The guest is not running yet, and will not be until later.
We cannot call notifiers that perform actions that complete, or react to, 
the guest entering a running state.

> I know I'm not familiar with this code at all.. but I'm still not fully
> convinced a new global is needed for this.  IMHO QEMU becomes harder to
> maintain with such globals, while already tons exist.
> 
>> I just posted a new series with a cleaner wakeup, but it still uses a global.

See "[PATCH V2 01/10] vl: start on wakeup request" in the new series. 
The transitions of the global are trivial and sensible:

    vm_start()
        vm_started = true;

    do_vm_stop()
        vm_started = false;

current_run_state is already a global, confined to runstate.c.  
vm_started is a new qualifier on the state, and hence is also global.

If runstate were a field in MachineState, then I would add vm_started to
MachineState, but MachineState is not used in runstate.c.

> I think the new version does not apply anymore to master.  Do you have a
> tree somewhere?

I do not, but I will rebase and post V3 in a moment.

- Steve

