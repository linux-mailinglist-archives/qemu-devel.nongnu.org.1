Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF2729EF0
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7dAU-0003iE-0O; Fri, 09 Jun 2023 10:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q7dAS-0003hu-Mm
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:32:44 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q7dAQ-0004s3-BI
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686321162; x=1717857162;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HEdwR3yB5DMoGsnDLTWUmptEYJCraUKyYtCKd0mmyPw=;
 b=Xsyuxc8RTx/8/w0662sgU2lyV9GJh/tSuTqaaWmL7osR5wsaAmfn2gh5
 ak3CvX93wEEVBVtqmz4sQoBZApdDl9N2obR4qEp5mZ8rISFQXFQhwi2t8
 g7wBRS4nEEmSxM7X08nA9qsBi6vZlKqhxzqbCqYLig9I9NKFx7jedZByr
 87CfjmdGJsn4kqvOhiWEzIVsdgRRe+W8UKXoCNKe4GM49wT7aVVWDSBQN
 nFyPjwmZK+xvZ2bR8O7LMLfCWI/XnamnSFrVLlspMsy7c2I/dpr0UoVBj
 O8SxOiFn2XFWA+V3CuLdxPAPJBH5++s/qxku+u9pnYVVyuI62WxJcHYZP A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="421199669"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; d="scan'208";a="421199669"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2023 07:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710378457"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; d="scan'208";a="710378457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 07:32:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 07:32:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 07:32:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 07:32:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huANxuNqGltu7vR4HpTyb1DB/CvzLIvj6EcyI9qANHdWZnmxHKnFGjqN8wYEcE9/Q1qWqWBKa4kpIMApEBbqY0542uhAm5lS86kM/GMvtVyrt0LxZqvlHzEBP5GeB6alWyOwvgz0hDLBsxW8vb0dYg24/pNGXAsvEoTS2GU3C8hB8jgI+0x/TigpJJZgZ/12s9XX1i5L92UxkSG/LYe/WviUzTX02SOf75iE9msZcj5cfdgXY8fKHgvg9xebRSlpWUuxPcdX7GobXowzt4a6ADhGCHaOCEnUTNnKWSyZH0zqkc+e8bnomWKf8jJsJviXEeAxJSz+fpNMrvY+jshUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roD+rYwJVgWx2D/Fn5sPtOiJ8ghXf5s1x+UmbnU0i2o=;
 b=avmT/j9Pw/X1Lj52yNCVtVfInQTSObDHMm2rQX6GfUG+4zr9+0lz8Cab637tBOaTI1QMtZfWaD+8+koacNR1o00TkanTZrfyepMBi6gURQXJT3Q/K79fooqJAxTQpTJRTa5JMIuZwOVyOzBFRt7kdPJ3N2E62I9GIQmyAuk3HHA9IfqaOEUItztQZ8tuyAF6vNpiiprgLNgfm02t1cjjllVORxrZbUrUXnv2x/Xj5hq1jH90QqAd/SUhC7rkxZmssYGgxiwM4dr2+htRAYzWh+beIR4+M0DoZFZokfgtHCrKxEJRzjQCqJp5t1E9EvGpX47Hj3e3CiPF+x7Lb0dCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by BN9PR11MB5547.namprd11.prod.outlook.com (2603:10b6:408:104::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 14:32:30 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 14:32:30 +0000
Message-ID: <da39dc7a-4741-7c1e-fc64-ac2bf76e4354@intel.com>
Date: Fri, 9 Jun 2023 22:32:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>, "Vanderson M. do Rosario"
 <vandersonmr2@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
 <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
 <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|BN9PR11MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e486c45-391e-46e5-0651-08db68f65ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZAqCi8LAFSt50iZbpc6bWei4V5RNCOIJGnEod6aV/bbaBeiz12vC5O265zMqLQv3cjDuOdwgQ5b6HdV4SR3M0fGhnlqX2MowwRzc+fhjUixafC1TQN3C7uZ/N4Ay1BbeXksKMVb8rki9QzgF2H9R6MsVUtxglUrbUdEZgaoHlhxJ31uxGwBbuaQUWdbE+D+7eTYc64vSjCxa6mJ+HShryt4QpDj1JKmUElsY1xkHPEGKGIDNgxjWArVIkYfIqTEHkRn9ELAYrRAm4V6hbGLWrD366lvefTSRUcInmO5/aluP0I9Y58JG+aK3nRJOIibPrn9n60x2y8QNbI1zPUffJEn0TS7QGktZ4S56x+HpaHqtoRKogOi6O83HA2L9M85exqR4Mjgsyw4KJuvDAddD/MZKy7aCj+2hEtvZn+HhBpLiJx5Xe3lnwT56/LCoS2cBh5+e55POle5ZV+vciOUD0dfK+xJsj8T8CbkyO+LvRFQpT9K3/lpvMWDfYtxr/xXS22+f7XV/eLIjmQBgYCCmmQAK4xwAl3fcvzwlQDQ8waeO+DgOqx6HG5jpdhsKXlINGy0K1VsctTbzg6XWIPqKCylTMuUy8Rd4dHiIAIPBAvcuU75web6rho+Zvnt/O3KWIjN2TVz/4dUuy0KD+Pv5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(31696002)(36756003)(86362001)(54906003)(478600001)(6916009)(4326008)(316002)(66946007)(66556008)(66476007)(6666004)(6486002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(82960400001)(38100700002)(2616005)(53546011)(6512007)(6506007)(26005)(83380400001)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0w1TzE4YnpuNGtxYk00L3dhdTdNT0I2ZGdKZEZobXhHZmtVb0QrNkNHdXFR?=
 =?utf-8?B?NTAyOVo4Y3NwM1ZBS2oyOGxPcW1WMWc4akNwdE1JSVozYkdZeTlQc3hURExZ?=
 =?utf-8?B?QjFSZlpDV2o3RnBrSXBtNFFCbE9HVE1KcHAzTEVUQ1dweGsxaGFZMnE3Vk0y?=
 =?utf-8?B?Z3JwaS9pOWt2Z21WT1JIeVBxT2JieVdZcm1oajk4aHl4c09USlAycnNKWG9p?=
 =?utf-8?B?WlFuRm1kYU9xN2k0bGY3akhoT1ZrK21oTkhBRHhYQTV0ODhzTzE1YUJWWUxa?=
 =?utf-8?B?UUw1RjJxdGhNUExCMWoxdGlZQ3pOWTRSUEU2bjNwOWxhdTE5NUYwMFVtaDgz?=
 =?utf-8?B?K0crVjRmRmJ3VUNROGp2eEtEYTBHZnQ3N215K3oybkswNTF3dVN1QlhSOU43?=
 =?utf-8?B?eFFVQWc5aGtOZXlyOUVwWFlLaVVnS3h3akxCV0c3WXlhZU1QTDhMOVlMckpE?=
 =?utf-8?B?SWZnTDFXUTh4QXFFdFRRVHJVVHRLZTdDd3lXdnU1TzBRcUdVVjJuTkMzM2pD?=
 =?utf-8?B?Mis0WXM2REtSYmhkVndtZ2dvNGlDVXpsYy9OMXQ3RE9TS0x4Uk9PeGpQSFRS?=
 =?utf-8?B?RkVCKzFjS2tlM0NEM3poTkhqVnBCSmdRak1EVlVhYTlxYlllQ1d0ZHVvVUxw?=
 =?utf-8?B?TEJQZGpKbjFCVnVZWGdWbXNoUEs2RzMyekFndkd3UEtEUU9McEt5N1lUeTMw?=
 =?utf-8?B?TGlzY3pyS0tnbXVNTEZpSjFPQVBjLzVobzRqN0FPVzcvQmYvWmpjdUNpK3JQ?=
 =?utf-8?B?bnBkWWlIWEl5TEJicGxVRm5UUnNmVEJxUEcxSHBzK2hhRFhPQWY4bjMrQ2FM?=
 =?utf-8?B?aWNqQkVhTnYzY0FUaitHT0pFdXAvdTBLNElmanhpZGNMSldFYVFvRk1hNFhy?=
 =?utf-8?B?dUdNQm15VHRmOVJlR1hFUHJhUysvTVNCMEp1eUFIQWpvUVhQVWxuOWcxdmhk?=
 =?utf-8?B?STluaUIvb0tkQUFvaWUxYlNvVnZrQVRqV3RtbDNmTHNUWTM2MGFNMDZFOXd1?=
 =?utf-8?B?eHdmMzR1S1o0YmgxUVl4a3BVYXRnN1YyZ1dQNkZVZ1Z1R3l2SENzcVp2NkFn?=
 =?utf-8?B?RmJyTXlsUTBvb1lFSDEzYkhTWk9GR0hpUlgxN1JkQXJmTXZWRWVSMnJzTkx1?=
 =?utf-8?B?OExhY3BzR1FCWmJZZGVVbnlhcW9VTXJiOEc4QUVUR1RzTVlreWdDYkVFZU9H?=
 =?utf-8?B?bE1nRmQydGlQSzhUMTRaRDBubEFjWnRmMlk1TUQ0QjZadUttQ3pNR3A2MGpY?=
 =?utf-8?B?MTcvb2FDZEFHbkppMWVoQlJ2OGZkcWRCUlN6K3VzY0JsL3J1anZLUHlqM2N1?=
 =?utf-8?B?d1dzaitybDJJVGtLOW5lTks0QjRETzVGTXgvNFVhM25tYXRIRm9yTEhWMXoy?=
 =?utf-8?B?cUx6K2F5TWxwWmVmbXdIZDVQdUVZWjYzQ0ZUOHB2WjdsbzlVMng2eVlkNGdD?=
 =?utf-8?B?SkRFN1AxWTBYb0dScjhCeVZPMjFJYmExdlNxbWhFVXh5Y3Q2SVFZQVpqNXZT?=
 =?utf-8?B?WVd6ODd3UHR4eFZCYmlLdzBkTE1LZ1Jib0xsdmJ4YmZuNW1PeXlKV2hnZ2dQ?=
 =?utf-8?B?YzNiZmI2ejJtcFdmdnR1Y3V4VkhuMDVKR3pCZ2ZRZkRENjJsTkxzTENldnBV?=
 =?utf-8?B?YnhnRDVpZmp2azRXQmNMQ0IvU3dISmpXSmlhallOODJDZUVsRmdPQVl3TUVB?=
 =?utf-8?B?MXRNeTFEbHBRMFBPYzJGbzVEUE5LSk1XN1ZkVzJkendNQUd0TlluOEtHL2lx?=
 =?utf-8?B?eHRWbkMzUmJtdTVyc1AyRUVDU0l0N0lGMVk2Y2JHU0VDUDF3QzhvZEF2aEdw?=
 =?utf-8?B?V1RvTXZqRlFBWjV4MGZPY3FyYVFEY3h1OWxsWGo4ZGlrcEJ0WmhkYVhMOXZq?=
 =?utf-8?B?YUhLSTFLbStUb3JQNU93UTdoQkNadlpoc3cyMVovdld4eDdUdVZFKzJuZzJ3?=
 =?utf-8?B?MzZ0N2JrSTVLZDlac2Z5RHUwZTQ4Wkd4SGp1S2JWaWRJM3c1cndVL2pYOXlZ?=
 =?utf-8?B?YlcwTVBDcFpOQVcwdEk2WGR4WmJvSjhna01OMDBTdnR2UDA1SVdGbWxGRFU5?=
 =?utf-8?B?UWU2YVJlRXZGd25GeTNQUHhFU2YxcnNLSEdUbmZXRUJ2bmk5RWgydm1KQnNx?=
 =?utf-8?Q?oIq75wanx0DXlgPvsZwR90Ut2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e486c45-391e-46e5-0651-08db68f65ad8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 14:32:30.1717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEq2ZyfRRtMAzGbvRalxeLzOs7XKHnogRSsYVOtGAgF5B/kSRpyqF23lWWUQ/4iEFYmvhpekGsRVseLS1MmaZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5547
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31; envelope-from=fei2.wu@intel.com;
 helo=mga06.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 6/8/2023 5:23 PM, Peter Maydell wrote:
> On Thu, 8 Jun 2023 at 08:44, Wu, Fei <fei2.wu@intel.com> wrote:
>>
>> On 6/7/2023 8:49 PM, Wu, Fei wrote:
>>> On 6/1/2023 10:40 AM, Richard Henderson wrote:
>>>> Did you really need something different than monitor_disas?  You almost
>>>> certainly want to read physical memory and not virtual anyway.
>>>>
>>> Yes, it's usually okay for kernel address, but cannot re-gen the code
>>> for userspace virtual address (guest kernel panic on riscv guest). I
>>> tried monitor_disas() but it failed to disas too:
>>>     monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);
>>>
>>> How to use this function correctly?
>>>
>> 'phys_pc' in tbs is returned by get_page_addr_code_hostp(), which is not
>> guest phys address actually, but ram_addr_t instead, so it's always
>> wrong for monitor_disas. After some dirty changes, tbs can record the
>> guest pa. Now we can disas both kernel and user space code. But still,
>> no code is regenerated, disas in 'info tb' is just a convenient way to 'xp'.
>>
>> Is there any existing function to convert ram_addr_t to guest pa?
> 
> Such a function would not be well-defined, because a block of RAM
> as specified by a ram_addr_t could be present at (aliased to) multiple
> guest physical addresses, or even currently not mapped to any guest
> physical address at all. And it could be present at different physical
> addresses for different vCPUs.
> 
Thank you, Peter. What's the scenario of the last different physical
addresses for different vCPUs?

For this specific case, I found I don't have to convert ram_addr_t to
gpa, the real requirement is converting ram_addr_t to hva, this one
seems well defined using qemu_map_ram_ptr(0, ram_addr) ?

Thanks,
Fei.

> thanks
> -- PMM


