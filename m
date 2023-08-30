Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF678D66F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLzQ-0006EN-DT; Wed, 30 Aug 2023 10:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qbLz9-000653-3U
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:16:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qbLz5-0008QZ-4m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:15:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U9iRkB019244; Wed, 30 Aug 2023 14:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AyVijfTR4DzYcNi6kgE8tlejyuEUSo2ZlFYTlvYT+aU=;
 b=G60aBqmfJRXakLsaltCgMU4kmuU0dj3iBSPgEzLmr5hbDTKzzBg4tOKHZwkDDeG03IMf
 cY237f7jcf770j0xfahfxy+VCdtYerq0EYuQrrPyZfO21Q0RuoezGG1orhe2caW+eCea
 dwkV5aHGc5xZK+pMjC8xPTZb2R8nf31nrOHu2bnxBG9K1MYxrgXL4rBo5KHGJMShFH24
 94hgsJ85hIr50/A4TlLSFsnC5/TxPaYDgQU158k/34wIS+RJ3yAGmYQxij0MmLgF7+xA
 NizSaxNJEjcIvq0JBeeX7DPCUCcYzRkAgDMEGTGYwMoVHy3ATzxo5xOIiFeW3jCZfzMB cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k67h40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Aug 2023 14:15:48 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37UDVSi5000526; Wed, 30 Aug 2023 14:15:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6gcmjsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Aug 2023 14:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojn7egzaAOEyEBhAJRcRXB1/adALosd5Hy4Wufr3pkA3UpB7+VzC6wGtjNoRmdmme0FpTfO/tIGHhOGj3FyeLNf2NOeFfIzeArqYgYnrXBl+uFUSqaBZKzpqmkrX2+2i9lJH55V+BVBOgDY5W487iFmJJXKlrd8nUePXNNkVg2/eitrTesD7yjNmAtXkw6gC3QoyOJDoxdY5Ur06hRQyxGq9/DwfCV2+A2X1wiKiPfA2eVeSs6uKAEAm1GVH+eCWv92NZxNRmjo4CT9jh3nHBKLkGlgwwUPB4FjBUYKLrslb5aazTS2pW30B7rgyitJJ7nnCFuuhLE116oKCfH1B9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyVijfTR4DzYcNi6kgE8tlejyuEUSo2ZlFYTlvYT+aU=;
 b=D48hKGlZaehW2WMYw29n7Iiec4I7yZNxoC+Nt8+dVIc/G1FNgbxogIAOccO6h5DCAzJaVrOm9ybVhyKRsvYaB+drQaEzc9BXNb9cUNoLU4uFmu8/mC+wrFzx24tX3Dn5U9mEFeGcYMqrSdG2mRm3zMMuVPwd0SXSvx1k2ejXLTDLKlZeVkUJICPFeVnU11VTU1yfpEYx3tYj38DAJO7+gtMTwwsPRp90Jz/fmdNK9jvur5O1siteCC0+EIHofxp4vsJfFYjW8dsKMrNYG3C5g7kz2+QdfGEOqCPqFjz+aa/b2xpzbPIZSzSf5D1X1dKLGJ/T84tGiMlXwC+jDi6rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyVijfTR4DzYcNi6kgE8tlejyuEUSo2ZlFYTlvYT+aU=;
 b=ckHWCuNsevzayEuwtZ2Kvb8asay7pjNPk7C/QhRssWZG1c/WNKn63tkzznYtJlvvmTYT4S+99Cq832sN50m/bM8Qsg9X+kRaDFLuRJb9ECxuo74bc33gvVkpuTfPfKoFrs4TUHzXxtKzIK9jeYE+vULplNxkMyrKtpFs01iS28U=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH3PR10MB7679.namprd10.prod.outlook.com (2603:10b6:610:169::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 14:15:44 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 14:15:44 +0000
Message-ID: <2dbbaf06-81cb-0442-05f2-f0f00deb5618@oracle.com>
Date: Wed, 30 Aug 2023 10:15:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V4 1/2] migration: file URI
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <1688135108-316997-2-git-send-email-steven.sistare@oracle.com>
 <ZO9BNnnOnLjH3bcD@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZO9BNnnOnLjH3bcD@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0029.namprd05.prod.outlook.com
 (2603:10b6:803:40::42) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH3PR10MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: f10b0dbe-93c3-4a0f-9935-08dba963995c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y++222P8bjC+GFwqliQpWt9UbEJst/5EXbM+d58jg2spGoMfYYzoZHXl/1h7hQHF/5CMuoJpz8z1PlsZxR3RMJlnc8AAV09X/v6CwETp0fTqze31RYNzmYPk8LKng9Zbqz+P3Z7zeYImsSuucJ4cTUljuTbmlGTIXR7XBotFKbzXiXK/LpNLbsm7PX8cJFV4QYErA09t8rUdpbdFghgCE5wLfc1KkJZq/zDkcbAQ7ti7qp6slq69JdgHa5yB0+Uirs2q8NNP14UAT+7ilC8DZBmY2XE6Q+k/2tPt0/iHo7Tq22F0uhzEVTK4g2RYe7fxbNtvNpxVaU8H1adk2rBrIltCk7SUBnRoL+iHQxn4Tnn0L2bybhczbL3V4ACkUOzCQhuugk7OUFaHK/agIGvzhwkI/V2YXUtRdMKyrtqxnjzNPqgA4kVlMzA3P4OjB3rbGP447ONc8Ka0EIplpt22uBy5GH3NLUjZcMsdL9hb7KzzWDgH8XNPCQLQXMXoZbmb5aPDMuH7utJIITD7poXBpXJI7MvoOLSb0l+0IGL256J7a+MiYwdluWatg4XGLLHc3Ra7Rd/iPcKfXW+iKCVXUyxU1sED4DxovnficNTbz1o3YdUl2kX7gztjdJUpBoJ8zQnLvB4bdiQ+4imzvnfHkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(186009)(1800799009)(451199024)(41300700001)(66899024)(38100700002)(2616005)(478600001)(86362001)(31696002)(83380400001)(26005)(6512007)(6506007)(36916002)(6486002)(53546011)(66556008)(36756003)(54906003)(316002)(2906002)(6916009)(66946007)(66476007)(5660300002)(8936002)(8676002)(4326008)(44832011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZDSFR0ZGZPWnM1UmlqdzJEWmtmanV4eWl3aGlLZzRPUCsvcXRlRXdOVjky?=
 =?utf-8?B?enlFdUJPWU84QytzWTU4d3BUa0h5NERodTM0eWdxKytOM2FMcWQwVGtVZlBp?=
 =?utf-8?B?b1lpSG1NdUp0S1JQNkdtSE1MMTFoWThPaE82c3ZwTWw1WDROSzdBUDA2RG10?=
 =?utf-8?B?WlZ3NDZVK1dZQlVvSlR2UGgxZEJBRkZpUW5BcEc5NFptbE1PeHRWZWVodzJ2?=
 =?utf-8?B?cWN3TW9VTUs3UTVjaEQzcEhJQkM1Y3E0bGpKcTgyRUNBclJUZy93SGpock1h?=
 =?utf-8?B?dUpjTzZQeC9TZGtyUHFmd1Z4dFVpem1RUHR0OTdrZk5qU1ppVWQ1OWJlZy9x?=
 =?utf-8?B?RXRRdHExYXBTR0xTZG5XMXUrdU8zSmkvdWFPT2pEU3VkdysxS0ZLUWhTcEZG?=
 =?utf-8?B?eGsvbGtqck16Zy9EQ3kvYWtsY20raTZIWjlQUmdlSmZtWTN0bllvL2J5Vmx2?=
 =?utf-8?B?eEJnREFUM041aWtyK08zNGdyaVVaU0w3SVdRNFExaU9Nb3Eyc3NNMmhWZFEr?=
 =?utf-8?B?elM1RlJYMU02bVZNK1paRTBPVEZZVjdpZjB6N2orZU9NNGdIQ2U4b1pCKzFC?=
 =?utf-8?B?MXhJOW94OXA1c0VtYkxveVlCeklSQkYyUTdNZGNxcWpJL2wwVjNSUWJqRjZh?=
 =?utf-8?B?anF0TzhoZkRDRmZHdXhLNkxnZ0tpT0RITFN1czhBWmlmTDBrQTNDQk9kZkE3?=
 =?utf-8?B?RVYvZnYxRTN1Yk5VRXJDRndrSWt0NUZxWWsxU3E4RGdYM0NZaWZ1cDdlUFlm?=
 =?utf-8?B?dCtJdS85Nko3MkZzSFRSb3hHOW95MTg2WjIrbXFZTHhLVVJkY2VYZ3dGQlRp?=
 =?utf-8?B?WFMwYWZHSmRwWm9JdnNuTzU0RWlkajNQOVBxQlZRbWlPdlRTT3RTWHJ5aEx6?=
 =?utf-8?B?QjNGR1lHWHVVV0hMOHd0bUdQWERoaE1WRlRvWkhwV1dET01NUGZpMXltSDBT?=
 =?utf-8?B?TDhKT081djY1TzE3Vk9tdHlWNDFZeFlOd2NGUi8yNjdYaWxIMFU0eE15VTVO?=
 =?utf-8?B?M0wxOWlLV2d4MFRCUk9oSkJMUVNOVVZuRWdTeUhUOVpnWXcybC8rdElRLzBj?=
 =?utf-8?B?M1hSYUFZanEreXZtWTRYSlpHRnFkdjNycmlEOU5wVUNWZndPNVV5UFRLclVP?=
 =?utf-8?B?LytqTXZpM3Nva28xMllqTXdwMnpsS21NVnJRV01XVmxObjU4SXY1c0xxcjAv?=
 =?utf-8?B?YUMvZTIxM05nczBjMVdxOWMwZnY5R0tsTU80dEF0eW1pdC9mWDNhenhUUWFT?=
 =?utf-8?B?NlFJZG5lSlRoZmFKMXNPdTE3WmI1UUN5cHFaUk56eFJqeTRJV0ZVOHBlbnlt?=
 =?utf-8?B?R2NjNnczdkJxOUNPenFQTUdrOHE1RG1IVUV2SU9HZjUxMjFDUHRkbnUxNDVJ?=
 =?utf-8?B?Vktwa0tYcnN6eGw1V3h2aFNJWjR3MnRiV3BIZkhKMDNsNnl3cFAwYWxSMzdr?=
 =?utf-8?B?L0xyL0gweG9zVUp2ZDhuUU10T0JpazZrZ05JNGpJU2tIaXhuc0VNWk9oY0RP?=
 =?utf-8?B?M0ZySVNmWC9BbXZZK1FTN09oTkdvUFlsc2dyUkp2KzN5ZWlEQXQrakFqRllP?=
 =?utf-8?B?dlV0ZVJyZ3dKN240ODJORld5bEcrUXJwMUx3bS9WVVNCWXg2cWxnNXlsVjg4?=
 =?utf-8?B?VDROVmNhS2xoMkdhYXU4bTIxWlNxRUEyMUhibnJoeWQ4OEV4RUMwT2JMYWVq?=
 =?utf-8?B?N0VRbFh3eXk0a3FUby9Oc0RUUlBxb0oxV05NL3lGak5IeTRxNVNDZHduaDE0?=
 =?utf-8?B?aGNLTE9EcnhJeEtVRVlIeUg3SFF6UVZqMmxPdGVVRS9NRjFNWEJQT2lIZDdx?=
 =?utf-8?B?VWJPVVM3OWFMMnRJY1JtVlV0SmZ1WUlrOVYwUU5IZk5KM1p3WlgvajhBM0RD?=
 =?utf-8?B?T1NKVGdFWmhIbDJXRy92NVZWMmt4dDBqY2FlZ0o4blJVZ2hjaktXK0NIV2Iv?=
 =?utf-8?B?eWFuRi9VRko3Z3BmK3RhY1Zpbk5Za0FTN2RKSU1LY0hIZmUrL2plczNmV1dC?=
 =?utf-8?B?NHZ6cmEzbm1nQ0tkSk5yTkFTTVhyM3Y2WnFBZGgvM2g0VUcrTmoxUnZSYjZN?=
 =?utf-8?B?ZFl0bFZta0FqcWpYQWtxS3JyVDNINGZTanJseSs4bGxVZWpJcmV4dzM3WFVI?=
 =?utf-8?B?bW95NHZOalFIaGJseXJSWjE4M1Bnc0IyM3ZNTFB0WDVCTHFjYWlndFlUKzVz?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SqufLH0KFD64LHG3MeZl6VJTmaSsvehDjHYtzyRqJj2kJIfi4arJN2UzQqCxnirYrArrXxx+n5Wq7VqQoJ+9Qwdz/qZq6oAdl8NgjWcnDGHYBIXWds/5itONm7pEQItYkmtKz4MSH1q+H9oNX4kikFRKc2qhdmPWFcWXIRFG3L6xYodHZrxy5s9sVu2DbdM2aI1Wy3qxEpUZHkZ6LWY7NLGrt+E2CuUlmBzMPiju52NmaQJvSFIlyoVIiP7xyS9yElAa3eKIRamKmq3/I5TZKGVFqhi1cetyx3gC4IOA0qvSvRIIkt7NP4OE35IKFD6a+bJxjpxIiB9wiumYM1EY20alYGG5vkGrcdUyeaKqHbOi8rptN46KQi6R5w5VhDuU4J6hQcMz7ZGgRZIou5xty25KFnOKa3W5e28zBmq0eZkIdo1Gz1EGd2M+Ur7CplyFFr+1VSXz9LAe3AHXfM7laf9oyG2AJSeKA5+DlSf1+nCn31vI8dnlr1WLEfXW6IZq5Ea84p/GGYTPJMqfKhklAuXgYGeSKnxZMcLZOgEp1n6LjtrS9SNzSEcLnHelhQeG+G5peF2yjka8HORAMxnXS50qCdga2agWn2I7jLTgrAV4ixDJBO9uIE6JUfPTCOkEau2T+X8wrMHriTQPn/XNsuCPqYngrPQPMxDLlCxC3bUafV1KFlGITs6qmkjRb+bnGdtgRbLsBHL/+ibPtCc1XiGO0D/lqmSRcHKRm2un5YkM7KhI3HHf2TwoZaZhFyPg/wY4bWufwdBTYKl3dTgArlaqg26Hlev+smDRfz/bqUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10b0dbe-93c3-4a0f-9935-08dba963995c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 14:15:44.4398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brdEMypYpU4fi+2MSXpRqsZ/X4vwmdXA7USjuj0l6n4azy4MY3MvtcoZ5LLqYoZ6GSXV+cIWBLeEYizLoE04/FwafF8dNUR5RMYz5byvXPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300132
X-Proofpoint-GUID: yxqtNSt7TLlKfN9KMc6Z80aNGJEBSGW-
X-Proofpoint-ORIG-GUID: yxqtNSt7TLlKfN9KMc6Z80aNGJEBSGW-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/2023 9:16 AM, Daniel P. Berrangé wrote:
> On Fri, Jun 30, 2023 at 07:25:07AM -0700, Steve Sistare wrote:
>> Extend the migration URI to support file:<filename>.  This can be used for
>> any migration scenario that does not require a reverse path.  It can be
>> used as an alternative to 'exec:cat > file' in minimized containers that
>> do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
>> It can be used in HMP commands, and as a qemu command-line parameter.
>>
>> For best performance, guest ram should be shared and x-ignore-shared
>> should be true, so guest pages are not written to the file, in which case
>> the guest may remain running.  If ram is not so configured, then the user
>> is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
>> the same page, causing it to be appended to the file multiple times,
>> and the file may grow unboundedly.  That issue is being addressed in the
>> "fixed-ram" patch series.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>  migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  migration/file.h       | 14 ++++++++++++
>>  migration/meson.build  |  1 +
>>  migration/migration.c  |  5 ++++
>>  migration/trace-events |  4 ++++
>>  qemu-options.hx        |  6 ++++-
>>  6 files changed, 91 insertions(+), 1 deletion(-)
>>  create mode 100644 migration/file.c
>>  create mode 100644 migration/file.h
>>
>> diff --git a/migration/file.c b/migration/file.c
>> new file mode 100644
>> index 0000000..8e35827
>> --- /dev/null
>> +++ b/migration/file.c
>> @@ -0,0 +1,62 @@
>> +/*
>> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.
> 
> Was it an intentional decision to assign this under the version 2 *only* ?
> 
> QEMU's LICENSE file states
> 
> [quote]
> As of July 2013, contributions under version 2 of the GNU General Public
> License (and no later version) are only accepted for the following files
> or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
> [/quote]
> 
> Thus we'd expect this new file to be version 2, or later.

My mistake, sorry.  It should say "GNU GPL, version 2 or later"

- Steve

>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "channel.h"
>> +#include "file.h"
>> +#include "migration.h"
>> +#include "io/channel-file.h"
>> +#include "io/channel-util.h"
>> +#include "trace.h"
>> +
>> +void file_start_outgoing_migration(MigrationState *s, const char *filename,
>> +                                   Error **errp)
>> +{
>> +    g_autoptr(QIOChannelFile) fioc = NULL;
>> +    QIOChannel *ioc;
>> +
>> +    trace_migration_file_outgoing(filename);
>> +
>> +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
>> +                                     0600, errp);
>> +    if (!fioc) {
>> +        return;
>> +    }
>> +
>> +    ioc = QIO_CHANNEL(fioc);
>> +    qio_channel_set_name(ioc, "migration-file-outgoing");
>> +    migration_channel_connect(s, ioc, NULL, NULL);
>> +}
>> +
>> +static gboolean file_accept_incoming_migration(QIOChannel *ioc,
>> +                                               GIOCondition condition,
>> +                                               gpointer opaque)
>> +{
>> +    migration_channel_process_incoming(ioc);
>> +    object_unref(OBJECT(ioc));
>> +    return G_SOURCE_REMOVE;
>> +}
>> +
>> +void file_start_incoming_migration(const char *filename, Error **errp)
>> +{
>> +    QIOChannelFile *fioc = NULL;
>> +    QIOChannel *ioc;
>> +
>> +    trace_migration_file_incoming(filename);
>> +
>> +    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
>> +    if (!fioc) {
>> +        return;
>> +    }
>> +
>> +    ioc = QIO_CHANNEL(fioc);
>> +    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
>> +    qio_channel_add_watch_full(ioc, G_IO_IN,
>> +                               file_accept_incoming_migration,
>> +                               NULL, NULL,
>> +                               g_main_context_get_thread_default());
>> +}
>> diff --git a/migration/file.h b/migration/file.h
>> new file mode 100644
>> index 0000000..841b94a
>> --- /dev/null
>> +++ b/migration/file.h
>> @@ -0,0 +1,14 @@
>> +/*
>> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef QEMU_MIGRATION_FILE_H
>> +#define QEMU_MIGRATION_FILE_H
>> +void file_start_incoming_migration(const char *filename, Error **errp);
>> +
>> +void file_start_outgoing_migration(MigrationState *s, const char *filename,
>> +                                   Error **errp);
>> +#endif
>> diff --git a/migration/meson.build b/migration/meson.build
>> index 1ae2852..92b1cc4 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -16,6 +16,7 @@ system_ss.add(files(
>>    'dirtyrate.c',
>>    'exec.c',
>>    'fd.c',
>> +  'file.c',
>>    'global_state.c',
>>    'migration-hmp-cmds.c',
>>    'migration.c',
>> diff --git a/migration/migration.c b/migration/migration.c
>> index dc05c6f..cfbde86 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -20,6 +20,7 @@
>>  #include "migration/blocker.h"
>>  #include "exec.h"
>>  #include "fd.h"
>> +#include "file.h"
>>  #include "socket.h"
>>  #include "sysemu/runstate.h"
>>  #include "sysemu/sysemu.h"
>> @@ -442,6 +443,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
>>          exec_start_incoming_migration(p, errp);
>>      } else if (strstart(uri, "fd:", &p)) {
>>          fd_start_incoming_migration(p, errp);
>> +    } else if (strstart(uri, "file:", &p)) {
>> +        file_start_incoming_migration(p, errp);
>>      } else {
>>          error_setg(errp, "unknown migration protocol: %s", uri);
>>      }
>> @@ -1662,6 +1665,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>          exec_start_outgoing_migration(s, p, &local_err);
>>      } else if (strstart(uri, "fd:", &p)) {
>>          fd_start_outgoing_migration(s, p, &local_err);
>> +    } else if (strstart(uri, "file:", &p)) {
>> +        file_start_outgoing_migration(s, p, &local_err);
>>      } else {
>>          if (!(has_resume && resume)) {
>>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> 
> This section will clash with the other pending reviewed series
> that introduces a formall QAPI schema for migration addresses.
> 
> Either this or that series will need an update depending on
> which Juan decides to merge first.  The changes should be
> fairly simple to resolve so not a big deal.
> 
>> diff --git a/migration/trace-events b/migration/trace-events
>> index cdaef7a..c8c1771 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -307,6 +307,10 @@ migration_exec_incoming(const char *cmd) "cmd=%s"
>>  migration_fd_outgoing(int fd) "fd=%d"
>>  migration_fd_incoming(int fd) "fd=%d"
>>  
>> +# file.c
>> +migration_file_outgoing(const char *filename) "filename=%s"
>> +migration_file_incoming(const char *filename) "filename=%s"
>> +
>>  # socket.c
>>  migration_socket_incoming_accepted(void) ""
>>  migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index b57489d..5aab8fb 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4622,6 +4622,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>>      "                prepare for incoming migration, listen on\n" \
>>      "                specified protocol and socket address\n" \
>>      "-incoming fd:fd\n" \
>> +    "-incoming file:filename\n" \
>>      "-incoming exec:cmdline\n" \
>>      "                accept incoming migration on given file descriptor\n" \
>>      "                or from given external command\n" \
>> @@ -4638,7 +4639,10 @@ SRST
>>      Prepare for incoming migration, listen on a given unix socket.
>>  
>>  ``-incoming fd:fd``
>> -    Accept incoming migration from a given filedescriptor.
>> +    Accept incoming migration from a given file descriptor.
>> +
>> +``-incoming file:filename``
>> +    Accept incoming migration from a given file.
>>  
>>  ``-incoming exec:cmdline``
>>      Accept incoming migration as an output from specified external
>> -- 
>> 1.8.3.1
>>
> 
> With regards,
> Daniel

