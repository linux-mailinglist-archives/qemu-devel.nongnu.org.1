Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F276C0B6
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:17:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQyc0-00077C-Qz; Tue, 01 Aug 2023 19:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qQybw-00076l-Fi
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:17:05 -0400
Received: from mail-bn8nam04on2047.outbound.protection.outlook.com
 ([40.107.100.47] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qQybt-0008BF-Nn
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEa/T6nqAsCkarm3zWs9pPa7/57dfSilBGKakhDTpAtcUva+6Q6op/ZJLISI+6MDtK8I/fG/hKpjPrrKBMB/DnPizv2XhXsm2Q8WrmICCB9rXadBT8NfmWoKu0mokjHPI0MEj4VQNCPO3XtWyiK6efFY1Axop1j3lhSZBGr4utYMkYL5V4Wv/oi8OyR7Y+lybshF+TCzdO8uV8ix1Aez5msFVnWYcfxNq5/MdLEIoMK2hp5zZ2OZtoC5Ei9FSYC4EjHpZuzyERakTKcT0AgLC/W4E/RJl11xZ6FAT90gU0xNDMrBiwjAQ26e7AXERLwyv+qMvcaJdcwCyKq/V8fPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlDFELi71whO6MTaFBU5y15Tup5sgOjfiYbViL4pleE=;
 b=TheF+kqLjmezDwZgo+IkCwRMR6Z9fVViJzy1qgDawXFVv3bW/+mSqQ+TwCG0TV1ZWoqOAD10V8GMd7KMuCqJXGExO0A0bAfYd9DhTHFFwEG2MnvgT0Pn8AKza/PYd49F4b6zQYnJBNClXy5jj9VsqLVYmnjsZwxJ5ej3YS8h8XE7QiuivyiiqwyNK7YkWAAZv/dnwFSAxQ03HBqUN/LL6FAJ/pBWQzyG2jg8aJxLWnVI35IqbBEWfv3rsbbKotV4xFbCXKHBQGKOLmLgwdTZMxGfA4UhX94NyyKvYzU7IStSgpMAbzdp2ajCxEeUAbLjSpqoI6HeyD+sype4wganPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlDFELi71whO6MTaFBU5y15Tup5sgOjfiYbViL4pleE=;
 b=jFWkAQb18htdwyET7OLdUmo4HUALsXFumffUg1zv94x51iow9qXWKCDzIzNkSSYrL1LLVd553581X96HTdVqICQ4CH8Fv77H+XTS35kwYn+c+LE7SxX4HZzJG1deG7tqBHS945u3KlJU3kj+vpHvhlsrrBM74CVVLn/bMgj8umk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 23:11:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 23:11:56 +0000
Message-ID: <f2a5e482-08d3-6d34-88d6-b5a89d47b78e@amd.com>
Date: Tue, 1 Aug 2023 18:11:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/17] Support smp.clusters for x86
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:806:125::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4223ad-1689-484f-9462-08db92e4b311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKaPjHM2GEDgg03KWq3uHhcAbkf0HD2E+rtZPVeTED//+LAo2U5iMZEeLs7RXE9GP57OBC7CPkTGhLWdUqbHFNodKq/iMTUTYhaZEsiAbieMc83BA/uMVrdZzfs72OMBWLmjs5CQ9pV/AcEb43lQzuvHBqZdqbqqUHXbAMAayaum5OTUl2WzeJqJExn3sCLNhkEe2FvnwBgphLEbyIriWOHnvQxjTxB+LBmPAMTtnrUSyeRrJZ59z23t2pwXzW9ZVnotr9imfBOSbLHaoOz9IRkht1Ry/MZ6U28/CnLjZIVD4U0IGy5cRPB7vai3UYVv3ad/fAz564Nn04C9+qBQpzlEFQYkkT18eLJC6/3alxvsd0RaOyGVUqsgz7v1A9K2r2ecqy2DYoZZlHMMPbQk7nC0dFnC14BAb6XYvThrvDKgdOYQuYhMZjwANeNV4VrUMAJhOLPeiJukGeAicPgMGZD4zJgr8tBnccXVZ/FRFSYD7UVCLz3577v7bYizAtbgrnfNePIQbPNaXHUaZQBGxB+z3kLyDt91XFUorLFPUimuWGS75CarfQUgt04weBtcP2ivjTM3IqqUbC5HXB3AZVgKu9CqPxHKOE2RlyYTtqlvpD+zNXVqUQyGOTF5iRxKnCz9+D5rD//syrUc3zphNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(966005)(6512007)(6666004)(6486002)(110136005)(54906003)(86362001)(31696002)(66946007)(66556008)(66476007)(4326008)(316002)(186003)(26005)(6506007)(53546011)(478600001)(5660300002)(41300700001)(7416002)(8676002)(8936002)(3450700001)(66899021)(2616005)(83380400001)(36756003)(38100700002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUQ2VEd3REIvRWtNTEttWnlwOFVMamNhdlBESVIvRFZnWW5raWJXdUxjZlFZ?=
 =?utf-8?B?Z2ViWEp6V0RweXVTUW5UNEVmTUttcGMxVW1TTHJyS0pGM2Z3cXBzajBWNVRo?=
 =?utf-8?B?MDgza2FIMW53SnJGMW5TclFpSnp3RXZNcXMyejdCUFRaaVUyZnVxNnFGU1pu?=
 =?utf-8?B?K2gzenJUUnY0VmJKR1l0ZElMblhlemhOL3BJQlhnVnhxK3VUSlN0MWRzb0py?=
 =?utf-8?B?N0s3YmpuU1FvRkh6dmhteDhyNzJKclFyNW9HMFgveVBrMENya1pSMmRjelRS?=
 =?utf-8?B?TWVzWG5raDB3TkJNNXZ5ekROMnd5ZjBoQ2VKbUNSc09CMXB1NGZrZmdvV3or?=
 =?utf-8?B?b2tqUmowV2w3UmozOERjYlkvT3F3cEpDejZGcmdFQUs2RFNjSkVtbzNNNzRI?=
 =?utf-8?B?eFk0cW5tOVBYY2N3aVRTSWc4MEltbXczaDVmYlVDVHVHVFF6dk51bGxrUGtB?=
 =?utf-8?B?cXIzdm1FME14Y1k5N2h3eDdieWdiTG5oVE4xOXprcDlrSStRVFJLY1lWd1J0?=
 =?utf-8?B?LzNia2cvM2R4cnRjcWlDV21aYkhGN3VZRUhkRVZ0VmlFS25LOG4wU0lUMFky?=
 =?utf-8?B?ZXh4RjhUWE5PMTJBNzhITE9XNnFMUmZDTHRZbm9zc2Rxdk9HWlNXVGJGeFp1?=
 =?utf-8?B?SDFNUjVldXFSeHY0SU9zN3hBN0cza0VWaHM0ZEozdlpsZm02cE1IN2FQTm5s?=
 =?utf-8?B?bHprVkFsa0hCVHYyTlBGaGdBcit6dE1uQytOSjBoVTU5SXZVcmxYajBYZ01w?=
 =?utf-8?B?ZEJFaXQ3MDhBazJrU25mSURxRWxXQ0V6bCtVdWNkemFrdXZ6ekQzRXJvdVRy?=
 =?utf-8?B?cDBSVklDQW5YM2VxSytHcVk3SVRia2tKQklHRzRxVUl4VFl2Z25BWk1JcG04?=
 =?utf-8?B?K3lQeDZIbTBBWU9EcS94WVFlNWFOaGFvaTRPdjdYeEt4KzlWei8zOWw5TmNH?=
 =?utf-8?B?RS9rdXpYL1VEbEo3RzRkYjBUQ0hiZm1zSkpJSXpSMWFrb1hpU25Fd1ovR0xv?=
 =?utf-8?B?MmVxY0VlaXl6RHlkWTlYcTQrRXBXOFBDdm9GOERJOXhqWmJkc3hoRlUyRjc0?=
 =?utf-8?B?ZUFiUWdpWG9TaU0raGthYW51KzZrM1JwemdtN0VrNjhkVmZHZ3BiRHNWdm05?=
 =?utf-8?B?VkU0ZW03Ym9QZ21qTmJNR1pWU1JpT1EvZkFDRWpxM29xd25GMWJ3YTdMVm9B?=
 =?utf-8?B?R2szY0dTako2NEpES2daZWw1RC9ZaVJ4Q3VLZXRiblQyd0g1VkVnUHlCdkNB?=
 =?utf-8?B?Zjc2MGdWeEFUNVNZMkpxL1U3Z1NyRlJ5M3JaRVFCRGhnRUhwTitqYzZ3WXNE?=
 =?utf-8?B?QUg5bjdRc0tPWUJkc1oydjRsUko0aE5SR2JlNlRYVWdkTkhQcGRHUUlNb1dJ?=
 =?utf-8?B?RVFrbUpkRElmdVozM2dhWlpGVHNaRncxL21kbUdEejc5ajcrOWlqeHNZbVc4?=
 =?utf-8?B?MFRCLy9xQnhGc29RbytWT3FhWjJQUDk3c1NPcWJZWWFFNFFhUUI4ZFJ0UTNJ?=
 =?utf-8?B?Y2ZCVUJqOTBuelVwWmdFbG9mK0FTMU9oTDJLeDFHeU1NL0E3bHBIczV6QTNC?=
 =?utf-8?B?QTZQY1p4Rkxpd0tBVC80RXRZRGQrbnZkMVdwdEZ1aXplUjdCVDlQZkJxMjVz?=
 =?utf-8?B?elFCdWNBeDdWRDlRWTF6TVlOdkpkY0tBRGhLUzRiRkt1dUE5MHNMNFJPQk5i?=
 =?utf-8?B?Y1V4QmZWd1NxcmYyd2VHeW4vbkF0K0xoM09HdmE0eEpVb2tCZVZHU1ZDR1dl?=
 =?utf-8?B?S3dXYmlEMittRzFtVVZoSWNaYzBPWDc3dkxKOHdSanpGU0ZIaHE1Z0VDM3gx?=
 =?utf-8?B?VTA4enhBT2JySk1GZUNVNjZ1L25xV29veHlDUXcxUThPRUhPYm9oTVdQa01u?=
 =?utf-8?B?VUhZbGRWZGJ3L3RnSnhtVEFZUDBnck00dVlKNkczK2EvVktYZVlGK0p2bVRq?=
 =?utf-8?B?OVpRQkdHOXpmVUw4NXNhdjI2WEVMM0VCbFB2b1dvUFRmMkRMM25aTlU5N2xT?=
 =?utf-8?B?RTl3SGFRbzh0NTAxNi9odkFjcFpOODVtcGVKTmQ4ZnJqVUZXQnNXVmlFNUFw?=
 =?utf-8?B?eEhSM1Z1VlMybkw4YmlTNFBqN1hYRWlTRUZnenNpTkg4eGlLS3cyZVZSNHNi?=
 =?utf-8?Q?MU3Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4223ad-1689-484f-9462-08db92e4b311
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 23:11:55.9688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yuhgMVSbfdyuYhs3lpHx9qX/izGKcUFD8xYC2xMody90sAlnWGf1sdRZheKwDDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
Received-SPF: softfail client-ip=40.107.100.47;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhao,

On 8/1/23 05:35, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> This is the our v3 patch series, rebased on the master branch at the
> commit 234320cd0573 ("Merge tag 'pull-target-arm-20230731' of https:
> //git.linaro.org/people/pmaydell/qemu-arm into staging").
> 
> Comparing with v2 [1], v3 mainly adds "Tested-by", "Reviewed-by" and
> "ACKed-by" (for PC related patchies) tags and minor code changes (Pls
> see changelog).
> 
> 
> # Introduction
> 
> This series add the cluster support for x86 PC machine, which allows
> x86 can use smp.clusters to configure x86 modlue level CPU topology.

/s/modlue/module
> 
> And since the compatibility issue (see section: ## Why not share L2
> cache in cluster directly), this series also introduce a new command
> to adjust the x86 L2 cache topology.
> 
> Welcome your comments!
> 
> 
> # Backgroud
> 
> The "clusters" parameter in "smp" is introduced by ARM [2], but x86
> hasn't supported it.
> 
> At present, x86 defaults L2 cache is shared in one core, but this is
> not enough. There're some platforms that multiple cores share the
> same L2 cache, e.g., Alder Lake-P shares L2 cache for one module of
> Atom cores [3], that is, every four Atom cores shares one L2 cache.
> Therefore, we need the new CPU topology level (cluster/module).
> 
> Another reason is for hybrid architecture. cluster support not only
> provides another level of topology definition in x86, but would aslo
> provide required code change for future our hybrid topology support.
> 
> 
> # Overview
> 
> ## Introduction of module level for x86
> 
> "cluster" in smp is the CPU topology level which is between "core" and
> die.
> 
> For x86, the "cluster" in smp is corresponding to the module level [4],
> which is above the core level. So use the "module" other than "cluster"
> in x86 code.
> 
> And please note that x86 already has a cpu topology level also named
> "cluster" [4], this level is at the upper level of the package. Here,
> the cluster in x86 cpu topology is completely different from the
> "clusters" as the smp parameter. After the module level is introduced,
> the cluster as the smp parameter will actually refer to the module level
> of x86.
> 
> 
> ## Why not share L2 cache in cluster directly
> 
> Though "clusters" was introduced to help define L2 cache topology
> [2], using cluster to define x86's L2 cache topology will cause the
> compatibility problem:
> 
> Currently, x86 defaults that the L2 cache is shared in one core, which
> actually implies a default setting "cores per L2 cache is 1" and
> therefore implicitly defaults to having as many L2 caches as cores.
> 
> For example (i386 PC machine):
> -smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16 (*)
> 
> Considering the topology of the L2 cache, this (*) implicitly means "1
> core per L2 cache" and "2 L2 caches per die".
> 
> If we use cluster to configure L2 cache topology with the new default
> setting "clusters per L2 cache is 1", the above semantics will change
> to "2 cores per cluster" and "1 cluster per L2 cache", that is, "2
> cores per L2 cache".
> 
> So the same command (*) will cause changes in the L2 cache topology,
> further affecting the performance of the virtual machine.
> 
> Therefore, x86 should only treat cluster as a cpu topology level and
> avoid using it to change L2 cache by default for compatibility.
> 
> 
> ## module level in CPUID
> 
> Currently, we don't expose module level in CPUID.1FH because currently
> linux (v6.2-rc6) doesn't support module level. And exposing module and
> die levels at the same time in CPUID.1FH will cause linux to calculate
> wrong die_id. The module level should be exposed until the real machine
> has the module level in CPUID.1FH.
> 
> We can configure CPUID.04H.02H (L2 cache topology) with module level by
> a new command:
> 
>         "-cpu,x-l2-cache-topo=cluster"
> 
> More information about this command, please see the section: "## New
> property: x-l2-cache-topo".
> 
> 
> ## New cache topology info in CPUCacheInfo
> 
> Currently, by default, the cache topology is encoded as:
> 1. i/d cache is shared in one core.
> 2. L2 cache is shared in one core.
> 3. L3 cache is shared in one die.
> 
> This default general setting has caused a misunderstanding, that is, the
> cache topology is completely equated with a specific cpu topology, such
> as the connection between L2 cache and core level, and the connection
> between L3 cache and die level.
> 
> In fact, the settings of these topologies depend on the specific
> platform and are not static. For example, on Alder Lake-P, every
> four Atom cores share the same L2 cache [2].
> 
> Thus, in this patch set, we explicitly define the corresponding cache
> topology for different cpu models and this has two benefits:
> 1. Easy to expand to new CPU models in the future, which has different
>    cache topology.
> 2. It can easily support custom cache topology by some command (e.g.,
>    x-l2-cache-topo).
> 
> 
> ## New property: x-l2-cache-topo
> 
> The property l2-cache-topo will be used to change the L2 cache topology

Should this be x-l2-cache-topo ?

> in CPUID.04H.
> 
> Now it allows user to set the L2 cache is shared in core level or
> cluster level.
> 
> If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> topology will be overrided by the new topology setting.
> 
> Since CPUID.04H is used by intel cpus, this property is available on
> intel cpus as for now.

s/intel cpus/Intel CPUs/
I feel this looks  better

> 
> When necessary, it can be extended to CPUID[0x8000001D] for amd cpus.

s/amd cpus/AMD CPUs/

> 
> 
> # Patch description
> 
> patch 1-2 Cleanups about coding style and test name.
> 
> patch 3-4,15 Fixes about x86 topology, intel l1 cache topology and amd
>              cache topology encoding.
> 
> patch 5-6 Cleanups about topology related CPUID encoding and QEMU
>           topology variables.
> 
> patch 7-12 Add the module as the new CPU topology level in x86, and it
>            is corresponding to the cluster level in generic code.
> 
> patch 13,14,16 Add cache topology infomation in cache models.
> 
> patch 17 Introduce a new command to configure L2 cache topology.
> 
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07179.html
> [2]: https://patchew.org/QEMU/20211228092221.21068-1-wangyanan55@huawei.com/
> [3]: https://www.intel.com/content/www/us/en/products/platforms/details/alder-lake-p.html
> [4]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> 
> Best Regards,
> Zhao
> 
> ---
> Changelog:
> 
> Changes since v2:
>  * Add "Tested-by", "Reviewed-by" and "ACKed-by" tags.
>  * Use newly added wrapped helper to get cores per socket in
>    qemu_init_vcpu().
> 
> Changes since v1:
>  * Reordered patches. (Yanan)
>  * Deprecated the patch to fix comment of machine_parse_smp_config().
>    (Yanan)
>  * Rename test-x86-cpuid.c to test-x86-topo.c. (Yanan)
>  * Split the intel's l1 cache topology fix into a new separate patch.
>    (Yanan)
>  * Combined module_id and APIC ID for module level support into one
>    patch. (Yanan)
>  * Make cache_into_passthrough case of cpuid 0x04 leaf in
>  * cpu_x86_cpuid() use max_processor_ids_for_cache() and
>    max_core_ids_in_package() to encode CPUID[4]. (Yanan)
>  * Add the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
>    (Yanan)
>  * Rename the "INVALID" level to "CPU_TOPO_LEVEL_UNKNOW". (Yanan)
> 
> ---
> Zhao Liu (10):
>   i386: Fix comment style in topology.h
>   tests: Rename test-x86-cpuid.c to test-x86-topo.c
>   i386/cpu: Fix i/d-cache topology to core level for Intel CPU
>   i386/cpu: Use APIC ID offset to encode cache topo in CPUID[4]
>   i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
>   i386: Add cache topology info in CPUCacheInfo
>   i386: Use CPUCacheInfo.share_level to encode CPUID[4]
>   i386: Fix NumSharingCache for CPUID[0x8000001D].EAX[bits 25:14]
>   i386: Use CPUCacheInfo.share_level to encode
>     CPUID[0x8000001D].EAX[bits 25:14]
>   i386: Add new property to control L2 cache topo in CPUID.04H
> 
> Zhuocheng Ding (7):
>   softmmu: Fix CPUSTATE.nr_cores' calculation
>   i386: Introduce module-level cpu topology to CPUX86State
>   i386: Support modules_per_die in X86CPUTopoInfo
>   i386: Support module_id in X86CPUTopoIDs
>   i386/cpu: Introduce cluster-id to X86CPU
>   tests: Add test case of APIC ID for module level parsing
>   hw/i386/pc: Support smp.clusters for x86 PC machine
> 
>  MAINTAINERS                                   |   2 +-
>  hw/i386/pc.c                                  |   1 +
>  hw/i386/x86.c                                 |  49 +++++-
>  include/hw/core/cpu.h                         |   2 +-
>  include/hw/i386/topology.h                    |  68 +++++---
>  qemu-options.hx                               |  10 +-
>  softmmu/cpus.c                                |   2 +-
>  target/i386/cpu.c                             | 158 ++++++++++++++----
>  target/i386/cpu.h                             |  25 +++
>  tests/unit/meson.build                        |   4 +-
>  .../{test-x86-cpuid.c => test-x86-topo.c}     |  58 ++++---
>  11 files changed, 280 insertions(+), 99 deletions(-)
>  rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (73%)
> 

-- 
Thanks
Babu Moger

