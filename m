Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1093C12A2E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Oct 2025 03:10:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDZ8u-0007VX-M2; Mon, 27 Oct 2025 22:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vDZ8r-0007VK-NG
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 22:08:57 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vDZ8m-0001e2-Jk
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 22:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761617332; x=1793153332;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gp/u7v/AS9AvdiZFLJo/wOP44ixu1SvR7JhPCiQY1KM=;
 b=NORiVPr/qP0n0tIH6nVKJeZnsSKRaTG2PZP65OEf+IcZAA/3QJO6kZoh
 93McDMdcxJytri+chah3sQlHPr6EpXOzTKtjJ2krfHRt/NLdQZsJOVLlH
 RkeAB48b3w+c8tjXnVC0o31uWkzHkwLngvoWa09U94pmxVah2ljj/OGWf
 RTtajmjDUGei4sEb562c1bbnIq1N3ldSp7VGx+frLOZTJaDxCUK+5Pus3
 L6b1RaBusPOXH3WEPl6IyxpB3Jbc+grijdM6z1RCmKz1sldsUjLTy3d+p
 SL/N27C32tJqMvPo53Tm5rcIPjtm7L+qj2m1ck8LVu9hhndlDVt28Gnem w==;
X-CSE-ConnectionGUID: cljsNEC0SBGQIq/k5FgybA==
X-CSE-MsgGUID: FBj/mgBRT/28mtOn2CBBBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63607108"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63607108"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 19:05:03 -0700
X-CSE-ConnectionGUID: MFdc/xCDS7C07r0H5zzb4g==
X-CSE-MsgGUID: 4z9arx12Sbq3wYOKYgCW1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="189266529"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 19:05:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:05:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 19:05:01 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVsm2L4pI4UGqDETMydjFVGkDDBfInIIUfWesR/XYU7CRHLuHZEoXk+53f8vYWNFkkRDXQXrarzsHwfxDKcy+TYZqluuoX9VcDrqgUwXf/5+LOL3nIbqAtgqJvzyjofrpXma12bL5UWCxe7JOfGRgVvQmcMQTqR8/6CIghrW+RDQ4+JqLv3+85cm66Ngqgwlglyw+sN25z4kMnerfAKWEbgF8OKP0l1yHf1nDSwftPRJ/Eji1I/96tJJimFeg/EdViqCwDVY4MQaLQ8yhgiAuLSKVz+gURQhM7nOQp+O5N9DPORFFuRNdOvT0TZwOKXxGn62GhgiV/BhpAy0Apvuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnAjDeh1gCX+205j4yU4Dz2aaxYLLRNmdtYboWqYvmI=;
 b=FuPHpgYqDBcW9Tcr8+7Be3kFeZu/ax7S7TXqP1YY80BcIxWPtcSfuaDyUSFagj+PPbQzTElLCJSTWg0bXTxn1OUvcb7Jp3MV7oqdt0IvCR6LnrdUbE4yIVkPngqWvcvoEbBvde9EI07PLALg+Ip/eCKTalzUq3QW9tm/6bg/yGhUVtPG1w2q3xaLl3W2VU6jBpYhWNXOPERC4usgsvXIc70DU/oJErv2goQbCjtVW/AtiQmWyaToBZKwfqfwuZDunSBpkyB17NP0t4m3WMSIKElI0lgy+SUFFyjIEo9LNrrvBxv8dI/df+jUvYV89MhKRtYV4vqwLN3FfXWSGQXO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 IA3PR11MB9158.namprd11.prod.outlook.com (2603:10b6:208:57d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 02:04:59 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:04:59 +0000
Message-ID: <bb8609f2-a17b-42ff-9784-379be0b77502@intel.com>
Date: Tue, 28 Oct 2025 10:04:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] i386/cpu: Add CET support in CR4
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>, Babu Moger
 <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>, Dapeng Mi
 <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-13-zhao1.liu@intel.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20251024065632.1448606-13-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:802:19::15) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|IA3PR11MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d48527e-6d5f-4523-73d7-08de15c665c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlBiM0dtTlVvMUMzOGRBcU5IVTlGMWxrLzNBb1dhaC9zS2JWNFVkN0lqak8x?=
 =?utf-8?B?UzJhcXhicDEyUDZMT3pkSnl3UGF5RzIzMGxwbmlROTVTV2RqZitGNGMzckgy?=
 =?utf-8?B?bk5RcUlGZm1ubko5K3Vnd1NHS29qdHdCYS93bWFIQ29QbnNPT0QxZVFVSk9u?=
 =?utf-8?B?dUlqek1icmNVMXVGZXNXV0d4V1BlVTRGWWdIUHlHeXB0TVBwbTd2blNiOWNC?=
 =?utf-8?B?RHlRVVFaRHhTS2NKdFhUbVNhejdLTVIrUlcwcWJRT25raXN0NldEcE1yUnp6?=
 =?utf-8?B?RHBjK0FkVjgzRU54OGRodTNCT0Nsdk9uMStEVDBYdUVTSENMcWFKcVpSNFZV?=
 =?utf-8?B?TDBuNjRIcHVlckpIaVkzdnVmb3F1dmd5eWQvK1BOVGRXMG9uYnd5N2lic21z?=
 =?utf-8?B?bzJkT3FmTEhsOTJTMzIwMXdQRXJ4L3VnWDFmb2pCTXFHeU5BdXVDQXpnUENR?=
 =?utf-8?B?UGxnWnA2eGF0azcvb3Vjd3BIQlNXSmp5N2kzMGxtM0NBeXZ4eTc5aEFLYTV2?=
 =?utf-8?B?aXpvZytjcGo2UDd1ZFpRSDhqb3k1K1dvSmpHdWdqcmdHOVRSdWM2VHVwdlZI?=
 =?utf-8?B?NmlYblg0aFZmNFJJNUZWckRyNTdMWkU5d2JhOEp4VTBBUHl5RkdnV3ZEeWdU?=
 =?utf-8?B?Rk5wdnpnQzZ1T2Y0NVpndFlacEoxYyt3SkxNbGliYmlGZ29JSzZ0OFF3NS9i?=
 =?utf-8?B?TndieDBvbTd2eTNkZG9YNWJSTFA1UUtqVWg3NXZEQ2Q2b0RtRTZIaG9wV0VK?=
 =?utf-8?B?a3JLRXJQT1QzeGlxcHNicUNWRXZzbVkxTzM4NkRjS1d3dTU3TnVHa1Y3elJN?=
 =?utf-8?B?Szd0NXN0R2xOTFhYWFZSb01YdTBENmtkUTdUNzBEOHlLeTlZZXlQWnllMDFN?=
 =?utf-8?B?bldjMzJYMi9CSUljbVI5eEVJaXExQTZqaWxhN2NGYzIzL0Y1UXc0MzdlVTBn?=
 =?utf-8?B?MmRHTGtUUVBoQ1dUb1R3blJ6K3Y4eFVYRjM3TkRUYTZrc2ZiaWx3ZmxyOStt?=
 =?utf-8?B?Tlp4NkJBR1QvNGdGemF4d2ExZkpjVTBGTUJLbi9ZOFZkYTBCb0NQaFdwMGRD?=
 =?utf-8?B?SnNOdDg1a3FIL0pBczV6b0FOODVqb0hzRVUvUnVQcXl1MmViaHRDb3R6dDIz?=
 =?utf-8?B?TmtUSng3QTRodzVxb1AyUTBIUEhpZ25VTGRvQ3R2T3NadmswcW5WTDRrUEpU?=
 =?utf-8?B?YVRBcmVCUHJONnM3ZlF1czhib2N2VHI1dllqK3pSR0RJWEZKVnRQOGVTSVNi?=
 =?utf-8?B?d3paelhUNlVOOG5RRjQ5Z25paHg5VmYxekE5RTEwL01UTjFyS1hRMks1bHN1?=
 =?utf-8?B?bzU4Z1FnYmFza1YxWDh4WktnckFWa1AwOHBzLytCUUx2VWFFWUp2Z0FyR0pG?=
 =?utf-8?B?OEZvdnQveCt6M1F1MmJXOE9JOFJHUC9VWncrV0hpdXYyTEZFcE80cW5pWVVR?=
 =?utf-8?B?NTdjUFhVbDFSYVpWWW16SVJQNVBKdXQ1TkhaVGdVL3VpRE94ZW8ya0ZzNkJO?=
 =?utf-8?B?Z1pWZTgwYjY2MkQ1cUszQUV2amlURjN0bEtsQUI3YWNIemVrN3l2dEduMllt?=
 =?utf-8?B?NGNHc1BMUzQyMC9BY1AzaGdscWIyM2lNSERJcjd4WUxCNmI2SS9xSjUzcUoy?=
 =?utf-8?B?cmI1ZExjNDBIaXd6MWZ5Q2czVmQ1ZlZaZXNYTm45NWtSL3N6YjZJaUFnWGM1?=
 =?utf-8?B?emVsRkoveFg4VXAzaFptaW9KS09qTlhXT0hwZWNFYWs1bnFpdG5EN1lUU3lN?=
 =?utf-8?B?NUJ4RWo4eG1YWjBvTE1JbU9kVDgxaDM1L2p4TVoyK2ZQaVhIZDl2am9vbndu?=
 =?utf-8?B?M3ZYQVcvZnFEMU1KN2JuMGRia21PZzd3c0dEallkOUljY2o5N3lZdzhXTTE4?=
 =?utf-8?B?MHpYVWU5V2ZIclArYlBYNWlXTkNhRkE0bXR4aDJZRjlkYno0S3UyMC9ySlJX?=
 =?utf-8?Q?jqDESnSSoE8lE9VFsL33tVkE/r2+m2nb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWhkL21UcCtrLzR3bkNkVDlWN2kya0padnYwUWVvWVFrTWIwcEE0SmhaRmNu?=
 =?utf-8?B?OUJ3QUFraUxjRkt4Z1EzbEhDK0pXbms1SW5YY0ZTS1JCS2NEVk5hdnViMHJO?=
 =?utf-8?B?ZDJ3Q1NvNFpCY3lBbytDdXZOckN5RVJjMUlhZ3V0Q3pzbGxra2wyb3pyS2tV?=
 =?utf-8?B?ekZWZ3pWS2NlZjFQYjJKNUJFSnZtYW91WjNOS3h4d1lCOGsyRVA0cTI1c0My?=
 =?utf-8?B?QWJ0Z0lSbnlkUEpFdXZlbGtVRkdSSFFQNjNZeStFMGtTZHZzRktRTjJUUVpI?=
 =?utf-8?B?SGhyQlR4OTRwL0tDd0FzYnMrbGRlaEhzVU5ITE5nRUk3aDBJQVhlc3FSUFk5?=
 =?utf-8?B?bmhmMmpHTlJGSVRSN3o1Y0luNTBqT2ttN0RvWmgxaHI5WkRIZ0NzOS81RFMv?=
 =?utf-8?B?YlhraWJFWkxWTzhRSDVBeHFvL2JxeU1sbWd0VEk0SXdYcUhWM0hBY3pNWXdn?=
 =?utf-8?B?N2UzRkh5S3h1eGJSM3ZFYittSVdjbmhkKzE0dnJBU1E1ZXkxTnlHRE9Ycis1?=
 =?utf-8?B?Q1N3cVZSQ0lzNHg0NzVXMHNpbm9sTjBzY25pWXMra1ZITCthQXo1emlYMEdF?=
 =?utf-8?B?ZHFLMXF6eUpTT1I2L3NjalF0QmVTajQzL0JxUnZkZTZmZm95RzgvSmxveWZM?=
 =?utf-8?B?N2ZtWHdOUmdZSHovck15c3VQOXY1REduMmc2K1JjdXYvdVVHdFp3SVN0ZjZ1?=
 =?utf-8?B?anprRllITlNKNTJLdTRiRmtwQnBoa0o0QWZBY29XbzNqVjZFaUVFN0hSdTVY?=
 =?utf-8?B?WUNVVy9sc3JWZ3RjdDBzcmRjREtqZ2VoVDVWUUFyQjVGMkNJVGRBRkZnVjl6?=
 =?utf-8?B?eVVEeWUxRXJOaWVhYVovSy81TWdHR2ZuNW5ybE56Q3prR3pCanJMcWpUT3RP?=
 =?utf-8?B?VGNUbXdyVVVEckxCQ0tmVUZkbEwrSkFSOHRDUThGSDZLc3h4K3V4T0NocUtp?=
 =?utf-8?B?V2tpMkJET3RqbHlxL3h3KzZnYkM0bVNwampaU3RCUWNmeUhJZnRmT3hHVXNk?=
 =?utf-8?B?d1lRdTRKWElJM1RLdmZaZHkxZWp1aUUycDNHS2ZaTVVQdVd5YWhFWndZdnNp?=
 =?utf-8?B?Wk5JZS9DQ2JJUGhLamUxcVBWQUVYSDl3amQvSnQ3TjhLMWZrOW5sd1BhOWhO?=
 =?utf-8?B?VWduRVZad0xkb2lESHpzTDhYTUdheUJ1RWNaREw2Q214QlFPaml5R3lydjdh?=
 =?utf-8?B?bGlMeXk5cDdyc01tR2hyTGdtZDdYOWFVMDh6LzB6RDYwRGhoeXRRanFLQjZB?=
 =?utf-8?B?RFFVOFZQOStSQlpxaExrL1BLWmdteUdrc1VpMzNCZDlFTFErSFI3aWd0cFM0?=
 =?utf-8?B?ZmEwK0Qzc0JjV0M2bkVzanJpVzd6WlhhOEFUTlhEM2hYRFUySlA0ZUpCdExL?=
 =?utf-8?B?akp6RUIvMWNUY0l4bmtHSng4c1Vvd1hOeXp5Snc2NFd5R3ZkVUp3SU9PR2Nr?=
 =?utf-8?B?RXN4SWhacy85bXhocSsyc3gzOEVnWGNFekdoQzFBZ2RZZ3lFamVCMnk5c2hQ?=
 =?utf-8?B?K3U2a1BjaDdCZFo0ZkNsNTNoVFk2aFBhaGlhUFI3Q2F3c3g3c1RSWUZiVnVx?=
 =?utf-8?B?VTBsQkFUUDFYWWhBSEJBaC9wZmxXWFp5Zk52L0p5clZ4bWlmdTYwcDBlQkJm?=
 =?utf-8?B?MFFFaHh0QmJWV3VQVFJ1VTBobXVwc2pNSkYrYnJidGtON2RkRldFTHQ5a2pZ?=
 =?utf-8?B?WW9qSmUrdGFRR2RmUHY2aGV6Z2xLcVF1OG9zUUUxYmkwRGN6MjdKY3hEbldj?=
 =?utf-8?B?MjA5NXU4V3Y1TG81Z2hvSW5CbnhEV1hMaHZCY0VmQmhpTFhKN0hYWXA4aVh2?=
 =?utf-8?B?Vy9oSnMwbXUxY0R1YXdUNTNnU3REck5DR012Uk5ROUNGaVFMdVpOTXlYcUZQ?=
 =?utf-8?B?cGgxMFZTbFpRb3NVcWJ3MFAwam1hMmtoZkQrdkp2SjNLUmV0anEyWTRWemRn?=
 =?utf-8?B?NkJ6ZGpzSVV5d1k2SndWQjgyT0tZakc1SHBnbDRONkhkZVh2eG54OTFtMzJk?=
 =?utf-8?B?VHhacHMvK3BVWm9iU24xVDkyR3A4V1lmVElGWjN5cWpuK2piSHNxWkhUaUpt?=
 =?utf-8?B?Z2Fxb2lNWkNqVGtZRE85dXVMRGk3emYwdGZOTnFhaUpmU2Fmb25zR0I4dzN2?=
 =?utf-8?B?dDZqMmFnVWI2bzJHdGFUeWlicU92cExiZHlrYXJla2l2bm9PTXI0aEw0VERJ?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d48527e-6d5f-4523-73d7-08de15c665c7
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:04:59.4403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAZq53IRdfYHUMSIB6OKBCjtIf2PgDKsb0cVdrW8ZBzHgxeXQin0Bj9gPN7WPYhE2jek18MqSMAoVlOCPqZSTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9158
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 10/24/2025 2:56 PM, Zhao Liu wrote:
> CR4.CET bit (bit 23) is as master enable for CET.
> Check and adjust CR4.CET bit based on CET CPUIDs.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.h    |  7 ++++++-
>  target/i386/helper.c | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7584cddb5917..86fbfd5e4023 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -257,6 +257,7 @@ typedef enum X86Seg {
>  #define CR4_SMEP_MASK   (1U << 20)
>  #define CR4_SMAP_MASK   (1U << 21)
>  #define CR4_PKE_MASK   (1U << 22)
> +#define CR4_CET_MASK   (1U << 23)
>  #define CR4_PKS_MASK   (1U << 24)
>  #define CR4_LAM_SUP_MASK (1U << 28)
>  
> @@ -274,7 +275,7 @@ typedef enum X86Seg {
>                  | CR4_LA57_MASK \
>                  | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
>                  | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
> -                | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
> +                | CR4_LAM_SUP_MASK | CR4_FRED_MASK | CR4_CET_MASK))

Maybe put CR4_CET_MASK between PKE and PKS to keep it in order.


