Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F4719281
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 07:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4b6z-0007FX-Pb; Thu, 01 Jun 2023 01:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4b6v-0007FN-RG
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 01:44:33 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4b6t-0007BT-4A
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 01:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685598271; x=1717134271;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dvWv5XfsmOKHx7Oze78B/lNBbZSsTjEbvcRBpy5O6NQ=;
 b=I61uElZ9rTkxZwZ5+8oZ1tY8N8EtDFn2mEVOnxPXSe2QwkBSBQ/0FllO
 s+HlKAA3UPxBcuTEd7LFx/Xg5Upsi3f48oAemaYJNrRrM73tkAfF91GPP
 b9hk3gm5DR2gOZEY15BfH93wWObw2w5RxmMr0Vc3H+A121Y0bNSxL0xSQ
 FL0SKZzs0lkEc2uNa2d2AwbS6HtIDDDSs95aSS3qulTknszNWswyjmOzq
 Zjw/FOscsd4ILdVs4WmHXcjExb6kjaCVzzbP6UTFD7tmB5Hk2JBLI7JKQ
 E7rlDKFVqP9jvm0b01Iqijv0UTSyQWe9ClhtHy7+lr2chIh6wb6WXR8dp A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344986877"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="344986877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 22:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="1037335258"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="1037335258"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 22:44:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 22:44:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 22:44:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 22:44:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 22:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NimlurshFE/D3q2Fc/hhgUtDGEC2tvl90VmZGyUn+OWq2V/dXJBkGDDwUCEaPG0KOIyXRNDoiA9wMtxvjKoxO+5HzcR3Ye/pSM7IDPcI6slTvCKxTQE+zIiLaTm4uZQcLC/gwmoTPNLKS7mqDN1XzTDTz1T9A95E5olyyN4Lsjktth3v1WXa9cJ6owGQ0FapUlt1WRlvmVqecR/VtZjq3f+rwgY8ZMGAiOr2jmieOqun4Wd3U73cE6v1yeMbGYKbf+wYf3DTfY5aHHL+XCMMAshubF5cgBJl8FAXcnnTuIHqKgH2fFkJN8jtwo1bbL+VgjNAiPmtBql2KYdjywZx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p7ZhNG130TY8H8w3WbDNY2mBDbTsl5UHj3MhNEZ7vU=;
 b=bl9qiUDnnz18h33ooTtN5fxu1qcs2Dz9JRaQnMQBGaiRoZJlDZNQBV/9voJ8hv+XPs4yaMih3m7wbUqFyE8tisLG4R8eg0/mTzNUgJD33tZSnHZIXKHa4h1NnEwTnbpbidHGPsgOpW0ZswkcYk8FY6oUukc0GTFrHlqwLWo3gQ6oFkOIeyt7OV2EOBDixAwcFYCcLMMV56tFISVFgKd+Au4P3qO/XNGtKTWXx9OGrmVt9x/L28qdqyJzGI3RjJ8pJEZp2TrB+br69RBmecA9OKNDHF8HcsudybiX9+i5014ymn4taNi6tQpIbZOXTR0gujpAuLl1GMQHJ0gS8Sb6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 05:44:24 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 05:44:24 +0000
Message-ID: <2ef489e6-4412-d792-7a33-153a30db3289@intel.com>
Date: Thu, 1 Jun 2023 13:44:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 03/10] accel: collecting TB execution count
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-4-fei2.wu@intel.com>
 <fe705139-31e9-974b-4e45-2f0c653359da@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <fe705139-31e9-974b-4e45-2f0c653359da@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: d4dead43-5204-43ba-7202-08db62634124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oD5biHLD28t0VaW8DuWEIslhkELBPUVpKk5CK4q5CEaFbkoCB4hUXTQnMMYJoYh1OdMq2jczwlV1ZSQVzLEdmioEOtZhkBsCucocyC5UsOkExEwCLYYIqHcsDgk+xoK2fCKO4XzbJTFs1kftNxJNlvhgw+JdCfdZyPnvBP3wOMspczfcIw3w86QszHePzPznvWfuQwAe1agSkVkp5LHoCdSwICb6x2hocdzJ0I4WFkchw1NgT0ydaYj6oTfrPUAT6xxPAAHlj7vc5u8qVrobPSStN31Zxo503yqXh6vjKtiuWDIHBAHv4wT6D8V5A9MWKiRGEXIRgDV88R+iiTwPDHJQaZhIDf5TKNOoU98ln/YzUrsIHeLE7VyhNGEhkff/rNd8HXf3cabvgUI0OUBQMRAur9ldxI5qqPBTjZU6OQVQbMGShxFxTYBfElMPUCUVPBIr+ntnW0aLU2fHQoyRk8V47iQOFSmAhf0XXAm8Q29CC8uCIAb4wBwmxDOXqa5wUbJJoFy7/AarbG/+Eyu16c52e/4CTy+ehFAT3ZQ6v4r2VwtyWKx57Ook0m8h8l35bFJ8rSDjOQbpmILMJUYmsQnPvUq1RcTeZ6K64jhQqGgV+M11/7GIDyg82hBgSlUYjqiDkWvBCV9Wk05muh99MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(6486002)(86362001)(41300700001)(31696002)(478600001)(6666004)(66556008)(316002)(66476007)(4326008)(36756003)(66946007)(5660300002)(186003)(2906002)(6506007)(31686004)(26005)(53546011)(6512007)(83380400001)(54906003)(38100700002)(8676002)(8936002)(2616005)(82960400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elQ2VDZCUjJKTnpDREdEM3FBdm93STN5QnFhS3NnU2pDc0V6bHY5NjUzSjc4?=
 =?utf-8?B?VmVwZ2VzdmM5a1RtM0x6VEVwdUxRMjA3dzdMK254ZFJaZHh5QUFyTm1tOFY5?=
 =?utf-8?B?N3pFZzNiNDUrQlBmVGptSFFrVVJMemxva1JnVmNVM1AzeXZ1Z2p4aVRlaEJF?=
 =?utf-8?B?a0VJbDBvUG5qK05XKzNOUGZxR1EwTy9uR2o1bTlZbUlkcnJiQWE4bEE1WmJ6?=
 =?utf-8?B?dTM4TitYT0pWMWRCNmwxVWFUYVduT0FOb3ZOamJybHZqZHoybWJBNFd0L0RV?=
 =?utf-8?B?N1k3empuRkErVE9jUEhoMkpqUXMvTHZpRGVwcTM3RjR1TSt1b2JtcXRqZ0JN?=
 =?utf-8?B?eEl0SEQvOERZWWJVRTg1V08vSGNPbm03aDVYcXZEQi9ieGVkdXpqY1dRSlBU?=
 =?utf-8?B?TFBoWmM2blM0bTdDSTV4VjFEWkQwL1lBZ2NzTThnaU1abFBSTHVTVUhhRmNV?=
 =?utf-8?B?dXZXZWdkUG5lZlJXVXE4T0trTnBDREtVVklaUGVxUk5HZ0xGUVJlYW1EUTZG?=
 =?utf-8?B?bi9wSjRYVzBPWWQyQW92RUk2N25QdWl5NW81djNaZFhIQkFqMnNzOFU0NzVU?=
 =?utf-8?B?ZHpYQU5HYlZEME05RUU0TU1QMHFMTC9VeklNWFRyNDJPeUJBY05hVE9xT1By?=
 =?utf-8?B?Sk1yMmJ5Y1diTCtJNzFHQjRwYUE3U1BpbGlLbmNwcUtpVG43dU9PazgrQzZH?=
 =?utf-8?B?ZENuaERZTHJHQ1A3eUhmMGJ4R0dzSGcwVWIvWDJzZExvMkg5WWdjbU1ZSWhl?=
 =?utf-8?B?WUFybS83dzIvVU1YalYwTVRuYWszbnArSmhxVXQ4TXFVNjVTZDRPQ0NHSTYw?=
 =?utf-8?B?OWcvRklSYnBWeFRoZUY3d0YwMGlVNFVHYVVjYlAxREdWWjZPOU1CVHcrUjJH?=
 =?utf-8?B?U0RHS3B6UFpGa2pKeHFJdXo2OUlSNkRJVDMyQktXbHora2ZqRUV4UlVIeTMv?=
 =?utf-8?B?aTdzSFlFd2VsKzNKLzd4V3o5TXFSalRtd2JNcTJPTEloZUhiL0ZIdkZtZUJt?=
 =?utf-8?B?Z3RjUkVMZ0J1c1U3aXdEODVTSFpUb3JxeTNUNG1jUnFUK29ycXoydjFBeUtX?=
 =?utf-8?B?UmFGWVc0QWcvVDRqTENDMkQxdStoOEZIWWdtS0dZU2JpZE45b0ZzWFdIMEpz?=
 =?utf-8?B?TzVOcWt2ajU4OWhLdUxNUDhBaXcwYmppQ3FKU2Z4enhHc2NTV3hHN2htb2Q2?=
 =?utf-8?B?R3NtTi9YWld2TmVudVVHYVBJVDFEY1UrcXc3cnJTVkFVRGZZcXJacTJRNXhG?=
 =?utf-8?B?bXhoTGF0cHZTQXNCc25XTm9HRUVXYklncGZmSk56VEZ6NGkvK3F0TFdYQ0Qx?=
 =?utf-8?B?RGNHZFRERlN0YVA4TEhOY1VtbVVwRUJ3UVpyRXBZZ2ZMVFY4Yzk5MjYvdGpk?=
 =?utf-8?B?YjczQTh2NkNQVGFIaDQxanZDeHB6Mk0yTUZCZDlhZHg4STQ0VklDYklleFE1?=
 =?utf-8?B?WlJFbHc2cEJRV0FicittWjI1WlZ2QndCR29kdGsrbFE0N29pTkkwaUFOQ2pn?=
 =?utf-8?B?ZnNMeExDRHRNdlVMSCtWRGdkdlJBb1pQOFViYm5FSVhHWmdseTNzMWdkTnBT?=
 =?utf-8?B?NU5BbDZGTDlvZm5KWmdpZzZ5WTBUVEQrdThtWHV3d1dycUswczBGcjdjdDgv?=
 =?utf-8?B?MnBKT0tWYUpvM1BWdkZWSTNoWkRnWlVrcW01bXBxdThCSk9kb29oak9VQlZ6?=
 =?utf-8?B?QmhtWEZpdTF5ckxKVWF3NTNlbUg1ZTVNVGlVSGhNVmpQa2s0MTBBQ0xuVndk?=
 =?utf-8?B?OTYwdEJIRnZmUFNaRVhhdmlIOS9icXpMVHdmZkYrcm1TYk1tbUZsRUp6S3NB?=
 =?utf-8?B?dUc0OTRFV0tDNVNiK1lRN2NZY05tK1duSU5scEVVbWdEb0hmeFBKcVFBNFgz?=
 =?utf-8?B?RDNEaU1sT2pUMDYvZU5jV0Z2b3JlRWp5bTkrcWhONkh6Qi9IVGQ2MVNUcWhH?=
 =?utf-8?B?VzIzTWcvdG5Fa3Y4UWs3QUZLWS8vT1pLdmNUUEJsb2gzTmU1SVl5LzVlbmF1?=
 =?utf-8?B?SURoWEQzNUNhZGlmNEo5RGdXWnFoM2NUcXJiZkxxak56Y3JYNld5T2ZhckRR?=
 =?utf-8?B?ZXdDbHNzSk1lNFI2MjFndFBLRG1JUHQrdGZJeHQyaExINE9CT1RuSGhsbXRV?=
 =?utf-8?Q?polP7M45uxU+dMWLn1CVJeePJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4dead43-5204-43ba-7202-08db62634124
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 05:44:24.0390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VLTIGe8eej7voWFopDxKeGikNdrYWIk1VIaoFQWJEmv7Jqi6WcbgA7T3kmRQzOHIaWeg8e0ljQqYPXXH/Xovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=fei2.wu@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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

On 6/1/2023 8:05 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>
>> If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
>> enabled, then we instrument the start code of this TB
>> to atomically count the number of times it is executed.
>> We count both the number of "normal" executions and atomic
>> executions of a TB.
>>
>> The execution count of the TB is stored in its respective
>> TBS.
>>
>> All TBStatistics are created by default with the flags from
>> default_tbstats_flag.
>>
>> [Richard Henderson created the inline gen_tb_exec_count]
>>
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
>> [AJB: Fix author]
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
>>   accel/tcg/cpu-exec.c          |  6 ++++++
>>   accel/tcg/tb-stats.c          |  6 ++++++
>>   accel/tcg/tcg-runtime.c       |  1 +
>>   accel/tcg/translate-all.c     |  7 +++++--
>>   accel/tcg/translator.c        | 25 +++++++++++++++++++++++++
>>   include/exec/gen-icount.h     |  1 +
>>   include/exec/tb-stats-flags.h |  5 +++++
>>   include/exec/tb-stats.h       | 13 +++++++++++++
>>   8 files changed, 62 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 0e741960da..c0d8f26237 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -25,6 +25,7 @@
>>   #include "trace.h"
>>   #include "disas/disas.h"
>>   #include "exec/exec-all.h"
>> +#include "exec/tb-stats.h"
>>   #include "tcg/tcg.h"
>>   #include "qemu/atomic.h"
>>   #include "qemu/rcu.h"
>> @@ -562,7 +563,12 @@ void cpu_exec_step_atomic(CPUState *cpu)
>>               mmap_unlock();
>>           }
>>   +        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>> +            tb->tb_stats->executions.atomic++;
>> +        }
>> +
>>           cpu_exec_enter(cpu);
>> +
>>           /* execute the generated code */
>>           trace_exec_tb(tb, pc);
>>           cpu_tb_exec(cpu, tb, &tb_exit);
>> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>> index f988bd8a31..143a52ef5c 100644
>> --- a/accel/tcg/tb-stats.c
>> +++ b/accel/tcg/tb-stats.c
>> @@ -22,6 +22,7 @@ enum TBStatsStatus {
>>   };
>>     static enum TBStatsStatus tcg_collect_tb_stats;
>> +static uint32_t default_tbstats_flag;
>>     void init_tb_stats_htable(void)
>>   {
>> @@ -56,3 +57,8 @@ bool tb_stats_collection_paused(void)
>>   {
>>       return tcg_collect_tb_stats == TB_STATS_PAUSED;
>>   }
>> +
>> +uint32_t get_default_tbstats_flag(void)
>> +{
>> +    return default_tbstats_flag;
>> +}
> 
> What is the purpose of this function, instead of a global variable?
> What is the meaning of 'default' in its name?
> 
tbs have their specific settings, e.g. after 'filter' cmd:
* the last_search tbs has their stats_enabled kept
* tbs not in the list sets their flag to TB_PAUSED

I guess 'default' means the flag for creating new tbstats.

>> @@ -295,6 +295,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t
>> phys_pc, target_ulong pc,
>>       new_stats->pc = pc;
>>       new_stats->cs_base = cs_base;
>>       new_stats->flags = flags;
>> +    new_stats->stats_enabled = get_default_tbstats_flag();
> 
> Is this merely to record how we have generated a given TB?
> What is the purpose of this flag over the global variable?
> 
see above.

>> diff --git a/include/exec/tb-stats-flags.h
>> b/include/exec/tb-stats-flags.h
>> index 87ee3d902e..fa71eb6f0c 100644
>> --- a/include/exec/tb-stats-flags.h
>> +++ b/include/exec/tb-stats-flags.h
>> @@ -11,6 +11,9 @@
>>   #ifndef TB_STATS_FLAGS
>>   #define TB_STATS_FLAGS
>>   +#define TB_NOTHING    (1 << 0)
>> +#define TB_EXEC_STATS (1 << 1)
> 
> Why is NOTHING a non-zero flag?
> 
yes, it might looks better. But there is no correctness issue either as
it checks if the specific bit is enabled during collecting stats.

>> --- a/include/exec/tb-stats.h
>> +++ b/include/exec/tb-stats.h
>> @@ -31,6 +31,9 @@
>>   #include "exec/tb-stats-flags.h"
>>   #include "tcg/tcg.h"
>>   +#define tb_stats_enabled(tb, JIT_STATS) \
>> +    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
> 
> Inline function, though again, why stats_enabled vs global variable?
> 
will inline it.

Thanks,
Fei.

> 
> r~


