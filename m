Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68A7F78B3
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:15:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6YoD-0007a2-9g; Fri, 24 Nov 2023 11:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r6Yo4-0007Y3-3M; Fri, 24 Nov 2023 11:13:28 -0500
Received: from mail-bn8nam04on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::603]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r6Yo1-00017C-R8; Fri, 24 Nov 2023 11:13:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU37fSO5csXOe9YZk3xXKVHJCeSAhPuDBGvyrIRPUvXlLU7SkK86W9lHnFbUypbyni2e73rH2D6mc4oSeQNJT41d4Hcwb17IBz87yQBF0ZJatT4ANYRLqPhV8H2WGsCZ0i6qPNZg/AEWLsYXfd+J7YpGAH6b5iIRL+GO2p2o9D9Q9SeG8BcJe+rVFC8DD7HCFdD7cket0X3RPJTslbLhjeYZur8ICZu+8rZ2Jaw0NvNgPEBShgfqqA+2u7KnCkAwRi8ObTONfEc9ULAsocrWzM38S/9AAPeTq/44E1C6Tv0CXFW56Au7a9Wcz2swELSyV15KWJq+jowh4DK+eekKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me189aj4Ee8UnWlSfvvzcQXinbAaWolGSYrEMBxQ1G4=;
 b=PD6zGcvdj3wvre0WqC8fbWP9qvFYezBSyd0yxoATGljd8o9JPzHWRvgJcm5HoDVE/gwsJGgDE8+jRYu80+zQ6loG8trNd6syN1ulomRXe3rcEl6e59AepgLkrcHHr4np0Gjg6IroYb3kM+MCTSSl4giJ6V9nIEpuSiqAh8GLUaqI3/uOxnX+RVQ+3dvb0drDldzk0bYqgy+/CYAhNHEmrZ0M/Lxl3G6Uxj+upgI+BTkCAg6Y+hOHuZzecoSn+DghN1m802OdIWq4yuxiTTPgQTCxlD/AcBaJT3YHdaTjjfbujCS4D4qH5BD6ZH8m3BQ9zEzWrZcwkq5wJXiduKe1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me189aj4Ee8UnWlSfvvzcQXinbAaWolGSYrEMBxQ1G4=;
 b=YPVOnQNNelCnsW2YcuapFdNOvlQ2AygsJTNNmaw9IWlxriQb1i/rISdHZEIimU79F4f6ZRKELBS2UPecAWblruHdGbMlQ9zVwbTUvq44Aqgu4Nf7eZZKppt9kWl3h5XYN9gotBW0922oChsUig39lPNw/NKSJog+f/q0+7mI+DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 16:13:20 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 16:13:19 +0000
Message-ID: <55f8803a-39af-4298-ab81-bc806cd68f2d@amd.com>
Date: Fri, 24 Nov 2023 17:13:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/ssi/xilinx_spips: fix an out of bound access
Content-Language: en-US
To: Frederic Konrad <fkonrad@amd.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, luc.michel@amd.com
References: <20231124143505.1493184-1-fkonrad@amd.com>
 <20231124143505.1493184-2-fkonrad@amd.com>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <20231124143505.1493184-2-fkonrad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0224.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::10) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bda79a3-20c1-4fcb-34e4-08dbed0845a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hg1gd99dUhMTCcdqOl4oNLj8ApKOYbuoQQBPs5iQDbZMUXbx2afeAgL8f/2qZRfeAav1ImktemRiwI06smo2Mu13IiPqutRYIPl7jxXd1yL6ixpf9X10rnOrf5nHsdQN7Bs620TmyCJExhRpugb8KyrVhaunk9ogmqdCWIy6oLFPhO2EtYQMXvoyRJi5pOh6AtcajKukkBdJ7SrNXL0YyOtTCGkFjuN/dNW1YEOQIEs0KyeLN5vgSMunCVk2P4wWh4q1vDDfo3xrtxtV0oeK5uQ8c5S0oCwyEFEzRU37pwRXCYD8SjPTnUpluKI/JCa2bTdZ+TUbfIU8FfqxHmleo+eiZ8Qi88qnAkS2Xu7zkVWPlCLxBTWE4lhMCNOZkFbuPlfwdbRQTbrYyWKVvVjZAFbrkZKLefGJLCW7bTyZcoIMdSzi5xSKeJFeAWw/uVwK7P9jyTEC+tueMAh/3jewXqvkTR9sLJvhziI1T/sTfJKxQT4Hvq+pgR6kAqbSqGIqJ4qQpMpErFoMj5hOJ4o1cjmeijJH3phslLuWju4IhQyXU0ge/A9a00qVWopa3mbOZfJZG2W+DTbtcMc2OmaRUEJb/ARDRxVO9K0cLe7n7on8iaTv+ge23oBtlcOeudjrpZ5pfqxYW2VAPc0dqmBLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(38100700002)(86362001)(31696002)(36756003)(66556008)(66476007)(316002)(4326008)(8936002)(41300700001)(8676002)(5660300002)(4001150100001)(2906002)(44832011)(66946007)(31686004)(26005)(53546011)(6512007)(2616005)(478600001)(6666004)(6486002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdGVytpK21GaUVraEFPcVQ2NnlRc1Y0dUQ1WEM1ajRQbGlKM0R6T1lHeDZ0?=
 =?utf-8?B?MTRjVXY3UDRSUkpsQnBsKzdHZXlPQlZuejVyN1diWFZXTVBwMEcxa3l1Q2wr?=
 =?utf-8?B?OU5kaU9OMmQ0T3RkamNWeXlmUnRBeERDa3RCMStmeHpVTXNPQVBQa1NKSzdV?=
 =?utf-8?B?M0NlMG9yYXVBYnhIbVNvQ0l2Q1lCTHFiRzJNYmZOQUpNWkdCWlhvU045TFho?=
 =?utf-8?B?RmR5WFp1SzRDSkhpQnBscG85Z3hmRHh2MUdYS0RtOFJpQjRlUVNiN0NienRp?=
 =?utf-8?B?SE1nYk40ay8xbVhSY05ucVNGVDRhSkRDOFlJbzNHd1NzbE5mWkplT3VoemZK?=
 =?utf-8?B?bmZRdG9KZ0JPVkR6NWdiSW1mUlF4dXVrTHJ5Y2diQk0rWVNiTWEwZVlrMzRx?=
 =?utf-8?B?T0pGK092dDF1L1VkTjRueWc2Z25NdzNJdy9vVG9ydk9ydFpUU1NXc0duSE1u?=
 =?utf-8?B?UHZ6eFNxOXBXTUpJTkVFNlRKWGxrVkdnWDlVZyttbS9Wd3l2ZmNQdHEwUkN1?=
 =?utf-8?B?Y3pSYlZEYWZ0cXh2T291eDEvdmxLZmV5RGVnYWQvNmpuQVZYaFhmdE9LRXhO?=
 =?utf-8?B?dm9ZQ3Z6NUw4bWJKUW5TWW1OUHcrUFM1eGlNcHBMb1Y3L0Z3dGZPRlc4Mmg3?=
 =?utf-8?B?Qk1uT1pUU2w3bXFOUlNlM1FWb2hOMklSdTdGU1ZxeDRYeitBL3B2ZGdBZDZw?=
 =?utf-8?B?Uk5KQUFqa2pWSkRYNSsvV292LzBqaHFWa2hBWStmU3JYOW1KSlQ3N1V2Wjd2?=
 =?utf-8?B?Y1h3ZWpJcFdidzZNakZ6SFVFcDlEcVZBTHJlc2szUkxWS0MrTXdXSnRNSWk0?=
 =?utf-8?B?alVEeU5HN2Y0encrdFAwYWlnWnErUUx2QU0yaEIwQWQvWERDcGVNMmVPcjVZ?=
 =?utf-8?B?M2N2SlpBM21hMVZTWUV4c1VuUFJBOVBBemtKODZIM0dGdFpMQVZhWWZjN1Ni?=
 =?utf-8?B?NnI4a2dBN0hDZXpPcU5HQXI4eWtHTktqQUZPckZmTkRJcmlCWjhDT0F5UjBo?=
 =?utf-8?B?UDQ1WmJET2xYMVlraE1jbUtKdUlXRTJITE1ZZk94WHk1K01MVWVFV3pqMjhV?=
 =?utf-8?B?aHdnL3lqWTlrbk1iYmIyK2c3Rmc0VkFaTHJ4M01BU1NQUGt2Mzh4dHlIYlN6?=
 =?utf-8?B?YW8va3BJQzNUNFQxRVJ3TkJoWnUzckt0Z2VEUmRjM0tJek0zN2tJY0ZoTWZY?=
 =?utf-8?B?LzQxRXZUQUIrQVFnSzl5a0FoTnJCYkY1MTMvOUxaK21ZejRrWVNOb1BCWFE3?=
 =?utf-8?B?WnlFWkk3czd5NGxKaWpwYitGdDFPWmtYSWFVQy9aOFRtbEN4aHgrTWtNR0Zv?=
 =?utf-8?B?clc3VFlBcnN5T2trUWpJc3BIV0lvcVBOb3I2TkFObTYrV2k2bzJ5eElBcDVJ?=
 =?utf-8?B?OFhsYXF2VU9kbHM4cVNjaDRiQnNJYmlpbXA3WG0rOTV1eUxXcU9MUnRMZ0FD?=
 =?utf-8?B?aFRrZG9Gc2JoYkpaSXc4WW1FVkVlcmZ4VGdEWkpSSmVMT1JYZTNkWEJNcUtP?=
 =?utf-8?B?cjZrWWg5VlgwbFliVlFDekVpRWVHYURCUU1WRUlLV25zalhCbWdQSnhTTGM4?=
 =?utf-8?B?ZUdlbkZ2TUZrOGRPc3ZQUUhIckdOS29KQ0Mxd1dIUmVlbFJHblFkOFBOV25j?=
 =?utf-8?B?cnVyNEhuS1oxdDk5YkR4ZUpVZlBFNGNXZHpkYzd0RnBqTzcrTktPeEQyd1NG?=
 =?utf-8?B?WEt0VGkrejdmSGt3ZE9ScXVnWUVqNDdDYlp1ZjFOVWZNNmtlMTB4dWVvejBV?=
 =?utf-8?B?d2FabUJJTkM3RWVLVktCL2JwQ0U2anlLdWgvMlVpWEZKei9acE51UVBZaStH?=
 =?utf-8?B?citSWi9FKzB1bllwYzZ4MmdaMjRXdlgxN0xCeGdBMXVpa3BlMENwditHZGtD?=
 =?utf-8?B?VWEwOEhCYjZNOXVmNlhaendpcW80VnhLS05Tay9kdnFTbzIrUkdobUNOUlQv?=
 =?utf-8?B?S3o4U2ZMclhHNlFtUENXRUdZWFRHUGhVZERjVFA1bFM5TGF4OFluZ2pLZW56?=
 =?utf-8?B?LzFZdGRpVWdDUE1vdVZHaG04YVdEcFZNTHJTZnMyaCtZdVM4M05IYkQ1NkN5?=
 =?utf-8?B?UG0wdTdZdGNzZGJFZmYyYWxlYllCSlBFQjNHTml2WFRaelJUQkFramF4eE1X?=
 =?utf-8?Q?lugidGT5DfuaGP1qsKW5n022t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bda79a3-20c1-4fcb-34e4-08dbed0845a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 16:13:18.9751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW1Y+PpON2mvhVeSbnEB/zPfT2QxR0wwsufwzSokq8AX1rcgKr/A1aNrk6THR7UDjHEuaCQm3Dmqkkb+lKS6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::603;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 2023-11-24 15:35, Frederic Konrad wrote:
> The spips, qspips, and zynqmp-qspips share the same realize function
> (xilinx_spips_realize) and initialize their io memory region with different
> mmio_ops passed through the class.  The size of the memory region is set to
> the largest area (0x200 bytes for zynqmp-qspips) thus it is possible to write
> out of s->regs[addr] in xilinx_spips_write for spips and qspips.
> 
> This fixes that wrong behavior.
> 
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> Signed-off-by: Frederic Konrad <fkonrad@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>   hw/ssi/xilinx_spips.c         | 7 ++++++-
>   include/hw/ssi/xilinx_spips.h | 3 +++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a3955c6c50..0bdfad7e2e 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -973,6 +973,8 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>   
>       DB_PRINT_L(0, "addr=" HWADDR_FMT_plx " = %x\n", addr, (unsigned)value);
>       addr >>= 2;
> +    assert(addr < XLNX_SPIPS_R_MAX);
> +
>       switch (addr) {
>       case R_CONFIG:
>           mask = ~(R_CONFIG_RSVD | MAN_START_COM);
> @@ -1299,7 +1301,7 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
>       }
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), xsc->reg_ops, s,
> -                          "spi", XLNX_ZYNQMP_SPIPS_R_MAX * 4);
> +                          "spi", xsc->reg_size);
>       sysbus_init_mmio(sbd, &s->iomem);
>   
>       s->irqline = -1;
> @@ -1435,6 +1437,7 @@ static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
>   
>       dc->realize = xilinx_qspips_realize;
>       xsc->reg_ops = &qspips_ops;
> +    xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
>       xsc->rx_fifo_size = RXFF_A_Q;
>       xsc->tx_fifo_size = TXFF_A_Q;
>   }
> @@ -1450,6 +1453,7 @@ static void xilinx_spips_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_xilinx_spips;
>   
>       xsc->reg_ops = &spips_ops;
> +    xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
>       xsc->rx_fifo_size = RXFF_A;
>       xsc->tx_fifo_size = TXFF_A;
>   }
> @@ -1464,6 +1468,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
>       dc->vmsd = &vmstate_xlnx_zynqmp_qspips;
>       device_class_set_props(dc, xilinx_zynqmp_qspips_properties);
>       xsc->reg_ops = &xlnx_zynqmp_qspips_ops;
> +    xsc->reg_size = XLNX_ZYNQMP_SPIPS_R_MAX * 4;
>       xsc->rx_fifo_size = RXFF_A_Q;
>       xsc->tx_fifo_size = TXFF_A_Q;
>   }
> diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
> index 1386d5ac8f..7a754bf67a 100644
> --- a/include/hw/ssi/xilinx_spips.h
> +++ b/include/hw/ssi/xilinx_spips.h
> @@ -33,7 +33,9 @@
>   
>   typedef struct XilinxSPIPS XilinxSPIPS;
>   
> +/* For SPIPS, QSPIPS.  */
>   #define XLNX_SPIPS_R_MAX        (0x100 / 4)
> +/* For ZYNQMP_QSPIPS.  */
>   #define XLNX_ZYNQMP_SPIPS_R_MAX (0x200 / 4)
>   
>   /* Bite off 4k chunks at a time */
> @@ -125,6 +127,7 @@ struct XilinxSPIPSClass {
>       SysBusDeviceClass parent_class;
>   
>       const MemoryRegionOps *reg_ops;
> +    uint64_t reg_size;
>   
>       uint32_t rx_fifo_size;
>       uint32_t tx_fifo_size;

