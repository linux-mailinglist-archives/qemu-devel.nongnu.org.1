Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF197061DE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 09:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzBzg-0000FF-D9; Wed, 17 May 2023 03:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.li@intel.com>) id 1pzBze-0000F2-4k
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:54:42 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.li@intel.com>) id 1pzBzV-0007b6-TL
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684310073; x=1715846073;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=H5G1iee3mLWYA+CHhtiAWcjTWoJG1eXwA+4sgowvhhE=;
 b=i9fMtpeB/7OQmX7iwC8aa0+UFHSCjeohoQJ0paB/scTEl8Hc7TG8dNYI
 fk7E3pZ8jN9isPGkquiYKHjpA1dSYGho6OblFodG5X24COAkQ7X3XMmPY
 YdgSpQeXIDfPhWWbjHTrpEY3cGnMUEFERqy3Sol1NAJlBqO6QjrSS6aj9
 b+YLWgG6wPz8jpTt2KdMMgMJZCZyUcGi63dbmS0Vz09X58jxRzkHzBiEY
 9cul8aLQlmjzTxh1orddZsE5zKYTR5h74Pn+ye1cH80/70y9uV0ffYpE4
 JZJv5iDFj1AQvq5u2OmcbXRfJFI1IPVgr49+f3jFJYlu/Bh2M8U5qDGhD g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="353985008"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
 d="scan'208,217";a="353985008"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 00:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="704724068"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
 d="scan'208,217";a="704724068"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga007.fm.intel.com with ESMTP; 17 May 2023 00:54:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 00:54:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 00:54:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 00:54:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 00:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyRpabGBMN3acKZqIP7rETQOi6tY4LQop8nNuYaAax7vqZ8Ut1DCJwgZFwz6O1kypgXSeQIE1HBafZH/VZ3ELn5n64g9XKB6IAo2IQp+Id2GdoU1xsD7laN7as8HKygd1I7nBKJZHt+avgJyFAeEgOZSMzFjbaggBUC4/m+fXtTcr+3OEX4kK4CgOrGLvfOY1r/B/kcR0LJ3dYofoTFPZGns3Xno5WTJP8SMJwSFRYDB30K7sN2uX3ZwLXxR8gxGXqCLFpW2jKY6vjb7ZprQcrIweFC1dqxySeUFN1km2q1Rww8jInjtlfRyT1JWt8INWP0Eha8RgcEw3M8VoNbm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z8EGh+uKk/vvi1l/zwKsf1Kj4daKDQxXyV+QVs684w=;
 b=lrXiDf6XzLhm+WI9hTiVD53sDmfbkHbWM/IAlfY2ZvIBpckN7cBll+xBSa3iuDuqTXBoBtG4gcP92N80GzevbNTZFt6ZATwekwvzBgXrwzbN6Op14VmHbElgGge6Uc0UNR1BYKJ5TPxVV27jBKY0/qV0Xusj+JYAGXISZumrA/GmVRuIgpHaOXd5RTYPGQArvLd3nH+gnRWoJ59sg6HFOJLfNG2jvthRM69gvGCnVPHzx3T/zbIe6KWjrNnWHdCz/SZjSueT4wbeIQHQS5mcby9vzKHy2wfvZ46gWF1qpzcfDKSD4B9z1Gsx+SKku2eDnDazMwpE8rWdLhFaqXoK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3861.namprd11.prod.outlook.com (2603:10b6:a03:18d::13)
 by PH8PR11MB6730.namprd11.prod.outlook.com (2603:10b6:510:1c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:54:13 +0000
Received: from BY5PR11MB3861.namprd11.prod.outlook.com
 ([fe80::4bb9:4d9a:1c31:bbef]) by BY5PR11MB3861.namprd11.prod.outlook.com
 ([fe80::4bb9:4d9a:1c31:bbef%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 07:54:13 +0000
Content-Type: multipart/alternative;
 boundary="------------2DM21hNuSrZbkMQU7CjpU3Xs"
Message-ID: <19340505-1996-f2e5-bce4-cdf20c96830a@intel.com>
Date: Wed, 17 May 2023 15:54:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] hw/riscv/virt: Fix the boot logic if pflash0 is specified
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 <sunilvl@ventanamicro.com>
References: <20230423095938.3232631-1-yong.li@intel.com>
 <CAKmqyKM09A-dCjrF+UJh_jQyTVjG7X3RPiXLXn-qy+Of-+Zg3Q@mail.gmail.com>
From: "Li, Yong" <yong.li@intel.com>
In-Reply-To: <CAKmqyKM09A-dCjrF+UJh_jQyTVjG7X3RPiXLXn-qy+Of-+Zg3Q@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To BY5PR11MB3861.namprd11.prod.outlook.com
 (2603:10b6:a03:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3861:EE_|PH8PR11MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 794e38f2-cff5-42be-43df-08db56abe7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5XYKQwstx0QlRMfs/2ZGg5okILo+ooTxlY81esIIzgEAypq4ABr1Tj8f2px9fnF7pKZendWSCCiR4/e5tDhIEH4D2dNwdm2SsMt6KY8fSFToCXHobMWMvfbRKGAZapE9D0f/xr1ZLEI2m8LXR7u938meCmHlfAf2IKCHoCDZMWFoB3FUSZ/SCAbwBVgJ/fx2/48jOOuzyorUxj4KE6RPTg1uI0iGKcliJT6AOU6JFnNFO4rSB9/29uG7vI7E1MQ3WTgfuZmDBApKw7Ugd2NH5TQ5lW/zuW8noBPzLcp7Kg/S3cBpG3P5HXSrDjghXwUsiSDJyRZGsCpREOfbeEiceXeDA4R/4mzEmo5xXuJNhn6IJXUtZ+xOoBMCDk5np9vbhmob9Fvi9QP+7JH7JjzGECdwORO+MfOF+c4cmmjocqeTWhH6XF+XUPI+B85UzZ3Yg0oMY0xaqU08xr+k/IzzyntoasrsI6ZIXQdgelpAul/N/v/UIhf/YuZkDfU1eMycQ5bImXkRBJGG1aI441yqq/pa2UxOxtC1eaEYWfwRyipEdS65FyHJ2MEBkT/mfiOsQq6ep9teShbgYaDxz33Mc2LQVPpza49E72fensWxGgOkYv96b1HzHQdaBpf9IWT4ud8f/E5/2AOOUtxiRQUWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3861.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(2616005)(2906002)(83380400001)(186003)(41300700001)(53546011)(4326008)(6916009)(66476007)(6486002)(66556008)(316002)(66946007)(6666004)(478600001)(21615005)(6506007)(6512007)(26005)(5660300002)(33964004)(8676002)(8936002)(966005)(31696002)(166002)(38100700002)(82960400001)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlpnVy9EZkM5U3RFcFZPNnJMNTI5L0tvK0FIcnpMTTFKYVNUMVdZVHk5SWxV?=
 =?utf-8?B?T1k5WGVSbFdjeC9vRnNSSyt5L3dIcndMM2lEWk5id2RjWnhDc2Z1K1lUSFRH?=
 =?utf-8?B?b2JIc1lFZVRtcnNpbmJCSC9LRkRENDVhbWh3R0NyV0RkOXl3cHJZRFRESU8w?=
 =?utf-8?B?R2kyQ2dZU0R0eUwyKzhaenczYUI3cTQzTHlVb0s5dDA5bFdWdDgzSHAvK2FG?=
 =?utf-8?B?VEVwT3ZFN1RnK2FtdGtBVFM2alg1MzZMSTV3bFJMaVRhRFVuZ2prckZPc215?=
 =?utf-8?B?WkVPRHJaNzArV2dmMmliZmhHUFNWWkpGc3l1cWZ0cGNRTEw5YXhQM3Fld2JS?=
 =?utf-8?B?by95OGh6U2V0QlU5TGkxRVY1R0xPSGZhdnpXSk81UkxvTldTRnJwL1FsOFJy?=
 =?utf-8?B?cWN5SXhRd2pMOE4rY1g0b2hVR01pQUk1MFN6bkxwN29OWlQyNGdSK2FYWDlW?=
 =?utf-8?B?RHVET0Y4WHlNNWtrd1RJcDNPbDlRVTZBTnpOREJ3eW0zSGpZbHJwejJvOUY1?=
 =?utf-8?B?Qno3c2hSTEJvVjhQNStnWmtUUU51VHhSYnZKSnNFRzZmUXczbG5abXZWYU8v?=
 =?utf-8?B?am1KOXVrUndldUFDbmRqWE9rSjJNYlM0cGhCMFhFSkFLVkRtQ043VzdUdnhQ?=
 =?utf-8?B?bEltZm94MEd2N1BPU2tWQWlOY0w1Q2NjVGl1bTM0WCsyNFg0THFXbVlFM09n?=
 =?utf-8?B?ZStBc0JGOG5oTmI2WGZKNGh1bVNUbjhuUTNUMFBSQU8xVC9BV1Rxc0JoeEpX?=
 =?utf-8?B?Z29OZjFrbWNxQ2lUMkpsaE5NaUQxTUxZdXpkOGU1eHhycnpNNWUyTEtmUFI1?=
 =?utf-8?B?NWJqUXZUaG9odWJMWGpzNW1yaWFkaGs1VlBVc0pCLzZBWUZ1VGZKUGVBZEhD?=
 =?utf-8?B?aGFqUDZ2eDQvYlc5eWY4NUJmREZnVmNXNmg5WVJzeFUvYXBWeDdZNEFyYWt4?=
 =?utf-8?B?Y1NqanIzWWZSWmYySkRnNDl5NWtZSkFTdU1PL1cxZHAvb1BlQm5XdVVkRTRu?=
 =?utf-8?B?K21rM1ArczFUMmdIakJub0pVMDVxTm9tUFowMXQ3TTdCbXpNL2xkK0dhK2hX?=
 =?utf-8?B?bE1VcGNiRjduMTd3TWpTSDJkSzU3TDhCM2h2V1VCbVlESjBOekt5RGdNa08v?=
 =?utf-8?B?NU92QWZRSjV6aUVPTE9UR2s5UllzRC9ORFZYYlkzU29OOW56U0puRGE3TnZV?=
 =?utf-8?B?ci9BQ1lLMmZ4YVNBZWFybnRnazZGQUtDQzJxK2tsUkxmUXUvQi9hcUZxaE1Q?=
 =?utf-8?B?Sk81VDdqNFBXOERJeUk2aEczVk1yeStsNUI1NGlPWFJ4MDdtVUpIT0pQMGl2?=
 =?utf-8?B?d0tVY1kyamxNMUZkRDNBOU5MZXpiaWVPdXFvdVMrbVgwNUh4MFpSdGl6QVgr?=
 =?utf-8?B?aTdRN1BVUWhYQjVJelNscWg2dW1SSWVmNnBsUER5VmVhUnRsNThvWi9rcHlY?=
 =?utf-8?B?T09LRjBFTU1ac2N2cWgyZkppNXJOb3kwNHBPcUozanEyNFhQdjk2RmhTZWxt?=
 =?utf-8?B?Mm5iL0huaTdWY1lpbUxrUlg4OHlDem83WVgyVGpaSnk2alkxYUV2NEdtT0VE?=
 =?utf-8?B?bUJQOGVUYjRNek9vcUZ4VHEvSFdaNFBRQjcwNExKZEFUb2UzWkxKMGM5OEVI?=
 =?utf-8?B?NlBrSXFnNzUxWS83TlR6YjlYeWc0YlJNMTdqdFh4aExHN1FUWDladndPdktU?=
 =?utf-8?B?c05kd0Y1WFNMdkFsd1UrRUJPT3liekhGK3pUL0FqTm5HR09Eb1Z4K1RkSmdY?=
 =?utf-8?B?TnZyVkprY1l4V0JZNWd2dXpnNHJERHA4Q1VuK0hqY21yMUxoUlZ5SlZybTUw?=
 =?utf-8?B?a0o0MFM1Mjg0ZnAwcTJNTGFGOURLRVNOM09jQTFlVWhLQ0djcHUwamlPUGZ5?=
 =?utf-8?B?emhScnFzbVpKSHlFY0Y5d2ZWZmVCakhNUVROejJ6WXNGRDNrNGlpalhsMWx6?=
 =?utf-8?B?cHlBcXh1Tm01VXozb1p0amNxN2NKQTBPSzVsc3prb1JiOStaUUd3TEVLZEVT?=
 =?utf-8?B?OEpBOExDd1lwcmFFVU5lSXlPdU5PR256SDV6dnRYdmUzU1Vib2w3ME83UExo?=
 =?utf-8?B?WHhMd1FSME5TcXRMRklZUXZpSlE0SURYSVRycTZCd3F1dUhCcVJuU1A0UnEy?=
 =?utf-8?Q?IX1xzxUESTwZvIoRy4njdQPOp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 794e38f2-cff5-42be-43df-08db56abe7c6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3861.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:54:13.3993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNCXbPQ287uQkseovl6sdooskTXfdFZUxC81BF3Tx9gAPKlympqCq/hNp8szENfD8tK1CzRfFV5rujUyotYQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6730
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=yong.li@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--------------2DM21hNuSrZbkMQU7CjpU3Xs
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/5/17 10:27, Alistair Francis wrote:
> On Sun, Apr 23, 2023 at 11:39 PM Yong Li<yong.li@intel.com>  wrote:
>> The firmware may be specified with -bios
>> and the plfash0 device with option -drive if=pflash.
>> If both options are applied, it is intented that the pflash0 will
>> store the secure variable and the firmware be the one specified
>> by -bios. Explicitly specify "-bios none" if choose to boot from
>> pflash0
> This seems like the right approach.
>
> Can you update the docs/system/riscv/virt.rst docs to include this information?
>
> Alistair

Hi Alistair

Thanks for your review, after syncing with Sunil from ventena team.
Sunil is also working with for thishttps://www.mail-archive.com/qemu-devel@nongnu.org/msg959882.html,
and he will handle this change in his patch. Thanks


>> Signed-off-by: Yong Li<yong.li@intel.com>
>> Cc: "Zhiwei Liu"<zhiwei_liu@linux.alibaba.com>
>> ---
>>   hw/riscv/virt.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 4e3efbee16..b38b41e685 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -1296,10 +1296,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
>>           kernel_entry = 0;
>>       }
>>
>> -    if (drive_get(IF_PFLASH, 0, 0)) {
>> +    if (drive_get(IF_PFLASH, 0, 0) &&
>> +            !strcmp(machine->firmware, "none")) {
>>           /*
>> -         * Pflash was supplied, let's overwrite the address we jump to after
>> -         * reset to the base of the flash.
>> +         * If pflash (unit 0) was supplied and at the same time the -bois
>> +         * is not specified, then let's overwrite the address we jump to
>> +         * after reset to the base of the flash.
>>            */
>>           start_addr = virt_memmap[VIRT_FLASH].base;
>>       }
>> --
>> 2.25.1
>>
>>
--------------2DM21hNuSrZbkMQU7CjpU3Xs
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023/5/17 10:27, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAKmqyKM09A-dCjrF+UJh_jQyTVjG7X3RPiXLXn-qy+Of-+Zg3Q@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Sun, Apr 23, 2023 at 11:39 PM Yong Li <a class="moz-txt-link-rfc2396E" href="mailto:yong.li@intel.com">&lt;yong.li@intel.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
The firmware may be specified with -bios
and the plfash0 device with option -drive if=pflash.
If both options are applied, it is intented that the pflash0 will
store the secure variable and the firmware be the one specified
by -bios. Explicitly specify &quot;-bios none&quot; if choose to boot from
pflash0
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This seems like the right approach.

Can you update the docs/system/riscv/virt.rst docs to include this information?

Alistair
</pre>
    </blockquote>
    <pre>Hi Alistair</pre>
    <pre>Thanks for your review, after syncing with Sunil from ventena team. 
Sunil is also working with for this <a class="moz-txt-link-freetext" href="https://www.mail-archive.com/qemu-devel@nongnu.org/msg959882.html">https://www.mail-archive.com/qemu-devel@nongnu.org/msg959882.html</a>,
and he will handle this change in his patch. Thanks 
</pre>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CAKmqyKM09A-dCjrF+UJh_jQyTVjG7X3RPiXLXn-qy+Of-+Zg3Q@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Yong Li <a class="moz-txt-link-rfc2396E" href="mailto:yong.li@intel.com">&lt;yong.li@intel.com&gt;</a>
Cc: &quot;Zhiwei Liu&quot; <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
---
 hw/riscv/virt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4e3efbee16..b38b41e685 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1296,10 +1296,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
         kernel_entry = 0;
     }

-    if (drive_get(IF_PFLASH, 0, 0)) {
+    if (drive_get(IF_PFLASH, 0, 0) &amp;&amp;
+            !strcmp(machine-&gt;firmware, &quot;none&quot;)) {
         /*
-         * Pflash was supplied, let's overwrite the address we jump to after
-         * reset to the base of the flash.
+         * If pflash (unit 0) was supplied and at the same time the -bois
+         * is not specified, then let's overwrite the address we jump to
+         * after reset to the base of the flash.
          */
         start_addr = virt_memmap[VIRT_FLASH].base;
     }
--
2.25.1


</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------2DM21hNuSrZbkMQU7CjpU3Xs--

