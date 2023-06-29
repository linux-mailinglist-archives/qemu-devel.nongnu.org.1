Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2C7429BE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEteZ-00067a-TY; Thu, 29 Jun 2023 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEteX-00067S-O3
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:33:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEteU-0001JA-L1
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:33:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TE7nXU008923; Thu, 29 Jun 2023 15:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PzUVStL0Cda1SWiIa5Hwq/SXMXMxPDy2YrFgumGrCnI=;
 b=NQne/U0qNRjox6kEaLjz2SRLQkClH5Fh4do8dRtPp+fUPFWAgwLcVR2ZkRtwzZ/A9UJ7
 ERL4l8WUrRxwgZpQKa3Lt62yXnkquDExQ3BYYZxmzcPOX9mRzeUm0IN+FtcP5mypeENx
 Eh+lwPWZfu4eUNJcCVVF6wqkzoGAzr9hzWyKP5fJVezq1SenOlLLNXgQnpLGOB0/2HtK
 jCJF0NhnuMNfJdYhJlWkQP1osyork9cPVRExtXkz/Jr65aKLRruE9CrTPz9EZoJ2XqUw
 U+okMXWT8s+5yq7YcLiKAeps1QqcsKkbyGBCFJs3+b+bJxDQbEC7u3CU0KRyZT8nYhWm pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1ucrf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:33:39 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TEeIPP013088; Thu, 29 Jun 2023 15:33:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx7srjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:33:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxsJUHv/zq50uY1gHncNSRogpmGc4GGlL2kFkpA1QambEXb/2WVcOXBvOJmSuKyin6ssKjpfWfJ6g9e+Ap1csgERFZHB0+OYm8ybNW8793YaJkr8Mbi5eLOSrlmGjqgpYj+zHlJovpyE6hAFglJviGTLhJlpJxP3KjcfLQkwMqfJrJS7zWy4qmMc8R6zF8D3r5/ktQK1+yaD2Ck36pjyaq8X3UCN/svzTF8YpR9rp8D3udhqD3E0YWZ4cTAzYPDaZ6MNNPujz/JP06U2JAg2UpmjrKWdgbDCg390Tz3qXrirMMe9dCMIgQ0KLmaJlyYQiLZ4chTjfRUXjr8uxQwokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzUVStL0Cda1SWiIa5Hwq/SXMXMxPDy2YrFgumGrCnI=;
 b=KWJYXt0OUNWYMQq/AB3Qw5l8dvEt9IPCXt7HPCkzgcltGvqzLnDHzQWv7GCUOUKmP62Vt2O8S7x+PkgwVbHdyGm87mAJnsM+aBg/qVyH1biK3dl08YwHFFoudpP/xh1gxN55EsCMM8BWmU3lpKfAkvLa8k0+xc4fOAHZamRbMhcLf+Pxs4ZxmiIlmPiYUl0xl5oWe55Gz6SOhZga8jCA5Jsi2ovrcJNpPgF8j06f0uU7XA7tQ6zP0FK6/1J22rsJti1FGTtu+eaaBEMxP35zxNqV+HNJ8y9w57fxj+zd/dbC76zQH69ULnG1QybUQO3ReYZfyEXn3Nv9WxUMbA8G7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzUVStL0Cda1SWiIa5Hwq/SXMXMxPDy2YrFgumGrCnI=;
 b=JKW3nJKA/UYSXmpwBltmKqWIrjKMSd9mk45Sra7KozRqnsFeqBvz6hIVSuRj866DKjbwh+gmsCSIPxHrF1ktLvrLW3EUsDqyx7ngqcLgF3yQ/JBi3Ydvqx8Ho4C5Xu0i/idrVCEF0yhRgi6SGmQwYJiweCHx27ZSGtMPPXUKoaA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 15:33:26 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 15:33:26 +0000
Message-ID: <c32ef5f7-4c42-403c-22b6-734432c01e19@oracle.com>
Date: Thu, 29 Jun 2023 16:33:20 +0100
Subject: Re: [PATCH v4 3/5] vfio/pci: Disable INTx in vfio_realize error path
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-4-zhenzhong.duan@intel.com>
 <29b6ecd3-d0a1-c914-9bba-cb99d95acd8d@oracle.com>
 <393d930c-da04-4c86-0f77-615c511df77b@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <393d930c-da04-4c86-0f77-615c511df77b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6639d7df-63ca-43dd-8c36-08db78b62e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGEY57G9f975G8epFdF6lev5zPwBvO69Zs7oMSwp6vs1YBC/x1NnPEwK4yUxF+9iovpHNIZWsO2v0f0a+hqXeX/shp0a3X6cbqEzjVhQUL5iMD7titdGc7vXEi9nw1QIgcUAjqVNr1rtPIo1cMooAJGcky46e36rhFy9uxvbTLC9oYblbI25XQKh/2uoDvXC4oxVZLMkmK805hniGifvFp7UwF54Y6/krwTyoRmws030FaU7ZefAdLU1zlwFmPJmy5AX78dFIPDbnfc/ronq1p8hpPMt/jJji1ceRwPpCDH8XwxtHbXl3kayWokbuxZMchm8cyZnM42MQHxLg5opB2uEXoS4CTExyFk/COPUBDrlMgA44QCWgO1e99tmner5OQ3OuwYy4LsgNG86rxh3uPpR5BAAaZr8zNY79Q8l3K0rXfBfJJnutQ0z2WuyiFskKSFbBYVlQXbMcP6T0lqrruRypKSY6YzcMvCQCxztsg8GvR+sb1HPhswAtd8wYG2ej3uqpNmphN/ZjkwOJjBEA+vOzhBHxe0YUXFbjMOJYu0I3EQtCFXIuNFBhIw2bdag5Z6xmiAUg5nasVF1b5EW+YfSZO/qf+X5ZJFqhj3Sg138u8bsvqfk2q7jLRKoV9GW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(6512007)(6666004)(66574015)(2906002)(186003)(6486002)(83380400001)(38100700002)(2616005)(6506007)(53546011)(26005)(86362001)(110136005)(41300700001)(31696002)(478600001)(316002)(36756003)(66556008)(4326008)(31686004)(66946007)(66476007)(5660300002)(8676002)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3h4b2U3Rlo2c0VKY2VKcGxmTU5KdnVVcE9mOHY5ZWZLWk5vbDlPTk9KSENB?=
 =?utf-8?B?SE9YL2pMR1EyN1BNdzJZa3NZNDhaalNkR1RnU0xqK1NPNDJ1c2s5TGVLV09R?=
 =?utf-8?B?bWdwMktOSzcrMm1XVGp4eHA5cWFPSUlwd0d6Z05qVS8rQW5QUE02akhVUGNX?=
 =?utf-8?B?UldXUDU4bmg0dStnTm9WM3lnUzJnSXBnaThEc3c0T3AwZkVDVlVIaVdoaU1s?=
 =?utf-8?B?azBsM1FWMTllZTE5b284RGtMQm1NTWMzb3J1VnB6MkdndUNISmVtZzYxdC9U?=
 =?utf-8?B?Sjg3TGV6RmswelJhamx3eXJKUVE2SHJIQmZhL243NHYra2Q5YzZVVHNvN01Q?=
 =?utf-8?B?SmYrQ1diZjNzYklsMGgrRlRtQmRBWTRZNkhXcHcrbkZ2a0NGRFJ1dDlTM1RE?=
 =?utf-8?B?TnBPbkQzL0o4NlpLOGduVHVBZmdROGZJQWFLMjdjeXpuYXo5ZEVLV3BUMzVp?=
 =?utf-8?B?RExiY3cva0t3TGVZRXc0N05DODI1Z1dYNE4waTZVZERSTzRXWi9sRWYramYz?=
 =?utf-8?B?b0FoaVFrNmZCS0QvbXZxbnF2ZUkyY1VleE9lZGRwcThGTzdacFhvb0JBcXd0?=
 =?utf-8?B?QzdkWCtJK0pOM1JESDlWRVAyZE5GaFZJNVRIamZvTDZOZkFYcDNkbU9POUpU?=
 =?utf-8?B?dlNyZDFULzYwWDZrYjByQVpKYVdqREFYbURwUUxOZjdzUXZadkFFQi9teUZB?=
 =?utf-8?B?WkV5TERVYmpYdDRKbDEzVVlFVlEyU3EycDNBdDBJdDRZWUEwaG8vaWFTeEtv?=
 =?utf-8?B?dm5OYm9rK0E5VUFwcXo3N2gwanhjREd6OUJCaGw2TTJ1RkpWVGNhZk1WbGRj?=
 =?utf-8?B?cUE2L0JGbjJTZEdWWU9ldWwwcWJWaHZ4c1hOQmpZenFDbW0vaDNWMlI5Y202?=
 =?utf-8?B?QXJWb0t2eXRzc3VaTnVWUXBaNkZCeFBkZXZXUmNrWlpjd3ZReVNBWVFCKzFH?=
 =?utf-8?B?TmNFaHQvc01lRTBwUCtPV2RkQ3hDeWdrdDFrTnJxaTBKcTFDc1pEa2NoUVJi?=
 =?utf-8?B?Y0dGbkg4bGl0OHVHR09HbEd6cksxdW50aWczRVg2OHJKb2cwQVIwVEMxem9s?=
 =?utf-8?B?REdFWGduZ1pGQkNmOVZLdTlaeUdFZzJid0dLcWIyRHZtVmg2WFEyN0ZpNFBw?=
 =?utf-8?B?M0xUMFUxRzAySW41Wi9PQmtGbGZNbU1FSnZ3U2s3ZGVhUysvUzd3T1ovODJM?=
 =?utf-8?B?a3pUb0tqZWJhdE1uVE5GLzhzVnY1OXh2NW5FT0lrZXBMdTUzOGUvZWwzQ2V2?=
 =?utf-8?B?SS9KTmEvTnJLQXZRRGs4blUzKzFicmE5YU9hOU9YeGUrUFRYRGpWdzRPSGlH?=
 =?utf-8?B?eEllbjlVVkFjQVVoQUM5cG9lK1d3cVlZeG9WZHpMTllINncyNE83eHM0NFRp?=
 =?utf-8?B?VklQaVZCb2tqSy9rd3VRd1dMRzJxRnQ2eGdDNko2Ujh4L1R0alQzUUE0LzFL?=
 =?utf-8?B?MFplU0d3a2pEVEtNbmZNeVVqQ0lQMXRxTVIxWGdidUtITzBuWjNuRGZPTXFN?=
 =?utf-8?B?bjlYaHBhcE1MeG5VRW9SWmJXZVo2UG1mRjNMOUEyQ0tYTXhObVVBVll1VVJr?=
 =?utf-8?B?Y3NHREV3VWtVVDgzTll4RHlOdVlBaUtOMEMvZnJTYldkYjM4OUpqMkIrZUtL?=
 =?utf-8?B?SkpRbmdLeThIaHlWUlJYZlE2cmtod20zdm95NHhRWGhidHVvamR5SFIyY3hE?=
 =?utf-8?B?NFNwMzdLTTlVVEVRWUNmUjAzaEtmS1gxamNFRjk4TkY4aDNCWE1TTXl6RFMx?=
 =?utf-8?B?S2V3Mm9vd1JzSXEwV0dUaFdMVkVKTm5zWDZsbk53eHU1Sk9LYTBnQTZJY3lR?=
 =?utf-8?B?OTlmYTlibVZDQXd4d2o0d1pwWVE2SHNzTW4zeW5yRmViQWsyWnhXV2RIREI2?=
 =?utf-8?B?c1BqNTdrU2kyT1VpQUlnc3RBMnhXeXpUZWdrSnQya3p2b0lrdHZQUndYdFND?=
 =?utf-8?B?T3dVOHVKRmlyZ29JY2tDWXVjUUthLy9mV3BtcktvQmFQeitmcmZMdEhrNG1X?=
 =?utf-8?B?cTI1V0Y1NExhY0V5cWR2VUpSNERzZCtnWmlpRzFjT1MyZThYR3JTTnBTeWpZ?=
 =?utf-8?B?K0lMR0ZlYzVLUkZmVDdBSitQVm94WklpM2ZyQXlseE5MbjlRUkkrNGRpbVNt?=
 =?utf-8?B?UGVpeWsrdlJ3a1BnaWtpTHNRTWJaU0xWRU5zZitERmF6bnBGYnAyY05YK0Ez?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lHBfSDnwMQXhc9rg7V/xZC6jAwYRLwLESCphtizwffygTLcKAyIH+YP/yaN3BIbnFhqWLyRn0eHmhPMfzVxAuUGDOJuxVDDhQIcG52IQyIkqcfi1lT9st+kSeGRPRlqt0GgDUF6pyjm7VxAXSLA0VP25qID7uu+8INgZUqwuMkmiJqkkIRgzXZ8hl8tvDjg8R6dbDIERc74l3zYeEqpvwAxC30g8YPoW4r4TGG6S4cW0bCVPI+5vVE0GeT6PtaUethmfGIUbiUpRLJ8OlIE3W2wkB7uemlq7XsV/nqhaJvPdlfJNxFi0CThj+T31ZBONrOTunJT1od7eE7QibM2ngZFuhs/n/dFLnYwmT84WaMpbU/Xy1WMopobFV5KZTtwI57XWILHP4bgYtYXWaE1j9/zdkokLB7ZXdL17S2Xf8qfL3SyG0Zsti29JSuX2yeH93inpWSOoOZ8MApYOkx3+Msk33ZRQZoAZSMAfLZWN+dBoXY19uWM1b1TxXvQs5pUD/MJ1ZHuSRhdO1imrum+r1YMzYuFfeDaP71ppJpiuz1Xv7knbvL8HKOZ++8aGzG9hUf5d8cO6YxmB1LG6pFaAPQNeW6fSYm5+0eQQhZx9ioUZ6JBJpgHW+Y2kvK5YzKHMMP1XOMt6b7HS3hDTs/h/cNrcPqwrD5S1lxDxYhSdq5x5w/9vPNPMMaGFqmtfnwDV65HQqWBOiyWDAf2THNgQ+kwsBvdwFzX4m99IyjgyKoCHgfxGGYvU1USuvJ4+JzQQVaryBVsMBpQFd+VgAP5jmiqqq1O4g1ZNT9qiczhFbH5Uh93F7BXNBPiBzW+OD6TTJfA9h/+6yZ4SKc0Z9BoSvA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6639d7df-63ca-43dd-8c36-08db78b62e78
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:33:26.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kuWvoa87VZ6X+p/HKkp5MFUJB/4OYsDkHGYRTT2vI4tM5spp5E5QsEZgDaSJYdM0R9IsBSd2u3JINbxvVOJtJNiY7G5251AbTfqkVl9xio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=729
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290141
X-Proofpoint-GUID: uACx8PycGnJdBqEvcZQnHcFXleqjju6i
X-Proofpoint-ORIG-GUID: uACx8PycGnJdBqEvcZQnHcFXleqjju6i
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 29/06/2023 16:13, Cédric Le Goater wrote:
> On 6/29/23 13:24, Joao Martins wrote:
>> On 29/06/2023 09:40, Zhenzhong Duan wrote:
>>> When vfio realize fails, INTx isn't disabled if it has been enabled.
>>> This may confuse host side with unhandled interrupt report.
>>>
>>> Add a new label to be used for vfio_intx_enable() failed case.
>>>
>>> Fixes: a9994687cb9b ("vfio/display: core & wireup")
>>> Fixes: b290659fc3dd ("hw/vfio/display: add ramfb support")
>>> Fixes: c62a0c7ce34e ("vfio/display: add xres + yres properties")
>>
>> Sounds to me the correct Fixes tag is the same as first patch i.e.:
>>
>> Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> Looks good, but see some clarifications below.
>>
>>> ---
>>>   hw/vfio/pci.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index ab6645ba60af..54a8179d1c64 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3167,7 +3167,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>>           kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>>>           ret = vfio_intx_enable(vdev, errp);
>>>           if (ret) {
>>> -            goto out_deregister;
>>> +            goto out_intx_disable;
>>>           }
>>>       }
>>>   @@ -3220,6 +3220,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>>       return;
>>>     out_deregister:
>>> +    vfio_disable_interrupts(vdev);
>>
>> You are calling vfio_disable_interrupts() when what you want is
>> vfio_intx_disable() ? But I guess your thinking was to call
>> vfio_disable_interrupt() which eventually calls vfio_intx_disable() in case INTx
>> was really setup, thus saving the duplicated check. The MSIx/MSI in realize() I
>> don't think they will be enabled at this point. Let me know if I misunderstood.
>>
>>> +out_intx_disable:
>>
>> Maybe 'out_intx_teardown' or 'out_intx_deregister' because you are not really
>> disabling INTx.
> 
> or simply extract from vfio_disable_interrupts() :
>  
>     if (vdev->interrupt == VFIO_INT_INTx) {
>         vfio_intx_disable(vdev);
>     }
> 
> and add the above code before cleaning up the intx routing
> notifier without any new goto labels.
> 
An even better option indeed.

