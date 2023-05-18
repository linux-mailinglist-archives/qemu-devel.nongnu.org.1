Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D28A7083D4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeRh-0001Df-7a; Thu, 18 May 2023 10:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzeRd-0001D9-Mr
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:17:29 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzeRZ-0006UF-J7
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684419445; x=1715955445;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rxzivDE216apJjc1lYMX7TPkQHKy4eLb+kdz2EuePpU=;
 b=YhdvgJNZPBE4X7VTqNwlRP2K7N3ezBOwqJJ28VzZoC8U2w7FU9JYKAXM
 w/pIR1FWOuavZTGynNAsvqjVQw9MjqkLaxFGGk63Lx/HO9H6X9E5Eujsl
 kfH+GjWZ5w4sChUZ3N+8NWT0s4Bu4IQku1fpfGk6ae5onvtfTlGmNj89o
 8J4Zr/TLDeIPNHHQh8DX84FpAiLc1EdQSEwqTb0SKTql3dTxr2BcvAxIr
 TFxSUtte9fAT/3x9ZkPpfDEycKp9BGfwGI3s0Ob/UqfiEZSDxliKRVq4J
 r6DNykHnfzBZTGPS/sMnCnMevg+bx2LEGyj0DQ6u5wjBkU21PAfLhhOG0 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438420385"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="438420385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 07:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="826386361"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="826386361"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga004.jf.intel.com with ESMTP; 18 May 2023 07:17:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:17:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:17:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 07:17:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 07:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5mr15QfhX21DwYi4gxv8shvG/hPs8W6TC3C7G1nU9/N3Bl08st2PlaVP/03isd1O1BqPWsK5Eqo0iMyo8lZ+25thACrttTtIXGv0meW8/SGWuUicwPU10P7OXHvOBPrRKlJnr64jelagSSTfVxkYSLIZ0t5JxxhalC2cVjgSrlcs+gjxLPMLN1opyUGDrU0ygxlpIFCWpxdXGaIlG5Pgq/XyVG8ti8K6QVNIn+7BJj9d+tzRp7mijNcvU5K3BTP35OzMSMLG0e4O1DCe2zZhy/gOmCI9DNvEA/90pLlgC8OWPZViQeZzdgennYnogRh8yZsprruoOmMmM8R/D4COg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbg3NrO3LE9G2TDyp578LTwxnwWzXp6TKNZLaSQp3Cs=;
 b=URCq0lUvdFZITWeG+4bH8mMw8TGDB/LmXgrtqVPPXwr3+WCv67YpCXO7dngxH0P82uGeTQ/IcTk1LwTWp5nWqHrTOYWMvUffqrai2Q4rOj7ADxQZdgtugH7JjMLhymEh3M3vhfSx9Y9RCM1/vQfEOIkF6QxanHeoXeOL3oozA07STmgeD5uD26dS/iby8eOBJzqIP4dV07QyZ7MSO5paoCB0x+MeNSvHppGHxPrKwdg3r3aPOW6ylfUw6sUy8Q1PaDLBVNSOxaa6xf+kzsLNBL+LDwbmmDgVJELQAAoq8xGXMu2wctc6bLCmaVfPEnVOkkTVEM6nzTTEDRWvjlak7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:17:05 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 14:17:05 +0000
Message-ID: <6979f184-a457-9068-ef8a-28bffd682760@intel.com>
Date: Thu, 18 May 2023 22:16:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 01/15] accel/tcg: introduce TBStatistics structure
Content-Language: en-US
To: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-2-fei2.wu@intel.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230518135757.1442654-2-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0210.apcprd04.prod.outlook.com
 (2603:1096:4:187::7) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MW4PR11MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: d043992d-195a-47e6-6e5e-08db57aa8e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDF5uh0u1RYPpUVqkjQa/Je1gPc7whr+N9111cf2AeNE0Rx1z1zKrLk7lNu9AKCjzazOj2Gp/zKEt8s93yTD/cOz/oDJbnfGBVYLBmm3AFB9zg0VjEUyYw8497Nf+hMKFSea8+bW1NRy9nq9/sRjnR8p1rmhzB18gJv4Gx1BCtQ9qw1Y7cN2PK+PfuKUNuyl6vZ/c/ybT73A7cVABXHV8dxTrDUqBPgMgo4YKcT2M09SuODql2QgM7aPGNk+bXDEC1/hj5gXLeVgtCHkhSzkUN3CmUTiwUCK0OKRjmaKVdhO7eZHEpbSr3ukj+sCTMQRbx2tp7FLPYUhHXfj0iuvkofOuvZVodfPSBol+OAB8quUdPbH2e5RwQKMtBl328yk6gHQAotgKNCSDnYIPmtLXSPJtz7T2YUxi56Xpcrblc821ExlJcmRDbq6Yb5A8BOna5pzGfLPSekcojLTsOXcJ8892JKLgHm4MFyGraHsTXheJ0a6W88W4XVcGJqd/6J1ImAwrEWZDHPDVx5YfgJIl6AuvmuT+O4/pzGVFDBi6UT9DEgN53cQRFZB1Ke5d7aAWBvzI1Gd1FGZYjOcQC81phlUKUHv5j+PKkwI7UL79BQqzTeGG3NgUlWEMB7QXBV8Q75ahtmDo+blXYBW1qAkuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(316002)(2906002)(30864003)(478600001)(41300700001)(8936002)(31686004)(4326008)(8676002)(6486002)(54906003)(66899021)(6666004)(66476007)(66556008)(66946007)(5660300002)(53546011)(6506007)(6512007)(26005)(82960400001)(38100700002)(186003)(83380400001)(66574015)(36756003)(2616005)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdMekVDdXZjcy9CVm1JSEVjWm9uWkFYTC9tMm5KSWRGanFPWGxFUW9vZ3pl?=
 =?utf-8?B?M0JLdFREZ3dkMVZJM2M1YjFVOStSOUF5VGZSNTNsSHlocmtDK01Hb1BuTFFP?=
 =?utf-8?B?MEJSOGljbG1TQkVmQ2FvU291aCtwbVJZcGdzREkzQmlPQzdRMldubkx4SURN?=
 =?utf-8?B?WEIveThxdDB5ZW41eGxYUVpxOVRzU2cyMDhzaVlHcFVidUZtTzh3RG1tRXZR?=
 =?utf-8?B?aU1yRG9qV1E2eVZmTUIwOWxLSUFMTnlsYUIvTDBySjJGeFBOY0FjWVRtaTgw?=
 =?utf-8?B?dDVFRDZheC9MS0dIa2RJZkdkdW1rUGZsRUJqa094ZVhsODFxV0luVi9zNHhM?=
 =?utf-8?B?dy80L3ZNaGx0K2xMdW5xUFpXYzUrdS9xSmRkUG5LSGI4b0liRGNwMUprY1Qz?=
 =?utf-8?B?d3grQTB3eDQyQTN6b2IyU25rWk5TSkFNVXdFNE9kSU9VMTZqc2tEaG9DRVNu?=
 =?utf-8?B?bFp1NXdrclBZcEx3dTF4SGE2bllBVmkvcm44TUU4SlJZKzAyV3R6SFI4SXkz?=
 =?utf-8?B?TTl3NitFRHVlZGQ0cHZlYjk5NUlhbDdLT2VNVkZQSlg3TzhhaUFRRi82UnNi?=
 =?utf-8?B?OVZmMGhJY2J4WVBlRDl1UmtWY1NrazZCZ1FtY1BnbUpVb3JXdGNDL1VDYlNX?=
 =?utf-8?B?azRqT3pIdERIcHBNZklxSmM3VjZyN0xrc1BvdGEzWHZua2dyRUJMb2k1bXpw?=
 =?utf-8?B?bzRzdWxBOHVoRXl0TEcyVWR4dlVKdHF1UjFTRjVtTjZDT2p1Y0MyUDZTaW5K?=
 =?utf-8?B?SElYenV3WmlRVlRMOHVpVUZRMzFjNk51akZYWHVZbDYvbGFXY2RhNkRLVWRZ?=
 =?utf-8?B?WG1ubGRSQThzWG5ScHRreFB0ZVczaW90ak9nUDhXNjZuWGZyZy9haENIMG9z?=
 =?utf-8?B?eTRFbWhBMTRGQ00xRTJ2Mks4MGFMclJQdnVlUTBQem02ZkcyQWxEU3VYQ2ZT?=
 =?utf-8?B?c24zeUlHSDl4dFVPVHFFeVpXL1MxaCtWVFlZb0luSGE5KzZJY1R5NkkzT1c1?=
 =?utf-8?B?dWIwVXlUMmhoNlpzSDRSdEgvYXo5bm40S2JDZ296QndrRmFSeUxaZWRyVU9o?=
 =?utf-8?B?MzhyT0VvSi9neXVZOGRRcTRuYkxudFRucm5uTEZhQ0FSb1NYWmxacXBlbDhy?=
 =?utf-8?B?M2ZUZGVlWVBWZVZoY0JqbzlCeWZZSGNuT0xtdjBmMWNWcE1qQlgvMmF1U2gx?=
 =?utf-8?B?TWFCZXl0bDIyZnljL3RWdy9rR3RtZ1p2L1huSmRUcUd5ZVhVRjBwS3ZOSk5H?=
 =?utf-8?B?N0NuOUE4WDQyYTFUYmRIK0tEaHdTMjVlTFVJbVU3UWQrajRzY0VxbFdjM2s1?=
 =?utf-8?B?UWdEb2JJeFlQNSttL3dQOTVwRTFIRkF0S0NndUNLQldONTcyamhvbWNtR2Fi?=
 =?utf-8?B?NzB1QXhtRWVCYzFuaHFMTVEyMkIwZVlUditoOTFidlZSUjNKcjdpKy9JbWs2?=
 =?utf-8?B?V0ErUDFkbnp1TUxobkVJVXZhSjlHbVI4OTNrOXluelRYMXgrNFJEMU1CN0Vy?=
 =?utf-8?B?SDFsREJ0VmNkNFBYYWlIK1FpNWdJalVJOEtudDhOWml5dVZOK2EzeDg3cnor?=
 =?utf-8?B?VXVwalpER2d4d0ozelEvNG5janJFQThjQ05PcTZKVmlVdGJ4d2ZpdGNuU0d3?=
 =?utf-8?B?anE1cjEyK3FoVHN0Z0RLckE0K0diZ1dudGRrRngraHRpWFFHNk1MdTFKa0E1?=
 =?utf-8?B?WG1ycTdUZXFVZUgvTUV5SUJBbnBkUURTUFR5ZmxNQy9WWm0zZlJrdDBYdTdG?=
 =?utf-8?B?SW4wQ29aZ25qMWtyVXhiTzVtaldmQi83SXltc3pVYzlJaDVQemZscXRXNlVQ?=
 =?utf-8?B?NWg0cmFMUzM0LzMzVDh6VnhFZi8xazJyeGFwRlIxVXpzZ01VWUdNb2VHOWI5?=
 =?utf-8?B?eXdNQkwrN253Mnp6dDUyLzlneEZpNEpobmVmclk0NDIvYk94TkUyUStvd1Vz?=
 =?utf-8?B?WlpYcVFoU1JGL1ZjdnliSlpMU1Z1dEZGeHJJUnN3RXV5cUE5cGhoRng1TW9L?=
 =?utf-8?B?T1hvaUlmeDYyWHB1Y1cvdGVUWmVja2hjTHhob1B4aVk5M0NXU0hoTVQrUlF2?=
 =?utf-8?B?WHA5bXFtN1RMellIQTNBREZYWS93c0F6QklRNWM3OG5EMTdPSXl5bXNsdGVE?=
 =?utf-8?Q?uzWqjFOtz+4chLc1xWv6AvyN2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d043992d-195a-47e6-6e5e-08db57aa8e88
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:17:05.3699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UyU+lE8Vrisr5jrfm/QHNMt2sdwTYTwuMxepOfb7hhV6Xy6oZFtmsV8OZjEP4j7pEWHGyKU0YNsCI6bGjUoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=fei2.wu@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 5/18/2023 9:57 PM, Fei Wu wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> To store statistics for each TB, we created a TBStatistics structure
> which is linked with the TBs. TBStatistics can stay alive after
> tb_flush and be relinked to a regenerated TB. So the statistics can
> be accumulated even through flushes.
> 
> The goal is to have all present and future qemu/tcg statistics and
> meta-data stored in this new structure.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-2-vandersonmr2@gmail.com>
> [AJB: fix git author, review comments]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  MAINTAINERS                   |  1 +
>  accel/tcg/meson.build         |  1 +
>  accel/tcg/tb-context.h        |  1 +
>  accel/tcg/tb-hash.h           |  7 +++++
>  accel/tcg/tb-maint.c          | 19 ++++++++++++
>  accel/tcg/tb-stats.c          | 58 +++++++++++++++++++++++++++++++++++
>  accel/tcg/translate-all.c     | 43 ++++++++++++++++++++++++++
>  include/exec/exec-all.h       |  3 ++
>  include/exec/tb-stats-flags.h | 21 +++++++++++++
>  include/exec/tb-stats.h       | 56 +++++++++++++++++++++++++++++++++
>  10 files changed, 210 insertions(+)
>  create mode 100644 accel/tcg/tb-stats.c
>  create mode 100644 include/exec/tb-stats-flags.h
>  create mode 100644 include/exec/tb-stats.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50585117a0..1e5a972be6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -153,6 +153,7 @@ F: include/exec/cpu*.h
>  F: include/exec/exec-all.h
>  F: include/exec/tb-flush.h
>  F: include/exec/target_long.h
> +F: include/exec/tb-stats*.h
>  F: include/exec/helper*.h
>  F: include/sysemu/cpus.h
>  F: include/sysemu/tcg.h
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index aeb20a6ef0..9263bdde11 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -4,6 +4,7 @@ tcg_ss.add(files(
>    'cpu-exec-common.c',
>    'cpu-exec.c',
>    'tb-maint.c',
> +  'tb-stats.c',
>    'tcg-runtime-gvec.c',
>    'tcg-runtime.c',
>    'translate-all.c',
> diff --git a/accel/tcg/tb-context.h b/accel/tcg/tb-context.h
> index cac62d9749..d7910d586b 100644
> --- a/accel/tcg/tb-context.h
> +++ b/accel/tcg/tb-context.h
> @@ -35,6 +35,7 @@ struct TBContext {
>      /* statistics */
>      unsigned tb_flush_count;
>      unsigned tb_phys_invalidate_count;
> +    struct qht tb_stats;
>  };
>  
>  extern TBContext tb_ctx;
> diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
> index 83dc610e4c..87d657a1c6 100644
> --- a/accel/tcg/tb-hash.h
> +++ b/accel/tcg/tb-hash.h
> @@ -67,4 +67,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
>      return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
>  }
>  
> +static inline
> +uint32_t tb_stats_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
> +                            uint32_t flags)
> +{
> +    return qemu_xxhash5(phys_pc, pc, flags);
> +}
> +
>  #endif
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 991746f80f..0980fca358 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -24,6 +24,7 @@
>  #include "exec/log.h"
>  #include "exec/exec-all.h"
>  #include "exec/tb-flush.h"
> +#include "exec/tb-stats.h"
>  #include "exec/translate-all.h"
>  #include "sysemu/tcg.h"
>  #include "tcg/tcg.h"
> @@ -41,6 +42,23 @@
>  #define TB_FOR_EACH_JMP(head_tb, tb, n)                                 \
>      TB_FOR_EACH_TAGGED((head_tb)->jmp_list_head, tb, n, jmp_list_next)
>  
> +/*
> + * This is the more or less the same compare as tb_cmp(), but the
> + * data persists over tb_flush. We also aggregate the various
> + * variations of cflags under one record and ignore the details of
> + * page overlap (although we can count it).
> + */
> +bool tb_stats_cmp(const void *ap, const void *bp)
> +{
> +    const TBStatistics *a = ap;
> +    const TBStatistics *b = bp;
> +
> +    return a->phys_pc == b->phys_pc &&
> +        a->pc == b->pc &&
> +        a->cs_base == b->cs_base &&
> +        a->flags == b->flags;
> +}
> +
>  static bool tb_cmp(const void *ap, const void *bp)
>  {
>      const TranslationBlock *a = ap;
> @@ -60,6 +78,7 @@ void tb_htable_init(void)
>      unsigned int mode = QHT_MODE_AUTO_RESIZE;
>  
>      qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
> +    init_tb_stats_htable();

Should we move this out? It's more tb_stats than htable.
>  }
>  
>  typedef struct PageDesc PageDesc;
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> new file mode 100644
> index 0000000000..f988bd8a31
> --- /dev/null
> +++ b/accel/tcg/tb-stats.c
> @@ -0,0 +1,58 @@
> +/*
> + * QEMU System Emulator, Code Quality Monitor System
> + *
> + * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "disas/disas.h"
> +
> +#include "exec/tb-stats.h"
> +#include "tb-context.h"
> +
> +/* TBStatistic collection controls */
> +enum TBStatsStatus {
> +    TB_STATS_DISABLED = 0,
> +    TB_STATS_RUNNING,
> +    TB_STATS_PAUSED,
> +    TB_STATS_STOPPED

So far there is no difference between DISABLED and STOPPED?

Thanks,
Fei

> +};
> +
> +static enum TBStatsStatus tcg_collect_tb_stats;
> +
> +void init_tb_stats_htable(void)
> +{
> +    if (!tb_ctx.tb_stats.map && tb_stats_collection_enabled()) {
> +        qht_init(&tb_ctx.tb_stats, tb_stats_cmp,
> +                CODE_GEN_HTABLE_SIZE, QHT_MODE_AUTO_RESIZE);
> +    }
> +}
> +
> +void enable_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats = TB_STATS_RUNNING;
> +    init_tb_stats_htable();
> +}
> +
> +void disable_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats = TB_STATS_STOPPED;
> +}
> +
> +void pause_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats = TB_STATS_PAUSED;
> +}
> +
> +bool tb_stats_collection_enabled(void)
> +{
> +    return tcg_collect_tb_stats == TB_STATS_RUNNING;
> +}
> +
> +bool tb_stats_collection_paused(void)
> +{
> +    return tcg_collect_tb_stats == TB_STATS_PAUSED;
> +}
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 353849ca6d..a5ebc5e9e2 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -54,6 +54,7 @@
>  #include "qemu/cacheinfo.h"
>  #include "qemu/timer.h"
>  #include "exec/log.h"
> +#include "exec/tb-stats.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
> @@ -301,6 +302,37 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
>      return tcg_gen_code(tcg_ctx, tb, pc);
>  }
>  
> +static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
> +                                  target_ulong cs_base, uint32_t flags)
> +{
> +    TBStatistics *new_stats = g_new0(TBStatistics, 1);
> +    uint32_t hash = tb_stats_hash_func(phys_pc, pc, flags);
> +    void *existing_stats = NULL;
> +    new_stats->phys_pc = phys_pc;
> +    new_stats->pc = pc;
> +    new_stats->cs_base = cs_base;
> +    new_stats->flags = flags;
> +
> +    /*
> +     * All initialisation must be complete before we insert into qht
> +     * table otherwise another thread might get a partially created
> +     * structure.
> +     */
> +    qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
> +
> +    if (unlikely(existing_stats)) {
> +        /*
> +         * If there is already a TBStatistic for this TB from a previous flush
> +         * then just make the new TB point to the older TBStatistic
> +         */
> +        g_free(new_stats);
> +        return existing_stats;
> +    } else {
> +        return new_stats;
> +    }
> +}
> +
> +
>  /* Called with mmap_lock held for user mode emulation.  */
>  TranslationBlock *tb_gen_code(CPUState *cpu,
>                                target_ulong pc, target_ulong cs_base,
> @@ -373,6 +405,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>  
>      trace_translate_block(tb, pc, tb->tc.ptr);
>  
> +    /*
> +     * We want to fetch the stats structure before we start code
> +     * generation so we can count interesting things about this
> +     * generation.
> +     */
> +    if (tb_stats_collection_enabled()) {
> +        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
> +    } else {
> +        tb->tb_stats = NULL;
> +    }
> +
>      gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
>      if (unlikely(gen_code_size < 0)) {
>          switch (gen_code_size) {
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index ecded1f112..d7038af3df 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -611,6 +611,9 @@ struct TranslationBlock {
>      uintptr_t jmp_list_head;
>      uintptr_t jmp_list_next[2];
>      uintptr_t jmp_dest[2];
> +
> +    /* Pointer to a struct where statistics from the TB is stored */
> +    struct TBStatistics *tb_stats;
>  };
>  
>  /* Hide the qatomic_read to make code a little easier on the eyes */
> diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
> new file mode 100644
> index 0000000000..87ee3d902e
> --- /dev/null
> +++ b/include/exec/tb-stats-flags.h
> @@ -0,0 +1,21 @@
> +/*
> + * QEMU System Emulator, Code Quality Monitor System
> + *
> + * We define the flags and control bits here to avoid complications of
> + * including TCG/CPU information in common code.
> + *
> + * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef TB_STATS_FLAGS
> +#define TB_STATS_FLAGS
> +
> +/* TBStatistic collection controls */
> +void enable_collect_tb_stats(void);
> +void disable_collect_tb_stats(void);
> +void pause_collect_tb_stats(void);
> +bool tb_stats_collection_enabled(void);
> +bool tb_stats_collection_paused(void);
> +
> +#endif
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> new file mode 100644
> index 0000000000..b519465665
> --- /dev/null
> +++ b/include/exec/tb-stats.h
> @@ -0,0 +1,56 @@
> +/*
> + * QEMU System Emulator, Code Quality Monitor System
> + *
> + * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef TB_STATS_H
> +
> +#define TB_STATS_H
> +
> +#include "exec/cpu-common.h"
> +#include "exec/exec-all.h"
> +#include "exec/tb-stats-flags.h"
> +#include "tcg/tcg.h"
> +
> +typedef struct TBStatistics TBStatistics;
> +
> +/*
> + * This struct stores statistics such as execution count of the
> + * TranslationBlocks. Each sets of TBs for a given phys_pc/pc/flags
> + * has its own TBStatistics which will persist over tb_flush.
> + *
> + * We include additional counters to track number of translations as
> + * well as variants for compile flags.
> + */
> +struct TBStatistics {
> +    tb_page_addr_t phys_pc;
> +    target_ulong pc;
> +    uint32_t     flags;
> +    /* cs_base isn't included in the hash but we do check for matches */
> +    target_ulong cs_base;
> +};
> +
> +bool tb_stats_cmp(const void *ap, const void *bp);
> +
> +void init_tb_stats_htable(void);
> +
> +#endif


