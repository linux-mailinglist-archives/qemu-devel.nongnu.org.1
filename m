Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C44FC7D891A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 21:45:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6HD-00084O-7p; Thu, 26 Oct 2023 15:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qw6H9-00083m-Cx
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:44:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qw6H5-0006HE-Ur
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:44:14 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJgTOa012113; Thu, 26 Oct 2023 19:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aErQAp3j4++SHfTDaFEOBemIluGXr39FBCqBIGyOres=;
 b=ACSGMy3BsQt2WIIlrsNtBiGU3m1AkK1BwR33uLHUOh6V578zPw3CY+f63osgaMVHSZYN
 WeBr+2BedOTXBtk+3tbaP8Ewrsc8hHAxNa4/H+fWWAORhpOjCiENl46qjFvFH3+H8Vv0
 SAsTZIaiHKyjk9AM3NSmSSanJhOOs17maZ9OcI/y8yiOG1qvsM/2Epf/08RhhItBPXak
 iNDI0RXkMEBFLV1ZPVzE8zlcv+JihQuHdiZZjnC57iv/yKB9uhXs8asYGmNDVawHQi2D
 +Ky3CBmKioE1tfeq4b1Vcrz4YXBVD6Pco8njAoQVMmCNB6C1TMx7EMCkZ1H6hjRP+ri8 XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxge005y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 19:44:08 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImmMM008199; Thu, 26 Oct 2023 19:44:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqhj1xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 19:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWbdWuM9wJyHeIzJhbmUsMLvR2PHPi8uOYn0zNm/MnYa3kIHJqi0WaWabvRKaI9ctK72t+IwP3C0xkx1q8QMSC9GlDOJi00Lw/Nj/nuTV2kILCI2i94arJqlP4vLfcM8jzVFbZIkpmK+0jx0MZdLJPwFzrHTmfdxKTCnyRmvJXNLH57mMuKgqjEzZT0Jtn91r5tWOwmb0U+5OGML6C4SUw4+x4IWoj0YXhO9OdlY8CPI12206hYfy/HPKQf8gkJBCRd2EK/puK4eCOySLqLCbgtYPv/p+VCCOBTKr2f7frLMRb+RkJsfYiVf0n4FrMvQz38eZTSXGlQzOe7T6UnAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aErQAp3j4++SHfTDaFEOBemIluGXr39FBCqBIGyOres=;
 b=TRcq/dEOdEz7ICvtyuxJPJ0ecKgG6tAiNVJ+fV/DP5Kk1aFg2FmnxKTvhq233UkunEA//od34frbiOEJZvPVS+fEioAquBGhcWKotym+DiMQU30x7NHpRoEsJqTF06hWOdeJUi0CSkAcOenn8gSn0GWcOwqtVN+20J02ooiu8xPmddgxo+aSU1q7EWgv8GKyABXVDi3+qtA1sj0vNQwKop7lBs6WakiB9WKbFSMTHSYjIl6Y/q9pZhKEHl1pbkd0RT+pLRF08FQWXw1oEnsmGCRMLHAR++t9B3aTXoCs4zFE2AOfoRs2dDdkzoEfzrFw+RmR2TZeWpgqWk7CnyPgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aErQAp3j4++SHfTDaFEOBemIluGXr39FBCqBIGyOres=;
 b=FlEBaT544KWLKRdX951cKwjkfkZMPATO/Vl51hoGcgMtUQbJaBaV6v0w0Swgyb9+3CBORoyvTtGYyOJYptJ7NCeLui5QNwAQt0Vcv7kpgiOG5qP+NTUK8N23miZwvcE9J947X7nJcoSr76D+uzNHEK06Nox3EDGoTIQi3MDP6UQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA1PR10MB7486.namprd10.prod.outlook.com (2603:10b6:208:44e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 19:44:05 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 19:44:04 +0000
Message-ID: <46fcd5e3-db39-46a9-979f-a649a5477be8@oracle.com>
Date: Thu, 26 Oct 2023 20:43:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/3] migration: Add tracepoints for downtime checkpoints
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, quintela@redhat.com, qemu-devel@nongnu.org
References: <20231026155337.596281-1-peterx@redhat.com>
 <20231026190159.608025-1-peterx@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231026190159.608025-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0124.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::21) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA1PR10MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: d92fdc68-5b54-4233-e78b-08dbd65be93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F42z3DrOnCnuTdr69+AWwRq59h5M8KMaUVDujelaaCi0NrThbQWuSdeu/tvfLg5FgsLvMiyzTH2LhAOH8HZy/bJ/wBnVASZYtwBR2/IDqqhh1M0pNkI7KgHcfKhsfKATSqAx6x4j+4VyBoASNq6trsm3n4Kc7ki0aGwFZ4cnosvYeqIZSESstKL0/Yfd5m19VoqQONdt13s6vNbtU0+qZP0QL90B/o2iMhLU95WkGNpv5eEBp41+hr48dR8nQl0JdO7bxAwSEupCm0cduO/w84XTSLTTHv+Qua9k+bNLq5gSI7zGLMc6RXuGvvncty9PsALKdNpvzNVofbA+SOHlxs67yAW0l682/+11Cy2hvb1GXGsM32zEUAjZWhxuvrjTvJQsUSNch/dEq2eWbmgi1zYW1/IGk2RAzVIeXOKLi2kP4W1CZDVS7LQFbe50XgCbhQNjAsUik9QvBmD/BcCdEcrEEGwpdhXxDtX6L1pV8D2mhKb6MwiQ3fTnji7jkVbYYQVWBjEKWDtkZDaguUb4i99NE5KMFKni4Xp63YZ9EE7BqMaDGvW8CjucjaIZ9XJ4nkA4b0XfcHPh2ITnmWnAt3ZE4p67aC/fSeoXvVAWwGz21aOVQlDSApjvX1sex4A3JMf3eNMB8BAhlplh5A9LKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(66476007)(66556008)(66946007)(26005)(316002)(478600001)(6486002)(6506007)(6666004)(6512007)(53546011)(6916009)(41300700001)(31686004)(38100700002)(31696002)(86362001)(2906002)(5660300002)(36756003)(4326008)(83380400001)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BFN2ZDd2Y3YnBRK2ZVZnZpQXp3MVc3TU1KUGVaQ3BhOURsNmluSERrREk2?=
 =?utf-8?B?NFlyOVhad2JZNkVoZXlwY2xjL3ZpekRXMWFCekpZbUxobUdQZjRDMDEzUDVS?=
 =?utf-8?B?akd6NHlnejB2SHFLTmtXSkJKUVhxOW5PWTJUZmFmSFhEUmo5d3JNMU53YWND?=
 =?utf-8?B?NTl2TzVyYW1XN3FZZVAzeE9WS2t3RHczdDFnVHA5WDdaVVVVMUkva2RNZ3Z3?=
 =?utf-8?B?SjM0S1lac2NmeC8yMnBmSlpZSkVQNGhNYVhRempTc0x6MHoxZUk0SGtiblp0?=
 =?utf-8?B?andkZWxPYU44MldDdFI2MkdGc1pjSzROT1FZYnJzMkU2MnRRUVh4SXZZUkMz?=
 =?utf-8?B?TkIrWmljeXZvM0NhTjdiRzByMXBzSWhDRCtlYmc4NTd5N0pVaDJ6RXBTNWh6?=
 =?utf-8?B?ZVBDZ2h2dGo0WitLY3Vid3hBSFdsOWdOUllnNzA4VTUwMVhEWUtDMlUwaTFi?=
 =?utf-8?B?YlJFdUl5UWtFZkd1dFJVZ0F3bW9najNpL281RlYwSk1UTUIxOE4yNkhaVzBk?=
 =?utf-8?B?ZU9UTTJsbThPeU41ZVhFTTV5SHJLWWo3Ykd4bzhtQ0t3Q3NiaHArS1l5NFNK?=
 =?utf-8?B?RXJjZmswelNWU0MzNjIrMnF4cVBlVFhNN1ZNTzM4QmRFbldoczZhNFJNelEz?=
 =?utf-8?B?NkN0S013d21CM1JJNlBxNk5RU1ptcEhSVjhJMkNmRm1LbkhOdEpUdURLR1M5?=
 =?utf-8?B?YWk0QlA0ODc0TEpFeWxuUzBUYmpkemprd0QxcENLc2dIWTlyTTdBUklUSVV4?=
 =?utf-8?B?UnlMbFBnZDZKRFY0VExaRXBxNjRETC8xMWxUV0Z3MWxNaWR3TnFjUDhEakEy?=
 =?utf-8?B?bFB3cWxkU2ZDc2szOFdtVXdDSUN4b0JSeWcxTUtHb01PSWFtSC8vL0lPTlRn?=
 =?utf-8?B?NlFlZ3dFOFJSckR0TnJMWk5USmEwcXpUcEU0UzJKMHBMT1dHUDN0dU01Mzg2?=
 =?utf-8?B?MXFLRUJJYU03K3pmdjIzQWpMUVVuUkhBU3gybDRGNk5Qb1YxRmJwek9qTkJT?=
 =?utf-8?B?WVZYT3Z0Qmh3akxOSjZjZFZWeWFhREs5SVFMd3VPSVhLN1BBdFltejlmbUF3?=
 =?utf-8?B?UjFubzRKU29iU0V1MGl0YXR3K1pPOGovYk1kY25qZUNXTHBQUVRKRzJkRzdz?=
 =?utf-8?B?MlhTVm44QVliT0ZLWEUvaUJHc3V3VTNmU00wOGJKVmVCaGFYUkZIblg4WThj?=
 =?utf-8?B?UkxZM2xpZEozNUFOS3RxQ3RXdStkU01ZSElOWXlEdXZ6VS9LSmJIa240cDVM?=
 =?utf-8?B?SHBFWDlTQktmN21pbldsNkZqSDBwL2Z3S05ib05HSk1nRjZHcFBrbG9hc2Fp?=
 =?utf-8?B?d0s3b2dVemJBL2ozU1VsbHlUYUxQTDBtY1dlcmx2K2RXTzRQaTVQTHRabEJF?=
 =?utf-8?B?Wm4wQnFKM0VwS2taT3dodlVRbTVINjZkdStKRE5JdUl3YUVxVG1pYVhHTHh1?=
 =?utf-8?B?TEszcDBqcGNsNE5TaU1CQkp2MTNEWTY5OCtjQ0FHRnF0TXdVVnZEL21TZkdm?=
 =?utf-8?B?bU9wQklMVU1RaHlMQkFRWEh3VWxGTlJidHRrMzVoRzRRVkFkL0Q4RExZK29y?=
 =?utf-8?B?SS92am5uTHhCL2NrcEt0QmdPRE5nc1ZpWWU1bzdhSXdYVVA3ZjhEeXo3cjhN?=
 =?utf-8?B?U0ZvOGkyZ3BsUTdsZ2Jwb2pueTZkSGw5cWhvZmRscnVoQ2FiUWl4VWxXQjFs?=
 =?utf-8?B?WG52NDJMaTZraHU1bzJLTG80YUZyOXZUR0RtM3dJanl4Y0VZUmQxRmxzUkVH?=
 =?utf-8?B?ZUV5OXlZL2FxVnZvZ3RwR1pab21WVU1ZcG9mdzRCTTJ1VmRDUkl0MENwbGky?=
 =?utf-8?B?T2JkSkFvOWp2SUo4aW01WnNzMmtEdE50aVlaeHVoNW5EMWYwZys0d3FtOHA2?=
 =?utf-8?B?M1lKT1JUNjdPTDhtdkxOWGRQSy9jK2w4WWlwa0JGRkw4d0VnLzNqdmxrZGJI?=
 =?utf-8?B?YzByektxckY0bHZ5cGk0aHhCV21DQjZZeTJLWS9pRVA0RDdtSVUvRzUvcGFa?=
 =?utf-8?B?KytvNVBJbC9hOEgzaEVhamU0eGhUTnZIbC80UWFoWDNRMzF0MysydXpMM25T?=
 =?utf-8?B?UjcraDF3RHUzNU5vcWlpNlhWbGpma0lhNXpYSjlkc1FoSHNLbWU2c0M4UEN2?=
 =?utf-8?B?elZ2cm95RGxhdTJ3RXFXb3dvUkxwbzBhdzAxV2hBODhjR3JqVXE4eEpNMjVL?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XCwcuP7DSbBWoVr8w5fqlP9oOdGhET6C76ubHr+odtECFGxTr1k0kuQnZF2/xBASSkAxItVJcuC/iB0xJVOj1qX38SPNG2KqTD47fOPUWlBP98xD501d1vtEOff1Q8PgA4JNi3fB8bsKf6peNJUdMfCLSsknTgDkuT3wWw7tf/Wwt98nnYPVzrisnQ0buT6V6hiklh2A2COtpIPmzdPRDiQ0G44/V5m5zgDXKHER4zNKsIJ1L82ZDdwDI9gxwEofJ5QUmuVZH1EEYQK1L1Spjy4sum7rx1ZnKEJg9uVkHmz+N9CctOrInHWKXubSEau31dLbV2tp0OCiE+MyOJoOwW/FNVwdOpKm5eluaPb8lr93AxGT3jqeBD29sa5ztJiR6S6H7XRQdbkJvI8hHZBlRmYqOh1ziSpv/xzrP90qab5AupJ4ib29uRN5WHwd4iF+d2SLRVmepMtEbOX6r7mrr4nd93hDviQ53tLTwFmuFMcsOCOhUL3ERbx45o7NV3Mx6uPCzzkjK1Z+bn1EFOkRksAuQh2tdsgY2k9IGLg1VyVr/8+bqdxmzWuaCq7vMiIULitsDo2SGcKbFsqKw64bw6WzWP8l31sDz/qb3+dowCf8ILhJwE+YhyyOWTTiZwPKVW5dIC8LComIefuM2CmfPMHFB0lJO9Y931OZpSZIUqGWb+Z+vfxQ4Al4A3a34p0aXjCmF1sqsJ7wjy9wCkIHapzSm/Gy+ptSwG82ki3oC0lVBVQNmfa+V02a0rC7Q16+wpXWjE6kNq/nFYXEoDJD/LJOTxdhCdKUmCdBbuMTwzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92fdc68-5b54-4233-e78b-08dbd65be93f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 19:44:04.9328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ElpWBw7R4KvhroCaLXNw2EmLZWEFRSvharPCzjl9JQ6NAmV3W7xzsU5pYgkzVJe/AE1R4rxNHS3tD7TvoNXhBSIahyuZ21Hy7v/M39+vF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_18,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260171
X-Proofpoint-GUID: ryAk-39N87-ZiT3YKvzRCcAlXg-guaS2
X-Proofpoint-ORIG-GUID: ryAk-39N87-ZiT3YKvzRCcAlXg-guaS2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 26/10/2023 20:01, Peter Xu wrote:
> Add tracepoints for major downtime checkpoints on both src and dst.  They
> share the same tracepoint with a string showing its stage.
> 
> On src, we have these checkpoints added:
> 
>   - downtime-start: right before vm stops on src
>   - vm-stopped: after vm is fully stopped
>   - iterable-saved: after all iterables saved (END sections)
>   - non-iterable-saved: after all non-iterable saved (FULL sections)
>   - downtime-stop: migration fully completed
> 
> On dst, we have these checkpoints added:
> 
>   - precopy-loadvm-completes: after loadvm all done for precopy
>   - precopy-bh-*: record BH steps to resume VM for precopy
>   - postcopy-bh-*: record BH steps to resume VM for postcopy
> 
> On dst side, we don't have a good way to trace total time consumed by
> iterable or non-iterable for now.  We can mark it by 1st time receiving a
> FULL / END section, but rather than that let's just rely on the other
> tracepoints added for vmstates to back up the information.
> 
> Until this patch, one can enable "vmstate_downtime*" and it'll enable all
> tracepoints for downtime measurements.
> 
> Since the downtime timestamp tracepoints will cover postcopy too, drop
> loadvm_postcopy_handle_run_bh() tracepoint alongside, because they service
> the same purpose, but that only for postcopy.  We then have unified prefix
> for all downtime relevant tracepoints.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  | 16 +++++++++++++++-
>  migration/savevm.c     | 14 +++++++++-----
>  migration/trace-events |  2 +-
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9013c1b500..f1f1d2ae2b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -103,6 +103,7 @@ static int close_return_path_on_source(MigrationState *s);
>  
>  static void migration_downtime_start(MigrationState *s)
>  {
> +    trace_vmstate_downtime_timestamp("downtime-start");
>      s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>  }
>  
> @@ -117,6 +118,8 @@ static void migration_downtime_end(MigrationState *s)
>      if (!s->downtime) {
>          s->downtime = now - s->downtime_start;
>      }
> +
> +    trace_vmstate_downtime_timestamp("downtime-end");
>  }
> 

Considering we aren't including any downtime timestamps in the tracing, is this
a way to say that the tracing tool printing timestamps is what we use to extract
downtime contribution?

It might be obvious, but perhaps should be spelled out in the commit message?

