Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF0E74A384
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTHR-0006uM-L0; Thu, 06 Jul 2023 14:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHTHO-0006tk-OG
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:00:35 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHTHL-0001Jt-MD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688666431; x=1720202431;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fSbgybbi1xyA+98NxDfw36m5pCLsh1swwI+QAf1wzpg=;
 b=RxXJ/UAhtikSszqwEJTj+02AtBVrxW4wD36V7odfts0BJr8pULOwoeR8
 aKNeIet3jBU5ypFZw0CF/a/k7nnrVoHPmEF6eHAmWAj+vDxJtA6Vc7IS9
 APceErzTMe22eHjGQtkcx0Q9mf7Dwz0wrjZKp+v8mZpF0UCFaBeYuQEow
 CQijJeAHvv1CDL1aQv3BEc7HPIk5ZbX3j8fAUqyJm+xnalup7YMfa743m
 8RMh2rQRtNT2EURsUm9vmqv/rozqRO7d4inVyRiuJtdY9houTqvPvnVgr
 xwpjfxx7ujDZ+bxrNyewUatdNarafc8D9KXyRTNQ5nl4qsPpQQwKGPNmU w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427361132"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="427361132"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 11:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893649437"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="893649437"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 06 Jul 2023 11:00:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 11:00:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 11:00:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 11:00:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 11:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpwp71MFzesC2oWgiNMOAe+lUtMZX+kwCwD/vRvhuQcQxeOWjAvaLJhy1BHSoztcA3UZRk4/3/IPyvH5zcUorH/mp1ljuai5KbB6pPjdqkXmLc1CJMUK0dOzoK8Mu3YMpBn/YcojbCctSm4ncyE9DyX9LX/YI9WmdrAY81s7sGWc8e6wT5Lp71T9uVI/qSL7KGRRtua4k1Asgp1abdMoattm46vQ0sp3sMVnPFzc4ZLxGc5oBpAC+YDdaY6CLA/cVxOIPrjwg+hNfG0aJgHtmZgKsCANcrqqwpvLcJuwVvpML+2G4vuesHY5BFd0RcDUuiem1nclloTX9d8TgwtThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RhcDI3/wmKwpgWMUgvhwgxGPcQA0myuldUTDbl8RkU=;
 b=a76+sb8Bv643EpUyKG8yP4xrmuMLNpEaAZ/HhqP82vhGA+ltWwT/9oIMhHV8f8xtHdVBPB6zf03znEyQ8xWi2QDQYlpWfudWzFuXGIP/x4UgcgWKXWYWiVxoeoRUmT/w2CPRqGlZrWu53U8n2bRztvXihR3ucp/M+fGUPCL87GxS0tvg0N1CB1wWriqd+mm9B47m6/lmHNOtRP89Ej8l2smAwt2kCRwAkRPPnJG6ZRvPvmPkXCoqC/n20T3j2ufvf2CcpjsVi+tCY3ccgmlWBwjaspWRupcWRChUO2OsB3P6XhFT6fev/SXlZtV9Eg58fBu0v5xr/yx/ikfy0Ua76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA0PR11MB4734.namprd11.prod.outlook.com (2603:10b6:806:99::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:00:25 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 18:00:25 +0000
Message-ID: <7b432804-c651-4cda-a18f-0098da8c2ff8@intel.com>
Date: Thu, 6 Jul 2023 11:00:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] virtio-gpu: do not replace surface when scanout is
 disabled
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Vivek
 Kasireddy" <vivek.kasireddy@intel.com>
References: <20230627221139.11250-1-dongwon.kim@intel.com>
 <CAJ+F1C+b8OXuTVS7oVdP+pvm8arSBWznxDki2TFttmRdeWqb1w@mail.gmail.com>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1C+b8OXuTVS7oVdP+pvm8arSBWznxDki2TFttmRdeWqb1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SA0PR11MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f60c517-59cc-4b58-9845-08db7e4adfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9nAHaSewavJ+N0WS+X62jjczQxAU4iFMFQEG9jmmldzVKRp5O5BOKtOGRy+xlg/6n+CKopKa91DoU88IuwkfcE/pUbwcXdOs25UCHpBYldijGdxKEi3XipzGx41DObFtb5eme1l2QZsbNqSw58cslhf8Q217iQ1dlVmJfX73v4HF4VIjSDnaAuZOoYyCm/eV0mqaIzeP/p4HAusHV28t7WpE7tq6OMw2TIA2oGz/WlCK6zQznCf9xmYq+dkL5saNj9WBE05Isc6tL2D6KjVEkbwfIqyo9KpORjZynrrLMvgYYCT/s6Av28QDSThIvDumHwGeabUPH4ZAT7IrWMWnxowseFbrY0evwde8lYSeHkHe8bj7Q3552joWrLuXYY+66pwdr+AgpD65v76+m0FF9h0J2+fAIvt/CKmnCx9r6BRsr4y9kKtNlZJODZQ3u0fgxUDhNnx8zJ0yzI13RX5teViCCsJndMIUygRGTkjnvi4b/4fLNS46v0Neg3ghVw8khZE5DvWO0b7JMjqAXbHNkhvZVWx6zVAfTKbkh+0qKMG+u2QpqudUEoW+76mx7crUJdrYN65pmzSF/0x3dw7jJ7D7PQgGpqe2aGNrIjNWD0gCeUI3ry1H4ikHq4Il/1goay2556W//GLzs3fgSapeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(6486002)(478600001)(54906003)(83380400001)(2616005)(36756003)(86362001)(31696002)(31686004)(2906002)(66946007)(6506007)(26005)(53546011)(186003)(107886003)(6512007)(82960400001)(38100700002)(66556008)(6916009)(4326008)(66476007)(316002)(41300700001)(8676002)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlRwd0ZsQjdVZFY5dGh0RzhWVWpQNzFaSFUzbW5oTFZnUzlJRi9FdnY2d1dp?=
 =?utf-8?B?MnRtNS9sS1c1cWpUUUdSVDA4a0JxY2FSQlVaaVE0YTNHMFlSY3NTdjFIdkVK?=
 =?utf-8?B?VUVkUVFTSHdGSmpVVG5UVS9xeXF1SGRUbSsyZExoVlJxRjdnRFFtK0tpeEFJ?=
 =?utf-8?B?N0JxZzJmTmxzV3ZPZ3p0Nk4rR2dNeS9GK0Y4L2xHQXFrb3FNeEhDZkVRbmlq?=
 =?utf-8?B?QXFiS1lhMEt0N2dwU2ltd2F3ZG45TDRodnk4T093angxOGZITGhiZzY5RUxW?=
 =?utf-8?B?S0F5YnUxM0dScjI3dzEwM3JRbS9wM2FEemp4T0dybjhUYzk2MXpya2RVdllD?=
 =?utf-8?B?NnJsRVJUOTh0clR4TlNNQng4NXlkWGJpZnN3aXBZSmx6cExzdHV0R3g3R3d0?=
 =?utf-8?B?TCtMZG9EaG1ZOElIYkltY1ZOU1ZicklSbjJtaS9LdEhGUktFTzEwWUVYMGtw?=
 =?utf-8?B?a3hHeDlOK1BCRjZUcktZaUJ1Wmw0NjBuR1FLR3B0eHMraXlSOWFGRDEvdU9z?=
 =?utf-8?B?ek5XYytQVVkwalg0UnRQOGFKdkEvT01kUTdYcWxybTFaa25pYXplV1NIa1l4?=
 =?utf-8?B?ZTV3cENPTGVxWk5jdkJpZURrWWExMG9PTURpKzV5WHF2TTlBMkxlSERpMFUw?=
 =?utf-8?B?d1ZGTk14Z2F0b1RtSGtqNHgwaWRicGlOZzloWElWeW1qZkpyU2dDZWNPSWFm?=
 =?utf-8?B?TlZPaGhOWDZQQ3RMY0JBMHhuUDR5VGxXUERLSWdzazhkVEc2V0hDaCs1bWhk?=
 =?utf-8?B?YW5xQm8vdzdtZ3k5bEVLQThPdXVyQVJ2OEhQTEkvR0s4WlM4c21oRm1Fb0to?=
 =?utf-8?B?TkcwUGtBVnROejVEM3BwZGZIZTJ4aStVY1cwSngrVk5tL2lXWjFWcmtrOFNN?=
 =?utf-8?B?RjJKNklWZGFLWjd3M1NERmRObXpyd1NUOEtsN2M0Y25nUFRSS3lBcnh3NEhT?=
 =?utf-8?B?UFhqaVdHclRNNGxYc3JQQ00yVE5MNjdTa25KVVdFTkFsMHFPbWRmZHVvbUJ5?=
 =?utf-8?B?UldmdUdxM0tScXlKbVFUVGZUZVJYTk9xUTIwdWhYbDVpYU1WU2NpWkRqcG9h?=
 =?utf-8?B?Tm5SZldmV3hlZW5KUTVWL1BYQVFBQW53OC9yWmIyU1Y4MHNMNk5qakJFMHV5?=
 =?utf-8?B?cjhtVjhRSWpVbk1SU29TOThZMXlhMjJaNFNFVVFnbjRud0c1cUREb2IwNDkr?=
 =?utf-8?B?RkdIUEgycVg0S0thZXpDZWFjb0JWTWlDZndzZHZyZEZIUGtyenpYNnFqV0JI?=
 =?utf-8?B?RGhHYW5WbXdwbkY3a3Qrc1NPLzUrZ3ByMkI2RHV3emtWbElZVjRSMi9ISUtH?=
 =?utf-8?B?ZWJmWm16VFNJcEgrUG5LRXNYQ2I3bXlLNXgyUGppYkpmcDdEMTBMQkpIaVkr?=
 =?utf-8?B?UGRyeEFid24wMXRXUnhMTERXTXdPTXNqTWlyaSs5Z2xnMm9iQWRWUGNxcjhl?=
 =?utf-8?B?UWExNS9XS05IWk1yMnhqZ000TzVOMHgvdHpuTmxUNG5OUEUrSnRmZFNwZUFm?=
 =?utf-8?B?cWVtWFBRc2lpS3B0aFljMWlwaXpxWGwvQnJLSnJ6Q0N5Q0p3d1Ira0FVTkt2?=
 =?utf-8?B?aU5TTDdzd0dxMVk1cS85d3IvMDcxY0IyU2hIOUUzZW9uOFJ1elBTbVlrZjFw?=
 =?utf-8?B?dWNWU3plT3JSU09tRmZyYm9WK1hWdGwwb3N1MnVWa3EwZStaaFB1dm1xeWp6?=
 =?utf-8?B?eExOQXZWSzExMG0xVXhraXRYT1lUdnJ5N294bHhrWVJZeGxoWWk2US9aQS9u?=
 =?utf-8?B?MWMyWGg1cTlCV09Ld2lXUTRwK1doV3p5aDlBYzBZYUo0ajJxWlF6T2lqd01O?=
 =?utf-8?B?a3dFUnN4NHJjWVQyT0svTEd2dmREYzhIWm9kVW45QlBCMUN4MmE3bVFWT0Y0?=
 =?utf-8?B?WEFOZVlyRHFLT29paFBhcGFMUi8zR25CNFZHeUtqVTVPcUxXMkJ0UTVFdkN6?=
 =?utf-8?B?TkhQeHFjMHNrUVBjOHNDZWJXZHM5blJRdGxUMkM2OHZqUDJrOG5CdWFaSWFK?=
 =?utf-8?B?MW95UUx5akh6ZzZ2QlM4QWhpUDRRcHJraHFmMmowWHZLaklkSDdCQnNGM2Fr?=
 =?utf-8?B?NTdZdW9oSXl0VkZyby81NkJkeGRkRHpaRm9rRnl1UXlTSXFHTEpSK0ZUck9j?=
 =?utf-8?Q?kM+g1hHVIQPb94hmsx/l7aya4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f60c517-59cc-4b58-9845-08db7e4adfcd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:00:25.2055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRzMlKWsoSDHzRn5tg/+Ka+32HMQQqwW+7H51aqKxvsN0I12oEZgxaF9Gx74zEJ3V6pUXB6JKWR1fE/S4quuiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4734
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=dongwon.kim@intel.com; helo=mga06.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/4/2023 8:12 AM, Marc-André Lureau wrote:
> Hi
>
> On Wed, Jun 28, 2023 at 12:32 AM Dongwon Kim <dongwon.kim@intel.com> 
> wrote:
>
>     Surface is replaced with a place holder whenever the surface res
>     is unreferenced by the guest message. With this logic, there is
>     very frequent switching between guest display and the place holder
>     image, which is looking like a flickering display if the guest driver
>     is designed to unref the current scanout resource before sending out
>     a new scanout resource. So it is better to leave the current scanout
>     image until there is a new one flushed by the guest.
>
>     Cc: Gerd Hoffmann <kraxel@redhat.com>
>     Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>
>
> Why is the driver not setting a different scanout before destroying 
> the resource?
>
> I think it's wrong to not replace the surface, as the associated 
> scanout resource may be destroyed or explicitly disabled for various 
> purposes, and we don't want to display garbage either.

Yeah..I got your point. This is to address very specific to our use-case 
with windows guest that runs virtio-gpu like driver that does unref 
before the next framebuffer is set. And I agree that this sequence 
doesn't look right. Let me check if we could change the sequence in the 
guest driver.

>
>     ---
>      hw/display/virtio-gpu.c | 1 -
>      1 file changed, 1 deletion(-)
>
>     diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>     index 66cddd94d9..9d3e922c8f 100644
>     --- a/hw/display/virtio-gpu.c
>     +++ b/hw/display/virtio-gpu.c
>     @@ -387,7 +387,6 @@ static void
>     virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>              res->scanout_bitmask &= ~(1 << scanout_id);
>          }
>
>     -    dpy_gfx_replace_surface(scanout->con, NULL);
>          scanout->resource_id = 0;
>          scanout->ds = NULL;
>          scanout->width = 0;
>     -- 
>     2.34.1
>
>
>
>
> -- 
> Marc-André Lureau

