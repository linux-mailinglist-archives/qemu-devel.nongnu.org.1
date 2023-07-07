Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414A374B5A6
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 19:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHp4x-0005Lj-VB; Fri, 07 Jul 2023 13:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHp4u-0005LF-9w
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 13:17:08 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHp4q-0000Q3-Ms
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 13:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688750224; x=1720286224;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hAuWgM7XR55m5fa1BOOHVU8aCMubWdNNzx1oXDfN7ik=;
 b=RoWCf2aV1fAkPqYlZhzFRbqeIYkWo3GARVdpdk+EiedPSTTk81HSvRif
 OyzhkTKYST6HCri8pkmt6BfO5dprsMiImDe4OvjyZ6TwuKCeneSYfk0LU
 Rh0W/kvWbEjN4B6v15UvE9beLFMjpKxaxi3NpqU+gWeaYklCXm3HTFuFc
 6f1lwuUU6bgZenGgKcwuK5sHSg5pT1KUowFL2ub30JqzU5FrCJzGYreGZ
 Q1LKU8Icvc0bN63foZfZxhCl13A9ZsyEgMeQ86NrnRaQIANqjbSbBKJ7c
 P45sIZQto6o+Wl+/5a5mwVi2QBLTuNhONUTdzqQWDo0qDVi8X9ATtATm4 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="430001727"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; d="scan'208";a="430001727"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2023 10:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="1050618561"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; d="scan'208";a="1050618561"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2023 10:16:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 10:16:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 10:16:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 10:16:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYcrk6JiFREXdbl9SPBtNQcdgz9//kxaqzYf8L7FQgE470AVBfuJitnBcrgsht/jIbZiODHJDaCB7t/HR8HNWCtIXYZAiInecsLy2SKeJ4YGiSmpB7fL5cbve6BTWQpBKFpEEAg7T+mhSxDVnk2d1UJTeWsF5s7pp35fzvYbgiGzk8kpxmHBZD4A5jVkHX11Gw5RLgXEBBo+xnwUhT5Ix11dL5w57K1YfkCkw0h34eHnl/O9JG92QZqgZ915+OfIiULwkcsNkKSbeDELg/z3yHxbY7CGfarNQ6ba87Ak/KAHwH17BYMk7l2NpfysFKNIvLBi7ViI9dLcomcFtiWjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XVvwEDU0nSP45DAHPZrCYlavj810qc3ziSwhXlbanQ=;
 b=CuIenbDNNciJ9QOWCdViST25TkqObyY1V4rOtvXZ/iWEFP9TZv+cv7rD1CRIbOWZv8hl4g6F0raxthYKq/P/MyeSTX4p8UkBHKf/dJbUsX8sN/m1kSkubk3/FHacPLtq2CgaHM63qEfwkslPQ8RcBh5GnplkTpxiMiAiECeqcIIitqtPDBf/EHoCT6RPwuljvbNoGqV/6ANT1q6HnyeT3VcRIB0KlnNYAIKL12Vx4I+h6ruYOJGWF+hsNlEZhIsh8f/vrO3a49maeq0tXTmgspwe0RDHDqOOXdUeTf4nzOaLNfJYF+G/FFjFjIFMapJnycRmWJuFcgSF7djOxo4QAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 17:16:52 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 17:16:52 +0000
Message-ID: <6351a85a-db49-7d6b-2a55-1ea7c65b3a8e@intel.com>
Date: Fri, 7 Jul 2023 10:16:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 6/9] ui/gtk: Add a new parameter to assign
 connectors/monitors to GFX VCs
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kraxel@redhat.com>, <berrange@redhat.com>,
 <philmd@linaro.org>, <marcandre.lureau@redhat.com>,
 <vivek.kasireddy@intel.com>
References: <20230621004355.19920-1-dongwon.kim@intel.com>
 <20230621004355.19920-7-dongwon.kim@intel.com> <87h6r1mkhc.fsf@pond.sub.org>
 <46dc1ac2-2ab5-48f7-73da-4160c26c3171@intel.com>
 <878rbrizmo.fsf@pond.sub.org>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <878rbrizmo.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::49) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1808c1fa-bf5a-4ed4-fc7d-08db7f0df4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DJ9jqAPCS5QjZgmjqsvOY6RagiHnCclXsWeRgEH+A85BSud97B+6qv2BJrLnPz96xt9quNrhcdM3zdhaxGy+HhQKO2Yn9qP3PrSFWkggs84MRWKenf1LBHkCTwxUzBtdpVSeZ5kmMRDrN3b19CoCbr+8YHY0fpucSLfwOhsfzx5yioJRaI78aiGPKsIbur/U5MGlTaoi4lDNxg8KFHmd0cYtqWcjX7j6QronVA1KB+AbHwTMELFDfbPjm16OOaJJO7K3DpBk9tACMLnN/Hbu1iRT9ZoDjMa1szbnImIzomBMNObPZAKI+36Mxsa0DKSjAUpE2wgbTT5UKduS8D1w7xXuVJlwe92Hc2Z3FJlGxiJ0lXNHGtn6JZuEnmxADbOCjXP5e9r5NJ7lqaCrQuD9/GZzqX6tgSG4E++Lyun1eF5gLdmqFwkK5g69qU1D9ryQaJYTryKwMxSUcI8kTc/lsEpKELpN6mMZNxoiVSAi8iDSZ+3q5/+yn5Q8HwdO+PJ0vxB/XsWoTjf+HJAlCxH2i2/jeVtQ+2W24mFC+WOb3oL6jQ2VwJ5EKXDyLVMs3ni6TifkvsYu4wZy/4LuvzqhjY6qdfHwx6SbBGPaAOEdCvVgu0RlIYhBsXeH1bj3ItjMPi5ib+7Di7vegMNQtqa8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(6486002)(26005)(53546011)(6506007)(107886003)(6512007)(186003)(316002)(2906002)(66476007)(66556008)(4326008)(41300700001)(6916009)(66946007)(5660300002)(8936002)(8676002)(38100700002)(82960400001)(31696002)(36756003)(86362001)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjhLNjZRdEpoemx0akF4eTVzZCtyT1JCa0pXeGxqbXpERW9MS25MQVBHdDhp?=
 =?utf-8?B?OGYzUGp0ZW8rVVU1RkRwOU1sTjUrVGhzRGhFWmRpRUNHR3lKTDNiZ203MGRN?=
 =?utf-8?B?R2E0OCtGUitiMzhDWUYrVnNjZFBLQkxzbUh0MWtlRHNVaE1QNDdPYjI5VlBW?=
 =?utf-8?B?bk5zMXRWSUd5Y3RIK0tHa2FDc1RoRUQ1SFQ4dTAwOEF1V1UxZ3NIRGJ3WTBq?=
 =?utf-8?B?RW50Y0FueGRQcU9HVVdXc25OOTdIUytqUUdqS0JhTFVoYnB5elloYlU3R2Ju?=
 =?utf-8?B?ak9sclJiWGM2TFZQaTlYSngvdG4yRklKeGNMaWVob0dUamFPRXNRUVpiOW5z?=
 =?utf-8?B?VWhJaEg5TDJNV2NETThsYU1jM1Y5WlhraGJYbFBhekxSc1QyUElPeUxmUm8w?=
 =?utf-8?B?Z3llR1F3QkRkdmJVaE52OGxlOUM1akwybUY2WGdjWXI0WUV2Rm9pM0NiVVJJ?=
 =?utf-8?B?dTVkVFZGOVV4OS9YWnJRT09jSU5GN3ptczRCQm9HT1FTVWpzRnpYbGtRNnRx?=
 =?utf-8?B?U3h1Q2NSQjZReVVMV3hzTzVhYTRiblh4TC9GQUFYanZVZy9Wemx1YmpPTVh2?=
 =?utf-8?B?bnZDUE9nNTNXT1A3TXJ4b1NvdmtjYUtKakxsRnkxazBBNjZpVkZTZWRiWWNh?=
 =?utf-8?B?dFQvc2haMmlxQWpQMW9HZ21JM2dWbnRuLzdMSFlpaGtna3FZK3JrOTRvelcz?=
 =?utf-8?B?cWd4L0M4SFZLZ2FTMzhoWFdNbUoyU1YzdWlrSXJReUNIbXpsU0Y1K3Y0dzhQ?=
 =?utf-8?B?WlNwV2pKOXBaNGZ1YVNHbFlncGs1R05YMGlXd1grNmpjSXoyb1c3Z0ozelFL?=
 =?utf-8?B?OTZIZkZ5dFRJc3A4SmlEbVdlQU54UmpHeEFLUXo2TUlNOGN6cWVUM28zRmlh?=
 =?utf-8?B?MExhZ00vT2VHVTJ4aHpxMFBnTlg5V2dhaTRpeDBuVGtueDJDcHk1MmpxZzNE?=
 =?utf-8?B?ZG5oRUNjT0VCMzJUVytDblFmYURZcXFXUzh6ZkdUSHJ3aVpsSHNSZXl5ZGxj?=
 =?utf-8?B?U2VxWW1SUWVCYXFBRWlnRnR2cDNhVjJtUEQ1WXdTM1BpcnAyZUUyWi9HdmY1?=
 =?utf-8?B?bGFzMHNEZ2lDeVA4YjJqR1lzZ01HaHJrbUJ5c3VJaEkyWGpzekNCSFpiUnEy?=
 =?utf-8?B?Q1c2RlZpVitwRG9GakJ1NHVHTjBHKzN0ZGdFZ3BmZjJoM0pOSXdsLyttS21s?=
 =?utf-8?B?UTBScE9ZQXhsYVVTQnNYdytVL0MraTB6RjBlakdPVlIwWXpadWIyTlV1UWVL?=
 =?utf-8?B?MTI0NzJYZGVmbDd2SEVwM3pHeE42ZFFEay9pV3pjOW1zMnJjbUpHUDFIcWRF?=
 =?utf-8?B?M0JMRENQeEQwMjdRdDhSVEs0VFpJMXUzM3hXaEczd3B6eU5leDBJMlpTV2Q2?=
 =?utf-8?B?UkVlSFQ1UURVeHo1Y3dWSDVYR2tnb0hTQ3Y1RHBjdTN1cmtPRC9nbUdYREFL?=
 =?utf-8?B?ZHVOdEdxVzFhQ3liNXZ1TzJwME9pay9VRmc2WGhlYm9CTmdjdkVzQmlyT1Nt?=
 =?utf-8?B?cGk3WG02VUdPNW1TbUNnMHAwQ0hncEVGdmNXUmZoZlRXZExUTXZ5bmxwZncx?=
 =?utf-8?B?SWFRU24zTUVsNlVFNHpHVW1VRGRySzBWdmFMQys4Qm5ob25WNThqUTdhWTRN?=
 =?utf-8?B?c2taenJzVFE0RjUvQURyT21xTXN4SUF5ekxWOHhMMzk3MUo3YVNKOSt2ZjMr?=
 =?utf-8?B?b0dhVyt1MmpBWEV0Q1FVbTFGZGFxcjVNN2FiV0NDSWg4c1BSOXhTU2Jid0VB?=
 =?utf-8?B?alNuZ0lURW9xWnBaajFpbDdTWStENm5MQU1sZ29vNnk5T0MyeVVaSDFEaGJk?=
 =?utf-8?B?V1pJSU1STVJ6SnZLTS9wZEJac3hHdUxSSzUzTTBrc3pIbUFkMWVoU2dINWov?=
 =?utf-8?B?bzROR2pNZUlaUFBkTlVVTyswNU9YbG1obVZEY0NMbjllbVg0bGhJcjRLTmtB?=
 =?utf-8?B?UDA3SFQ3M0Y4bEQrdmdtKzRMckxGcnlUeUxjdG55TVdNd2hzbGRYMkNuQTFw?=
 =?utf-8?B?N0QvQWNTeXVMQmV3Tk96R1NoVkJUM2ZERVc2cndjZWp2S3hxdzVEMGpvR2s4?=
 =?utf-8?B?SDhkNEVURlgzbG55WWdKOTFZUUhuRlRVeENmVzNIYjZqSVd1L0UzYnUzbGJr?=
 =?utf-8?Q?kUoFkK88JmwGoODwnEYSraGpR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1808c1fa-bf5a-4ed4-fc7d-08db7f0df4c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:16:52.2403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0qzB0C9l1SJzbyTKCM7BAfpvw02s17qFo15nhRk8SkxBN2Av6Ht/yL3wN/2qhfmfwUCZejCsVxQD1ezKJvCvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=dongwon.kim@intel.com; helo=mga07.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 7/7/2023 7:07 AM, Markus Armbruster wrote:
> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>
>> Hi Markus,
>>
>> So I've worked on the description of this param. Can you check if this new version looks ok?
>>
>> # @connectors:  List of physical monitor/connector names where the GTK
>> #           windows containing the respective graphics virtual consoles (VCs)
>> #           are to be placed. Index of the connector name in the array directly
>> #           indicates the id of the VC.
>> #           For example, with "-device gtk,connectors.0=DP-1, connectors.1=DP-2",
>> #           a physical display connected to DP-1 port will be the target monitor
>> #           for VC0 and the one on DP-2 will be the target for VC1. If there is
>> #           no connector associated with a VC, then that VC won't be placed anywhere
>> #           before the QEMU is relaunched with a proper connector name set for it.
>> #           If a connector name exists for a VC but the display cable is not plugged
>> #           in when guest is launched, the VC will be just hidden but will show up
>> #           as soon as the cable is plugged in. If a display is connected in the beginning
>> #           but later disconnected, VC will immediately be hidden and guest will detect
>> #           it as a disconnected display. This option does not force 1 to 1 mapping
>> #           between the connector and the VC, which means multiple VCs can be placed
>> #           on the same display but vice versa is not possible (a single VC duplicated
>> #           on a multiple displays)
>> #           (Since 8.1)
> Better!
>
> Suggest to replace "that VC won't be placed anywhere" by "that VC won't
> be displayed".

yeah, I will update it in v2 and send the new patch shortly.

>
> Ignorant questions:
>
> 1. How would I plug / unplug display cables?

I am not sure if I understood your question correctly but 1 or more 
guest displays (GTK windows) are bound to a certain physical displays 
like HDMI or DP monitors. So plug/unplug means we disconnect those 
physical HDMI or DP cables manually. Or this manual hot plug in can be 
emulated by you write something to sysfs depending on what display 
driver you use.

>
> 2. If I connect multiple VCs to the same display, what will I see?  Are
> they multiplexed somehow?

Yeah multiple VCs will be shown on that display. But those could be 
overlapped since those are all placed at (0, 0) of display in many 
cases.. but this all depends on how the windows manager determines the 
starting locations.

>
> Old question not yet answered: Using a list for the mapping means the
> mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
> what we want?

No, it doesn't have to be dense. In your example, you can just leave the 
place for VC1 blank. For example, you could do 
connectors.0=DP-1,connectors.2=HDMI-1. But in this case, VC1 won't be 
activated and stay as disconnected from guest's perspective. I think 
this info is also needed in v2.

>
> [...]
>

