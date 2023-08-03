Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB376F1C9
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 20:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRcyn-0004lc-B3; Thu, 03 Aug 2023 14:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qRcyi-0004kJ-LF
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 14:23:19 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qRcyg-0004ZK-Ie
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 14:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691086994; x=1722622994;
 h=message-id:date:subject:to:references:reply-to:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nwIz18Fb6aYx9ywnCJvIyjS+t4GeLpQtWoUD5t3Gj4s=;
 b=OiiDVURjJsA+yMAS++jMwC8mtICWRP9tKQExsT1oE+ww1wkl3202gAOk
 Pg2npuB6443W6hE3dNf3MesjoB0+ObT33uT44Uex92zCg/JvaZB4csz2q
 C52v1bkn7TKEjLstXDXv57b/WzzzU/FccslUlMs99odT52P+tJcA0Ib/F
 3G+4+tJvwSCF7oQxZzA+JhGp+HLXjSvZGuuC3kg+gW6trIgnd8isLyw/l
 9LT+LvZ7av2ITuH1BV9S05mJARcoBnDEtwxbXV5eUImjqYXOu5W5Fq53g
 lRAlHjYf1BrfFRjU+TIGcx8Jg9Lu+2HQ00SSREqxS87Pf17SovnLPh1/l g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349554172"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; d="scan'208";a="349554172"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2023 11:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="873052897"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2023 11:23:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 11:23:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 11:23:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 11:23:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 11:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cstyRDk0VW/DayjL29WQqryUSOXg7DOaXxr4SmrRAfuE9wHfGlWIXfCxhVWD35jJPUDycQXNuTvpIHBvK0SsqDpGjj6jDiiATOKWlfsfjlN4bNX2tn/15WW15xR4S1rsa9dHZxEkQ40vjnPbWJns86YBKVq4+7xZwqbqDjf+KkC9LmDOu0ReXtfVU5azsoL9cI0kkQR/5EurGWgXRKffk0jchFIECPfD05zzhs3hRKLWXhwt2BHbkjsvLb9EWRKqJmf25GE7YpGOIFPm3Mi6/XU3uH/DmzVvYIP2AyOeJe9YeiljUpPrSyS8gA7OD8SW5PUYLz9yOEfkCihNlpkDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/R152g/jEt7eWf4lxUyO6Es7U+tSGAKYdNBE+K/s/8=;
 b=a+ziQPLJXfHxGx+clJvLJzHhkvUv6fIs1vJc7u7d5zIADxGvEZzQZgBDws/VauEvqmhQ9hdSd7BDdug79z4/YJd5BStE4Kel+YUM4ts6mWdsFmBDegujhISmKLayCGbJHFIk3REQrb5UzQJLqvPNUyqvEK71uW1C2h/Bh394wAj9/RFtYCoZBr089Xnt2hqmQ7YJ019NrYslmifjU/bqB64xiVs+kVbffpJgxJ7EYKhmzy+nRms5puSuJFCuQE2nDq8IzFJBe+BVxvR+SVTLKvIP8Qc26ESYl62SIzNDAv90c0u3rcb4tDGKoJ0MnNlYTAK9rRVIUOsS6ZEbs0EN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 18:23:08 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::e12e:7690:e251:1aa5%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 18:23:08 +0000
Message-ID: <75578ecf-4aed-7201-ca83-83e2dd523403@intel.com>
Date: Thu, 3 Aug 2023 11:23:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] virtio-gpu: reset gfx resources in main thread
Content-Language: en-US
To: <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <mailman.213.1690396551.25301.qemu-devel@nongnu.org>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <mailman.213.1690396551.25301.qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f6fda1-a6c9-47f4-2187-08db944eaf9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFKrTuQTVg7P5W94bkLIxvCpTzqM912gHlK+NyC93KRlqwkFhRtVJpV2U9YhzeqJg0SiHjWMtawIxaleDkVGsYVTLJrUTsFEBymYk/7bojPy1fnn3nUgNYnjzMXpJWOzKHLmPTZL4PxtfHewbY0XIw13yO9E30Zf/XBZFd+ZLk3pmDFC6wWaySBQ4yO7wZqxy8mhg3YjiZ9+UISSj6TH44GskCufjWUnyO+i+zeHz9S7HobQdJoxujC61icKKAd1Ma9Ed2WRCXurFia1GChtDLMlo83uU+EwLgAc8YNJDeEBaPY7cW0c2W+jB9FVQ9nCvU/GBcJePlrO1s/vOTV4o4M8wtsgKTduGk0x4KNcqudUuTfmXIni7IJdDQuFxctS4ukHe+oOrARvLZeYeaFO9zO+3mtwiGkDo03gHwTuUymBa/NDVVtup8NgzzDUsZrLN70U+X2BeiKjvB+ybeWLlGtzQqHdYgcUPYJcHILfUSAWQizsH43OMZ7n77jDsubyo3t9xPIMWt/qoQ6foN/7YxVLl1wtp+QqWdWG/2zmlQop4D35MR8QrEZ+5Kk++iI0pa/DtjowDyXIqgqQjb1h0rKP1TTJ3A/LklkTtHWOtezdRwrqKIgtAFOQaj3pIv45F9YvrMubzsTe/dHkmfbnSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(2616005)(6506007)(186003)(83380400001)(26005)(8676002)(66476007)(316002)(66556008)(2906002)(66946007)(5660300002)(6916009)(8936002)(41300700001)(6486002)(6512007)(478600001)(82960400001)(38100700002)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBWSmlDeXhFaVF0SkhQK3Z1WXFSaHVjZk94MDB3a0tVVzVFZkFabU5TeDkz?=
 =?utf-8?B?RVBhbDkzYUlOZ01KSGZNNktOMWRTd0dUZlBGOXhVSy9nVk9GRVlWK3NtQlRp?=
 =?utf-8?B?OUEvbDkrU3VnNWFTYVBzdXY3M054b01PbW1rSEZNNWR1VWl2ZTFGQUR3WXlX?=
 =?utf-8?B?dGxhVEhOK3Z6UTZlbHpodkxBV2lyT3VjbUZDa1dRRENydEhLOERoejdxM0Zy?=
 =?utf-8?B?a3dHMElnQklDZXlKUXAreUdDZ0FLQ0VscTM1RTNlZ1gyM1dnWldpME81dDEy?=
 =?utf-8?B?bG15UXkyYjRDL0pTWkdqcFBSVWplSDRVUlgrZmlyZUJZUjFid1pqRVhYb0Mv?=
 =?utf-8?B?eXQ1TjNpQTR6L1hDMFd6cENRaER4RnRDdHd2MGRMMUFYUE16Z3ppTUFqQnRC?=
 =?utf-8?B?bE9iZnpQWGNac25zQW1zVU5pTHprWE1TUzVHTXRHcmZ3MFoyOFlGYXpLbDE4?=
 =?utf-8?B?MndYdjRLMTkyelI5c1lIZk4xRmh2MHQ3TXlaL055bU5DZXppeGxhbWpIWXU4?=
 =?utf-8?B?R0hhbk10cEgzMkY4RmhkdlBwRTM4YW9PSmt3WDhQUFdnZ2dmQUlNVEJRQ3JQ?=
 =?utf-8?B?MHQ2a2ViSUZseGlHQ1R2NWFrMjdMWitxSVYwS0h3THJDSnE2RVZ5UkR1MXA0?=
 =?utf-8?B?dEp4VkxueC9tNDg4SG9vK3VHa05iTFI0Y05ONjB4OVBUQk41dCtvVkdONkIy?=
 =?utf-8?B?WFhZTEFDVjJIVWlKR3dtdmhZdHZPY2xrN2RaOHc5VW1BOHBqTWUrT1ROZEdu?=
 =?utf-8?B?bFNuUTNYWWZaUjltRlNPUHJYdDh3T1E2VGRkdjFNNDJmRHpyTEtGVDlSMlBO?=
 =?utf-8?B?Vm1wczA0Z1ZkUVlLNjR2YjNRb3R0MEs5NXZBQUJoS3UrbFdkVEY1TWFOREty?=
 =?utf-8?B?eHg3YVVvNHRaWXN0WHhlVUJPVmZ6Rmx4aFQ5blRIYTBpUFVJVzZ6V3o2NDRN?=
 =?utf-8?B?OGZRN3BReTZCZGY0NUxsOXRoT2pPanBwZlRHNkFncWVQR0hod2FHUTRPVk9K?=
 =?utf-8?B?cWtjSkxzSmFqTGhycEc4VEFqeXVtQXpCTVFlMjhxU1o1Vm5zUGhHdDZIemE3?=
 =?utf-8?B?b01lWmpwNzBGd0kvbHZkWlN5cnBpWmpzWEFhcUJYRU5haW1SbEx2eFJrZVpo?=
 =?utf-8?B?MnpWOGZqQzlSeXdTejk0UytCYXlYY1h4dWdEaWpGNXZjbXVUOXZoL0pRNDFE?=
 =?utf-8?B?MmxXcFd6bG56T2RlclNyYlNxMFJBYTczaEwxQk0wZnlXQmg0bkI3a1hqb0Iv?=
 =?utf-8?B?bjBIZ3pHdC91SEpoR0pJWmw2OWVNc2puNFRzNmlNcUtwQ0RZV1ZaWElHZ3E1?=
 =?utf-8?B?U2J0Qm1HeHdxM3Q1cFFYajlieCtNRHVYMWljbVQ3RFRYb3Z6ZldwOVJJNjBT?=
 =?utf-8?B?aUh4YnhwRCsrbXozTVk4ZTYweGpMaUVSbjhBeCs2MEhYU0RvKzdURE1McVlo?=
 =?utf-8?B?NWVmNWYvZk5ZRnBUSUVnNmlGL2c0UGNBOWJ2V3ZlNGpOY1E2MDdUclVHenQv?=
 =?utf-8?B?R3ordmR0RTZPYVpwais1a2JzZmdXMzk1ZUhhWVprR0pDTVhCREsrTUsxT016?=
 =?utf-8?B?WmJRbFJjaHRqK1NMQ0M5b0hVY1JQV0d0OUp3M255R1d3RDBiMm1Da1dqaFlD?=
 =?utf-8?B?K3hZVkh2VGtLSnNtRlZDTlVEQmx4RlRNbU5mMXhwVUNkc2E3THEwYkFONGli?=
 =?utf-8?B?bzNJUWF4QXlCTEhPVzBTVlFlN3MrNVpWY3B0VEp0L1R6d1BhN05RV2lSb2xr?=
 =?utf-8?B?TXBxR1p2dmtNUkpoOVB1SDR3eFJRdENSVHhNR2wySkR3azRUWGtESnZnU1hL?=
 =?utf-8?B?eHR6SWtacksrMlpwamwvaEoveXNwNUthVUR4VXdpallWTW55YU5aTGNNSmhX?=
 =?utf-8?B?Smt4cUMxSUhuMGdPNUozMVNjckI5RU9JZEx2NmJLTyt2c3ZTdFVCUkpVamFQ?=
 =?utf-8?B?UDVXTnY0T0s1bHh0Z1pGVXJJY1g1Y3JnRnJnOE1WYVMvUmNjZDA3Mk4yc0Y2?=
 =?utf-8?B?ekhoeFZEaXhlSktsbHJlUVFXR1dUbWFPNldhaFlsbWFLS2szYlZ6UVhSS0R4?=
 =?utf-8?B?Yk93T1BLeFZmUHB4SUE2WjN6eHViUEFsQ01oYnFOL3l2UkRZVnA4K2lDNnl1?=
 =?utf-8?B?amlNTk8vSFgvWXJFNXVHS1N5QU5CK0ZIbG53dGVoWlhGQUdUTjZxM0Vkb0Yv?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f6fda1-a6c9-47f4-2187-08db944eaf9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 18:23:07.9244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9udsqj4VkxA5klhj3a9Ri/cu4YRnCZmS+aOPEIyN7SH2shp9fZYVIpYf4OnUbMhrKE/QzYdNPUyK1LXqJKmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=dongwon.kim@intel.com;
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
Reply-To: 20230726173929.690601-3-marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Looking good. By the way, what does 'BH' stand for?

Acked-by: Dongwon Kim <dongwon.kim@intel.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Calling OpenGL from different threads can have bad consequences if not
carefully reviewed. It's not generally supported. In my case, I was
debugging a crash in glDeleteTextures from OPENGL32.DLL, where I asked
qemu for gl=es, and thus ANGLE implementation was expected. libepoxy did
resolution of the global pointer for glGenTexture to the GLES version
from the main thread. But it resolved glDeleteTextures to the GL
version, because it was done from a different thread without correct
context. Oops.

Let's stick to the main thread for GL calls by using a BH.

Note: I didn't use atomics for reset_finished check, assuming the BQL
will provide enough of sync, but I might be wrong.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
  include/hw/virtio/virtio-gpu.h |  3 +++
  hw/display/virtio-gpu.c        | 38 +++++++++++++++++++++++++++-------
  2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 05bee09e1a..390c4642b8 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -169,6 +169,9 @@ struct VirtIOGPU {
  
      QEMUBH *ctrl_bh;
      QEMUBH *cursor_bh;
+    QEMUBH *reset_bh;
+    QemuCond reset_cond;
+    bool reset_finished;
  
      QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
      QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b1f5d392bb..bbd5c6561a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -14,6 +14,7 @@
  #include "qemu/osdep.h"
  #include "qemu/units.h"
  #include "qemu/iov.h"
+#include "sysemu/cpus.h"
  #include "ui/console.h"
  #include "trace.h"
  #include "sysemu/dma.h"
@@ -41,6 +42,7 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
  
  static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                         struct virtio_gpu_simple_resource *res);
+static void virtio_gpu_reset_bh(void *opaque);
  
  void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                     struct virtio_gpu_scanout *s,
@@ -1387,6 +1389,8 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
                                       &qdev->mem_reentrancy_guard);
      g->cursor_bh = qemu_bh_new_guarded(virtio_gpu_cursor_bh, g,
                                         &qdev->mem_reentrancy_guard);
+    g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
+    qemu_cond_init(&g->reset_cond);
      QTAILQ_INIT(&g->reslist);
      QTAILQ_INIT(&g->cmdq);
      QTAILQ_INIT(&g->fenceq);
@@ -1398,20 +1402,44 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
  
      g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
      g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
+    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
+    qemu_cond_destroy(&g->reset_cond);
      virtio_gpu_base_device_unrealize(qdev);
  }
  
-void virtio_gpu_reset(VirtIODevice *vdev)
+static void virtio_gpu_reset_bh(void *opaque)
  {
-    VirtIOGPU *g = VIRTIO_GPU(vdev);
+    VirtIOGPU *g = VIRTIO_GPU(opaque);
      struct virtio_gpu_simple_resource *res, *tmp;
-    struct virtio_gpu_ctrl_command *cmd;
      int i = 0;
  
      QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
          virtio_gpu_resource_destroy(g, res);
      }
  
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
+    }
+
+    g->reset_finished = true;
+    qemu_cond_signal(&g->reset_cond);
+}
+
+void virtio_gpu_reset(VirtIODevice *vdev)
+{
+    VirtIOGPU *g = VIRTIO_GPU(vdev);
+    struct virtio_gpu_ctrl_command *cmd;
+
+    if (qemu_in_vcpu_thread()) {
+        g->reset_finished = false;
+        qemu_bh_schedule(g->reset_bh);
+        while (!g->reset_finished) {
+            qemu_cond_wait_iothread(&g->reset_cond);
+        }
+    } else {
+        virtio_gpu_reset_bh(g);
+    }
+
      while (!QTAILQ_EMPTY(&g->cmdq)) {
          cmd = QTAILQ_FIRST(&g->cmdq);
          QTAILQ_REMOVE(&g->cmdq, cmd, next);
@@ -1425,10 +1453,6 @@ void virtio_gpu_reset(VirtIODevice *vdev)
          g_free(cmd);
      }
  
-    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
-    }
-
      virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
  }
  
-- 
2.41.0



