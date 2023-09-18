Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F37A51EC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 20:20:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiIq3-0002hK-QF; Mon, 18 Sep 2023 14:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qiIq1-0002hA-39
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 14:19:13 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qiIpy-0006oM-DQ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 14:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695061150; x=1726597150;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Gbiex04lXtZIV6de3n6e7FSBPWe8Gs32SeiqAuZ84NI=;
 b=Iqf/b4QF7PdSswXrj8IhXb+NiLEvwREtBrh3DfzTVUEi4r3BUHyl2aPF
 RjQ8Qp/mf1Tq4k9q126ybtIU6i8Z5AgjX+C1pnw9GXC9qgGylL6X3KlCm
 ANFVvsvh5DlwkPPrT04dyPiSOFBByqS3I9cMOM82xXrBczNE+zIw/+EOj
 FukuuvP/R49v3SXMZV7u1E76gYwX4EAk97CqJzlFMOEl/yuPXW6TS7iuM
 sB6+PHi1ZtpkaIAMjKh5ZlxeEHt7Jefl9vL+2kqGkER+yG1ZR8Ra0lRsi
 1Qg5XGgc5w4+VYsIR0WdoQbAzzUhGPEarS+hs/vUQgszIvxVlbh09jcHo w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379645911"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; d="scan'208";a="379645911"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 11:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076684743"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; d="scan'208";a="1076684743"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Sep 2023 11:17:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 11:17:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 11:17:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 11:17:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 11:17:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsB3TGS8jkS+ECtp4f7nHdpT71DAiyIHS6INNknJf3X8HFZjshE6iPyKNKQMi73OAKH6OGBMUTEjQHqytzzDUod48bor6pxDzRHtolz0wXSpYboBHaAqLP0OmpQvGBjk7MMq0YOrsNhXa7OkGtjXpJN8URaFlgImrHVEVRW4IdusubGFu7iGfv7KPRQfE7+vaKFLtua1kTkwllIf0buLdzdog3tVRrV3m5DDEJ65HuLmDZDDMmeFHc+Y+mq/DfOq/ZUm7+S9eEQkDUzqx5FjbMNrrQEJUoHoHlpEp6ISUGSL9paVezt8raF9ezu1y47NCH7MdSFXNU/OtYAoBosomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZQk3w1qgAQFYLg23L7Og86rL+hy29QR5JGu3dbtN1I=;
 b=L/ekp7Rqb+VCLqQTty9lZYNpzxryEVYmzChS/PmGyp6ZRhJQTrDSc21kS4Rpl1oyQrAweVd9PRSJdUXKPg9RWUw/WM7FS2BgBgMYtZlZbsagmSeAj0f+opIABBiktNbegaJYJ/+EjHLUJ5aXJKi3O/PflQ1Ig0+xz935ENV2HO7egzJdUvOFOBwcEAgiuF820Rck1Lm+lzh7eFGa6LvBFzRTAykU7KUPdDBR4be0qS65eHjUvWi4mexN2w+omtbODlsyDUv33921mIp6ztqY1TYSzAGVp/WJcc/INIQ0nrmXZd0bsA4Xtjfi5ybypbO+voGEFHFh+MSfaHtZQtZGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 18:17:53 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 18:17:51 +0000
Message-ID: <1c4ecefb-cde9-8384-7497-4a874dc99cfd@intel.com>
Date: Mon, 18 Sep 2023 11:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
 <dan.j.williams@intel.com>
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
 <20230918180013.000035cf@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230918180013.000035cf@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 46baaea4-1481-41c1-6faf-08dbb873921e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVTPWB6xnEysEQUkRFmSsppL1FPrGep1CB5t2iwCFWRtyskhEkM0WDqjX0Ly4mJo/K3FDuP3kxXLPXpUr6gEDPDrOqaH5l+AoIs53FaUQt7n/BFmvQOrOmuaiDZRu3zaxNUQr7QaUfSGT+6GzKxBbUbq+C+JsaPZsw1XV3B9uNM084nD3sYci2lMqCzdL07ihAsja8Ap92H/simZa8RzLTZcW/7uGJzZLSJaQIOeTgVwjcKhwfremyE1IlbCY8YaIiAoECyd+845C4mAKODuPhsGucNSdltIulQOmjwdyIisPb+5XG+VB0RgbP2ML7CfXAiZfflmjq6eNbJlAc5NS6tvsXa5q6dAL8+7ZWVbhLEzpwxbSdTjlqTnpwI3F51NST2emozy6N7+LB+J56DypvucFbGiDuiz+rxKcwVP5iBi3b6o+/V+MpkgDsVCaT09fy5Y4zxHjOn6lQ78mz705388x9FgLR4wqa0mY68W00sjh0N90iwPh+UFbeEuYFAj4HNXhXbvYuhOGltnbYSCQpi1FLeLyyN5Jnx3mOug5RT1i70y0HEPBEpssYrOm4VELKhZTylHTWkNgZT20kBP82k9m81MRJmROFKFEpI2hxMimuLRTk3dNHTnSo0YMVitxFWRcuPQWSfInIXcuDiDiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(1800799009)(186009)(451199024)(4326008)(2906002)(8676002)(8936002)(6666004)(26005)(478600001)(41300700001)(31686004)(44832011)(5660300002)(66946007)(6486002)(66556008)(54906003)(66476007)(6506007)(316002)(38100700002)(82960400001)(66899024)(107886003)(2616005)(53546011)(86362001)(36756003)(110136005)(31696002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZCYmwyTStZdlB1MUUvbnVsQUJ5MlYyNnlYMVFhUXBFMGM3anVxcEcyRS95?=
 =?utf-8?B?S1cvRFMzcDJMK3JDRVlsK28yeXFzV2pUN094dmpjKzF2aTAwdURkRzlucUgy?=
 =?utf-8?B?cFYvYlF3MXRsOXhxaStBaFd6NFBQbFFpbnRDSzErZHRGd2J0bVIyT0hIeGF0?=
 =?utf-8?B?a0N1OW13eU44T2FlUGdPeGxrNWk0ZWZHY0Nuc2kwSnFmS215WndndUlwUHg4?=
 =?utf-8?B?OUtoejd1c25YNUdhZ3ZMNEdyUmlPL1Q4QU5EQmZzQmRvNlFVNlVWYkNTZEtG?=
 =?utf-8?B?UG4rd2NNNk1NZlV1M3pwanE5SVNMaktSYjZkUjY2RDJQR1AxTVRqbmdSSHRE?=
 =?utf-8?B?RFphY0RJaDhWdHE1Qi9kaDZId2dnV3UvT2wyQ1dCSmEwYVFOOXpndHhLS0Qv?=
 =?utf-8?B?TUFFa1lBM1lHYzEyUTA4MzE4NlFzR2lTOXhPb2VWQk5ZcTdWVEowTXBXUUJk?=
 =?utf-8?B?Z3pOemh3WEFsZE5zTGVIelB6WjNTcFVHNEU3eHZURXVCN05idEhyeXNXMU5H?=
 =?utf-8?B?UUtnRlRZTkJZSU1vcmRtWmNRY0IzK2tmbWI1T1BzWnhVL0M1bFI3Qm13dHJO?=
 =?utf-8?B?MU5EL3RjR0VMWThTQmJZUXZ6ZEJVTG8xQlBnUE5XTlRtYndYb2ZtVGtpWTdp?=
 =?utf-8?B?aUtZK2hVYVljYngzU3FiSDllbzhBa3FsWTRsQ0xIWTlKUHVheVM2QXJQSzky?=
 =?utf-8?B?bE9LU3FFZ1dDQTFUUGNFVjNjYlRUSVo0MFdkMC9EcHd1NWdPR3J5QTRWdEgx?=
 =?utf-8?B?RStMNnVjaG9yOG9GN0IvOGIzMG92bDVxVTJMczJkV3dHZ1I2aHhiR1plNU9x?=
 =?utf-8?B?VTl6TGE4VXJkTmliT1RzVk4zd2JvU2cvbmttL0xuK0NOcnZ3N2RhTzlxZmpq?=
 =?utf-8?B?NjF3bTBOa201MFd5U1RDbnpBZGFuSEtWQ1VxTWFLU2pjQXpRa29wYlBqUHVt?=
 =?utf-8?B?d0ZjdXcwTWpDK0w3dkZWUFFLaG81TnhkeFNvRHBKb2FWNXVodVc5WTZON0p4?=
 =?utf-8?B?a2hjOXJreFlXa0YwNkFKVnVveFE5VHM3bGhkcTZkcEZDaU5lRU1LUCtyNVFG?=
 =?utf-8?B?YUd1SlNDNFFjVzlNc3R4MlkwMUtrSmErUEg5NkpnRVZzWWdxbTZHMEhrRG8w?=
 =?utf-8?B?V0lIM1ZqYzNNZlJVdlRKZkJUMjZ1ckZiVm82Q2xWdVd4bFF5TmpsV0xtTWhm?=
 =?utf-8?B?dXJCSHhnZ0ZSbkRaWStpR3Q5SWJHZmNuU29ySTBGVlErbXYwM3NUcElpcjMv?=
 =?utf-8?B?NVlaT3BSclFaRkdFWjVjdnp6L3crL3JHU2pkbEYrUEFFdGxkWm5tME5uS08y?=
 =?utf-8?B?QmUvTStxNTJGOER4M3lrS1ZZQ1FzdE5rcGMrTmlBdjlwT0JNN05UWmxJaStS?=
 =?utf-8?B?N08wWHJTZFlOckhxZkxkK3lVU3BYcFN0VWRsSEhQTndZdkd6bWdUY2tsR1A1?=
 =?utf-8?B?V1NlTmx4RkZCYnAvUVd0KzhPdU13TUNpdU9XaWQ0MDZiT2U4MCtnY1krTUNF?=
 =?utf-8?B?a0locXduU0ViMlppb0lOemVLcWFVL1NaUk05SytEbFJvbXBkaUpNTCsxVjAx?=
 =?utf-8?B?MUJpeG9SV2xsa0NkK1BuUGtyblZwblJuZWNkQWFlVktKcUFtWEFuSkhhU0Jx?=
 =?utf-8?B?V3RGa05xNE81SEh3VWNpTEh5eWZlWTBwangzcmxSb2NyajBGR3h3cEVBaG4x?=
 =?utf-8?B?Y2l1K3hTOXcwODlFV0VrY0I0THk3RWl3NzBKN01zVEdpaS9SWktoZ1F6YlJW?=
 =?utf-8?B?QklvK0JQQURoTWFUQk1mNm1zcThJSEhoc2FBYTR5ZTVOajZZUzhmZFhQeHRl?=
 =?utf-8?B?OStNUGRDSjl3V294SkNrSW8vQ3NPamVNM0FaM005U3kxblNMeWp4dHpUc2Fa?=
 =?utf-8?B?NkczL1djUTNGbGZ6WXFlb0FuSmFDbXdDd1dpSnBnZEQ0aCtlczBITEZwT0Q4?=
 =?utf-8?B?d0VVMEdXZmdvaDIzWm9Ydy9oZ09BWW5NcDdmckJjaGl1MUhQVkZNdlg1ejdr?=
 =?utf-8?B?UHRNcFVzVkNpTGIxRnBwZDVCY2RESTRuazF2bjI1MnZUdlFoTFEvY1MvNUZH?=
 =?utf-8?B?eTFscEdiUlVIOEZXZTZ3VUthb0ZwZVhhMVVJd2FoQUZ0ZXpHdUlLbjhLK1JH?=
 =?utf-8?Q?Wr84jdNUR3jxKavNfegSZtXkm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46baaea4-1481-41c1-6faf-08dbb873921e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:17:51.7260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjDywph9utP3Kp+f7ECdYC31hnJ0o48PJh1fP72AXwTh2WmxqsgnabxDKHVp1/O9UqgdU/8kxoimWRYj4wzA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
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



On 9/18/23 10:00, Jonathan Cameron wrote:
> On Mon, 18 Sep 2023 17:31:38 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
>> <Jonathan.Cameron@huawei.com> wrote:
>>>
>>> This has been missing from the start. Assume it should match
>>> with cxl/cxl-component-utils.c as both were part of early
>>> postings from Ben.  
>>
>> Sounds plausible -- is there an Intel person who could give us
>> an acked-by for this?
>>
>> (Ideally we wouldn't have let more gpl-2-only code into the
>> codebase without a rationale...)
>>
> 
> I've +CC'd the kernel CXL maintainers from Intel a few of whom
> have also contributed some of the QEMU CXL code.
> Hopefully someone can ack.
> 
>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

>>> ---
>>>  hw/mem/cxl_type3.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>>> index c5855d4e7d..ad3f0f6a9d 100644
>>> --- a/hw/mem/cxl_type3.c
>>> +++ b/hw/mem/cxl_type3.c
>>> @@ -1,3 +1,12 @@
>>> +/*
>>> + * CXL Type 3 (memory expander) device
>>> + *
>>> + * Copyright(C) 2020 Intel Corporation.
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2. See the
>>> + * COPYING file in the top-level directory.
>>> + */
>>> +
>>>  #include "qemu/osdep.h"
>>>  #include "qemu/units.h"
>>>  #include "qemu/error-report.h"  
>>
>> -- PMM
>>
> 

