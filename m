Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8875EAA4
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 06:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNnTy-0008LK-RZ; Mon, 24 Jul 2023 00:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qNnTw-0008LA-RG
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 00:47:41 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qNnTt-0001FE-WD
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 00:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690174057; x=1721710057;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PUR3V1vVVCJM4yqtV+kHEZFzK6yqExhkwi4dsN00Krk=;
 b=hc8muqLK/3pJPSXU1d1hZk8DnQSeJGJCkN6chypm0oh41Jdb7cG+8CD3
 SvBnBFLMTxneFqDAAe/rWo9AxLo0y4j6HygCbqbYDZ7hToZnoZDggEvMI
 9BiqdppGt4l2ZZ58cycOQrJTDdj7kCERWJ922PB2B7ufm55ygwGK94WMU
 F/eEpizY5wnpYGRd385LAsCYRM0+I6VrP4mXv/mfYHd18u07V/KXdElEh
 bZ9XIpzWg1n6bz5Wytp2X6aIbsjlNmsSnmf80F+hTm8kcUdPnwgl3U22e
 DzZ3qMVrn74MoDCj5JU4cSTZ8E37/u9nO25LPtqACNHn2LEWikM2w79IF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="357345248"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; d="scan'208";a="357345248"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2023 21:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="719516386"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; d="scan'208";a="719516386"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP; 23 Jul 2023 21:47:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 21:47:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 21:47:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 23 Jul 2023 21:47:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 23 Jul 2023 21:47:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSOLJ9BC6XvI//X/iJg2znfim5MditzVxHkltBOq+9llgVvl4W3e2y0aArwDAs7dh33gFrRxEvlqSOJbP10IcaQi0rFZQJkQjMqXGJ5hhKA96kMmhmb/TMY9ntJ355ZHoN7xLZlMSrU7I4WwQ0OfWvD7WGDzanZ/nExRGpBukEWXhJqmYsgTiYjhETxFukD5Q2ZaMJm8i2bfl/dQtm+ZwipuxKJyN/bJZgyWtdA2jpgLYA5izKDF81cBdLG3PwaMDqWf69xZTcGML2Ry02HsqJ6oyO+R51pPMWN+ZplfvPZVod8BeMgIbiDoVpU+7o7DUa3FfhK8CrXrBmXgFiP+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akrR55RK3Q5c9q7orS0j5QLiIPt1Xiiuxk15mXAZwWc=;
 b=PLyL3AxcRjAB/YZ7cFTgugjwddIKmF7Otiz9togiYfhL1DDt2oZHcZTMhvl6XK4ZVulOoK1WFZvXER8FKJgaUyjQMV5d8ZfcAO3LdIAP1JwdWIV52T6WadGFmaXrsgRPRaz8J3bPAOPtRAlZ2nKH0MeGEk9gFgOZkrwLQ4FgJuB3TJDT2yD8LFlPOHVxSt7Yl2kBFhaaQRt524AhdG2Zr2PEaCm8QG0FSlcE/+TBakmOG6DSNWdwOXaMithSFuXShEOgrr+Xz3F0+VWTcJk9dufPErtgb1ToU7GaKClf+aZ7eDSCSRBDaFIUd/swubh0SGo6oU7WNldS0iW1VJj3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by CH3PR11MB7389.namprd11.prod.outlook.com (2603:10b6:610:14d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 04:47:26 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5%3]) with mapi id 15.20.6609.025; Mon, 24 Jul 2023
 04:47:26 +0000
Message-ID: <282e81f9-6521-4225-7ee5-1ae84cdf31e2@intel.com>
Date: Sun, 23 Jul 2023 21:47:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 06/19] ui/gtk: set scanout-mode right before scheduling draw
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
CC: <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, Gerd Hoffmann
 <kraxel@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
 <20230717124545.177236-7-marcandre.lureau@redhat.com>
 <b0edec9a-e3a4-edad-c492-a71dc78d7253@t-online.de>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <b0edec9a-e3a4-edad-c492-a71dc78d7253@t-online.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::11) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|CH3PR11MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cbc6c7-1d54-4349-9f78-08db8c011421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt+JUB9DQYw3ERYxrmwTcDAn+jvJsY3QJQNbM3nNfh0ylrkYxuoQuOQKtJ9vI8MDuiDxCXA8iP9gh5ZUcdfR0xudrzCwbXPXa6UPTmxKMuXJnJW4Zuhs3mgFrPc0GkhqVq0BXGFj+o1aJPpmnp9Q8c3pfp28SocosGh6tfA83SZjXqQWelkHbm4rZF25TM/Ht56PvPkOeFEXaz0gF4NyKCDrbfmizyfkZrhXKvmQmyVTUPkKrWPPW7lKKQskeyIxw9JJePm1slRgKWVcaa8cl+FjU8aLYybS12MQulmDeGfE7rRfkfjUCc8DZrMo4FDmtvqArlnMRAAHzgHXYpEcCCOXYtVNgIfFlnR4BWHlcqBE1VXGe3TuKfw1RGibW3D9qGjMTVmvuE9fd9fSK7owlEe29BaUGn+bxvxxaK2z52o8lbeSh5N2WoSkiv53cu4RMYdbkXD19dsk/dajhFnATzqn0q2Urma42VQ8NZstxj7ya2THSi6u4HfDYZgp+nmiHqRZUsNoIonm3lW+Bg5GO09bZ6dsJZqnBpcGsthTaJPVTijetWpD2DmonNz7wYudob45Eq10ufZw0HGIBwNr6ux2A24D7k9dzUvdECImy7NbFT3XRe/D67jKV40EL66AbpBU12tqRx1rM5elsTB0oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(2906002)(66946007)(66556008)(66476007)(4326008)(6916009)(6486002)(478600001)(31696002)(86362001)(6512007)(54906003)(83380400001)(36756003)(186003)(82960400001)(2616005)(26005)(6506007)(53546011)(38100700002)(41300700001)(31686004)(8936002)(8676002)(5660300002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNlR0pPNDhraFltcUZvVWd5Zm5EdW1GZHl3ZkFqd1NOSmdUd1ExVEtmY3c5?=
 =?utf-8?B?S25ZRks5MzdDa1dzNXpLRmV1S0NWUFRNb2hvZldjS2xYUTRUMmdVNEZvUlR3?=
 =?utf-8?B?MjVNMHF2UzYyOUQ4Q1owdlNHOWFqV3FxR2FHU1hpQ3FiWm00K2Z6UnM3MVFr?=
 =?utf-8?B?TGRpL00rTUkzL1h2NzREbTZEN0dqcisvRkhsdmJ6NkRmOWlzRDlCRXQ3YnRW?=
 =?utf-8?B?dVBXWWozN3d3WXRtMGFjK05zVndqeFgvQnh3MDlwSUZHYnkva0l2KzBVOFlU?=
 =?utf-8?B?VmJHeGpmQUpYQXZSYjd0dkF0WC8rRk1wc0dmQW1xaXJERm1jSkFUckRjbk5E?=
 =?utf-8?B?a0VLejZUdFFyTysxL3pnaVdMVUt2dXhPb0pSbFIwOW5GR2lMZGVkMXQxZzlG?=
 =?utf-8?B?emh0TkFBRFpGcWVyeVNqRXJKa1JJeEZ6Wk54K3NJajY3aTVBdC80VXoyOTRv?=
 =?utf-8?B?OS9QUS85bmdRZEZUYjUzZ3JRTUdHb2ZYNkNqR1lxcHY4SG9HZ3JKMFlISjY1?=
 =?utf-8?B?V2VaSXZsU2ovbGRxVHNUU0RwVURDNEtGa1hVS1dQUGpkYTNzN3pOTXV0UDF4?=
 =?utf-8?B?NWtpb1YwRDhwakF2MHBBaVhKMUo1QVlVQTdsSDFhRWFyOEppTUFaOWx4bzdB?=
 =?utf-8?B?RDJGb2wzUFpEbjlzUU1WSDNoOG5RazBCckRuTWQyUy81VkpDQUY3TUt6eWs4?=
 =?utf-8?B?Vm14RVY3TXBNRWIzek5tWlo0U3B4b0w3NmVVemZEUTliT3pvbHpCVUxteGRR?=
 =?utf-8?B?aktJQWJ2U0NEbVBlb1RzTGVSQlJiV0NVUTd2VTVHWWZzakJ5WTNrMURaSm1Z?=
 =?utf-8?B?Y08vdktabXBBV2F3d0J2WkJ3aHVPYXBoQVdsR2VZcjRYM2IreFJOdEtMeXlr?=
 =?utf-8?B?a3lGdmdqVTBCUEEwK3hybnN1QXhPRDlHTFFTWkxTUGFtbGJEZW9qeHJkWnFV?=
 =?utf-8?B?bVBab0lxOFNVNUQ3SmwxaFFqRFhESzBVZmx1bUViRU1VVFA2blJ3WG9zUGdk?=
 =?utf-8?B?Ykt3TkFvd2lrZDA0bkMxQ3BPV2xNNi9DNFRFUFVFdktSamVKYVpVL0x3NzRv?=
 =?utf-8?B?NTlqd3BmQUJlc3lnMzZkcW9oNk1oZVMxa3lTSFIxWGNrZDdBWjdMVC9mQVc0?=
 =?utf-8?B?QnlPTFFZSU40d1ZnLzVWNDFrTk56ZzhJcitkREpwWVB3dzkwcnpYL3NucEZl?=
 =?utf-8?B?Q1RrdzUyVmhTVmcvQjY1K3B6a1dWTis2OTBBbmcxQ09sNzNOVC9scCt0QWY2?=
 =?utf-8?B?c3VwS1V5bDZqTEI4d2lGMHF6NTBEUklmRFQrUXIwdSs0M0Z3OW5jb1I5WnNY?=
 =?utf-8?B?Z2JaU1hwYzg0dEtXaWJLb1JvRDljZW04bU5OT09VeE01QkhlN0ROMUJMTlFq?=
 =?utf-8?B?VERPVnZDemU1cmRhS2xjL2hNd0d1YzVsTHR6S3krWWpOQUcycnh6QWdsTWxh?=
 =?utf-8?B?NFY5LytnTXdnbjc3cDRPMVNKbkpWemdwcWRtbnlyNFlTMDlsWldBdlhTdzAy?=
 =?utf-8?B?dkp0Zm55Q1hDemFRRUpRdVJRZGZNQTJHZzhyMjZRZ1JGL29iV3lXOW9KU1hl?=
 =?utf-8?B?S0RFYStJMHRwRGtYL2xwOWJ5dm0vckR6aThXNzBTSzVKVEpYaHdEYWNzc294?=
 =?utf-8?B?blNzV25xNDdJb2toOWV5UzQ0T1QzeWVGcmhBQjltQUJLaDhiVnVneXlwVjBV?=
 =?utf-8?B?dEZiT08rNjA5eG9TNFB4U2Jzbk9oKzRqTDRPeWFwOStaekd0dWI5UmhUbjN0?=
 =?utf-8?B?T0VGWjJOODRFRUlweEcrUUJjS25acytBRGl0RmMvY0xBc09wcUpnazRucExr?=
 =?utf-8?B?M2RJV3d2S1UvTVpvanBieXNFbmVobVdVbW4xRi9iaWRtMENZTmR3bEV0TCts?=
 =?utf-8?B?NENsWmFvaTArVk9CRVd4VzJwZnVIQXBndmM2YnBQQmpQTTI0bStqZmEvK0Jm?=
 =?utf-8?B?Y0lKYTg0ek4zSEdiLysvM2ovakJsU0NVZzZBZGRyOTN4dENyZVEyQUl3RXpr?=
 =?utf-8?B?a1lyOTNzVDFaN2xpaHcyektic1NvUUdjU0xyVFpkYUJPOE1FVHdPd3l2cHNL?=
 =?utf-8?B?WnFRVDNmaVo0Z2pIWXo4ZXNpK1hBczdMbGhreWVHYlltNkxWaTNSSXRWWS8x?=
 =?utf-8?Q?rBbmU5ghHYUZNPjqe98zToAZH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cbc6c7-1d54-4349-9f78-08db8c011421
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 04:47:26.4922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUd3lpnIDaXuIKPnAv4j1w8QINbrJa464ygztAzvfwUDvOVLwd9lwx4QotqRPTtcXQO6mhKDQ428fBxn0ByuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7389
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=dongwon.kim@intel.com; helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi there,

I guess removing this line would have been causing the problem. Can you 
add this line back and test it?

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index eee821d73a..98b3a116bf 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -242,7 +242,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
       eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                      vc->gfx.esurface, vc->gfx.ectx);
   -    gtk_egl_set_scanout_mode(vc, true);
       egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, 
backing_height,
                            backing_id, false);
   }

Thanks!

On 7/20/2023 11:53 PM, Volker Rümelin wrote:
> Am 17.07.23 um 14:45 schrieb marcandre.lureau@redhat.com:
>> From: Dongwon Kim<dongwon.kim@intel.com>
>>
>> Setting scanout mode is better to be done very last minute
>> right because the mode can be reset anytime after it is set in
>> dpy_gl_scanout_texture by any asynchronouse dpy_refresh call,
>> which eventually cancels drawing of the guest scanout texture.
>
> Hi Dongwon,
>
> this patch breaks the QEMU guest display on my system. QEMU was 
> started with ./qemu-system-x86_64 -machine q35 -device 
> virtio-vga-gl,xres=1280,yres=768 -display gtk,zoom-to-fit=off,gl=on. I 
> can see the OVMF boot screen and then GRUB. After Linux was started, 
> plymouth normally shows the OVMF boot logo and a rotating spinner. 
> With your patch the guest screen stays black and I see a text cursor 
> in the upper left corner. It seems the guest works without issues. I 
> can use ssh to log in and I can't find any obvious errors in the guest 
> log files. I tested on a host GNOME desktop under X11 and again under 
> Wayland. In both cases the result is a black guest screen.
>
> With best regards,
> Volker
>
>> Cc: Gerd Hoffmann<kraxel@redhat.com>
>> Cc: Marc-André Lureau<marcandre.lureau@redhat.com>
>> Cc: Vivek Kasireddy<vivek.kasireddy@intel.com>
>> Signed-off-by: Dongwon Kim<dongwon.kim@intel.com>
>> Acked-by: Marc-André Lureau<marcandre.lureau@redhat.com>
>> Message-ID:<20230706183355.29361-1-dongwon.kim@intel.com>
>> ---
>>   ui/gtk-egl.c     | 2 +-
>>   ui/gtk-gl-area.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>> index eee821d73a..98b3a116bf 100644
>> --- a/ui/gtk-egl.c
>> +++ b/ui/gtk-egl.c
>> @@ -242,7 +242,6 @@ void gd_egl_scanout_texture(DisplayChangeListener 
>> *dcl,
>>       eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>>                      vc->gfx.esurface, vc->gfx.ectx);
>>   -    gtk_egl_set_scanout_mode(vc, true);
>>       egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, 
>> backing_height,
>>                            backing_id, false);
>>   }
>> @@ -353,6 +352,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>>       if (vc->gfx.guest_fb.dmabuf && 
>> !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>>           graphic_hw_gl_block(vc->gfx.dcl.con, true);
>>           vc->gfx.guest_fb.dmabuf->draw_submitted = true;
>> +        gtk_egl_set_scanout_mode(vc, true);
>>           gtk_widget_queue_draw_area(area, x, y, w, h);
>>           return;
>>       }
>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>> index 4513d3d059..28d9e49888 100644
>> --- a/ui/gtk-gl-area.c
>> +++ b/ui/gtk-gl-area.c
>> @@ -264,7 +264,6 @@ void 
>> gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
>>           return;
>>       }
>>   -    gtk_gl_area_set_scanout_mode(vc, true);
>>       egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, 
>> backing_height,
>>                            backing_id, false);
>>   }
>> @@ -284,6 +283,7 @@ void 
>> gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>>       if (vc->gfx.guest_fb.dmabuf && 
>> !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>>           graphic_hw_gl_block(vc->gfx.dcl.con, true);
>>           vc->gfx.guest_fb.dmabuf->draw_submitted = true;
>> +        gtk_gl_area_set_scanout_mode(vc, true);
>>       }
>> gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
>>   }
>

