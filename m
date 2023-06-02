Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E071F83B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 03:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4u0E-0000co-4T; Thu, 01 Jun 2023 21:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4u0B-0000a3-Jo
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:54:51 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4u09-0005sF-Ch
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685670889; x=1717206889;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Fo66k/jn/xjp3cKkW9SftkjZE7gMTrvXcCB704hZZHg=;
 b=WXS7BWv5U0UClRhUlRRMsPk0kLdcVeX+rx1mbdmHbbFEJ4sNLZXkrPU6
 kxigNcRR64y8R/GfjTqNnqyQ2K/V7BZdEhiHOPbe4vIlIjcspW3AGGW6N
 H7WSr7WUu/VGmGSFib6oNgwBKsSiMOVqbWv3f+GLOtf71d9huZK2nYdsG
 tILrqxPFIilf+fASfgWhVdzz6zJxQ5cgtky516fibDchjDOfnn4FsimsZ
 Kp/0kPjY0Z0YmPQSxpYHTxsVr3OLijaAJdQbEsbqbwxVIxOld6kCi1grV
 ilt55uAEK3tIemD/7zED8Vha+1znc+tKBPZ1ctI5weclECs2wlTdtBPfb w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="355754090"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; d="scan'208";a="355754090"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 18:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701768275"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; d="scan'208";a="701768275"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga007.jf.intel.com with ESMTP; 01 Jun 2023 18:54:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 18:54:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 18:54:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 18:54:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvGKS8JfIJ9qy4Zl9eb/w9vuPRP5brdeQSF1kfRxQc5dPRTWe1ZP4wdkCxSa7Z7Ba0z/hKHb17PTSlvApZeVS66Ttl6S7P2KDbcnDcPUEmQmZMknWqzn+V+OzUR4iZ7thysJOv7asXvWsWDmVuU+cherwHFup3u3Zpih+rRfUzFpmQrrxW3CgoIRtl4a9pXLgRgu3MfoYZ7K693TyHH7E7b8ZTfOGeqcMau2SeaMeZpgHdCuq5DmybeIIV+rCAZQ/ckAPiWqlJLHFcLg7PJtKAnA8TCHlnl2Wi3EcPuti65vq8GwuCpVieEldXnffKHWQsa5ZikKmFQtFCQrnRkw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9uxd7GW7FeEKwxIYRhCojwQFEcIaUoBRLcOv0GFj+I=;
 b=hPIhonrbR+pUlhk+mGhPXgjEVtyIKuSr8mcnYUC+9mw7XNlyvjVrv8YONchn0BUIFb5qlvnGiYNsT82kn1QJhsAWYjfnyCqIu6AjzCdVujY9aRoRV7RUMJzlMRAAW6Pb+JgrEUm6AnukKM00X5S7rclOY4d76peczUbAYGpd+PD/n8RMDiJAl8exLdGHySC/A/So2kYRbbpcv+fIKmtU36yx0DwZRDFVjXO3dRH5JxnGAHl0ffDREDTJAN8ssAATsUZWXHgyEZsQh4ZXthViCpVaopJk61M4YOI/axpLbhMqHMStM3J62y/N1Rj3LIaUIinUJ8EKmDS9wkp9VYDubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by PH0PR11MB5675.namprd11.prod.outlook.com (2603:10b6:510:d4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 01:54:41 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 01:54:41 +0000
Message-ID: <ea8032cc-63c7-da86-a9d3-7bf0c25ed8c1@intel.com>
Date: Fri, 2 Jun 2023 09:54:31 +0800
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
 <2ef489e6-4412-d792-7a33-153a30db3289@intel.com>
 <1b8dceed-548f-d155-b4fb-80e76408db7d@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <1b8dceed-548f-d155-b4fb-80e76408db7d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|PH0PR11MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 391ab81b-7758-40f4-a5e1-08db630c54a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhgUGnVEJkB/EbTvRV7vpAE3RZwtubbliINbLHVFKtntFhrE7G2HGAmPO8JCniGnP2gK+vB4LJ2T0xvcW2xsBDvNNdsfVknVHcJIrp9WBG2EMcNJimy41Y6GdPXE4VEJpkC/7sRtMYSOANm8FvqNtc50QPLPyNa6aM89RmscCHJCWbMW9w2vTPCDtboSF+ZBLFmOgY60ReWBo7Ym1r+D+uHCJrIFX17qHuCLNfyN75fSrcMMw/t05uT1v0Qr0rUO0KiJDC14RMyOKBuoLywEtVvPeuO55iDNYCIE3EfHRr1e3N2nYyHMxGaYMNSetFMdvepG2T8UZduVcQ/DLgOuEjuz7B+m4OZW4YrXkENiIgP7UX6qxGU+BZzy6xTcZsWFqGwce6sgjJOySlnNhae2dpEKbZ2f4dc6jiouJnuhwcGNtCsNMC22+mdveH0jwH9GJ6KFdoGJD05Qo/+F7XIsGJ26qillRDinc6ZhfvFVM2v2/gTnIByNU87LXKF4Mv8GziVQa43rIsZNguySCGtl97V1scyp861jVbTLQggaXkZcb9vKceorBOTMgFqA13QDuOqSh1UYpTXRbZ0J38d6GKKghZ5h0oStmyxCQtMaaagvGVT4LWlm4r8uOUvpqlOCUG80xQzDtPazpH5cY0HtLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(478600001)(54906003)(8936002)(8676002)(5660300002)(36756003)(2906002)(31696002)(86362001)(4326008)(82960400001)(66476007)(66946007)(66556008)(316002)(41300700001)(38100700002)(2616005)(186003)(6512007)(6506007)(26005)(6666004)(53546011)(31686004)(6486002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG41VHJmOW1wT0diSmJ2R1E2NXNSczdYVGdJSGM4Sy8wS25sZVVjbWIxcU5z?=
 =?utf-8?B?QmhQV0Q5WjlFK3pmaktKTXRWbHVJRHhPQXV6ZGRLT25BbUJyMEFKQitoQjEx?=
 =?utf-8?B?RkFoNkdvNFdSTkpZbUcxNXZoVTd2Y09SYm1aOWtLdi95RlE1SGh0WGxzZkFD?=
 =?utf-8?B?T0NQSlcwdW8wL3FzUzJMMUE5R3l3UWFTcDZDZ2JkSnhYYTRYUFVIR0QxTVlZ?=
 =?utf-8?B?aGZjSWh0NHhrRnptMzJhakJhT2hnZWVPYU0zUUd0NFZnbjBneEdUaGFGanZs?=
 =?utf-8?B?VGlMbFJpUU16OEdNc3F6QkJ0dXNSMXpGdUExck84dTQ2N0hzbkxEL1AxNkpZ?=
 =?utf-8?B?L3YrTEl3QmxobnZYNjJ3MXpsbzZHSkpQMHNJcDh4SW1YZzdUM0NWdHV1ZHhu?=
 =?utf-8?B?c0JPQldla21yT2NHRTl1TlM1d3FWVG5Ud1paSkdZaVNzM1pSamJmWUNMOGV0?=
 =?utf-8?B?QUpXQ0lta05NSEl4UWh3dDdnSytPeUtNTVJYL2RTaHU2V1RJejhWVTlTSjc1?=
 =?utf-8?B?UE5vaXJ4QU1FMU5HdEMzQ3lGUjBmTEhsMUpPdU9UNnFIdnljTlZrT1kwNFpH?=
 =?utf-8?B?YXlkenhjVzhTdm00T2E3SXVzRGpjTEJEYWViN1Q5dG5jSmxvNytTaXk2VU4r?=
 =?utf-8?B?TC9tK0tiUENjRTc5bVlrbjBkbU5vT1JYV1hhT2JTYVR2NllTVWt2M3IraUla?=
 =?utf-8?B?U0tOTEF5Unk1SnpTU0cwWHJPeGFVZ1ZtR1NaaHQ0UTJBZ0ViNzZEZzZZcFhh?=
 =?utf-8?B?Rjh0Ui85S3AycTA5TXhCdXhtc2V0c0xyZXFUSmoweGM1NXhmcEpCdUdFVUJR?=
 =?utf-8?B?dFRLVzFaZFJPbFBncGlXUS8rVjhrV0RkM1BDZWpkeWJMVWI1bFpqTHVCTVVU?=
 =?utf-8?B?cTNDM2crK1NaVHpQMnhIdStSQkNvUnBUdjlCYUZRWGlsb0lLUVhUU0F5c2JW?=
 =?utf-8?B?SFQ0SXY3YUdJVi9HQ1VwU2FqUFQ1QWl0dkc1UDJMczlzMXhOblB2YU96enQ4?=
 =?utf-8?B?aEQyU05mcnBGMUtnYk5JK0NHdWd4Ykk4a1hIM0x3Rm1QMFprRXBqNzlnelQv?=
 =?utf-8?B?aElqeTVzSDM3cXRJY1gvOHlFZXR4c0ZyVHE2TXptcUFsTlczVUxGKzFreGR3?=
 =?utf-8?B?ZDdpTlpGQmRaRGVoL2tDSGFXbXN1ZnU0MXpyZWFaRUxsSGt6Q0xQNWN2dks1?=
 =?utf-8?B?ODRZajVzSG5BeldwdUZyWndLbjlxVWxiemxhOTdCMFZEc0tnbWhsN3Ridzl5?=
 =?utf-8?B?QWZJYXZOdFVwdWVBck4reTBCMk5zMCtIS0p1MFZGeE5CZjA4QmI4eUlpcVlZ?=
 =?utf-8?B?U2JsYkNZNjBWeWhkVDRkUkFPMHBMQTdzNlpPa0FCZkFPcmMvbXFjTTJIQk1j?=
 =?utf-8?B?Snp3OUdwUnVwN0FLdHdlczB1aHZkT3MxZEhZMnBDOWxvaldHbkd5Y3VZMVNF?=
 =?utf-8?B?VWtqbFdOYzVVOTBQSWhjNDhBUU5nOVd6VWNmWXcxbVNVa2lSaWh6bDFTNjA3?=
 =?utf-8?B?WHpzZWV2bnQwRlR1V0lXVlpLeENuVUFUcVdvRENDWVNMMHFsN25icVpPSnFL?=
 =?utf-8?B?RVJCd3lVR2FuZ25RVjdSZGM3eDJSZ1g2c1A4YXNIMHQyME9OSS8zQ3F5dlJu?=
 =?utf-8?B?NENXUHF4cUFUSE5qUkU3Y05HZzR0QWoyT1lBOHFOSFFSMmkwMFYxMlhxN1B2?=
 =?utf-8?B?eEE0QVZITGtvZTVqcDE3aHd5ZWx0cWFUMWZ3WWtUek5Zamx1ZVcwaHVzcnBl?=
 =?utf-8?B?ZWVvRmhqRUVNNXZwL3pMT2I1S3ZLUXcxUGNGQnlWWG9qVHJWTnF1YS9WTEdw?=
 =?utf-8?B?K2NxWnlUbVlvUDNITTVady9WU2hIR28rdHZjTWdNZnZOMW5jWjUrb2pqcCtV?=
 =?utf-8?B?Qm5RbGZsTjR4MUM0dFVpc3g5TE5RTmhIcDdlTTlTbktWR2ZIVkRIbVdxSmFZ?=
 =?utf-8?B?WnQ1eUZ6RFB3emtqMUppcktXNlNlR3J6cmNIMGpOTHdSMW55Wk93dUpZbi9m?=
 =?utf-8?B?Ky9uVUxTUFVpN1NQeU5CKzAyOTRBRW5PeHdOUUQwNkFZVm54WEkxL01zck44?=
 =?utf-8?B?cTlYZlprM3cxdFphYmJ4KzJTNTBVVUNLeFpZd3dsUzRCd0w2eUs0dG1mU1Z4?=
 =?utf-8?Q?RBDYvB3+L8t8kwIIBJKVjTLtw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ab81b-7758-40f4-a5e1-08db630c54a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:54:41.6957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsqLNyMbry3hHRHdyvgMgZ8G/ZSCuvk8CE9ZwgjoGQwSwk5A3K20XBYjlsHsSKcxmMxWcQ4e1VIk+DAtv5k9Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5675
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=fei2.wu@intel.com;
 helo=mga14.intel.com
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

On 6/1/2023 10:03 PM, Richard Henderson wrote:
> On 5/31/23 22:44, Wu, Fei wrote:
>> On 6/1/2023 8:05 AM, Richard Henderson wrote:
>>> On 5/30/23 01:35, Fei Wu wrote:
>>>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>>>
>>>> If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
>>>> enabled, then we instrument the start code of this TB
>>>> to atomically count the number of times it is executed.
>>>> We count both the number of "normal" executions and atomic
>>>> executions of a TB.
>>>>
>>>> The execution count of the TB is stored in its respective
>>>> TBS.
>>>>
>>>> All TBStatistics are created by default with the flags from
>>>> default_tbstats_flag.
>>>>
>>>> [Richard Henderson created the inline gen_tb_exec_count]
>>>>
>>>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>>>> Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
>>>> [AJB: Fix author]
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>> ---
>>>>    accel/tcg/cpu-exec.c          |  6 ++++++
>>>>    accel/tcg/tb-stats.c          |  6 ++++++
>>>>    accel/tcg/tcg-runtime.c       |  1 +
>>>>    accel/tcg/translate-all.c     |  7 +++++--
>>>>    accel/tcg/translator.c        | 25 +++++++++++++++++++++++++
>>>>    include/exec/gen-icount.h     |  1 +
>>>>    include/exec/tb-stats-flags.h |  5 +++++
>>>>    include/exec/tb-stats.h       | 13 +++++++++++++
>>>>    8 files changed, 62 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>>> index 0e741960da..c0d8f26237 100644
>>>> --- a/accel/tcg/cpu-exec.c
>>>> +++ b/accel/tcg/cpu-exec.c
>>>> @@ -25,6 +25,7 @@
>>>>    #include "trace.h"
>>>>    #include "disas/disas.h"
>>>>    #include "exec/exec-all.h"
>>>> +#include "exec/tb-stats.h"
>>>>    #include "tcg/tcg.h"
>>>>    #include "qemu/atomic.h"
>>>>    #include "qemu/rcu.h"
>>>> @@ -562,7 +563,12 @@ void cpu_exec_step_atomic(CPUState *cpu)
>>>>                mmap_unlock();
>>>>            }
>>>>    +        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>>>> +            tb->tb_stats->executions.atomic++;
>>>> +        }
>>>> +
>>>>            cpu_exec_enter(cpu);
>>>> +
>>>>            /* execute the generated code */
>>>>            trace_exec_tb(tb, pc);
>>>>            cpu_tb_exec(cpu, tb, &tb_exit);
>>>> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>>>> index f988bd8a31..143a52ef5c 100644
>>>> --- a/accel/tcg/tb-stats.c
>>>> +++ b/accel/tcg/tb-stats.c
>>>> @@ -22,6 +22,7 @@ enum TBStatsStatus {
>>>>    };
>>>>      static enum TBStatsStatus tcg_collect_tb_stats;
>>>> +static uint32_t default_tbstats_flag;
>>>>      void init_tb_stats_htable(void)
>>>>    {
>>>> @@ -56,3 +57,8 @@ bool tb_stats_collection_paused(void)
>>>>    {
>>>>        return tcg_collect_tb_stats == TB_STATS_PAUSED;
>>>>    }
>>>> +
>>>> +uint32_t get_default_tbstats_flag(void)
>>>> +{
>>>> +    return default_tbstats_flag;
>>>> +}
>>>
>>> What is the purpose of this function, instead of a global variable?
>>> What is the meaning of 'default' in its name?
>>>
>> tbs have their specific settings, e.g. after 'filter' cmd:
>> * the last_search tbs has their stats_enabled kept
>> * tbs not in the list sets their flag to TB_PAUSED
> 
> How does this affect anything at all?
> 
> We are not *checking* the tb->tb_stats->stats_enabled bit except at code
> generation time, not code execution time.  Therefore nothing ever reads
> the TB_PAUSED bit (or, correspondingly, the clearing of the other
> bits).  The setting of the bit is permanent.
> 
At dump time, it does check stats_enabled e.g. in dump_tb_header(). So
the question is whether FILTER is necessary at all? If not, we can
remove FILTER together with PAUSE, and only keep START & STOP in hmp cmd.

Thanks,
Fei.

>> yes, it might looks better. But there is no correctness issue either as
>> it checks if the specific bit is enabled during collecting stats.
> 
> No, it does not.  See above.
> 
> 
> r~


