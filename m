Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B91830858
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:45:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7AD-0000LZ-SV; Wed, 17 Jan 2024 09:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rQ7AB-0000LH-MT
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:45:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rQ7A8-0000Cl-G6
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:45:07 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HDEIhV020389; Wed, 17 Jan 2024 14:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TVVxXFgAXPYbKNVvFV3jJMLYOO2Uw1WDhdvQkUkVd+c=;
 b=Ay65VrVoKNjuD70B/qcM5vqAoeDXepxZTafTvptQBg8FbAHsp/hpo1fqjKreExp/FfPx
 cD2xfvNeoRJA3QnvkHElx7eMoV55/senZn6/XqWrlBLDedq64OyheULVnK6VtY3NaWcn
 Q7Bt313sOkxKCMwxkQjaFQPrbpmKT9xHRR2uM1tvhf1OTWVmHMkMgu3q8S9yG+1NeMcd
 UnlDaLoO8Dyqzt/ROSnqwN5fDW4v0lEKlHWLsc2yx2wOtHkn0nODXsszVRqvQp+mdEud
 ebVcdaj9ea+1aiR3wtaPNco0BNfjfp+ZrAi9YHNXbyirXZScCie3M2FTGvKyqmSu3kZP Lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqcdypm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 14:44:59 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40HE3dd9023237; Wed, 17 Jan 2024 14:44:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgyad5k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 14:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGptygwIsF81eJnZaVoMoZjQ2VQzaxIrOuJ6vs8z9tSAYa26xU8DGvds/ubzTI145WbeHJYmATP7WiEr6u3B0gc1/K1zYKl0/rzWcMGP6IJpyy8C3+q39yrI9OWp82RpywMjLQVFZn44a9kmm5daSGFAVZwyc0nXQMj4MzuqBX7RVNE4pWaKlQoZGhfqaL+5fJ5nE/0YfW54zHWBPvsbFaxnXyscgvTEtG1B6n2Es9ke3a6GVfr7UsCswQDjqpK2QCZk0on5n5LNrNSeSKgLQZv36Meskxe+4WzVeHyXOUophm5So+pVFD2WKbpF7PaDu9iHxJJyGQtJ9GjNOCqRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVVxXFgAXPYbKNVvFV3jJMLYOO2Uw1WDhdvQkUkVd+c=;
 b=mbkE0iSEAj1ba33l2QiYMY2+4bSmPr+ImpHlPu7KmPB0XGCzG0Oay5hh8jdyC74unhpMxuCbPkGzeKfDypBfjv8DKDZJkCw0yftV+hl8tuAUSVpTQPvuRxXUwjMHw0dvbx3VQ5ICtx+cG1Fh1Hmx3dpHRV+GdlXlLCQZ6GX9RyGFtnTE0mOwuRVlML0Q4d5rxVMcAaKLwrFIQ1CtcN1nwdJEc/LtYXBwSv4TjMyggf6cIQ30H4oUq3vVFr9Z+Z+Pg5nqEAR4DmfBDmyeHTHUcPhKtNDnBxOTaOh3+Zw+jn05qMyMP+5zrBRcrJMRPQc80EtMf5O+4gjr2LFwALBPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVVxXFgAXPYbKNVvFV3jJMLYOO2Uw1WDhdvQkUkVd+c=;
 b=O1WQ1HbMnBk0J95QbuA8Zblx5JFAXi1aHupJ9j+f2jrTzRRIbqXRdLDN5MPLx9oYgJCeKJ4IFbRIB1ovWB7H4+Y0zRo5VTYRdc/irXHLTDuIwrEobPKiYkKOg2ea4Vfg8JFEjnPkuBmLkocRgFcd85KiqEojHWe30iU7zZMMojY=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 17 Jan
 2024 14:44:56 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535%7]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 14:44:56 +0000
Message-ID: <931d619a-d5f7-41a1-bb15-b6c10b94af90@oracle.com>
Date: Wed, 17 Jan 2024 08:44:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] oslib-posix: refactor memory prealloc threads
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20240108151041.529716-1-mark.kanda@oracle.com>
 <20240108151041.529716-2-mark.kanda@oracle.com>
 <2be78fc2-f76a-44de-8db7-fbc1bbdc0d2b@redhat.com>
 <1854ecdd-88d8-462d-aa0f-990c2bbe57ff@oracle.com>
 <02801117-4408-4069-b0ba-b54f4d050fc4@redhat.com>
 <ZZ1VDF0U7PkOwgWh@redhat.com>
 <fc3a6a13-6a2d-44c4-9cf0-a91dc2cf1b97@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <fc3a6a13-6a2d-44c4-9cf0-a91dc2cf1b97@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::11) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: b7eb7979-8f07-446a-30f1-08dc176adf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfIMMrLeAInOfMb/jigE4PuD1xAikUfseiaIMYeYbg8pQTPih6lQuixDx/qhcCAuwB3uLtDGqNdV7AhLgqdpNcprecv2BLodupzC2D5jKENTyMRTrpnsC1Fc3VrLImC1HWBGuNVOtPCOBfYr2PFo0W5YzIKxDE3uqrVj0YylerseQMrR71Qlb5bQ26mDKkwfyefVj4NP9S3/3rJ8BgjjiQ+tSp81C+xhuucXd26UqeTpj5SNau1mq+DD/Lj98E45NqTUIu/rAOFw+igmkZ5o/t5T3A/XbSAEryG1QJOtJd+UMTeR7NLPl4v30ebVFP+n/+tpaitz9UQQf61b4LIlVP5jwj69Y+t/9L8/++n9HpyyCPsDnKIMnHxhVHeK2AGo2yn9+hOT9fP04ra2tsqlsPUOc9f+GH5cHm/93AchY5Ncf32zA6tAJJ/9T/v7XFHN0GyYCaz8nR29qL0zHfTPaRc+j0R4eDE7UB2yCA1h6acD3+ml8Of6SNc7s60eACYQvry1YdmUgJIwUSM1INaxdL33Us8y3v2ie8MC47vmMg+3r4nOknKy29fSWp3RH9mt/ZHVTImB/kLiBsK4SxagkP8kDgVo6jw5He5Y+8rIZYXUfUFQEV6Hk/Z3hgvJpCZaTvu/YJyinppJVGEi9BYU1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(66899024)(36756003)(26005)(31686004)(86362001)(31696002)(6512007)(2616005)(6506007)(66476007)(6486002)(478600001)(66946007)(4326008)(8676002)(83380400001)(53546011)(110136005)(316002)(66556008)(8936002)(30864003)(41300700001)(5660300002)(2906002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BDMkh6YXJVNFhWdm5jNWg4VzhXWW0zOXAyaTZURFNXMTE3a0w1Qk9UenZG?=
 =?utf-8?B?T1Z4VG5DY2l6RzZ2dEE1WEE4bmlJQmt3d250QmVVVTRBSVFOSVdsd2tGZ2ha?=
 =?utf-8?B?QVdsQlpxdW1mSjVsWEhsdDFTR1hnS1l3VXBHTzZuUno4WEY4RDRtcndYN3lG?=
 =?utf-8?B?d21iMEg2UUtiWlZiNVpmMmorTXRZVzJnSDE1bUJaY1lZdkp0M0VwQlBzSWdN?=
 =?utf-8?B?eXNtZE84Q1Vxbk1Ha2VyNXg3enBFZzFudmxaWFVKTU5xdHBWSXJrUW1tQitq?=
 =?utf-8?B?cm1nalVtYklMdE51U1k2c1diR3g5aHdoR08rNFBFSlB5VisyY2JJcDFZQXdv?=
 =?utf-8?B?UXI0OWxTdVNnbjA1a1EycVdjQndxVVYwQkxxY3hlTEZ5ZVRZb2JRN2ZqQnht?=
 =?utf-8?B?RXpKTHJtUmRqbS9qeHRtYU5ZeXFrVHNGTGgwS2tvSm0wczVsd1p0SzZvUUk1?=
 =?utf-8?B?azBacDY2ZGdSVHl3TmZqb1R1ZERZZHlWVnd0UkVwY0Z4YlNwQXNya0N1TDEw?=
 =?utf-8?B?b3cwUHd0ZHRiOWVLRGZxMEZyUWtWMnZmdExhWFpoeUQySGRJWlpVdlZFb3U4?=
 =?utf-8?B?bUNWd2VXYzliMDVkb0FMMGIwcVMxRjN5K1lXMm55aUxRWTBwVzdEUU94SzEw?=
 =?utf-8?B?amtTakVDbjVXQmtBenpRK3hyWEpEWlFsOXkrSWszNGJSYUp4bHpkTkhtYTAw?=
 =?utf-8?B?eTNoUlJXak5VUUxncy96WjJRQys1VzFSMWNQZUx6R3daOXFsZlRDMGY3b25S?=
 =?utf-8?B?U2UzT0IzWVpBUEUwZUNiV1JmbzF3bzdUVjRpM2pVTnZQTHQ0dURoclB2M0U3?=
 =?utf-8?B?RmtXd2VSWUJVeHZhcEJ1NlczMVBvZ3ZyZzlDVHl5YWxZelJac3RCMVNaMGhO?=
 =?utf-8?B?MU5GTjkvV3prcmJDWDl0cDg5SXRnNis4TE54QnF2b2toYXBKeW01N2U5WTdE?=
 =?utf-8?B?eWd6alc0NE8wVkY2YWpPaEovWUtUVW5raVZmMFVHSWpKUjY4K3VKbXFmRFZq?=
 =?utf-8?B?RDc5YXQvNERMRC9aNDRnZzZUVklrYXdOK1Z6T01HaXFkUjhDOXRxUkNuZk5t?=
 =?utf-8?B?Nm1sZVZENHZkcVR5bGRaSkRBSnFtcGE3Sm1KYjdzWS9WcTZpVnMxVXlFR285?=
 =?utf-8?B?U2RtY3k4TnJCbHpxdGpPWHgyR0lhWHlYVTVXNmtOOFZ0USt0RlZiWTBjZVdQ?=
 =?utf-8?B?KzN5dGhMd2JZTnJMY1A3WHJNNDIyOFA0eEN0U3RhN2xTU0o2SFN0SGt1WUxB?=
 =?utf-8?B?Z2RyT2ZCTGNkSkNJY3krWjlOOUUyRkY5Mm1FQ2lVWnFLbnovTW9DczdiajBy?=
 =?utf-8?B?bFprOUEwalRvRzJYc3ZxRjAyYlI1VEZ0c0doYTZqVDd3WnRLNVZiWVlXeXpV?=
 =?utf-8?B?L1FIbk92Mld0TXhsRVVteGtQa2xWTVNobjJIWnB3dXdKL0JSTGdLR2tIbjZz?=
 =?utf-8?B?WjdTWEFHTWlBRXNKY1RWQWpwUGFKZUFod21mZ0sxTm8wRkFXZXVYUjlqWlh0?=
 =?utf-8?B?MVZHcGNsVkMzQmo1TERLeVlyVURhU3EzNlNtRlZxVkJpVTJDSDNrUEdZdWJK?=
 =?utf-8?B?eGdhTWg3MTFjNE9jeWxtT3pNaWwvcnVLMWVVRjdmaFpiTkF2UjFzZks2U0x1?=
 =?utf-8?B?RXNYZURJQ3BxZm1sNzNML1g5TUxQdzNvQ21ZWTZ5Ry9LZHh3REtkZDlrSzZ0?=
 =?utf-8?B?ODl3UnVsVUd5YzRrTWttNFVVendhZDNrd1N0ZDB5OTJzTWNjU0lkZ3pLb3lU?=
 =?utf-8?B?d3QrRjduSHhUcTQzcVA0WURyVjg5T2ZFNE1EYk5CNjdncnZaMkIxdVRTdkV2?=
 =?utf-8?B?V0s5RjczN1I4MGtRS05hKy9VaDNic0lEOTVmSjQ2cDZXd0Z0UFpkR1J5bzhQ?=
 =?utf-8?B?NEZkWGZXcHJLaUZHcWc4YmQ3TGFnWS9TSzJZY1JHaUJScElqMVZ2K0ltUWNF?=
 =?utf-8?B?Ynhva2hKeVB0eEMrUml3ZHVTNlRmNHJLUjRTd3M0YjBnZVhHNDhiQ3BsSHNq?=
 =?utf-8?B?UGc1aC9ydHVtOTlPTGVycFVlQVZLNVY3RlZsRm40dFB2Zm1pSkJyTnphWjhN?=
 =?utf-8?B?Q1h6eS9hbE5sRjRkWkV3ZGlrSTZhTW5Oa2U0SUdrYmlJQU1xVVpJVHEvakMw?=
 =?utf-8?Q?279J5vnrsQao76dgUns922LLP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BQOmexiKQqP+EOLdB/kxlsJUVPjGdIYjviAvMZnNztwCOUtECFiozHKyc+scyytTjNo5+4EUMatp6fQ9by7cLsO1rq3UdqhnEG1GStINK3ilc2dMr40M9Qb5DwInrMqigHYk2PgfCFNZbNM3TGr470BEEMkF/gM6t5Fx+FNo4eV1PSVtZDfmrhvlCLlIKltH6waf5NIKcQoM0ofFPi0Ozy570lLqC+hUZBasDxawhH2qGaZLey28QuIOMsa4IZfxSBguTnZrvAw8IAnCURKI+sudEHD1U3rbl+OQ75ZXOPxwMOo8mW9Exa2dl14uzsfquRQf8VFXImhh+C2oPmpf9vh4aO9LNnuIM/POm8bKWOHiIxRYhf6m4uK3ieXh1DQkAF9K95/sNZFonzwYD9wcmwpR62vuHWbdIGXz6op6u4b6sQ1HG/CCAdDWRt8clrp1LMq8dU71d+LbWNLsuvFCueNYvQYcbBzno3Lcot89qfU+RYitVyLGPeBmNP46/ITrspZDc8sGwER/EhgjkRYbsZ/kYoKe0ZIWyocopdlVyGuHNpEN4WKvO7LHb0+uzHny28QHgbSs6YDSAu1PU0Pd7WOt9BEDj+55fecpbRPRg30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eb7979-8f07-446a-30f1-08dc176adf50
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 14:44:56.1572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgzgWHgZV/szbDNope9KE48sw9uGgrlJjg1fWqQNZraX0ardZKqvB2BnYvFEeLc59gj39a8zyD7UMO5tUcxuTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170106
X-Proofpoint-GUID: cCu-8rnWcqNcVTfz7p6gvPpX4EjyYoe3
X-Proofpoint-ORIG-GUID: cCu-8rnWcqNcVTfz7p6gvPpX4EjyYoe3
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 1/9/24 8:25 AM, David Hildenbrand wrote:
> On 09.01.24 15:15, Daniel P. Berrangé wrote:
>> On Tue, Jan 09, 2024 at 03:02:00PM +0100, David Hildenbrand wrote:
>>> On 08.01.24 19:40, Mark Kanda wrote:
>>>> On 1/8/24 9:40 AM, David Hildenbrand wrote:
>>>>> On 08.01.24 16:10, Mark Kanda wrote:
>>>>>> Refactor the memory prealloc threads support:
>>>>>> - Make memset context a global qlist
>>>>>> - Move the memset thread join/cleanup code to a separate routine
>>>>>>
>>>>>> This is functionally equivalent and facilitates multiple memset 
>>>>>> contexts
>>>>>> (used in a subsequent patch).
>>>>>>
>>>>>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>>>>>> ---
>>>>>>     util/oslib-posix.c | 104 
>>>>>> +++++++++++++++++++++++++++++----------------
>>>>>>     1 file changed, 68 insertions(+), 36 deletions(-)
>>>>>>
>>>>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>>>>> index e86fd64e09..293297ac6c 100644
>>>>>> --- a/util/oslib-posix.c
>>>>>> +++ b/util/oslib-posix.c
>>>>>> @@ -63,11 +63,15 @@
>>>>>>       struct MemsetThread;
>>>>>>     +static QLIST_HEAD(, MemsetContext) memset_contexts =
>>>>>> +    QLIST_HEAD_INITIALIZER(memset_contexts);
>>>>>> +
>>>>>>     typedef struct MemsetContext {
>>>>>>         bool all_threads_created;
>>>>>>         bool any_thread_failed;
>>>>>>         struct MemsetThread *threads;
>>>>>>         int num_threads;
>>>>>> +    QLIST_ENTRY(MemsetContext) next;
>>>>>>     } MemsetContext;
>>>>>>       struct MemsetThread {
>>>>>> @@ -81,7 +85,7 @@ struct MemsetThread {
>>>>>>     typedef struct MemsetThread MemsetThread;
>>>>>>       /* used by sigbus_handler() */
>>>>>> -static MemsetContext *sigbus_memset_context;
>>>>>> +static bool sigbus_memset_context;
>>>>>>     struct sigaction sigbus_oldact;
>>>>>>     static QemuMutex sigbus_mutex;
>>>>>>     @@ -295,13 +299,16 @@ static void sigbus_handler(int signal)
>>>>>>     #endif /* CONFIG_LINUX */
>>>>>>     {
>>>>>>         int i;
>>>>>> +    MemsetContext *context;
>>>>>>           if (sigbus_memset_context) {
>>>>>> -        for (i = 0; i < sigbus_memset_context->num_threads; i++) {
>>>>>> -            MemsetThread *thread = 
>>>>>> &sigbus_memset_context->threads[i];
>>>>>> +        QLIST_FOREACH(context, &memset_contexts, next) {
>>>>>> +            for (i = 0; i < context->num_threads; i++) {
>>>>>> +                MemsetThread *thread = &context->threads[i];
>>>>>>     -            if (qemu_thread_is_self(&thread->pgthread)) {
>>>>>> -                siglongjmp(thread->env, 1);
>>>>>> +                if (qemu_thread_is_self(&thread->pgthread)) {
>>>>>> +                    siglongjmp(thread->env, 1);
>>>>>> +                }
>>>>>>                 }
>>>>>>             }
>>>>>>         }
>>>>>> @@ -417,14 +424,15 @@ static int touch_all_pages(char *area, size_t
>>>>>> hpagesize, size_t numpages,
>>>>>>                                bool use_madv_populate_write)
>>>>>>     {
>>>>>>         static gsize initialized = 0;
>>>>>> -    MemsetContext context = {
>>>>>> -        .num_threads = get_memset_num_threads(hpagesize, numpages,
>>>>>> max_threads),
>>>>>> -    };
>>>>>> +    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
>>>>>>         size_t numpages_per_thread, leftover;
>>>>>>         void *(*touch_fn)(void *);
>>>>>> -    int ret = 0, i = 0;
>>>>>> +    int i = 0;
>>>>>>         char *addr = area;
>>>>>>     +    context->num_threads =
>>>>>> +        get_memset_num_threads(hpagesize, numpages, max_threads);
>>>>>> +
>>>>>>         if (g_once_init_enter(&initialized)) {
>>>>>>             qemu_mutex_init(&page_mutex);
>>>>>>             qemu_cond_init(&page_cond);
>>>>>> @@ -433,7 +441,7 @@ static int touch_all_pages(char *area, size_t
>>>>>> hpagesize, size_t numpages,
>>>>>>           if (use_madv_populate_write) {
>>>>>>             /* Avoid creating a single thread for 
>>>>>> MADV_POPULATE_WRITE */
>>>>>> -        if (context.num_threads == 1) {
>>>>>> +        if (context->num_threads == 1) {
>>>>>>                 if (qemu_madvise(area, hpagesize * numpages,
>>>>>> QEMU_MADV_POPULATE_WRITE)) {
>>>>>>                     return -errno;
>>>>>> @@ -445,49 +453,74 @@ static int touch_all_pages(char *area, size_t
>>>>>> hpagesize, size_t numpages,
>>>>>>             touch_fn = do_touch_pages;
>>>>>>         }
>>>>>>     -    context.threads = g_new0(MemsetThread, 
>>>>>> context.num_threads);
>>>>>> -    numpages_per_thread = numpages / context.num_threads;
>>>>>> -    leftover = numpages % context.num_threads;
>>>>>> -    for (i = 0; i < context.num_threads; i++) {
>>>>>> -        context.threads[i].addr = addr;
>>>>>> -        context.threads[i].numpages = numpages_per_thread + (i <
>>>>>> leftover);
>>>>>> -        context.threads[i].hpagesize = hpagesize;
>>>>>> -        context.threads[i].context = &context;
>>>>>> +    context->threads = g_new0(MemsetThread, context->num_threads);
>>>>>> +    numpages_per_thread = numpages / context->num_threads;
>>>>>> +    leftover = numpages % context->num_threads;
>>>>>> +    for (i = 0; i < context->num_threads; i++) {
>>>>>> +        context->threads[i].addr = addr;
>>>>>> +        context->threads[i].numpages = numpages_per_thread + (i <
>>>>>> leftover);
>>>>>> +        context->threads[i].hpagesize = hpagesize;
>>>>>> +        context->threads[i].context = context;
>>>>>>             if (tc) {
>>>>>> -            thread_context_create_thread(tc,
>>>>>> &context.threads[i].pgthread,
>>>>>> +            thread_context_create_thread(tc,
>>>>>> &context->threads[i].pgthread,
>>>>>> "touch_pages",
>>>>>> -                                         touch_fn, 
>>>>>> &context.threads[i],
>>>>>> +                                         touch_fn,
>>>>>> &context->threads[i],
>>>>>> QEMU_THREAD_JOINABLE);
>>>>>>             } else {
>>>>>> - qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
>>>>>> -                               touch_fn, &context.threads[i],
>>>>>> + qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
>>>>>> +                               touch_fn, &context->threads[i],
>>>>>> QEMU_THREAD_JOINABLE);
>>>>>>             }
>>>>>> -        addr += context.threads[i].numpages * hpagesize;
>>>>>> +        addr += context->threads[i].numpages * hpagesize;
>>>>>>         }
>>>>>>     +    QLIST_INSERT_HEAD(&memset_contexts, context, next);
>>>>>> +
>>>>>>         if (!use_madv_populate_write) {
>>>>>> -        sigbus_memset_context = &context;
>>>>>> +        sigbus_memset_context = true;
>>>>>
>>>> Thanks David,
>>>>
>>>>> Could we just use the sigbus handling alone and support parallel init
>>>>> only when using MADV_POPULATE_WRITE where we don't have to mess with
>>>>> signal handlers?
>>>>>
>>>>
>>>> Ideally, we're hoping to support this with earlier kernels which don't
>>>> support MADV_POPULATE _WRITE. But, I will check to see if we really 
>>>> need it.
>>>
>>> That's around since Linux 5.14, so please try simplifying.
>>>
>>>>
>>>>> Further, how do you changes interact with other callers of
>>>>> qemu_prealloc_mem(), like virtio-mem?
>>>>>
>>>>
>>>> I'm not familiar with the intricacies of virtio-mem, but the basic 
>>>> idea
>>>> of this series is to *only* allow parallel init during the start up
>>>> phase (while prealloc_init == false). Once we have parsed all the
>>>> command line args, we set prealloc_init = true
>>>> (wait_mem_prealloc_init()) which causes all subsequent calls to
>>>> qemu_prealloc_mem() to perform initialization synchronously. So, I
>>>> *think* this covers the virtio-mem use case. Am I missing something?
>>>
>>> Good, so this should likely not affect virtio-mem (which also ends up
>>> preallocating memory when loading from a vmstate).
>>>
>>> To make this all a bit clearer, what about the following to make this:
>>>
>>> * Optimize for MADV_POPULATE_WRITE. If we really need support for
>>>    !MADV_POPULATE_WRITE, this is better added on top later.
>>> * Pass in via a parameter that the caller requests async handling. 
>>> "bool
>>>    async" should be good enough. Then, pass that only from the memory
>>>    backend call, while QEMU is still initializing (we can find a way to
>>>    make that work).
>>> * Provide a function that waits for any remaining async os-mem-prealloc
>>>    activity. That is essentially "wait_mem_prealloc_init", but without
>>>    the special internal flag handling.
>>>
>>> Further, I do wonder if we want to make that behavior configurable. For
>>> example, one might want to initialize backends sequentially using 16 
>>> threads
>>> max, instead of consuming multiple times 16 threads concurrently.
>>
>> Seems to me that no matter what parallelisation we use (within
>> mem regions, or across mem regions, or a mix of both), we should
>> never use more threads than there are host CPUs.
>
> Yes. It gets tricky with multipe NUMA nodes, though. And that's what's 
> being requested here.
>
>>
>> Can we have a pool of threads sized per available host CPUs that
>> QEMU can access. Then for each memory backend fire off a set of
>> init jobs that get distributed to "appropriate" threads in the
>> pool. By appropriate I mean threads with the same NUMA affinity
>> as the memory backend. This would give parallelisation both
>> within a single large memory region, as well as across memory
>> regions.
>>
>>
>> eg 4 host CPUs, 3 memory regions (1GB for 1st numa node, 1GB
>> for 2nd numa node, and 1 GB with no numa affinity). If we
>> spread the init work then we end up with
>
> I'll note that having a mixture of numa + no numa is not a common 
> config we should try to optimize.
>
>>
>>   1st thread gets 500MB to init from 1st memory region, and
>>       250MB to init from 3rd memory region
>>
>>   2st thread gets 500MB to init from 1st memory region, and
>>       250MB to init from 3rd memory region
>>
>>   3st thread gets 500MB to init from 2nd memory region, and
>>       250MB to init from 3rd memory region
>>
>>   4th thread gets 500MB to init from 2nd memory region, and
>>       250MB to init from 3rd memory region
>
> We do have prealloc contexts that are used to craft new CPUs with the 
> right NUMA affinity. Prealloc contexts are set for memory backends. So 
> extending prealloc context to limit/reuse threads and do the pooling 
> might be possible.
>

 From a NUMA perspective, I feel prealloc contexts already supports what 
we want - i.e. we can set the number of prealloc threads and their node 
affinity per memory region. As such, unless you feel strongly about it, 
I'm inclined to leave additional enhancements (thread pool) as a future 
project.

Since multiple NUMA node configs are the primary motivation for parallel 
init, I do wonder if it should *only* be used in conjunction 
with prealloc context. Perhaps we should have parallel init only enabled 
for memory regions with prealloc context?

Thanks/regards,
-Mark

>>
>>> Could
>>> either be a machine option or a memory backend option 
>>> (async-prealloc=on).
>>> Once hotplugging such backends, we would disable it for now, but 
>>> could allow
>>> it in the future.
>>
>> IMHO "do the right thing" without user config is preferrable to adding
>> yet more cli options here.
>
> Sure, if there is an easy way.
>


