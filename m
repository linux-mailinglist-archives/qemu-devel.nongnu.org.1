Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F10674662A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 01:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGSqb-0005Qm-Dr; Mon, 03 Jul 2023 19:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qGSqY-0005QK-J7
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 19:20:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qGSqV-00041q-0x
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 19:20:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363G8SVb029702; Mon, 3 Jul 2023 23:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=w/djzPb9fFQcPeRLtKQR5CcTQz0PKKHCLVRbEgeIgWo=;
 b=nAFz8e3VwDKzUA6EZoYcBa9/KG5agugo+qeJy0tkjTmjS6nwy1f1xbe1HDVyHmvSBh8r
 o60oshPjrA9bM4BB6KDJ4G7H3qnCcHHhl+03brl0PVIX/8U1xvmTi2q4QW4PGK5qmI9F
 qw7nyu1j8xpunSFGcmzxk3eXysQMIWFWvkUzOR65MluZnaxPqffHF7VihwRaw4A/TwxH
 cRDCDxFaKs42Y5VFKh1b/tomb+nZjXPSLFPl59pDd786f7bthO7P14odl6osXI7Jxt8Z
 XMRr5F3fFrVMx4c0KZCaHP6MMNRlBjdvY07yVjK786a+GNaOvJlPD4BHtbYanYAJGdC1 RA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjar1bjnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jul 2023 23:20:25 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 363MaTFV008991; Mon, 3 Jul 2023 23:20:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak9my41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jul 2023 23:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An9InwgugFe0VB+a0i2MIi3pUIxHmBbiw0OsKukI0wKFfa7oxiVD7xJGF5nfWXP1jocRdzvENO3kqW2wClTrQeswz5eFx8rBXR32uB8MAeOZ+Zx2BAsWs/7XK4CHnEM2/9MfsHgshSF0GzPXtJjWXpdWRXdCEq3GCHCVp0+YmjdBuzSND7XyOszyeJqJGzJ+No6COluawjTD/cWnYkw+6uxmA0lt7yDHsxyNHGIK/95nRGoI4g+kWxB30ZDYvgnf9ZU4Hbz9gPKnChTsm2T/JNvNB98x/3lNsN1m9C992RyjUKdPyF4Qs39X3JHNfqNTJjvy2kGt/pXHMvqe66I9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/djzPb9fFQcPeRLtKQR5CcTQz0PKKHCLVRbEgeIgWo=;
 b=SZq9K0qiaun/l1O2s0/62i8xB7azIWEfI24SwCwLjHlaj3uI04NfrGXBAVrbREcBLbeVPGnXXq7AJzcXNZwZ2GKFh8ZIhJlqunhYxrXDJFBqX+6MMK9blYXUYp7R7lw+a2mlr0+GjBfAimr0/hYlH3ZLHquQMeL0ID3YEyQMTbwE+z8ToTh6tkMhgiu/FQ7BVmbx13BUEVxWbsL5iBvkZdlV/Q1yZD5yxSwGTsMUlQS//chRlD51R4mz1Wn6kfgUYjevTfEFIjqcF1m+aRcBbzJSmtcfBCZ0nU+E+gCXFCEJpoV2Psa4OAlqQnBwx97FCiQNImUDucHaxMQTDESCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/djzPb9fFQcPeRLtKQR5CcTQz0PKKHCLVRbEgeIgWo=;
 b=LSnL7rVjbvnoJQ+vARbNSxpG46aGOKn55V64YvUF1TItq/oQA7l9LJ+ckCEW0kot1jl1y1HP5Gl58LZdCisqyRkgpIVAR7LCQSs4LwqJj1qJMDmMNRgEnjvuD6qsR8xLWcBUpYDEE8AzTVmbnUNeLPvdqWYn7zBCOi7PQDuJhZU=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by MW4PR10MB5864.namprd10.prod.outlook.com (2603:10b6:303:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 23:20:21 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::96aa:8e73:85a9:98b9]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::96aa:8e73:85a9:98b9%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 23:20:21 +0000
Message-ID: <25ac4ae4-cdb9-166e-88b1-df9af247c6c9@oracle.com>
Date: Mon, 3 Jul 2023 16:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND v2 2/2] target/i386/kvm: get and put AMD pmu
 registers
Content-Language: en-US
To: Like Xu <like.xu.linux@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 joe.jin@oracle.com, zhenyuw@linux.intel.com, groug@kaod.org,
 lyan@digitalocean.com
References: <20230621013821.6874-1-dongli.zhang@oracle.com>
 <20230621013821.6874-3-dongli.zhang@oracle.com>
 <CAA3+yLdC0Vo-cMuPh++U1-u=eROOG-YdaPrfCMUF+TgErtwj4w@mail.gmail.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <CAA3+yLdC0Vo-cMuPh++U1-u=eROOG-YdaPrfCMUF+TgErtwj4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|MW4PR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5e4c2d-0e67-43c9-607c-08db7c1c122c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIot3ncEbls7oygJzCmoScjbqrHYz+UArawz+OHVXXftwudZeHq2nZpLDjNvq0/QZ7gZ/XXW/YXl4Jiu31DWn7VbfMTQc/UV9xN4PoilKEEmG8obyzFYJ2qfhvdJq1RBagGMvlKdj+hNsWLEhIpOFnKCxn8nNsZ5zNDrcCm6jXcXbhtGXNwHx+ggR9MjoAFmat03ADUAl+NBnYzxNOIJrG6wYBGR8cWMSHoZnFKaCjGotOHp2HblUkxuQeW1Arr15Jqc32p78xW7S8fCuRri8v5Ht15AV1PxCqHQFQQstC8SWaUEMfumHchn6F7oKJHE3mi3+QoYVuv51mRGgyJOFgCt2pn0Prrv7BCV9uDBQsTEU/X5WXkvmNyU1qvTFta3gY51qxAnUKCS3EnzIycT3K2AAdEqLqFLkXYjIgv/de2zqiPrpT0oc1U6i6em/rENVoe5/HnVbpHoKETub+W+iWjM5aihBFgK6IUK+3gyahR87TLmC7oAlRmDlNt/jX0dQ73O/p1+Mi/c330X91eB4+y7spxUvPdt82lP6cvzozIVT1kWAX4WViShp8IdTP16xRnAyyomV4iuLDGvDOFM/rxrImSFLGLHtjlRVep2DRMwHujgzXFd594ing48yYCKVfmkja9rQcKHBlTJiX36qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(44832011)(31686004)(4326008)(66476007)(66946007)(66556008)(316002)(2906002)(6916009)(478600001)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(966005)(6512007)(86362001)(6666004)(6486002)(38100700002)(30864003)(53546011)(6506007)(26005)(186003)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEluWGVVVWowZTNaUEg4MEJEbjhnL3BkSW9ZNStQWDRjNTNQZ29WelNtSUVw?=
 =?utf-8?B?T1NKc1hGMmRHYUlBNTR6UHp6ME80bDkzR09FS3k5TGY2aUFNWDlSaUxtdFA3?=
 =?utf-8?B?N0UvMmIxRmlDaWRwSUkrUGticWxlQkJLd2JTOTFOZzR1T0xTR1lrVk9nWDZZ?=
 =?utf-8?B?OE9ocXREWkVvYnZYVmZ0S1Z1NjY2TzAzMXNJOTZ6UWNiWHFHYXIyWU5QL0tE?=
 =?utf-8?B?b2NnWklNM0tKUFUzcytmZHlMa1NZUTl2a3MrQTF5Z0Q2aldVYnUzayttV0lT?=
 =?utf-8?B?NEFTUEw0ZTNDaUNsczBmbnpubzNoMzZVTnpnbFFZV09jSmVhOFd2MTM0QmVS?=
 =?utf-8?B?VkhJNjBZdTVabFd1TndaekRqdng1cE5xYzdhRDZyOWlhbkNrVmswNUFibzl2?=
 =?utf-8?B?K3ZqRDU5dXZzclFCejlMVkoyZVdZWFI1VnR6UkFXQmhGd21KTDJ5b3J6eno1?=
 =?utf-8?B?SnZTUTZSRnk5ZUlSL1dabmhRZE9RWDdUc0pDcGFQaFNUSy9ENVAxR1lUOTJ4?=
 =?utf-8?B?cVJaNGYxS291d2t2dGVvLzNBSUZvL1g4MG83NHZQc2hVSm1CcUdDcnMwcUFM?=
 =?utf-8?B?bHFKQ0g0SS8rSmJmaXo2RTFyUjFSVmtRWHNhQ2o0bnVJekNQZUdoQ3VRRnVF?=
 =?utf-8?B?elFLOGJKOTZSSmU5T1J5eE42TkcvdGNzczc1b093NEtURUwrSDVGM1ZnZGhN?=
 =?utf-8?B?bml2dDI5bityemN6ZDZqM3FnZ0d1dUVYUzNwdHMyc2RSbVQrRHIrQkQ2eUY3?=
 =?utf-8?B?Y0FrOXJSNXlxZjZjK3ZrYy9saWJYUHUvejEycXJWcmp3ak5wU2JmZ280RTJu?=
 =?utf-8?B?RjVzMy9TczVTUjY4Z1B3dTlSVWxEdFFqaUFyNGFzTW9EV005VGZ4bDNicHQy?=
 =?utf-8?B?NklJRnJ4cjZhVmRWK3R5bTQ1YnY2VkpEMU5OanoxYlhaNUUxTGlyT2Y2bk5R?=
 =?utf-8?B?MVBDOFgzYUdLUXhlbVlUUXZpcUVscExmL0xKdW4wbkdjUW1BVUNCUjVTSS81?=
 =?utf-8?B?L1FNVUloQWN3Q0IrSC9VV3RadTN5MTZibmxOUzRqUlZtUlRReDk5dy9DYitX?=
 =?utf-8?B?a2V5S29XaFRuWDBOMFBRaENvNTdMT0p4OTl0MmpOS0ZDMXhUSzhCalN3WHFS?=
 =?utf-8?B?UHNkWUZVM2ZNWVlEc0xzTCs5Zkt2M0R6NHlsWEMxRlFMS3l6VzlkazQzcnpM?=
 =?utf-8?B?OWFPRVVzYUgxQnIzYnducTVyaG5aUW5iSEMxUVc2QkxmY2JQZmVrQ0dDeDhK?=
 =?utf-8?B?Ync1Sys2ZzRVV0dqMUszZk1QaUFxc0VsNndMdDdtaVdhb0lBWVljRGRacFdy?=
 =?utf-8?B?Z0pDVmRLamxSVkZWT1NLS05GR0taMHMvcUw2d2VwSUNVcDBDNElLai9XdDJM?=
 =?utf-8?B?OVJWcXM0bjNXQ3paa3hHRkNCemlranBUTCtVRmVjVXpSMldqbnkwa3ViRDlP?=
 =?utf-8?B?YU55UXdabk1SOFBscXNnNnUxZDRqYVRWdGt4YUlrb2cxK1ZCUkFBdjBVYitE?=
 =?utf-8?B?cEtCOUhFTm11NW9CWHI2Q2NUUFlFM3cvakRRREtORVJXRjc0WjdrL1ZqcWhh?=
 =?utf-8?B?NkE2UzNhYzZCVFJ4MXVjU3djZTdJdVQ3VUtpc2FDNjRqNXliNzMzZ3NLNDdH?=
 =?utf-8?B?NStyRjhmNGtEbVJ6YWhmeXhRMXJRbjNBVEUxd0Y1UUZWcTNUQTV0cnAybkdr?=
 =?utf-8?B?YVNPVU93UlBaY0JxSmkyNXFDaExZTkNjTXE2MURiNG5ZK04yZC9rTVBNcEtV?=
 =?utf-8?B?NFVqbkRTaUIwNkxWb2pLV2dwNWhYeE5wS0J6QjZQcG9wYjM5ZU9xSEcwWC9p?=
 =?utf-8?B?cGgzeHRtOTYwWlVSNUZtcCtLZFlrNDBSWERlekt4OEdPdDNURWN0RGc3WnRV?=
 =?utf-8?B?QmU1MEdmR045TUlvMml3TldlRHlwdFYwTlVjd3pvQ3hyNEl5UVRpV3AxVVc3?=
 =?utf-8?B?aEFPQWh6ZFByVGtlNDJLZWUzaHlQbkloYzkzdCtwbFZlM2tNUksybTl1VDVD?=
 =?utf-8?B?dW1zRDMybFVucmFleVVJTWJpbXcwb0Y5RERXRmRZeXJBTVdZdXQ2Z2NMNWZG?=
 =?utf-8?B?aWdkZ3d6NWQzYk9yL0FhNmlOZ1liUVBndVQ5K1FsYkYyOU93MlI2TTVXTnE1?=
 =?utf-8?Q?C3EcnTJnYWLBjFzJsjnajSDnp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vtU/H1B9rUb93mYG3kfm81K7BOaqbdkxmmY6IcV/9jIDGl0dlzjHIWAThCfeTGat2cme4X7FQ0/gaFh9yD17OteSzSDiSYqgDYSsSq95gxwKy7qcNwyPA0CAphxcuA9h1LSUZX2J7QQQKE8LoNvykPgF2HOX6UMooVdgrBIOvBAwzeNA6l5KFTmRNc40zUzWlqEVIx5ZKr5K1vhUGxQ2tDfuypLrgBKEanGiot0MiXXk63XPsGdZB01qzGNG5kQRQxzu300urY2VBEpgunF5ZaZJ6/bjWRGlJ94YCbuhgmpCQLR2gOeCINbSe3ZOUzKl9wFbY6br5tHHFejDkNcHIjmZrJA6sDo2lcfzPA/IG6htCZ5m9bCwT1UqA/4DphbUJEwQRm8Muo5g5eCakSFX8HHCfD8DaWrqkpibq3HCq2DX852o2PtCMaybMhVa+V+qUkXX+dECuXmtURta3yu266yML/EoKlJI/YYIQ6jOj2UUaIsGCvAEB7a/jTXrEATDDAc6v9h3uPXBBuFyzPk9Ikbqd/IGF492M5TPtvtyD6hnbrTj2cMyw2MCB18+3qkEwsFohZzA90T5fBCqk6yijeuJzmt8ec+T8ZhCC2ssosBKXnIQWeUIDwboqDo8gvzMzkt9r9FSIElqgxhLAPwdObcmEWcUZljJkNABlXYAUv0Xgwvm6z+r11GeHI8lAzokQB/gdrErrh0XnJa9uAQ8yK9bX/FQ/lYVxeH7+SMUoVaM50UAdMCnEujwg+eqgp/z0FzdL47AB6R9AD+Ofx9dri+G9TFElNCXkWZhI85eTX+tQ1e4l4gjRWJ2b9FZAqZQ1NEGhd9y/V3dZVDkYZncuNbE+M5fNMr8Sc70xK1ExF+pjriL3/BLpr2NYnGVGLqhpSViXvTL8vFGWEl1LyYOmJlEXr1wSrBTCMfiNsHn6r0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5e4c2d-0e67-43c9-607c-08db7c1c122c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 23:20:21.0250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYRdCNuCopRVH+fh1TZH6UvhJWt6OGESyl5MQvNvCU/uq7klAaDE4DMWgs1r+DHggslACjw0NVfPPiJ0kRn8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030212
X-Proofpoint-ORIG-GUID: 3aXyJgRcyeSSmK_Czp-4M0-JwBagku05
X-Proofpoint-GUID: 3aXyJgRcyeSSmK_Czp-4M0-JwBagku05
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Hi Like,

On 7/2/23 07:15, Like Xu wrote:
> On Wed, Jun 21, 2023 at 9:39 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>
>> The QEMU side calls kvm_get_msrs() to save the pmu registers from the KVM
>> side to QEMU, and calls kvm_put_msrs() to store the pmu registers back to
>> the KVM side.
>>
>> However, only the Intel gp/fixed/global pmu registers are involved. There
>> is not any implementation for AMD pmu registers. The
>> 'has_architectural_pmu_version' and 'num_architectural_pmu_gp_counters' are
>> calculated at kvm_arch_init_vcpu() via cpuid(0xa). This does not work for
>> AMD. Before AMD PerfMonV2, the number of gp registers is decided based on
>> the CPU version.
> 
> Updating the relevant documentation to clarify this part of the deficiency
> would be a good first step.

Would you mind suggesting the doc to add this TODO/deficiency?

The only place I find is to add a new TODO under docs/system/i386, but not sure
if it is worth it. This bugfix is not complex.

> 
>>
>> This patch is to add the support for AMD version=1 pmu, to get and put AMD
>> pmu registers. Otherwise, there will be a bug:
> 
> AMD version=1 ?
> 
> AMD does not have version 1, just directly has 2, perhaps because of x86
> compatibility. AMD also does not have the so-called architectural pmu.
> Maybe need to rename has_architectural_pmu_version for AMD.
> 

Thank you very much for the explanation. I will use version 2.

> It might be more helpful to add similar support for AMD PerfMonV2.

Yes. I will do that. During that time, the AMD PerfMonV2 KVM patchset (from you)
was still in progress.

I see the pull request from Paolo today. I will add that in v3.

> 
>>
>> 1. The VM resets (e.g., via QEMU system_reset or VM kdump/kexec) while it
>> is running "perf top". The pmu registers are not disabled gracefully.
>>
>> 2. Although the x86_cpu_reset() resets many registers to zero, the
>> kvm_put_msrs() does not puts AMD pmu registers to KVM side. As a result,
>> some pmu events are still enabled at the KVM side.
> 
> I agree that we should have done that, especially if guest pmu is enabled
> on the AMD platforms.
> 
>>
>> 3. The KVM pmc_speculative_in_use() always returns true so that the events
>> will not be reclaimed. The kvm_pmc->perf_event is still active.
>>
>> 4. After the reboot, the VM kernel reports below error:
>>
>> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
>> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
>>
>> 5. In a worse case, the active kvm_pmc->perf_event is still able to
>> inject unknown NMIs randomly to the VM kernel.
>>
>> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
>>
>> The patch is to fix the issue by resetting AMD pmu registers during the
>> reset.
> 
> I'm not sure if the qemu_reset or VM kexec will necessarily trigger
> kvm::amd_pmu_reset().

According to the mainline linux kernel:

kvm_vcpu_reset()
-> kvm_pmu_reset()
   -> amd_pmu_reset()

The PMU will not reset when init_event==true, that is, when processing the INIT:
line 12049.

11975 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
11976 {
... ...
12049         if (!init_event) {
12050                 kvm_pmu_reset(vcpu);
12051                 vcpu->arch.smbase = 0x30000;
12052
12053                 vcpu->arch.msr_misc_features_enables = 0;
12054                 vcpu->arch.ia32_misc_enable_msr =
MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL |
12055
MSR_IA32_MISC_ENABLE_BTS_UNAVAIL;
12056
12057                 __kvm_set_xcr(vcpu, 0, XFEATURE_MASK_FP);
12058                 __kvm_set_msr(vcpu, MSR_IA32_XSS, 0, true);
12059         }

According to the below ...

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d28bc9dd25ce023270d2e039e7c98d38ecbf7758

... "INIT does not initialize the FPU (including MMX, XMM, YMM, etc.), TSC, PMU,
MSRs (in general), MTRRs machine-check, APIC ID, APIC arbitration ID and BSP."

That's why initially I did not send a KVM patch to remove the 'init_event'.

> 
>>
>> Cc: Joe Jin <joe.jin@oracle.com>
>> Cc: Like Xu <likexu@tencent.com>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  target/i386/cpu.h     |  5 +++
>>  target/i386/kvm/kvm.c | 83 +++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 86 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index cd047e0410..b8ba72e87a 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -471,6 +471,11 @@ typedef enum X86Seg {
>>  #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
>>  #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
>>
>> +#define MSR_K7_EVNTSEL0                 0xc0010000
>> +#define MSR_K7_PERFCTR0                 0xc0010004
>> +#define MSR_F15H_PERF_CTL0              0xc0010200
>> +#define MSR_F15H_PERF_CTR0              0xc0010201
>> +
>>  #define MSR_MC0_CTL                     0x400
>>  #define MSR_MC0_STATUS                  0x401
>>  #define MSR_MC0_ADDR                    0x402
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index bf4136fa1b..a0f7273dad 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2084,6 +2084,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>          }
>>      }
>>
>> +    /*
>> +     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
>> +     * disable the AMD pmu virtualization.
>> +     *
>> +     * If KVM_CAP_PMU_CAPABILITY is supported, kvm_state->pmu_cap_disabled
>> +     * indicates the KVM side has already disabled the pmu virtualization.
>> +     */
>> +    if (IS_AMD_CPU(env) && !cs->kvm_state->pmu_cap_disabled) {
>> +        int64_t family;
>> +
>> +        family = (env->cpuid_version >> 8) & 0xf;
>> +        if (family == 0xf) {
>> +            family += (env->cpuid_version >> 20) & 0xff;
>> +        }
>> +
>> +        if (family >= 6) {
>> +            has_architectural_pmu_version = 1;
>> +
>> +            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_PERFCORE) {
>> +                num_architectural_pmu_gp_counters = 6;
> 
> Please make the code a little more readable with some macro definitions.
> 
> #define AMD64_NUM_COUNTERS 4
> #define AMD64_NUM_COUNTERS_CORE 6

I will do that. Thank you very much!

> 
>> +            } else {
>> +                num_architectural_pmu_gp_counters = 4;
>> +            }
>> +        }
>> +    }
>> +
>>      cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
>>
>>      for (i = 0x80000000; i <= limit; i++) {
>> @@ -3438,7 +3464,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>              kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
>>          }
>>
>> -        if (has_architectural_pmu_version > 0) {
>> +        if (has_architectural_pmu_version > 0 && IS_INTEL_CPU(env)) {
> 
> It seems to be saying here that it is possible to perform kvm_msr_entry_add()
> for Intel-related pmu on AMD platforms. So the reverse is expected to be
> feasible as well. Why need distinction?

My fault. I always used something like below when emulating AMD on Intel host.

-cpu EPYC,vendor="AuthenticAMD"

I should consider the AMD-on-Intel and Intel-on-AMD case more carefully.

I will address that in v3.

> 
>>              if (has_architectural_pmu_version > 1) {
>>                  /* Stop the counter.  */
>>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>> @@ -3469,6 +3495,26 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>                                    env->msr_global_ctrl);
>>              }
>>          }
>> +
>> +        if (has_architectural_pmu_version > 0 && IS_AMD_CPU(env)) {
>> +            uint32_t sel_base = MSR_K7_EVNTSEL0;
>> +            uint32_t ctr_base = MSR_K7_PERFCTR0;
>> +            uint32_t step = 1;
>> +
>> +            if (num_architectural_pmu_gp_counters == 6) {
>> +                sel_base = MSR_F15H_PERF_CTL0;
>> +                ctr_base = MSR_F15H_PERF_CTR0;
>> +                step = 2;
>> +            }
>> +
>> +            for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
>> +                kvm_msr_entry_add(cpu, ctr_base + i * step,
>> +                                  env->msr_gp_counters[i]);
>> +                kvm_msr_entry_add(cpu, sel_base + i * step,
>> +                                  env->msr_gp_evtsel[i]);
>> +            }
>> +        }
>> +
>>          /*
>>           * Hyper-V partition-wide MSRs: to avoid clearing them on cpu hot-add,
>>           * only sync them to KVM on the first cpu
>> @@ -3929,7 +3975,7 @@ static int kvm_get_msrs(X86CPU *cpu)
>>      if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
>>          kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
>>      }
>> -    if (has_architectural_pmu_version > 0) {
>> +    if (has_architectural_pmu_version > 0 && IS_INTEL_CPU(env)) {
>>          if (has_architectural_pmu_version > 1) {
>>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
>> @@ -3945,6 +3991,25 @@ static int kvm_get_msrs(X86CPU *cpu)
>>          }
>>      }
>>
>> +    if (has_architectural_pmu_version > 0 && IS_AMD_CPU(env)) {
>> +        uint32_t sel_base = MSR_K7_EVNTSEL0;
>> +        uint32_t ctr_base = MSR_K7_PERFCTR0;
>> +        uint32_t step = 1;
>> +
>> +        if (num_architectural_pmu_gp_counters == 6) {
>> +            sel_base = MSR_F15H_PERF_CTL0;
>> +            ctr_base = MSR_F15H_PERF_CTR0;
>> +            step = 2;
> 
> Perhaps it would be more helpful to add a little commentary on why
> step 2 is needed.

Sure. I will do that. The step "2" is because MSR_F15H_PERF_CTL1 is
MSR_F15H_PERF_CTL0 + 2.

#define MSR_F15H_PERF_CTL0              0xc0010200
#define MSR_F15H_PERF_CTR0              0xc0010201


Thank you very much for your feedback. I will address those in v3.

Dongli Zhang

> 
>> +        }
>> +
>> +        for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
>> +            kvm_msr_entry_add(cpu, ctr_base + i * step,
>> +                              env->msr_gp_counters[i]);
>> +            kvm_msr_entry_add(cpu, sel_base + i * step,
>> +                              env->msr_gp_evtsel[i]);
>> +        }
>> +    }
>> +
>>      if (env->mcg_cap) {
>>          kvm_msr_entry_add(cpu, MSR_MCG_STATUS, 0);
>>          kvm_msr_entry_add(cpu, MSR_MCG_CTL, 0);
>> @@ -4230,6 +4295,20 @@ static int kvm_get_msrs(X86CPU *cpu)
>>          case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
>>              env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
>>              break;
>> +        case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL0 + 3:
>> +            env->msr_gp_evtsel[index - MSR_K7_EVNTSEL0] = msrs[i].data;
>> +            break;
>> +        case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR0 + 3:
>> +            env->msr_gp_counters[index - MSR_K7_PERFCTR0] = msrs[i].data;
>> +            break;
>> +        case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTL0 + 0xb:
>> +            index = index - MSR_F15H_PERF_CTL0;
>> +            if (index & 0x1) {
>> +                env->msr_gp_counters[index] = msrs[i].data;
>> +            } else {
>> +                env->msr_gp_evtsel[index] = msrs[i].data;
>> +            }
>> +            break;
>>          case HV_X64_MSR_HYPERCALL:
>>              env->msr_hv_hypercall = msrs[i].data;
>>              break;
>> --
>> 2.34.1
>>

