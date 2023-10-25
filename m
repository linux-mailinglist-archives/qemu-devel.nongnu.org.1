Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E77D783D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 00:47:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvmcq-0006Bl-DX; Wed, 25 Oct 2023 18:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qvmcl-00069x-GR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 18:45:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qvmca-00073q-BO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 18:45:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PLGIYA006400; Wed, 25 Oct 2023 22:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ms0NngT4qZbSNP6Ac3WQYbwBnx1pElOnraiLn8fl9r0=;
 b=RnSfjufx3ZWkDQ1sNF28T3yQXr2tX8Af9gSGwm0kv+sVQTpdDXeADBqAjaO3z/Xh6pv0
 Vd+KAK4MWCmF5kRlhap5GkKgE96ayg5lcoUMMFjVMQs4dgynV4ZloMXtfH7Yucwgha65
 /TzcYBnQKEdmkY9S8h4szxm+HBld++KfMwWAseY27Qup5rbRSVpz/JSBi4fp1/D5YLBV
 hNqLCzfTUBHqV6FtgdqUnwj3YuS7ibrB7fErE0fYQzFuqB+irVFFBgon+sUO9nPLr45b
 Br9eGpnwMUCWgK1xCKbqGZAjPlzafvefptZr11BGXRG1SJ0yZ9fJJldG0ViRZ3EephNy uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581shp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 22:44:58 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39PLSlHq019029; Wed, 25 Oct 2023 22:44:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv537kvax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 22:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY8ZyvfRL8gkMvl7zCNRqzn/TQgtBBw1iL0KpINFbMgb3eqYIFK/B/Oh6TFiXGmuvrwFL5WB019yOmjse9bgmL0LSujUYzrtR87qWF9FEgDfGCDq2bTGigEBX8R2AB/yIHGKwOUQhIIyzeKlfBxPFWzVGJ63FSTBDuQWVgA6A04ZT5zEZ6qgxd5tLnugmlPO9O/AwSxmMQ50Oda7TQe1wV+0qwbe9FqJAJlDX+vS5Jq9aaPV98JhQCJqSWpOc/0E9juuiLRwXomOZI6iWBBcIACeqkb82l9VCS70wfciPJvw37Fl3QDFfh85NW7dQsDgNZQDAYavYfLMQf5/S0zEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms0NngT4qZbSNP6Ac3WQYbwBnx1pElOnraiLn8fl9r0=;
 b=StO4p5gmIGojVn6L+zGcrploaoET6KlBJFT86odv+MgCoZXx1+9McLzmL4i1hQXl6Ib4MK9mCqzmsOAeLOja4s/le9S02s8huZAmAR2FlySJmaUHrPptDxZwwUMkBMdShngTr8zEfcFwfiE0f+FTW1gkUd3iEawt6gBiLAnmT0/4KARySfkjIj93if1v3LyZ8qd1F3L/ybl7HJmvif0AXaicK0JDl3p2c+Re1dAL/XaszxeHGDe+8URE0+EFDuMek1oiiguFguLMo64+Jt5pBHRgakxvCOGO1QV2KgdIcuGPYyobvg2ToPAtI6OjoSUy6MTAITS6buCgkpquFGHIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms0NngT4qZbSNP6Ac3WQYbwBnx1pElOnraiLn8fl9r0=;
 b=VP+EVtXDYX1jxGczvbsnG1YyYYQCehqzBGJu4an15ChfALWCPk6ZgyTgCF3Yrvwwq0o8/BCYYlKSff1UEyrj8RgWV1mlZ8Q3C5WBF3Wm9upEMzU/a6B7Ofx+Am8LNJ5Y78X5dWbR17fDaZV5Aj3Ny2ri8sgOh+4D80nW9oYmc2I=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 22:44:55 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 22:44:55 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, Omar Sandoval
 <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 qemu 0/3] Allow dump-guest-memory to output standard
 kdump format
In-Reply-To: <CAJ+F1CLLgb=mYxf69gb+DpNQHrdOFY24Ax0eYfkVS4NxQ=NEgg@mail.gmail.com>
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
 <CAJ+F1CLLgb=mYxf69gb+DpNQHrdOFY24Ax0eYfkVS4NxQ=NEgg@mail.gmail.com>
Date: Wed, 25 Oct 2023 15:44:54 -0700
Message-ID: <87h6mez5i1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cf1a0f-1863-4764-372b-08dbd5ac024a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5rV0MfDbuwy2e6Ozmpb2PIUQoofOfPd0fIXp3SqexmLLLmsK++36OsaUT6bga+p0tdZmxzLLB2U14PVOlR1gCgxqk8+yMRaAtEdPJmykvBUnTXB5lMAc19eCPlPRTU0FfY5neFn4qPRF1O3SvMmrykJLhFh0f+cWIUZThsEqP3IlUN0J195H208ZcxAXDWoxGCGOy2O7ds5rJ5bTnyWDBXus6v/PvPfyf8PGdL7x+Y1FH8YUbNYCWERjiy/2xex5PoN7kaAHjWNXEEmio2jvvohWPt27qXL9r9v3CW5Pe9QK1YsZitAE3cv2Hk+hhfktOwaUmU3OdsVrA1Hs8Qe+Aup+VS335pQflE8k7C9kkpTkUUgX2cWf9PFqOQxeGxt9ALWcaVBlqgGvVp8L+kSfY19bL1zp9SFfQbHpkytJn7CBMvMmDbOzSA6JsOPzRQTiA2q9i2xYQBLYxxLIY7pY1psMbon1E05kM/TzYw0qwQS2Kc7ikhnetyo1wUI1GvQvS6ODsUT7IeBpW2B9HkeL78OSUcKvAT90FPJiN2Rotx50sgM+F25yW3tsyol9i4u8jOn0eTCRpcP3amvitJoWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(54906003)(8936002)(6506007)(6512007)(2616005)(83380400001)(53546011)(41300700001)(4326008)(6486002)(2906002)(966005)(478600001)(5660300002)(8676002)(66946007)(66476007)(6916009)(66556008)(38100700002)(86362001)(316002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEFxbXpaNEM0RFJpSHB0VmhINFZ2YXhDL1NKNDkzRSswT0RUaW05WXB3Q216?=
 =?utf-8?B?d3RmaXBNRWJMazJsem05QmpSUFNYWk5IQkU0eG53NS9YaGhVaUg5Y1Vrd04z?=
 =?utf-8?B?a08ydTE1MzdhQmowMkMrWkVNYjd0cmVkNVR3NU9qMm9tVkFvM3JoYm5qSmkw?=
 =?utf-8?B?YVhWcFRnM3crMGNvRXpjWDhLY1pzYnlRMkNhMXl5b0xpRThzNjAzNm1CQ2Fu?=
 =?utf-8?B?OGJVTVFnZFFURTRzSGlhWUlYa3JoblJLZW44UnMremFucis4alhsdWh6bnNv?=
 =?utf-8?B?Q3lMYi8wV2hLeGM1SWJvckx0dVp0b0hoNXB1aE5hTERVK3FpU29iSTN0dDZr?=
 =?utf-8?B?VDBoWmFzN2kxZ0FScTVXUUZZTHZLVVBmSEVFbVBHSVRINUlhRnhkckxoV1ZJ?=
 =?utf-8?B?Ulp1enpGbFBHVm90OXlYdTVpend2WnVsQ3A4aDBxVUZDd0RnSlpEOU51SWRw?=
 =?utf-8?B?NFcwWnE2ZENUQXdLbFlqSUY3WkpaUUtUM0hqQ2dQdytBWVRoemF6RFlsV0Zi?=
 =?utf-8?B?UGdsdWxpbzdxckE4VFRtVFY1d3I1UlVPWngyaERNYm45WW9kc1p1Wm1jZjll?=
 =?utf-8?B?a2liMmNhUy9XSUI4Y21NcTBiNHZ1L3NlcmxpTEY0WDE2ZlZudGRnUk1BVU8v?=
 =?utf-8?B?TUdqVkkxUkZWUlpnMXprQk9mOHFXVlREaWhPS1QrQmlEU0RURG9VUElCcFIv?=
 =?utf-8?B?ZmV2Zy9YWG9oTVhOckppZ1dVT09PRVdMaW9lQitNVEdYTFlSUWN3MkN6UDVz?=
 =?utf-8?B?LzBrdWkrcTRMU0JldVdwT3hJUENJVWhxRDErbXZCUUpEUjg4Rm5PWk5BWFJM?=
 =?utf-8?B?QlN6anFONisrbjAwWnRSaDJWUGtRNnFNVFdMdUR1TDN6WDlWcm1YcDJoU1ZQ?=
 =?utf-8?B?bWgvaWp6TmhyNkZkSEZrSGNQcUtBc3lORmtlTVRsLzhhUy9BUHdoSTZNejgv?=
 =?utf-8?B?OC8ybkZLUlY4SVBLa3huSlVsRG1NVWhBeUlMZzVjMzdZdWI5MzBvSFJMbkdQ?=
 =?utf-8?B?ZS9DVjcrbTFIYjYwWkIvcTVxcDJldnVNOG84UlZyVXhYVDc1Q2ZCQk9uVnlo?=
 =?utf-8?B?bHRxTTZqZ24rTDRobE1OMTdBUTYwa21lLzJxOWJpdUtGd1dHby9rUE1xanpL?=
 =?utf-8?B?VFRHVCtJY1VidDJBcmxJNjlUOW5YQ0RBWmorMW1FN0NxRjM1Y0UvdzZoQ1cy?=
 =?utf-8?B?VmJUUnVwQ2VuQlErMk9aRWZNV1EwaFFQdFo4OUNQaEFueUlSRGZLeTBGYlhB?=
 =?utf-8?B?Q3ZndFBMRjB0SjRLTVRvUWMyK0Y0S3FtQ2ROeVdPWUduQk5qR3FSbWxCdndt?=
 =?utf-8?B?endWVnFPeVFkZVA3K0hzK1d2ZHN6U1YrODlETHF6WmxQN1QvcnFsYzJFV2RW?=
 =?utf-8?B?c0dLUk43bFdqbWcwdGtaenpVTHY2L0lLc0x0eW11QWZ4MXNGYkszQ1dhd1o3?=
 =?utf-8?B?ZU9mSGd5U010V0luNHBpVlBUcGE4M3BYNWJuTVdYMVYwT0VVZzVhYnByTnZQ?=
 =?utf-8?B?VnZoZU5tOFBERFExQWIwSVl3ZmQ0WW5WSllJckpHTTg4Yk5RYUpHb1Z2OUpk?=
 =?utf-8?B?Q0oySi84MUNyMCtldk9MQWg0ZHc4K3JDSnUrNGEzWTh3ME0wTFNzTm5VUVJo?=
 =?utf-8?B?dTNJTUdjcCtOVmFXZjlmMENpcFUvZDlpQXdtaWNOUDlJRFd6NmdHL2xISzNB?=
 =?utf-8?B?TUcyTm1ySkdhWTZidnpFZFNFRm9rMlNpTjNSamh0ZGg2Rm02LzFJcThwS3lU?=
 =?utf-8?B?N0hLK2pLY1ZGRExXdlhyNXpkczNaYnNya1JscGNYdkVzTDN3WnlNeUtyYjVR?=
 =?utf-8?B?V3BPWU1tejNYeGwzdXZObU8vYk9JR1lwVTM5bkh3T1FqNlRSYUdwUVZTSHNl?=
 =?utf-8?B?MHhCZ1ZTL2FZVTc1NnhGdVk3a1hHS1NyL1pLbFFqemV1UldFaGpObEliTnc0?=
 =?utf-8?B?eWczSHhORjY1Rll0bUNwVGJrbzlWbTlVMTVhV3AwOEhZSCtGWnBhVDNSVzhj?=
 =?utf-8?B?VHlTTDl4VkV6Q211d242cEtrdjNwN2orRXJBWlYwdzZ3eXZ3VU0xYllCcUZH?=
 =?utf-8?B?N2dUYzAzRVF0cWMyS3B1OTNPd3V0QXhWbGdoRkFzenJNMllDcWwrZEhSWUtt?=
 =?utf-8?B?OExpWURpd2NTMDVVK0l3N2dGTkwvN2F1WXZmK0ZWem94NzNNa1hlZGpmOThO?=
 =?utf-8?Q?QFlPmI52074yV+1+GlGLC+nM9UjbUSBlkN9tkMoDM7xo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bS0XyiSflAZyyHAJVHPO2fJcjyln2dtveqRD6WPtWxcR0sMKVLKw7ZrAt1p0sTvhlcBhUIJQE/0CR/0EOqcaoQ/9hSuhRWw4TWX32XKsDdBujRK211rf2D+FMO2NY7QtqjnGFbb5MDgmNLe3ZU+Zq76rJMrpiJb/Dxwf5p6Mmhgf716Ln1jPHB39eXzCaOWaTnyZailXXpLGKeyImUrswL2iPEorEu1W9zhej2N5GP6spB31EIPoGlSgNWzw4q20GyeIwSpfEhxCphy84JN5RXyNtHaPL0Y44EHCbuytC4UChQA6Xovwcp/ZuRMQ2vnrSco+ZRm1OZN5se4wuX1unQ7hBhBMR8HMwMxS1FtSR6EbqQNIDOquv5Od7rw52cM+sHQzKwnxGetqsa1PJwLKBuc2NLaPdsMF0sCAglvnEzaeMlXv4Jeu9iYNbWlk/sF7xd8AgvCDEMKgoW5WIvZ16JOTx30nLAiF+iqkm4BFr0meyfpM9v8uhsVkPHlEZcjMS3QdNLluGj0F0CWcOKJYanrWMzwlndVkLBQlUOnLOdeBlzQdu1cJeA/9oIKfjfWWGvdfgNmZ0gG9UCD0n/JBCB3ci3sbTHODvRdC3Z2yl+Kz+07x2fhuCzZF5MjO4nQq1H/ZcShXritIeF1FJhhfY+PUcF/+Xoihlq9c7FM/Y0tJKNo2QMc09+iOiQPmToBOY/2MreRE0XIrsH78fCPv4LMZEKmEdDOqp3BdteGHZdCz9FDduc8vDchAPdWqEjLBaD8X5IKKxq3GwB7lyq/UIIpI8MR9TB/6Hudl1HliSyBG76XFUxa2dSg9lA7zehEiXhnNwGeAZVPgawbgia78aC+e1q+EHiQ2OI6Hq8lJX9NOExRWuAEXtmarzI49iiRz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cf1a0f-1863-4764-372b-08dbd5ac024a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 22:44:55.3885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hheEOP2ST+Ljltlo6V2+0h6BUWIPVBIxLLTbhUyd+g/zyvlgIZBPvWMolzNxnVFYQj1gCvR9vz+slINrS16d9PLHZvozJbJACK22mOt+Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_12,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250195
X-Proofpoint-GUID: 2--0jxxNdUVf15EtlJwA8awYfkAaz6xS
X-Proofpoint-ORIG-GUID: 2--0jxxNdUVf15EtlJwA8awYfkAaz6xS
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> Hi
>
> On Tue, Sep 19, 2023 at 3:32=E2=80=AFAM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Hello all,
>>
>> This is the third version of the kdump patch series, the first and
>> second revisions being visible at [1] and [2] respectively. You can see
>> the history and motivation for the patch series described in the cover
>> letter of [2].
>>
>> Thank you for your continued feedback and review.
>> Stephen
>>
>> Changes from v2 to v3:
>> - Rather than use "reassembled" flag in QMP API, represent each kdump
>>   format "kdump-X" with a new enumerator "kdump-raw-X". (The HMP
>>   interface retains the -R option)
>> - Return an error if the file descriptor passed in is not seekable, yet
>>   the requested dump format is kdump-raw-*
>>
>> Changes from v1 to v2:
>> - Keep the default as the flattened format
>> - Add QMP / HMP arguments for "reassembled"
>>
>> [1]: https://lore.kernel.org/qemu-devel/20230717163855.7383-1-stephen.s.=
brennan@oracle.com/
>> [2]: https://lore.kernel.org/qemu-devel/20230914010315.945705-1-stephen.=
s.brennan@oracle.com/
>>
>> Stephen Brennan (3):
>>   dump: Pass DumpState to write_ functions
>>   dump: Allow directly outputting raw kdump format
>>   dump: Add command interface for kdump-raw formats
>>
>>  dump/dump-hmp-cmds.c  | 21 +++++++--
>>  dump/dump.c           | 99 +++++++++++++++++++++++++++++++------------
>>  hmp-commands.hx       |  9 +++-
>>  include/sysemu/dump.h |  3 +-
>>  qapi/dump.json        | 24 +++++++++--
>>  5 files changed, 119 insertions(+), 37 deletions(-)
>>
>> --
>> 2.39.3
>>
>
> For the series:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> --=20
> Marc-Andr=C3=A9 Lureau

Hello,

Will this be queued for version 8.2? I see here[1] that the feature
freeze is November 7. I'm not really familiar with QEMU development so I
didn't know if there was a "linux-next" equivalent I could check.

[1]: https://wiki.qemu.org/Planning/8.2

Thanks,
Stephen

