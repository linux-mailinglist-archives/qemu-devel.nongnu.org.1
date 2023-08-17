Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EE77FC1E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 18:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWfre-0005tx-Gu; Thu, 17 Aug 2023 12:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qWfrc-0005tl-CM
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 12:28:48 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qWfrY-0006T6-Kx
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 12:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692289724; x=1723825724;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3daStf2sgoTib2PduYn/ubzhDGohBty370OtodfE0F4=;
 b=gySA5XBQOcEGckuoeUeske9GlrXn4OZxa4l5sbag8Vo1sjwoBEueGmq6
 JYpr+E8JiS1bIt5tmvVWuH83/Hv59zmF2WuhNTtFO+zcVIu3yFRns7/vr
 nAn4cOJdMGOp6TvbHHBhdKyl13Xle4c3hEM3Q3hG4pe9dK5zXEZgxNX2Y
 QPtlDlBpGIh3abWaiRyUED1TO/xc4fnFqyZAxzxRjcrkOTte8k/awTXNP
 sMrQl7+UMu20eX1J37DARCkMfwmcT9qAo4tteUofGllWMJLjUoBcA9G2t
 xKFGJNbHOW1YTaKWTIvop6W82/P2UWmzd2lVf+wlTz/jDq2F1XwKukquO A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375645069"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; d="scan'208";a="375645069"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2023 09:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800125674"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; d="scan'208";a="800125674"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 09:28:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 09:28:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 09:28:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 09:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxJI49mmJaa96Rx6zcQaSAEl4+4AD8GWsYROS1Pnag3d9efNUKyyO1I+/LlYtXz8hRf6WfGdLMZ/CUytwHwfQkjSQpPQ/Yuv6IiB16tBi130LDUtjvrxl+ir0IiLAn5pKrbX2NrUcIxua5tQyRzgZ/UAUVsIZFfyHmhYEzlpAgQ3kiZZPxD2eq3As2u/n/61u/ZO0cQ4yk8OXtyRzpmaPPhTetejWcfrc5awusTKa2F3P8clSFuA3XePT0oblhZtFJJeh5WwtcEHe9K3MwkChXAt4x2gH5On4/IEuBsLu+a+P3Pxjkew7NLZLH+WiWZxUbCsuorluARpOS3hCgN+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXkBmp8oPtyPD6/NhXvLnnauHp123mzkwRtb9QkKqWg=;
 b=ilQifJC3Q2XbnbbGQ4eQ9HrAUK9vkSiG/O7bkDtfggmEjiuMQ5FnaEGFRozBrlk3+I5GPuTixOZKDV8xUQK5pmeu/OGvShgIQhg5Hhl1IKGpEmaBxcKhb0BqcicJ6s4dVCGplwlqS6xpKX8cODo3MUmziAk5ns1h3Q9jis+GzIznPSyzaWydfv0A/PCB5kPGPH6mlQXHase+2Q+HgaBnGRswpSEiAvj/I/7AJn36hYp7A1iK1uwBl/hD+ufjDvZer/DuZD1mcsTb5CZ+bwawaq0FwD3jASUnPSMT50ISAx2iC45MB/jRFclh0wMcvwF36CgFzmUjmGEeJ41C4m28+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 16:28:34 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5%3]) with mapi id 15.20.6631.046; Thu, 17 Aug 2023
 16:28:34 +0000
Message-ID: <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
Date: Thu, 17 Aug 2023 09:28:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, <qemu-devel@nongnu.org>, "Michael
 S. Tsirkin" <mst@redhat.com>
CC: <marcandre.lureau@redhat.com>, <kraxel@redhat.com>
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|BL1PR11MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9ba8f2-5f7a-469e-82d1-08db9f3f007c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDQfcxfYxhYhhbaUYl4kzYpMONhXFXLNIa1qrOolc+3ZIu+AGXIB724uajXb5FUm36l/fD8FU7eFI7Yl7xiMWc7OQq1SnTJDI6DFWWeQLJHLLylZg/QyBa9acqDrndYGXLOnzyapJJYeVuLM/o0iXAhi40Rtet3orQLRWDkY69sHGNX2LUWaB7UxsbptpPrdI1JNEM7rbwhA4m2VFfgQIiGiR+ilE+cUio5M9GtSNlAyoaB6aT90wUzjwZTZc3dYChbOslyKG6e3KhXC/YRcEk2Xv0bByNYAcGDi+cBhOgMXd2QDDmSlzvquniXdDQU3/Rmmx68D+yGPI/rw3k7cUZ45r0AGOrfG2kEURtvyBt0ID8ngw/Jud62q4YNHqmZEYBXG0oY27aZ+m8PKeBch4fnNvOiPrYZrRdOVgQLTinfIY3yuUKZnq62RGkst9V6VSd/hYwuHlVuKLHAQcKB+3PVuqO53wBk9TcrIUHNKsw2Bt5+gxTXS70ZsI3Np/NRgbImUfz84BX0H72KI4IfFb/llN/ti6v64os/PSuSuAZswSAMkAAOfruAziupndZ3+gNsshdgXXi1qQpq5MOJn1ZHdpU6nBI2P9XLN9k9alMVslS27UMI70/LbycPjZnKddY9l5u+8yHCU4UraoF1HkvdhTzqfOmSn3s97fn/Km9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(82960400001)(38100700002)(84970400001)(966005)(2616005)(110136005)(5660300002)(66556008)(478600001)(6506007)(66946007)(66476007)(53546011)(6486002)(316002)(26005)(6512007)(4326008)(8676002)(41300700001)(8936002)(66899024)(83380400001)(15650500001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1F3V0xIb1dxNXFVV2RRU2wrT2FJeWNmSThSOXdlWVVYMEtCeVhXM0ZrWkY3?=
 =?utf-8?B?Sk5CWnQwbExsL0M5N3RPQXEyWE43Q0k2ZTAwRWxkc2pmbEppVGMwVE9OTGY1?=
 =?utf-8?B?eFJsRCs0azZ6cjVYNEdRaXVPMldiaUROWmxNWlFTb21hdE1rS1NuWWZ5T2py?=
 =?utf-8?B?VjM1cFVUa1luZlFiSEVzTzZPazJGZkJNeWRNMWxGc1VZT3kxbERuN0pVT2h3?=
 =?utf-8?B?Qko4Z0R3OTRNdkYvQVVrWTM4SGFSY3VJcS91SnVXSEtmdC91VFl6SitsQTVr?=
 =?utf-8?B?YnJiR0c0Yk9lSitnQVBnRDFqaEkxT2hDMGZYVkNvRGhVQlFMRlp6R0N2RDlI?=
 =?utf-8?B?alUxNU5GK0l4S3hqcTNiQVp1MnZCdWl6ZHlzZnliTW8vVlVxOXN6RERacjFq?=
 =?utf-8?B?V0EweFZZM3ZxNVZFUnBDWDJmZFFkT0t3ZE8wY0NNTjBsSlpVMklERGRDVXFy?=
 =?utf-8?B?TGlFYSthNythdEZ3SW1TSkxPeW1kZFlDdFhtdkRGdUFkSDUwTnVCWkJIZHlw?=
 =?utf-8?B?UUZYVzZsUXQ5WlhGL0pwNDc4dE5BUXFweUxPVEcyODA0dUgwODB6K3JqK2Jy?=
 =?utf-8?B?aFZJS2JWVEM4Y1VqNGRIbDdrYmVlZm0vQk9iZnprNzNVblVIRVBrWk05SVMy?=
 =?utf-8?B?SnlJMG9IbHFtd2owdWR4Q3FsOW85aU9vWFRmSmhLYzJVV094cXBOd2g2SjFN?=
 =?utf-8?B?Wi92R2Y1R2FDajFpRE9yNVFNYm93ZkFHWk9sZ2xJRWFsMUVBVFJDVHJxMjhT?=
 =?utf-8?B?MEhxR0hoME5aSTBGU2Fzam9BNXQ4cjdCbENwRGxCZFJaZnhHeUJFR0JuK0hC?=
 =?utf-8?B?VGIyTk9BN21jUGlYeVdFd2JsUVJTTkMxL0RPYm1kVXFuVnFBWm5yT0RzaFVN?=
 =?utf-8?B?c1ZMK1ltRndmL0UzQjcxeHhyaFVObmRFa0lLVVQwbWZWeldzYTZzSE5kVHVQ?=
 =?utf-8?B?WVJnajlmdFBUUkxRekhmLzVxNWU2aWdoU1NPeHZuL2NiSm1kWnp3cnNDU1RR?=
 =?utf-8?B?UjFZRSsxS3pYcUdNcmZ0eXlxN2lTZEpkL2I3bjh0ZFJBdnRmNk9PZE8va2pu?=
 =?utf-8?B?NU04RFArYS8yRENMWHJUdDIwWFlvQklwNThiMUlKUk1WQTVyWFdLQnExSllU?=
 =?utf-8?B?ZGlxVEFkM29MMW9iaTFhbVdGUXpKWXhnUldESHIxVDVWd3MwNjYwcnVkeHZu?=
 =?utf-8?B?dENwbFVpd1U5ZnJXd3hYZUw2dmUwa3B1K3JjanUrU2tzV0dQbkFsakF3TDdO?=
 =?utf-8?B?N2dYNEkxamJTUURxZjFVd3V5RjBnMWM3cVZ0bzB6M2pvZk4zNlR5NENRMGJs?=
 =?utf-8?B?NFVLcVhGMTAzZXI5UUEvNlZXUlM2UXVtRWtueDRpT05OaFZicU02andXaWhp?=
 =?utf-8?B?OU56dEN4YzNNMk1xYTFwNlJOWW90T1dTMi9OTHZHaXcvS1doZlNzNG1QVUI2?=
 =?utf-8?B?UWNKVTB1aHJoeXdZNmVxMUpRcDN6WllxMlVpY1lXVk5YYTY0RDhJd1V1eVd2?=
 =?utf-8?B?eGJyenJ1bUgzTHdRMmxZRmV0Tm1RQnRYVVdoVjRJQVcydDVHVlQxMDV1OGpQ?=
 =?utf-8?B?bmFodlZLVmxHWVNGN0xDTkhpQktkL2twUGc1SzhRalhwVEJ2WDJDQUROYlZz?=
 =?utf-8?B?UFQ2RWtWUHFNcmhVSFB5ZEpzRjlZWXVySVVMTnVadE43WXRFWk1aUnlEUmFj?=
 =?utf-8?B?VmlyRTJhbGJrcFF4Q05LM3RSTzB0S2M1dHdVT1JTVTJpODh4RFpaY2ZyZWZt?=
 =?utf-8?B?SnlLYkxoT29MeGFrTzFiMlAzWDlrWkx6TkZqbjFxMTJqWTkxVVRJOTB1VDMy?=
 =?utf-8?B?OTFGZnM3RTlRalNaMW53WkdRQ1NnR3p1aEd5MFpsdnM2dFVtU3JJQWFsY0hG?=
 =?utf-8?B?TDRtTDhtTi94Wnk2RVQ2cFdLamIyMFNveGVJVUc5S2doSWFESXcwT3B2Vi9E?=
 =?utf-8?B?RnBSeGNPLzlGdWwxQU9xeHZRSzVQSWVGdUhzd1NzYTUrRTNxd21mb05OdjZu?=
 =?utf-8?B?RSt1ZTZXa1duanFkb0l2dDR3ZTlmY0FPUm83M1BVQ24yc0J0NmJvcFpCS0w4?=
 =?utf-8?B?aXYybXRjYnZ4TW9HTjU0ck0xN2NBT09FOTJqSUtiQTNZTXNzSmN6a2JQeEZC?=
 =?utf-8?B?Ny9uZFVGUVd6N3ViaXNsbUhpa045REM2VityNjhCZWcwMGhLcWxqRGhhbHdL?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9ba8f2-5f7a-469e-82d1-08db9f3f007c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 16:28:34.4044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSdDl1xGzqLM2dDgiTaUixibmGWWz3Zzw36e5r9AtiOsIrGND9wy0+cD4d6GiZsjRC4e+XumeLKbu9Liqhjt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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

Ok, this regression happened not just because of renaming. Originally 
width and height were representing the size of whole surface that guest 
shares while scanout width and height are for the each scanout. We 
realized backing_width/height are more commonly used to specify the size 
of the whole guest surface so put them in the place of width/height then 
replaced scanout_width/height as well with normal width/height.

On 8/16/2023 3:31 PM, Philippe Mathieu-Daudé wrote:
> On 16/8/23 23:55, Alex Williamson wrote:
>> The below referenced commit renames scanout_width/height to
>> backing_width/height, but also promotes these fields in various portions
>> of the egl interface.  Meanwhile vfio dmabuf support has never used the
>> previous scanout fields and is therefore missed in the update. This
>> results in a black screen when transitioning from ramfb to dmabuf 
>> display
>> when using Intel vGPU with these features.
>
> Referenced commit isn't trivial. Maybe because it is too late here.
> I'd have tried to split it. Anyhow, too late (again).
>
> Is vhost-user-gpu also affected? (see VHOST_USER_GPU_DMABUF_SCANOUT
> in vhost_user_gpu_handle_display()).

Yeah, backing_width/height should be programmed with plane.width/height 
as well in vhost_user_gpu_handle_display().

Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.html
>> Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of 
>> QemuDmaBuf size properties")
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>
>> This fixes a regression in dmabuf/EGL support for Intel GVT-g and
>> potentially the mbochs mdev driver as well.  Once validated by those
>> that understand dmabuf/EGL integration, I'd welcome QEMU maintainers to
>> take this directly for v8.1 or queue it as soon as possible for v8.1.1.
>>
>>   hw/vfio/display.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>> index bec864f482f4..837d9e6a309e 100644
>> --- a/hw/vfio/display.c
>> +++ b/hw/vfio/display.c
>> @@ -243,6 +243,8 @@ static VFIODMABuf 
>> *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
>>       dmabuf->dmabuf_id  = plane.dmabuf_id;
>>       dmabuf->buf.width  = plane.width;
>>       dmabuf->buf.height = plane.height;

One thing to note here is the normal width and height in the QemuDmaBuf 
are of a scanout, which could be just a partial area of the guest plane 
here. So we should not use those as normal width and height of the 
QemuDmaBuf unless it is guaranteed the given guest surface (plane in 
this case) is always of single display's.

https://lists.gnu.org/archive/html/qemu-devel/2021-09/msg04737.html

>> +    dmabuf->buf.backing_width = plane.width;
>> +    dmabuf->buf.backing_height = plane.height;
>>       dmabuf->buf.stride = plane.stride;
>>       dmabuf->buf.fourcc = plane.drm_format;
>>       dmabuf->buf.modifier = plane.drm_format_mod;
>

