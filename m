Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5928375160B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 04:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJllP-0004LP-Ig; Wed, 12 Jul 2023 22:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJllM-0004L2-Or
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 22:09:00 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJllF-0000ox-A7
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 22:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689214133; x=1720750133;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jGpqsaInkXmwKl57YzlN4IL/Opx79U/zlT0p/7tG5qs=;
 b=DrI5kayRVqXay3A0KAmFKEz+7ZqmU71dNYmQGtyKG9ePwfgQ7Up9Wdi7
 HEOQPVyKRnIqGziQ4X5a7gNksTfpRjUZcayYZc1syJVlaffxKOXw/GKHJ
 AwxTqiNk/hDRPrVxnLFAqf7ahcYWhUtFFNgfyIvZxeiVj5PA4dwKJrkKH
 x3ta91C2TPm4uTDWpCcWqb/1bfPkOnioZK3H8r9DPoKgdHC8uMjgVBUxO
 N6fLlGbi1PkZMSP0Azd7/rvkXi9tAHaMxKCRnkdUAqMsqu1qj83sCfACp
 tKiapCR5uHBAksw7n9/Gw/+GUSss3T5j/MldZVsNOvAb07Zwt2rPnIrUU A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367688252"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; d="scan'208";a="367688252"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 19:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="1052426142"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; d="scan'208";a="1052426142"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2023 19:08:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 19:08:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 19:08:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 19:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZSrcPZVUmGiRqv+eC4YS+iiIN2PVyKd4k68gIchTjluzkiwG4lYLht7Lxloq6VHwFu6RtHLjOWblDHnKYYJ6/Wk4v6YL1KPsI2ZS46H0s8BAtiXkCo6qC4SYXCjy7sUdxmRKdh+jw15T6Zqn5ihJx379/AdkYBXPUTMzbNC9SQ3DDL0jann1R2LyZqDPSQyRUqb0bmIAuQFfobmUSAoCLmLzrEOZy3MVj0UdiJAQu0y+PEkiBu0L2dO4NmTKa829DHeWXTArHwEngvlB6/nIqlE0X0tsYOgkK787GNRSQICl823eQH2WLbQs4OmnmTTA7GT7LDKzAAnhOrzl5KQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2H/ddTrqQIt8SfHjwo3J5pZtZ98iil0OwJ7+kM39CZU=;
 b=ZfHuzd+3fI+UI/NuYhaSIYRtI217A7XOxbZ9MIAR1vAXTqBQqfM9dPzmCm9gNNYa4PfJU7eElExwW1B36WQMe1FGd68AG3kYTHl0DQXAibmEsa/CoEIMQPwBo/gM5tY5meqrqVXK+5a43qxVs8NAeJx0ZyHTofi9pnra68Geg2G4uj0eU6i9icBGhDRu0RHy9ylfA5sDUFB34H0j23m1ZG8sdPF+rY6ywjqLkNkM4ixxKs+9AMfdWEXTgLdt4sLgtmlULuYCfzCNQZVZS/2B3g2kqAPhDgNWUHCWk1iHoMSw4F+/dQzb0/rsTodsUDpo5K/K2x1H67QOhz7uVORsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 02:08:20 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493%6]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 02:08:19 +0000
Message-ID: <eb1ae626-9d94-e889-43e1-b34e49198762@intel.com>
Date: Wed, 12 Jul 2023 19:08:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] virtio-gpu-udmabuf: replacing scanout_width/height with
 backing_width/height
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Vivek
 Kasireddy" <vivek.kasireddy@intel.com>
References: <20230705224635.25343-1-dongwon.kim@intel.com>
 <CAJ+F1CKOQxQQh0qNJteP9EPfrCM3JaLZx5PkgsHJpQ4y_hWtnw@mail.gmail.com>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CKOQxQQh0qNJteP9EPfrCM3JaLZx5PkgsHJpQ4y_hWtnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SA0PR11MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b013b9-2bfd-47a5-cce7-08db83460739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZNaSUrF+FvKyw2uRCUbYLO6dKfWMOgHHJcfDuAZt4YWfXcN5gL6kpNEWKz9TjD1lQlKSuDkfE3TSToRv6fKCOlx9SLE4s7/cq5WGNVu6dGStiW0wgp8PbgivMtyxdJr2We0tuf3ZCCnvcyxVMFBVzk6yEY0hWhOlSOHIUcnY7f9gy8DEPskqc8FsLtPpCs/4tR8owlO2brAfYxK/f/vB49ExgNTr/SJTO+KMD4JOqDvAuYiEbInmxe0ItAZXbN9PELmmq6P0lnTAZvLFkOiij6jBWMjT6KybUR/9OSugriaDQsBnn6UkoSeDGjYp3+hXpvx0kzjMbdtiB6pQPCl5M2pE8DzpbUzleyzGcxyNysDgu99z3NruJQIkeaIDN4xdzcj7YnUk3kRS8FmS/A+yyFVEXmyRmEkKEEeqUjdfw8rHcpcNVFPB9Z0rHovs6rzMbhwcZEExLvS4fWWJFLNmiNpqvpdYDldq2rkWqDk/T6eL+UJHiEUFnxpDWPE7eqWOTjKh857r4H4kgMPPHopgvCE3rw+wBV3GSNc+vTZZf5MitC5fOj9Lx4+x0CgLPy3IA8RQ4w3wo+h9mbFrtXWAI7P782O6Bol+dIBh7IEYZIqpt1j1DaKG5/nrtEpCLTdDvg+Vj43lJziADZcS3zzoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(2616005)(2906002)(41300700001)(83380400001)(186003)(26005)(6506007)(53546011)(5660300002)(107886003)(8936002)(8676002)(31696002)(82960400001)(54906003)(6486002)(66476007)(66556008)(66946007)(4326008)(6916009)(86362001)(478600001)(38100700002)(31686004)(6512007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzIxZ3V4TDdsU3FFa3Q3aWxsZURtYklaSktHU1hIT3lTWDdFQVE3a1BjL1lL?=
 =?utf-8?B?K1R3b21UYjl4T0x6WmEwNGU4NnY1aE1HOHJlcG1qd29aQmFZV0FrQlN3U2ha?=
 =?utf-8?B?UnZnRlROcnducW5rWmw1V2dIbHJ5REljSmZ1akFtZ2puSlJUTmNzZ0RoZGhi?=
 =?utf-8?B?THhJQm8rd2hGUHlHOVhKeC82WEV3TnE5NVR1UEh1dk1rUytzWWd3c3NuN2JF?=
 =?utf-8?B?alRlQ09uWm0zZmxDdVF1VUpWamMvMFlsaG9ybEJYbEs0aFlxa3pyM29SWTNF?=
 =?utf-8?B?Ykg0SnJQaVJVM0NZYXZQdE5ZUEJocUlJUW44c0U4NzNOK2pqSW9VRGNwczV5?=
 =?utf-8?B?T2Jsd2ZNOWtCTFJESm1rTGpjRmxvQ0ZEQXlhaGtZMzNIT2kvTzlxSGFNY2pP?=
 =?utf-8?B?cGkwUXhCQjR3YVExZUJwN0RsekMvUU9FR1JZVzN0SDV3dlRPSlFvQWY2aDZk?=
 =?utf-8?B?REhZeTluWnc3TUlrTXM2UzhYWlZHQWowSDUyZnQ3d3RucjFBeWVzMXhMQVZC?=
 =?utf-8?B?UENlSEFhdWdPYXV3am92d082VWdxUGxVWVlyS2xiemtkWFppRzRFV0FaNktw?=
 =?utf-8?B?UHVqR3NBT2o5dWUzUlNnWHdTL3QxUWQ2VlIzZVB4aFZYZlBwTFhDWVJidEN1?=
 =?utf-8?B?enJWNmp6cDJ4SXNnOWxSLzJ2N1dRdjJZcnBWM3ZnMVkxS3Y2NzdOM1RNRXE4?=
 =?utf-8?B?SXdOT2JUSXBrMThCTEIyVlpDRHh4andLd3ZMZXduZjhvVGJicXZXM3RjMVNw?=
 =?utf-8?B?VURmMVM0VGtDNUtEejRHUVYzdlh2aXhnN1ZTNlFOWTk3WHVoOTZVc00rVXJy?=
 =?utf-8?B?REdZRDQ2dStNQmU1TUg5UVUzVEVOdXBDVlRJMnpjMnlQa05xaStZN3lHZ0M1?=
 =?utf-8?B?VHBzbStzbEZpOE1qamVwa1NLZTUvQVcrNEEwRG5rMjVnYjdST3poV0tWbGtx?=
 =?utf-8?B?L2ZYS09tSjJNcjBxS1FaSlhzY0dGWHVuSGptdlhEbU9oWG81N1RQTjU2VzlY?=
 =?utf-8?B?OHZyMVcvSFVnTGdiTkhzbVp5Qi9UbFdiek9FaTU4UFQ3K20rUzgxWmJETWV5?=
 =?utf-8?B?ZGJuaFdwa1lBL2FjMlBUc2RYNmIwN0k5Y0U5SFBUemhvTHZablQrdFBMWXNR?=
 =?utf-8?B?amhMU2NmTWN4aURYeFlwWmg4blgvM3ZRem5FOG1jMEpXczZqZTRUZUFHSCtw?=
 =?utf-8?B?c3VGUm12T2MyZ3NsWnUwRjlFbUY2TmlCZ05pRzhueXR5MjZCek9JUXcxY3VD?=
 =?utf-8?B?c29Hd0psdDhOZG95S1VreFh3SHltY25sOG9aSnhINkNlaGNTZE94RlRQNS9Q?=
 =?utf-8?B?djNjbjVJVU1ZeTJDdHg1MFdHVEdZelRsclJQQmhWbktPNFhWOWdpOGd1bCtL?=
 =?utf-8?B?a1JObkc2bDJXUytrMVhrQUwzbWJ3VSttaUVGN2szVDFzRlErRmFlT0Q4RTlR?=
 =?utf-8?B?K3JBOFBYZG9Yd0FGU3h0M0FBcUFrRm1TM3lXRFovTG5aVnU0NHZpd050Zlcr?=
 =?utf-8?B?TFE0emRma3ZhSUZveS95My9WWGNmUUpqSmdDMDdKaEFqVStJTEIzemU2bnJR?=
 =?utf-8?B?ditoUlh5RHBpRTR6WEp2WjZ6b3d6REZ0clRVWHdSaTNTOE01TTY4MHVHSHdV?=
 =?utf-8?B?Z0JUQnJvWWo1OTh2d3pqOW5XY2NnellrWVlhRzY5S1RqTnJzYm5JZnJnek5u?=
 =?utf-8?B?dVhzWkU5TlUzVldTQnNyM1hwOTJuTXU0VDFhbnRLL1BvRWZQMDRFbmJJNjJW?=
 =?utf-8?B?NDR5RlA4cGYvRUFzcHNEZlF3ZWNVMGJtUFkvWmdNZkp5OCtYMnpJazRzck9z?=
 =?utf-8?B?Z0ltU05jVXhsd3hYa0pISDh3azc1bXVoRUNOeEJGZWV6alo2RGJ0OFZtOHZ6?=
 =?utf-8?B?WUE5ZDR3YVhIZ2NRR2NjMVZRTE5nVVpOODY1cHlHYk0vQlVKNmh0RUl3TTA3?=
 =?utf-8?B?SHZaa0lnZDAwZ1NMMXVVbTlQUnZKVFdQSnVxNnVZdStQZkZ5WXM2VjRHY283?=
 =?utf-8?B?aVVRV2ZjbTRwL2VBbnJTRnAramhTTXMxWTljQ2theGF2TkxOQ3VNKys0aTBt?=
 =?utf-8?B?NEZwR2ZGRVo5OW0zWDJ5YzVMcmVneHJ3NlF0QmxGeEZNK3ozYm9wbDlMQ1pk?=
 =?utf-8?Q?Xf9wh0AeUY1yvIdfzu4vQL034?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b013b9-2bfd-47a5-cce7-08db83460739
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 02:08:19.6827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /STYweuxPlwkpkGaWIfDaqUhLKSWhF6/nCFVxQjlXekxTx13FUX7uvCw2qIjfUH/dASXWnXcZj8ogbT0jS6UTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=dongwon.kim@intel.com; helo=mga09.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 7/10/2023 4:57 AM, Marc-André Lureau wrote:
> Hi
>
> On Thu, Jul 6, 2023 at 3:10 AM Dongwon Kim <dongwon.kim@intel.com> wrote:
>
>     'backing_width' and 'backing_height' are commonly used to indicate
>     the size
>     of the whole backing region so it makes sense to use those terms for
>     VGAUDMABuf as well in place of 'scanout_width' and 'scanout_height'.
>
>     Cc: Gerd Hoffmann <kraxel@redhat.com>
>     Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>     ---
>      hw/display/virtio-gpu-udmabuf.c | 8 ++++----
>      include/ui/console.h            | 4 ++--
>      ui/dbus-listener.c              | 4 ++--
>      ui/egl-helpers.c                | 4 ++--
>      ui/gtk-egl.c                    | 4 ++--
>      ui/gtk-gl-area.c                | 4 ++--
>      6 files changed, 14 insertions(+), 14 deletions(-)
>
>     diff --git a/hw/display/virtio-gpu-udmabuf.c
>     b/hw/display/virtio-gpu-udmabuf.c
>     index ef1a740de5..920d457d4a 100644
>     --- a/hw/display/virtio-gpu-udmabuf.c
>     +++ b/hw/display/virtio-gpu-udmabuf.c
>     @@ -186,8 +186,8 @@ static VGPUDMABuf
>          dmabuf->buf.stride = fb->stride;
>          dmabuf->buf.x = r->x;
>          dmabuf->buf.y = r->y;
>     -    dmabuf->buf.scanout_width = r->width;
>     -    dmabuf->buf.scanout_height = r->height;
>     +    dmabuf->buf.backing_width = r->width;
>     +    dmabuf->buf.backing_height = r->height;
>          dmabuf->buf.fourcc = qemu_pixman_to_drm_format(fb->format);
>          dmabuf->buf.fd = res->dmabuf_fd;
>          dmabuf->buf.allow_fences = true;
>     @@ -218,8 +218,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>
>          g->dmabuf.primary[scanout_id] = new_primary;
>          qemu_console_resize(scanout->con,
>     -                        new_primary->buf.scanout_width,
>     - new_primary->buf.scanout_height);
>     +                        new_primary->buf.backing_width,
>     + new_primary->buf.backing_height);
>          dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
>
>          if (old_primary) {
>     diff --git a/include/ui/console.h b/include/ui/console.h
>     index f27b2aad4f..3e8b22d6c6 100644
>     --- a/include/ui/console.h
>     +++ b/include/ui/console.h
>     @@ -201,8 +201,8 @@ typedef struct QemuDmaBuf {
>          uint32_t  texture;
>          uint32_t  x;
>          uint32_t  y;
>     -    uint32_t  scanout_width;
>     -    uint32_t  scanout_height;
>     +    uint32_t  backing_width;
>     +    uint32_t  backing_height;
>          bool      y0_top;
>          void      *sync;
>          int       fence_fd;
>     diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
>     index 0240c39510..7d73681cbc 100644
>     --- a/ui/dbus-listener.c
>     +++ b/ui/dbus-listener.c
>     @@ -420,8 +420,8 @@ static void
>     dbus_scanout_texture(DisplayChangeListener *dcl,
>              .y0_top = backing_y_0_top,
>              .x = x,
>              .y = y,
>     -        .scanout_width = w,
>     -        .scanout_height = h,
>     +        .backing_width = w,
>     +        .backing_height = h,
>
>
> This is not consistent with the function arguments. I think it should 
> be after:
>
> .width = w, .height = h, .backing_width = backing_wdth, 
> .backing_height = backing_height
>
> Hopefully this inconsistency is not repeated elsewhere.
>
Yes, you are right. Backing_* is for the whole surface. And normal 
width/height or w/h specifies the sub region as you mentioned earlier in 
all other places. Inconsistency was caused in QemuDmabuf where 
width/height was used as backing_width/height. We should have corrected 
it first. I will send another version of patch to correct this.

> thanks
>
>          };
>
>          assert(tex_id);
>     diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
>     index 8f9fbf583e..6b7be5753d 100644
>     --- a/ui/egl-helpers.c
>     +++ b/ui/egl-helpers.c
>     @@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src,
>     bool flip)
>          if (src->dmabuf) {
>              x1 = src->dmabuf->x;
>              y1 = src->dmabuf->y;
>     -        w = src->dmabuf->scanout_width;
>     -        h = src->dmabuf->scanout_height;
>     +        w = src->dmabuf->backing_width;
>     +        h = src->dmabuf->backing_height;
>          }
>
>          w = (x1 + w) > src->width ? src->width - x1 : w;
>     diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>     index d59b8cd7d7..7604696d4a 100644
>     --- a/ui/gtk-egl.c
>     +++ b/ui/gtk-egl.c
>     @@ -259,8 +259,8 @@ void
>     gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>
>          gd_egl_scanout_texture(dcl, dmabuf->texture,
>                                 dmabuf->y0_top, dmabuf->width,
>     dmabuf->height,
>     -                           dmabuf->x, dmabuf->y,
>     dmabuf->scanout_width,
>     -                           dmabuf->scanout_height, NULL);
>     +                           dmabuf->x, dmabuf->y,
>     dmabuf->backing_width,
>     +                           dmabuf->backing_height, NULL);
>
>          if (dmabuf->allow_fences) {
>              vc->gfx.guest_fb.dmabuf = dmabuf;
>     diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>     index 7367dfd793..3337a4baa3 100644
>     --- a/ui/gtk-gl-area.c
>     +++ b/ui/gtk-gl-area.c
>     @@ -300,8 +300,8 @@ void
>     gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
>
>          gd_gl_area_scanout_texture(dcl, dmabuf->texture,
>                                     dmabuf->y0_top, dmabuf->width,
>     dmabuf->height,
>     -                               dmabuf->x, dmabuf->y,
>     dmabuf->scanout_width,
>     -                               dmabuf->scanout_height, NULL);
>     +                               dmabuf->x, dmabuf->y,
>     dmabuf->backing_width,
>     +                               dmabuf->backing_height, NULL);
>
>          if (dmabuf->allow_fences) {
>              vc->gfx.guest_fb.dmabuf = dmabuf;
>     -- 
>     2.34.1
>
>
>
>
> -- 
> Marc-André Lureau

