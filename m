Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106BAC47CB
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 07:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJnA5-0006lF-Qk; Tue, 27 May 2025 01:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJnA1-0006kl-7B
 for qemu-devel@nongnu.org; Tue, 27 May 2025 01:47:37 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJn9y-0000WG-AI
 for qemu-devel@nongnu.org; Tue, 27 May 2025 01:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748324854; x=1779860854;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KlIa7KM+2fO/CN5wnl9lAdXwUZm/NsjhODQlSiLVa0A=;
 b=j+GuxL/0+GMYOjW1f2H8KRNyM6pKlTbleDY8KRU93OxiWjSZMZeIegEo
 bJ1+tRnJuaVShHZQmL6cmd0AZgxbj2wo1bLVPM2Ttn67Ba0l6gG6utOpG
 3UKGddW9gBA2Huy0BmY++8Msprbzc6chXzAGyD3zCVSlQotq00SlGgJdO
 CtzuMWbhu9tLx14/uBK+uCjqv/rQEpHw2uJ4sI/6Qe7QfhpnP/pJMH1A0
 KWlIS76KsWOgseuopW39PI1JJTmSzyfQq7XZQZXPrHNYa8hAm6oxlstIC
 4u9qeJmx28O8HoIPrG9FzGUCrJ+LPFS1x5wWhyD3pcyDjaLLKXPU0x2Lf Q==;
X-CSE-ConnectionGUID: j0s8Yo7YT6a9n2Kyl6t0Kw==
X-CSE-MsgGUID: mENhtr/4TiKkq1Gzu1mgwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="60549426"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="60549426"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 22:47:28 -0700
X-CSE-ConnectionGUID: Zpo3WXZFSaO4SNVADgcWSQ==
X-CSE-MsgGUID: mYQInqXnR/CFbgSDGDtGlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="147671455"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 22:47:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 22:47:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 22:47:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.81)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 22:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0cmDMyIScDi44RAxhD4/w/gt32IjoG9Zazn2V2F8V0ea3sZvrWnhzgzA098RMy5W9i588wTy0CKQw/YOzQAoTSGsDuEDobqC8OekAngEATsKjTxlAnRRYMXGU1SSTsm5P/5oLS5wLu6IkVseUOsYr8z4HschTLlNHAh1sojDiMEldPQLmBPij8MyqQ+Edqo06jrMWZtXO98S0awgqywUxp6tAhC69Y2zkfp4u+Yj0ClOxr1579CtmiBKMIgICMd+H9+gyxWE+PqwzOSEzVP/xe4t3SYJP8i87stG5lNDo0t1m7e325TCGbXGMuIH4yNwYzyoJbcyqVdTIs5ErEidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWiVOIk3cK55LCrLnfu1sLYiJBOaD5a2K8u1p2zaJFQ=;
 b=yvQwGr6fbIGChj13KxLqEHo60mpnZgSMJPlvkLX6enMRglrNF6DLHdWHmWMsHUVqZUAH9m0XauWMIdVsaAWJhUy88RL/iRxGlrB9hs33XWFGjkhY38bOvC/i924MiXNQImrkBENT3yZgf3P7Icv7TXVFMkb+onSLZ1GuwTo6TwwCSDlo791zGL5zc8TkHpJbHe7yzfGLlwvnIaVh2v0ZPNg4sVihR0Nvjo5UlFE9OxqYdNmzwMytslm7UIskpfLR7VesL4FfHJ69d1M5vCr00YpEPW6+w4gth/e7ROQYh5OQB1UdLMV3d5YXZWhcbweAWFl1nDBSIzJKSQLQFyMu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SA1PR11MB8351.namprd11.prod.outlook.com (2603:10b6:806:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 05:47:23 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 05:47:23 +0000
Message-ID: <cf9a8d77-c80f-459f-8a4b-d8b015418b98@intel.com>
Date: Tue, 27 May 2025 13:47:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] RAMBlock: Make guest_memfd require coordinate
 discard
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-8-chenyi.qiang@intel.com>
 <7af3f5c9-7385-432f-aad6-7c25db2fafe2@redhat.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <7af3f5c9-7385-432f-aad6-7c25db2fafe2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SA1PR11MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c3e4ae-c108-4123-65a9-08dd9ce1f3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SytsVXpBVFFqTnBZdHd1ZkcvdHdockc2VUlrUTJiNW1ldVhVN0cxR0x2cCtz?=
 =?utf-8?B?Uzd3MHdweWp3b015NnI2SFhSKy9RSkF3cjQvMkxZWkV4TnV6b0F2bTM5NFhS?=
 =?utf-8?B?b25STVBRSGhuczBBWFhlQzhSUUh3V1htYk9udTZxT01hc0ZFR2dwYlNXWEts?=
 =?utf-8?B?d1Q4dnU5U0V3d0p1eHJHdUtEWGQ4a2hzK2swTjRKWURiMzcybWxvL0tNSThh?=
 =?utf-8?B?dDJMdTdtckJxTGh1aSs3S0pHL3ZHMTNXMFFKQjFqUjV6dmx6Vlh5djhrNXho?=
 =?utf-8?B?MjRkazhIaUtkWnRwOHJtR1hIVGFxUmkyd3dmVk42MmRBRlNlNXRxbXpaSmhn?=
 =?utf-8?B?QXVDZnI5enhBVGU2bVpsTlhZTXk2TzhXdVNmeEltZStSMUoyaGJIWGJsNnhR?=
 =?utf-8?B?eUJOK0FiK0d5SlZxR1dpVUtLOWRkajZCbE5EeFRvSjgvSW5nZ1UxTnFaLzBQ?=
 =?utf-8?B?R2lpR0NlU0dHQ0FMTVJvM2lXK2t6b1QrcWVwTUVvbEF1Z0V5UlBLejloT3NU?=
 =?utf-8?B?Ump6TXB2S1AxTjlrTTdPWGlzRGYzdXU1dXZ2cHFkWVg5Z2hib1AyOW8yOWY4?=
 =?utf-8?B?YitSNXJQNjFrc3ZUcW4wWmxoQWlWRXZlS0swdkNYcmFBek1IZFRwMUZHTVl1?=
 =?utf-8?B?b3lCS1lRUFpDTG1GWlhGRXlIYmJ2VmRjZGx4bGFwMW5qTGMvNEtIbkZhUWlr?=
 =?utf-8?B?RUJTbDFzTXdmM1JyR2FOblFKYkEvRzl4TDFKV3BuamNpeEZuc1BMTWxOVU5H?=
 =?utf-8?B?aUJFRFhuTjRlYjlKdzBNSFAvMXJwNFlDMVNRTDBaWERrNTNDVVp1QmdXcGNi?=
 =?utf-8?B?cURDaW1xQ3ZRVC9aRHlBeUNUMzNZck12V2xHRzhIN3ZHb0t4UHc4VWNrMmtC?=
 =?utf-8?B?dm52MmFzNEVKdGtFR1FIdnVNZkZsL0l2YU1JN3c0c3hwV2t2L2ozeFVaZFJr?=
 =?utf-8?B?TlN0K0VOSEpUSnBJSXRWRTdwMWlUNzdTTXE4eWk3WUtKeHNaVThrOGxKZm9s?=
 =?utf-8?B?Ykl1VUx3TSt3d21xckxFTkJPaW56TmxHZ21jWGlkN3VJS0ZjZVBnVURqS2lr?=
 =?utf-8?B?VGc4SksyUnQ1TVFkN2pja3k5NGlqamdQbEpQSnFFQ2hyL2RvRHBiWjNiUTVv?=
 =?utf-8?B?SSt0NGlKaUxJVzVTc3UrUVdRT1p2UzhTc1RETkEwOThFbjFYR0lBMk9vc0Nq?=
 =?utf-8?B?VXQ1czZ1djIvdzJiS0hJT0ExNFRRV1VPTjMxT1krS2FSRkRvOC83SXV0bEp6?=
 =?utf-8?B?MGdmZ0k3cnpxRVVNaTZRNWd3SjdOM2lleXNjNWgwU09Zb2ZidnFKdU1qZFhY?=
 =?utf-8?B?VmJBeUNYL2hBc3FjVk1NY1RzeUh3TWRrQWY4aHBCcVJOZU53MG5OOUhnREZq?=
 =?utf-8?B?bTg2Tys0NytkYkR2VkFESTFIZUdpQ1A0OWJpSU04eGRJUGxyZGZ5THg1VnVm?=
 =?utf-8?B?UnZGOG05NmIyUCtHZHc5c05EckxzbVFOcVlEK3ZDNUxBV3BWb2cxT3VkM2dw?=
 =?utf-8?B?VnloZTh3UVAvR0F0L2MzV3NQVXBZOHZuRGdmenIxZ1FwMHBNeGJXWG1NaGxU?=
 =?utf-8?B?dUowaWNtaGl4aXpLUnFiV3hlc2NDVFQ0STNVS1B5TE9pUForQ2VOZW5keW9O?=
 =?utf-8?B?WVJiWngreWg2YlJGcVNGbmVNK1Z4c0U4a3hlSXU3Qi9LRVRmcDlGbEdvVTcy?=
 =?utf-8?B?bEpoODlWYXhzcGxHVXZuWnB6VDhSR1NpOUlQSHoyNUw0T2FibmlLVVp4N2Rw?=
 =?utf-8?B?RjhEYjJYZjI4T1RZV21tUDZQYU5SUHY3TDRxSjNCbDNjeHBQa1hiT0xyV2No?=
 =?utf-8?B?R2tENVBvemRNQ2dqQUFiM2dkOUFSZmIzR2l0ZWJQeVNqQkh3aUpNWXRQMUVs?=
 =?utf-8?B?cFRDWU5MWUJCaWZpNmZIVEpmTFlBcVZEUEdNTWNLcUxobUpxUlV4WFp6ZE90?=
 =?utf-8?Q?kh9hvKYcT0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdlTWpUbllSLzNnSHUwZ2NiZUQwMjBFR2hDc3ljUUk5QmJlV1IyVzJ3QkpX?=
 =?utf-8?B?WE93OWpjVHZkUU81UUJGMy9BcFJyY1V6WVlvTWtBQlhHMXcraFFvcS9OcFlm?=
 =?utf-8?B?OE5wdmtOL0IwdVhlZDA2Nkw3SjZHalhGUWRZdC9CaXV2QjgxSXdCcVRrSndN?=
 =?utf-8?B?S29rOEJheHFsRnNiUHNVUko0WE44RlpvZjVIb1QyVVdHWWZPclVkTWRHTzM3?=
 =?utf-8?B?VEFUNmlTMURxNWFKMWU5TDdKTVFzSVJRODV4bEVaVUlaWDdBQ2RxbGFoek9O?=
 =?utf-8?B?NG01UjI1Nm5jbHE4MExrK25BMlpCSGNVVmZyN2laR1QvbFBJZlV6blJiMWd2?=
 =?utf-8?B?MlJKbFNrWmRjemRXbWtzcVFqdzlWRjhGSkY4cytZdlhaOGFVR21BbTF5QzhE?=
 =?utf-8?B?RmZHeHI2QW5mSVkrR0RuTUNQRUNuY3Z1dVU5Wm5tVUs4L05HUDB5bjdYOC9P?=
 =?utf-8?B?aHRsZklRbWpOcFNldjF5WUVLS1BNMzB1M2EzTW55WjZoeUsxRUVvekkrRkVm?=
 =?utf-8?B?T3lSTk1PdHVRSnUvZ05Yd0tWTUMwVjZES3ZmQzBBVXllYzQ0dnlTZkVqMFRh?=
 =?utf-8?B?cE5wYllGQytBRnJMNFJRYWlBZE9KaTlQTkhYdElDQjlldnlkSVk5VHJpb0No?=
 =?utf-8?B?a0RoRFh6dElHSU9CKzRjeFJBRWJidEtHSnlTaGFtWUptY0xyaDlQQ3B2T0dV?=
 =?utf-8?B?L0t2ODlqKzFqYlYvNXhUSEVjQ1ozOUZNSUs1ZURMdEpjZTJOamY3Wm44Zktr?=
 =?utf-8?B?KzRmNGZETG1hWlpkRkZuaEJzT0xGcW1xVkVVZER3Uk1ZY2pyVEoxRXVjUCtu?=
 =?utf-8?B?YjdtOHhrM3JGVGozSW12aGRFL3pYbXJXUC90TElFTHo2NWJuUk9UbDZEL1VT?=
 =?utf-8?B?V3R1Qytka1d3elJKckpQS25wTlZTRm5FcndqQktRV1dGcHc1aWlwTFpqNDF0?=
 =?utf-8?B?MXZIaGhGT2MwU3RlRStXNHozTnhHZ0YzOEJhdzA2alNFOU8xV3VmakpHMjVi?=
 =?utf-8?B?b0cvSXppN2Ftc1NxL0crNUttbHRLMzg0ZExIQmN4UnhUTTV2cW53R1YzQmp1?=
 =?utf-8?B?VDVDTjV4YzdMRHdEMVl1dkcxSkNucVlBUElmNDZnUHNQSFFHb0Zkb1lBMDRy?=
 =?utf-8?B?ZUpST3FJK29oOUUzU2p0cWM0SjRNa3RONmpDNktieWkwMnZzeWg5djBjTDh0?=
 =?utf-8?B?bFJXMUR2QnZuRVpDQ3pFOGN1MHpqYzZpWWdxWjZHOWp6cjIyUjcvZnVXajRi?=
 =?utf-8?B?ejlrTU15bGNuL0tEMXMxUUVTYmcyS1NGVkwrRUV3N202SVdJZ00yK2ZRZ24r?=
 =?utf-8?B?eUljekpEZHpRT0ZERXB4cHRTaUo4OHhEMHJyL1lONVdKWHNkQzYwVmRhNWk3?=
 =?utf-8?B?SkZmRVAwN04zY2pxYjQ2clE5QmZLUEsyNE5ka3pvL0JQU2w4N0w1NzNjTzhJ?=
 =?utf-8?B?aWlUZXBZR2pFaDBtdVd4ditScXV1V09XS2xYUERwMG1pcUZZMTZicUhSNUMz?=
 =?utf-8?B?dllmZ0EvazZ2L0tBY1AvRG1rUHlqZnp0VnNyVU9NUU1XSUM2K1EzSGpiSzNp?=
 =?utf-8?B?eXVVYVBGZWdaLzc1bEVYdnVvS3krWEI1VkROd2hqV3RmTWhCZ1dYQkRub3Y3?=
 =?utf-8?B?SzJaY3Y2VzJvTis5TXNpZjBkckNPRHQrYkVyMWxpQURHQ2pHTUJta1ZYL3I3?=
 =?utf-8?B?aVlmd2ZnWXhMRStaTVZwUVcyZXE2S1p2dzIvTHU2d2pmSG9CYVQycnlIb21q?=
 =?utf-8?B?YWZyQlh5U1NXblVTMlJ4em1VQWZ5WTBJQWpqMDdRNy9yOVRZWWlNSE5ROFVX?=
 =?utf-8?B?OEhzZlRCcGw0eTJmMXhVMGJha0NMaUVkVmU3azErelM1S3lVVEFaSWtWV2hV?=
 =?utf-8?B?NmovWkVSVU94TEVXb0tpSHVOUmxIVVZSQ2VHLzdvWXQ2UDJ6REVzYUFPdkJL?=
 =?utf-8?B?NFAyRkliT2VKYUtFekx6U2JGUFhWQkk4RkttWUdvZmJ6U0xMWjk0ZjJLTkEx?=
 =?utf-8?B?Uk5pNFJxZlFNSVBCcExlOU1FOWZVVExoYXBtc2xsSDBwc0czdklYNTRmalY1?=
 =?utf-8?B?SWIwZ1F0TmhDUTQ3U2t4eHVHVHc3OGp4cGY4MVcyelBQSmdmSVFobFQ0VHov?=
 =?utf-8?B?TDZIZk1HNUVzWTRUdXVRRWpaZmRvM29uL2hRY0tBYzd0T2kwYUZCRFRjcmw5?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c3e4ae-c108-4123-65a9-08dd9ce1f3de
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 05:47:23.1203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCIoh9TsDJUjl879/4Mqc4LSenSk+OEHafKytwNidY9BzpUtXGrGWpMhu+3l7DP4r1sOvaYEPW64DpNhV68BNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8351
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/26/2025 5:08 PM, David Hildenbrand wrote:
> On 20.05.25 12:28, Chenyi Qiang wrote:
>> As guest_memfd is now managed by RamBlockAttribute with
>> RamDiscardManager, only block uncoordinated discard.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>> Changes in v5:
>>      - Revert to use RamDiscardManager.
>>
>> Changes in v4:
>>      - Modify commit message (RamDiscardManager->PrivateSharedManager).
>>
>> Changes in v3:
>>      - No change.
>>
>> Changes in v2:
>>      - Change the ram_block_discard_require(false) to
>>        ram_block_coordinated_discard_require(false).
>> ---
>>   system/physmem.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index f05f7ff09a..58b7614660 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1916,7 +1916,7 @@ static void ram_block_add(RAMBlock *new_block,
>> Error **errp)
>>           }
>>           assert(new_block->guest_memfd < 0);
>>   -        ret = ram_block_discard_require(true);
>> +        ret = ram_block_coordinated_discard_require(true);
>>           if (ret < 0) {
>>               error_setg_errno(errp, -ret,
>>                                "cannot set up private guest memory:
>> discard currently blocked");
>> @@ -1939,7 +1939,7 @@ static void ram_block_add(RAMBlock *new_block,
>> Error **errp)
>>                * ever develops a need to check for errors.
>>                */
>>               close(new_block->guest_memfd);
>> -            ram_block_discard_require(false);
>> +            ram_block_coordinated_discard_require(false);
>>               qemu_mutex_unlock_ramlist();
>>               goto out_free;
>>           }
>> @@ -2302,7 +2302,7 @@ static void reclaim_ramblock(RAMBlock *block)
>>       if (block->guest_memfd >= 0) {
>>           ram_block_attribute_destroy(block->ram_shared);
>>           close(block->guest_memfd);
>> -        ram_block_discard_require(false);
>> +        ram_block_coordinated_discard_require(false);
>>       }
>>         g_free(block);
> 
> 
> I think this patch should be squashed into the previous one, then the
> story in that single patch is consistent.

I think this patch is a gate to allow device assignment with guest_memfd
and want to make it separately. Can we instead add some commit message
in previous one? like:

"Using guest_memfd with vfio is still blocked via
ram_block_discard_disable()/ram_block_discard_require()."

> 


