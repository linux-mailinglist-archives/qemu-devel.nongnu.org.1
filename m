Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7722F7CE53F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 19:50:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtAfM-0000jC-TK; Wed, 18 Oct 2023 13:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtAfK-0000Kq-FI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:49:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtAfI-0003Yq-BN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:49:06 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39IHhpEt008044; Wed, 18 Oct 2023 17:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J0NmT5m9dzob+RpVrtNa2tO4caWGSXL/+gvRG0T6jxQ=;
 b=V+MtWfudcT0Q/n/SFPOYi6+ZBR1ErOt7vfgRf95KcY3uIpAgQrSnRldoUmK2avYOtPRn
 FCOk3i9/3MGbX6HlI8dxKSMlB4VX9lNf8AgthnU9odokZ+mgduPal8mAB861F1+57n9b
 0h+pc904dH8UBuCLSbF1lodrHH7fT13jAmDEmer+TGTjlYTBk8KzqXnKcAoOJZLHwHrQ
 vcP/pS90xCU6IMsXf0+wM9ZQd2FOYroTwH0h/QHMh+xehCkxD41jTeutBmMMj3fr3TZs
 s1XQkow6ZR7dhgrX62mSb3PxGU+zGN0J6fdKd0hM8NF0ivLqr/DlQU2iTt4CgPOTCHqp /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cgba9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 17:49:01 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39IGVfqD027313; Wed, 18 Oct 2023 17:49:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg55mtpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 17:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjW6AG5nQTXsDLud97N4LPAZ0j0jvg8FFf5JOp3b7aGWwsiyBhtkJivWhYxAuHemPk+Dmy67K+QsSQk8GRm+kIZNNp9ujriFRrvm1YBbKI/lZj9aKa08TDIUeUj7vc2ugdFpQpZXucg9hKxSVsz4LhLtX3TcZkIvmcZWsYH3eC2f6ycCm5imFdHEZGtkH9jZK0NtGbn9yX3PRr2SjffIELVxFf7Jb8CAOdwsf5IKCmJGK5Lays33uFhBM5SlExhDSgX8n0guz2uMMvKNB/0IUhvdJMm6GWsOi89qyGp8PmSjH0WT+pVc24qwaP/aoLc07qdf/N6/XYbSNii/6Vdd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0NmT5m9dzob+RpVrtNa2tO4caWGSXL/+gvRG0T6jxQ=;
 b=mLEW7z8j3o65Teed534FkWGXDGlhqGVuYAGel0BjMdnEuiVnXCCPr5LGMkhCQ4NjMs6/C+aHe1d7LuD2tcELl5MAxuSkcb7IZcndlMPhy7fevx/nSU0LLuHsVQ8u2XI9hQyB0P6tc+0Jz2B/2/qlLZAsSNqFdN2J9QOZ7ZG/pwSl35Q3DtyNBC+Uosdvp7mCZjm6QMQhoa7i/dN+s8X9dMI3/uXErpKL7gQ7rcmUTF6Jz6nmWVdMSodpw8ruDc5B2fimdLcUSGH50VMqq09LUccP1AWpBmGLg2y3xnH1IDcX8yB2DQ6pD7gN/+vUQmfpVU5dDyHsqmhWBO5gcmvrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0NmT5m9dzob+RpVrtNa2tO4caWGSXL/+gvRG0T6jxQ=;
 b=FUErsPewL/fjAhKfQjWTQk5Sg580gjHW0PI0jnlDc4tZ2nSFbq7aLEnXw+i8QoyfyYALPo0zbN6gj3n5EjuqmYmK6tEFCzvmzADxoSugNkTfdaoJtudqEv54wdS0xrALgXwaP/2Bt4kqcme/AS+H6EJUnO9MEg6YiqXKbe4x+6Y=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB7755.namprd10.prod.outlook.com (2603:10b6:806:3ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Wed, 18 Oct
 2023 17:48:58 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:48:58 +0000
Message-ID: <000572d6-ef9c-4e24-9f9d-fb4bf44a564f@oracle.com>
Date: Wed, 18 Oct 2023 13:48:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] migration: simplify blockers
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697634216-84215-1-git-send-email-steven.sistare@oracle.com>
 <87r0ls82al.fsf@secure.mitica>
 <16d749b8-5d79-4fd3-944a-1be1361af019@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <16d749b8-5d79-4fd3-944a-1be1361af019@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0023.prod.exchangelabs.com (2603:10b6:805:b6::36)
 To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe97c55-bcb3-4c2d-7f37-08dbd0028181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goHHIRF0J7dRcpz52vXZbaHG/jdiSbg1eOqqA2mn7gnt2deNRRJdmrB6gaCT0em2aofYIdsrjpfzTpFA/RTxkABxJJMb/ALL9ctX08lZEnJhG6/2fFUe2S4RGNMwjkx+E8pjWvjrAvjMuYAxLvP2RdKT1Jgfnm4Bfw9GpkE+TXu974mPIBzIOryVROjGVFJSB88nfwi2oTGJ+uyOPt8hryygNH55a/qxiJSilOQk3QhIzVjkEvgG1YkNM+m4ZiHM1lv2YzkXrhQ7NSRMRzSNIyPuw+cRgoIxAofnAioVSNxPacopJnN9z60a7iPkA4+HRJoRuZR0C6+MbtLOcxUHh5iMXftqtSn1IDXH1o443j+/HiNXyRgTOnGbT2EIASTp+XFH3COpBw24JCAk54ptyT4M0PoSH/05qATQO9RWPGshhdaAa/JN83HrsMLPQQudwIZK5br3z07wOqkoBKHhs2axNgmBY1DPLN1Vzf73OMmsQSmIdCseUxDCPlMjneXo4g3RdexBxCgseSjT03kpmPyiAD+AOIU17/uRl+jP9ukK5OUAt9dEMQl3oXXpD1GteoPFe50FQPnbuA98LiRCjN3AjVILS4APzE9B2zEtmy8ZGGeRtUpTX5eEqrwUa9vVqobv7NWfRvopIfV7hn1AOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(8676002)(2616005)(6512007)(5660300002)(478600001)(54906003)(36756003)(66556008)(316002)(26005)(86362001)(6486002)(44832011)(6916009)(6666004)(66476007)(66946007)(41300700001)(8936002)(31696002)(2906002)(4326008)(53546011)(36916002)(6506007)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZyNDQvSFF6OXpNWjF0OHhhR3F2TDB2QVFETGpzSTdSQlRuVXJzbkFjTHUv?=
 =?utf-8?B?aEMvYTVacnB3WEI4VVZlRVZhZWorLzE0TDlwbHduUDlFNGdUWitHb1ZRejkw?=
 =?utf-8?B?YmE3SUlzMUJ1emR1TVFjSlMrSWZSbERLZjVqWTZiT1IyMVM3bFByNi90SmRP?=
 =?utf-8?B?VjlHb0psSEk4NjlRVDJ5Vmx5aWVCSGc1UDVBaCtpaXo2eGl0ejJWWVhyU0c5?=
 =?utf-8?B?Y205VGRtMitHVmk1ajhmblI0aHBhVGowSUQzV3c3a2F0VE1kak5xcmxpTmJq?=
 =?utf-8?B?QWY4UzVuWFlWQnNaalZXRVRDWlArZG5sT3hkeWZFaWNxQ215WndiT2tEZGF6?=
 =?utf-8?B?bVQ5dHBXMG45aC9YNjk2Y3dOSWtubW5TRVJRZkN6dUl5QmZRaTZWbE9OeEYy?=
 =?utf-8?B?bnpkTTYvMGQ2ZWJjbGRtTE53NldHYmsrNmx4SWNUb29yV0RXRUlBS1E2ZWNO?=
 =?utf-8?B?REdWWHJtYlA1Wjk1d08waWltNG9ZWjhoQ1hOZ3UweUxBQlNmNFF2WVJwbUlQ?=
 =?utf-8?B?eVdjbHA4K3FXVVFhSE9OUW9VSTV5TmhQT2M5NVV3OElyU3lCQkovWi9KN2pJ?=
 =?utf-8?B?elFhMUFzcldaY3QzU0RzNW8xdGdNT2JIN3g1bVczcnB6eFJrSzZXcWNYZnp0?=
 =?utf-8?B?QyttZDE0NzNZUWVxc0s3NWZvaUNHeHFuVEx6bmdUYWNqdmVpOXNya0NEanNP?=
 =?utf-8?B?TExXVGQ3L1h0RXJYMFpkYk1oUWduYlVpVGlKWTBVVzVubmRjaGIzajg0R3FR?=
 =?utf-8?B?dkpXLzQweC9NdU1Pc0ttTENMNUpPUFFvTkU1RDlDc2R3RU1YbW1odUxab2VD?=
 =?utf-8?B?cGJKOVhPS0k2YWM3aU1lSEpTMnQvTS9KUlZYRExLS3FEdnIzWmlqTUovbisx?=
 =?utf-8?B?dFNKVlpaZkFNcklTZUtnM2dIQ2l0SUJXR05DNjhkdlZrNWo2RERIYVZVNWI5?=
 =?utf-8?B?b2NDdEtUR1lFZy9ZcDlYdUJTSzZaWWx6Z0U1b21NYjlEcUFUTXAxaU1PTXRZ?=
 =?utf-8?B?clhzUTdXaSszUkRFMjVaNXFXeDdSUUZ4MUZQWjFscXhwMWltcXhkL2hVVXlx?=
 =?utf-8?B?VmU0R2QzdkNGeDNUUEFMZnBKTTVGdEZOMHNIU2ZOa3FDZ2owVWtzSVppTFYv?=
 =?utf-8?B?NTdmNllhK2NYT0NlbEszcVQzd2VDTTgycVB4Y1M5Rzh3dFg2VnlrTzFxQlRW?=
 =?utf-8?B?RmdYTXNzeGhsNlFOZTQ5bjlyd0h0SlBrL1FVUE5STDhCRGxMaE1FM2JyLzhY?=
 =?utf-8?B?c0JBb0RZU2tBeW9IV2tzei9OdjNWcjNLYmxKaHU3NVlHNUpaOXNNTVNPczBO?=
 =?utf-8?B?eXU0WGgvOG1wM0dqb0F2MVQwYzBOUnc0blB3WTc0SFRIZGVwWlBLSWdldlhy?=
 =?utf-8?B?NWZiMTdTTEx6N3djOGwycFFMMXpCYkxxL0Nxa0V4dkJtMFM4TDVRelBOc0Jp?=
 =?utf-8?B?NHp2ODZHZWpNRVJsalVxN1JESHRlejdXNVlpMjAvRkhncUUyMU16aE9nQjJ5?=
 =?utf-8?B?VnBWN0FoaHFHenMxc29Lamd6Wnh6SzAvWGFITCtpUTB2dS9SeEp0WklHQXV1?=
 =?utf-8?B?YjFaQm1OK25MRll6YUZ3Wmo1N1QzRDB0YndpZ29kMFRmeVljbytnbmx5Qzh1?=
 =?utf-8?B?QVoxRDk5MDU4Q2JtcU1jd2UwekJjdEwrQkZKaGRpaldMQi9wdU1jNEhWSmZW?=
 =?utf-8?B?THlhSjZJVjhGSnZ5MTlKU1c5TzkzRXR4c1hmeUFDcWFseGNSSCt1bnpNZHE5?=
 =?utf-8?B?L1owNTRuK1R6clVrVlBjcUY3NGJpcEdMemUvYTBBMDd5TVpXZUx3QitQYU94?=
 =?utf-8?B?T0wwSmJmZjJWWUxMTE5VbGhFOE5kQ2FNK2V0VjcwMHlFUWVjRnJKVXFJRW8w?=
 =?utf-8?B?REFiKzlIY2h1N1RsQ3lCR1dlRXpqL1hNY3NsL1lSN1EzQVp6TjNpMEVpNENi?=
 =?utf-8?B?Y2l4bzg4SUU4bXJGRWxyOVN1NWNnUk0rMkhXS1FwbTV1NGlSS1YrTlBUVGVN?=
 =?utf-8?B?N2NSaXdKeUdjWENMZVlYY3JwMG12T0U4QVNacmE4N3h1K0w1YmtMMG13THpL?=
 =?utf-8?B?UXFtdTYxTGxnSWZtakxGbDVJSWVRc0NKZytqRUJaNGR0MWF1Nk83NS91SnY3?=
 =?utf-8?B?N3N2Z2xvLzdKT2dJZ3VrOTNyQlpQVGdzTThmVy9GV0lYaWpRZGZLR0xxOVEy?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DJsGR/UmkFs+k537alfMbBwP0KhzxZWtP74A7+qPvEvNrRxI/liX7ryJjGrBwVJszKvyPsQS9FNPzUlYjANb4mNHroED7LvWF2o1N39BXHchB0F72u+WNDeqjVzr8vR14kjWR9z3DnLd0UyAL3TA0erMOWX7PPldQfnFJ6bEEMTm1tn2WMc86BFN9Z3xovuCMamXL53kOwToOjY1gLMtf8Fl1B6mFQ1DJ30cdpooGb4yeUUolDrM1GvKXrDcOwfD7XE6+ShtqLvsmgnmoMIfvssIr+fb5oGzNU82qvvz7PYFGb+Lok03XBC7yXUE2e541DQ1QRQVtqe2o+56msI0B+o6X/uP5Xxz1OFinjgEBAGrnChyeh9GwPrlzHkPO4xK0XTq4JmyqQ/wGn+jv0k/QTb1ZHO9YpqZXqySDUF0VOved2YsXd6sQefG2/+2oQ/GYGE1XYdU9zJDa5YvJ1rCwY60ticoYbclzxKM1c97feC6gpqaqgp/RBS8x1yfy5rWRFBgFoRBkSZlBRmOKUJfA5kRlsThnE9Sc7c3Oj/GMKWYM/kJLSrVDkzOSsECMy36hcYYldCr2g4xO3wqaN+K+ejPun43Im0ljAt2nXeGn2p1K5IlsZ2NIs0eosN9gjR35BXg76n+iX8gOBMu3mJxAcbVjskgSCuK86bEwWw/BVALxOvLcFFWYQ3m4VBz/8Ulm3eaAFRzeq3oPjbpUFBhWyPveDNNA1FIoec09X0cUPsOycG3mg9kMxLD3jjeUJ+dIHw0tfdsYKcaraOnblAnOgMw/sFjXzd8wv7yBs8zPhM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe97c55-bcb3-4c2d-7f37-08dbd0028181
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:48:58.5996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB/r/QY8gG3smWpt9opqUxsaQ9NqA57nkVLK3Jc+hNGernNQwU72K7QYQ701dZZQ6eX8itwh1b063KQaHfK1DhP9Sxt77WYV0GsWyYu3hF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_15,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180146
X-Proofpoint-ORIG-GUID: D4tgEFqClo9sh9bHHWoVP1rrHt7zYOG-
X-Proofpoint-GUID: D4tgEFqClo9sh9bHHWoVP1rrHt7zYOG-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 10/18/2023 9:59 AM, Steven Sistare wrote:
> On 10/18/2023 9:53 AM, Juan Quintela wrote:
>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
>>> reason.  This allows migration to own the Error object, so that if
>>> an error occurs in migrate_add_blocker, migration code can free the Error
>>> and clear the client handle, simplifying client code.  It also simplifies
>>> the migrate_del_blocker call site.
>>>
>>> In addition, this is a pre-requisite for a proposed future patch that would
>>> add a mode argument to migration requests to support live update, and
>>> maintain a list of blockers for each mode.  A blocker may apply to a single
>>> mode or to multiple modes, and passing Error** will allow one Error object
>>> to be registered for multiple modes.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
>>> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> Something weird happened with your rebase:
>>
>> (next *|AM 1/1)$ find . -name "*rej"
>> ./block/vpc.c.rej
>> ./block/qcow.c.rej
>> ./block/parallels.c.rej
>> ./block/vdi.c.rej
>> (next *|AM 1/1)$ 
>>
>> trivial to fix, so I did it.
>>
>> queued.
> 
> That's strange, thanks for the fixup!

My mistake, I had rebased to a master that was a few days old, sorry.

I just verified that my other patch, "simplify notifiers", applies cleanly
to the latest master.

- Steve

