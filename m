Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B1C719C82
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hjg-0006pI-3b; Thu, 01 Jun 2023 08:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4hjd-0006p1-T2
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:48:57 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4hjb-0005Lf-4f
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685623735; x=1717159735;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jZ017DkaA0+Ea8DynKF168LHlueAkG2HulMDzwTbwCU=;
 b=ZgODuLdwJDD5jhVglh4hP8uWMqiQRQe+0XHMAo/h9J3ulC2NbdyxlrM9
 K28VLhhb9sdYfYyzp4B3UQrkMt9OgsfbEySnCjwuKDM6+i5/DgN71AQHA
 SNyIhg/jqNNynWt8NC7iRWW8KyBHlnoLJa/E61QFJJ3Swt+JOk+Ll0vLN
 qZ6Q2lUTL2DkBSle6riUVTvRKwoJY0HNV5D9PAqAI4zSbVBgDfxmT9X6z
 wy/5nRORWHfGEIj7Sx6Xp3D0uvBMJujtwk2d0uPx251DkyEPPmPolAkUS
 xw0EUtZ9WMpSMt3IyAc7aCguBlIx/SHX21s+Dbe3MWpSnJWSWorT8HGOU w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="358821728"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; d="scan'208";a="358821728"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 05:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="797141772"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; d="scan'208";a="797141772"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2023 05:48:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 05:48:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 05:48:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 05:48:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIt5rLNFGXOwrq9fDXnmglq1WlTp+WmKyR5ddzE6wsDH+gPhr8syeg+iOq05+CG/CoSgYrP3iQ8xHmsQMai24y7T1UIPUCAIgSYKG9f4rs51zS3hFbE0w81H3puj0ElY2G71JLvd4ycKfAUsjBh/Ex/IAVQDI3HskQ62rjtwwx0dPuUwH3ildUG3jeAsJBtAiOSJRa8l4iK5tYtcyTw221yBpJlnanYwpDb098iBiWZU4zqj5b2HjaWsxqgAL7u/XA7VHtSBuwz4iDDm0ER0pUneyLrLBD6vAI44cNDjtHZJay7Imt4yU0+pA0mNoFHBh1+Sp1p6zcAO9hdYLAK2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VQW53ekJsnsJQRseCPuGuAq73rggdlasWf7VaOLZ8A=;
 b=T/H8MzrlnrnIN8rljeHvLHe+r36w/48n8KVHCIUDh8CiC8TbLkNCOB8LWOHvHmv8IrcpSz9oKgaqypQd9X0g0xrsw5CAoYHyp86o231bG719bK0k2YPI0AtFV4sLudSGQCyyCjdzG5ARwUWH/wuJiyJenz0IRiiKpnDKzb37vX66SphQnmFFcSbkEmlA1tW99Gclvmx6/6XxCbBdISwHe/pPY8hKYtnPeCd6mcJythYsI6Cw4DW6kDYKWxqbUYikJlz0ViinP/cQHKqA0EUPq7bTl0XtcPxuU7fcYG8OlBwpwR+PCTEOK5EvcU8LeEDOHDCsiyL8X/1FeUV5+jd/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CH3PR11MB8564.namprd11.prod.outlook.com (2603:10b6:610:1b1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 12:48:49 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 12:48:49 +0000
Message-ID: <810dbb1d-50d5-8f69-fe07-62afa7d63465@intel.com>
Date: Thu, 1 Jun 2023 20:48:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
CC: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>, 
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
 <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
 <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
 <a6a88248-4142-baa6-dc86-b6d471477384@intel.com> <87cz2idt3m.fsf@linaro.org>
 <ec09d167-18af-9170-3d35-2d55fa6112d8@intel.com> <87bkhzbdrx.fsf@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <87bkhzbdrx.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CH3PR11MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 8208e03d-b570-465f-437a-08db629e8bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhwHipuKAKYl5Bb+gK0sEf66n9NCXuQx5jZsHE0KchScU6Iz8XovNjZFsNaGJIgIAAPnhSqRCTXvpQbqpLiVJbC6ZL1iUb0g48D21GsxZqrE+pulM6YZ3GBQQemXorrpTXk7E6SHw+6jfw74O2PoXFV3HMYCn3clnrsKCn4fvRcFZTMhSnJlOJYK7a5WgX0kT0BqupadY8GcEMTxR5jV8vs5bEeJEkYC+ASrTFvMJpAGxiv0zNIFSnN0cYAI94Ynmk2dpFstBAZ56rIPO6mB2Z9XCpwpIBY1ynJBkyoGmhKDaoNFiMwbtb/drzIWAgjcwrg/h0wRGE/Xce0nDBMZeQAYUK7C+/N1naKnvPHwSeXppsKF8/6qwJOB70kgtm3YaTwLoXCMe7/RJDD9baQmOx5dGjksIWNDguS3wf/hejDr1CMtGCJZES30d7CcyPWA/YF66+4YL0c4PnaYz4KbzrMdaD1Q4k5snmnkCJlBJgZXiYZaXQcPBeMukIc07FxMHMNixrmmIqDr+Q3Cyf71nUmRJYUj+NElHTkh/rkQeEVecOOVJ4qiROTjFlRtuRCTNNG4BcIkI7gtix1gsM29KPa9n7xPQhtl0VjR+yLm0o57aiA/+i1DQg4FVsVqamh8xorbdI2+iteXmrehGIsewA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(31686004)(82960400001)(38100700002)(86362001)(31696002)(4326008)(478600001)(66476007)(66556008)(66946007)(6916009)(36756003)(54906003)(6666004)(186003)(66574015)(6506007)(6512007)(53546011)(26005)(2906002)(316002)(8936002)(8676002)(5660300002)(2616005)(41300700001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmVrMGFKd1NyQlZoR0xPYXBNMVhyczZCUEpubDJGbUlEejh6TUxDT1ZhV25s?=
 =?utf-8?B?K0Q3RjBhbVRuOWNwclZjTmlUd2Z5bVdtKys0TGZMYzdpeUtqNThXQUVLQTBz?=
 =?utf-8?B?U3I4WWc2Zy9xZ0RsUWlLMWtaTjZRck1MVTVrODIwTzk1NGRodnlMcWFmTUkw?=
 =?utf-8?B?QVdWck1WRzBwUDFHSjAvbUZwVzF0RWlHZlA3WElFcEZzY2I2M3ROeFcwaWVy?=
 =?utf-8?B?ZG5pSmhLOHRkNkQxN05FdmFUeDd3N3BVUjdsWHNqWFA0d1BNaU1tQ0NxOExQ?=
 =?utf-8?B?QnMzMlhEM3JMdGcxbFA3YjFEc2NqTTRLTmdKcGZFaDAzalJuS3VKc0VWNk1T?=
 =?utf-8?B?REJpNmdFWUVBaUhqOUxVNE4rTi9zWHVoWjJqZEhCUW04L3ZWYUs5d2JFdDVR?=
 =?utf-8?B?cTgybkNGeHo1YXE5Z2tDWWIxbXVUTDUwVkxGSi9tb2xoRWdpc1FDbWdKMnQr?=
 =?utf-8?B?VnJZUTFpK0JlZ0hkKzNqRERUb0FDSlVoVzdwelZlbGlWZ003ZkxGbUs1TVYz?=
 =?utf-8?B?ZkhVbDExejhVdVV3OFEzWlgzU2RXRUVqbUJwelYwTjZ1UTREOVBWRllPUkxB?=
 =?utf-8?B?c1pHeTBhckJEZDNvbi9yb3JwbFcwbmR1NVVCeldOclNNUGlJRTlyS0UyZCs5?=
 =?utf-8?B?RmF1ditjc285S09hcnhYR0p5ZDR2enZKVHdma3c4dHJVc0YwWndBNjY3OVdk?=
 =?utf-8?B?OGlwSm5uYi9vbzNEUy9Wa21RUEUyKzgyNTBWRG9Rb0ZmSld1aE5tMjNQWDJL?=
 =?utf-8?B?UkZIUlpvdFczNHRELzBHSERlcFpwVHhXR0RrcjJQWThnbDBaaEsydldxYTk5?=
 =?utf-8?B?QllKWm90aVl4KzdJaGxBYzRESzhlSTQ2Zlg0UUpjOFhiZVZpTWVyWUFadWtu?=
 =?utf-8?B?eElUanVLMzBhd1I1ZjZ6bkw0T3YrTUVuTXpsM1VRY0Y4eC9aVDVuQ3dadUYy?=
 =?utf-8?B?WElxSXRtTTRqZWQ2bUVyNExJQkdrSmxpUEtaV3lRalh1WmxGWTRNQTZHcm8x?=
 =?utf-8?B?dk5ZQ1EwRnl4M2R0ZVBER2p6RkRvNkc5MTNVVU8xYnlER2srTHE2VEpDOXNS?=
 =?utf-8?B?TlBadTN4SCt3Um5JS0tqS1RvaVZubmVubWl3cFhreS8xejJPTnlSTDF2SzVu?=
 =?utf-8?B?UG5EZVRvcDZzTHlBT0xOcFRla2EydlBzNnA1Q0g0N0NraUoyNzBBdkc0YlRC?=
 =?utf-8?B?MjlMT25ldmxLem83ckRLZFVjWHNsRER6enJXMm1xZDBGQmRjbzhkRTJFeVZQ?=
 =?utf-8?B?UFhKMDJicFpocHhQYU5WTGZEdktPeitXK1RGaUlOQ1ByQ3ZNSGpFbjZNUHdj?=
 =?utf-8?B?ZXVSODUrdjVTaUNsclJ3VDJWZlpEMlBtQlRZMHVSUnVPVjZBaTQyQytVUGlx?=
 =?utf-8?B?UE9DMmR3QXh5SWFnU1plaitidXhRTWsycnRrekJIT21tQTQxNkpRUytINWVM?=
 =?utf-8?B?Y2Rnek9FNGhra2FPVDRtUEdBL1lZSWVpMmE1RHVjeThVUXVKUjNTNFZvLzJo?=
 =?utf-8?B?T0dPRytycjRpM3JTTHpqeWRrdGRKb3lmNi9hRUtac1ZwUU8vZHBxSjJLdVZJ?=
 =?utf-8?B?VE0vWVJNMERJNU9uQUdyQlp0SU5uc3NaNGNaUjhreDJaSUY3NTZZOWNZeTYz?=
 =?utf-8?B?K1UrVitINnVRZXAzN0ovREgwRHN1eHlWMVRYUWJYbmZORUlQYWF6YjJ1d3BQ?=
 =?utf-8?B?L0dhRDNnRE1iOXNhdVFBWXJ4S0dxUmFUeExCMTUvUjl1NVBERThnMyt4Y1R5?=
 =?utf-8?B?UjRuRHlMejhXOHhPQVZHQnQvZXhXRzRULzRwejVxTFBScStORWcrU1NlbWJq?=
 =?utf-8?B?U3lmKzdOY2FHV0V1cTQrcm1YZEF5VjhMbDVobnNabnlvYVFRZm1qOHYvemNs?=
 =?utf-8?B?dUhhaG1YSU5kNklFRUtnZjh6V3pxNkwzS0pvSHVFYk9rOEVDR3NsZW83YkhK?=
 =?utf-8?B?S0RyeUNuWFlpdkFwL1N6cWNaMUpJOERqR0k0OW1FYjdDVXltRU4xeisvOHZG?=
 =?utf-8?B?YVAzWEp3emlwNTY4eHFNWXVHOVgyYU1wM0NmWGh6SllWdFRZV3ljSEp1Mm9v?=
 =?utf-8?B?YmlYWTBJUDNORUszR2E3RE5qdDVIVFZzb0hWeHFnR1NaMFZmWk1vc0k1VVla?=
 =?utf-8?Q?ID/akm8OHNjYL4/2Qp1HJmFbm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8208e03d-b570-465f-437a-08db629e8bd2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 12:48:49.6281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5p6ECf8lLUL1ljOTUgKmKjNYeHW487Emwn7UPqEa9kGsn1ohLeUdjIGKIB/BlQCI1gNwBBLJd7pXI14WMOArKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=fei2.wu@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 6/1/2023 7:51 PM, Alex Bennée wrote:
> 
> "Wu, Fei" <fei2.wu@intel.com> writes:
> 
>> On 5/30/2023 6:08 PM, Alex Bennée wrote:
>>>
>>> "Wu, Fei" <fei2.wu@intel.com> writes:
>>>
>>>> On 5/30/2023 1:01 PM, Wu, Fei wrote:
>>>>> On 5/30/2023 12:07 PM, Richard Henderson wrote:
>>>>>> On 5/29/23 04:49, Fei Wu wrote:
> <snip>
>> ----------------
>> IN:
>> Priv: 1; Virt: 0
>>
>> 0xffffffff800abe14:  864a              mv                      a2,s2
>> 0xffffffff800abe16:  85ce              mv                      a1,s3
>> 0xffffffff800abe18:  8526              mv                      a0,s1
>> 0xffffffff800abe1a:  46bd              addi                    a3,zero,15
>> 0xffffffff800abe1c:  fffff097          auipc                   ra,-4096
>>               # 0xffffffff800aae1c
>> 0xffffffff800abe20:  cc0080e7          jalr                    ra,ra,-832
>> ------------------------------
>>
>> Look at the tb with phys:0x2abe14, although the first time IR takes
>> 75274ns, but in the second command we can see it takes much less time
>> (Note IR time is accumulated).
>>
>> So if the time for the same TB is not consistent, and the deviation
>> could be dominated by system events such as memory allocation instead of
>> codegen itself (?), I think it's less useful.
>>
>> Alex, regarding dropping time profile, do you mean remove TB_JIT_TIME
>> completely?
> 
> I think so - perf would do a better job of separating system events from
> the core code as it has better visibility of the whole system. 
> 
OK, got it.

Richard, can we reach the agreement here? If yes, I will remove
TB_JIT_TIME and all the time stuffs (dev_time, cpu_exec_time)
completely. We can still add it back if it proves to be useful. The only
concern is that tbstats replaces CONFIG_PROFILER but drops this function
from it.

Thanks,
Fei.

