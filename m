Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E45AE1171
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 04:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSRtt-0005Tv-72; Thu, 19 Jun 2025 22:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uSRtq-0005Tb-Mv
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 22:54:42 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uSRto-0001Dv-9e
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 22:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750388080; x=1781924080;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cvl1Mho8hgTxdRMnfdatQDTc5W/BOeLBpUKjg3Y4bVM=;
 b=D2LxpaEbTtvQ+ncYbyMlwIxLr8JL6ZmdhnfajhOO6SAzzzPKYO34QghP
 /nQutKZLmSPfckSCtxnyjXGGOg2OPkvsAuvNPmPXCEJZxhGlyXMmWFxS8
 R9G0F/D8Ebl8UffpOmXBncu8CnpJdo8r4253hO75h/BijtBchI28wN5xh
 ChtPVSayS+IDpjRokTi8esJxAsDudcC8DB4LKo5rR2+CXwNoAeoYMaS4e
 YLGDtB0zAlABLqUmB6aTZgNjbey4w19Rl77Pzl0oQ+XMAxuiOOR13Y5eq
 mRnFJJig34ka9jLJdtTvDGZyE1fzpmfuFjpr86m5AOKXHe06ott0lOKD8 A==;
X-CSE-ConnectionGUID: 6W9NaqNJQvKUWgvXLsrj1g==
X-CSE-MsgGUID: 81NO9kkOQG6/ZN+Dg/1h1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52725525"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52725525"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 19:54:36 -0700
X-CSE-ConnectionGUID: ERdQ9gJtSfekzRCI3X2EoA==
X-CSE-MsgGUID: 9Np4wjAXQpaxT3D6Q5TCYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="156595409"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 19:54:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 19:54:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 19:54:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 19:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIh65r2P29VxFSe/N69OgapP6/0dWrpRVYT47P3lpTesJzwGkel6o/IooXBeS8CN+7/mvo668wKWJ3FlKwREVj0cXaRObZVUhObyCVVt/7RtRn3Z7ie5DHDTVQDtumJuwywNL7AiBDNV2QumIIYm3mvfeO4A+MOC8bqcLNVdCCYpj2uUY/+H34LzyMQbQBamduuWoHBKZqk/GXqlhITR13AS0xiyzPwFkf2U60nWBOEVbwYLqL0Ee9LScr/NIr+zBo3bcETlB5g0CwwTLS0AZd9HdVU/ZbkZ/HetMARsYYesIsQom4VXiZ7FW66fciHKUnSGsLQYpmQcHcqR9OJhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb7j7Iwv5UuDnnANV7TiFbjzUmfwjS6ktXBRXRfkQG4=;
 b=PWkyKwACxmIoT0/yK6BVZuk1wQkkHifOS51CjSBiAfDqdAml8t7I0oo5Yxp6d6S+COOHL0dvF4/W0GV/xrBs5YroAhdyuChItld/2OH7sEqnqUHUz5ah8IknqZboKCJ6Uhyvcjm6F8wUuoVOqJ0eZLaO7t9InzoZ44t9z8EUsdLGytdTd9DncRGVKeUwpS4AUww5tqHZaq07Emh2rijlvaOsfA+xwZvELL93nnU0DkgA09d0TeT9wdEXh8sIrqQRBauFX3dV+TeD0a4zdmm/SVFg6/GKoaTSiX7DPGg/wE9aEEAygMi7oBObc8yEszWQzdRZ9mDSzw5dedkAFgH5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.38; Fri, 20 Jun 2025 02:54:08 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8835.034; Fri, 20 Jun 2025
 02:54:08 +0000
Message-ID: <776dbb8b-7b21-4a31-bd7f-d97fde1d2988@intel.com>
Date: Fri, 20 Jun 2025 10:53:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] ram-block-attributes: Introduce RamBlockAttributes
 to manage RAMBlock with guest_memfd
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Alex Williamson
 <alex.williamson@redhat.com>
References: <20250612082747.51539-1-chenyi.qiang@intel.com>
 <20250612082747.51539-5-chenyi.qiang@intel.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20250612082747.51539-5-chenyi.qiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: be8bae1a-b35c-4861-cf76-08ddafa5b9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU41aCt5UE95MXNVM1RyQmZQZEVJZE0wQjRMc3kvaHIzcCtVTHJXS1VhZHhY?=
 =?utf-8?B?UkpBVHFWL2lJakRwMVlMOXBaeVV4QWdYQmU2eUFyaHV0cGd4L2JzZEtsbkxV?=
 =?utf-8?B?WnowNE5iUUNGMmtnQjVoc1BXdkxlN3RmOVowOHpSTVViS1krL1crRzVWeW9N?=
 =?utf-8?B?Vnd2NEV4dlIvekxsSWhSVktrM3BYRUZLWDRpb3Y2QTRnT0ZpOU5ocUxzZDZX?=
 =?utf-8?B?YU9yQzZtVXNuYSs5SzR2SjNVMUFUTHdyc2MxRVpRSDdsVVVJZm12RG1seWk1?=
 =?utf-8?B?ZTZxUkRMSmVQR2xnNDdUK1IyaTFsMWduSHh3M25XTlpoTWhQRSttc2daV2hh?=
 =?utf-8?B?NFFDajJWeHZUdDZUbndhMnpYV2lXNHFWcEExeE0ybm5KS3VISmxRbnU0eGVh?=
 =?utf-8?B?Yzc3RVJVcHUwM1lYdXNKZEVrWVdrWThaU1JNbzlvRFBscjBsUFFMcTlvKzla?=
 =?utf-8?B?L05hZk9oSTNMK1l3QWtxUUxJRTFsY1V3MWhTUE1oVnJQeTlLby8wem1pSXMw?=
 =?utf-8?B?Ukh0Q2NlRCtDK3Zzd1BuNVRBTU14Q3U2bklyR3AzazJPM0sweFhubmtqR1Jh?=
 =?utf-8?B?YTN4YlV3Vzl5TTVwTHJLUXNnVUdlK1lJQmRwVHVaS215a2E0VlVYdFhrS0Rk?=
 =?utf-8?B?M2c4VDdmQ0tKRFRQVVNuUFlkbEU2MkI1a242R2sza2IxM0lKTjc4OXBTV2h3?=
 =?utf-8?B?VWVtWmh0eXVCMWx5NzdKbmMzOFpRV0lVMTVhZDZsdUFRVUNqOVpMSkphU0s0?=
 =?utf-8?B?K2dWallOSjUzZHVHOWlHM1ZMaElNeW0xaFJjK21FZnl3alpmS1NvYTdyZDNK?=
 =?utf-8?B?V0VGQkYvck41Tk55RVpyV0p2MDU2dFhrbCt0enpsZlhPdC9UVkJBaDMrWVNx?=
 =?utf-8?B?ZGFsTW5TcnhRNlRBaDUwcW1haXlUZnBtVnFiWFcxZ2wyc283Ry8vaUR4bHd1?=
 =?utf-8?B?K01sRTRqdUUrVjVwTWk4V3FHRFkyREpHaHRjSXZINXQ0Wk1Ub2pjVWZWY2xE?=
 =?utf-8?B?Zjl5MSt1TmNNanN5ZWFqREJGbFNMbStkODFzT0JFSE83ZWFNTXNOeDNCT2NQ?=
 =?utf-8?B?N2t6R21PSkxKSkY4aEhPNWQwMGRiaXUrd1dUcmdjSUFsN2w3Q29XSnpVOUFj?=
 =?utf-8?B?VXY3MGVsdDBEWGtXTUxvTEdNL1d6cUhlR1NUYVVsUDY0QVkyZ2xnZmhlV1VD?=
 =?utf-8?B?T041ZTZsOUFPMHV3NyswcWVzdHhUckhSZWxYVkViTXVyNjRJY0VLV0lSdzF1?=
 =?utf-8?B?VE1LMHlhYmNGbGZla0JIWDFPWlNiMmJjMVRtckZZUXhSSzlyN29hMGp5QzlH?=
 =?utf-8?B?dWlNWUlvVHJNQjE5K3pBN2txcEFJZGRNeDRSeDFnSnFoMzlnOHl6NGk5WkFv?=
 =?utf-8?B?KzA2TFplbmNOZU93MWpESWxMQUdMTWs0VEZxREw3eXBIVkpHZDBmRWRtMFQr?=
 =?utf-8?B?NW03N3VzdmtEU3FvRktsKy9OWGRMdVQ3QktxcjJkc0hIdW8zd25aME0vL3JY?=
 =?utf-8?B?MFcyTGdwTTF2VngrRndCRStwcThtSFdMajFMcXQzUDdZZjhWdldENWVCeEdJ?=
 =?utf-8?B?ZC9VQ0syczBnU0VaUUk0YWs3UFBOREkrbTU5eC9TNUhtZGVMZUhxQXBVQlpE?=
 =?utf-8?B?b1hoeTBPZGFVcEd5OFY2TE5rU3M5YnAvaTIzTnNycTgwTm1nbTRKKzlHRmRV?=
 =?utf-8?B?WDJxUHdBVVVFRXBqSEtHcENxZWY1QjJ3MXJHRExJMG1SNUVwRnhnei84d0w0?=
 =?utf-8?B?UzNoMnhqWWkrN1ptbjB2MTFjVDFIRDBjMEFDUTdMTGJTQ0RZRUxqTElwVzFp?=
 =?utf-8?B?VThIOUJqZHZTVC9lc2FyZGlDU01lUEJTNTJ3VE02QWZqdEpWN25haVozejFy?=
 =?utf-8?B?Q2hjQmUwWG1lbVdQdkp1azJpWU9iSmVFUjJucDAxSjBUZjViQ3Z0SnFQUFJQ?=
 =?utf-8?Q?YLXdFDJecXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURUSDArem8wRUJXeThQM2tWbGp3Y2ZWQkVJanYwa25rM2w3cUUxT25FcTBH?=
 =?utf-8?B?QjJWUmt4aEIzS2RVbkFDR2ZxNnplaGNLdGhNZk9WRkNWMnQrZk13SmtBS1I2?=
 =?utf-8?B?dXlsenc4dVRVYW5SNlM2b2xYR1FlL0VwV00xK0Y1bXM5NS9yR0JWKzc5a1RI?=
 =?utf-8?B?UDBVUWhxeFhMYzNVRWxSdExKaC8zVlZxVHZVRE1mcnB1MnhLODAxVkQ1YWx2?=
 =?utf-8?B?QzR2Q00wc2laNFBSTlB1WXc5c3ZHN24vVUdmd25xQnZiKzVsbXVzYUdjcndn?=
 =?utf-8?B?NWJSQ2RQZTFva25pTFl5dVJKNjZJVDMrS1dVSXdIclBSV3FHS1pnWTNSWHBh?=
 =?utf-8?B?RVBITFNnVjliYjI1OUsxUi9GS3M4YXJUQ3NBUVdWSWVDOXFmRE40c3M4SHRk?=
 =?utf-8?B?SzdjMjJrUnVVQThOV3pINzFhSzJGazAyelZIQ2hYSDYyME1GQTdZMUFoclht?=
 =?utf-8?B?dXM2M0ZkQ3NTdUhydUQycjhuTkFQZC95QWVnODZ3cExhTmhZdGg4WHFmV2VK?=
 =?utf-8?B?WHlLblZJY1YyTXJoTTJOTUlqRHBVSzlSeVZJbjFNN2N3ZHNMN2FRQW1mSEcr?=
 =?utf-8?B?Uzc4NFVqQ2JmTjhLRkFrdE03M0IzNnkxT1lyOVluTzdxamRldTJCeHkyRlhs?=
 =?utf-8?B?QVBVM3RvMFEvM1lESTZWdjVGeGF1QWJqd1BSTUxJM1dOVlRDSU9qSkNrU1lN?=
 =?utf-8?B?cXhTM3BnbkxYL2NIY0Q3cGE3bHIvd1Q3cVJaMDBKSjZuU1lnRU4vTExtMmdQ?=
 =?utf-8?B?K0UzR2VJTitvR0E4d3hyNWtRUGQybG9rcEw2MmtXUmNsa0ozUCtSa2t5ejZo?=
 =?utf-8?B?Ry9UVTZuaFZHZXhjc2grVUluZElCTGhoSVhDalpBdm53YS9WalFERGNjbkJE?=
 =?utf-8?B?Slh5OHZGVllXZG05OGdaa05uN0c0MEhlSVlDU0ZwMXVGdnRkUXRmTTBKcVJ2?=
 =?utf-8?B?ZHJTTmRuSVB6c3JMMWs5OVNCMG9PR0daT3VxZWNLMWRSVjJuM2pkSU01OVdZ?=
 =?utf-8?B?RnJHQi9FYkpkZjRod1h1WEh3WlB6bUJtb0JLcXJUTGMrU0xESGdNNk5DNWFC?=
 =?utf-8?B?V2Q0VHVlZmxXZVBPR1lzYlEzWWpSRWpOMERzN1dyRndreXlmT3BJWVhBbnZW?=
 =?utf-8?B?SXAwenFvY0ZpMWhoYjB5Skx0TTFTblQ0SGVHdXd0NTlKaGhyeFNqemtzMWxB?=
 =?utf-8?B?RzR3aHVrVVJtbS9DczJoRGJKQjdFSTJLajJwNG9jRmNOWjhLZWUwbDVIbGlZ?=
 =?utf-8?B?UytQMG1ObWVLbWlObTVteUp3bHh3MmNEMGJsMSsyNjZxbDBDZzNRcW9TK0ty?=
 =?utf-8?B?VEQ2V3hOcllZaVgvS0QzY2JLOWliVXcvbnIxb0JCZWNPNHF1UWNIWUozM2Y4?=
 =?utf-8?B?NzkySVlMRkNZNFNRL0dkdFB2cUVEVTVnWkVtcE5CN2p1blFBYXNmUmNsd21Y?=
 =?utf-8?B?aXIyK1ZJS1g4THJkbWdnNVEvakNYZWZ1SUd0azdUaU9heEFCRE5jRGxlTTBU?=
 =?utf-8?B?bkFyTnZtbElWdzhhdVY3MUJsWGlCRTlHQnNaUGkvNFRvZk5hUE5rdDc3T0dH?=
 =?utf-8?B?djRUUlFUdWZINWJRbjZBRzRjWGJWeFBDcXpYUGZpbHQvV2hJTUh2ekFtdVlO?=
 =?utf-8?B?eGtDMjBqNFJDa0FXVHVxc2hhaDRvZkZVY2hoWjF5TDBVUG5haGx6THdzb2RV?=
 =?utf-8?B?eVhVQ1lQUGNHN0FobFFYUnlzbFR2OEhoeStEeDJLYWpzQlJndnI4K3g3blNY?=
 =?utf-8?B?ck1UQmFrWHFWdE13MzZlVUpkNjNsU0xRUkJ1UmpRcW02QVl6MFArMGZEV1NZ?=
 =?utf-8?B?UVl4USttNDF5Z0pITFhXUVBMME9pLzJ6dUJiaVo2RzJnVlJCdXlySnRXVjFz?=
 =?utf-8?B?ejQ3K2pQT0lrV1QwVm93VlhvaVlPOC9BN0I5S2FDbU5VVUk2VlBaZkR4dEh2?=
 =?utf-8?B?blhDQm1TYnZLRGRGajI3RExUL3ZTSitNai9mbnV2NUxWNEdTdVJneDczd1pa?=
 =?utf-8?B?NU9DMEtCOHBlc285UlU5K244TkdWZk05UXNNSEM3U3hjNTU1NHMzR00yZlds?=
 =?utf-8?B?c0RkOG1EL3FZMFlKR0E1LzV1MkdOSGN3aDFYSUxhQ3p3dHorWHFTL0d4cW9C?=
 =?utf-8?B?ZVNzb2tyZ0oyTlhMcjJtb1BDVWZsTXpXdWIzZ0tMYk9obDNmcHB4dVhJRlR6?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be8bae1a-b35c-4861-cf76-08ddafa5b9b5
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 02:54:08.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8RzhyC7OJ3dMDKsAR8iKngYDL7eZCUjQPJbQcazc9VKSKnV7zRMB18sperMDmj4wydyoJT/6QcRvTUlKAwdsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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



On 6/12/2025 4:27 PM, Chenyi Qiang wrote:
> Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
> discard") highlighted that subsystems like VFIO may disable RAM block
> discard. However, guest_memfd relies on discard operations for page
> conversion between private and shared memory, potentially leading to
> the stale IOMMU mapping issue when assigning hardware devices to
> confidential VMs via shared memory. To address this and allow shared
> device assignement, it is crucial to ensure the VFIO system refreshes
> its IOMMU mappings.
> 
> RamDiscardManager is an existing interface (used by virtio-mem) to
> adjust VFIO mappings in relation to VM page assignment. Effectively page
> conversion is similar to hot-removing a page in one mode and adding it
> back in the other. Therefore, similar actions are required for page
> conversion events. Introduce the RamDiscardManager to guest_memfd to
> facilitate this process.
> 
> Since guest_memfd is not an object, it cannot directly implement the
> RamDiscardManager interface. Implementing it in HostMemoryBackend is
> not appropriate because guest_memfd is per RAMBlock, and some RAMBlocks
> have a memory backend while others do not. Notably, virtual BIOS
> RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
> backend.
> 
> To manage RAMBlocks with guest_memfd, define a new object named
> RamBlockAttributes to implement the RamDiscardManager interface. This
> object can store the guest_memfd information such as the bitmap for
> shared memory and the registered listeners for event notifications. A
> new state_change() helper function is provided to notify listeners, such
> as VFIO, allowing VFIO to do dynamically DMA map and unmap for the shared
> memory according to conversion events. Note that in the current context
> of RamDiscardManager for guest_memfd, the shared state is analogous to
> being populated, while the private state can be considered discarded for
> simplicity. In the future, it would be more complicated if considering
> more states like private/shared/discarded at the same time.
> 
> In current implementation, memory state tracking is performed at the
> host page size granularity, as the minimum conversion size can be one
> page per request. Additionally, VFIO expected the DMA mapping for a
> specific IOVA to be mapped and unmapped with the same granularity.
> Confidential VMs may perform partial conversions, such as conversions on
> small regions within a larger one. To prevent such invalid cases and
> until support for DMA mapping cut operations is available, all
> operations are performed with 4K granularity.
> 
> In addition, memory conversion failures cause QEMU to quit rather than
> resuming the guest or retrying the operation at present. It would be
> future work to add more error handling or rollback mechanisms once
> conversion failures are allowed. For example, in-place conversion of
> guest_memfd could retry the unmap operation during the conversion from
> shared to private. For now, keep the complex error handling out of the
> picture as it is not required.
> 
> Tested-by: Alexey Kardashevskiy <aik@amd.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---

Fix the issue when build with cross platform compiling. Opportunistically resolve
a "line over 80 characters" warning from checkpatch.

===

From 66d6edfb78a6059362a1de3d5028c4159782554b Mon Sep 17 00:00:00 2001
From: Chenyi Qiang <chenyi.qiang@intel.com>
Date: Fri, 20 Jun 2025 10:29:14 +0800
Subject: [PATCH] fixup! ram-block-attributes: Introduce RamBlockAttributes to
 manage RAMBlock with guest_memfd

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 system/ram-block-attributes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index dbb8c9675b..68e8a02703 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -42,7 +42,8 @@ ram_block_attributes_rdm_is_populated(const RamDiscardManager *rdm,
     const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
     const size_t block_size = ram_block_attributes_get_block_size(attr);
     const uint64_t first_bit = section->offset_within_region / block_size;
-    const uint64_t last_bit = first_bit + int128_get64(section->size) / block_size - 1;
+    const uint64_t last_bit =
+        first_bit + int128_get64(section->size) / block_size - 1;
     unsigned long first_discarded_bit;
 
     first_discarded_bit = find_next_zero_bit(attr->bitmap, last_bit + 1,
@@ -333,8 +334,8 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
     int ret = 0;
 
     if (!ram_block_attributes_is_valid_range(attr, offset, size)) {
-        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
-                     __func__, offset, size);
+        error_report("%s, invalid range: offset 0x%" PRIx64 ", size "
+                     "0x%" PRIx64, __func__, offset, size);
         return -EINVAL;
     }
 
@@ -402,7 +403,8 @@ RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
         object_unref(OBJECT(attr));
         return NULL;
     }
-    attr->bitmap_size = ROUND_UP(mr->size, block_size) / block_size;
+    attr->bitmap_size =
+        ROUND_UP(int128_get64(mr->size), block_size) / block_size;
     attr->bitmap = bitmap_new(attr->bitmap_size);
 
     return attr;
-- 
2.43.5


