Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B27A91D2
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDU3-0005L5-5g; Thu, 21 Sep 2023 02:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qjDTy-0005Kr-VL
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:48:14 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qjDTw-0005RA-D2
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695278892; x=1726814892;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=80rafH+MkBkHuYJFQpZNbtm+lbhKUcvd8XKwJ2vwxeY=;
 b=QlNUeGagUaEHrY3InaZylnQ4k9pHNiKY3I5jyTPNZeLvyt36VwLxsVWX
 BQlM1qxby/+wwOrMpL4zE7oepCaO3VIQHT1TcHW2qO5dK9iBEhwX/bm6M
 1+JVk3OoBaqlPwKQOACcKonDu3mdrrdLJ8eOKpXSj+VgzZRxhb7WrYVta
 Tkh/J01OmyFhmBDypguQJ3v+CtxvkY5bEP2lPFcINn9TiYWDJEzAEGtDj
 AaxHh3TuGShOEUaRwlzAeiWcUMflfyQ0g93f00bXfBrXsAW3+5IvHiGNy
 hYgMFi/X7z0aAifEOlpxz46nzHUKj12ouWttFwtApd3kfqNfMO/qaNq89 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411386544"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="411386544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 23:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="890250725"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="890250725"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 23:47:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 23:48:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 23:48:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 23:48:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 23:48:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfz2YdPtPcsLx+LpZtuIyjKu553tlZsyn2YaAKBRbBnUSHs4jsTayufQqtEIf4DaBHC8z5jYWI/DZzDOj7X3kl0Pd3f+rKS5/45r/lsKvNL0uC5xvKbR/sdOCCTI7Fj2zaPN4AixWZrgTcEmIQYIvJucPyZuH3rqpC++7M9kuceXf8MnXC29e6PZ93OzSdLmDnz7wf6OCd1pt0XrIozlXLungnPCd8FCoS+XcraB2KRVMjZrrbozjYRyqIhVKxKW/E2t0Cx1INm2K7wxSBW+H34/Zqmf7oamD/xaYWQN8IK0skp3m4WmfQxv875Q5XZV7lgfIbvkniqUw5s1zakB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnUmPLaMcrePNaYUg0n2hvXPgtwIw63DZMu7g3LgDG0=;
 b=jbzwKJgQS7tZU+730e2mTWcLq+0bqGHcDmThtPN6XiP8Numi8/mF+hcEH1fbKMByr7/k6IOgs4TUfhFtT5Tpb919xaky8r34sIWCMHwTTgzEFA8T8RtJadFHKUw2JoZ+G7tVLrY/lzXexCuhBZbyPb6rAb8r6zNKjzGSoDaw/tAvtNIxuzr9wmzZ8GhTMT1JfK92DLhGoJaQaMsJ7bZn1drWsMuECdTNZg67dTcpHfTzSzLNzgUtTknsPHndDf05sHi1zUvish+xzSPyBz+dRaOq8gi+S+s2VixIxNdMNDYLAqeB+H+VPQAOquBZnO8HWkTeydAVJHdNBp3VNT3GBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 06:48:05 +0000
Received: from PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::a64d:9793:1235:dd90]) by PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::a64d:9793:1235:dd90%7]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 06:48:05 +0000
Message-ID: <a2ba1567-1dd3-06c8-08d8-b198abde9e61@intel.com>
Date: Thu, 21 Sep 2023 14:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/i386: enumerate bit 56 of MSR_IA32_VMX_BASIC
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <20230920154136.33171-1-pbonzini@redhat.com>
Content-Language: en-US
From: "Yang, Weijiang" <weijiang.yang@intel.com>
In-Reply-To: <20230920154136.33171-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PH0PR11MB4965.namprd11.prod.outlook.com
 (2603:10b6:510:34::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4965:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: b42687ed-3967-4218-f81c-08dbba6eb50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpXfOnWbUDXkuiJeXxPEq4tgh1ZIpamAqfXXW0p4tVJ8zHILlT8VVnMl8jokIEqN1DrYHyocyP9QaoO7aDX7zielEY1c9HWSGnHEu8w8mfvMWz7Chq+hlNjicUPbWV4gstO8N6/ToZc0vO8gldPp/PJfgqSE+XRYkhDbKaHTgehGxYXOILbGiZhRocoDLHHlTIn+nvI9CjOcOwKCAxP2nvV6VuYSJAh1TPfjpI/XYVf6BcMgz/DLrawdlN82w2i/ulbFixDtyeohu/8OZ8yHuKfFvdEVYDtU1XegBFwOH52CFssSQuF+iNGbTsvRovnBpsx2ebxHl6LOHowu7NJFp5k/iC2/40q645bJmerrZ/uGCCBHR5al391voZgST5nrM+x5bo5rWsmCGxrmVAJqQ7Df1KNap5VrDGqFCLPSKtj1aC0BIeYERQU+vhNPYBgQqzdHNeq8Cyn/ObsxCoE8vguH/zARQYDlBZlVSDTMmQufbTCI4iEgomVXJoX6fk4JEPyN0+wn8B8GAAt8UTsTHtMteEhRmYU4gcRWglhVtqUelN/6ncVs3nkhSI8gYxFTsUCs0gfkGb+jhTeeZnTHeO15ScYV0SxwFspavC9F8+qpuh3TMT50mR+6F2C8yfGPWTFDbMf8s8gxlPuK61jr9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4965.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(186009)(1800799009)(451199024)(31686004)(6486002)(6666004)(53546011)(6506007)(82960400001)(36756003)(86362001)(38100700002)(31696002)(2906002)(26005)(2616005)(8936002)(8676002)(6512007)(478600001)(41300700001)(5660300002)(110136005)(66556008)(66946007)(316002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVQMTcrUlE4VGNCWkNqUktiTndPL2ZtUnFPdjlCRWE4cGlTMUdyMlVhS1d3?=
 =?utf-8?B?aEZXdWx4RUdxamFwOGFidm9rYXlQRHFFMktBc2FjeDZvcnk1aE9GU3FtWUZV?=
 =?utf-8?B?dU9aQ0RBRHQvNnlKaWJPZFZlWHh1UWNrQk1XaitndGowdHVCVThTUnVHYlJD?=
 =?utf-8?B?bmpDdGJwQS8vaVdSSEkrejgvNFhuekpLQnFXazFDY2JXV0dGd1p2SENIaktq?=
 =?utf-8?B?UFlYMGZXeFltZWx0elFzeTlmUnN1MSswSUdvQlR1MHYxNHZXMEVRVUMyV0dj?=
 =?utf-8?B?SU9nNEZaaWcrRUk4TUJaYTJiVEVqME0wMTB1cGlQTDl6SHB3a0hqdnZwZlhG?=
 =?utf-8?B?cVNJTnVvUkJONzRENlcwZEs2K1JNRzgycUxKWlFobmIzSVBuRXNMMys1clNY?=
 =?utf-8?B?MC9LRDN2V2NGMVJxeFM1aWtwNm1aT2xYWmM3M2RXM21hZElURkdVOHlPa1A3?=
 =?utf-8?B?RVJ0cGYrZUIxb01jUTVab3dMQlpubGVsbG1RTW1Vb3V4R0JrY2V2cXpWdnpp?=
 =?utf-8?B?WUVMTzZ2R1NWWDIyQXpZUW9hTHBRZmlmREdkSDNrSExiVVN4YjFySjduNk01?=
 =?utf-8?B?R1FINEV0K1lyMlFhbVJ0VDBmNXFNTi9VSWhJUzN2UDNnV2dPNXM5OElZWnRD?=
 =?utf-8?B?Z01rQlhYaGw0NkhYWitjc2x1Qkw4eUVjRW52RjEremxOUUQrM2cvdTNuKzg4?=
 =?utf-8?B?SjZtMGVJWTg3Q0ZseGdTZXhrYlRCbVlnbmNEbWhIUTllajN6UDBQbm1mRUgv?=
 =?utf-8?B?ck15VnRYRTFlVExnbFZCMEpkODdTMmErd2NMOXhpTlRqRUdvaW4xdzEwR1h0?=
 =?utf-8?B?SEJWVGpoNmFGckllbU5OL2RyRHZzK1hZSXhaREFhWGdTNkFhblBJemN3RkpE?=
 =?utf-8?B?a3daU2FkVjcycUtpcFFRVkU4SjBrcDFPbnhWRmt2dk42ZUppYVhhWGlCNEV6?=
 =?utf-8?B?M09mMzloZTh6WW9xVXo1V3VoejF0TXplajBrcFpWZ2hReXF4ZkJEa2F4ZlJm?=
 =?utf-8?B?eTk1VGV3SUNZc2I1UzZCdE1qU2Izb2t6MjZ4YUtSWDdKaDB2RVlya3ZueG41?=
 =?utf-8?B?RFM3WXlmZFZUcTRHazNWTlQ0NUR3d0hyTjVzMEgzc1ZITXFtc3I5V3dPZG5n?=
 =?utf-8?B?WkpFZDlVQzhqWTVERCtWWWJzRWJIcHVFelRHNVdwdEZLQ2p2bzhES1RJUGdw?=
 =?utf-8?B?OEkrc3lERUJqSHBvNkVWTXpha1NDbkMvK2o3aE1mQ0huV0c2SGlXd0Fwb29N?=
 =?utf-8?B?dXVSSEFLUTdBY1hRVldUZUxlZWd2dGtITWNmaFNOUFFONDNLSCtYY0xvWGJR?=
 =?utf-8?B?bDZVdGZIL0hESzc5RTJCNnBLajVmTHpBQ0dqdjZWNjl4bUsxMC9vMTlPczVu?=
 =?utf-8?B?SGxRempOUElVdlh5YnRCaG1YTDhib3grNnVvSHkzamRuWHBMU1FCSisxUGRq?=
 =?utf-8?B?OTZSZVhWWEUwaDg4UlNpYTd4TFpzK2FrTXczYUg5aklKRnFOTy9leVhwMWtG?=
 =?utf-8?B?VFFseFVidTAvSmhDQ3M0VTF0ZXQxMlREY1ZFY25CdkY2QVRQRVo0N1Z4MXFF?=
 =?utf-8?B?SjFBd3NiVEEwOTkxbkpXNDNOVFhOY1VBRVlTNUhNdFo4Y3d0bFg3Q1M5K1M4?=
 =?utf-8?B?UWVZcnRnemY4YTNkMlVKaVgyb0xKeWxIMmI3VG15Z29heU9VU0g0TllSVFNq?=
 =?utf-8?B?emJIeWc0Qk5hVWU4NDZmd2dRczNORDlDcWZPQmFkc0ZuSzJ5Y1Q2NGVSSGc3?=
 =?utf-8?B?OFlULzF4SE5HU2VWTFFIWVJTUEFsdDRvVlJaNDBEOHNEWW1EREV5bnFSMEVz?=
 =?utf-8?B?OWxpNXVXaE5FejBuWjNSTE9xZE1aTmZkazJWeFVCOERBUG02TVNKUiszRkQr?=
 =?utf-8?B?eThZTXpJZ1FGckJEOVQxZVR0WmFIUExJb2RDcUlpVENkU3ovQmVtbWprZFFD?=
 =?utf-8?B?ZWZqWmczTloyVFl3UkFvamQ4ZW92ZWMxQi8vQ05ydEpQTitmc1lDVWh4ejhJ?=
 =?utf-8?B?TEwwRG8wS2dMc0d2VWVxSGsvZHRBL1NHMHJzKytJeGRaZ0IrZVhlTDBINGUr?=
 =?utf-8?B?SjZVZmlqR2RleURNbHFXMlBXR3h6eXoxK29nb3Q5aVZxRzJwbllib3gwRFc0?=
 =?utf-8?B?ZmJOU2tJc25LWXBNUEVONVMrckI3VjFiT2VlcWVLS3RKMWRZdXpPSzhZRlJD?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b42687ed-3967-4218-f81c-08dbba6eb50d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 06:48:05.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKoG+0K3PEMwMTQxZvkaqQG+jwSCvujIOZyZn0p8qGMBEDaRwkATIYS8nGvCwS09i1K/fTiwk9LKY07cCDlDyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=weijiang.yang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/20/2023 11:41 PM, Paolo Bonzini wrote:
> On parts that enumerate IA32_VMX_BASIC MSR bit as 1, any exception vector
> can be delivered with or without an error code if the other consistency
> checks are satisfied.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 1 +
>   target/i386/cpu.h | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6e52c7be1e1..8f334dbbcc2 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1347,6 +1347,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .feat_names = {
>               [54] = "vmx-ins-outs",
>               [55] = "vmx-true-ctls",
> +            [56] = "vmx-any-errcode",
>           },
>           .msr = {
>               .index = MSR_IA32_VMX_BASIC,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index eab610e5cd5..2e09c588f0b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1039,6 +1039,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   #define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
>   #define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
>   #define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
> +#define MSR_VMX_BASIC_ANY_ERRCODE                    (1ULL << 56)
>   
>   #define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
>   #define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)

Thanks Paolo!
I forgot to post refreshed CET QEMU series which includes this bit enabling.

Reviewed-by:  Yang Weijiang <weijiang.yang@intel.com>

