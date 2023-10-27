Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8F37DA34A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 00:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwVA2-0000DK-1w; Fri, 27 Oct 2023 18:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qwV9x-0000Ct-3C
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 18:18:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qwV9u-0004rq-6f
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 18:18:28 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39RLnIYv010560; Fri, 27 Oct 2023 22:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+KywMXB2DpsH3+b0V41O2us/9sDXyTi55wAiPNuee9o=;
 b=CR2ONxAxmsEDRNcVZaxMrcFcWQ9gHCUQEdMTngnRnCH9m9me+QZVhyXuvntvimnCZ/Y/
 ykvoaGgyo0YRK8yDdvUyrkw/s3znayaVSSjltexkUsqCm7jda/JohJePEmdACb7wUeDa
 GY9PVCMhrHfRlqIYX0ezVo8YPVArh3kMQRL6wSDcrt2bcnZ2l31ax3DPFD7RMiXjg4zS
 MJOnmnDbQeQ/eg89B60jgQssFL4uh0b3z4RZCue6EborwuMfp1TANhULly1uf2bbn7RW
 tM3RjmmbKreD5fQA85TJD5D0yiNqoJ5ICoCv+avTuswBaz3LAwUPvF/8rbbj7d3Z/fsN yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx4tjg5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Oct 2023 22:18:22 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39RMBqZF022929; Fri, 27 Oct 2023 22:18:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqk2dhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Oct 2023 22:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9dmif/hbwygFG+VY8mdFBzyxcoQYlOECj57FHVvB0y8+VXpHFJ5AUyi3B6plTQKyVNLby//sgsxOfNrX3LS+E5tM+9mzMdddgTzUBFc3361ydlgNpuOjjjsLYAIJRU4OPGIofnwt7NvqgegfA7yeDn5+bQe6DxaZq3Ph81mUnebfNnGwo7rfFCuvKMoX0u2/IWPOfCEswG1ibSCUVwaiy6t1P8KZLa0IWu3+iR+ONPBAF7rLCTQ0uqjhRHEJbxkO/zJ/pgbxMBcTRdpfythKS65krAQBc6tKT09deSgKFLTmFxs3c0VGTGS46VmgBPaS2WV1ce2FZ2XU1T0wTXu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KywMXB2DpsH3+b0V41O2us/9sDXyTi55wAiPNuee9o=;
 b=RUVCWiwt/VDt036OQKxO7RUAhbOf7c5gaWSZEPNkcq4m3ET42CEDqNlbGf+XFLGoGhmSJ2WytZzPQTag3A2mAeH3rXQvriY+V+9GqMRhevd1vc4NNlXL39Nh33xOSXZcQ6jbfrj6DWwWJ6vdD3UaNHNazMBCQxkxlblc6k+rJoUecJ8eyEUmCbDyfrveRmjxI9m3LUxYhwjUVz8XSVwH5JcP1YXjupp44T9daG9LENvYO5rgc04QjGBWjZvU2BO+Q4JqgnlhFJdGLvcePAUh9Wb19JDZ/ezmeSPKlO8mv+0RdvRjHZM/3z3CjvXqhYXKjjqQ5CCx50n+3E3XNZ72Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KywMXB2DpsH3+b0V41O2us/9sDXyTi55wAiPNuee9o=;
 b=Ub4yEDS6Jr5SMS8PA+zIijCJVqa1YVeyVTOrpWUdn8ARxazympVzYTmAoN3KXvoqty0+TxFHw9NcuZMIOThuKaxSWqZU3T0QcJG4AjxeSpcq+3+A3h7/IwdRWPLw2ahjXFcSGgMTZzHYcQ3QbtvKuihWKDiuXp35YwRxu3iXNyE=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 22:17:46 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 22:17:46 +0000
Message-ID: <e6be9230-2f63-4c48-9db4-5eff2c4399eb@oracle.com>
Date: Fri, 27 Oct 2023 23:17:41 +0100
User-Agent: Mozilla Thunderbird
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com> <ZTqb/XDnwhkTUL3s@x1n>
 <ZTqtieZo/VaSscp5@x1n> <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
 <ZTrHAbyDxLsDl007@x1n> <af899e9e-a1b6-4682-ba83-6d0267e46247@oracle.com>
 <ZTvMEqYYVS4KjL0F@x1n>
Content-Language: en-US
In-Reply-To: <ZTvMEqYYVS4KjL0F@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::9) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SA1PR10MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 740a3e60-d694-48b6-cbb3-08dbd73a8bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /R2OJY+ZbGirIfQy7E5GKgG3+4PEohECxuL66D2ShYWEgfmS1jFejyxGpIYgUwkzMeDIx8DBIyVglT76byWpIQ4bTRsAgA4ovd5GUO1mK4PwtqHFygVEZgwWurSLaI5dMfyYD6t33Zc+KBAUs3NO9+gxaedxIA5PYJcE8NQnUd+2Xgg9U5siPx4L0FpZGYo/YFK0/cdspp61pAg4pjzpJqkDRsrj2ADjjguA6aJPlCo7CSbYaOStKetuZSaru7ffZrzyvaxxYtb+UhiVOt3e+Vrd1qPuzXWE9o7tjozpO2aQKLbcv0Ost/RjUwNIfcggLuMyhoDmSNEsYz8a/mfYrehzxs3tHc0wKFCue/5N1vpzJ9D7eTV/mYoULMX4f+f14uDlPwgaOXT3fJRwWbKrd99uXjm/RvBEOnmPX9ThjRnGCbt/grhz1YQZey5+QapKbVHRNTrLixTiKtn1H9Asuz136Qr4N9mdnIXeaaKEl0D8rih3JwoKTzjsm4n5t8oKAF0hW9MaDCi1HGIiEUgoZl6aGZ55mG48XlUFYl3kXSCEo0vqeAIKaI4aimTh6Wwn1PPzV8NUmbTSJdOnF1xGiPyvLsWnW7M/BbSAGztCgDSd3pYGxXXH5/TJX8t19E2Z0GZkc2Vbd+KKv3dLGZEFrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(2906002)(6916009)(316002)(5660300002)(66556008)(26005)(4326008)(41300700001)(8936002)(8676002)(83380400001)(38100700002)(66946007)(6512007)(66476007)(31696002)(36756003)(53546011)(6666004)(2616005)(478600001)(6506007)(54906003)(86362001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VJbkYzU1VSSEVCY3B0NzNjNjYwMXhCblNHaXZ6K0VUbWEwR3JoRjI2M0tX?=
 =?utf-8?B?WXFvcWZVN204U3pLVkZDTEV3VDJ5VndWaTRTOWJPa0RZQndRMDZJYTdidGRI?=
 =?utf-8?B?NUFpT1RWRjlNblNtNTVyRnlYQlpyTTZCdUFhL0w0WS9zM3NHNVg5MWsxbE1m?=
 =?utf-8?B?N0xoL3dURmJxb3VKVmpRdE8yU0ZLSi9TTWsra3BwLzFnOHpTVFczZjhCL21R?=
 =?utf-8?B?S05RQlczNnZ0YlNDR1pRVnNnTVVXemVPYlpTKzZuSkl5N2FJa2NZTTc4LzNa?=
 =?utf-8?B?MEVVdWx2TWdWaXp3djVIcitYUUVTaG0zN29WOW1MbkRsVUhOUkdvR3kyWFYr?=
 =?utf-8?B?MU9CdGhzZDl5TW5SbHNON1hYWUxpNW5IZWZrRE1ZMC82UWZZeVBaLzc0ZHhV?=
 =?utf-8?B?MzR5b3FHWHFMbTUycWpPOWVHRzRObmhiTXZGcDQwQjZjejdUWkdzQ3RHR3FI?=
 =?utf-8?B?bnd3MnJZNzBPOEw2bjVDTkZXNHo3SlV2SmpHOHMrTVhxd0hPUG5uWTYzcHB4?=
 =?utf-8?B?Y1VOZ0hJMldkMUxrNXZ6ZmUyc0Q2UllXa1pVV2d0QlUvMFl5S1htU3RjZFlG?=
 =?utf-8?B?TmFzQUZ0NS8wK0kzVy9RNHhUR2VtS05BS2Rudms1Zm9INUxobVlTNGFqUGc4?=
 =?utf-8?B?Z1FxbjRMaUp5OXJGbFQwWmhXMHhmTWRXcklmcTBQWCtBZmF4TGU3S2JKcURW?=
 =?utf-8?B?NG90L0NCUWhScnVQWHY3QndHNjZxWW9XYjZUaUFxT2hqTVY2QkFBcTFvUno1?=
 =?utf-8?B?aXloaUNOVVBlWExoWVJySjhWRVMyakNka2NVSERmcmI5Zzc5Z2JxZ29TVWF3?=
 =?utf-8?B?aWdZRHY0c0pJY3l0NDArN0ZNY3lmZDVEdG5pa3BabDl5UHA0SWJFNEFhRmpr?=
 =?utf-8?B?VWFydDQ1RWFkM2drSzdLdEZsS3pNQVJKSEd6RGRudUJGVW4zOUVSaWxPQ1g2?=
 =?utf-8?B?eTZabkRQYXUxOFN2Yno5MUlPTE92anRKemh3M3VJZ3lXRmZiam9kRWJhbStH?=
 =?utf-8?B?ZXpINDV0Z2JrS2QzYWxWNUUvUVZTcGF3aVR5SzcrS1YvZ1hzcFpMcDFiK2pt?=
 =?utf-8?B?cjdOQmpIaEF1bHI3dkUwaXBzWkVIMXloZ3ZMZ3o3SjdzTjJTeG9UWlFaYXZ0?=
 =?utf-8?B?a29LT0hSM1Jnck0vTDVaVmU4MExPR3Z1N09PU3lyb2VVcEhGRnFVOVBzQ1Ni?=
 =?utf-8?B?dFVKRjFwbzdjOFIrc0NXR3F0TWZwWlVEVG4rTGtYQnpheTdYdHpjTmZSdTgy?=
 =?utf-8?B?WjF2UHhaTlFCb0VDb2RhejNsenowM2hkdFJUZmNmZzlPLytGS2lTVzE5Y09M?=
 =?utf-8?B?dWZYV2hSQ2xWTnNkQUwrREM3dmlRRVc0bVY3dkZBaFJFdzlaTy9Pc25ic2lZ?=
 =?utf-8?B?cTU1RFV5bnVIR1Y3N3ZlQTF5STlLeXNBV0RHT1o3UENaSUpyRExiNUh4Qk9Y?=
 =?utf-8?B?d3dVczRGaXBjZ3VXb2dyUU1LTFZyZzlDZk9Ycnp6dFZQcUZEZ1dzbWZQeEll?=
 =?utf-8?B?bFlhZU82dzR4eTdLcWhDRjJPSHdJeC9rd283M2NuVExha29vdUdvOFV1T2lw?=
 =?utf-8?B?ZVc1TDdCTDNITUdOaUlpd0FaZDBFS2ZxK1hsN3FpUTl6Y2pUeG9tZm8xdTVj?=
 =?utf-8?B?cUFNemlpS0ZmK29VWWM0dUU2czZWWFF0NHEvV3VYN2l2dzNJSmNtSDZ6YlhW?=
 =?utf-8?B?eGd3YXRKdHptbTNtdTRyWWYxMXNXWHVvdDJobUcrdDZkQWlTVVdHNmxsM3hD?=
 =?utf-8?B?cWllUVJJK1h5NGtNV2pPNTUwaUtobUswQVpEdDNDUmpraTIvTkJnSS9KeG1p?=
 =?utf-8?B?WDhpS0lpMjQ4S1k2Nnk5cFNZaTd4MW9nT2FBYW1zUDd3Q3BYakdjZksvaU1I?=
 =?utf-8?B?N1ljeGVMek1MNHpwb2tkbVcxN09GV0lLQnNzZEZyK0RvQU5JMGRzT2VVOFhI?=
 =?utf-8?B?VVBUQzAwWXJYaGJOellVK2o3MUxVR1VmdHozQ0xTWmF5NXRWVGZKcXlZSHRS?=
 =?utf-8?B?QzF4YUwrOEtGVDBsVWNtOFkzZDFDL1NPNTYrUHFUcGRsS2ZpaHBRdTh1TVBy?=
 =?utf-8?B?MTdFM1VXWWI0Sm9uTzRmOVNCRUhHcG5ta0NsQmN1Ukc0a08wUEJ4SGxZUXRR?=
 =?utf-8?B?RWhsOVZnS2tKRXZOYjlBRHdqWW5Va2ZjSU1maVRTZStrbVFKL1hZWFNiZlpn?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tihVMJ8hZfN5INyfcOE8pQqAoX0CrS543IdnyQCv+YKBQK0nXss1O2//81yO9rtMbdFnvL/VptpyaNHCbVttPgVLsLcZAsHOaIdD27CQDrlBcKnNdy/8odiNF7ZgdGFVmj+N4gsCxBjruxlxo5VaOI1jh84sHiQGFC8/90wsxJS7Tf269nw6yVTi7oDjookfXIpZoIpc1gucskAEg0HdSymMjt53bd98xdQiHme8LypXoLHJ2of68Rpk46GqCagoWUgYwSkik+Z3TLVnrhGc9N10Tea+j6LEjYaICpe0HYLzllekp03MIpPTXvF2GmAeryCYVGVNqzpQ8Y+wAN9XGAqspIRpiW9tzSolLmbGUfe+5msPJ8XPFfQgN/30ZX9C7ee54lgtVZuIzvTdRPD9bmBddfPkMlixP4ZykMDMZyGignxGutDaloBhY1RQ6QcYeNIEMgiRYf6ym0ZIFyzw92T6cbbtJlt2aOFWJvyI2z4xubXNnUomxbLmb2pfZZUSSBK8NnKm1VpYKKUPkrvuOYVXroB9ZDREh2VQ9+sIQPZ07ENg4G5T/MWGLOOpYWzj0MeaWVZI8dDmbKK5uQQW8ihYEmLUTU4SnLoC3ngHdmpnLKWXArMS6fOqR1vKp+pm7/4nQtx9Nxd9JB2eakpJFN1ZNy9vTFGA0d+pcPYAPuEfyUjLt5sBWif8n9GRdWLbixKEtH7bDsogLwxRS+Kb9AnjMqHzeWIs1edKbB4L/h9Zx4H5x/1uRkBRqJUriK/KtwqKDG0Zrn7y8NiDWQSBI2PN+l76DRqJ8+7bPES2qGZnTSyt5n0/vjPp7uMTf7pX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740a3e60-d694-48b6-cbb3-08dbd73a8bd8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:17:45.9838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKDyxt5qCsnY+vMTEBmnHpphi3VkAowhRtr3J8Yc0hhilWIR36M3HW5DZuCOCcJBsbJhBImfu3+eyXYQsZ6N/iKi6CUIlcX+OPhggZuV9og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_21,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270192
X-Proofpoint-GUID: 2j0XAtF6YttbxKAQCEZCrHOl3_07X5FX
X-Proofpoint-ORIG-GUID: 2j0XAtF6YttbxKAQCEZCrHOl3_07X5FX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 27/10/2023 15:41, Peter Xu wrote:
> On Fri, Oct 27, 2023 at 09:58:03AM +0100, Joao Martins wrote:
>> On 26/10/2023 21:07, Peter Xu wrote:
>>> On Thu, Oct 26, 2023 at 08:33:13PM +0100, Joao Martins wrote:
>>>> Sure. For the fourth patch, feel free to add Suggested-by and/or a Link,
>>>> considering it started on the other patches (if you also agree it is right). The
>>>> patches ofc are enterily different, but at least I like to believe the ideas
>>>> initially presented and then subsequently improved are what lead to the downtime
>>>> observability improvements in this series.
>>>
>>> Sure, I'll add that.
>>>
>>> If you like, I would be definitely happy to have Co-developed-by: with you,
>>> if you agree. 
>>
>> Oh, that's great, thanks!
> 
> Great!  I apologize on not asking already before a formal patch is post.
> 
>>
>>> I just don't know whether that addressed all your need, and
>>> I need some patch like that for our builds.
>>
>> I think it achieves the same as the other series. Or rather it re-implements it
>> but with less compromise on QAPI and made the tracepoints more 'generic' to even
>> other usecases and less specific to the 'checkpoint breakdown'. Which makes the
>> implementation simpler (like we don't need that array storing the checkpoint
>> timestamps) given that it's just tracing and not for QAPI.
> 
> Yes.  Please also feel free to have a closer look on the exact checkpoints
> in that patch.  I just want to make sure that'll be able to service the
> same as the patch you proposed, but with tracepoints, and I don't miss
> anything important.
> 
> The dest checkpoints are all new, I hope I nailed them all right as we
> would expect.
> 
Yeah, it looks like so; but I am no master of postcopy so I don't have quite the
cirurgical eye there.

Perhaps for the loadvm side, 'precopy-bh-enter' suggests some ambiguity (given
that precopy happens on both source and destination?). Perhaps being explicit in
either incoming-bh-enter? or even prefix checkpoint names by 'source' on source
side for example to distinguish?

> For src checkpoints, IIRC your patch explicitly tracked return path closing
> while patch 4 only made it just part of final enclosure; the 4th checkpoint
> is after non-iterable sent, until 5th to be the last "downtime-end". It can
> cover more than "return path close":
> 
>     qemu_savevm_state_complete_precopy_non_iterable <--- 4th checkpoint
>     qemu_fflush (after non-iterable sent)
>     close_return_path_on_source
>     cpu_throttle_stop
>     qemu_mutex_lock_iothread
>     migration_downtime_end                          <---- 5th checkpoint
> 
> If you see fit or necessary, I can, for example, also add one more
> checkpoint right after close return path.  I just didn't know whether it's
> your intention to explicitly check that point.  Just let me know if so.
> 
It was put there because it was a simple catch-all from the source PoV on how
much the destination is taking. Of course bearing in mind that without
return-path then such metric/tracepoint is not available. On the other hand, with
migration_downtime_end I think we have the equivalent in that resume checkpoint.
So we just need to make the diff between that and the non-iterable and I think
we have the same things as I was looking for (even more I would say).

> Also on whether you prefer to keep a timestamp in the tracepoint itself;
> I only use either "log" or "dtrace"+qemu-trace-stap for tracing: both of
> them contain timestamps already.  But I can also add the timestamps
> (offseted by downtime_start) if you prefer.
> 
Perhaps it is easy to wrap the checkpoint tracepoint in its own function to
allow extension of something else e.g. add the timestamp (or any other data into
the checkpoints) or do something in a particular checkpoint of the migration.
The timing function from qemu would give qemu own idea of time (directly
correlable with the downtime metric that applications consume) which would be
more consistent? though I am at too minds on this whether to rely on tracing
stamps or align with what's provided to applications.

> I plan to repost before early next week (want to catch the train for 8.2,
> if it works out), so it'll be great to collect all your feedback and amend
> that before the repost.
> 
>>
>> Though while it puts more work over developing new tracing tooling for users, I
>> think it's a good start towards downtime breakdown "clearity" without trading
>> off maintenance.
> 
> Thanks,
> 

