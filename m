Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDE7719389
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4c6v-0007qr-T5; Thu, 01 Jun 2023 02:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4c6t-0007iw-01
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:48:35 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4c6q-0007PR-DV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685602112; x=1717138112;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nc2JflUV1YPEhW7n/nbx60vWoGCsw/VzCXjsj1BxxoU=;
 b=LukuJ/pJjJTP+miHepRxBThPwjGV0atTFPom3sRAgoW4/XF0w/Qpc4cI
 Wn7SesX6fSM4qFX6sS6MJp9FnI6hn5gIu/9MsY0uRUC/xHWggUvcNv7Uh
 mhaqqC7QaNi3IK6A3YZQr6REb3JJvvXdFKU6hHiAAo4YfxGk6lpHhJTNJ
 gLBoVvnpbquhASB6FaDw4nPM/reGFqCCZSEL8QeA+gDnXOgBCl3rZaeUm
 8z7X8sPre9JgAiRUbJNLCWyaTODnfi2w9z25vteyhQMuuGGGyoD8qEfv8
 0D2D5m1FSAtoGRFOPEQZ9Ru6mHe5PQyO00cBpvIHFk3VQSQp17T3py7qw g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="335091685"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="335091685"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="881503150"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="881503150"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP; 31 May 2023 23:48:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 23:48:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 23:48:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 23:48:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 23:48:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8qTueEPsKB3w7jH6cw5l+P3ZGJXjO44WCAxnd3kklDNPVISPBFVxkFh8cUyFQef5syCxj+413/oLO2T1ES2/X5mVRqmKnHIlH1kyn70pofpHkHxnI7VrHMPKY2LSHivmT6s+3UuEjx6hcBB+RVIl1rMDUqvER1rYfoognJETQ7LkZzLWDEngonNXyr9febbSllRYDnAlz4k0Ni7AwsJ+dUO4eDSh28D+woZAquYtRwg5ShqfjOaVXXysqnz4WivjKrcWliKuf/6dCWK58Nye1T4SJtHDLZqUxqjNdzLIzJieXlcy8YTuUYfFBKxKcNeNiyEfk0l9O1xmfW/15wpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blMEt1vNb0Fhe7GBo/1yhRCjvsglB1SQdP24huN5+Zc=;
 b=cg9f/mkSQGm9943u2ItpHeT5SR5gJ/YjtPa4WjvS1S4sUzJdMjxy6+ZfuUhcNpeLkix8kDq/7z9eCfz82uVhQTG+04q/PS10rkkxz4jXzCWg1oRXRmRFUtZMbuBulT/0wX2Hgfb3kiprIlYetYnX3b7ffWh/cMnYt60pdB7GVIbjEHXOUMO8+7QU1Gfp5CiYVGTZQ6HGQNvG/D08NGEOMlol76PXuI80fmNWA2xN4TAcf42B9lMpOC6ZRf8Des+SZJwBjZlJPhxx8IY7CP/TB2vPtB8GgD3oAGrej9qeqhliGdth17w3csoSg6GRX6JiM5ZLaKSAf2dnCHyJ07LdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 06:48:27 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 06:48:27 +0000
Message-ID: <7345653a-6237-afc3-3e9f-63e31e0539b1@intel.com>
Date: Thu, 1 Jun 2023 14:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-5-fei2.wu@intel.com>
 <3cc014aa-96ef-9a5a-f567-2e55ce37b469@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <3cc014aa-96ef-9a5a-f567-2e55ce37b469@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 288f8269-4af4-4090-848c-08db626c33e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmcR++I36fSCNKJXoONrLvrKo5+62BNR338yHzyAc0jMg5+f943DBD61usLQWc+7gIVdQpg1EFdabYwafx6McZkJgKld92U/VDmhqqi/BsFAHqtsOp2FQqfeGKoAXTqXLZZ9UazI5chVZ2FwmDi88Y5f8x5asVOX/Hn4LcPyJolhvXic6C1PBSLbFES+y4EJTD2XlQ6L4Na9vYvoR4vHojRbcbhEHLfvnkcv9qdtOeRZndDd+MpKDjPDmzIkNSZn9xmFsprb5/BSH+MD7tZE9oiM8Fm4iR2GL6vyqTK4fk/wcTWd3gLImfes+KYHWtzm0MksEiiP5VAJZqW3E0MlaWYJWYWvlF+YiFJCRTQmtEZppoJW21fzVDADlnQ0aPp/SAhvBDa42u/lARzc7LtkUfzbFc5D5jyY5Nr06Ab/NX9qoR2ZlqXeNO7YAKoVxhJWxpuu9IvD1FjhpQ+KJ7yfJNwHEAJ3+Nrw9TNe8ab7HOMNTubbyYdolwKiXuc+jUDVBdymrbVUQH2sRDXC/+M4pxitpVR0cQqTUco4gO8bc9cF59wHc23NVztteM5QZSRaoVa9oQkhmj5KoJHzY9hxihngBPZ2Q762cpefNsvrh6Gj9Z9MQp0aSpMgHwHyEZvEbimAedTnYbCuA8kdHSDZCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(6486002)(83380400001)(316002)(6666004)(5660300002)(2616005)(41300700001)(8936002)(31696002)(8676002)(86362001)(478600001)(38100700002)(82960400001)(6506007)(6512007)(26005)(53546011)(186003)(54906003)(31686004)(4326008)(66899021)(66946007)(36756003)(66556008)(66476007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUkvakUxcXN5MXd6NjMyWmVCUXRkYmZabmMveGtnVFFTbGNJOTBVRVR3M3Fq?=
 =?utf-8?B?aEdSMDdNb05TVHJDOVFwbk9nVUR5VndHb29kcmM1cVRsYlhROHZ5aXpmNms4?=
 =?utf-8?B?cHliLzBicHBJUnpGaEtWWFhxUFgwbklpOHVDTE5XOVp4QXJMa0tmODhxTEcz?=
 =?utf-8?B?OXZLQk9qWXZDdU5Fb1RNazJJdlRWbUtETlIwa2pqWlAwclMxV1h4YXBxdDlQ?=
 =?utf-8?B?OGp2aVYzQ2tiNXF6ZVNCVmpGdXBLdkVXQ1FCL1A2V21oK3pHcitsMml0K2tr?=
 =?utf-8?B?c2VPam1MZG1Lbm9lWGF6ejVwSDVFVFd5OW5EQXA0SG9kWnlXbUxKWHZjQWJw?=
 =?utf-8?B?RVkxTk5rY3lZZEw4VDA2am16NHg5RWxwQUFSSVp6SnRuR0J3bHRYTVNKa3hi?=
 =?utf-8?B?Y2VTelpZOWltbnBMRnNSeGk1WmdlU3JJSG0xbGhBZlRUZFJRM3dmTDBjRXdZ?=
 =?utf-8?B?cFpvNStLbGxwTkpwOVUwZW5mUmJUZjVXOEFHNFNCRkx6dGZxS2dHZ0JIRFpP?=
 =?utf-8?B?TzNFb0VubkhHdDFkWjJoelhtejFnYkZIOXBzYWtwMkpEMkZrb1Z0MEtpWFBr?=
 =?utf-8?B?ZkcrVDhZZThtL2NsMWZJa2hIcE1VeDdZdERJY0gzL2kxNHcrVFpJeXZRc01G?=
 =?utf-8?B?Zk5JeStFZk4yN3d0SlFjUGRxcXp6K2NXVnA0aWFvUk1kWjdCS2xGdWtxbEl6?=
 =?utf-8?B?NndrWk1rZG5FVEZ1RG1raWFMYnVGcGphTVE2V0tvcEEvQ3EvcE9kQWZxd0hz?=
 =?utf-8?B?QVV1MzZ0cEZiSW9kcXRwY2IrMjRJdlNoUm1HM1NkWWtlaTNyZVp4b2JSV0k3?=
 =?utf-8?B?ZC9NanRjNWNhVVVCZFZoTDBZMVAyR1BPRXk4R1RGajdONFBBNm4xRGNvTTNX?=
 =?utf-8?B?Y3RkdGQ3dldpNW1pczJkTXVha3lvR0ZMWkJEM1J3Q1NiVUM4eDFNMmVFVWtq?=
 =?utf-8?B?TFU0eHVVTnBRVGxlOHgvWGJ2ZUVCdjF1OVVlWHVPaXpDZk5DVTJkT3lYWnFB?=
 =?utf-8?B?UnB3ZzN5UzFjalVYbmJlT3hBdmdnakZRYWkrUmtmZHRBVWRjeGd5TFMxVWky?=
 =?utf-8?B?Q0ZXejJ0VklJSHNMWHBjQ25HbTAzU0lVVUFiMGhqMkFrYjAxcTQyNGc3OThK?=
 =?utf-8?B?MnZtOHB3cmN1SGM5eWF0NUEzMkVsR2hxM3J4UnhRRXBmeTFrV3BzUS9VWmlR?=
 =?utf-8?B?VE51N0F1MXdvZnJhYTBjWlZ3V1BjcWFCWHhQVjhZWG9mbGhtcUc2T1k3TTFK?=
 =?utf-8?B?R0V4cFEwT2FTUXZPWDM4a0FuSmNwMVRoQXBnbE5lTjcya3hEb3psTXFNbzI2?=
 =?utf-8?B?ZTlVUDVicnNQQmFYRXdxeXVBd2VCZC9XR0RtKzJhT3duUkRvbEtFUFNMVEVE?=
 =?utf-8?B?bEl5U2R4VFJMUjZaOFdCNUh5ZkdxbVZUb1NMR2EwRGpRcHVCZ2hwbzdLdHQ5?=
 =?utf-8?B?dlBwd2Y4STNBem9KUEt5SWdLU0x1NDkrV2lLZU9NWkNGVUpWblVOaDZjTitC?=
 =?utf-8?B?SWdvTEg0bktxVFRTbThGYUFaSmExS282NmVWcXpQbkxUYU8wa3NqMWdLKy9m?=
 =?utf-8?B?VVNHSkZLU2R1MmpCY1VkMkRheTFSSzN0cXBSL1dUUW55djk3VEs5cStvcW1W?=
 =?utf-8?B?ZFVLS3ZHVUNiQmw3MXdNcEJ2ZExjNEdNT0hnRFZ1YzhtTUhGS0IzZzZDYjNN?=
 =?utf-8?B?S1RTUHpMYzBpZUVDYkZiTDBBTy8vcXVpRzNzUk83Z05ob0lJNmdEVURRRDJs?=
 =?utf-8?B?cHRFMk5PTktZbVl6VXcvY3pMNVd5QTFnWEg3emJHNHB2TVVSQjZESFBUM2hE?=
 =?utf-8?B?Yk1kelNaVzBSdjh0RkwwYXlJd1RqcjBkMStXaGxUVktEUVhsQ091NjVIYlBj?=
 =?utf-8?B?RWNxbU9uNFNCNnRpQS9oMWFnZmc5YWwveUFWdEdiRUI3VnVzMU10TTV3c3dD?=
 =?utf-8?B?WG9DZ2JJQlBPakJBMFdzYUdzVjlJMDB6aTJReE9RYVEvaHBwdlJJVUJlVUxa?=
 =?utf-8?B?TWo1VytvN2NEaysxTk1zLytNS0x1ZkVVTTRDRG9ocGJkbkMvUmpSYUlXMjVw?=
 =?utf-8?B?SklIUnlPRlhDdUVlQ2FVNVpRcWhETXpGTUVER2hjSThQRVBrK0JJaFAyVEw1?=
 =?utf-8?Q?et5TiKzt+a6jKTo7hcoB6Q0Jc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 288f8269-4af4-4090-848c-08db626c33e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 06:48:27.3052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UWQT2lQm6gPxRxIW7Nf5xMs+VKglpFy1Z5cZbnxcPEtCAN7cHgxkE6aYofTIlROb0UdQUxj+ULYs87WPhHiBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=fei2.wu@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 6/1/2023 9:08 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> +static void collect_jit_profile_info(void *p, uint32_t hash, void
>> *userp)
>> +{
>> +    struct jit_profile_info *jpi = userp;
>> +    TBStatistics *tbs = p;
>> +
>> +    jpi->translations += tbs->translations.total;
>> +    jpi->ops += tbs->code.num_tcg_ops;
>> +    if (stat_per_translation(tbs, code.num_tcg_ops) > jpi->ops_max) {
>> +        jpi->ops_max = stat_per_translation(tbs, code.num_tcg_ops);
>> +    }
>> +    jpi->del_ops += tbs->code.deleted_ops;
>> +    jpi->temps += tbs->code.temps;
>> +    if (stat_per_translation(tbs, code.temps) > jpi->temps_max) {
>> +        jpi->temps_max = stat_per_translation(tbs, code.temps);
>> +    }
>> +    jpi->host += tbs->code.out_len;
>> +    jpi->guest += tbs->code.in_len;
>> +    jpi->search_data += tbs->code.search_out_len;
>> +
>> +    jpi->interm_time += stat_per_translation(tbs, gen_times.ir);
>> +    jpi->opt_time += stat_per_translation(tbs, gen_times.ir_opt);
>> +    jpi->la_time += stat_per_translation(tbs, gen_times.la);
>> +    jpi->code_time += stat_per_translation(tbs, gen_times.code);
>> +
>> +    /*
>> +     * The restore time covers how long we have spent restoring state
>> +     * from a given TB (e.g. recovering from a fault). It is therefor
>> +     * not related to the number of translations we have done.
>> +     */
>> +    jpi->restore_time += tbs->tb_restore_time;
>> +    jpi->restore_count += tbs->tb_restore_count;
>> +}
> 
> Why do sums of averages (stats_per_translation) instead of accumulating
> the complete total and dividing by jpi->translations?
> 
There has some inconsistency.

>> +void dump_jit_exec_time_info(uint64_t dev_time, GString *buf)
>> +{
>> +    static uint64_t last_cpu_exec_time;
>> +    uint64_t cpu_exec_time;
>> +    uint64_t delta;
>> +
>> +    cpu_exec_time = tcg_cpu_exec_time();
>> +    delta = cpu_exec_time - last_cpu_exec_time;
>> +
>> +    g_string_append_printf(buf, "async time  %" PRId64 " (%0.3f)\n",
>> +                           dev_time, dev_time /
>> (double)NANOSECONDS_PER_SECOND);
>> +    g_string_append_printf(buf, "qemu time   %" PRId64 " (%0.3f)\n",
>> +                           delta, delta /
>> (double)NANOSECONDS_PER_SECOND);
>> +    last_cpu_exec_time = cpu_exec_time;
>> +}
>> +
>> +/* dump JIT statisticis using TCGProfile and TBStats */
> 
> "statistics"
> 
ok.

>> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
>> index 3973591508..749ad182f2 100644
>> --- a/accel/tcg/tcg-accel-ops.c
>> +++ b/accel/tcg/tcg-accel-ops.c
>> @@ -70,10 +70,17 @@ void tcg_cpus_destroy(CPUState *cpu)
>>   int tcg_cpus_exec(CPUState *cpu)
>>   {
>>       int ret;
>> +    uint64_t ti;
>> +
>>       assert(tcg_enabled());
>> +    ti = profile_getclock();
>> +
>>       cpu_exec_start(cpu);
>>       ret = cpu_exec(cpu);
>>       cpu_exec_end(cpu);
>> +
>> +    qatomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);
> 
> You can't qatomic_add a 64-bit value on a 32-bit host.

Right, I only changed the counters to size_t, didn't fix time part. Is
it possible to support it with some kind of locks on 32-bit as a generic
fallback solution? After all, 32-bit host seems not popular, it might be
sacrifice performance a little bit.

For me, the times 'dev_time' and 'cpu_exec_time' is only for the
developer to get a sense of how large part of time spent on such as "ir"
and "code". Alex mentioned in another thread that it's arguable if they
are useful. If not, we can remove it.

> Nor is tcg_ctx a good place to put this.
> 
> If you want to accumulate per-cpu data, put it on the cpu where there's
> no chance of racing with anyone.
> 
> Finally, I suspect that this isn't even where you want to accumulate
> time for execution as separate from translation.  You'd to that in
> cpu_exec_enter/cpu_exec_exit.
> 
>> @@ -296,6 +315,8 @@ static TBStatistics *tb_get_stats(tb_page_addr_t
>> phys_pc, target_ulong pc,
>>       new_stats->cs_base = cs_base;
>>       new_stats->flags = flags;
>>       new_stats->stats_enabled = get_default_tbstats_flag();
>> +    new_stats->tbs = g_ptr_array_sized_new(4);
> 
> Why default to 4?  Is that just a guess, or are we really recomputing
> tbs that frequently?  Is there a good reason not to use g_ptr_array_new()?
> 
Is this the same question in 2019 :) I cannot find the original link
right now. I will try to find it again later.

>> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> index 80ffbfb455..a60a92091b 100644
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -19,7 +19,7 @@
>>   #include "exec/plugin-gen.h"
>>   #include "exec/replay-core.h"
>>   -static void gen_tb_exec_count(TranslationBlock *tb)
>> +static inline void gen_tb_exec_count(TranslationBlock *tb)
> 
> Why?
> 
will remove.

>>   {
>>       if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>>           TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
>> @@ -147,6 +147,11 @@ void translator_loop(CPUState *cpu,
>> TranslationBlock *tb, int *max_insns,
>>       tb->size = db->pc_next - db->pc_first;
>>       tb->icount = db->num_insns;
>>   +    /* Save number of guest instructions for TB_JIT_STATS */
>> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
>> +        tb->tb_stats->code.num_guest_inst += db->num_insns;
>> +    }
> 
> Why do this here, as opposed to the block in tb_gen_code?
> 
close to scene of action?

>> +#define stat_per_translation(stat, name) \
>> +    (stat->translations.total ? stat->name / stat->translations.total
>> : 0)
> 
> Not a fan of this macro, and as per above, the reason for doing the
> division here is questionable.
> 
>> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
>> index 9a91cb1248..ad0da18a5f 100644
>> --- a/include/qemu/timer.h
>> +++ b/include/qemu/timer.h
>> @@ -989,4 +989,10 @@ static inline int64_t cpu_get_host_ticks(void)
>>   }
>>   #endif
>>   +static inline int64_t profile_getclock(void)
>> +{
>> +    return get_clock();
>> +}
> 
> Why?  You use get_clock directly most places.
> 
for the ones still in TCGProfile, but I think it's okay to remove.

>> +/* Timestamps during translation  */
>> +typedef struct TCGTime {
>> +    uint64_t start;
>> +    uint64_t ir_done;
>> +    uint64_t opt_done;
>> +    uint64_t la_done;
>> +    uint64_t code_done;
>> +} TCGTime;
> 
> int64_t would match the result of get_clock().
> 
OK. btw, there are still several occurrences of u64 for time in the
existing code.

>> +
>> +/*
>> + * The TCGProfile structure holds data for the lifetime of the
>> translator.
>> + */
>> +typedef struct TCGProfile {
>> +    /* exec time of this vcpu */
>> +    int64_t cpu_exec_time;
> 
> TCGContext is not per-cpu, and therefore TCGProfile does not correspond
> either.
> 
>> @@ -608,6 +630,7 @@ struct TCGContext {
>>         /* Exit to translator on overflow. */
>>       sigjmp_buf jmp_trans;
>> +    TranslationBlock *current_tb;
> 
> TCGContext.gen_tb already exists.
> 
no user actually, will remove it.

>> -int64_t tcg_cpu_exec_time(void);
>> +uint64_t tcg_cpu_exec_time(void);
> 
> Why?  (Also, probably wants removing, per above.)
> 
The original patch mentioned 'make it an uint64_t as we won't be dealing
in negative numbers.'

>> --- a/softmmu/runstate.c
>> +++ b/softmmu/runstate.c
>> @@ -728,9 +728,18 @@ static bool main_loop_should_exit(int *status)
>>   int qemu_main_loop(void)
>>   {
>>       int status = EXIT_SUCCESS;
>> +#ifdef CONFIG_TCG
>> +    uint64_t ti;
>> +#endif
>>         while (!main_loop_should_exit(&status)) {
>> +#ifdef CONFIG_TCG
>> +        ti = profile_getclock();
>> +#endif
>>           main_loop_wait(false);
>> +#ifdef CONFIG_TCG
>> +        dev_time += profile_getclock() - ti;
>> +#endif
>>       }
> 
> What is this intending to collect?  Because I don't think it measures
> anything.  Certainly nothing related to TCG, CPUs or even devices.
> 
It's exported to hmp cmd in dump_jit_exec_time_info() together with
cpu_exec_time.

>> +    /* ? won't this end up op_opt - op = del_op_count ? */
>> +    if (tb_stats_enabled(s->gen_tb, TB_JIT_STATS)) {
>> +        s->gen_tb->tb_stats->code.deleted_ops++;
>> +    }
> 
> Not quite.  We can emit new ops as well.  But how useful this is on its
> own is debatable.
> 
okay, so I will remove the comment.

>> +/* avoid copy/paste errors */
>> +#define PROF_ADD(to, from, field)                       \
>> +    do {                                                \
>> +        (to)->field += qatomic_read(&((from)->field));  \
>> +    } while (0)
> 
> It is only used twice.
> In addition, you can't use qatomic_read of a 64-bit variable on a 32-bit
> host.
> You really really need to build e.g. i386.
> 
>> @@ -5879,6 +5923,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock
>> *tb, uint64_t pc_start)
>>           }
>>       }
>>   +
>>   #ifdef CONFIG_DEBUG_TCG
> 
> Stray.
> 
will fix.

Thanks,
Fei.

> 
> r~


