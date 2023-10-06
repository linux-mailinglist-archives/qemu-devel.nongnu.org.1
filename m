Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122E7BB6E6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojII-0007IH-0x; Fri, 06 Oct 2023 07:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qojHL-0007CX-NK
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:46:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qojHE-0002zF-Jh
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:45:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3969Dq3K015048; Fri, 6 Oct 2023 11:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qCoo5PYyDEgywYRtNT5M+rUO3rRT3t+q3/1s8jljNPE=;
 b=Y4f3rPgvIwtQe2dWZEFUmF0s5tK6e+vMBY17xNNKveO1vmIahg5VmQw91EYTjuLon8yP
 7VgHOtMyrJ5dMSPE4yXlVg5pGn/Rk2Wx699YLdEKBSsBBSDMIosVlBO5v7CNbv2xJTZH
 G0jELDk7yGxThqEG9RyTQinh0olv+u1foEtNdwB5swSOMoYRHmgeP3KZrVDalIov+921
 WYI3Jc7j99oCZu1vUy0NCJHVC9PLQAtWNoalaW5j6tgLV02sXwSq3FOxOxxx8RJW33Yq
 vmY7Xy1t3Y2ialSA2RU8WFzE10w0UjLYv2vOrGq2Syx2oZWIPXhrMuRllIcY6Si28JBK EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4bqnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:45:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3969PSWE005814; Fri, 6 Oct 2023 11:45:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4ajpkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaTJCOkkaLL3qcFkGBbsiPOM0uxFAi07Nx9jt03S+5uSxgqdDHNW3KK+RFQ/0A1eZrXr58kpsaRBe/LaygugiTcQCyEdzFw1PchxNsq0qlLUYGGI0OmUvOadBJ0sDyuvpJ6mIWRGK58vD6xW7cy0YiKYsT+2To7vVA14tb2K0KJiBTEthJHA3TL/crlzH1eEKVoiJIoYntjVOZcDXr1KDkcsGGpshUL/uES7p3Xu2LSXN9ueq2243fblWkf8v3F67FEDKo4i82FVGJX+OlN2hieFCB28QtEM58RaSZJywCG6RIpFR80mXPWEQcFyRTXWMQ+UHk8fUehbxdkVX0TCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCoo5PYyDEgywYRtNT5M+rUO3rRT3t+q3/1s8jljNPE=;
 b=XU8fuTMDQolC/E2+oaoxxsyYgaAvvCgqeYfpCG8PTVUrfgitPpafmACYNfyBkQFCHDgt8VjP/glVxhv2TlqC0yALbgsSmMwQnkBDvA7Dy9rmB0INUEJLgPOqzCPxw0srKnut3NATYNkUpEjEeSojqvO+6w60gcmYlPI+8fIAyWAo+yaG6m5Sl7g8ec+Ac59KYSIaYNrioKd6MwIy7pl8nGEqczoxrE0PN4YIqIlWJZ/He0xrYGjrWLPn11iV+2OlUwq9kAOXZXXuAorIdTSO9reqK4loRGlHptXkMcUyaolNoEdLCy+ZbBgV3w9u9ZniLrKdhgNG+opPn4GtB3OSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCoo5PYyDEgywYRtNT5M+rUO3rRT3t+q3/1s8jljNPE=;
 b=JHlK1CQ2vuChzO6icPYTyChN/4jBDTwB4kbSlcWBc47KEoE475/FJhul/8nWbxrE2lIhd61n41X54x9gFmb1gSm22zcTFZ3yi9jPZ8Tz2OF09pRGJc+RJMZkTtMsiyrX21V3BSx7Glasd24KGgLUVK9shIVnOukcoKdzhVApdj4=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BN0PR10MB4872.namprd10.prod.outlook.com (2603:10b6:408:124::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 11:45:45 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 11:45:45 +0000
Message-ID: <a1066697-50e4-41f3-bd78-2bb9b528f21a@oracle.com>
Date: Fri, 6 Oct 2023 12:45:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] migration: Print expected-downtime on completion
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-6-joao.m.martins@oracle.com> <ZR29849MU0dmXBlg@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZR29849MU0dmXBlg@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::36) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BN0PR10MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cad863-1021-4eb7-3ab2-08dbc661c6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZWHOafJPagnVO0j6tYzV/xl665Dt2YctZD+uMLLEMbdIddCo+Y95wG0QiilzfazMJXcN2wR3n/9Kt5vJgjt/A7tKosz0NugLUNOj3Cccm+HIRbumOtoiRv2pNbiV61SFAdmuNxeQsIJj4z+Czw0PECp9U1n+O6w/BJGLJ89jmxtnsWPEqm2ZCnR1EX/BtQLHv8DniuWk5dF+Yy4mG7F7ta4VuIGc415Dm3A+vmous6g4uiB6sgQGRtpm+oB0Fn3O84dkPSD0PoFvgYEeXg9HyGCYT391fdtO/7vR3SeEduHgxJvyw80DffAF9OjY5IEiphRrVbGA5hR0T30ayJ67Nag1tC08YVDQdSr94frJ8w0WmewBAYI6Rfa1at4cKdL4l0aJBW1a7ev1pjXMEKdd7x30smNObQDBo18Qs3Uv4JJoLH3NzfFSR2AC35kVapC87v9L0pGvP1anpg1C9PhHWdi/8RoVrGJWor6shC34/s6s979X+alB/Vm40qE91WxI3wD58Jwn96440tfGvSoa5/i8uTL7kGyQ9gYr6QcpU/9yRZjqKgH0dBV0ds7NQMNMGetrKQ3cYVwl6DayKSQ2c7hPi3r0TAv65MTU0BaPGVJxdQbElbYwnisfAlZTgBxP1E4EFq1KA8ZI/3bWV8fSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(66899024)(6506007)(6666004)(53546011)(6512007)(6486002)(478600001)(38100700002)(86362001)(31696002)(2906002)(316002)(41300700001)(2616005)(83380400001)(107886003)(26005)(36756003)(66946007)(66556008)(66476007)(5660300002)(54906003)(6916009)(4326008)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1B3a3JxS0tDZ1hTbHQwUCtpQ1pBbDFSMW45dGs5ZndKRzZIQXNPTVdUTzd0?=
 =?utf-8?B?bWFtMGs4TSsvOXRjNVhidktpK1ZFczZSZVp3R0tRSDdGNE1nNERoN1dxL2RS?=
 =?utf-8?B?NW85T1ExWDlHNHlDQmk5OVJaeFJsUDZMUzMwdFFhN0d4dGxNbmFCcGNCOWoz?=
 =?utf-8?B?NitsOWkwYTNJMDdvTitWOTIxc3NKNEwxbkVseXMyWHpGSFlGaTcwTHN1WmhM?=
 =?utf-8?B?ZVk1MFdOczQvU0J6ZkxrcUZXU3NaOWM1a0VZZUs4em5zaEdiWlJHKzlDRGt5?=
 =?utf-8?B?R3JDb3VRU0RQNlBpbXNCcGNIelFRNTdrK1AxUDlOcnJDeHlSdmo3NXdzbTRH?=
 =?utf-8?B?enFqNVRwZ3dMdUxVVWpNYTRheERnSVBSRDd4UG9OaURFa1Nhc0FWQmlGNi85?=
 =?utf-8?B?b3psd1NGQ0Noa25MZi9Jam40N0JQTFBHL0pFMkRnOTQ4TnRpbFBCZklYNmM1?=
 =?utf-8?B?cnlnamgxZWpyL0R2NXB4YUlzRElFQ05ocTNsUEhGQ1VNZHNqWXBhQndGakc1?=
 =?utf-8?B?V3lsZUZIemkvMEVqOS8vL1R4cXZTU21JZVBET1pKMnA3MmRMV1d5dG9mNEIy?=
 =?utf-8?B?dXZZNXQ3cDF1SU03TStocXdXL09HdGNrdEszL2k5WjZ0bGVZMGZ1OERHTndT?=
 =?utf-8?B?ZTRoOXVxTW1oU21pcjR0VjdKdnNzekZibWhOK1A1ZGVmREMxVXc2VEMvUFFR?=
 =?utf-8?B?ZjRINktYWitMNkdVdENTVGNLK0ZxYXViTXJFWld5cFg5bjVuNE0zN3dVVzQ0?=
 =?utf-8?B?RlpRRmJVd2VFZzBCL1RUOUxUYVF2WFE5SWpzQWlmYjI4SHBwRWFuQys2NXhI?=
 =?utf-8?B?Z1FHUXlOY211Nld3cyt6MXJUQjZ0Q0UrOGJPczh5ZkcySTZMc3pOUGtubytn?=
 =?utf-8?B?ZzNKYWsxa0E5TG9oTXlleUtJNDFUNjNSNDJyb0JGWnlnMkc0ZFUyVXpvZUhx?=
 =?utf-8?B?bTR1d1kvT1psZEQySmUyUG85MGRCYk1seDdxbWlMeEtadndKUUhZcFNOVUVw?=
 =?utf-8?B?YkRaa1MwdkgyYlREQmdRdDNQcnZ5NTBWc21vbGkyZXlnN2pUL0dHNmh1RHhT?=
 =?utf-8?B?Wm1zUWZCMnV0NENOeGdTaXFUYVdUZ2lXQmdIU1V1cE5WRWhkKzlFRTlNZFNx?=
 =?utf-8?B?aTRBQ0wvWHRZWGl5ZVhKVWJkZitnV1YxL04xQ094U2xSREkzTklwaXg4emJv?=
 =?utf-8?B?Z0VzTHgydng2cng1bXI4YnZEcnEwazlobHh1eU50aUN2b3I3UmRvR3B6L0FM?=
 =?utf-8?B?RXFDN1Nnc0lIWVJuYXkyL29mZVNaMXZIZGJnNkdNQzZjWklsQjBWRmFtUVhs?=
 =?utf-8?B?Z0MzajEwQTRIM21BT1NkWFRtWGpZSFVVcUFyNk9VSXU2ZlFEU0NYdndVc1ZR?=
 =?utf-8?B?aHNnc2tNOFQwNVlGSWtFL082TVZMMnZzZmFQa1l1M3d1bUQ2THBIcWxHT2Fm?=
 =?utf-8?B?c1ZDdUF2eG1tWVplaDhQZHU3MXkvd3lmSGRPUWtjUGdUbys1aEdQRG5JUFJx?=
 =?utf-8?B?LzRXVWV3RmJQaTl2M3g2dUJkQURYRkdkRzVwd1VPZWhuaU1wRnU2SHlsTWht?=
 =?utf-8?B?eStmTEZtM3lRNTV5ZTBDa2Y0dG9wcGxKdHVWQmMwdGZCSUxFTG9EVFZJOEVh?=
 =?utf-8?B?cTV1czdRSTJsRGVnMVJIaXc3MzJvRUJVL05DamtKSXdvTDZvUFMrMC84U0F1?=
 =?utf-8?B?UGFEUmhoL01yeXlXQWdkcExZaE9wTmtYMTBpZ2ovMFk1QmY4clJua25WNmtY?=
 =?utf-8?B?VVlmK0VYd0g4dStOZnFOTUEydXc5Z2tIUytZRjVtcE1qSytBczZ2RTBZbFJ6?=
 =?utf-8?B?M1gxT3NnOUtxU2dwMHlid2hOTXltSWg3Zk9PZVlkZDUxRUovUGoyWXVIanB1?=
 =?utf-8?B?MTZsRE5iN0J6ZkxHeUpnQldQcFNGS2NRQ3kvM0ZFWGs3QnB4ZTZpQXJpUnkw?=
 =?utf-8?B?MlZ2R2gxTzVGeGRYMURSNWF6WlRmY2NjcXlPL0VQa3JETTRrMVBSVHh6QnJs?=
 =?utf-8?B?MUpUclhjMnFvbGhpL3NCNGtGTERGd3JYbnZpbHVOa1pHL0l5dlBXSjJaa2J0?=
 =?utf-8?B?RWdaeHlzbC9yOFlReThkeHA2ZjMrZUxISEsxd3VpTC9sUFVRSWtvSkpvVXBR?=
 =?utf-8?B?aE9rMWxrdlJJZFZENmVMMUFHNjRKb0VEZWZ4eHFiVmNMMElCSHk4OW9CVmVs?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wrm7rws6Db/FtBs0wI6tUHlgidNynfY72i2CHOovbSUIO39OiI1bzEQKZNX907f+R35JpIhCUgbj2VzT3tse6VoZjotBNYMQbWVqpa1VvKWuj29E8yWtFvfjzsZEAkrTTR1RWDi6gMQGfdez72cajAcSw5xO9aLyYQC35oLgqcLF7XvibDXq7UPDBR2ADhvMsJgnEoozaUJ5BEq/ISptHHzch7V10HPssVXq1WHF9+XTF3MMjQfc4Nc0l86O5qaBq/OM9DVar8DfCdBWEMyozCZyGr9n6/Vk8BBKR5cRIyMPZPfjgx3fXNo/9Nzyamp0+0mXh/XfiAcm+R1LRxZ1Hk+79xFC3gmZ4+eZj6xbgn1Hz1SBI4x9od5uHS1OS0t9LjIj2Aq9WZWRJ2iiodxgeIzXrPGZrMPKmfNewFBz5Qh6fGPoZDJnaObSF9MKOs+tM8C6CVBw8O6yLNk5u1IXvq2I4OhHoo8TjGnBfRy1uWJCzaf3x22h1pqv/YQp7p2kGkKxb9ynSFKA7BcfWigmE+WBm8N7bys7uWmvgj+UdI67BlHsrffElhBcLrReC5wfhlp4NAnPrui+FcYJGdT+q3WKN+iYCkm9aZ9OqIpnyHqyXh6qi7tUJeZ8HGhUgDkGnoxa+GaT0Oh5w0GW3Xg2IN0012LsDQ2GEQBeaGU+g1Jk9ViU4IQFZF5Ckj6OgsG/37VSIizOwk+L+gmiQ9JpN+XYIUmN04FP/4A6fT2np4Sy7LahZSAB7ClC8ZjslPTqzRo0cGTTPm4w7UrazHjpp6xqYpC44YHTvxbIZFoTQxWsOa2tXRWGYp4v+wej+uGn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cad863-1021-4eb7-3ab2-08dbc661c6d1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:45:45.5445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sboFqQYd2FtZki7zF9lJQ1KPV2M1T3A0eu64XDX012bAwYYFymdm2/2kqOcWqgf+HM4dOqzKYQo1BWVhIf6uty+ewQ+VrQM2aEWF38IZJs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060086
X-Proofpoint-GUID: L6wGYCeNlKnsxLIFUOyD60dvmQNVHmGj
X-Proofpoint-ORIG-GUID: L6wGYCeNlKnsxLIFUOyD60dvmQNVHmGj
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



On 04/10/2023 20:33, Peter Xu wrote:
> On Tue, Sep 26, 2023 at 05:18:41PM +0100, Joao Martins wrote:
>> Right now, migration statistics either print downtime or expected
>> downtime depending on migration completing of in progress. Also in the
>> beginning of migration by printing the downtime limit as expected
>> downtime, when estimation is not available.
>>
>> The pending_size is private in migration iteration and not necessarily
>> accessible outside. Given the non-determinism of the switchover cost, it
>> can be useful to understand if the downtime was far off from the one
>> detected by the migration algoritm, thus print the resultant downtime
>> alongside its estimation.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  migration/migration.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index dec6c88fbff9..f08f65b4b1c3 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -943,6 +943,10 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
>>      if (s->state == MIGRATION_STATUS_COMPLETED) {
>>          info->has_total_time = true;
>>          info->total_time = s->total_time;
>> +        if (s->expected_downtime) {
>> +            info->has_expected_downtime = true;
>> +            info->expected_downtime = s->expected_downtime;
>> +        }
> 
> There's another chunk right below that will also show
> expected_downtime.. How about we merge them to be clear?
>
Definitly

> IIUC the current patch will not display expected_downtime during postcopy,
> which makes sense.  But it'll pop up again after postcopy completes... so
> not ideal either. If so sounds easier to just show it as long as we have a
> value, and the user can ignore it.
> 
Yes.


> @@ -913,7 +913,9 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
>      if (migrate_show_downtime(s)) {
>          info->has_downtime = true;
>          info->downtime = s->downtime;
> -    } else {
> +    }
> +
> +    if (s->expected_downtime) {
>          info->has_expected_downtime = true;
>          info->expected_downtime = s->expected_downtime;
>      }
> 
> IIUC currently expected_downtime for postcopy makes less sense. 

I think it makes sense, you still need to switchover to destination. Knowing how
much you miss is useful? Albeit compared to the rest of the algorithm is less
critical than say in precopy.

> Maybe one
> day we can make it reflect reality, by taking more things into account
> (besides dirty RAM rate).
> 
>>      } else {
>>          info->has_total_time = true;
>>          info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
>> @@ -2844,6 +2848,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>  
>>      if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
>>          trace_migration_thread_low_pending(pending_size);
>> +        if (s->threshold_size) {
>> +            s->expected_downtime = (pending_size * s->parameters.downtime_limit) /
>> +                                   s->threshold_size;
>> +        }
> 
> I had a feeling that you did the calculation to avoid accessing ->mbps. :)
> 
It was oversight on my end

> I'd suggest we move this into migration_completion(), and use ->mbps
> (before the other avail-switchover-bandwidth patch lands).  It's just that
> using the bandwidth value seems more straightforward. 

It is better that way, and things get consolidated.


> Or maybe I missed
> something tricky?
> 

Nah, just oversight :)

