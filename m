Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB170BEC5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q151H-0002J6-SA; Mon, 22 May 2023 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q151F-0002Iy-Tx
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:52:09 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q151D-0003ws-6H
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684759927; x=1716295927;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j3VK0pWyvDKoy7wN5mF50LSyQFuKobx69zY/wrvAQss=;
 b=Z9EoCWrmUdgEpYCl3fCsbFn57dHyTHsWCvNLBXst5v8E+ZLe1dKwuQhS
 VCxn7xNIGwzXQ3z0jVz1Gf6Mjx5vQ/ad60m2FlIXSGIERwcmTqaDcUI20
 EGtCkk3kTyOlmE2rSO0zrhizd5h0usbM3zFa2zsDQcioA7VG5oupzoob9
 fmT9NZcvXS/ridHShdkTtYOKol/8qPpq53RleYr+fbeRJMWfH/Gz4EtyW
 VXMia7qNAL7f4uytTpXROg1EOc3tgShGn/w+y5UjzCvkS90S2+9U1ms/o
 KJKywVCm3A2bNCazV79Z1quG0bAwleLKHbkfGQ+FGWqTp7KoF9Jnz2+aQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="418616507"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="418616507"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 05:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="877743067"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="877743067"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP; 22 May 2023 05:52:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 05:52:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 05:52:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 05:52:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 05:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWyLkFgrRWa3zP2Ea6Q6mjuHO/rxXIaiUeMicD1FWtLkJ2FlE+L75Fo2t0ZIpgkL75mgi9pSmj6IYoPrUzAL4niLk1kPVnvfmjEzIYgd6ge8kwffor0hC+zfytAe4ph9a5XURrqfnHBO3vJc3nevIyncpDVAGhZZEiXer/h2eFXyDQb6A45famb+rOc1tagTJshtWL5nbOhyUIPMoJMDDbMKI9alIhowlNjuluoUJkV/EIy5YwYPFk+h4yaSutggdmyV06Sawv8cXvMd6PP2FmFaKLCpcM2wDppDAOEZfA4rV7WUL+lG3MzGqjp4q0D1vbiTyBWHaw1JMcwimuqspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuoIoT04jSqWiiVQsW2dKgDW8zimMixNNoSl9OQKato=;
 b=hZSqWToK9/KoxdUtG7ntvO1P1RwW9/VT0qnHds7EveBSwCP8gKahvHrRhM0XyQpfORGo5AX2tqIZnhW2FBO3XAqSaZ1ULvPZj/nw6+PubvD9asLc09K4oEj0KAUdF4hDpfzE1jnEGSntzYDPyURTLcMeRaSv3qcQqyFT6QDHNvwUy86LUdIcIdqbVEWkRA1Z7qJnmWaoAJ6OooLXGQVe3f3kFPhDNfNaUpBDchxb9vM0qx8yRODrKQoAEZlSjR0giOYzpPozm4f5iijfxSCFKocOERANAYmO8Y692ND1LI5BoEGACsoLQl/tCwZ6WPGtmv8vM+WT4+U1sredKAZ5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 12:51:58 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc%3]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 12:51:58 +0000
Message-ID: <d281595e-1d62-a32c-0627-09ba0b0577ad@intel.com>
Date: Mon, 22 May 2023 20:51:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 15/15] docs/tb-stats: add how to
To: Thomas Huth <thuth@redhat.com>, <qemu-devel@nongnu.org>,
 <richard.henderson@linaro.org>, <alex.bennee@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-16-fei2.wu@intel.com>
 <36525a40-b4a5-517d-2926-8b646ec46d7e@redhat.com>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <36525a40-b4a5-517d-2926-8b646ec46d7e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MN0PR11MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 022cdbdc-9cdf-4742-befb-08db5ac353e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09sYcGEPRGMTdnFrzPJVk3TIXAJ6tLbLT4M81MKwThmZjsoH/7XRLUX5Lc/EqsViSRwp/e3/IpZr9UNrOYhnULl9gWLAYjBsUcsXgoNgJLyWujSv2NhrVOtAbojrJj1mjvpA0YkiTC7AZKc7KS2EOSKjlkqB2Y63Smln7nBTW0n93wPG2Fy+MCDWEinWWPH1eOWba9TP2YIZoTcVnp3sZ6p6y+CMvFDjaRy9UMmN8Ja+OCU/56mLUo2yhbpkE4ZW9TwJC7Np2NhygSYOc6/hO05YW8x1qiJfFaYhvb8tbADsnUa+0TCDQVoZbBvk5Yuyqe42sftwgrqQ0uksa4mA0KP6AnIRJ7k9WALcmVa0tBdWrZKYBigsBg5u92wgDVmT20+b8j41rYjiohZs5ugrGI63kiTbf4pAgKglWtFPoUs7a7O+kEE0WPkn4FSB9ITBlBOmpNVImni0CMGFhCA/soQewcnLlZ1/KXZIiw1N7xdTi79OnnZgea0EOvjOacxsZZ4cMCfm5xsWdFQaUvKPMmPLqZMW8+onwJ4KI9e2B3LkWQ03dIrQbDJmDhmKaIVdYCduHJ5uVZ71V6qSxYgi6ApTbHLGTlU9GKgzXJz9oNMHi761KHQWAfi1DzAuY1Lm4PrCFebPnCeoGO+UFuEa8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(31686004)(86362001)(4326008)(66556008)(66476007)(316002)(4744005)(2906002)(36756003)(5660300002)(478600001)(66946007)(31696002)(41300700001)(8936002)(8676002)(6486002)(82960400001)(83380400001)(6666004)(38100700002)(6506007)(6512007)(26005)(186003)(2616005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3U4akdiYnJmRFZLNS9XQWY3amlSNVNDWlEvTTBidnhrTVZoVDdpQXErZ2tk?=
 =?utf-8?B?VHhZS0xXbWJRMXhEL3VkYjlBMXdpZDFRaFFaWWZUMlVKY0tUWnBWZFN3WE15?=
 =?utf-8?B?TElqRTl3UGNwN3h5Q0VjNFZ6aXlFTitYakVBVlF3aGZnR2pSVkR0QnlPSUFp?=
 =?utf-8?B?YnlTWVN0ZVUyTk5kYituOFBBM1ZoU0RXaVo3L0ViR01uTjErOTVJRnhDNGpn?=
 =?utf-8?B?bURMRzZoL0FlT0NsOG5pOWhVdDRkcGc5NHEwUHZ3TVdFbjA5V2pzMml6ZktE?=
 =?utf-8?B?ZXVFOXRFTEp5UjBOQm9vbzNubnFnNldoVFUwTnE4VDFEUlFkeVM3amtaWDJV?=
 =?utf-8?B?RUk4NHNVMkRXaXJ5VVN4TzM0K1M4SHZiS0U3M2NBZ1o5Q1U0KzFKU3FYUVdM?=
 =?utf-8?B?UWdpNFczU0UxNFZHWkRjNFZpYmh0NFBqV2NzNjBpaW5zcTJLblEwOGQrSUFq?=
 =?utf-8?B?YStTdlRqNy8zZmRXZVU2S0FOVWs4K3RaWDFPNERaT241U1llWi9rU0FYWTU1?=
 =?utf-8?B?OUdsdC9FWURnOXZXR0RJZ2dwSnpGdE9qM0VHUThZK0RHTGhDdG1IbmoxQTla?=
 =?utf-8?B?enpIQkE0blF4OFZoNE1sMmZBUS96MTBmYTJYV3hyK1FuTXU1VTdzOU1vYWJZ?=
 =?utf-8?B?bDdiY2ljcHFZMzJoRmV1amJHUnBMNXhJem92VG9JUTJjUFFnNUJJeWVJZk1j?=
 =?utf-8?B?M1BzMFRnanhXamhmWkNhM1RjNzlMb1RWZVBaTzFpU2dzSXlFWlhkb1AxRUYr?=
 =?utf-8?B?cHo1d3RPL21wbWhabzMzMXRKdXUvWVZjSVRUbU1IbUJHRE1mR1d3d0lycXNz?=
 =?utf-8?B?K2ZNOFJ2bmNITENEaHBuTmFiTncxRklQYUUyeVAycDlFcVk1bmt1NllFeldp?=
 =?utf-8?B?bTBzK2hHUGpxZXdvclo0OFVldnpDK05sOGF4ckVlUXlXRUJVOFBUai9qeDNE?=
 =?utf-8?B?c2E2T3BVb1laWGVEVmdWU0lVTE1paEtGTTFiWmg5UzQ3Rmlnd2NwVXhQRUg1?=
 =?utf-8?B?TFNLbi9qcnVSbXpEYmdidTUrSjJnNWNxWUZFN3dhNVNhMC9IZlBUVHFyV1I3?=
 =?utf-8?B?dlNvQ0ZTTDU1bysyWnArT2t6NHErYlF2RzhKMC9Mb21yNng0WDgzV1h4WU9r?=
 =?utf-8?B?NTRidkZyMzZITW5rVk83TzFJZ2VHRVJwYWlWRGoxN2VZUlU1TVpKT3BqV0lm?=
 =?utf-8?B?VXJaTTJWTWU1M2Y1cEZoVWlKaDhIaERjd1ZhWGFZeWNUOVJDRms4ZVBZVzlJ?=
 =?utf-8?B?NGhHNXFPc0ZpeVE3eFhzNkl2WTRJbFkxWjFTTEFiWXJQS1FwTU1oYi9Xd3Zj?=
 =?utf-8?B?U2xvZkhaTW9sZHJJQzhEMUkralpkMGtzWmh2anJHSUZCMHBGcmx1VFBnU010?=
 =?utf-8?B?Y2V1MkV4eDU4Wnp6UmlReTJZTGpMM0QyQVZmS0ZZTzdZZTZuTUF6SEZsRXpT?=
 =?utf-8?B?SGtHajRwOEFkSmhSV3BJOER3T0xsZldyTTJVZFl1S1VLUjAyVlNuMDVBVVpY?=
 =?utf-8?B?ZHl0Vzd5aFBWNTlHN1ZjcTRTMFZFV1BVMWNuZ1JrU3lXdVdXdWJQbWRGN2J5?=
 =?utf-8?B?VnFhVjE1bGRCNUE0Qm1VVU9ZVGF4Z3NjR0VVQi9GRitvY0E2eGg3UEszZ2Nu?=
 =?utf-8?B?Qklrc2V6Rk12VVVHV0g1K3hua1lyUE5OamVWUGlKL1VORWZJdk1KblhtbTVS?=
 =?utf-8?B?SFRScG9VVm92YWxRS0VlOVdGU1lHaXNCRTlIUEZ2MkRQK00vYVNJRVVlZ3Ar?=
 =?utf-8?B?dVJHSWc3OGJEQmFUNDlOM3VwaU1uL0NGcW45RmFUWVVZZmphb0tiOHlxaStn?=
 =?utf-8?B?eXhZYVhGcGRLK1FaVytXdFpIY2pBY3B0WTE4Zk9zbjJPN3FNS2lObFhGdFJ0?=
 =?utf-8?B?YTByTmdJeTMzb2pqZ1QvZFpKS0RSQ2g0cmZyQ2F0YmtJUVZ3S0ZlcGFXcWUy?=
 =?utf-8?B?ZFRPUHpOQmZESFJVUUFPMUZYcnNQSTRxREdWSDNVNTFESkRPNXl2SWhvbGFi?=
 =?utf-8?B?emZPZnhweFNLQ0NKbGZsMmNPazNRQTRMWTNYNDF0UFpnaTZPZThQVThDdGhB?=
 =?utf-8?B?dXRmNHg3NnN4a0krMElNaGtBall5WnNLU1poY1dMTDVEQjVZM0ZIZkVKdCtP?=
 =?utf-8?Q?7hwZeM8YBN/91CZisZSjfujL9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 022cdbdc-9cdf-4742-befb-08db5ac353e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 12:51:57.9295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InDcEJy6GC4f3UYP4AG0dyrf1TefDt6LEg9q8ARo0mO3ZONNc4k3609hS9YiGFpgGQrdQUJLpZtRfA1dHoIJVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100; envelope-from=fei2.wu@intel.com;
 helo=mga07.intel.com
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

On 5/22/2023 6:25 PM, Thomas Huth wrote:
> On 18/05/2023 15.57, Fei Wu wrote:
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
>>   docs/tb-stats.txt | 116 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> I'd suggest to add this file in the docs/devel folder instead, and maybe
> use a "tcg-" prefix for the file name?
> 
> Anyway, please add it as a proper .rst file instead of using plain ASCII
> .txt for new documentation.
> 
Good suggestion, I will update it together with other comments in next
series.

Thanks,
Fei.

>  Thanks,
>   Thomas
> 


