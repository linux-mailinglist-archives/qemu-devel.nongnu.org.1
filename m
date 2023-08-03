Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7676F172
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 20:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRciU-0004Y1-88; Thu, 03 Aug 2023 14:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qRciS-0004XY-2f
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 14:06:28 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qRciQ-0002mK-3C
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 14:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691085986; x=1722621986;
 h=message-id:date:subject:to:references:reply-to:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TBJTLDuV4+Rv59a1U6dmMgxOs9RLAHWCJ7MKCBk25GA=;
 b=Q8tDzZMHbrd6bu5ib1orViYNRsfySsFWb33NjxxNEDGR55VD3G2LEifD
 oBCEo+RMH+bEGGWUzRTQ3NuGH8hBvokuhTZilIOMvancoII04Ro12v6PQ
 Tgay9iH2ltSvNhqJFm7qh5vaYu/Q94DqmHs+4icxcdNdLGpwWQHdx5+WO
 WMgUDrXEFh+r/C9HuLa6drBL9w9mGfelj4LZPigZI4QTXDPzVRXpTpbd5
 0wvHE+nQNRscZboliDdTlcfOXlcUluytg6prZSN3hsiX6aOENuGgHLzvI
 O06jA6rxc4O7hBe521jxbDSWEDN0L8MRZCiuOhlzrY0QAvzg9JrLZcrFR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368858460"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; d="scan'208";a="368858460"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2023 11:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976207933"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; d="scan'208";a="976207933"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 11:06:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 11:06:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 11:06:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 11:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE9BLrrvp57xVrYgwDPwXR3ABZHnyvKGEjpxEF255zeV+MN4wxvEnFsJz3LbbNWdHYBoN3rjLR6bd7HLCUw/AQAsWIpMt0H5b/cnbcj5uJF2EL3MEJd1H5p6HL7dP5XMpT4AJ5DN7gyjMYs+j23GPHiV22Z7b61pHuF8Gkc1kP9yiNdjadRLPUQqgBBeV4m/jxS02lazUmKvYyUlw1tUPSv4RRyH/zvvt62tb8qimh7PKe274tyz9okPO01gkX6hBIg02JIwP6368m7F6PRB1QWinR+Wa0heu3+QCRNuHfz4BHzeYMYI5BwpP71oalORNs1pFk2Grel+iMbD865UTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH5KDbILskcLKtN3H2T29I/SNUCC/XaEI4viqCIex1k=;
 b=c8Dy9i7WJAwYr81uCaVlGqmO2E7l46j5OZqevbnQeOGSinkhirGzuJlvwrRBrdKY0HlciGV0QJ468V1G2AWbqzPPM6MwCvOJug1HztBIXgXiRp9Ik+hsiy//F0qssgh6WOh1mesIUcEDiJW02Lhvyiuq07x1Bh9K6ew3Yd9Mao52RAj1qEn9SAx0cK7xFV+8brDjyx21PuDR1UMZ5x9e98jtRepK3UYhJxxB8YeOYM6B91lniGmlQrcWWLr7ZH5RC4vM2YCO0bhJBv+p1vhR7zJtR4Xt5d+rbuG02ujqxAAGNDO3Rl/ZCLeRt0nz1F9ji4cHsxQbvWZTxyylJf3XDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SN7PR11MB6924.namprd11.prod.outlook.com (2603:10b6:806:2ab::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Thu, 3 Aug
 2023 18:06:16 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 18:06:16 +0000
Message-ID: <619692a0-8277-045b-dbee-5f2900150b32@intel.com>
Date: Thu, 3 Aug 2023 11:06:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] virtio-gpu: free BHs, by implementing unrealize
Content-Language: en-US
To: <qemu-devel@nongnu.org>
References: <mailman.213.1690396551.25301.qemu-devel@nongnu.org>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <mailman.213.1690396551.25301.qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::39) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SN7PR11MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 9074248f-95e1-453a-882f-08db944c54ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un8XfRYLJwftjKzXKR2jRs7PqeE4ytewJyvV7CcUDpzSXPKzFwd+Ux2O1QKiA5BD76uAiVLuxJmvMQTnKiIBBaouqTFlBRmHoF47Dt+zZQ/S4wUvu0gYsIxXrfshiPUovACZ8+6lV+sazBEz2GFzGRTe1Y1MEmBxJsUhYj7MH+oqc6V7EgbwBahltXLmsyORr+qUW8juSq0K8hyGd8CeUCgMVIUiKQMGR74ZJpvg4W7HoydalpHpQyCaqj4NcDwiVaGJBlRIaCYIvkYNOApZEYaBAY+iAk/VYWPxKHcz0mVo8cK+etxeUs6VipZ4zEBcFSz/aI3iLhm95dHTIB4dnlmj0b/Ld1kqx2lxD7Ef+yI5LurGfRaNJVPXaVTINTSk425XRTlO+FGQSOzfRBCzV//KGZQI8MHT89MhcGbyszXeK89hD7fhIir61n9o4Z+YKgnm+5oz/BQWOhh9c7aQ9Cr71kvaqo+JWl4heV5kDbKbiz1HLViXRFYdB5LBdXD4lrzLQ/LlFJCYebx1t5lJyKhdb96QTdbmJ8c6c0/b8xgZNTTkbx5segbFwE+7EjvcV+ENhCZMSQyUna0AaYYEaV4Cu/iBZt1yKaGsV3h3bdlyksPvXOZQwrzyeZc20ZSMMMEmfkvQ1p0KDWAkf8lzug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(31696002)(66476007)(86362001)(38100700002)(316002)(8936002)(8676002)(6916009)(31686004)(5660300002)(41300700001)(66946007)(66556008)(82960400001)(478600001)(2906002)(36756003)(6512007)(6486002)(6506007)(83380400001)(26005)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVGekRkR1RRTWpPOVRxR2tpeUpmQW03RWhyV0ZnaWVCcUp4UklzL3BKNmx0?=
 =?utf-8?B?MmhFamtYc0ptV3lhWDJjd1hReVFwSi9PbnFOb29lNUpLQndQdmpidVE0Nzg2?=
 =?utf-8?B?d1IvQ2NXT1l6VCtHbGZHRXE5M2owcHV2a1hld2JjYVBDWHcyRlo2L2VadlIr?=
 =?utf-8?B?NWhjV0VYTVZXNk9TV1lXL0p0TTZZRytrTWxaVFF5SWZITDZMOXE4bERKWDQ3?=
 =?utf-8?B?c3NQMHFQdXpMNnJ6SExLSFVPaFNoKzNETmV3TVlMeHJCTE0ycGw4eFlxbm9D?=
 =?utf-8?B?ZlBYby9wKzZzbzRmZ2JqVVV1NDM1TlkrOXRwMEpGSG40WDRWWUgwaGhoV0xp?=
 =?utf-8?B?WE02ZTFwMG1nS1lkNjNZTEJRL0x3NUs2TWN0bWVvMDhNeklWRUdsVmtJaFor?=
 =?utf-8?B?ODlDZVhlMVZTSDNrZmdaSWRSYnhJdzUzVFdZS1NoK0xnbjc4dXRpLzJvTDZT?=
 =?utf-8?B?MXBpbDJQbExYVGM1SDV0RnBrZFA0UXU5N3lXczFBd2xoWjFMMlM1T0RtdDJp?=
 =?utf-8?B?bFZRa2NrMVlxaXM1WERTUHRHY0craWNBcVQwMUNJdEpFblZwdERJTk9FUUhR?=
 =?utf-8?B?bTZvb0hZQkIvWno4R3N3MnFLenQ5NWlRR0tBbHIwSDVwVXVNeUlUTVIvNHdQ?=
 =?utf-8?B?RkxrdGM3VUdYaWVKQzJ0d1F0ZmsrdUoyQm1XbDYyTkNNRzVwSXlUeVBjR3dE?=
 =?utf-8?B?dU1WM3FOYmRWSFBOc1RzSHFIZ002RWM0N1p4aXJIRmpubno1SkxHM1hTN0NO?=
 =?utf-8?B?Rlg1a1JRUDVkN2w3N0E2VGhtd0MrT2tuQnowdTBkbFFIT1FZSUVTKzZvRXI1?=
 =?utf-8?B?V1BoMnNockVGeVp3SDNRL2Fhb090SXhXZFdvZG50d2ZKd3VJTVMzZG1TNnJP?=
 =?utf-8?B?a1EwK2RMREhPb0JhZ0RQSTllNHEyc3cxRWJ4VW81Z09CSEtpbVpFcnR2R3Bu?=
 =?utf-8?B?QkRXajg0SmVQYkEwVCtQZEwyVWh2UG1aaWF2ODV5a29zeTloMkFkdTI1bVZq?=
 =?utf-8?B?OUFiU3MxcVlzY3NwN3JudFNramRseEcxd2JTd0ZwY0JWUkZnNnBPd3hXelp3?=
 =?utf-8?B?a3B4Ni91Q2cwS0lFVUdiWDQ1bE5OSFYva1lZd3l0Mjk5SmtkYllacSt1M1NG?=
 =?utf-8?B?d0lFY1hjNWhFYmNwa1NWZFBoallFaDUrUTdlbnRpVCt3REtvc25pWlU0a0px?=
 =?utf-8?B?VkIvRkthRmlLcjVlS0lrTEFIOWphbmpYeVBoMmZjMlROMForVU5HN2VlK1hL?=
 =?utf-8?B?U09md0FXWGxMYnFtUU13amVXdmkxQ1YwNFN1cXJsbmtlMFFXNXB3ajdLVTBu?=
 =?utf-8?B?RmY2dmdCV0RkYW0rRmdwMEluNGtOR280Mi95eHZOYjhwMDR4L0l1MTd2OXFq?=
 =?utf-8?B?KzU4cnZYMENMWnNGSGRneGw5cWpZZnlEQXhOZXpuSW9JOWYraHRYL2F2RC9C?=
 =?utf-8?B?OFBMUlZFQzloVlhHZ2pZdThkNnVjTTFOY2FmTjd6b2lZR2h4TThyVDZ5RUQv?=
 =?utf-8?B?M3d0OG5hUHJNZXk3QzIyUlQ3R1ZvbHorQmpRVVZIM0pRYU9SOFpqYnd2QUNM?=
 =?utf-8?B?L2JOT1F2Q1hrM0dTVGVEbk15VlhFbmtueEJzMVdGVUh0VGZYRlVrVDlOWFZI?=
 =?utf-8?B?SG05WEVUd1JkWERzZU1VY0ZYQXpHWU1IRzgyc0dRZzJVRzN1U1hDdDRTRnMy?=
 =?utf-8?B?OEZ1N2lwTjRWUjdYK1FqYlh0TkhiZ3UzTHdGellORDNIMmdhTDNLenhJKzEv?=
 =?utf-8?B?WUdHa2lvQVBSeG91Y1lNSGh3RGRUeVd3WDBJdTJScElRRzA4QWtaTlc1REtu?=
 =?utf-8?B?T2hjemMrRktNbE0yK2czK1N6TVdJWVpkVWZGOVM5TTQ0UTh2azFKcjBjL0sz?=
 =?utf-8?B?Y0FPbGZlN0NLNkJLUlpxSnNpdWloVWZHQTZBRzhQcUJDMDVZTmtrSnFBb0xi?=
 =?utf-8?B?MG9ZSXJwWC9CK3Q2ZndpRkdGSWZMWGJxbSttMlQ3eDA0MzFFWEpvaXhEdjdL?=
 =?utf-8?B?TGZmY0xIRU1DNlVyT28yUjFpVkVHYlZ4cys4RXdLUldIVlk1bUdpeDQ5WnZ4?=
 =?utf-8?B?bWtoK1JHc2t2V1lkeitMN0FHb25lalBZU1dQQVo5T1hKbTVQNzJvdFY4RzlI?=
 =?utf-8?B?c2w2ei81dUZkVm11QXRxVmtROXlRUG52YWZOeFF5RTQwUEJHMk81S21pd1k1?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9074248f-95e1-453a-882f-08db944c54ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 18:06:16.5183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc1c6pdY9lPmYruQ8vI9Qj3x5bTrekCKeZW7YgyDhAfQL9Qfh8+judYa0Mz0kLKh5K09/WDqzA+q4Pm/xvwzYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6924
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
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
Reply-To: 20230726173929.690601-2-marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Acked-by: Dongwon Kim <dongwon.kim@intel.com> From: Marc-André Lureau 
<marcandre.lureau@redhat.com> Signed-off-by: Marc-André Lureau 
<marcandre.lureau@redhat.com> ---  include/hw/virtio/virtio-gpu.h |  1 + 
  hw/display/virtio-gpu-base.c   |  2 +-  hw/display/virtio-gpu.c        
| 10 ++++++++++  3 files changed, 12 insertions(+), 1 deletion(-) diff 
--git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h 
index 7ea8ae2bee..05bee09e1a 100644 --- a/include/hw/virtio/virtio-gpu.h 
+++ b/include/hw/virtio/virtio-gpu.h @@ -238,6 +238,7 @@ bool 
virtio_gpu_base_device_realize(DeviceState *qdev, 
                                      VirtIOHandleOutput ctrl_cb, 
                                      VirtIOHandleOutput cursor_cb, 
                                      Error **errp); +void 
virtio_gpu_base_device_unrealize(DeviceState *qdev);  void 
virtio_gpu_base_reset(VirtIOGPUBase *g);  void 
virtio_gpu_base_fill_display_info(VirtIOGPUBase *g, 
                          struct virtio_gpu_resp_display_info 
*dpy_info); diff --git a/hw/display/virtio-gpu-base.c 
b/hw/display/virtio-gpu-base.c index 7ab7d08d0a..ca1fb7b16f 100644 --- 
a/hw/display/virtio-gpu-base.c +++ b/hw/display/virtio-gpu-base.c @@ 
-244,7 +244,7 @@ virtio_gpu_base_set_features(VirtIODevice *vdev, 
uint64_t features)      trace_virtio_gpu_features(((features & virgl) == 
virgl));  } -static void +void 
  virtio_gpu_base_device_unrealize(DeviceState *qdev)  {      
VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev); diff --git 
a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c index 
e8603d78ca..b1f5d392bb 100644 --- a/hw/display/virtio-gpu.c +++ 
b/hw/display/virtio-gpu.c @@ -1392,6 +1392,15 @@ void 
virtio_gpu_device_realize(DeviceState *qdev, Error **errp)      
QTAILQ_INIT(&g->fenceq);  } +static void 
virtio_gpu_device_unrealize(DeviceState *qdev) +{ +    VirtIOGPU *g = 
VIRTIO_GPU(qdev); + +    g_clear_pointer(&g->ctrl_bh, qemu_bh_delete); 
+    g_clear_pointer(&g->cursor_bh, qemu_bh_delete); +    
virtio_gpu_base_device_unrealize(qdev); +} +  void 
virtio_gpu_reset(VirtIODevice *vdev)  {      VirtIOGPU *g = 
VIRTIO_GPU(vdev); @@ -1492,6 +1501,7 @@ static void 
virtio_gpu_class_init(ObjectClass *klass, void *data)      
vgbc->gl_flushed = virtio_gpu_handle_gl_flushed;      vdc->realize = 
virtio_gpu_device_realize; +    vdc->unrealize = 
virtio_gpu_device_unrealize;      vdc->reset = virtio_gpu_reset;      
vdc->get_config = virtio_gpu_get_config;      vdc->set_config = 
virtio_gpu_set_config; -- 2.41.0


