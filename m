Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85C83003E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 07:46:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPzgU-00076e-0s; Wed, 17 Jan 2024 01:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1rPzgP-000765-Ke
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 01:45:53 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1rPzgL-0007Al-8Y
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 01:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705473949; x=1737009949;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3vPgK8RRYtHiHZgekYxDcseCC835vOocLGQJGXpNQI0=;
 b=XxJAQWVEUd5I58PZlIDYlWAfK6irRi4nytATrnyYCDCPhICRghYIH4xo
 SRz8SfLnbG6LxNEh0JpmPzUFWiT0Bm+du4wrEIoXHs2/77B2lTXYZ0hTw
 wfCupnsXX0mC004iIiQLBw3pBdsrcbp7mdWimaUQLTbh570LvrwFYYFWA
 43VjB/+R4bOLNK9weSYnJUQq8wLSHkmpJy6FglUUkmNW2Swfms/pByIQR
 De54gPGFu4JBN7N4wzsZ3uP/ThKVT/kwXY+xqbLXFbF2/0/Nk5w9uuwAz
 HGR7CbU0DDviNhuFAXu18rrF0JvH+ebv+4yfYQ+JpmkC87Xuyax6ajZZo Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6802008"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6802008"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2024 22:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="818419488"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; d="scan'208";a="818419488"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jan 2024 22:43:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 22:43:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 22:43:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 22:43:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2rovuwpEczhQzRUN2pgQymf6Gaixrxp4h339adnm9PCoKF8OvdjFhp1b5KGRD4qxe3Oxc+NUAndDBcKpPmdrYdAd7BN2SqbRLAB2kGzPbECYF5mtEb67GLHsL0WyyCdDr+Fxq4PTOfeAeph8t/dMgbAqSZ19RDucqWpYkalj5m9yHMa0NeQ9sX+ERTwmUXVoJ5iSNmG4rmuBSB3wMIMdN/Yy7Wm2z9pQOf9NgjX1XVut2YocBmy8gsuhO1lMFnYkh3i9brszMZ5wWdF4XUuEVIupCNC6ks6rlgwaJJ3WoEAL6wLProwT5NeF6GNPclviOPu4BKYb4jdPP1zQ/qEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbFfdFKL7W3YUXk71XfrH8SEQkCxMbxggsWk2k3c7l4=;
 b=CcsGu8admL3ozqUPFBfi2+C30dbYdqxH9ZLZN7I35mjD+F7eTjJnEnI1T3XjQuzi7v4enrrlZ11QUE0FAGkjR+r4lh7EBQ6wt7sQ2IetaZZm/t1sBbyTI9mtf+dSseiTXUyDguH60LDpNI5ZTU9H5zh6ILYS1Re7HhQrn2jaowfiwHwZVTr8RPAsxLFMw+AcY1LcEulKNxX5fW+c9wB/F/eOnPNUUmVi54H2d6dKdE2pz7k20KtrY6yUJ2SX4RVcO2Qg1mIxSfFJhRSYRPC4+Xj1zgsY/JUHN3gO4QRwZpfCux3h16HXIogX2qOEmRNtU7OitlF6El63043BQjA8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 06:43:24 +0000
Received: from PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::819:818b:9159:3af1]) by PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::819:818b:9159:3af1%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 06:43:23 +0000
Message-ID: <374dc62d-04e9-429e-9585-a2f8d3cb6182@intel.com>
Date: Wed, 17 Jan 2024 14:43:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i386/cpu: Mask with XCR0/XSS mask for
 FEAT_XSAVE_XCR0_HI and FEAT_XSAVE_XSS_HI leafs
Content-Language: en-US
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240115091325.1904229-1-xiaoyao.li@intel.com>
 <20240115091325.1904229-3-xiaoyao.li@intel.com>
From: "Yang, Weijiang" <weijiang.yang@intel.com>
In-Reply-To: <20240115091325.1904229-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To PH0PR11MB4965.namprd11.prod.outlook.com
 (2603:10b6:510:34::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4965:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 45acce3e-eb57-4d8e-2226-08dc17279a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsdRfBZwyI+1UJOt/nMZUu5fie3Tnrn8qs4vPHxVW6V8Crjnq41H0/QJTrMPLzGE5VZmIpzG2hjCA8jKSoQkUTsQbZpTFc8Pg9HaJRKJfVi3+CInQGyeGWOVEUVrxE2TCOyl1w/P47cr58hNKxs8BUHL1bdUSzHyCv8Pv1nyPo93i7MEuhJW8FSa7glspHFQCfsgkXEVEni963BwWvQ/quBh+nZD91gYFSpMJ0qD75C6y6yCPCDXh7WjrzNfgDBMVeIkdC8N48TrDTtqwDfFrQHH0VTfJTx7jdJ3LeGVsc43MYCOBUJ2nUYzJmUVWmjyDZF26TUAgCGNcPcSNPK2yTp7uZxJedlo3Nkv9/UCCsTWSnfX7ofHabunLs+WITC0lNR6uGL1M+WVZXh2HEUJNhejbKlZwk9tb6W0N4AZRwdH33V23ml85W3ce3yCraXAzlLFyYANHoRy9x4zjnz7A9CBagE/WezkIlTSNZX8occRyXI/9fCQ5SUeJAW5ngQNdqypM3cCF9Jg2AIjN/s1Xk8joDGKrGeFFd2GYy+//YSSLjGlIE/9vch5m1AA7Wi1JutUOlp9ybOUQbvDFS8vuCXP0xyoyLGsYhonPRV17n/PrM17FriRivWose+sBFYK8xuctGzwWHfuBC3tyEAIfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4965.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(2906002)(4326008)(8676002)(31686004)(8936002)(110136005)(66946007)(316002)(66476007)(66556008)(478600001)(2616005)(6506007)(6486002)(6666004)(6512007)(53546011)(83380400001)(26005)(41300700001)(86362001)(31696002)(36756003)(38100700002)(82960400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNIUHZybitmNDhKM1FnSDdFN1FqY3htYzM3WVdkMW0wQ3VuZUlmR2NPaXN3?=
 =?utf-8?B?K0U3djRFMlBrNHIrbXc1QUpkcEpiaFVMZHFsS1o1RVJGYU1XUVQ1ZExMeUFR?=
 =?utf-8?B?bldHV0pqd25UVGlkYmtackZERGdwVlBzNEgzOEt5YlUwKzlsaXUrdWRRVG9Q?=
 =?utf-8?B?enkwTlVEdFVRUE12eEowMWhQa0lYWGd4eGozamE0SEM0VkJKSzBYa1FqTHhr?=
 =?utf-8?B?WWVGU3dlbDJnc3RGTUNWZzJDRmd1SEdDUkNPMjZjaE5rTHdvMFlvQWw4QlNq?=
 =?utf-8?B?SWVzY2EyZzVpYkswdm1VeDh6cllXUHphV0djK0w2anNBa21Wc1k0SHB4WmVa?=
 =?utf-8?B?RlMvZ2MwTUQ1SFhvaUJLZmpLcWF5bjBBTWtvWXZSTnFGZkg3ZGs4WmZvMWMv?=
 =?utf-8?B?SEdWWk5ld3JjYzE5eFpvZXhJSjV2QnRzUDY3TWFtWnRTSGFiVG9TbmdMME9F?=
 =?utf-8?B?dkpZTUxwYklzd2F4dDZKc1gvTHppYzllcmh1U0RUQ0ZaRUNoWHpRajlMcnB1?=
 =?utf-8?B?cGI1cnIxNWJiMDhIYWNQZ2ptUnV6Nmtkd0t3KzJzOFlJNUtsWE9JSVYxT09N?=
 =?utf-8?B?MUxaZk44ZFhvaFpHN0hJYjViWkl5c3EvY2g0bTZ0SjJ0QmZSUEJEa09mcVpD?=
 =?utf-8?B?cmFQQm5WM09uQnBSQ1ZGcWgydFltRjQ2T0VkM2xBU3Zwdk5XVjNvRGZMaXRz?=
 =?utf-8?B?Mklmd1o3VkFESDBENXBJTndLOHBHTjBTMTFZa05DZE1uYzJrUjZFSHZteHlX?=
 =?utf-8?B?SUpMdFJFVzZXUzc0Mlc5NTVUSXMrak16cDlZb1BBN2JDRHA1YjlsT09CMzN3?=
 =?utf-8?B?RnhjWGQ2UnRtK2JTM1BsSitGNmtOWjRvZXUyYXhkOWZRTTZUam5yWnAwL3g4?=
 =?utf-8?B?NGx3SGlIL2JwM3VCTUxjNzg5Vk9oTUd5WFlIWlhzN1plT3U0UUVuc1dtWHVX?=
 =?utf-8?B?U0czemI0WHJYTjhtaGxvMEd2M1Y4SndoeHBkNmovVGJhUjNTb21DQTRXZUh4?=
 =?utf-8?B?U01UMVlwVEYxVW5EYk96SEgxN0dNS0dEY09JYjMwSU9uL2JFL2FVYnFTaVRQ?=
 =?utf-8?B?RUgwZGtjeVNmT1ZPYVFZWWxmWkluNmlhWjZ5QWhmNURHbWU0QVR2eGhMQyt0?=
 =?utf-8?B?MGoyYzQvemNCWHcrdnFiZi9qOVA4OEZsM2k2aGlrMFhqd3ZLbFpvL2ZuN00y?=
 =?utf-8?B?WEZDYy94WnZNZkxzRmJvZjVTUTcxcHhReDZkVlpTazEvcEI1Kzg0TzF6NXd3?=
 =?utf-8?B?c0FLVFEwcDQ1a3NpSVQ4bDVqTm5DbmxFTTZxaEg3c1RZLzVoVnN0ckg1SDlU?=
 =?utf-8?B?RDA1bXBQMHlwQ2xHc2dsanNQNjhtV3VVTUs4My9KTlFRU2Z3RDAvSjBSYkND?=
 =?utf-8?B?dUw1YmZtbE0zT044c084MnVwck9KMW9VdzF5Z0JkaGg3RVN2ZGc2OC84bXlI?=
 =?utf-8?B?Y1pwVUI0aWV5cytQam5idXAvTFRuRjczTGh3WXN4MWx6cEV5YTVxVXk5dUNx?=
 =?utf-8?B?MGJoU0EwL01KQi9yUzE4bGs3U2RlRk9uZW9WTVQyNDYzb2FLUHRRVXVxbnVI?=
 =?utf-8?B?VnM3TEdPS0UvdzVlcjRCTG1xSmkrSEh0dUVjeFN0cTA3QkN4VUREWGZHVzJK?=
 =?utf-8?B?NnovRnRyZTcweXlvd0dHeUdOcWFETjVMQUdDRDdnTE80WFpWZ2RtSDVSYndn?=
 =?utf-8?B?SDA0T1pjblhUeFNkNGRieG1DV1h1RG9rT1M2TlRCRzNKbVZoZEZOL200OVBM?=
 =?utf-8?B?SFhXbGFYd002N2wwaDUwK3NUQnV5NnBDWjBHL0F3cjFVVlZCbjh5bi9ZcTg0?=
 =?utf-8?B?TEFEWVlDMjlQYmNETjhpTjNJeEt2RmJCbjFSZWFHMk1HYWdoaU5zdWdqTW5T?=
 =?utf-8?B?UXZpTVdUazFTL0o2OUFCRUErdmpqd3hQdmx3eU5PazJrdEp1eG9MSXZOTnA1?=
 =?utf-8?B?d2lneEhHV004dnQ4NStsTFBaM2NSVEF6V04waXpxd1JOTmFwdGJSYXYyVEFW?=
 =?utf-8?B?SnZWYnFOaC9oc1ZHL3NiQzdJaHZFVk9zendXUjdRQjFzS2NTYnoxTmcwdCtp?=
 =?utf-8?B?eGRwak8wUGdla3J1OHp5aU5NakIvKytqemMrM1hCbU0vUFJEcFk3dzJPTHQ3?=
 =?utf-8?B?N0xwOFBUTjY4WTMwRzM1OTBkL3VXWG14Zi9QaTJqeWs3dHFCc0VsamhzZ0ZI?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45acce3e-eb57-4d8e-2226-08dc17279a22
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 06:43:23.9380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOiThHgWbYRpYtIXAGlmCVW6sl1POgM/w061/f7JcSb/b/kBZnm8DVpy/FqHxvT9EqOvBxtrOaWRGaMMMxD/Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=weijiang.yang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/15/2024 5:13 PM, Li, Xiaoyao wrote:
> The value of FEAT_XSAVE_XCR0_HI leaf and FEAT_XSAVE_XSS_HI leaf also
> need to be masked by XCR0 and XSS mask respectively, to make it
> logically correct.
>
> Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b445e2957c4f..a5c08944a483 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6946,9 +6946,9 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>       }
>   
>       env->features[FEAT_XSAVE_XCR0_LO] = mask & CPUID_XSTATE_XCR0_MASK;
> -    env->features[FEAT_XSAVE_XCR0_HI] = mask >> 32;
> +    env->features[FEAT_XSAVE_XCR0_HI] = (mask & CPUID_XSTATE_XCR0_MASK) >> 32;
>       env->features[FEAT_XSAVE_XSS_LO] = mask & CPUID_XSTATE_XSS_MASK;
> -    env->features[FEAT_XSAVE_XSS_HI] = mask >> 32;
> +    env->features[FEAT_XSAVE_XSS_HI] = (mask & CPUID_XSTATE_XSS_MASK) >> 32;
>   }

Thanks for fixing this!
Reviewed-by: Yang Weijiang <weijiang.yang@intel.com>

>   
>   /***** Steps involved on loading and filtering CPUID data


