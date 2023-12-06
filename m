Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD253807881
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 20:21:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAxQz-0004mE-IT; Wed, 06 Dec 2023 14:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAxQx-0004m3-AD
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 14:19:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAxQv-00009K-4u
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 14:19:47 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EY171030115; Wed, 6 Dec 2023 19:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2BBIqgoKn3u9aYDjtm285LzmBHdxU6W6XWl4QE4b+HE=;
 b=AmESz5AilI0qCrvDY3zPvfeMcqJT0jgQPwztTbM8z45ACrnGd654p3+rq/1/QtwgDcoe
 t/C+yZgG5n3FkqYCJN75w9yHVgsg66bcb7zy1H3cSxkZPaUIjUlGiFfxaK7jgPTebD3j
 FtOzDiUU8RAH1HONscUb/hYPo8/Z+YCvYnRr4VW7JrFb9CpJkmkEK3oZFDACSgP0xR8j
 8BGbhzOW4nF9lXwQ4Ow+HN6gV+v5OeXcbIKUwaRPTm3B/xZwtWH5ZuOFdqrw9rAL6d4y
 ACix7fzecjf5Hq7X8x2kj3ECXg6/xxhnxK57iCRfC6zKb1VVf6hW7XbypOfkqNLsoc+C Rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1gac2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 19:19:42 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6I8AL5032697; Wed, 6 Dec 2023 19:19:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan9met0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 19:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9CzXwZbn57YNpXdPZZCYVQxIluSHfK+UkGBv4qVBArC8qF9v2Zg5vBJViKZMuENKtRV2xfy1kdJP4D2BBLwliBQ3JAK7w8W8ekk/6NJgQJ/NzJyFcmSyICTi56au4983NeLAKnjdvJnmJI4JgDfFFXGuyNXFUgCAJSai5PHmChIA84Nk4Q+y/0F4nOWwbeTHwL9t85Zk5vjSdMPBggcgcFucoR2MdY5SsVyrMi0fJ836hM27HQhi9XSXI2763HJHfXblrxtgga9gn51KQmDX/qgrhPOVahOsHBnzjnO2j2+Oq/J3VPpSe8v+5jiQR6xfAW6MGuByrd51r/g6IIM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BBIqgoKn3u9aYDjtm285LzmBHdxU6W6XWl4QE4b+HE=;
 b=LzoB1e4n1wp2MYKvSL6A3vBKu/bInvux4THhP2HrnivbE3RnxQ2Q1cTmL6sQilVZ7eHC+l8+Hy+e099A2hANYhMkBXdtFzvS0zFWa9ZhoQDEomxzEpdPP09jp//U9DkWAKOR53eDNF50GXE1cD0ZKkcUBE5QBz0nsWsQJ17VST7DIDT90xlzv1HDBM6InGeZAbojupGxrAElfTvCv/VfC+8q2rxz7+rnbhHNBRU/IqoebnybY7D3CaWQd3P6RVAx4BHeM2PzsdYtRK1WMGPe6tCTR1iFSvvZHHLf45OYzpVY9xS62FkOIvAKO74lPU7Hqiu5GlHnszhN85+bHI4yLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BBIqgoKn3u9aYDjtm285LzmBHdxU6W6XWl4QE4b+HE=;
 b=tZb5hrqTPC3OU5E+hm2+KNP46rM7bYJVwGU+Ck6mp36dmaxQjnCDswC+opR6sQ4n/dnbvUiMWLTm67t4H6b9ZXtk+M9++Ax5CfAqb6JAq8XW48MHlQ0b3QOUM/klUxU+F6TzhUQJkYVxSntjg/EQMPs5FbVJwFr3oJlmODYMM2g=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:19:39 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 19:19:39 +0000
Message-ID: <a4ba60ff-be9e-4380-ab91-5b85e690c1d8@oracle.com>
Date: Wed, 6 Dec 2023 14:19:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 02/12] cpus: stop vm in suspended runstate
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
 <2d6e4dec-bb04-46ea-bfa8-7006d8cc6dda@linaro.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2d6e4dec-bb04-46ea-bfa8-7006d8cc6dda@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::24) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA3PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6c4f53-938b-4673-67cb-08dbf6904ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yawzu+DHbxTEaw04NcbzJx44fq8J3I/oFOs2MFnVnzULbTTtLKrAllBhWjo8qYzhLtk94/UEITzK3GnDCM8dZtfkVx+YsrdeWznG2olnWyQAYU/YznK6blx4XoY5WxcRGddIyYbSRTj2hfCYs2Qxoablj6dq4f1kOa9CqnPsz0BXLflk8ITnRRH41AvVOpb7gKq8ea1lAOSXkAkR2Sbpgl05L4yCAVnVWG8K4/Y4wFfzsihowK96Gb9so0Jq9WHw4B+mLhweqhDVDDbZYQ0JPyB4SZMaINYDWAyTL2IHZMnSu8etFYCHQKN/a2rBj4cvkmfQdEQXIARDEokdUGJOV8OSWRJI/FltrvpWGES9qAFGd+icjXIv9OdJHK3wdBQ/DjMEjWDMchusmOJFbKEoflSNlY+feZnUFXF0G86zYKikw6SsXy02sQCVdTMpeItASrVEt0qhrEXqXQeuxszfJDtVW77VHNWKCMGIpD9Qi56mj038LQgInZNgrqEMtRY3dGF7MV+NqCJVVMHzQLsPFekAVWOIdiZVHys1g4AyoZIFdHhLkuKuKYwUS3SQclhiarC0mfEKPRw9OdBUqx4CVU1xxLdAFAQHSJln74zbzXbP8X8Gzk2mI0rznTpe3w+IVGLfnYfnxMQN42gfsJM5lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(36756003)(5660300002)(2906002)(86362001)(31696002)(44832011)(15650500001)(2616005)(36916002)(6506007)(6512007)(53546011)(83380400001)(26005)(6486002)(6666004)(478600001)(38100700002)(31686004)(66946007)(4326008)(8936002)(54906003)(8676002)(316002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJqcGlGMnAzMVl0b2JQaHp0SzZwcnd5dGpBMmp1bUl0OE9PdFExWUpuSzVZ?=
 =?utf-8?B?T1hUZzNOVm9SOElLREo1dyt2dkpUSm4xZk81bzFpemtkRmljMlRjQk5XcjFY?=
 =?utf-8?B?YXVtVE1PQUlvK0pNM1FGbENYcSt0cHFUbXFGOExJUmRVTnJ5dEg5SE5ja2tZ?=
 =?utf-8?B?dnNLRVpYa1J5SE8vQU9Jd2lyTmNPdGI4UlkzOWQ5R2F3L3hqc2JnWFl6OHR3?=
 =?utf-8?B?M3BNbjFURXkvdzRzN3diTnpOVmlhVVZKbVJZRUUzQnZZRHNVU08wUXJkTUNY?=
 =?utf-8?B?ZldrVko4eHpCTWs1Nlc3MCtxcFBWck4zb1ZLNDAyMXJibnBzOEhxaVE3Tkxw?=
 =?utf-8?B?cUt4RnNHL1M5VWJkR2hGUnpTdGE4emZ4b1ZBS2hnR2NZOTd6dlpVTHo0MDNC?=
 =?utf-8?B?aTBCcUlyWVpPZFUvNGFxRXFmMDdCWk9UK1dZRHVsNlRnVmt5YWZ6U2FFUWlJ?=
 =?utf-8?B?elhjRys4NTllYVNjM0Zydnhac1pqbnZyVHdpcTN4dmswVTVPZEdOZjFDWmF5?=
 =?utf-8?B?UU5FbCtOZUlVMDRVMS84YVpBaXUxOUtWRlZSWDhacU5TM21LNkpLdkRjMUtn?=
 =?utf-8?B?M1VTTXpsTDdsN0JuaXJGNWo3Y091eG14M0tpUkxlQk9rb0p6emhreHcyc21M?=
 =?utf-8?B?U2ZhZmpFcWI1aDkvT3dUUm90M0REcjJmOEQ3YndaeFhhV280a2hSM2oyYnIz?=
 =?utf-8?B?dEQzd25rMHAvYkdjV3JWTGFoWDRrMk9DTmY2dXJtQmhhTXk5SWxHbytiVFhT?=
 =?utf-8?B?UU12ZFN0bFhrcmpVYnczQ3FqaVEraGlFN1dxcTAyY2ZBY1dTcGxBK1phK2RS?=
 =?utf-8?B?U21oVzVuNlVVUXZjWTdGSnJzM1BlVEtRY1hGbURmbVpFR05za2xzVDRoTld6?=
 =?utf-8?B?Ym5SQmphRHFMbk9FRjd4OGJiOWtleFQyeWEyb25lVlM0UHNqWDJzR3Jac1lm?=
 =?utf-8?B?UnBqTmxpMWpOcHJ4VFFPVVBzSHgvK09jRkFtVFliOTFiYlVEdXBXVVk0TE9z?=
 =?utf-8?B?QzU5dFZOQlFmVFdSa3BId0JLMHI0UjllM2U4My9YU0QxL2kydndOQ3VDWnFE?=
 =?utf-8?B?eUxCV2NHMjJ0aEROOEhyVCtOaGMzdWpnSWxCVDMyeHVpVzBOM1I2Qi9TMUth?=
 =?utf-8?B?cGNPZVA3b1RETWl0TElOa0hXM2R2MncxZUNKOHRJL04yZkZkWGV5eUppZHFC?=
 =?utf-8?B?R0Viekd6K2wxdWFFbndzNUVDOCs1dUU2NUsyZ0lVdVNUeWhkbjU2NDI1d1NM?=
 =?utf-8?B?eUt3ZmloY2hWWjVmWGxRcENBQXJmZCtBMVZPZ3U4eUFPNnBxdjVNb2FEZDVv?=
 =?utf-8?B?aWprOXV6Qk1VNTJudlNqaGxPRk43WkFXeVFVZEZwZXlmdXJNRFNKUkxoUUY1?=
 =?utf-8?B?OHhmdVlkUUYxTEgwNnp1Qmx5aDJ1REhjUzhQYnlxenFmZ2hqSVVSMFBUdXJR?=
 =?utf-8?B?Q1RIdmlJRno3NlBZL1pXeUdKVkUreHhyNEtuY2hIWGtCTXgxdzBIQXN4NmM1?=
 =?utf-8?B?R0lLVkIrS1d2TWpiR1ZKTnR4WC9POGFXN1R0NktZKzZpQlZ0WU03bWptanNP?=
 =?utf-8?B?RVp6dmlrVXRHNStEb0JTR3FySERBSXZIb0VrMkhUd29vdVpFQy9VQ00wK1VF?=
 =?utf-8?B?VWdTdVJlTlYvNWhiVTFNd2JXK1d0QmFpOVcwWnRqRHB6OFRBY3B6UjZDZGV4?=
 =?utf-8?B?ZWc4dGpmL3ZJdStQWENHSWFmUFovY3ExSm1sWEF4OFhUd3QyVmNSZy94TjJC?=
 =?utf-8?B?dWlTNDBub01ZNXNPa1ZIYmduZTZ3cHpkYlFIN3NpRG41Rk5LZGlEMVJwcDVR?=
 =?utf-8?B?UDY1OXZZck42SklPQ1psQVo1QzJwYVBJT2hxQnlhWlA5TXRhLy9oVjZXVVNq?=
 =?utf-8?B?YkVTSFIySHA3c296UmZIKzNaQ25pMVVLZzU1Z0NRZFNFdTZncnVqZ2wrY1dI?=
 =?utf-8?B?S3ZWci9vd0kvdDd0a3RJR2pyRkhmYS9zeWE3K0hjSXRYRzcvbzVyT3VIREtG?=
 =?utf-8?B?b1RhNFU4cWdIUC9PbzdONHlYQUUrUTQzZ00xaGE1bndZY3NxMUI1bnd0QWVr?=
 =?utf-8?B?Vm5VUS9ZSmlaRVprbWN1TXhvaldiSEdGOFdPaWhkRU5RUWlkdmVRVkNLWXhT?=
 =?utf-8?B?L0tHZE91TDQzVFdMOVF5bzBCQ0ZXdldiaTJ4ZTlIc3prODJHM0dhRlEyS0or?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E/AmrljEZ3O9JJndjB804uen+a8cCYMynZWzsGTk0jzETqRadrgUffwVNuHwdeWWIZuPj+nWYrzK60/ehYdC3DD4YL5aOsK1OPFhxsIfQ3GG+awq3dYntI5iwLqfjAbM0ihxi2dv684ZDcKBruqllMI1UsYTWU4LTeeqWUvk+n9azQ+KecXF3v/lHGWfsrimcmYDzzswpw98p7NRJxjgW4Rh4MuNQqoTO9QtvLWCut7kSa3n4ohJyGMoqncWjJsL5xek757oOsT4Odki+wk+sx4Nq8I7ByNmfcUabcLLsxqST3+ndR2S7uJQwRHP4tffWWZQAJQlJvRJHkE0jdbNKU4l0GdkicB2L4v9KuD+rILWul9xuK/hf42jTsXL3MsD0RVhejOir0osLXrV+cFzCbSvVPWx5Orm7CUWBARkouWxSn6Tva/SoQoHkuZ8MOLpK2az8Dsd2OO12BywgmfUcWCQbigjkDZi7cwv2gM2W+aC1/ULGjCzBZpk0qCpjGe56FJhYwdO92LVhofH1d/lMVwV0WvZAhnl42SsUQj7xNv6YKeh041hs9Gz6dzTD107TNKhApWzKNawiVFmn6gPeQ1k1r6REMYuHt6Wdb0ZyamlrfI93sA60xu0SvRbdnmyKl0x71I5XivMwqzJ/qIvYc3zIla7hoNXZOIMRPTcU/ri3uNzoM7l6BDmrXHWdlgFCWwprVrGZYUHByRRww9Hap8uSz7ZaaTbDz5YVCZkH6sAkMQgTr5l8Dn/T3lqXZvNfnVs/GSx6uHBcWwNJDZvmyrtluP8oRmVTt9oj5ierrVEn8clh+/D1naP82wmvFTk1ZaFfa6O6BjGM2g72IKR7Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6c4f53-938b-4673-67cb-08dbf6904ac5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:19:39.5346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn9hgKJD9FtauE3C7PkyqDH436FdJVMtNKYNjMkKh/OP2KC/kOFI3g54I38hefFO/DUorrHwn5edTGgfVTinWX4XE/g5V2xHhh7/NUmm+uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060141
X-Proofpoint-ORIG-GUID: m46e13j91ZF990t5erF20pEbfpNnrue0
X-Proofpoint-GUID: m46e13j91ZF990t5erF20pEbfpNnrue0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/6/2023 1:45 PM, Philippe Mathieu-Daudé wrote:
> Hi Steve,
> 
> On 6/12/23 18:23, Steve Sistare wrote:
>> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
>> have been paused, but the cpu clock still runs, and runstate notifiers for
>> the transition to stopped have not been called.  This causes problems for
>> live migration.  Stale cpu timers_state is saved to the migration stream,
>> causing time errors in the guest when it wakes from suspend, and state that
>> would have been modified by runstate notifiers is wrong.
>>
>> Modify vm_stop to completely stop the vm if the current state is suspended,
>> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
>> Modify vm_start to restore the suspended state.
>>
>> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
>> cont commands.  For example:
>>
>>      (qemu) info status
>>      VM status: paused (suspended)
>>
>>      (qemu) stop
>>      (qemu) info status
>>      VM status: paused
>>
>>      (qemu) system_wakeup
>>      Error: Unable to wake up: guest is not in suspended state
>>
>>      (qemu) cont
>>      (qemu) info status
>>      VM status: paused (suspended)
>>
>>      (qemu) system_wakeup
>>      (qemu) info status
>>      VM status: running
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   include/sysemu/runstate.h |  5 +++++
>>   qapi/misc.json            | 10 ++++++++--
>>   system/cpus.c             | 23 +++++++++++++++--------
>>   system/runstate.c         |  3 +++
>>   4 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>> index 88a67e2..867e53c 100644
>> --- a/include/sysemu/runstate.h
>> +++ b/include/sysemu/runstate.h
>> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>       return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>   }
>>   +static inline bool runstate_is_live(RunState state)
>> +{
>> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
>> +}
> 
> Not being familiar with (live) migration, from a generic vCPU PoV
> I don't get what "runstate_is_live" means. Can we add a comment
> explaining what this helper is for?

Sure.  "live" means the cpu clock is ticking, and the runstate notifiers think
we are running.  It is everything that is enabled in vm_start except for starting
the vcpus.

> Since this is a migration particular case, maybe we can be verbose
> in vm_resume() and keep runstate_is_live() -- eventually undocumented
> -- in migration/migration.c.

runstate_is_live is about cpu and vm state, not migration state (the "live" is not 
live migration), and is used in multiple places in cpus code and elsewhere, so I would 
like to keep it in runstate.h.  It has a specific meaning, and it is useful to search 
for it to see who handles "liveness", and distinguish it from code that checks the
running and suspended states for other reasons.

- Steve

>  void vm_resume(RunState state)
>  {
>      switch (state) {
>      case RUN_STATE_RUNNING:
>      case RUN_STATE_SUSPENDED:
>          vm_start();
>          break;
>      default:
>          runstate_set(state);
>      }
>  }


