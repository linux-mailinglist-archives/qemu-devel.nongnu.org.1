Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1DD72663A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:44:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wFQ-00023O-J0; Wed, 07 Jun 2023 12:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6wFO-000238-8L
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:42:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6wFM-00083s-73
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:42:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EkpF2019658; Wed, 7 Jun 2023 16:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kQVnwOxq2Vg1RdbamRnVaC5wknGo+z5Lj44T8lMBr0E=;
 b=Hf2w/4y2Rh7OkKQ6CIE01lrlUgZT/UR7Ve2rCzv4TlUybuTv6OPiT9Xd7TD32Wg8hNi8
 wQwvbaWd+AQG3ub2APM67rz/epLwvniDLORffSfTYADdrbYQZPjP1GrSLpxZWnyoKEmH
 rWgmnOUKajSsXP/DN9wFdIBNHJ6sKaYL3iQs18KOeArUjGqhOjNPzx+xuXulBncM4Dwq
 th7A7rwdQrfRwmVfdTErDZYoCCp5ui4iubjhKDh0kUU5ZHV0ySOcYZd4SLHttNCN5B5T
 FUS5wqBXaSXyVuVvpUVCIkAs2vzAqur2mM8eHb31NdYbQ+Q+8QvAZ0zc58Hyh6phRKWg HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ua74b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 16:42:53 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357GgSuB010458; Wed, 7 Jun 2023 16:42:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6qs8g4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 16:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbZ7R8FrySHd0xdg9jn3mOmaoHyJpEIeXfsMsgi5PRTReOJQ42RkDFkVpZYYkswztsR2GLQjtpYGMxWse1+4HPtxwoP1CKYVS+RMXRnvi7PM1cJ+aGnPlo40Uw7Dk+9r3K0N2TwwEfNjl/DO6fAw/U2yWyx4M6ELQdMJ/QpnA6PuRfbYSwZ9gagdz1//QRD7Gq2+n6fxYtmy1RZxSv+P1SgZsHyzlI/oCFY7bg/i7jNo7zY1tAuycx3KObC4t7m1FiPndBRTiy6apK+1zHY6govEKsDwAAJSaFlJ1PSYZxdX+rsbfywjnF4EEo16BFeJMvTXV84R12i4I5cjBAZzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQVnwOxq2Vg1RdbamRnVaC5wknGo+z5Lj44T8lMBr0E=;
 b=K+Kbe+RmpYLP/AXQImVQfO4lRMXAmFEIadfhcYfIPmO+rik0StTz1YgT97SBwYw15V3Qfxu5Qh3Cr+MEpxS0VbnS4qMUSyDLuJ6BwdUYZ6EWu5c2nN+UZ+y4Ujx9B56ukkoHD3SKeKJGgN6NWu4R7CZ0bemAzXfAI3mUlEAvFiCl9RkLvAf75tKkUE4zxDz+9Qb4TR5kljOIR3Ql1wXgwPcdKar3kLGUrF1vxXDi4qpUYSbInWWrYj0Dw+XlsKem0myZYHiydkvkkP+MSgQxbLua8QodIy6FLAvyiY/brY4YGjZb+kc07hiKGdmgR6aY7Hsi7cqpv0C+ZmYuBHVaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQVnwOxq2Vg1RdbamRnVaC5wknGo+z5Lj44T8lMBr0E=;
 b=XyYtmtnzwFtRD8ziEwd009vdFMjtSyitkh1Hv4sZAtqIaFoXgwgchk3h2KAT1uuol3RqEAgD1hFusxJfDsJ78Si0x1OFn+sC9M+A/UdyslHu4VDTGGFxwKaHSbtPsFCJR02KjdbkQrx3RqVWRsEurqOsi7SVhk6NEx2u01xdmxo=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by BN0PR10MB5112.namprd10.prod.outlook.com (2603:10b6:408:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 16:42:48 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 16:42:48 +0000
Message-ID: <90317bae-293e-8ea1-3268-69b6a5298668@oracle.com>
Date: Wed, 7 Jun 2023 12:42:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] oslib: qemu_clear_cloexec
Content-Language: en-US
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <1675796588-235506-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1675796588-235506-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0410.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::19) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|BN0PR10MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc96841-f51b-4d5b-270a-08db67763a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdDNjDPnb7UOj8WNddvL1DooWpfx+hXeH83BeHqs1SYxSp99tiV+25AaR6XujoP9dHIq+4Q8P0c+dWeTmcBgASq3fDNjcEYtk9NhTFNDk4M/CF8+MzTXdfQk6LZ6j+t3NJeRjhagJl8Lc5zgUCIpBYiTQrpxmoo9BZ/+CjzpTvmRuub2vA5cF57cchejh5MiXCiP4ztq+dgqaguexUntR8o6cx/zEfmdsCMMbdza89ix07MqGtszmsjX4yjnYLPbZDjNcwLjoI8Ktuh10RnA51JUsr8dhpFfGZbTjXSZrhkE02mV1gLFOopYSuJnCNEiGwEi6MH3kAYwQFJ3VnIu7USjBwC6uoiMD9TM1t5cN0UdbDapsQCdfy4FFQaomW62Loecea7shA2Cz4ltpCN1aQlgfu94Jnuj1CcUYRccmIgR5MShku87su7hYGIhSWqPGFLYxJPY5Uv8qQ8RI7qqr73yrXuxTk7gDXh0L+Nuh6TWaXSdHWDoRmghC3wcxPiUXXUrNhW+CYvEGCypFYsawJ13Mv9HmvzrNNDXT9UjxPXEWqQZmlxdHuUFvYNIzFfThg9K7aquthu/N7YHj0tkz5l8kk7li7jxNDJWRMKAT+nlqKb1DxGGR1tZ18wmAHP3hpmMCpaUWZfrctG+inOrag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(53546011)(26005)(6512007)(6506007)(2616005)(38100700002)(83380400001)(31686004)(6666004)(41300700001)(36916002)(6486002)(186003)(478600001)(54906003)(4326008)(6916009)(66946007)(5660300002)(316002)(66556008)(8676002)(44832011)(66476007)(8936002)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NpdlRaQ0JTWER3N2xWR1lIaHhYNjlqUDJpM1htNk9STkU5UW5jMTU4TDlj?=
 =?utf-8?B?enYrS1JXNU1LeHNUS0VKWTVLQmN0NW0wSVNjeTRDUExRR1hyMlpUems2Rkw2?=
 =?utf-8?B?M1FJM2JubUVkcVY3dkNQY2VHT1FDL2FoUmQzYi8wdzROL3NCNjIyL0pvQ2k0?=
 =?utf-8?B?WjIvQ0tkU0dCekh3d0JkTGFtYWY2NklnYkdzNDdaTVhBUE00LzVYQ2RFSE4z?=
 =?utf-8?B?TjNsekdCelVlTTBZTkk5QjludExxZHJCQm1mRDRBQXFaVDNyZituUlVkT1Jn?=
 =?utf-8?B?YlJyUEJNdHJONFV4Wkg3Y2hXcVZSbnJxQk4vdVZ0RTVtSGRxNXdLZS9henZw?=
 =?utf-8?B?djh3cmVUa1pPYkRpa0dPVk1FMmV4Q0hjb0pYd1pnREpkQXNtUC84aDdqM2ZD?=
 =?utf-8?B?aWFJNy9FMGpvOUh3Uml3Y1NaZ0VzVkJYY1cyTHBUWTYzNkhvVEtYL1FySHFt?=
 =?utf-8?B?KzFGWnhYbmhNNWZxKzlKRUhWQ0tPV2YvRGxGc3QwdEhETi9lYzl2K0U2cHRs?=
 =?utf-8?B?anprMS9jalNBZU8yZG5ubGowbzl4cmk4aHh4cUt2WmhGUk5Va045Si9pK045?=
 =?utf-8?B?NGk3ejFRWlhMNjJ5VUNnNjdGNTJ5YVJqWnIydE1JZHdjdGg0cmRJYXpSOGJr?=
 =?utf-8?B?VVh1ZXBYNFo1MGZDd2szSlRuY0tENENUZzlDNHVTMGNneE1LVis1bFRudFhx?=
 =?utf-8?B?ZmYyaEhnMjhJekhVdUlmMGJ1Z3FGMy9obGc4OG81aUJIbzNXbUllcjFaL291?=
 =?utf-8?B?Q0swelZ2WGNkWHNuREozVXYweHd2L3hOOWlEa2crQ1dBUXhzclBLcDlydTFr?=
 =?utf-8?B?bzZmVzk0a2JvaUE0c3EzQkZHZmtKLzR3bDdrUmtwZDlCd1dIcE9UcHZFenV4?=
 =?utf-8?B?Q3JjM3RONEQ1U0E5RG91Wnp1ZjduWlRRdTFkc2Z5ejV5VmZLRXhsc2hmVHVt?=
 =?utf-8?B?eTdGWEV3S1VDVE9IeUhTTzRteE11UkVTM3BTVXNZY1NUblhoaEZiUmkyNUJw?=
 =?utf-8?B?RlZaV2FRbGUrekhucDUydjAxZUEwaFJERXg0ODA5RGYyaThnTStQam1sYTVr?=
 =?utf-8?B?Q1lkalVPam4wYmJVUENSRGQreGNmVjNZM2RPS2FLWk05cnBzT2txVTd4NHVR?=
 =?utf-8?B?MzR4WHgzUWpCUFRIY3RmVmY5cjRIVUxCTTl1RFBsSmpiVGUvaVpLK3lQTThH?=
 =?utf-8?B?WWNyczQ2NHZadmp5R1dGMlZRMnB0ZHdYUDNhUllBY1RWcTZRbWtqYzVJb1Ux?=
 =?utf-8?B?YnplcFRzSGpKeDhIb2VZVUdpcEFQQUUrRDFrNExWM0dwSmpTNzk3VEVKbnd5?=
 =?utf-8?B?d0ZpeUVDVi9jcU94YWVzT2NYZGZTc3EwWEtDTSsvRnJIWWFRN2xXUjkwSm81?=
 =?utf-8?B?NUlhR3F1Q21GbE9YYWxKdEhyRzBHcERUN1pmRkd6VndVMG1VcEZ0RFU3VTNG?=
 =?utf-8?B?RERubWVLMVdRMEZSdmJqQWM4RHpUVG4rcytSL3Vpd0Z2S1BGaEJTYlE2Skp0?=
 =?utf-8?B?cTNOcmFIR0pzK2Zyc1lid281TzgwWEN0OHMwdlN1R2EvbzVjNjQyMm4zQmFR?=
 =?utf-8?B?bWxvbTllMGhvak0vNHVhNUxBT3gwcHhMS2FJVVAzSXFRZ3dTRW4rbnNwSFJU?=
 =?utf-8?B?dFhvNENSNENHeWhVcjY2d0pUbG5UTGZIRW04S1h1VGJJQ0JWdXBLQU1McWtB?=
 =?utf-8?B?SnViN1d2NmtHd1kva0t1dkR6K05KYTAvczBuRy9ycnVJTWZqOHFsZ1hmeVF1?=
 =?utf-8?B?dm9GaTByWTdyM3VhbHBBRmlJVm5HaCsrU2hQTnhhNUV0d0FrQS9SajlFQ3py?=
 =?utf-8?B?dkt0dWtrTjZWdUJ5MityK3ViZ0ZCeUVUVkFSaVdVcDFOZTYxZzludEdSK3F2?=
 =?utf-8?B?N3JXSWFmczR3L1F4M0xRM2FWaDduOXJSQVI3QnZtbG9zbEtpTEpxWDVuZ0tw?=
 =?utf-8?B?dGN5YkVzMy8vcHgvSnY4R2oxVlFuUkRKK1I5V3V6a3lacFk5cENpZEFabStQ?=
 =?utf-8?B?QUJMMkRWSVd0MDhLRnVpalBvLzFIZ1FNWVJGOXpDQVFLc3NXUVJkT0MwRFZR?=
 =?utf-8?B?N28rbk5MbmZDYUJ6ZmZmcmxaSTZDVHZGSHcyU1pPeHJBa1RQMllKaUd4a3pS?=
 =?utf-8?B?RkxJdmpHVEd6b0Z1OXpJN3YyU080SHlKOEpET3RTcVZxb0lrdEVwaFNrNFZX?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c51/bqr08bKY4R1zqYu/mhu8kU6RrQM9/Pxcf0Iq1eGqIDEu/d7039YGl6EqRm9V4OLtmkPkjH9aLjow7xQQfNe77wtpJkZkIIeCL+yPlPp/v4rAnelxKO38XkZLvjUU0oWoA3j5vBIPMPr6v/7fqCq2sFp2pgL/7TsjmTvo9s7FvInQP83fp2z7TeH3IMOXQ4RwjHBt4jKOQfd3S97jnCDitEWX0oALWJjc0MU9D5pQfZz0JqzpM3wOPCmoaIBLR5ewRRB2Y8JlhX/sdNlzDZwkIxltlsfXiX9L3TmJJZeSAS0NhmngZE/+chnD+9ujyYREKHxQN/22c0ecW1L5LiOxERUzcG5R2oNLdoku3Wz012uv/ZNOXv3Gpdks9/JQJqG6mF97/+T82qDwnrS0MJrtgVuewnk9ab81xJuyEDGjInhMdfFCQFoKpbXNN6aG890/2+P4vT6cDzA5v/INWL5RWtZ3k1/17/jqDOq/S7ktxueFuywtLE+RO1OupyINFiQu31+7ePP4hfv98R7kX/f3BXho3KUahz2yhsCTbHiepyG41I47e9QjfVdI98cXI5KIqkeOvDcBlVEFwGohxsojHhdgp2fS4Srw0DmtJLjJtyYDwllIaPxcroiHCVIdMhgu7i7FpMxT2W38J5G0hvjMZs2Fawl/w78aCH60sLfdE3+bhxOztI2ef2GXhkMPBEca6AkahZz2EpMp5Kur2pMJzTUxNGV4hf+PnXYWb/s5lVEc0r+QIxG5oApZaotw0BXdT2kU3H/g7Aj+DWPIFw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc96841-f51b-4d5b-270a-08db67763a02
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:42:48.3160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja0lvpYTtl9Rz/y89ylN8uPq2DjOgs4J4l3jmg+tBSTLypXQPw+CRrfcV9HqdeRGjFiNozMzYGqJeiWtS6I+/Pb7S/PC56qL6HxnI3F79D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070142
X-Proofpoint-GUID: t9TRd4nfJnbhQ6G-TQWP1fj5ILp-9KVY
X-Proofpoint-ORIG-GUID: t9TRd4nfJnbhQ6G-TQWP1fj5ILp-9KVY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Paolo,
  Can I get an RB from you on this patch, since you maintain posix?
This is needed for live update, to preserve vfio device descriptors and
character device descriptors across the exec of the new qemu binary.
If yes, I will rebase to the tip and repost a V3.

- Steve

On 2/7/2023 2:03 PM, Steve Sistare wrote:
> Define qemu_clear_cloexec, analogous to qemu_set_cloexec.  This will be
> used to preserve selected descriptors during cpr.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/osdep.h | 9 +++++++++
>  util/oslib-posix.c   | 9 +++++++++
>  util/oslib-win32.c   | 4 ++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 88c9fac..9c8c536 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -618,6 +618,15 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>  
>  void qemu_set_cloexec(int fd);
>  
> +/*
> + * Clear FD_CLOEXEC for a descriptor.
> + *
> + * The caller must guarantee that no other fork+exec's occur before the
> + * exec that is intended to inherit this descriptor, eg by suspending CPUs
> + * and blocking monitor commands.
> + */
> +void qemu_clear_cloexec(int fd);
> +
>  /* Return a dynamically allocated directory path that is appropriate for storing
>   * local state.
>   *
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 59a891b..a8cc3d0 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -273,6 +273,15 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
>      return ret;
>  }
>  
> +void qemu_clear_cloexec(int fd)
> +{
> +    int f;
> +    f = fcntl(fd, F_GETFD);
> +    assert(f != -1);
> +    f = fcntl(fd, F_SETFD, f & ~FD_CLOEXEC);
> +    assert(f != -1);
> +}
> +
>  char *
>  qemu_get_local_state_dir(void)
>  {
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 07ade41..756bee3 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -222,6 +222,10 @@ void qemu_set_cloexec(int fd)
>  {
>  }
>  
> +void qemu_clear_cloexec(int fd)
> +{
> +}
> +
>  int qemu_get_thread_id(void)
>  {
>      return GetCurrentThreadId();

