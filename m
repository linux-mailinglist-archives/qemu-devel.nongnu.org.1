Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C72723913
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 09:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6RA2-0008Ox-Br; Tue, 06 Jun 2023 03:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6R9x-0008Ok-Eb
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:31:17 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6R9u-0002Bl-TN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686036674; x=1717572674;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nbyMZJ7t2OAhsSfE6fPIcdapEbBA3RIAGgviZZk2j+s=;
 b=MAWYJhsRFcAjG7FRoN9pfx65O7jhonj4U7/YiD0IpIb0AFNQDXtY+tBH
 myUnbOyFoHLu4oE//xLHcIFpRTTDWbiawAowYafOEOjELQsesTqDAnAX5
 BI5yznmFy6060GTFqdIbt8O4AlKjFSOkQDeaZrURbdtYlE6zmNP7A9VQ0
 jrtZ96qTuvUljAesgnVfFZ+PY1qleNB8GKWuosvAVGfcyE+maO5LSKhr8
 cSMn73uNQt461Q+INQsk+OdJI3CHOopesurrWxqQdWOnDGlEb4GuTC+zK
 u77Qfjr5YGVZt7uZ9RqukOEzJNu8pN737WwNBsk7nU3oFdBBTWt0dG/Ep g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336216761"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; d="scan'208";a="336216761"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 00:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="703057183"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; d="scan'208";a="703057183"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 00:30:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 00:30:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 00:30:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 00:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSLRPLHPobiEkibm7FEQ4aXfDIT3tLkonG9RQDsmtBsdjAWQo9Tpz3chvBf53VP7kuzIcHCI1DEMEJMBVoFd3MBZANXlKZ/XAmtyLBlAp/UVvMHuh0ThAxQKpjXObLqV5iXmXwILKIAbyShDLepVo6BlLfyqQBcMnDBJmMlSvfON4KELU9RJDmMDq2l/Cm9TF2puTR7HkuFvQRXa5SKtdKwtus36Gt5txx1nINxKNZ+vmJy/MvyC2AdKQ5Q2/FD9W25NM6WVOucb08DW+Wv4ms3YSS1onLUJX1W8HMsB87GxYNY8ugNQ6y5iQ4J8L70chaavJg03qMvTPR8183x4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzAiG6fmMAtiuA85mlaTsYF+MPE7C6Ov8GvjVmOOrQ4=;
 b=BtHsh1pBKUV6/ImxV6q8ZyOE7VqqJvnhoINSFlvn1GvVrTa6sMm/Ba1kE0ZVMDmylX3ONmO5igQE/EwRgrkl66uy88/HpIK+KT/jDCDgdmkYQEz5vD667E2vSHlXdJZkcuX6r0JF1ffPMv8PbfRRyC9ef9fWEla4uQ8LD16w8TLRP0Hl+ANB7ypZ2Ou38M/P8lNS9FattJWtzNlfI/4bZ5dflFM0DTrj7qGUWLG/PJu+MG8s7o6JjtfXpRSS86zv+YS3D1hKsH2u7rxy90ljqcEze1BfQXMzmhO1O+o/zTfwR/QG6/cdQRmX4MzS5DFWhkojbaQKTl4MkSMMdXgngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MN2PR11MB4582.namprd11.prod.outlook.com (2603:10b6:208:265::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:30:52 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:30:52 +0000
Message-ID: <8fdc80b8-8529-4772-f426-639c50e24b4a@intel.com>
Date: Tue, 6 Jun 2023 15:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
From: "Wu, Fei" <fei2.wu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <4b393fd4-76ef-4313-212f-2e641260591f@intel.com>
Content-Language: en-US
In-Reply-To: <4b393fd4-76ef-4313-212f-2e641260591f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MN2PR11MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a20754-41d8-4b4e-dd74-08db665ff4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eD3WWcRpEtpoa+bcxzr6OJxtYrUkYFamKl1uVM+8RDOeXW6dJI30pgeoSGUPDE42OFNAY6Rshmgiap29rr5ZKQjbzoqXYbEUPicX51ciKFILjbYN6a5gygdTRqa3Kox3ZjuD8gzeOJyiB/9HVP8X9dHpB51DXMV8aCkHNJEzIhyWHTFLypEqIHIA3WPodI8UkNawKaM4jpk51kg0LJAbD5C8hpTGKEjUvRQha85B2BuOIR1mc7kgKiWc7/KKPPEZXWJy+y43kNR+dcnJJ2itv5+qEar9GLdgv46FQT7OJY2LZjGgTu6iy9Cvmggfuc6wdwZIdVnp2s/l/3JJhce6b7BYa+BnvruzB/Fwe2ar/VdAEiS7C67sgE2BJhKOvR9e2J3a1BIuvOHhMCz83u7PV+A7I1C73pNpL5W6b9f1AUj7oeUh3U2Up34qzG9iJVR0wvpSIAeQ+wVBq6nJFAJjUPjtvkH49iey45iAjNxbs7Ni4rkkc+kLC0A0FguEZieQ25A5YGkxq5Th+Zb7zeg7Ae1cy4j58dP3WCQFDQ2bRDC/ULOgPTeuc+WWd4SvGqDtayiGx32dppDwCXauOo+b4OsmuRZRNjpcN3oIZrbs/H5DyuAWd5oj6FtSmZMEclF7Urqg2r+H3ZDZaSTANrTmIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(6512007)(26005)(53546011)(2616005)(6506007)(316002)(83380400001)(31686004)(4326008)(66556008)(66946007)(66476007)(6486002)(6666004)(186003)(478600001)(31696002)(54906003)(36756003)(2906002)(5660300002)(8936002)(8676002)(82960400001)(86362001)(45080400002)(41300700001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzF5dWdTeG54S1QxTWJyQmV5UHRkRHhEV2hnRWx2R245akt3QktyL1lrVGha?=
 =?utf-8?B?eGJjYisrRGRTSFZ0cVJzdEI2dFlEZTRUWE03WW11YnQ0Q0VoY0lLWlVSZlNp?=
 =?utf-8?B?ckFMUkNSQTBsS255M0VMQnRQdDIyU0t0L2Zyb3Rjc1VjSlpVcUlFQ0FBcEp0?=
 =?utf-8?B?dHJLWmxPbjkvY2FWYjBiRHYvVHVBWDJTMnp1UEZKdVp1R1Q4blFsMEFpaHc0?=
 =?utf-8?B?S29uZTB3a0trcG5lSldad1RkNVBzeEVNWkZPOXpSVUNwVEltNEJyVWIrNkVh?=
 =?utf-8?B?VEdaWGJYc0djeW1lZFZyeGhxYW43K2gwZFJsQkdtZDRhNDM4ZXd1cmFaNGtG?=
 =?utf-8?B?UGRNYjdKTlpSaWRWcTdDWkpaSlBidHFHOVhabWF6M3pZMjMySjk0cFRVUVg0?=
 =?utf-8?B?K3RjK3dYcjdtSUU3OFZyRDhsSW56QUxmS0tuUTJxRlZBcWdqUURhYkI2b1Bm?=
 =?utf-8?B?aEwxQk5QWnk5TnNzZkVUMCtVL0xMU21aemk4YTR3d05veCtPY2NuN0FyeEFt?=
 =?utf-8?B?UENCazdXemVTbFNGN3l4NlFnZTZPSU1HNktUc09ST2JaK1J6RHNNV1dweFlm?=
 =?utf-8?B?T01vWHBua0l0MkUvanNFc3Y4QlAxUjJmdjV4OEc3OGRDYXN5WjBCa3BmcDd3?=
 =?utf-8?B?V2pmTm5HMEVKcWFkZzdLdUg0OFNGbWUzaGxWbGxhSWNxWU1WVlBkdFdOdktZ?=
 =?utf-8?B?VjJKNWNVWHgwd0l2cm52V05mUlFMMSt6Sjc4OHZoNXlGeGFacGJrTzdPamJW?=
 =?utf-8?B?QmluL1JGS1UvVURmbFZyUWZTL3JvT3pMNFFseUdiMnVmTVk2eWJoczJkdFV4?=
 =?utf-8?B?RWl5OTgzSEV3UE1jRVhKVFdyVmdlRUR0Mnozdi9rbHFFWGtwbUFzWVZ5c2tO?=
 =?utf-8?B?OTBoUWhpajdtS2VlWnh4RkpSRFo0M2VhenNlVm40OWhzS1UxRXo5eHBOR1VO?=
 =?utf-8?B?dXh6b3hwWTBCU3d5Ti9TYmZlUzJ4a0QxTXZ5VzZpaGpBdDlTcTNrS0tBRnpu?=
 =?utf-8?B?L3F3WXp4amh0UWJYWW1oN1RQSWlXNkFzTFJRVUROU1p5SzFYQ0NkVzQ3NHNp?=
 =?utf-8?B?SHl1K2xtRGpvQ0Y0Qkx5MldYUVV5enpqZEV0eFpZUDZWUlFrYVByVEdQMlZz?=
 =?utf-8?B?NzlFd0Jmc29xRnBhZ0c4TXlkRzdIKzZhRE9XbHJpU2F3OG5iMHN1bTI0QjdO?=
 =?utf-8?B?SmhzK2NnZDBsRjl5bVY4QzVFRWFQdDdSZjBqbVo1bWtQbnEzSVFSUVpkekRR?=
 =?utf-8?B?MXI1dFNkeklVUE95Yy8wNlZvMW5ydzJJb1RPVWlTV3JEdWxqajRmd0ZwazFF?=
 =?utf-8?B?ZnJid0hQKzh6S0I1WnNGZ3JXQzBaTlk0MHhpb3dJR1Zpdmk5QWNxRnJoVm1J?=
 =?utf-8?B?ZlIvYjArOU5xa0FzT0ViTGI3TlFjUGdFVHZEajJldnpHcFdCN2xqRDJodFhp?=
 =?utf-8?B?dDcyUGYzc2dnOTJ4dUlJNHNVZ2JuVHQ2L25MVU1NUHkra2hMbFNrcHNDUTgv?=
 =?utf-8?B?ZnpzcDdKenoyQmhMM1ZUQ3hYem5hQXFrNXF3b0pId2ZJUGRpQ1RmYUlKamhp?=
 =?utf-8?B?cUtpZ0pyV2t2eG5uT2N5elBUTWZ2L21JWmV5QmlVdjlnNHZrRDNxRk5SN2x1?=
 =?utf-8?B?eFZRNElla3QzWGJOcGpKeWIwSnVENFBUMTRZTWFDWDI4QWpYeVo2V0RYUnhY?=
 =?utf-8?B?VXFpaGRRMUNFUzZIdk9ldld3aGs0djA0OVNXV29oQ0JZZHFxUnVWLzBNdDJD?=
 =?utf-8?B?c3lvaFNHektkNXBWR0ZoMHZhRDZjTjdSa3VUUjh6RS85NlpIdnFKYm81M2hF?=
 =?utf-8?B?alJ4Sm5Sc3JxRlR3NkhrdURJaWJ5WStzUWg5N1NsTHRFSFpKa2hvS3l2Zzl0?=
 =?utf-8?B?WG9LWmxiTVZsT3k1clFucjNnaFJnbnQxcUhVVHFhY1RMMUk0MEIyam41TmM4?=
 =?utf-8?B?eWMzdHQ4RzhRd05DTDJoajdodWpOQXdaWUpyRHJCbG9ZelF0NVdtOFYyUC9Z?=
 =?utf-8?B?TUJhZ09Hd0RuNEtRbXVrZjZKaVIzMnArVjdhV2xWenpoTkhQMDY5M1hTN1ps?=
 =?utf-8?B?azZCd1FCa09Qa0h5dnl6RjlpYVZ0SzJIbEFCdlJNWUJHYmxqYkpIWFc0czhX?=
 =?utf-8?Q?1dTc5VWlNVttCdaM/Glp6UUY1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a20754-41d8-4b4e-dd74-08db665ff4ef
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:30:52.3451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPkaUgO7gJUsvPjEyODY7ieBbcBLgfJha/U2PxQa3hcAyJkflB+B8StezN+zpyHjYefsg0nnnWpj+Sek46Ua+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4582
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=fei2.wu@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 6/1/2023 8:12 PM, Wu, Fei wrote:
> On 6/1/2023 10:40 AM, Richard Henderson wrote:
>> On 5/30/23 01:35, Fei Wu wrote:
>>> +static void do_dump_tbs_info(int total, int sort_by)
>>> +{
>>> +    id = 1;
>>> +    GList *i;
>>> +    int count = total;
>>> +
>>> +    g_list_free(last_search);
>>> +    last_search = NULL;
>>> +
>>> +    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
>>> +
>>> +    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs,
>>> +                                        &sort_by);
>>> +
>>
>> Why are you sorting on a list and not an array?
>> Intuitively, sorting a list of 1 million elements seems like the wrong
>> choice.
>>
>> Why did you put all the comparisons in one inverse_sort_tbs function,
>> and require examining sort_by?  Better would be N sorting functions
>> where sort_by is evaluated once before starting the sort.
>>
>>
>>> +++ b/disas/disas.c
>>> @@ -8,6 +8,8 @@
>>>  #include "hw/core/cpu.h"
>>>  #include "exec/memory.h"
>>>  
>>> +#include "qemu/log-for-trace.h"
>>> +
>>>  /* Filled in by elfload.c.  Simplistic, but will do for now. */
>>>  struct syminfo *syminfos = NULL;
>>>  
>>> @@ -199,6 +201,24 @@ static void initialize_debug_host(CPUDebug *s)
>>>  #endif
>>>  }
>>>  
>>> +static int
>>> +__attribute__((format(printf, 2, 3)))
>>> +fprintf_log(FILE *a, const char *b, ...)
>>> +{
>>> +    va_list ap;
>>> +    va_start(ap, b);
>>> +
>>> +    if (!to_string) {
>>> +        vfprintf(a, b, ap);
>>> +    } else {
>>> +        qemu_vlog(b, ap);
>>> +    }
>>> +
>>> +    va_end(ap);
>>> +
>>> +    return 1;
>>> +}
>>> +
>>
>> Not need on this either.  Global variable being checked on each
>> callback, instead of selecting the proper callback earlier -- preferably
>> without the global variable.
>>
>> Did you really need something different than monitor_disas?  You almost
>> certainly want to read physical memory and not virtual anyway.
>>
'info tb' has extra flag to specify dump out_asm, in_asm & op, so there
looks more user cases than monitor_disas, I think it's nice to have, but
not strongly required, usually we have a general idea if we get the IN
ops, plus the other counters such as g/op/... in the output.

Right now I am inclined to switch to monitor_disas, I found it causes
guest kernel panic with the selective virt addr, it happens to the
original v10 too.

------------------------------

TB id:1998 | phys:0x9c5f5ce2 virt:0x00ffffff8ff8ece2 flags:0x00024018 0
inv/1
        | exec:68/0 guest inst cov:0.00%
        | trans:1 ints: g:1 op:17 op_opt:16 spills:0
        | h/g (host bytes / guest insts): 129.000000
        | time to gen at 2.4GHz => code:1960.42(ns) IR:915.83(ns)


could not gen code for this TB (no longer mapped?)
------------------------------
[   98.213363] Unable to handle kernel paging request at virtual address
00ffffff8ff8ece2
[   98.219153] Oops [#1]
[   98.219299] Modules linked in: binfmt_misc nls_ascii nls_cp437 vfat
fat cfg80211 rfkill drm fuse drm_panel_orientation_quirks configfs
i2c_core ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache
jbd2 virtio_net net_failover virtio_blk failover virtio_mmio virtio
virtio_ring
[   98.220832] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.2.0+ #1
[   98.221122] Hardware name: riscv-virtio,qemu (DT)
[   98.221330] epc : arch_cpu_idle+0x1e/0x28
[   98.221985]  ra : default_idle_call+0x3c/0xb8
[   98.222150] epc : ffffffff80004398 ra : ffffffff808a0bc2 sp :
ff2000000068bf40
[   98.222339]  gp : ffffffff815688e8 tp : ff6000007ffcc240 t0 :
ff2000000064bad8
[   98.222562]  t1 : 0000000000000001 t2 : ffffffff80e02ed0 s0 :
ff2000000068bf50
[   98.222780]  s1 : 0000000000000001 a0 : 00000000000154ac a1 :
ff6000027d0f3000
[   98.223001]  a2 : ff6000007ffcc240 a3 : 0000000000000001 a4 :
ff6000027d0f3000
[   98.223217]  a5 : ff600001fdd5d500 a6 : 4000000000000000 a7 :
0000000000000000
[   98.223427]  s2 : ffffffff8156a220 s3 : ffffffff8156a418 s4 :
ffffffff80c6ba18
[   98.223636]  s5 : ffffffff815a9588 s6 : 0000000000000000 s7 :
0000000000000000
[   98.223853]  s8 : fffffffffffffffe s9 : 000000008003d6a8 s10:
0000000000000000
[   98.224065]  s11: 0000000000000000 t3 : ffffffff8156a438 t4 :
0000000000000000
[   98.224272]  t5 : 0000000000000000 t6 : 0000000000000000
[   98.224436] status: 0000000200000100 badaddr: 00ffffff8ff8ece2 cause:
000000000000000c
[   98.224778] [<ffffffff80004398>] arch_cpu_idle+0x1e/0x28
[   98.226393] ---[ end trace 0000000000000000 ]---
[   98.226770] Kernel panic - not syncing: Attempted to kill the idle task!
[   98.227188] SMP: stopping secondary CPUs
[   98.227980] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

Thanks,
Fei.

> This makes me think the necessity of 'info tb', the primary extra info
> it adds is guest instruction, which can be gotten from 'x/i' w/o calling
> tb_gen_code.
> 
> (qemu) info tb 1
> ------------------------------
> 
> TB id:1 | phys:0x79bc86 virt:0xffffffff8059bc86 flags:0x01024001 0 inv/1
>         | exec:56962444/0 guest inst cov:0.61%
>         | trans:1 ints: g:8 op:27 op_opt:22 spills:0
>         | h/g (host bytes / guest insts): 26.000000
>         | time to gen at 2.4GHz => code:747.08(ns) IR:477.92(ns)
> 
> ----------------
> IN:
> Priv: 1; Virt: 0
> 
> 0xffffffff8059bc86:  00000013          nop
> 0xffffffff8059bc8a:  00000013          nop
> 0xffffffff8059bc8e:  00000013          nop
> 0xffffffff8059bc92:  00000013          nop
> 0xffffffff8059bc96:  1141              addi                    sp,sp,-16
> 0xffffffff8059bc98:  e422              sd                      s0,8(sp)
> 0xffffffff8059bc9a:  0800              addi                    s0,sp,16
> 0xffffffff8059bc9c:  c0102573          rdtime                  a0
> ------------------------------
> 
> (qemu) x/8i 0xffffffff8059bc86
> x/8i 0xffffffff8059bc86
> 0xffffffff8059bc86:  00000013          nop
> 0xffffffff8059bc8a:  00000013          nop
> 0xffffffff8059bc8e:  00000013          nop
> 0xffffffff8059bc92:  00000013          nop
> 0xffffffff8059bc96:  1141              addi                    sp,sp,-16
> 0xffffffff8059bc98:  e422              sd                      s0,8(sp)
> 0xffffffff8059bc9a:  0800              addi                    s0,sp,16
> 0xffffffff8059bc9c:  c0102573          rdtime                  a0
> 
> 
> Thanks,
> Fei.
> 
>>> +void qemu_log_to_monitor(bool enable)
>>> +{
>>> +    to_monitor = enable;
>>> +}
>>> +
>>> +void qemu_log_to_string(bool enable, GString *s)
>>> +{
>>> +    to_string = enable;
>>> +    string = s;
>>> +}
>>
>> What are these for, and why do you need them?
>> Why would to_string ever be anything other than (string != NULL)?
>> Why are you using such very generic names for global variables?
>>
>>
>> r~
> 


