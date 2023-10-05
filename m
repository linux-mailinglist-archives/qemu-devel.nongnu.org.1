Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7CB7BA54B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:16:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoR07-0001Vv-Df; Thu, 05 Oct 2023 12:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qoR05-0001VV-HT
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:14:57 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qoR02-0002sf-S0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696522494; x=1728058494;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6lqDn2GrmfcbTdAy34R09I53C+UWkK93pXBLE8cZVP4=;
 b=ejYOsX3c9BY/tpZdjh9PVEu5Z59IF5zi4ba7xNhUyp0SHNXuH4SjAo1z
 282+EaoiOTR+nWulLs4ZSMmqp6aYBHWBSAxwph4qEEosF1I5bf/uGHO/P
 IUSKhcZxKAG6V8UbtvrEukyyTm6SaM82Lgsi+sWrw65rpR9I6mmnoY8LX
 4LTUERs5mp48gQCZjnFNE1ljqoMXaiXoMCDaUJ7Kax33LFNshc9X7NgLm
 +HVKrV9yuKq2peuTLPd5APovYv6HORQ4Ihk1fZtARarab3+LLJ9YYvtsG
 lFMfiBk3HYIOq77geDK2kv6fR/ErcBRH9+WNhk8X5/6wFwLVT8dAW78Fi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386374820"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; d="scan'208";a="386374820"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2023 09:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083089152"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; d="scan'208";a="1083089152"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Oct 2023 09:11:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 09:11:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 09:11:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 09:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbVnwAPPneuw7bgctvNbGS6SGM+fdPVDRrSLcY9mTueFJZtLbnPvPQz2MxDNayjnuLHnOZ4Ez0Rtde0SVphQLE4z4qIzvLVcNwm6KaRBmQqwc7Z/yZgHaUUxvDSAGgPxpwPCkBEe/O1jiswmw1/iUJjSPj24yjnTv4b4Uvg4pTf7bIYMhPW+NR5AvHFpgt45oGhRMIJt0Kx8Kmw2FYi66onjSOfPwgeGlNbdXzxB6n/MKONnapBHYHjIjtODlNdlRR8TtwZvpxqsTeM7cdKb8SdGAm0u6NOSuFPKBzSIMz6CRAAuZVpKlzM6ycErq8IQRdzHULYwuOPTamwv7eWOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hKWyRTkBIujKujCKUn4gV4mzWBTX89APlgp9kr8GnE=;
 b=FUuRGtOhuSHhBmzA1IDXaHAfDXYepZuWW8dd4jJdy9HRSm6RhciOjTCKw7RI3/goHFFx3rQaQ4Z6lb3StWMQcqKsX1kgPReuN+FYrM4uHhM9izqzTJ94x7nvZz7NTjcJ7nuS3r6S0EMzADE7rruU27Tcd35tYS+eyAGgC9vpzzi2it72anyXq6mWxUOSXcKzSchTfnxLMrsYIV+Dt5v2zyfGcLAnGWstIAe8hLoMNySFvd7G1+wx4OwGWaWxlPxnoQEo//AAGhLpKBYglFRe8eexmzI2kspWBsj4X9ajIEPglESPjMdR3GzHq3Zk2ddPNosagAoLqK4+Ub03HcbuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Thu, 5 Oct
 2023 16:11:21 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Thu, 5 Oct 2023
 16:11:20 +0000
Message-ID: <12874c03-7de0-474f-9378-7d3ab8572d8d@intel.com>
Date: Thu, 5 Oct 2023 09:11:15 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] hw/cxl: Add QTG _DSM support for ACPI0017 device
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <thuth@redhat.com>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <Jonathan.Cameron@huawei.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>
References: <20231004180529-mutt-send-email-mst@kernel.org>
 <169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
 <20231004230132-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231004230132-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL3PR11MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: e478698c-85e2-4873-1625-08dbc5bdb621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Sju2WSjjGodXKi+nHJi5+38DC+FF0Sbb/Io6kfjCPgwSSI1iccjutn44519WvQYSOgxFA1kCbXfJn43C2aUjBuecbRpRzk7TK5XsOBzPQI+jAd39DCn+ni9xrsMFLwjwi4iFVTZOZRyRFanvRzkIY30RdJVay14ZTzaD+yVckG0pnqDv8KECLwuR1gAsC3yUOS5vqXqrZ3qnux6hsF4msX2BZMvYo1+saTVWOurHYtO5ua2nt8rctEw18OAgphrtLsVCHC+QavTxsK6jSX0wkiXJqINbz45GWatL3ZUkbpgDGSslNlhhulZTBq5qSl2O3TeZUJo7yho7/y4JGCzNkgUrDl2xOYzixMqeyaZiiea9WwaBgpA/9pV4zh4QwD43gQCiyHcv1Z3TNpcxeQR8V0rkLlVpvO6QJykIqbWMemnGC/x5I87hcAOwhTODaJ0E/D6AkB+7ew5CvnRkT5baZZ+CxTxdNqMhlRE32xkcBC/wi4n9TmjTp7AO8REzXJvqu+CWE+3B42Rqw1aTtvCm2krLlIxrdOKYCsIxyepr3b0NJVAj5MyqtSD3RfhCb3xBD7PpUm7fwq5b3bozG+63hXo1rAF9nMT5sHFnRp1DeLATJInFrZ1FFwJlau1eOtq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(6916009)(316002)(8936002)(8676002)(66946007)(66556008)(66476007)(7416002)(41300700001)(83380400001)(31686004)(2906002)(5660300002)(4326008)(478600001)(6666004)(53546011)(6512007)(36756003)(26005)(2616005)(6506007)(6486002)(82960400001)(38100700002)(86362001)(31696002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NHeXp3Ulh1QXl2c24reXA2eFpReWJPekZMMFJlZTV4RDhDODBnOE85anZr?=
 =?utf-8?B?SWtncnNicnovTDMxTmZZcHUzMXNHMnk1dXE1eURxMmhhTkhJR25nT3hQd3ZO?=
 =?utf-8?B?bWNockhuQ2ZDbU5GOExzeUhrVzVXSkZUck52YndjMmhFbmFFV3h3T3pUeUl0?=
 =?utf-8?B?VlNLQ2toelp2dGV3VGVtNDAvYlUveHNtbjd0bVRiWmlmUlpyRWM4WnRBVnVm?=
 =?utf-8?B?Y3I4Q3FYdHROMkxCUzBYRG10VlRNbUJDMEhrTDRFUVFTb0swRVdRd0ZvWnFI?=
 =?utf-8?B?ZElQYnI4aExCUVBab0pPdDEyM3NMVVAwMXJUVy9HWFBlR3IvNWN0TTI1MzI4?=
 =?utf-8?B?ZG9tMFlTcDVvK0dPU1dIM0ZabWVqbXJUdXl3YXM1NElkVDJ5S1gzczJkVTky?=
 =?utf-8?B?bDJmRXlUSUdzU2VUTzAyS2ZQMytqaGMwVjllcUpieEJWWUFITytrbzNZVXI1?=
 =?utf-8?B?cmdTblJOVlRTaW5lUzQ4U2VEK2pISUFMaXpDTkZoRUdWWFlYNld4ZWcxdXFK?=
 =?utf-8?B?TUp1eXdLVzhkQW45VzhPNWMrK1N4RlJYK2xrMTZ6UklwRkpYOU5DL3RvVFpD?=
 =?utf-8?B?c2cwelpqV3VjaW15TUhINTlQTFdNSm9xVkNEbm5SQTdGM0VkaG1CTmk0VFhN?=
 =?utf-8?B?V2dnUnN5T0lidkpZMWc2ejkzMnRNeHZiODFXNVpwSmttejdNVzh2MGozclBo?=
 =?utf-8?B?U1JNL3BySHVJQTVkakJJQk52WktGcm5MNUpiTVRya3QyUjFVVGx1TnJCNWJS?=
 =?utf-8?B?dVgycTUvYjh2blljY2NOZllDMTN0OERadEFSRmJRWnhEM1VNTzR5T20xdE1O?=
 =?utf-8?B?aFVVOFhWaFh3Q1NwUzBPMzF4L0hJNFdZWFVaa0FzOUJIQUhaYlJ3bFFKYjlP?=
 =?utf-8?B?S0FEWjEyVVhaMjlXdXlnTnZGdW1CRDY0VXVxSWd0a3hDRXRvMjBUOWwrWHVE?=
 =?utf-8?B?QkdZdW93WWxnT2s4L0szUjB2T1YrcDgrcWhoU0xPbUIwYWRvQzVaNjdyd2JR?=
 =?utf-8?B?bkk2Q29mQTdKa1JNaXVFRkx3YkpNOGh2ZFVDQ1JZVDNKS2ttWm5LU0k5bmNI?=
 =?utf-8?B?cnJxbHFCR1RJZVRobGRyenZhdUl6NlRwK0tKRUpPRVNDa045TDFwWWRKU0xW?=
 =?utf-8?B?a0UvRUFLYmdaMnZZUzdsMTZXRGRWZzF6VVF0eHdxVXF5KzVoYUFmRTdTeVJm?=
 =?utf-8?B?MkFBSEtzZDJJOHJzVHFMcW9iQzVIUjI5K1VIZFNaQitJQnRlanBJSGl3TjBV?=
 =?utf-8?B?bWJKd3QxM0NFN3ZBeFBtYU5WVGozMUxyd0lqdjJBQ2kzc1VXWm1vNHZsUzVp?=
 =?utf-8?B?endpSm5zVzc0LzJ6cm5PcFgvWXJSZitaTnJEQkwyZnlzQ1EzRUJld2NjZFJI?=
 =?utf-8?B?Wk0wOGJUUkJjRnVXOElMc0dZRk1uakErUm5OSkNqWmtJeklLZkdLRDRXREV5?=
 =?utf-8?B?ejBxSUx2djRmakdiaE1PUHBLY1IxeWVzY3VPaXpZYWxhT2dtODJveDJUcnpK?=
 =?utf-8?B?OWF4cGpQOUZ0NGZYc0xqdnJyYnduenV0cndRNVZmYnhoVUMzb3dUYmpDK1NT?=
 =?utf-8?B?RkN2OTVyK3hCendaVWhrM1lNT3ZtWVk5UzFzSytIUWR3YzlKLzkySkxERDFm?=
 =?utf-8?B?c3FLS3NwWittcVU4ZEZnaTJZMUFZYnYvUTVEK3BoNkZOWUtFZHBQbU9keUtx?=
 =?utf-8?B?eFk5L2lRaHNiQ3JzbjZDaENqUFVOQ2l2eHFXZC95MDdLM2N1Qk1BZVNFZHFj?=
 =?utf-8?B?TC9pWHlJTmNUSVMvajNsbHluOG1ZcndEbUtGMEM4M0JzR0dpY1lyL1NYU2hN?=
 =?utf-8?B?VmM5YmQ2ZTR1NmdmYWduajZjdWFIanMrYzJGL2RVRS80b0Zwajlqc2FmUlNW?=
 =?utf-8?B?dlpQU0loa2tyTHEzak5HdDFwYmloUlJaYVJsZHZnbkJuRStwR2syS0lmOGxa?=
 =?utf-8?B?anh0dEFWakpIYkMxYmxBZnNwS2w5cWZXdmxpbFhUdlY1d29vMkpGL29pekFu?=
 =?utf-8?B?Mlh5R251S2dKaUdXRHJPVFVaZ3JFUnRPR05HN24wM2NreW4yQ3U0VVFZODB2?=
 =?utf-8?B?NFIzUHJJdGNDa1cwenM3b1I0NVlPRFY2OEpmQXpMMFVQMU1PUm91RDh2bzVN?=
 =?utf-8?Q?85+IeOO/S7wKi1IdIyqT2k/AA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e478698c-85e2-4873-1625-08dbc5bdb621
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:11:20.0062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugA2iK9rkSIjVuLM1hidjTbGv5tlkrM7AG7UOeziKshMaMc3MmxC4pAp8L08QrRXYoVZ/cqgDhOOe+pGdAVrWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/4/23 20:36, Michael S. Tsirkin wrote:
> 
> On Wed, Oct 04, 2023 at 04:09:07PM -0700, Dave Jiang wrote:
>> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
>> ID value of 0 in all cases. The enabling is for _DSM plumbing testing
>> from the OS.
> 
> 
> the enabling -> this

will update
> 
>>
>> Following edited for readbility only
> 
> readbility only -> readability

will update
> 
> 
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
> 
>>             {
>>                 Return (Package (0x02)
>>                 {
>>                     Buffer (0x02)
>>                     { 0x01, 0x00 },
>>                     Package (0x01)
>>                     {
>>                         Buffer (0x02)
>>                         { 0x00, 0x00 }
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
>> ---
>>  hw/acpi/cxl.c         |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/i386/acpi-build.c  |    1 +
>>  include/hw/acpi/cxl.h |    1 +
>>  3 files changed, 57 insertions(+)
>>
>> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
>> index 92b46bc9323b..cce12d5bc81c 100644
>> --- a/hw/acpi/cxl.c
>> +++ b/hw/acpi/cxl.c
>> @@ -30,6 +30,61 @@
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
>> +        /* CXL spec v3.0 9.17.3.1 *
> 
> 
> drop this * please
> 
>> , QTG ID _DSM

Ooops. git format-patch mangled this and I didn't catch. Will fix

> 
> 
> this is not the name of this paragraph. pls make it match
> exactly so people can search
> 
>> */
>> +        ifctx = aml_if(aml_equal(
>> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
>> +
>> +        /* Function 0, standard DSM query function */
>> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
>> +        {
>> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> 
> function 1?

Yes, will fix

> 
>> +
>> +            aml_append(ifctx2,
>> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
>> +        }
>> +        aml_append(ifctx, ifctx2);
>> +
>> +        /*
>> +         * Function 1
>> +         * A return value of {1, {0}} indicates that
>> +         * max supported QTG ID of 1 and recommended QTG is 0.
>> +         * The values here are faked to simplify emulation.
> 
> again pls quote spec directly do not paraphrase

Here it's not paraphrasing from the spec. I'm just describing the dummy value that will be provided.

> 
>> +         */
>> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
>> +        {
>> +            uint16_t word_list = cpu_to_le16(1);
>> +            uint16_t word_list2 = 0;
>> +            Aml *pak, *pak1;
>> +
>> +            /*
>> +             * The return package is a package of a WORD
>> and another package.
>> +             * The embedded package contains 0 or more WORDs for the
>> +             * recommended QTG IDs.
> 
> 
> 
> pls quote the spec directly

Will do.

> 
> what does "a WORD" mean is unclear - do you match what hardware does
> when you use aml_buffer? pls mention this in commit log, and
> show actual hardware dump for comparison.
The CXL spec says WORD without much qualification. It's a 16bit value AFAICT. I'll add additional comment. Currently I do not have access to actual hardware unfortunately. I'm constructing this purely based on spec description.

> 
> 
>> +             */
>> +            pak1 = aml_package(1);
>> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), word_list2));
>> +            pak = aml_package(2);
>> +            aml_append(pak, aml_buffer(sizeof(uint16_t), word_list));
> 
> 
> It does not look like this patch compiles.
> 
> So how did you test it?
> 
> Please do not post untested patches.
> 
> If you do at least minimal testing
> you would also see failures in bios table test
> and would follow the procedure described there to
> post it.

Sorry about that. I compiled successfully but did not test. The following chunk is tested. However, is it the correct way to do this? The comment is direct spec verbiage. I'm not familiar with constructing ACPI tables in QEMU and tried my best by looking at other ACPI code in QEMU. 

+        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
+        {
+            uint16_t max_id = cpu_to_le16(1);
+            uint16_t qtg_id = 0;
+            Aml *pak, *pak1;
+
+            /*
+            * Return: A package containing two elements - a WORD that returns
+            * the maximum throttling group that the platform supports, and a
+            * package containing the QTG ID(s) that the platform recommends.
+            * Package {
+            *     Max Supported QTG ID
+            *     Package {QTG Recommendations}
+            * }
+            */
+            pak1 = aml_package(1);
+            aml_append(pak1, aml_buffer(sizeof(uint16_t), (uint8_t *)&qtg_id));
+            pak = aml_package(2);
+            aml_append(pak, aml_buffer(sizeof(uint16_t), (uint8_t *)&max_id));
+            aml_append(pak, pak1);
+
+            aml_append(ifctx2, aml_return(pak));
+        }


> 
> 
> When you post next version please also document how the patch
> was tested: which guests, what tests, what were the results.
> 
> thanks!
> 
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
> 

