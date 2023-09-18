Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C27A5598
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 00:02:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiMIi-000653-BN; Mon, 18 Sep 2023 18:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qiMIe-00063T-5H
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 18:01:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qiMIc-0007yg-1q
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 18:00:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38IK4068031418; Mon, 18 Sep 2023 22:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YOCdTxsYm3DtHQxZ2UVSQoSHTJP6RtuJfSqA9u8JRmU=;
 b=CzZnsefbzf2Yh2jQP0wMfaqNrBZRO8BIWSVyZ4gO+P6O7ACG51nWN6KcvtVWIB45S+7J
 MzuMQ5qvP3DnIlG9z4h67Dp32MSeQq9i8HBLgxSZKIe/VN8CyZCnON+hlhKofvT0Tmxy
 ZSHhjhMsxZmgjj9lJLgsrMcs8Fap4uWgw5C9QdEWXKC4kz3CR5HNrmPo5rVQgVFGf1LI
 l2o87r7plBkPu7Ys/Gj1EYMD9A1gbUeovs+8BJvTC6zRf2DP368w1z+vJH906yNxMn6z
 vZ97yRTF7fRzH1eMc7l5bh+wfGGvy8sIjflUf3TUYoldJDDQU4T0Hx3G/iAwz7+PjAuz KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352umu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 22:00:49 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38IKLcLj027043; Mon, 18 Sep 2023 22:00:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t549ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 22:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhQhakvcK++5aFLQSNKpPH56/8hbKS3hcicFkxd99BnmHrUV06+ljCK/f/8cCks+kh0Y284iVEr4l9Ivu5Nxrh/BacHoktJJz0JRWzkvKX6BhwEdw32HORq6RnQrR1BJUi28m72BF6Tmr9MslUiUDx3R5bYdFsJ4WBqxDmY9EgIfCLAYz1O7VtBLKIxYz3OEMpPBM5Nit5o4wq3czPO6v+yHi4XNca1xdeyj2mtez/rOkXJ3nd48SDOt2LgEfryhFNA8lCNHq/UBRBNN/nJn5/Pkgag9QiUMvaQGeOmXmyn/qqY6o4lUhNXvNRFehR68yLtxfcvlNCJAg+Em/Ez0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOCdTxsYm3DtHQxZ2UVSQoSHTJP6RtuJfSqA9u8JRmU=;
 b=F/Z1MsGhfLvBFsYe+H9ZTGckpEdLlUNqV4ngmbKa3053fuPYGvjmgKJFV8EUr8fkR1TQNSuRJiH3VLTP5Y2VCBUOl1pLoEOhbuIz5eTNvJn6wOeWG8DjZIM0xdFoTGpOnP5utGwz7EB1XjqoF6VJJXZwd0LiMO42DnjG25su2+QiNvfOqX3J6q6TAeYSYOwOwovI6zNbHYqEsX2M+0Xz2hUA/TcPhKccm+Ix2VJ5VzvvE5/mGcuQ1UWP7ZySfvLrL5BDsbrEsZef2b+xXbH9stvC0Dnm9cB0UER5R6hsme3+8f4pNMLwPpwWDHidL8bFmeszVJiXWgciOGJ5DY1Gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOCdTxsYm3DtHQxZ2UVSQoSHTJP6RtuJfSqA9u8JRmU=;
 b=nOFRMzHKzRoHXNQ//4JGkaKalwO+2UKO+REQ9WG6MgIZjn1nR/ATeT2ShslziuGdShOmMxnDfkJGk7szY1l9oZo6DLTSOAMjHtp4FPvRpzYvZ3qbUqVdYuJP13+2StNI9nQMiOLDQEteDxzsggLEg5B3HnOtzAVW8DpM0pgmMtY=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 22:00:45 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 22:00:45 +0000
Message-ID: <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
Date: Tue, 19 Sep 2023 00:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
Content-Language: en-US, fr
To: John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20230912211824.90952-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|SJ0PR10MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f819c7e-f516-47f8-1142-08dbb892b54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1ikIygIoVp14GAI0ZFdhBcj89J1NjFjJGTpvXOqudU0YlyZ2xtK7oTRWDsHYXvVAEfEJ7t/y6NNZjOjQlOrZNsC1B6n1h8iD+sJfSl+//2zozX1zh6cemPP0jTOoy2tTDL8FeCjKLomkj3nj/kYlyYPyPpes7n/iyRmzM2z7JFC5Mb7IeB0mQYsR+ExJOfNxDZNWbF4X8t7RAJ6UrScKhbDL1S4jRQv3Yvyqwf5wqFwOR8Exqf8rDGmM7IVsGOz8rKiYCN/APcHzVyHdkb7MjYVu1j6lRrf//XDiLXq7UIa5Y1UVVw7+XZGuECqPaOsddrfl6o8Rt+IJ52KTubfFFG4Y53OPZK2sRDVMoKbtqI858SuZFSS14ZEHbG/sV92b6wmfIYrRmC62JEm7pID5Vd5Rh0U9hd//WhjFmO4ok7nll0JWwOxiZb8fMqK6uSk3GFsXe7zHfa2tea5OT+a2kG7w0XMNGDcH+CNzAFUbC4JXNa6QL/SlsV/P95sTX5TLtfF8oYh2gaeL89WBHwiugHRLqaPC7N3BsDxLxVqe802uy9bhb6RLcdXNN2DExuFCkzIZun7HCv4btr5ksM4iQp8cLQJe85JafT8UT18obbQBBFqyJJL5rKpyO6Mewt2En+xvUEPlJj8ZJzKp+yYjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(186009)(1800799009)(451199024)(66899024)(83380400001)(6512007)(26005)(2616005)(41300700001)(316002)(66556008)(5660300002)(66476007)(4326008)(8936002)(8676002)(44832011)(2906002)(6666004)(66946007)(6506007)(6486002)(478600001)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzlmaFkyVWEvK2daT0tZVmhzcHBVTXJYK3ZVVks1QlFlUytlY3pGVG1GRURy?=
 =?utf-8?B?U3Z4NkVlZVVpRzZ2bDJOSEtEUFRwQmYvQS9wZ1hLdEJFUjZDVkVMZU9aY0Vw?=
 =?utf-8?B?Y1dIaXFDKzlucHFaSXUxbUU5bW5udVIzeUNKamlFNGMyWjNtYVNWYnlWWXVW?=
 =?utf-8?B?bVhMQnQ2alFsd0x3Qm5uQzlvVmlQOHRsTEF5V2hURGlkcU5jcU41NHlTRmZ3?=
 =?utf-8?B?WWgxcmpIUGN5ZXREMlZCZ3hlY3lOa0h3RG9DRTVqeUhBWjlOV3UzUytlcEQ2?=
 =?utf-8?B?SWNUWVJMbFYrNW1QYnhmTnhmMlVsY2drYUdveTBGeVZOckhmV1ppNG1qQjYy?=
 =?utf-8?B?MW5PU0t3S3V6SW0zN295Rml2RHdiT25sSHRRM1hnU1NDS2tyTFVPT0NVS21R?=
 =?utf-8?B?QjQ5YVV6MEVXL3VZV05aZnNiS3pKaXM4TE5jR2ErcHJsQjVyVUFrQTBlNHdx?=
 =?utf-8?B?bTV1TGhwM1Z5aXRjaWJ4M1RtTXlpelRjcXQ5TnR2SkdjNWUzNEt2a3J1dDNE?=
 =?utf-8?B?N0N4enY3aENHVzNKU1hjQWxqK2hDZks3UlYreTBPczVjS2s3VjFYVTdjOXJG?=
 =?utf-8?B?dC9KbUQ4TXJQZWRhM3pSQmpzalUweGorSEFVdmRrcUVaY2pJZTZrNGpGYkhj?=
 =?utf-8?B?YW5BT3FLR0UvS2w3RXNxeVUzWkg4RUNjMEkwYlFrQzBJQlBEeUkzcitQLzVO?=
 =?utf-8?B?aDgvYkFXTXIwVXJYM213aXQ3Q0EwN2ZuUDBSeGYvaEU3aENmbjRMUWttY0VR?=
 =?utf-8?B?bkJURGRsbDMzbnpPdDRmdnZCQlFndUdUQjVjVkVZRE4vWlp3dTh4YXNGZ3E1?=
 =?utf-8?B?VVpNRm43OXpJanU2OFMweEVBK3cvNFhXNlNGWDBtMGQ3U0FrTy9XQnpFVGR1?=
 =?utf-8?B?bkd5Z0YwbmVrSHVuMGhoUUZpNTRONVV4K2J4QkRMWk1PdzBzc1FxZUcraW5m?=
 =?utf-8?B?dHVYQUdLYjR6d055V1VJNFlyU2hNN0NVNG16TmxlcHlqS0QvdE1QT0xDMm53?=
 =?utf-8?B?TVpEZStmYmZveVpIc0xBTjQvYWVyR3JSWDNRR0NobkI1L3FNRm5LY21BU0Qz?=
 =?utf-8?B?WW9vWDNNbWlKVjVMZ3lya0tDUG1sRjR0RGZ0dFFtOFVSdFFQRkVpMFFWeThP?=
 =?utf-8?B?Qmp6VDhZRHpJZ2tTQzg3Wk1xQVFTbzhsU2pGWjJsdG95eXdoU1FwQm9mVFFQ?=
 =?utf-8?B?Wlk0MUVQTFZhUjQyMHJMdjRMaUE3dG5qaHJrK0ZsekVxNTdNWkNLVEZpYmpu?=
 =?utf-8?B?VnpDQ09xWFRWREx0K29HMlF4eGhwZk8yUDZFZEpQcWdSMjYrWFQyR0JFQ24y?=
 =?utf-8?B?OVgvV2t5TG1XM0lIM1pzTVViTFRpYnVET2hCZ05YeWFJcVpyeHJaSURVRmly?=
 =?utf-8?B?enBvM3N2TUdLWDZSTTRuZXFuT3ZDb1RkSmI5ck9aV05Kc2dsc0M0UkszNGk2?=
 =?utf-8?B?WjhaYTlCV2E0NHdUNjFTZHR6TjQwWDdRaFNVS1Y4ZjFjTGNkbWRhUFdjR0Y4?=
 =?utf-8?B?bDRQTDdLWTRuZDlBYTl2Ykt5WnBiZFpJVmxRUklWN1gvOXhCanhWRm9TeVFx?=
 =?utf-8?B?VUFYTEhucndSekRVbTFsdllrWEs2OS9VWG5lSC96enNrRVoxb29POFVrbFF6?=
 =?utf-8?B?UzN2S3ZxdzNzdzZncG9BY3Z6UC9PcWVNYWorMkxINk5wbUoyb2ZyNldxRGNQ?=
 =?utf-8?B?MzJKMTdwdytmRldZZE9qbVQybTJiQjFid3lQM1RBUHFIaURJbmRyTndmQjdq?=
 =?utf-8?B?STgxMFR1RG1TMmxCM0U1MWF3UVFKUmlGUENsSzQyYkRMSEl6YWsyb3BRUHhu?=
 =?utf-8?B?V3RVY1N3TEFJblZna1dJZHRtdHlLTktZRDNsV2RUcHBUMzY0K21oUXZ5Y1E1?=
 =?utf-8?B?ZFFJbEZyaTZGM0lYaTVneWZrdG5hK1ByZDRmaHNTcjUyUEZ6UEI0ekJRY3FD?=
 =?utf-8?B?cFhrN3B4RnMzb2oxNXBLWDNLZG1Vd3RsVnhIVkxhbFpYVng3SHg4eGMyd3Vw?=
 =?utf-8?B?Mit3OTQrNmJkRGpsTHRnNUlXU0N3b205ZjVVejRVZXZoWU01VVJEbmVoS2NC?=
 =?utf-8?B?WThHUFhsTWxyWnVpWmFzSkl6L083cWNtQ1A2Q3dCeHZaUkVqRmVzUnBaeUNK?=
 =?utf-8?B?QlF0TjU4MWwxeEEwZHdmMUl1YkU1U3grLzV5U2pTcUp6REdxQjlLVGxCcGRr?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BdQc8S6BqYPkabkwWIaH2oZ1xZ5giSFccNgvCqUN5/VDAwYjq6Mj1LU/E1dVzOmWrzx43oK5L6rf74brAU5LAPvSulf0BZUVK4eB/H+Vo24u0C4biY1Zj4CHLDyHbzI6ssLE3+5G8hbv92XbDaH8MGwayBdGkUfQ6WrAgElOL361GC+pXl5knYw53El/US71VEUYvx3LiyKmcslcJarQ4ImuOeVRTNupoPF/32Zwc1bYpJvngbFM6wS0qTCoOrkNuzJrLpEiLB1Fr6LT3g1EuEwFSM+6n4NgzUz3af82dG/jL3pSV3E6xWkReO8O2cg1R/BZLZK9QG6Sp10zv8Z6TrnZOdLvqsrele2lGClOXrWWhlEM6r9rLvMFhCKbEFJ1QPVKwD6qCFyCLdmuyF2TvTrdzs+w8CNQEq08+RiLn60Nx/6nUjoKwPJAw5woQkBmb6jhq++xHF/nic59YDs5aVLwP3KECISX5yjAjmU1jbCTLCwficBBxRgIhz46XtsdKcbU1DPHvejeAwQB/5SBMkdFqHku6n6uhCZP6Wa6LJ+A+9ngY7d+MyQ/cOJmcuxLTY0hr2srLu01dIFgzDE6axxRM4FE4+vb6IlICwXZQgzYj33tcbiIPDYT8drU0ltK0iytAncY3mt+Ytqh7fBS/j11B9+Mv/exCKIIEFBRT8Yfp7dyNSpqPdhFMeY+RJ2zZ9PkcmL/ckA7uGIAr1h2lek9KEHI+XyNPotwIGTBum6zYMjONaVIm9Szj2Omi/gBgqRq6FpGOQ93cxpPQCrqRA1cMelUiAcHa3N8RuDwieVEWcn7aPWDYAEaRDGclmawwl77fPkg6dmnPSwbzRLTSm5YWJbSnF/0zPx2LvaZtIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f819c7e-f516-47f8-1142-08dbb892b54b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 22:00:45.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yF6wjNoj4yD/adOE1VhXgVo1vcIMPGkS/ibAYSaJfJCfj3SQ0SByt6w0S+SWv46S3aOmPOLGae/pYJDPWvs86BB9bw8bfXq0hXU3MLnRkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=828 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180189
X-Proofpoint-ORIG-GUID: Peea1Lw664v4p7u_yEcYRnoOkEb8jEoj
X-Proofpoint-GUID: Peea1Lw664v4p7u_yEcYRnoOkEb8jEoj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi John,

I'd like to put the emphasis on the fact that ignoring the SRAO error
for a VM is a real problem at least for a specific (rare) case I'm
currently working on: The VM migration.

Context:

- In the case of a poisoned page in the VM address space, the migration
can't read it and will skip this page, considering it as a zero-filled
page. The VM kernel (that handled the vMCE) would have marked it's
associated page as poisoned, and if the VM touches the page, the VM
kernel generates the associated MCE because it already knows about the
poisoned page.

- When we ignore the vMCE in the case of a SIGBUS/BUS_MCEERR_AO error
(what this patch does), we entirely rely on the Hypervisor to send an
SRAR error to qemu when the page is touched: The AMD VM kernel will
receive the SIGBUS/BUS_MCEERR_AR and deal with it, thanks to your
changes here.

So it looks like the mechanism works fine... unless the VM has migrated
between the SRAO error and the first time it really touches the poisoned
page to get an SRAR error !  In this case, its new address space
(created on the migration destination) will have a zero-page where we
had a poisoned page, and the AMD VM Kernel (that never dealt with the
SRAO) doesn't know about the poisoned page and will access the page
finding only zeros...  We have a memory corruption !

It is a very rare window, but in order to fix it the most reasonable
course of action would be to make the AMD emulation deal with SRAO
errors, instead of ignoring them.

Do you agree with my analysis ?
Would an AMD platform generate SRAO signal to a process
(SIGBUS/BUS_MCEERR_AO) in case of a real hardware error ?

Thanks,
William.

