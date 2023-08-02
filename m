Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AB76DAED
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 00:46:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKaK-0000HY-5e; Wed, 02 Aug 2023 18:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRKaI-0000HK-9L
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:44:50 -0400
Received: from mail-mw2nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::631]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRKaF-0006eA-HV
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b97uVu0bFEu8hw1t1UpPBs6aRo68gtVPcNOa4L17vNGFjvgvnJORP+RNFt7HwhSyxE9NbYwCO+cgqicWfyv4XBwrg4q6xJgOhlqs9titD+2InJ8VAcVy6Nc+0ej48tkrfnYP8CDaUSEimgEeqo/7l8jQFp/2giy546AOzlXFnDEHjVbpQvv8Sze5YBPZbT909MeaDLv+gmp15+x/CDE4oG/IRJ7cmoUeWY8gq1U0bevvp2rtF+Esmlmaq81dnv3PY6gbVrAFEVWeR6K+avignWFso14Lwu3h4hjC0tJNHU3n9VUvpLbH30uvPmAINOdufIvWvdcgbVxIGTpnjanqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PjBDldfbaQBS9k9faMhqS7kDWms3PRR3VQniwxGkA4=;
 b=Ido99u92ahkbj197DPr6ZaZf/j9hPqIG1mrLvQazrY31AnPbz62go4BxLqpqEAcK7ukR1+Os7PpziUauAHT5GIXF504Bfq3LqK2G0Wca1gXcixJS3mFq2LL/HfqEuYU9SSDg2rVh5InyC1OomDce+a5aZ0TCDV7Otf1bKnVRoJNufBvBnElLv/ezh2d3mfpMJ9o16gqFF6j0L1oN9Ykem3v3vLtUDIGYmvo+Z7ulLx5kgE1TT+D1jfHKSex5YskcdU7xlYWPkwEPYPWAxdgXw0t/4J8OIfm8UJxdWZbD/RiqrHVTGJQS2Tky8bQvhZXuhCdsP0xfGg8stlSx0RKGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PjBDldfbaQBS9k9faMhqS7kDWms3PRR3VQniwxGkA4=;
 b=zUfONAT7Z3/SizQ6G+UBfvncycAOvmadR/xc+g5pLC9hJY4Ks54yEz8LZstjnXu6xFsH3fNqaKBoRUJro6MgJzfqLa1rKAV4/Ydo3cQ+OS3xBwcYMP4Q4H0Pjyx19QZUE2RNYIBaYPYiEkgLhbOZhf3UJ/iLIqZYkaHVExm9Hrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 22:44:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 22:44:41 +0000
Message-ID: <b7adedcb-e3c8-98b5-6650-91a70790d183@amd.com>
Date: Wed, 2 Aug 2023 17:44:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/17] i386/cpu: Introduce cluster-id to X86CPU
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-11-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-11-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0153.namprd02.prod.outlook.com
 (2603:10b6:5:332::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: ad680021-e5fd-42d3-64be-08db93aa0eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjkHDOi+gV6HWn0kMu5TWRrMLdkr5yFhZcMX7Mh8jUS/K4iZbz+9FwopBeV+Y1Px+HIHbY/L49CvlRFQXOk4Y2HROTanH0BidlpCW2rpH+v4DDjmYy1/MtbN2Exr47HPz7zgg5CDvWHX43b2ni1EIRLyAQX6W1j6zty/AadIxeT+vyq0Ge8Qn7sfIR3DCGKQlVuZM5WBdk3UFXXrEvmWP4A/95enLcc6LpdP7iS2T3gJpU/COr0DeDdENxxfMnwWDO6GYf9IHttpw4IUZdgGWBBwfXXpn0ZntiHhqYgm6MWxmNFzI44EXtVxfpnT9W0EamviSPWz6BTnzAlWGVFU9zGR9OMxzM8/kgONA2RV1e2J8oY6N32hvcfEa0YsYNBSzN3GFzHAt363DI7ByJDUZ6KzUnwoEQQsHGR4G7T7H/qSvtpEgOZAFeLzCM9mxp5YcrCa5R4fPokkce9AJ7VTWj9n7WpkkIK4fNjiVaDN+eFI6RjK27Jfez1UuZCD3ZMhE5XQbadB1hp8zU0LuW6SRNj/EXP+jDuci0qtS+5eeFW+4uQ1MzuhqiLcyGEqI9UxA/XNY9wzTTRHghve8MwoW2BsM1dkM2MD0PRC6kesu/aN3Hc1tqYLNcyDZSC4kcZo2Ckz143k7NVwGhqRyB9xRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(3450700001)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(7416002)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(110136005)(54906003)(38100700002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxjclp0UHdxTTdQQ3UrMEw2dndoeTdiakY0VmtWQXF4aG1HMVd1VGlIZGJU?=
 =?utf-8?B?Q2dxeEV4bStFWjhHVEZlNEo2V1ZQWUg0aUVVcnZhZ0s2eWlCRkxTRk9Qa3pu?=
 =?utf-8?B?THdVVzg2SkVNWTYzSEQ1NFdkY0J6a0R6ZUdyZDBvSFJEbmllenZUcVdtR1Bt?=
 =?utf-8?B?TDZKZnpTOUZSK1JxbU9LRXYrYmFzbHN4cDhoV201azVibnJjS254aC9meURh?=
 =?utf-8?B?clkxV1ZFMHFYQ3NIZVlXNlMvMkMrUzJoZWRTL2JmU0RZNklCMm9rS2ZMQld5?=
 =?utf-8?B?Q2pMR2lrbVZmM0g5K1Z6RXQzZnNZaS9NdmRLSmZRZlFwWU9nZm9iSTN1dGg0?=
 =?utf-8?B?dmNJQklUbGRIV2p0NDg0TyszbG9pRndmUDgrVTFwNThDeTJtS1Nqa2l6eEsx?=
 =?utf-8?B?REdJZFJPenRMMDFGR3diMjBtc0ltQUFkQjVtWFduZzJrTCt1SEphQnhncmpR?=
 =?utf-8?B?L2szMlIzTDJhSUpqMC81dG4wSDZmckRIZzZ5VUU4dm9kaW5EUS9XY3M0UzA2?=
 =?utf-8?B?bnZGakZIYzZ3czkwTzJ4Vzd2dndOWFdlQnpkc3pLYUVPWk4vc29tWnZGdXlV?=
 =?utf-8?B?akdjRXNLUVV3Mk9Nako5eURIQ0hhOWJZS2tjY0NINk0rcDFKRjdSYnIwMmM0?=
 =?utf-8?B?TGFmWmRPdGJ5R3JJalZVR2ZCRldZa0JvSU5idXRtemFva0wrR0hoKzZsY3JX?=
 =?utf-8?B?cDNjTWpHdmtLVHBpdEpoZThOUWZPalF2VWdma2ZZZjY1cnBQWm5pYmo4OTJ2?=
 =?utf-8?B?eU43bEh1dmRJQmpoQ0FVRnhaNGk4bkplTE4wNzBFTittcGw1MTN1a2JKQm9S?=
 =?utf-8?B?K2hiYmQyOERsbzFlWUhycnZHVFd1MVF0WDlYK1JFWnovRmhtc1FIR1IyTFRU?=
 =?utf-8?B?bWt4VGVGeE9kSGNvMWtSZDkwMnlNYnA1UHE2YXR4Q0VmQXNOdEtqVS9lRWRm?=
 =?utf-8?B?VzdKUytTbDJmK0JRdW5TUTRycFIwSE0zZmVKT2JpamxEZzFmbWNBaytNd1hJ?=
 =?utf-8?B?MFNPWnN2ZEFuVmp2WHNxc01QMmJEcGNsaHp2aHNDODI1STZ6bEFMNkhNRGNl?=
 =?utf-8?B?NUg4VDd1SlFrRGhaaGVqSUlZLzl2UDc0NVJCQTBOWGcxbmMrMEJrU2hhTk0w?=
 =?utf-8?B?K29lcDkrQ09YOFFqVDB0RlFYS05qOGt3N2MrbG5QNVpnb1BpbmJNYzZZbnEy?=
 =?utf-8?B?V0FCVHhaTXN4VmYvN3RUWjhWZ1JleUdzZ0JoejdUd1JZRGdpZDVOYUJwelVF?=
 =?utf-8?B?K1lVZmhnT3JHR3BuWHZYTmVGRElQbk8vUUgxMXF2RGt4ak1SeG9wa3JmNGpW?=
 =?utf-8?B?clg4bnpLcW1kdGJVNktlVkRiY241R3FTbjhoQiszbkl5YTVYU09sS25CcUxF?=
 =?utf-8?B?TVMrUGY2YkJKdExZdUZNOGJlditjZHYraHVubldIWEN0eGlXT3VRN25wNjJo?=
 =?utf-8?B?SEhWdDJ4Ty9JTVRETlR0dGRQTXRCYjViNkR6cE01b1d2QVF0cWxzT01BUXdy?=
 =?utf-8?B?Vmg3eHlzTTlUNVRMYytycFY3SmtYYURVekpTbktlRjVLdGUzc3R6TmlwV05n?=
 =?utf-8?B?L0JreTBMb1lNM1FmcjdOZjdzY0I0YmRGK08xU3J2NVd5RzVRVndrZFZOTVN1?=
 =?utf-8?B?cjlyZEZsUzRFNS9aUWo5YXQxQ1E2dTkzaVpLNXpEbFFZYUMyQjZWWWhuVkly?=
 =?utf-8?B?YUN1dDdNY1kzQnozVURJN2lWTHg1a0FSRHlrMWpGVHZQN3pITVpDUzhiM05u?=
 =?utf-8?B?YUtDN3N0Q05MOXkvaWU3VE5WUGNhMW1jNEd1RnBiZkRoKzlzQ0o1M3poOUJS?=
 =?utf-8?B?ek9XRENrbTVYczNsSE1tcnJhenIzd1QyRWh4VFF2VHBLTEI5b00yV25ncFFF?=
 =?utf-8?B?MmplYXZZcTZFaTVRakVncjhRdWQzdUh6enVuUEVKNWhCbmY0WTVTNEI5Q081?=
 =?utf-8?B?VmpXdSsvVmhCcDlkUElFWlQ1NGJnbFZheHdzTmZwN09tc0N2VHpsa010cE9M?=
 =?utf-8?B?Z1Q1a3NmcTlFMVlUOGhhNW42UzhnNURHTTkxUE4vNkxBWk5jb2RMODFDVDBx?=
 =?utf-8?B?V3FZSzJGUUUybEpLN3lmYllOSmVkNCtiUHZMMEtDU1h1dUhoZExZdStDMWJh?=
 =?utf-8?Q?B2p4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad680021-e5fd-42d3-64be-08db93aa0eea
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 22:44:40.9118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vaIl0Rarm+ojzXsXi21FAWtnS+MHxByXkhtWUjEHm+bq/wTSI1KeFXwMNFxdjvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::631;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhao,

On 8/1/23 05:35, Zhao Liu wrote:
> From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> 
> We introduce cluster-id other than module-id to be consistent with

s/We introduce/Introduce/

Thanks
Babu

> CpuInstanceProperties.cluster-id, and this avoids the confusion
> of parameter names when hotplugging.
> 
> Following the legacy smp check rules, also add the cluster_id validity
> into x86_cpu_pre_plug().
> 
> Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/x86.c     | 33 +++++++++++++++++++++++++--------
>  target/i386/cpu.c |  2 ++
>  target/i386/cpu.h |  1 +
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 0b460fd6074d..8154b86f95c7 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -328,6 +328,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>              cpu->die_id = 0;
>          }
>  
> +        /*
> +         * cluster-id was optional in QEMU 8.0 and older, so keep it optional
> +         * if there's only one cluster per die.
> +         */
> +        if (cpu->cluster_id < 0 && ms->smp.clusters == 1) {
> +            cpu->cluster_id = 0;
> +        }
> +
>          if (cpu->socket_id < 0) {
>              error_setg(errp, "CPU socket-id is not set");
>              return;
> @@ -344,6 +352,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                         cpu->die_id, ms->smp.dies - 1);
>              return;
>          }
> +        if (cpu->cluster_id < 0) {
> +            error_setg(errp, "CPU cluster-id is not set");
> +            return;
> +        } else if (cpu->cluster_id > ms->smp.clusters - 1) {
> +            error_setg(errp, "Invalid CPU cluster-id: %u must be in range 0:%u",
> +                       cpu->cluster_id, ms->smp.clusters - 1);
> +            return;
> +        }
>          if (cpu->core_id < 0) {
>              error_setg(errp, "CPU core-id is not set");
>              return;
> @@ -363,16 +379,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>          topo_ids.pkg_id = cpu->socket_id;
>          topo_ids.die_id = cpu->die_id;
> +        topo_ids.module_id = cpu->cluster_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> -
> -        /*
> -         * TODO: This is the temporary initialization for topo_ids.module_id to
> -         * avoid "maybe-uninitialized" compilation errors. Will remove when
> -         * X86CPU supports cluster_id.
> -         */
> -        topo_ids.module_id = 0;
> -
>          cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
>      }
>  
> @@ -419,6 +428,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      }
>      cpu->die_id = topo_ids.die_id;
>  
> +    if (cpu->cluster_id != -1 && cpu->cluster_id != topo_ids.module_id) {
> +        error_setg(errp, "property cluster-id: %u doesn't match set apic-id:"
> +            " 0x%x (cluster-id: %u)", cpu->cluster_id, cpu->apic_id,
> +            topo_ids.module_id);
> +        return;
> +    }
> +    cpu->cluster_id = topo_ids.module_id;
> +
>      if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
>          error_setg(errp, "property core-id: %u doesn't match set apic-id:"
>              " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d6969813ee02..ffa282219078 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7806,12 +7806,14 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
> +    DEFINE_PROP_INT32("cluster-id", X86CPU, cluster_id, 0),
>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
>  #else
>      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
> +    DEFINE_PROP_INT32("cluster-id", X86CPU, cluster_id, -1),
>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
>  #endif
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5e97d0b76574..d9577938ae04 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2034,6 +2034,7 @@ struct ArchCPU {
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      int32_t socket_id;
>      int32_t die_id;
> +    int32_t cluster_id;
>      int32_t core_id;
>      int32_t thread_id;
>  

-- 
Thanks
Babu Moger

