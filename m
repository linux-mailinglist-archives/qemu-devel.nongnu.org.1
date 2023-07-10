Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF4C74DF56
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 22:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIxXt-0005SE-19; Mon, 10 Jul 2023 16:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qIxXb-0005Rp-EY
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:31:29 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qIxXV-0002Ll-F0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689021082; x=1720557082;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TtsnWdnqLPwG81sH0DhOKci3J9o6dDdFXWI6qxcOEvQ=;
 b=WmxBwpMxjkQcAVgBXLI2b5xWlpYXdTthCEVQdtC+JhFh9MzIK4Lpy9bO
 zk6dQmejUqt9APOvzp8vAfAAFtgfHatcU2JCggYObPJcNxHevAsWOJS5O
 dEoUD+yIJRFzPqzezm0PBjH58LSC1sA1TTxQbvL7irNcce3nShS6PuKjW
 3K1+eofmyKdmQMnri+GCAIwGOnWEW0bFVLO2/4lLgzix2NbAfI2DHUfdm
 I+T7MSJarxCVc6UX33e3Uf4BDWtCmuZjABdOdlPzC0AkFU9QZAHkLWxXx
 Gz1q9+Q50duShrL1poy5B2JP1EyrkgZzLRttcPET9k6MxXteyed8djFAk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354309064"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="354309064"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2023 13:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="845018273"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="845018273"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 13:31:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 13:31:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 13:31:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 13:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEj3/B2+8FLGKCKZaI65tyJqswEmfLn78EKi+ZJkwAO6CNzSkMNLypZERenJRJqxdwAeon4/52MzsDfEcefwhCb8FBkWYSu/A4fdqWURns/ReYHgJvtxeW00KHuzGwVFz8e1N0cHrDn+a8i5iIXDjpx/TlXr4jqDk4W0ADMLzg2qpwpTvtUOkeiHz2E9EDYYv+Zd8+558YzY42Hikp02HE4umwZ+KtlzGNddsxl7/WlM//ybgQTVJsbtU50fGqkTmlDwPZeBVYd5sYOkevO8/DXSwCTVXWqd6gNnBhDAERZRXgOVAApmnbsNo2PtbpwHLnzo7600r5PupNK0QyUPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai/Mkwy0tm7yMBzKXW3Sqf0sWI/Aq51F6nNIt55uAXY=;
 b=nIaTI11NnCai97/gYleNYFsozok22s9tHUT3qlQAFhabtY0WVA7hmpkRtL/I9FbtiLr1U4UBnjve94/+waHQc+JoL//qgIopWOMrvKykXWQlKh55AXFL8mQ7QN8V7A8WzH6/pC7etaDdp0PzJry9+wcotjV3hr3yN6PTh1dZgTubI4MVuG6g4co6qoNIZJibWuF1KxDdJp2E1dmKWZ7PWOg+fL2I7KHbI/XyswecHEf0Dld6yEbxaVj3Z/dvoO4/vEjfoVPMmGwOmioVgtX/Sacl8JzOPrbp3CSh4SNVdKTdvuWLsJF9OznboyKppo8AuzRkTceBrOofUR+/bc/+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 20:31:04 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 20:31:04 +0000
Message-ID: <ed732fc3-bb1d-42da-e179-0dcd08c663a8@intel.com>
Date: Mon, 10 Jul 2023 13:31:01 -0700
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
 <6351a85a-db49-7d6b-2a55-1ea7c65b3a8e@intel.com>
 <87r0pgb8su.fsf@pond.sub.org>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <87r0pgb8su.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|IA1PR11MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: deeb00ec-b67b-4930-d939-08db818494f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVnqAplgdZYYnia5G5igrkU613UJeynpZB6y9Z4P9scsnXBWjthXHVVxrWfuRCCv3T+uOM1RSnlB+MmxLCvpk4I1hdPJyNEQ/kR+rBsTm/sy8ZX7OE8qXgTEZJAGqMvD+HokonKGrSxlhpRvhCA8qqwLu919TQTZj7+xxcRputZxGPoaUc2oNcmRSjPw3cA//oZrXoiWA6dUDXnXHHxZrDh9jeEvZv6fQK4UNnuepi0slmCv5pGkKart7ivR8lbC3268v8O8v7oZRIJFYzQmZZmlLEEcAY9S6OhbsM1CvV5qgAmFLnFIe0IHRtgPf+Ztzva/eYBmUypUf2chAbJVIz2k7O4/lsHBZAi3ensE0wah9zI2Nzv17mGoEwxRAJroV9joKcqRdXCcBPVS1FMrBqFjaweH1BZyv2WE9FLYXsdKMNYzOdHNJHOEGaui0iKZONEWOF9eyGq68pd8G/M5cvWOAR9/7ndU1IGE7vVBZcp0PsDz9jPdaImXrrYxRbIyb9j0pp9zNHmbLj+9ZYjRWO8LTw9GIeNOso9eI6rtkYIOAA7zx930vYhy4SLVrYfM6lKdT5My1ie5gaUerNfgllTADCYYBp0lxy1GDaYst2UkmTZ+b+WQMMagC870WxtZ1MTF5y3yRTE/yvAYP/+ghA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(6666004)(6486002)(478600001)(26005)(53546011)(6506007)(107886003)(66946007)(186003)(6512007)(2906002)(66556008)(66476007)(6916009)(41300700001)(5660300002)(4326008)(316002)(8936002)(38100700002)(8676002)(82960400001)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNCeEoyRDBWWUJTZlpwY0xNZFRMWXFDc2NIaWJpNWgvME95Y0lLaFlHcVAz?=
 =?utf-8?B?RzJiSzNqRjNqT29zRWt2NExFanJ1YXRKQWVERVFGM0Z3L2ptc3R1RnpFVTJ6?=
 =?utf-8?B?VGQrQzdoaWhNV2hIaWlOanpKY09lM1F2RkxBM2JJQjJhZDQreDRFQjd1VmQ0?=
 =?utf-8?B?dko0aVVNaExnWHNQZkJ0eTFhMmFXRGRmMmdDbmVFZUIvZWhPcjViNDVKbWdR?=
 =?utf-8?B?VE1pRFRqbWV4cHZGWERyUTV0cEF2dHpSaVEvNWdjVUp4cDcxaGNTc3Y4UURW?=
 =?utf-8?B?aGpGN2R2R1pCMGZLNGc4VkhPKzdOaHc1Mmh4YlgyUjI2VW9TbnpScnJCN01D?=
 =?utf-8?B?dm1NOUdUNjNTQjI4YlMrTWthcFdubXdBTE9OWEt6TUIvMFQwQVJST016cCsv?=
 =?utf-8?B?dG1JdGVaVkxtZHI4VWlCYkpsU1loM0JXdzk0d05NL1FhaUM2RldhenMxNGZH?=
 =?utf-8?B?cGJiZ3pWbHQ2a1BFMmc3MTZua3BXVi84dDZFcHlJNndpN1BRSWlXYXRsMkdq?=
 =?utf-8?B?RzNhQndjRW9wOXhIcGNhT3VHY1FwUWVhRG5Kc01RelNaRXdoaTEzYXp0QTUv?=
 =?utf-8?B?ZFhXLzBlYm81Vjk5Q2t2UHBsc2FQUGdVTjQzNjB1NzJ5QW1rQ2RMOE1ubkZr?=
 =?utf-8?B?UlJVVUk2T3E1OUgzNStJSy84V1BJRzFubkJKNjg3SEhiaFp4UVQ1VU9WS2Jz?=
 =?utf-8?B?dkhTaU9BSVlIVnNHNjBpSVhveVBnbnN4VVhPLzAyWE5vc1M5bVYzVWtlOU02?=
 =?utf-8?B?RUZLSExNeTU4U0hWeUgrYVhINXZ1VndYL2lYMzNKak1pQmZjZXB4SCs5NlJq?=
 =?utf-8?B?czM0TDhIdEdLb0RENXFRK3BjM3NDRXRxUk1td3padDdvd3dvbXFmTDVZcnJG?=
 =?utf-8?B?SFRtbUwySURrenVHNzVsNDNaUHg1ZGdwTDFQVFlYUkx1Q2VRS2lCcFZKTS9z?=
 =?utf-8?B?aG1iYWhRVnd1YlIrSjNpUkNBaithWU4rN3psbllzeTBBNGkweVozbHRNRXJk?=
 =?utf-8?B?amh2OVJWYkpZMDE0V3lSaFIvQXVNOC8zYnZxSzREZXFyNklWOTFHUWVteTF5?=
 =?utf-8?B?R1BFVjc4MEtaNXFjdkJjRGljQ3FzcjFHYXlNdkhQblMrTmxrQnQ4dGc4OGpr?=
 =?utf-8?B?QjNrUS9QMW4vbzV3RUlXRVN2SUlaTVAwbEltZmdNeWU2cWZVdTVyNDFDNTdJ?=
 =?utf-8?B?MEhaa2ZCRFNueUlETVhJTnNPUXhXYkRjQ0hxc1JnTGxVWFQ4RnFsTVV2cHpJ?=
 =?utf-8?B?Q2EvMlI2NDVTY0FzOFBNdGczVGhPNjZTNkhIYjdYOTZZellUcUxLOWE3ZEl5?=
 =?utf-8?B?RWtnTDFjek9ObkEvcTY0VnNuR2dGaVY3UmtRWHo0N2g0T3ZQWktOQnBnUUUx?=
 =?utf-8?B?NWd5Y2FKc2s4cFc4U0FhRFVOMHhPaUlaYjBDSm41Y3Y5cDNqbHM1czhaNDkv?=
 =?utf-8?B?RDdGRDBNYm9MTmNaNFJBVFdwYzFldUlwOHlHeWhnYWEyaGhNWGg0T0tqcGdB?=
 =?utf-8?B?ZGFJcnN3Um5VYU43dDl3VFBvTUxXUEtubnFWcUREOWptSWVKNUtQQW1zUEpH?=
 =?utf-8?B?dXVQRmg1N0E4ZUVkTXJFV2lCbkQ1T010dDZBNXY1OFFTdGFTZ1JhUURYNnQv?=
 =?utf-8?B?NmJ5M1VYSFM5Q0ZrVGhHR3RBRzhtSmhHaE9jSkJTZ0xLSEpmK2JYQXhMVXZJ?=
 =?utf-8?B?TnA1Z05aWUpOcml3TFZOUlhqMks1YXZBRVVBR3BsL056WE9QZG9TM2c1eUhq?=
 =?utf-8?B?TmlwSFdDL21UM1hKWVFMdUwwZkZNN3U2U0tSVUN2Rm5sYUlleVJlUEFkWStl?=
 =?utf-8?B?ZS8zY2tjekdZRjNTRHY3UGd1ZDgvQVdlZTg3MDl5cnllUktrdkFUTjRJazRH?=
 =?utf-8?B?Zzl0a2dqcDBSRk0xMCsvYTR6TitGS3VBaEg3b3k1VjNJQ3NlZDBEcy9sdWFB?=
 =?utf-8?B?QkN3eVlManJzOEhKbGZPODE0UndsTm5kajNmU0l6T09rZlVDUkFubnp4VnFw?=
 =?utf-8?B?YUNKUHFXMG05TW93bXB5bE15WUVieFcwcGUyeDAzeWcrM2UzL1BMdVNuRHFu?=
 =?utf-8?B?Q2xTRW5XRnRmMERoOWFGN05BNnNtakFSWFpRSmptckt1WXVMNEpCVnk0cTBx?=
 =?utf-8?Q?0eguzLqNht9lH5RXA/ifBZtJf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deeb00ec-b67b-4930-d939-08db818494f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 20:31:03.9645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6hByEHFxg2v2J+sRooXXfm4QoqRq/YwbvIaoV8vp1V8Qx98e+IVkRhcePWeM/4qeyqZHCJvVLLp4rrETlv2+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=dongwon.kim@intel.com; helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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


On 7/9/2023 11:05 PM, Markus Armbruster wrote:
> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>
>> On 7/7/2023 7:07 AM, Markus Armbruster wrote:
>>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>>
>>>> Hi Markus,
>>>>
>>>> So I've worked on the description of this param. Can you check if this new version looks ok?
>>>>
>>>> # @connectors:  List of physical monitor/connector names where the GTK
>>>> #           windows containing the respective graphics virtual consoles (VCs)
>>>> #           are to be placed. Index of the connector name in the array directly
>>>> #           indicates the id of the VC.
>>>> #           For example, with "-device gtk,connectors.0=DP-1, connectors.1=DP-2",
>>>> #           a physical display connected to DP-1 port will be the target monitor
>>>> #           for VC0 and the one on DP-2 will be the target for VC1. If there is
>>>> #           no connector associated with a VC, then that VC won't be placed anywhere
>>>> #           before the QEMU is relaunched with a proper connector name set for it.
>>>> #           If a connector name exists for a VC but the display cable is not plugged
>>>> #           in when guest is launched, the VC will be just hidden but will show up
>>>> #           as soon as the cable is plugged in. If a display is connected in the beginning
>>>> #           but later disconnected, VC will immediately be hidden and guest will detect
>>>> #           it as a disconnected display. This option does not force 1 to 1 mapping
>>>> #           between the connector and the VC, which means multiple VCs can be placed
>>>> #           on the same display but vice versa is not possible (a single VC duplicated
>>>> #           on a multiple displays)
>>>> #           (Since 8.1)
>>> Better!
>>>
>>> Suggest to replace "that VC won't be placed anywhere" by "that VC won't
>>> be displayed".
>> yeah, I will update it in v2 and send the new patch shortly.
>>
>>> Ignorant questions:
>>>
>>> 1. How would I plug / unplug display cables?
>> I am not sure if I understood your question correctly but 1 or more guest displays (GTK windows) are bound to a certain physical displays like HDMI or DP monitors. So plug/unplug means we disconnect those physical HDMI or DP cables manually. Or this manual hot plug in can be emulated by you write something to sysfs depending on what display driver you use.
> Let's see whether I understand.
>
> A VC is placed on a *physical* monitor, i.e. a window appears on that
> monitor.  That monitor's plug / unplug state is passed through to the
> guest, i.e. if I physically unplug / plug the monitor, the guest sees an
> unplug / plug of its virtual monitor.  Correct?

This is correct. When a display is disconnected, "monitor-changed" GTK 
event will be triggered then it will call gd_ui_size(0,0) which makes 
the guest display connection status to "disconnected".

>
> Permit me another ignorant question...  Say I have a single monitor.  I
> configured my X windows manager to show four virtual desktops.  Can I
> use your feature to direct on which virtual desktop each VC is placed?

Would those virtual desktops will be their own connector names like HDMI 
or DP? We use the connector name for the actual physical display you see 
when running xrandr. I don't know how virtual desktops are created and 
managed but if they don't have their own connector names that GTK API 
can read, it won't work within our current implementation.

>
>>> 2. If I connect multiple VCs to the same display, what will I see?  Are
>>> they multiplexed somehow?
>> Yeah multiple VCs will be shown on that display. But those could be overlapped since those are all placed at (0, 0) of display in many cases.. but this all depends on how the windows manager determines the starting locations.
> Got it, thanks!
>
>>> Old question not yet answered: Using a list for the mapping means the
>>> mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
>>> what we want?
>> No, it doesn't have to be dense. In your example, you can just leave the place for VC1 blank. For example, you could do connectors.0=DP-1,connectors.2=HDMI-1. But in this case, VC1 won't be activated and stay as disconnected from guest's perspective. I think this info is also needed in v2.
> Have you tried this?  I believe it'll fail with something like
> "Parameter 'connectors.1' missing".

Just tested it. Yeah you are correct. I think I had a bad assumption. 
Let me take a look to see if I can make it work as I assumed.

>
>>> [...]

