Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFC811706
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:33:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDRE8-00007R-SG; Wed, 13 Dec 2023 10:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDRE6-0008SS-Lk
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:32:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDRE2-0007kz-Hg
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:32:45 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BDER1gt023845; Wed, 13 Dec 2023 15:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZxTSMVXDvYyviT35/EnHuMcbxcCBbQiXg/MBi4NWq9A=;
 b=PFHck+tHDhzmRge8iKtP7FZSinQIHwrBxRxG2oI7cHA1EvoumYEb2xGUF+1aS643O9ql
 5he19GmW9YUFq52aWktgf/w+i/26eTLKPFvtRP2LnXCBteNxeYAaRuR/tbjo1C5daVpk
 KpJxo65p8iluDFTHWkI7yVVTpI8FtIfe8aRequVql/38C9Vg2K1VOY4nC31cPBwtGKG1
 aOAdXMPwskrXBuzGKWIHLNCWS73UuG0O0mrzRW9b4N56x9JhXZvJ3HV5eliq9e8dtFoW
 CkpZ+BfvpUo17PTIP1iBbn10VauQ5ILleRPGed6RTUUEhOC5ZsCDFzDWuWT+3GYDaDon Lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c8h3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 15:32:39 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDF6APE003112; Wed, 13 Dec 2023 15:32:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep8fbqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 15:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuzZNSpw8Jx7Fq55R2W2GQs40rEEY3scidWde9EmTY2GHkRlm9k7dJgMm1ruXMiyRl8rkXrzfbWxZvUtq7oI8R9YuwdTgTBIi6Mqf2r7hHwQ4cVfWhr6mXUu9Q+ePuhUv6Zrd/Y9z0zhzflEbeolFiaGUfLpyXJ2h6EX/dXn8F3S6/v3h3AeM+6guWO/1ONaWxyuex3rSg9CGnAToy6bY1gQ/hiVVixo6pzS0W+yAoWeuKO4L9oZ5RF9ETrLTqanttxI4VJEe79j7Cnwl2zYeUiQt/K/uR7da8s/5qU2K4fqCBe0CBd+TvX2IiWz/hP/5q8opAN1tQwux10ZGfDgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxTSMVXDvYyviT35/EnHuMcbxcCBbQiXg/MBi4NWq9A=;
 b=TloJ/gJYZ5zMlOc16MClJTq0TGikI0mujsgjDiDJy34wF9kFuAf1Dqj/eTJRgKfPU8xYc8hzDTTVMcPEAC2FmAYco1TXqLcCkHs80ealNAfpfYQZSLlHjahCYu89+BcveieO2C8+mVweQXI0UQPIWPsYb7Q2fp+I5St+k/TWj89NVysHjs8PEDUpMw6ldoXg8++/HZ9YdfWv1shX7yhQtzQRew0+6ljgUzdaCGq4U+smyiFhrzNiuP3Q46pfiENKkgbOeu+IK4FJWw5XlSj0u2CXI1yngj1D4dr9CfeJxnK6j+CPNHw4etYIu4uImaXU4HFY7er92PMEE3ZhvnnL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxTSMVXDvYyviT35/EnHuMcbxcCBbQiXg/MBi4NWq9A=;
 b=ACk12h+ZLPimeBMZM/kO7nPLrHcfUwzA4sgHdBUpgf39zIBcrqsLaXsznZsHaC6a1KJDv/8q2tXi1NZIUHPJAkUiADti/yuaw7GVnQ/etnWvZ+xg3b6CZfo51UjFzuvT7QwtaDAoqhSAmVRyoEbtGYm/g2IWHT1kcsb+eBQa7IQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5768.namprd10.prod.outlook.com (2603:10b6:a03:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:32:35 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:32:35 +0000
Message-ID: <a8f3e93f-d74e-4adf-8a71-a85a90930302@oracle.com>
Date: Wed, 13 Dec 2023 10:32:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 02/12] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
References: <1702481421-375368-1-git-send-email-steven.sistare@oracle.com>
 <1702481421-375368-3-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1702481421-375368-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d322a5-2e2d-4b2b-2cdf-08dbfbf0bb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4+D+R4HzsFMY8aFoVU7CyogbE3EM9raCgRIxbwhBatUt1GYrqlmTmgw88L8gk0vgMBzLTJzmPl+UIhSXx3ZExVDFsC+at0RvIJbI2Q6YdLltrZPSKs20CU1SlR4jhLjufs/YgxTupiH+sMkQw3OLpTP3ozoEsFv9J8oR/yx7S0iFbBjr/c2FadBiaKpfGyqyMmt7FD8gs1pMnCSRjJqS8zAromWjBAz5diSQ9jOK17ZiC0lIFyNHqieLIEkJkviPZGFuNFoaCHSZIFHn5mcqzELzyhHrK3NRGJOLgphlekEHTc9AaRFvb9BXeeDFBE8jACFeAL3I1+jqw7f7JPLZRMEL7MhE6a8jIs4FlBlgTpwxxRO2rlVCHOEDjOQ4p6kWGw1R0g7eP0Z+esJZ000mhb5WWbPo1obO+y/Jk6ZeGvWP/+xp1Ura0ko+ZPXYjb7tnDtPoJIR2xUImj6IpFVrW+1tKUsWnGHhbJgHSXQM/PFaWCisOMtaVlz8hta/N9bZk2TchfIUyIxLAaefA8Jxjdyi0WXNrsugUVE3ipursksu8gDEuRzOTNkC9SgHjIdyFkaR0WILZqcDyBQcQVUFOuKTv7fkWOLhtblZTuDkH+M7RQrRDP5XhEMnYMwfpo+wZqRMQjTiJMWoDHHJ50Tbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(6666004)(36916002)(478600001)(6486002)(6512007)(2616005)(6506007)(53546011)(4326008)(41300700001)(8936002)(8676002)(38100700002)(5660300002)(7416002)(15650500001)(31686004)(36756003)(44832011)(2906002)(66476007)(66556008)(31696002)(66946007)(86362001)(316002)(54906003)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRIWnZkRzh5L3RuUzdHeEI4aVREV25ZS0p1SzZONGswbVlQWFpCamhUNVlC?=
 =?utf-8?B?cStua0Y2Um02ZDgwa3FPckZyZzNFd1ZpcWlCKzJxeW5Md2pCeUgxWmFUWmh0?=
 =?utf-8?B?R3VGZE5INEZ0TG1qRUFLK1d6Vmptb0hGa2FHVUFtbE9EU0tXcndhSEY0OWpU?=
 =?utf-8?B?SzZKa2JMdDdFVmpYNGhQVlVWLzNvRndXTnhmcjhNYmlyd21VL24vZW1VdFhk?=
 =?utf-8?B?WTJiWHFCaEJ3TGovRmN4NDFqLzB2YTlRSVZUdldaalZsczI2clZSSTRtdVR3?=
 =?utf-8?B?WUVxdWpUZnhhTEtNWnk1RUx5ZlpGVE1mZ3Z0NC9vMmJGdU5tcnE3Z0pMMHJ6?=
 =?utf-8?B?bFRZWC9VU2phckU1dm52ekc5K00vTmsxZmVST1lmTzhKTWhjSkkzYnk4cWpM?=
 =?utf-8?B?YWgvUkROVytyVVFBWE1IOFR5NWVncXJ5SGhXRnFBSW92WVg1ZHV2SlFIUkxM?=
 =?utf-8?B?NnQ2OXdiU2FNL1NMZnZiWkR6MmZkajBZei8zYW9JNWFudzNlSW50UitlaUtx?=
 =?utf-8?B?WmxFSTA3UU1GUGlraUtPWE91UHhPS1N1bDVHcGVyc2wzN0xsOEt2WUVMNzhZ?=
 =?utf-8?B?dkFUb3JiUW1OODJod2wwQVlYNGVhWlpPWHk3bnhQVHlSL1loWVVkbXFxYVJH?=
 =?utf-8?B?bVZ6Y1VMQTRYQ01ycUVXa2IyUnRMN3U0Q3pMbUVvVC9MTkFNWE84NWl2TUE2?=
 =?utf-8?B?NWdITUEyS2ErWUFuSzU0SVorM1BTMXphSkNpOXpNRFkvVkdEaUV6WVpocm5R?=
 =?utf-8?B?ZlNla2x5NWFkWDBycG5TOUVXWHltbVdBWWMvSjBDQTFkNFUxcUd0cXFoWHJk?=
 =?utf-8?B?MWYyTldnMjdRTE5SbkpWM2xyRGQwVElDWDREaVQyZG5sMGdEbVQvMElpRmdY?=
 =?utf-8?B?Sjg4dDZqYTVDeEs2bi9vY29mcWxjT3lnbGhvMk9tRHZqYW9GcDc5d1BZUnFx?=
 =?utf-8?B?OW9TNk1tcU13UXpDODRDTElGODdxeFJEM2RHb2pBbnl6TzRic3YwTEdqemE4?=
 =?utf-8?B?blcyMEUrNnplYVVxM25LS1g2YkhOK2JJL1dVVlc3N2VobjVEaDRtOWg1RnN2?=
 =?utf-8?B?UlZNQm41TFhKSyt0c2theXYyZUdrRTQrTDFFUjkzR3V4YUFQU0M0TUtzRW95?=
 =?utf-8?B?WUtDV3BiWnlnMlZPUEhUYVd2MkVwbjRaeTl3T3B3b3NHK2dsdWg3czJ0c0VP?=
 =?utf-8?B?dy9ud0R5eXVjYUt3clhCeS9pWkVVNEYzZjNjK1ZraDNZVGZTWEk3emdYcnRY?=
 =?utf-8?B?SFFSd2NRbTRMK3lkVERBNGJraWZKeXBSL0gzUmZDK25meEd0VzcwRlFzTEJ3?=
 =?utf-8?B?bER4Q0pEMHp1M0wrWFRuVWJUSVdTcTR0c1JlQk1HSnAyOElkM2NsODduTjVV?=
 =?utf-8?B?aGFOVkd4U1B3L0gvbGlJczJPNkRrVWFzNjFTbWdVSnlXMHZ6R2hGZWpLeEE1?=
 =?utf-8?B?dmt2eUZlVkZDNlpKWFRQeFhlSEp0ekdhby9WaHFyRzQ1Qm4wZ3pMSENFRkFj?=
 =?utf-8?B?NnZ2NVRTL3BuOUpLNlFydDFmZ2RlY3QxU1I1V2wydFhmcWxKK0ZGUnR3L1ZN?=
 =?utf-8?B?ZFd4Wi95eWdvd0NEUXpOWTc2SEd6ZElsc253NWQrUFVCcDA4VWlPbU9uTkNo?=
 =?utf-8?B?YStzdk1ENXF3Tk1wcUN5ZHpmSWoxdHJDS0FEb0JITWFvQTZFWHg3NXplVFNx?=
 =?utf-8?B?NEhCNno0UmMyY294ZmdyNVpmWm9lN2g1MGNaZzgxNS9ZM0hKSFE0dXgwYzBT?=
 =?utf-8?B?Tlo3N1crZXdzOGVhUEswWkxLZG5zWjN5NkZIc29LOVRDMUZ1QjRQZ1pWOU1N?=
 =?utf-8?B?Zy9CNmdzdjA3L1l6Y1crbElqWHFGS0FkengwZ1hXbVJmOFoydkN6dnZUV01H?=
 =?utf-8?B?MHJVazQ2MFAyWEJqTkkxMXRmSkFYRld0UWl1YTg1UlNJU2pqTUwzdHBvZkx5?=
 =?utf-8?B?MVdMY3M2bzcrWlFmbVZna1JaVDJkVy9pcHl0QURYUzhDR0JuR0JDVVVmMFRT?=
 =?utf-8?B?UlMrSHB4cU9SZzdsTEVTWlJGV1Fqd0c4bEpKZmg5TGJHVEJsN0RkcnNJKzkx?=
 =?utf-8?B?ZFhyekZSUHAvQXUrM1dYRFQzTGdNcXZ6aHV3TkZ5c2RMUFg3ckg2YlBOYzY5?=
 =?utf-8?B?WEcydEE1bDgxeW1sblNTcysyTXVoaW5raVRLQzUzcVNiK3lLYW5lcEVtY0ds?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EXtbXMYS20rNpsUEJG5lHfA4RHDB1Nb4Y+kgURpXg2CivbHlqb/wI/CB2UBVwZi7SU71PHLG7TynAXmdt6ap+7DGqP6PRy4pYIqlpRTmOfeGeEwX8s2rjPs21cBeXQow4eriUkOz3agOCbt+ciQ7eJ40W2QAKocEUTA0XFHEC/TotXBIv5u1T0X3r3ZwSkEKmB6RoTF/3INhekJRjLyLtGRyzMGAPe3cn3mdAw7iitiJKYBvRHxjj7tecB8MVz71eV60E2yhk6mKHDmzB9XheDWeE8Mn+cFu/6B0nbzY+f5h+qQ33PDIP4QnQwGXzguS0BXXxpIFZ9ya3dWwqWfKdAkzx4ur6zAusjn34byG9egEpAat8MBGHPB2xxtQfLBR76lGIb46N/5Dkv/6ieqOcQOs7eMOvAHPnFob5mcTbuNk4wGGM7OfI13WHO7XMFhXkIqW/pqk/DOclJHmWv/Ptuaer+XMZHJsq/+LA4sXNFc6WbZdor6PnTrQN4JvweGDg0kvSWA2hIQLZQfuPR1FBKD45/PZRQFraMbgJWMpZPu+t4PBc+kwuGZ9GXOKhFq5yYyNhyGlqmS3WilxJ9FnlZB66oAN4JpI4rMz/zz9cU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d322a5-2e2d-4b2b-2cdf-08dbfbf0bb1a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:32:35.4391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THvJbrZwT8mI54LI1WRokhUoiaeiCIrPEP+ZJ7RVkaP6zeCdeR33ASeq+YxAOJpXMFY2W99dL7kPaEoW2rTeOfMd9rORcO2yxTHyzKytV2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_08,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130110
X-Proofpoint-ORIG-GUID: kUKeaKxJAEip2aBqTvyBUDqTrxaxDIt8
X-Proofpoint-GUID: kUKeaKxJAEip2aBqTvyBUDqTrxaxDIt8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

FYI for Markus and Blake.  No change since V6 and V7.

- Steve

On 12/13/2023 10:30 AM, Steve Sistare wrote:
> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
> have been paused, but the cpu clock still runs, and runstate notifiers for
> the transition to stopped have not been called.  This causes problems for
> live migration.  Stale cpu timers_state is saved to the migration stream,
> causing time errors in the guest when it wakes from suspend, and state that
> would have been modified by runstate notifiers is wrong.
> 
> Modify vm_stop to completely stop the vm if the current state is suspended,
> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
> Modify vm_start to restore the suspended state.
> 
> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
> cont commands.  For example:
> 
>     (qemu) info status
>     VM status: paused (suspended)
> 
>     (qemu) stop
>     (qemu) info status
>     VM status: paused
> 
>     (qemu) system_wakeup
>     Error: Unable to wake up: guest is not in suspended state
> 
>     (qemu) cont
>     (qemu) info status
>     VM status: paused (suspended)
> 
>     (qemu) system_wakeup
>     (qemu) info status
>     VM status: running
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/runstate.h |  9 +++++++++
>  qapi/misc.json            | 10 ++++++++--
>  system/cpus.c             | 23 +++++++++++++++--------
>  system/runstate.c         |  3 +++
>  4 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 88a67e2..618eb49 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -40,6 +40,15 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>  }
>  
> +/*
> + * In a "live" state, the vcpu clock is ticking, and the runstate notifiers
> + * think we are running.
> + */
> +static inline bool runstate_is_live(RunState state)
> +{
> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
> +}
> +
>  void vm_start(void);
>  
>  /**
> diff --git a/qapi/misc.json b/qapi/misc.json
> index cda2eff..efb8d44 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -134,7 +134,7 @@
>  ##
>  # @stop:
>  #
> -# Stop all guest VCPU execution.
> +# Stop all guest VCPU and VM execution.
>  #
>  # Since: 0.14
>  #
> @@ -143,6 +143,9 @@
>  #     the guest remains paused once migration finishes, as if the -S
>  #     option was passed on the command line.
>  #
> +#     In the "suspended" state, it will completely stop the VM and
> +#     cause a transition to the "paused" state. (Since 9.0)
> +#
>  # Example:
>  #
>  # -> { "execute": "stop" }
> @@ -153,7 +156,7 @@
>  ##
>  # @cont:
>  #
> -# Resume guest VCPU execution.
> +# Resume guest VCPU and VM execution.
>  #
>  # Since: 0.14
>  #
> @@ -165,6 +168,9 @@
>  #     guest starts once migration finishes, removing the effect of the
>  #     -S command line option if it was passed.
>  #
> +#     If the VM was previously suspended, and not been reset or woken,
> +#     this command will transition back to the "suspended" state. (Since 9.0)
> +#
>  # Example:
>  #
>  # -> { "execute": "cont" }
> diff --git a/system/cpus.c b/system/cpus.c
> index 9f631ab..f162435 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -277,11 +277,15 @@ bool vm_get_suspended(void)
>  static int do_vm_stop(RunState state, bool send_stop)
>  {
>      int ret = 0;
> +    RunState oldstate = runstate_get();
>  
> -    if (runstate_is_running()) {
> +    if (runstate_is_live(oldstate)) {
> +        vm_was_suspended = (oldstate == RUN_STATE_SUSPENDED);
>          runstate_set(state);
>          cpu_disable_ticks();
> -        pause_all_vcpus();
> +        if (oldstate == RUN_STATE_RUNNING) {
> +            pause_all_vcpus();
> +        }
>          vm_state_notify(0, state);
>          if (send_stop) {
>              qapi_event_send_stop();
> @@ -694,11 +698,13 @@ int vm_stop(RunState state)
>  
>  /**
>   * Prepare for (re)starting the VM.
> - * Returns -1 if the vCPUs are not to be restarted (e.g. if they are already
> - * running or in case of an error condition), 0 otherwise.
> + * Returns 0 if the vCPUs should be restarted, -1 on an error condition,
> + * and 1 otherwise.
>   */
>  int vm_prepare_start(bool step_pending)
>  {
> +    int ret = vm_was_suspended ? 1 : 0;
> +    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
>      RunState requested;
>  
>      qemu_vmstop_requested(&requested);
> @@ -729,9 +735,10 @@ int vm_prepare_start(bool step_pending)
>      qapi_event_send_resume();
>  
>      cpu_enable_ticks();
> -    runstate_set(RUN_STATE_RUNNING);
> -    vm_state_notify(1, RUN_STATE_RUNNING);
> -    return 0;
> +    runstate_set(state);
> +    vm_state_notify(1, state);
> +    vm_was_suspended = false;
> +    return ret;
>  }
>  
>  void vm_start(void)
> @@ -745,7 +752,7 @@ void vm_start(void)
>     current state is forgotten forever */
>  int vm_stop_force_state(RunState state)
>  {
> -    if (runstate_is_running()) {
> +    if (runstate_is_live(runstate_get())) {
>          return vm_stop(state);
>      } else {
>          int ret;
> diff --git a/system/runstate.c b/system/runstate.c
> index ea9d6c2..e2fa204 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -108,6 +108,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
> +    { RUN_STATE_PAUSED, RUN_STATE_SUSPENDED},
>  
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
> @@ -161,6 +162,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED},
>  
>      { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
>      { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
> @@ -502,6 +504,7 @@ void qemu_system_reset(ShutdownCause reason)
>          qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
>      }
>      cpu_synchronize_all_post_reset();
> +    vm_set_suspended(false);
>  }
>  
>  /*

