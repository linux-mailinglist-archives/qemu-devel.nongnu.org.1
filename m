Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0847BE5E4
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpsmU-0007wJ-IV; Mon, 09 Oct 2023 12:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qpsmQ-0007uk-I7
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:06:52 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qpsmN-0001xn-2i
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696867607; x=1728403607;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FmlZfzUDsLKzliAHkWuB4+BurcOF7Jde6ROOb3wqW6o=;
 b=IPf6dyOfkP3yFaiCqOsbhlcg5Tn9XMQjdhEmtBwu3AnnNcl10A8jwc05
 3StjZn/xpWWXFn9yiuuNQ/7k/lZkfkLbUff+tY46cjQSzmivmrFROPnhF
 rvGG8BGKgkgKyLcgimftKS+A1M+19e8+Uk3I6lGslSKlWyyDyX/NINj2x
 L6fX4+ruhT9aYbuBeTyGEMS3h/o53OK6mJ8C6niP370wiAXvtHP0oGkFk
 65fZFkuRAVq5K3z/s+2wAfkHMRHw68eoY384Z1gUWEev/AFF+Ziuay2pT
 5lBhTPopt/4x3dr+1Y8AJzC90eqaUx/IXVZS+VBo5aTYVgxaEpnbWVw5B A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369250959"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; d="scan'208";a="369250959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2023 09:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="782548022"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; d="scan'208";a="782548022"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Oct 2023 09:06:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 09:06:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 09:06:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 09:06:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 09:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEM/NK8kJtQLR0LYY5GWOLbhq8FMTyUW6Ko5mWcXFykrZG/UL/GuACBsQDouWnnJyxaqt12PX21rTGkTZ/gFb623AU4gE5lOSNWdVKop8VRiyIIueXQb5xxSEDRvo7S2Td7ubscxBqyAsc+Q6tiuve2Bfwk8kkFbeo+KPnQ9+AhcOr+hvxLFm2iloSU16MOs243GP1qsqAtwrzpHLUSdaTvjUWTg8//6ZNnbXR8NX1/ZrYgERe3sDMVazGPNmRoA5Qz5J7wATmXOyHeZ9u/Nkwptun6GPVkbS6KZGNVzv2ssEvahDER7VyQRKMt6g+c0WyIfHIgp/6nw4HuwbZO7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzuPV4v7PTVMidnDtUvtGXUXMJl/nWTgnSrWrdDYU3s=;
 b=I9+jrqx6w5D225eAS/ho13JJrl0gGWn8D5D0g9py5GT3LsfRRFcnYAQ26DZJygcaAPbWYoYO5uvK7+YC/VVB/3ZVOgs6+U8Q+IzMFZy6VJoCggHZXxGjeyKpY/xBFBgOUxA0MOfpSVfNczNpSZaj6VBZnVoQe2H+9SafLpHesbCABdupnhdkV55MY/Pn3u5o5XI4ASpTYybTl2BedBlM3mkVzL6LsObRYzz6klc8GVNqivYEn7Rzmy9IYiK6h1rUbdBQrMNyZIoAWeY/wmgnIe6ICoCW3JTgbv+4Ae9Bi4D2sY6qHqBafnbUAQA5aMA81dE/v45pNqgjKjARhSq+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7406.namprd11.prod.outlook.com (2603:10b6:8:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 16:06:15 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 16:06:15 +0000
Message-ID: <db66dfc2-eccd-41c1-9345-62d287c44baf@intel.com>
Date: Mon, 9 Oct 2023 09:06:12 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v4] hw/cxl: Add QTG _DSM support for ACPI0017 device
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <mst@redhat.com>, <thuth@redhat.com>, <qemu-devel@nongnu.org>,
 <peter.maydell@linaro.org>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <652048e465c8d_ae7e7294e9@dwillia2-xfh.jf.intel.com.notmuch>
 <169663055629.1214042.8019806314058171125.stgit@djiang5-mobl3>
 <20231009164758.00001e43@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231009164758.00001e43@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 15405d6f-8bfe-485f-9039-08dbc8e1aa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5KvvdR+IJ5xv1qB6tH0Rd8QWuRZKr6oWI/j1ycAELQaPkM/CqyUowyFG7hxLnTczdroRXJuNq8mjg9RAMcK1CbJlrG/BwRHmZZIIcDky+COdMV3ZIgeu79aTdbD7yIwsAD5B8Wq5Z7uXhkNksYtTTun9GBgEyTtBsZvh418mj9OzBQw9CLfO+SCfWki4QdwqMyGNDbq5EGWV1bYHs/Yff/drT4WyhgREMfT5hz5r6YR8FL5ZnrRg+pEU6/S3lc7yCIb8xXaOuSb3+QfZy39In8RxQfC1tTGg75f185QezHyrYaw9aZkfVNQE1Y58/9w9gy2h7oseN6NmhYZ8eEhv8FuOvxbOXfU33gHMNnLYARRoG0ZSIsGpkI08ye9FDw4xPjerKVjqjP7cr3lJ8IfFfSrC1RCXDXmu+Ih8RIALMZjAskBCj5YvmwzWb9jAhRNR8v39onVNADwssAJZSQCSEIWbRp17fT6mOAPjXOhNJ62HfJg769xd4iIJoOf/1leu42Htv3qg5XPWREfSn5nOu8hqZpEGskLIHZFwDWKBAtXE7b7FhwiFfw16a3nvgQnB+lTBqpcWAk19Sx8tkXTbn5R633j8agDjo6VCD5SvEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(53546011)(6512007)(2616005)(6506007)(41300700001)(316002)(478600001)(966005)(44832011)(26005)(83380400001)(2906002)(7416002)(6486002)(66476007)(66556008)(5660300002)(6916009)(66946007)(4326008)(8676002)(8936002)(82960400001)(31696002)(38100700002)(36756003)(86362001)(6666004)(31686004)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEpucDdJVHFIYmxEa0Nsd3h5RTFkeDIwOWlrcG1xOTV0TTNoRGgyeTJPMzRx?=
 =?utf-8?B?QThST2tQZmNLWkVhMndtMFJjMFcxalpDYkI4Mm5jR0dHUllUNEd3L0VlTmhp?=
 =?utf-8?B?UTFUYlMyVkhvTXVlaFcvblVjV1h3dmFXMFRxeVlDL280T2pQbWMxclZMRWR3?=
 =?utf-8?B?TnI0Vm83ZUJVeWVDM1R1K0V1c0NCdXZGUmxac0VlVmxJNGdIOTBQalNNWjlk?=
 =?utf-8?B?cmNIaEdvVHhLMTJ2UVluS3E5QldoNEw3dzk4K3I3UHpwZ1h0b2l0dmpkR2Rh?=
 =?utf-8?B?Q3lRSHRkT0lYakdBOHJsaXRtNnRBSVNzcG5wcGpmWmtseHp4bnlZbGhsTEti?=
 =?utf-8?B?MEplZWNueG5oN2s0Nm5vMURhUk0xekxkUDIwNkpTemtUWXZQNmhUUnhDSTRy?=
 =?utf-8?B?R2pHTnlONWsvN1RTQnppbmtBUWNKQUFvMlROTU9yRnl2UU9VMTBDRTFQQ3By?=
 =?utf-8?B?c1JNalJvUnd1bi81eE5raFVMcWdXSWl3MVBsQndKdXhhamdyYjE5OWlzcGI5?=
 =?utf-8?B?ekhjYnRhWmxRL3BqblFteVNmbVdFTHJnRnNqR3QyRkQwdlU3ZFd2NUxLVDg2?=
 =?utf-8?B?Yk9sMTQxSUlhSVIxM0k1bzhqR2hmc2NtMU5BNzc2TUF1QlhwZkxLcmtKRnVI?=
 =?utf-8?B?VktPeDFzUHNpOVZ4MERSS3JzdU1GTWptVW01cHpKcVYrdkNnMmVKYXovcTJQ?=
 =?utf-8?B?WHgvZnNOWVl6N0dmM0duWlJHbERUZnZwbzhPdThzbHdCYzlDNXJSSCtIazZY?=
 =?utf-8?B?RkVKeDdYM1NXRjZTcmxMMm9IUE15akdsalBkL2N3eWFYSk1CaFQzb01CZE01?=
 =?utf-8?B?dGptRUszRTZmMDVnUHNVQ2U1a243UG4xa0FMS2wvcUtsL3lZVkFTWEJiUmJy?=
 =?utf-8?B?T3ZUeFpCMnp0NmJPMFB3TzlHL1czUVBhVkRiakQwZUhWdjcrR2E1d1UzclZB?=
 =?utf-8?B?RUVhYlFGZURweXZ3TlVmT0Rsa2YvVWV5TGhGZFlueWdrTDE0ZlFPNFBZQXZI?=
 =?utf-8?B?K0JydklXVzV6cHJzNFdFMURoT0xHaDdzK29tUkdIVWJLR3Q0bFZQNmdETXQw?=
 =?utf-8?B?bWlyRWhuMUttcStTeFY4bmNNRUxhc3J4aDlBWk0vODgzZnVUUDNFSWhXdDIz?=
 =?utf-8?B?aGEyZlB4V0lXNEl1V0c1RVdjUE1KbGl3TS9nSHhwbzJCYndPR0lKTDYxSFcz?=
 =?utf-8?B?eWhqbHlMS082aUZHSiszUkFvN25WZ0haN0JQbUlRUEZFelhMRHJpSVFZTzU1?=
 =?utf-8?B?QmpyVzF2cytEVUt1VGVYcUZSY3dOTnNWZjdlU0ZoeU5hcmR1VitGVU9NUDM1?=
 =?utf-8?B?R3RwNzVFNjczeXF6RUVFMm1aMFRKalNNcWROV1RkR1RQbjR3eFpDeVN5YXF5?=
 =?utf-8?B?MlhLYzg5ZCtiQnNBd0FiYjVmZjRGQTFIN3RJZFlNcGtLT3lHN3BmNUMvejhu?=
 =?utf-8?B?Q3ZpQjlrQURlR2NobXpvQ1hvRVo4TDJCSmRWSjNZYWNKbW0rMDM1bGgwTEQ3?=
 =?utf-8?B?cW94OVpPaXBDQU5CeDlXQWdOL2pCNnhteTQweDFSdWlzVzZMMEkxTmIrVzNI?=
 =?utf-8?B?TG4zZnpzYTRyQlQvdmlPNFBDa1kxOE8vdXorMkIyMHpoTmtOeStpTDYyRkJo?=
 =?utf-8?B?MmErNzBxS1FENWcvWGhkeTkrNUlrZmxpdVJGd245UjlTSXYyMXpVQ2U2MnZn?=
 =?utf-8?B?SS9tdFRTTUxlTWI1MlZSZzFyTHB4aGx3UzF5SC96TkxVUmVOMDhnQXZSclNR?=
 =?utf-8?B?dVpDcUoyUmI4WUxsbXBLcDVlNzZ0bSs5cDkwci83MGdUdWEwZ1RKUGRTeTVh?=
 =?utf-8?B?NUVoZ1dMbGxQdDFjcENQNUFRVCtucmlodDNaNVFsL01zTGVxUVdnbldVVVp5?=
 =?utf-8?B?eWgrbmtWekdGMnY1eWVMTE9NMnZ4RUlqU3I1UWxuSGQ1R3l6L3A2dlNMOWlC?=
 =?utf-8?B?SWRLK2dNMWlacWtHYzhrQjdpNmFTQm5CcDM5M1pPajJUdlhTdXZ1ekdUNmhz?=
 =?utf-8?B?R2kwYzYzendQdnUrL1U2L3lscjc1Qm0xMzRCTnNoNnNHdFI5Qk5Vc1R0elZB?=
 =?utf-8?B?QUY0VXRKRnFhaXJPVGYyQ2thTjFnMHAxWUxIWiticVEzVUF1am9BeVFXbUdM?=
 =?utf-8?Q?QV7wxYEFt6mFEHRSCL2SJpciO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15405d6f-8bfe-485f-9039-08dbc8e1aa79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 16:06:15.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u96lIAbetknC/CYxpe6fZPPgVpmDgYWQT0CiW3rIgia4Od0pvTQNx/csyxxLBKaRSW/Vj/W8VbkMb6xf4WE1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7406
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=dave.jiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/9/23 08:47, Jonathan Cameron wrote:
> On Fri, 06 Oct 2023 15:15:56 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add a simple _DSM call support for the ACPI0017 device to return fake QTG
>> ID values of 0 and 1 in all cases. This for _DSM plumbing testing from the OS.
>>
>> Following edited for readability
>>
>> Device (CXLM)
>> {
>>     Name (_HID, "ACPI0017")  // _HID: Hardware ID
>> ...
>>     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>>     {
>>         If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
>>         {
>>             If ((Arg2 == Zero))
>>             {
>>                 Return (Buffer (One) { 0x01 })
>>             }
>>
>>             If ((Arg2 == One))
>>             {
>>                 Return (Package (0x02)
>>                 {
>>                     One,
>>                     Package (0x02)
>>                     {
>>                         Zero,
>>                         One
>>                     }
>>                 })
>>             }
>>         }
>>     }
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> --
> 
> You've picked up my bad habit / typo.  Needs to be ---
> to stop git picking up this text...

I preserved what was in the original post. I wasn't sure if Michael had it like that on purpose or if it was a typo. 

> 
>> v4: Change to package of ints rather than buffers. Also moved to 2 QTG IDs
>> to improve kernel side testing. Tested on x86 qemu guest against kernel
>> QTG ID _DSM parsing code to be upstreamed.
>>
>> v3: Fix output assignment to be BE host friendly. Fix typo in comment.
>> According to the CXL spec, the DSM output should be 1 WORD to indicate
>> the max suppoted QTG ID and a package of 0 or more WORDs for the QTG IDs.
>> In this dummy impementation, we have first WORD with a 1 to indcate max
>> supprted QTG ID of 1. And second WORD in a package to indicate the QTG
>> ID of 0.
>>
>> v2: Minor edit to drop reference to switches in patch description.
>> Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Given it's changed in significant way should drop these.

Sure. I just whole sale preserved what was there as revision history.


> 
> Anyhow, the tests also need updating.  I can do that and push out
> a v5 with tests as well once I've tested.
> 
> I'm assuming need tweaked kernel code to test?

https://lore.kernel.org/linux-cxl/168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3/T/#mc45e3d8dd7463f8aeff432d57b834dd4831cc709

There may be some additional changes Dan wanted function input parameter wise. So there will be a v10. But here are the changes to use ints and fixing the input as well. Tested against the changes in qemu and looks to be working as expected. The inputs actually looks like below now:

+               [0].integer = { ACPI_TYPE_INTEGER, input->rd_lat },
+               [1].integer = { ACPI_TYPE_INTEGER, input->wr_lat },
+               [2].integer = { ACPI_TYPE_INTEGER, input->rd_bw },
+               [3].integer = { ACPI_TYPE_INTEGER, input->wr_bw },

> 
>> ---
>>  hw/acpi/cxl.c         |   69 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/i386/acpi-build.c  |    1 +
>>  include/hw/acpi/cxl.h |    1 +
>>  3 files changed, 71 insertions(+)
>>
>> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
>> index 92b46bc9323b..9cd7905ea25a 100644
>> --- a/hw/acpi/cxl.c
>> +++ b/hw/acpi/cxl.c
>> @@ -30,6 +30,75 @@
>>  #include "qapi/error.h"
>>  #include "qemu/uuid.h"
>>  
>> +void build_cxl_dsm_method(Aml *dev)
>> +{
>> +    Aml *method, *ifctx, *ifctx2;
>> +
>> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
>> +    {
>> +        Aml *function, *uuid;
>> +
>> +        uuid = aml_arg(0);
>> +        function = aml_arg(2);
>> +        /* CXL spec v3.0 9.17.3.1 _DSM Function for Retrieving QTG ID */
>> +        ifctx = aml_if(aml_equal(
>> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
>> +
>> +        /* Function 0, standard DSM query function */
>> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
>> +        {
>> +            uint8_t byte_list[1] = { 0x01 }; /* function 1 only */
>> +
>> +            aml_append(ifctx2,
>> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
>> +        }
>> +        aml_append(ifctx, ifctx2);
>> +
>> +        /*
>> +         * Function 1
>> +         * Creating a package with static values. The max supported QTG ID will
>> +         * be 1 and recommended QTG IDs are 0 and then 1.
>> +         * The values here are statically created to simplify emulation. Values
>> +         * from a real BIOS would be determined by the performance of all the
>> +         * present CXL memory and then assigned.
>> +         */
>> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
>> +        {
>> +            Aml *pak, *pak1;
>> +
>> +            /*
>> +             * Return: A package containing two elements - a WORD that returns
>> +             * the maximum throttling group that the platform supports, and a
>> +             * package containing the QTG ID(s) that the platform recommends.
>> +             * Package {
>> +             *     Max Supported QTG ID
>> +             *     Package {QTG Recommendations}
>> +             * }
>> +             *
>> +             * While the SPEC specified WORD that hints at the value being
>> +             * 16bit, the ACPI dump of BIOS DSDT table showed that the values
>> +             * are integers with no specific size specification. aml_int() will
>> +             * be used for the values.
>> +             */
>> +            pak1 = aml_package(2);
>> +            /* Set QTG ID of 0 */
>> +            aml_append(pak1, aml_int(0));
>> +            /* Set QTG ID of 1 */
>> +            aml_append(pak1, aml_int(1));
>> +
>> +            pak = aml_package(2);
>> +            /* Set Max QTG 1 */
>> +            aml_append(pak, aml_int(1));
>> +            aml_append(pak, pak1);
>> +
>> +            aml_append(ifctx2, aml_return(pak));
>> +        }
>> +        aml_append(ifctx, ifctx2);
>> +    }
>> +    aml_append(method, ifctx);
>> +    aml_append(dev, method);
>> +}
>> +
>>  static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
>>  {
>>      PXBDev *pxb = PXB_DEV(cxl);
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 95199c89008a..692af40b1a75 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
>>      method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>>      aml_append(method, aml_return(aml_int(0x01)));
>>      aml_append(dev, method);
>> +    build_cxl_dsm_method(dev);
>>  
>>      aml_append(scope, dev);
>>      aml_append(table, scope);
>> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
>> index acf441888683..8f22c71530d8 100644
>> --- a/include/hw/acpi/cxl.h
>> +++ b/include/hw/acpi/cxl.h
>> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>>                      BIOSLinker *linker, const char *oem_id,
>>                      const char *oem_table_id, CXLState *cxl_state);
>>  void build_cxl_osc_method(Aml *dev);
>> +void build_cxl_dsm_method(Aml *dev);
>>  
>>  #endif
>>
>>
> 

