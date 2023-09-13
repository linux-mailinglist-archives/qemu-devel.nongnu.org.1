Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E0D79ECB8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:24:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRj3-0006PL-GP; Wed, 13 Sep 2023 11:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qgRj0-0006OO-PZ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:24:19 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qgRix-0000yy-LZ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694618655; x=1726154655;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dkp+BoCgF2di9RLsWoNBpGtG55qAGh5nbP2htuFwtGc=;
 b=gP9M055BiJuLs06yRe3WjgoSh/gGCyslqw/MThY9AQg/aAVeIPi/4Zp8
 wktRRI4pDCbyrgAgY8CmfYMDQb4nWHVE0Ft2CseNVy0c8OK61ZdzoRCop
 dqv473w6sDcg7AOY0C05JpnQTLNKd/DQsjwhzy3FguoCCNuXkpiuMX53P
 REhvFsyDTd8zwXIfTQWPf4oNLgtXsTVSMz0CVD0eZzDD5JCEuTsInXaXt
 ek2OxxW4aX5+iPeauGJ/Vwwm0iDe0IjwdROFVAoKK0LlbgE6J88KOHR6i
 RH8WJUjucRSpBozwISu95NZEsJVnYyfgZZdOXxHzpdWoiN0Ms012j0V8s A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378602676"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; d="scan'208";a="378602676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 08:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917874491"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; d="scan'208";a="917874491"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Sep 2023 08:22:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:22:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:22:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHV8Pl5MWgvK+6/a/IwiFhtaLrhrRkoMM/T/Oe59oHVNzBqvprAY1WK4WTS71ZTDxMkV3A8oCWZ15Nj+cDNosK/1Kbj+d+YlMZWMDGzNz6Sz9Tim+EEUqtDgc2uQ1klA2XzTCIyU/pv4WyNxCk2VeZlQMUdfINlOAwi521WMISPQpl+MqbkWcLZQg7bE9GqbmEM8c+EznnRSUYX4Obvzgaf5VGI0yKUEk04LC72P1gF1YWINbROFrXrEtXzA2jvVuLir/XIW3wxUKnRu5MwGyU5DeMREZOvkazgCJmPFy4sB3Pjww2DfQBeKxhxqrfLnJE+0q3FhsmdJnK4qk0WRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD/4sRRJbYZ++mM+/szOHT80AGkbbsmaKgaRLWNzMXY=;
 b=PIv9rNAmenjz7lfTIzDHK5HI2Sg6Il4/6Mse515+aYv/RuPgCgxO8ymVHp+7rRErZi74CQW3+mqr4eSS00aPBqbx9QzHx6InsgiHsN3rqpQ840kDahIYTpBPfAck7JB/I4YjjnD9HlSrzwd8+bgGApupoCkm0Pv+Py5gQmm3B6XKX2Yd5vYZCTfZjWmKdwQ4k7G7GCrjxcvpP2c+FiF0hpNTlvIhh97E/l4lfl8KHiggfNVjvQE6zG/Web2cyyKoorns6r/2yIdbDk64AIaMIJbFNgTD0XxaC6E2q7iZnmRlKr1dQ2Z5fMHF5LrcIsk2uF4qTvEAKX3NANFsNALh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 15:22:46 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:22:46 +0000
Message-ID: <224cec62-ff6d-82e7-b262-72d5cb56b55d@intel.com>
Date: Wed, 13 Sep 2023 08:22:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 1/3] tests/acpi: Allow update of DSDT.cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <qemu-devel@nongnu.org>,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
 <20230904161847.18468-2-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230904161847.18468-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:a03:100::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 484d8dbd-7614-4e0d-82f2-08dbb46d4840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELdWTblUjoHKdppMa6X6tgURo0EnCgWNy+Tc+PVK/ozPUBV6NOeVoimuFFpb9zXzgInhsVOnGHkLkxQrOIxgV1y8WED+GC1kxVEqJOIXwSoZqiaI+LlogJPJRsp187BKarqmqZXosnWD1dwEloOS0XhOWYMI1DJXRe1/5nhnpZD8ynTz5vaFbSWpZM94ff7D30rBIFj5k8/gKvf1Y43jWK4YWQ6nZ6AYJA1wfh86X8AxCZm/26oQnuzyuVtjeWHKC8yzSdgF3noIa+Dv4e19bhCmh7MyniaqubMVJNKC3cseAd5b17B6/WN8OhhAxGfFKuzuktqQCFAMqyNZzNn+SCxH3w7s03HsZllIjkfD1EXrJrVuOAAwEQwjxe+Ac6ci1/FL6Z3LKC1QDbd8q/xEC43phvmZxMnvTEHkYfOmV/CpgquPvYXdETy2Hqs9hmIQSuAYBM2iIqWwuHoh+SvE4ll6E/qSAUK3obU9jvgxmWGnn7ybLDHXaZevY9Qi0IgdjTyoIaioYjlE1rC8xOfua50x35PWy635DmR5qv11p/w1pDQZchObm9vwPp/SpRt0mcdGHdEG6jPwPHZVulFwvR+NPZ1MjoBng1LQEQkuo9HvMIX/BZyFV4Ow+/3d6Vc9eIR0oYBBlBjwmE/6FYKLTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199024)(186009)(1800799009)(15650500001)(44832011)(26005)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(4744005)(110136005)(478600001)(31686004)(5660300002)(8676002)(4326008)(8936002)(6666004)(53546011)(6506007)(6486002)(6512007)(2616005)(36756003)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SENvMFFpdDlZL0NNY2JLYU9TM1NnOFNMVVNNSndZRVZmWnFEZnY4QUowNktK?=
 =?utf-8?B?TGJONmJ4Rk92dTlLdTd2c3Ayb29QV1RhVFpqQ1FxN2NFNDM2TFo2ZjJMT1BO?=
 =?utf-8?B?R3RLMDRQb1BWODIvSWJEUlRXRXAxQXhIbFVZL05oWFd5WVBHeEtMVFR5UWJo?=
 =?utf-8?B?YjZWamVHS094OGJMRCtSUG5lZEtqcGUyR2l5QWJmcy9tb2c4SHhyTHprQ0NV?=
 =?utf-8?B?Zk9JcGkzem5QOVcrbjMxQTViSjh0RHduRmp6T0NGa1E1bEpGdTJPSHRPd1Nr?=
 =?utf-8?B?REROTDRyQWxnZEo2VDBrV2RwLzlXbXVkTjZSa1dvSTE2WlpWNG1pcVNXQlRo?=
 =?utf-8?B?am9ZckZucnV1bmgxVy8xYUoxZWcvWUtBblVZTHh3Y3pWOXJVdm94cGtDb2Ev?=
 =?utf-8?B?T01xYzNOemFxWVVtTkEvcTVuYUhWb3J4Sm5TRnlYSFNDTktGeXhoUzA2dlpY?=
 =?utf-8?B?ZzlRYnVFd0p2K2hkSm14MXZJS2NodThGSlZ2SXMrVUdLd2hEUXFseUlyUHJQ?=
 =?utf-8?B?TjNma3VJYS9lYWIvbEJlZHBPOHloaUxLUFlmS2h3QWJya21HVUlvU0F5ZGpz?=
 =?utf-8?B?anhhTnd4cm5kaG9CbUhNKzQ1blFUUnBNbVp3WXFvcWVScTJOQnhQZEErUDZ0?=
 =?utf-8?B?Q2V1MTFUY2Q5Zis3cG41d0wyQTk5UzduUGJvaTN1NmEzYWJVOVF2OEwwRVR1?=
 =?utf-8?B?dEZ6VU01dkZRcGNyc2xPS0k1Sk9oTVNNRFZxL2dBMm41OSt6QkdGbXFoQ3lG?=
 =?utf-8?B?MzdWQVY3YTVDcnBBdy80RXNwUkJEYVBHWklJdmhOQkkrZjRWY0dJTHV1b0xS?=
 =?utf-8?B?MGhaelVmS0R4UmNaZSsxNmdyN1R0R0x5QnlEOFBrQ1IrR3kwdXQybnZUeW8w?=
 =?utf-8?B?NVhKT0xZY2xLMEhlZmVJSFdkME1vd05jS25iZHJmZDlpOGJpWkpyV3pzZE1l?=
 =?utf-8?B?cjVDSy9yc0xuNjRsUGo4MnVmUXFnYTFZUDlzMUxrak5DYlAvaG9DUG1udnQv?=
 =?utf-8?B?cUV6TG4rbzZPWkJ3R3BZMWpTSnVyYVkrcklXb1BIQ3lSNFdaSGJpcU5BK0Rm?=
 =?utf-8?B?cVIrNjhUM2ZiVldpWTR2QTFuTWtmTTQ5Z3JHdlJiTFIvQS9kYW4xdEVuVm56?=
 =?utf-8?B?N0FFZlZWWDBVSjhMVC9GTGF2VTNHbkJWMzhhMmkzV3lyalJQMFhrL3FnS3hI?=
 =?utf-8?B?Z3AwNC9UbzIvbitGOFdraWVTSXpEeDVsUFJjT2ZoSW9GMVNBdVA4ekpocnZx?=
 =?utf-8?B?bi95OVJ6NGk0aFhVMXdBR3RNUnlYcWRLSmNXOVVpdkZIOHlxMU9DZG50N09P?=
 =?utf-8?B?aTl5SEZvNktGamd0SGxQbkxOVzBIcmZUS2NsK1ZZRWxpZk1SVEVTMEJoSVVX?=
 =?utf-8?B?Z2hsZmRhTmNRS0toV0VTZVpTTklZNmxmQ29XS3pOOC9FU2FKenh1VENDV1BJ?=
 =?utf-8?B?SFUwS0dKdFovRnYvcEJRYUZmWjZFMUN1ck5iNVpDVUlzTDFyVGY5SE9pU3Fw?=
 =?utf-8?B?VzhyQUU1OTNVK0NPVi8yZ2pBT2IxUlRRb3VzZU5RSy9jVGEwNkRHOUR3WDhZ?=
 =?utf-8?B?NGtKWXFDb2hVYXFiSE5YOEJYTGFKU2IxK0xWQzRXVExmZXdRUmRyY2NSWUNx?=
 =?utf-8?B?TjBsYm9HZGk0TE5IejIrWmxDMm03TVZUT2FpZURKSmhqblk2K2ZVaEZ6dWRB?=
 =?utf-8?B?MXc4NlNsYUNlVDArbG5MNHBhUjhPeVZFT1l2ZjBvRFJ5c2tGL0dVR1MzMFhs?=
 =?utf-8?B?bnM4aXBMRXc1cEtRc1pTUkZTUzRONGIvc0ZhdnpwSTAyT09hOS9UNm1sUmZa?=
 =?utf-8?B?RVlVcU16dStIczFVQS94Q1dDb25sQmhmMGpFV0lwMnJ2eVUwNHM4WWV5UFMy?=
 =?utf-8?B?cmFkaUlhcWxLRHJmVzBlTHh2NFEzTHlpS1BrNjJROXByeFhrMTMrdG9ZSDNS?=
 =?utf-8?B?a0FOVytMMlRaS0NxbnZLbmdUemlFM0xSc2NxMk9xSXNHVGdBS1hOUmN3Y2RE?=
 =?utf-8?B?eExCNVlkRW9lcEZuTnlOaWQ5UlZJUElQK0pGR3ptSHNONVFtQ2VCSzdib08y?=
 =?utf-8?B?SGlyL1E2WDR3SWpXWXRRSUdNTVF2V2hXV0krbXdLMkdKTTRvVmkwYkRydzN5?=
 =?utf-8?B?NG1uY3V3aHFxQytVOHg0cCt0bjlGWGR2WmlrdG05NzZpVGRUblVmRXFyU2Fw?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 484d8dbd-7614-4e0d-82f2-08dbb46d4840
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:22:46.1658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfJvW5Ga9SCGBG6EtTLPOEz6+nkelFEP8F2mv7uziMNqRdKe0YwUh+uvskA76ptDdOKGsKtyTJSpxw6gaOLckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 9/4/23 09:18, Jonathan Cameron wrote:
> Addition of QTG in following patch requires an update to the test
> data.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..9ce0f596cc 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.cxl",

