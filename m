Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCD4A09CBE
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 21:58:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWM4j-0002gf-CX; Fri, 10 Jan 2025 15:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWM4c-0002Vh-4e; Fri, 10 Jan 2025 15:57:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWM4a-0008S1-Mh; Fri, 10 Jan 2025 15:57:41 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AKuKtL027626;
 Fri, 10 Jan 2025 20:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Bpmp8wN0AT4Nbj26BiDqzycQMIBwYujIwlFJ7dizpLU=; b=
 ov5b53w7ptY0erCHNFrj6i3tnnYb6Ji+EOsBRSfM1j2qb06OCj6zLQiKRt46q9Hv
 D6BPEJFREmWz/YACwkB9u/cf1d2NcQA+Q+f2sEPFMNhAC4XXWE74oyVk4OY4zWBR
 Vk+1Q2KKR04PZGQMn9Y+ch/UJ6TVRjXbFkf3WGpqc+AUWYedZ4mnMK4lXofUEWMX
 Wxu6BlzzZ0f41AeCsOVToi5JT4L+F0YrGLmpRBA/DYh/xtIGuqG7aYfstvCmYUgL
 MW9FVqNJOHozpu9jgzEJYInA61H82rZKzOlrdMQI5Tb9uT8k7ktBlLXcUiXm02BC
 Gy1dWKIsPTvIkwW90A4XoA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442kcxaahn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 20:57:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AKFrrb022664; Fri, 10 Jan 2025 20:57:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xuecvqdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 20:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9mQdrQKhOsgfUg4J+2aNw1a7WlWDHiEkv3EytZtyEiOf8zPqK/iJ4GSWaPsqJbIYdQiwMihard+b726b9f4XYpaVC+uLoH+2ef/4cUZmK+xOQx7h7yrPmqIuQ/g+2MLpD0mHbLYTi/nz95BY9JOJLYRZF/hBzbJQZ0yGB2Ec9BoxBJDaxsCXJdGkxJXlurfevYqf2esiR3+WxukTpWRzqOUp6DaPt9kIBZ9Xp4a9Hu3EsF4NF7mYmI+wV46n2G6PNMI8LMfJsgMaqA5SORg6WWtrwD5KLcJFDf2P0Fl/n39NA6oddo2Irxy6DfIVGP+RclD561yBFWRxADdHvPmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpmp8wN0AT4Nbj26BiDqzycQMIBwYujIwlFJ7dizpLU=;
 b=mjfY/q+xS2pcw/sSPOUbVlhoyYppUhyzYaMwgVcdgqXPhKTbmUDTChbem4wOI37XyLZMUMAUYDz9ZvhkfItTI7o9aer3xqMikSfsfIvWKLY8KD8YC5C1pOznDOjQXwfKBwgYSj7hf3vEosCujXS58gfRvkCIbhLyoxgkV0+VlyEo5i9+MfskGHtGT4NRNMMnO0Rv+JchueViS4AOawYAXko1exaFhoxBCZLGkBbQ/mrDTXrNBJG3XCGA77Nl4XYX1K6iOk9mB7dohkEc9Us+5WlrPJEzVaN+5QMvRMC2EPryia/fn5laor1Hz9e1zZFO+8YZao6nDPM/MsTLa3Z5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpmp8wN0AT4Nbj26BiDqzycQMIBwYujIwlFJ7dizpLU=;
 b=mBbtMaYgWhV6J3L2R5g3sEc15+e6BVA7lZZl8/ES9Dss6po6RrhZAujPzj0lKIbk4Gk1c1PtvHAfuHKPBPkA0vZDmG/RZM5k9jePT/pms/YxYestr3+xMmOpJZKN+UEENIiIDwW5EwxmVf0wQBsFHw/fyKf59F0lWnryTOcIluM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 20:57:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 20:57:30 +0000
Message-ID: <fe018270-5c2f-4b13-9254-aa047fc48ccd@oracle.com>
Date: Fri, 10 Jan 2025 21:57:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] system/physmem: Memory settings applied on remap
 notification
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
 <20241214134555.440097-8-william.roche@oracle.com>
 <e13ddad7-77cf-489b-9e32-d336edb01c85@redhat.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <e13ddad7-77cf-489b-9e32-d336edb01c85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a72a1e8-7f54-4288-7c5e-08dd31b965aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVZLYUE5aXRwbDdlSDlpN08ySVZPdGgxL0RvMm85d3JpR1FQenArekx1ZHdq?=
 =?utf-8?B?WHp4Ny8ybXV4TTYxY3VzM2gyUGlGTERvYi90SVRXc0N0QXdJcVhadUU3bndt?=
 =?utf-8?B?cEQ3Z0x3Z2JRWXB6djVjMGR6UXIvR1grL3o4eXlVZlJzMS9jbi9UZUdlcy94?=
 =?utf-8?B?d2Mxcy95S09SbDN0NXhNTTgvOVpzVnJQamhLUEJFTHhaVkUwbE9SZjlKZlhv?=
 =?utf-8?B?NngvRmd3ajdCOUF5bGorTFg5Y1pLMHZ3T2JqbmhWV3IzOWQ5ZWlKWkRIUHZW?=
 =?utf-8?B?dU5WL2tFcU1RbHQyRG5VS056VnhvL0huR2JmLzYyNlhqZXB6NVFqTWZWZmRE?=
 =?utf-8?B?ZTlHNUJFZlRIQko5cEsrWDV0dlZhaUJ6Q2JBS1FCT3NjQW9sUEM5OHhlZ2xL?=
 =?utf-8?B?SFZsOWV6bG1JL0hVUEdGQThUcElJKzIwMEgzbzNvOGIvQVB6NXVIK3ZWc0c4?=
 =?utf-8?B?NWMxY1kyczE1ZFdSMUlmZVYzeUluQzVQZDV5aWx6cG1iSWxiWWg0ZTRpNjAz?=
 =?utf-8?B?eVBDVFFpK2J5VGhMS2pQT1J5N0tRSEtGWlA4TTFNR2tWT01yNWdkQVN3Tzdu?=
 =?utf-8?B?UjdHVHI5SW81bGFLS04wQkdwMFRvbXR1cU9ISllOZytlWklac1gwOXFtK1hT?=
 =?utf-8?B?SDRXYzQvQ1NkaHZCb2t0Qm15ekxqVGNGWkxoQkEyOFBDaW1BZ3VTdG9RM1dH?=
 =?utf-8?B?NEc1Q3ZwNm5GeDhySWF4ZG9SODIrQWZjSHBjdDQrVzk1cVpHUTZ5enNzcDVx?=
 =?utf-8?B?dUZTUWZvNldiMXRVWWZhOGZaekpGUU9sMHVZcld4NGJ0RjFia3JNQ2czUDBs?=
 =?utf-8?B?VENDMmNTN0ZVSFRWbkNGR3NQMStsVkRXUmN3VnREM3oxSUNUOHk5NjBCMy9I?=
 =?utf-8?B?SGFlYnloZjllN3RHbU5rSXB5emN3QjI0UFFINGdyTDZSR0RPeEVKVnJDRXFK?=
 =?utf-8?B?VW5uSng5L01LRWZiWkd0VW5oa2Izc1pyV0pyT0traXlpL1JwOGN1ZGJPdzdC?=
 =?utf-8?B?eHh5aDNndmxoUlo3WEVpQjkrU3RLVkJMSHpYQ3d1eEtDellVeTgwVUlTMUNV?=
 =?utf-8?B?WDlXK1BJQSs0OThLaGJMSERGT2RmSGdnaElEMUlJYUxDZWs3MnNta2xZakF0?=
 =?utf-8?B?TUtEOVFNRXRpTXJhcytBRHVGdEU4eG0yenFLL0VteXgyRnRncUxiQTUxdGtV?=
 =?utf-8?B?dVhldjgyaE5oWXNpWWhISFVwZFgwQWZscjRJQzhpaHhYakp5THFmbExwLzg3?=
 =?utf-8?B?K2lxSmI2NjRyRUpzOVdveGxRbnBZVjJGQitSUDBLOUI3b0RSNnJ5NHRZYjBL?=
 =?utf-8?B?WURNU3NMUnc4ZWFvMlNuV1paRnRVY0ZqNytnblJzZjFVQVlrdm9rZ3VDK1hS?=
 =?utf-8?B?WTFOYlU4MVdEUTJ3VjNiYWdOanNJVGt6ZzVjMUs2bVJwU01uZG5ZbCt1U0pa?=
 =?utf-8?B?L0U1eU4wMTYwQ0s3dm50RWRyMHVEZ05HZjZyaVRQUzY3dE9LOWZOWHEvd0ZF?=
 =?utf-8?B?UHBHQXYxd2lPbWpyNGwrRDd1SG5TZWpyNnE3bTNyRzg1MVIvdTlkVnJSVStY?=
 =?utf-8?B?TWFrWjRreW5WU1RtUkJ2WmU4cTlCbzFtNERXWjg5cUZiY3NjTUFxS2h2eG42?=
 =?utf-8?B?MWVqU3F0R1RXWHRzeVZaNGd2QVpZS3VERzMvcWE4M2pTWGoxSm9yMnZ2b0VC?=
 =?utf-8?B?eUliaWxpeVUreldWOXArTWhWUUVuZTdjODVXYm5zQ2xxWXNRNjhodDBoNG53?=
 =?utf-8?B?NEpKQnl1OHVkdUs0N2VtN28yV1h4d2VwNnA2QzBnanBreE01S3VuZ0tza3BH?=
 =?utf-8?B?aHJiR01Gd3FiYTAvSmJKelFueitCTnlGVTdSMkVjSUZvQUNyaU9xai9QUC9L?=
 =?utf-8?Q?fqgoNRMKrAB0N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW51SUUvVHUxTmZQOGkvOWhmOWI3R1BLY3QwTUtEMTdQU2NJZkp6NTBCVnRL?=
 =?utf-8?B?Uy8welgyU0lkQjluK01odGlmT0Jnd3FrT3ZLY0o0M3NBbFdIYXorMmFZZkJB?=
 =?utf-8?B?YVIvTUNRR3hIUGpXWG5IQ09BTGwyM2l6UEZueWVabEFqdktsSDVZTld3Yk5K?=
 =?utf-8?B?NGRON2dOQjF5WjJhUzNoWm5vQWR6NkM0RnpBdW9tM3pudXBTTU9Oc3NWYkJ2?=
 =?utf-8?B?VVNWbjB2L0NaU1BjdDN2MXhPV2RiZzRvQ1NBbFlQTFNZVVNyS1VIYlQ0akIx?=
 =?utf-8?B?RnNieE9YcUVkSWorUTJjaTFNTHozcjlKZnpEd3ErL0VRVEZOcm9idmN0TUhK?=
 =?utf-8?B?MDF1MU13TjQ2ck9mTkRhd0hJM0pQYUJBblJ3aFlFMSsrbFFlelA3aG43dk5m?=
 =?utf-8?B?U3ZUQXJsaEV6dzlYMFpSeWpjWXlpeEtmT29Sc1hGUU5pWGovVmNzT0ZPanhP?=
 =?utf-8?B?VkQ0REJXaHZJb0NCQnpEWXU3aFdFbVl4Rmc4RmxFaURoUmRvajVTdndaYW9v?=
 =?utf-8?B?YnQ4N3lCSnN0aTUwN3RZM3cxc0ZrNSt4Sjk3K2htbGtzeWZ5RkY0a0xBeFV0?=
 =?utf-8?B?TmlmOVpOM2tTYVhia3h4ek1xaW9mOXYycjlFeCtvMElRWkkrNW96UzZNYlZp?=
 =?utf-8?B?QXVUc210L1JBZ1A1djdRZHZHT2FIYkE3SFZLRzZPZDc3V2trbFM1L2xnczEz?=
 =?utf-8?B?cFpIZ1pJN00wWTRwaDJnLzlhWFJxZ2VaNDl1OXRzdlBJMmRNdTk0eEJwK09t?=
 =?utf-8?B?NzkrS2twNnlFdGJJb2NKUDNTM2VCMEVlL1BXTnVzMEE2YWZCMXQyQjhhelhr?=
 =?utf-8?B?ZElxc0NXR1prYnc2RzhjZnZORGQwcms3dlN2MnNITndVNFZCejdmaUlzbjQx?=
 =?utf-8?B?S2dueWZJMjNkUGMyKytPNlg3aFVKNUVkdkpoUkxNSDhZRTJiWU53UmhWV0l5?=
 =?utf-8?B?WDJSMlhRNFZzN0lVaU1HQjRFZkw3RVJPQmx5M2hodmo5cXpFNldtcDB2bUJ1?=
 =?utf-8?B?UnYrV1VvVHcweFhORnRicWNEUVBzOE1pdDVGTTk5dnpjQS9uYkU2elNpZnZa?=
 =?utf-8?B?WWRwTjU4TE1JZExBZDRXSzl2NDV4aXJRejhRTkRvL0R3WDFFckpINlNyOS8y?=
 =?utf-8?B?ZDVtV0daOVBwMDIyYnJQNElQbmNlRDU5WWNxRTYwcFR6SFBFN05NRHNDZUc1?=
 =?utf-8?B?YVdTRFI5VnBucGlhcm9XU0N4bVJpak1BQjB2Y2lBQ2RMZ2YxREFXU2JYaVlZ?=
 =?utf-8?B?K2JTenRaMFhwdXpwVVhDTHUweTFxQ1p5NW9EcEZ0RUhJS0lNR0l5azhIUERV?=
 =?utf-8?B?WCs4Q0dIczdsNnRlSUtKdXlyQW8zQmJMYnVOZE9zNG5zNEpHSlZQZjkyTC8z?=
 =?utf-8?B?QnI2MVFyVjVlMm9neE1ORHhKNFpwcXQza25LbjV2R3VpdVVneXd1cjU3QmRj?=
 =?utf-8?B?bFUwbXlaeWovZWhtMTdXR1pzY0dCMUNwaFUxS1o4N0dyWXB6VmdISWNRckVI?=
 =?utf-8?B?ZXBWdmtEeHBSNWI4TTVkelFUUVI1eFRteVozckxBSnZWQ2syb0FJU0xDd1hP?=
 =?utf-8?B?V1BOQ3N2QnhiSlJDeUZYbC9xUmg5RXdwTS90TVo2YXNLQS9pUzRvV0s2akJh?=
 =?utf-8?B?WEZIZkMzMStxZVpHQXZjdEpyYUJOd0gvaFZaVnVlRTBQMktuRXJaMGdlZFFw?=
 =?utf-8?B?aW9paEVpWDRsTThaRmdmNVZJb3VoTkZRMXVKVHVaMFVOS1ZodE4yYXhIL1FH?=
 =?utf-8?B?bEtCaStmS2hTNnhlUUdLOEVXVGM0YXFaWEtRdDg3cE1aUG8xSkdrTDVXS1VU?=
 =?utf-8?B?cng1VHRXeFhyMUx6OTdjSCtjanlSSEJlOWJYc2tQMks1SEdNemFJVHhrRTdP?=
 =?utf-8?B?dlNXTUZ5VFRqTTlkcExRdjlZY3BVMHV1QUNBdUViNHVnZWNHQmhybzNnS3BY?=
 =?utf-8?B?TFFIai85Qzh2VnprQld2VUNLZzVUMTlVTEw2ZTg4ck9CSFZTOWJ1TS9xZGIy?=
 =?utf-8?B?dG1XbjdyMFV2SDJVMFVKV2Q4bUpxcHVZSjBjc3pWYU1GVU5QN1M1WVcwOUps?=
 =?utf-8?B?WXhuK0N2OHk0eWZMZVJ0bGo5aCtFYkFlZHZVbGpLWFJ4dk16OFlxR1JxZTg2?=
 =?utf-8?B?cTNGN256SXY4TUpHaFBqVGJWWGxQWE9lVWRtYnlyQTFqRnVBZWpDaXl3TEhk?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NFAtcJIKT4y7Jww3sTZOGnAjrVMNtFy/Z6aV99xGHK/9LQnQu1p6TG1r+Ql4iLqYUcemoatKVFHIUHr7jVz21bFCzCxdAev623S/FpSDdbbtdhdg3Ax4BW7eFJ1EEaWw8O/21VFKw/capuRKDYc8cihwG7yErIbnyhDRSTAEULOMTZyqU2pPihgHkvgKfV9nKsqfsGSNTGO5Vy8OGbrotV28EcKRo8yOL0gTH8VXEVUObnmgc8J6mFhJGg6t3l9qFN400sVgRqxDwTBHtJMvyCn9sLYi9Sseyr6alXJEhkTeHZnxLeQIgyR8MymLob4DNzCDse5xLNEg15rS1yrUFh7OlUemp2jlZTN5bBLa8gf7nFkIOVCH4mVHCNOurJ1082Lbqo78tsI/AwCLNxBuEyRrDNAlLXskCgVFHBXoCVkntPwl6O3o2Eig8+8GBYl24WHtTw6gJqAslvVy/CTaXvrgbNn+vAZ3vnXBbtO5i3xW4d7jVDyF/hJNaVQpFLmC9hB2bM+dC02CKSSQ7wrXB2oz1cVUhlzTkKoPmJSpj/ncAbgv1mF2DDgmzTcFZUPmATyWZKIhA74dbqrEMxQumnI1pDC8Hnq6/n4r7Ecu1wU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a72a1e8-7f54-4288-7c5e-08dd31b965aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:57:30.2110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nn8kcweIaBP62rxG6wP6zeHZRp3lRyLBMHEzCzot+olzs77eapZC3HmA/OXRXAgpfTqYnDiUORMhKm5LLVUjKmpaiLY+iMtiZ6sDOsIQYEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100161
X-Proofpoint-ORIG-GUID: 3LkekUeqj55-MXMiK3vcaD0kaVNzGT59
X-Proofpoint-GUID: 3LkekUeqj55-MXMiK3vcaD0kaVNzGT59
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/8/25 22:53, David Hildenbrand wrote:
> On 14.12.24 14:45, “William Roche wrote:
>> From: William Roche <william.roche@oracle.com>
>>
>> Merging and dump settings are handled by the remap notification
>> in addition to memory policy and preallocation.
>>
>> Signed-off-by: William Roche <william.roche@oracle.com>
>> ---
>>   system/physmem.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 9fc74a5699..c0bfa20efc 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2242,8 +2242,6 @@ void qemu_ram_remap(ram_addr_t addr)
>>                       }
>>                       qemu_ram_remap_mmap(block, vaddr, page_size, 
>> offset);
>>                   }
>> -                memory_try_enable_merging(vaddr, page_size);
>> -                qemu_ram_setup_dump(vaddr, page_size);
>>                   ram_block_notify_remap(block->host, offset, page_size);
>>               }
> 
> Ah yes, indeed.

I also merged this patch 7/7 [system/physmem: Memory settings applied on 
remap notification] into your patch 6/7 [hostmem: Handle remapping of 
RAM], removing also the unneeded vaddr.

So now we are down to 6 patches  (unless you want me to integrate the 
fix for ram_block_discard_range() I talked about for patch 2/7)

I'm sending my version v5 now.


