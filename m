Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C57F78C1
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:17:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Yrs-0006o7-9r; Fri, 24 Nov 2023 11:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r6Yrp-0006mE-Vp; Fri, 24 Nov 2023 11:17:22 -0500
Received: from mail-bn7nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::614]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r6Yrm-0002Pu-TO; Fri, 24 Nov 2023 11:17:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd8QlZQC5DErB9JogD21f1RNyX7Lb0NKNpdA6Nmy1WebiRHDRGVU11vWXuhp1b4SQc2XA9n4AZurTIUifHBHSSpkEcw2FPAbUDPvRFcLTaYNRdnxtTKF+LVetkx9BRxlbfU9pgoeVn3CCkoICG+wOTuO18ad0sPBgCNXwaPdSDDtWHIoBTMEY+hs4qn3SEwhPvG2p1GgeGMErU+iEYZ4AeSfaM8h29u//ec2nkaOYdj6Cgv5i+UnetVrsZak4ppzqfHDt6WB4iNjrsiiE0hOfyt/+JE7wFnRPntk49EfxZ4oWbm1Z41sRvStjR8/+aUJ6Eye67+5CkaJEDzVH74CNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiWEPUTw8RAJfz42vj5dRyOCNa0rvwjoJgzDPny6EvQ=;
 b=WM5eKYqLNWQhJorzIaIJidDyzrfZ70eT2zy0ayCHxA3zOGTUXPelB1zKojpmYQe2uJxTE3bFrtjJeaXvXri3Hat7OyQWgeYBXEJfLDIZgyw9relDAfLIQUpXYuBz4/ZXd0J4cKrsZBds22SiEw/Wm8l4NpfHTHQg4JiTiXDCncaVjqtl1WZ69DmHMb8LK00Ag2RQniNAfDwZoKvF7V6TfMgRuT3ry9FE8z2Na01fGURhg47plWQzFrg/ktPkiKNA5tYRJSrhrM8Gpc7Tcm4IbSem42oIC7n26xgscSK/4aPa9c82oOvVwoZi/Ms5qyql2Yw9tU7b2k0rO5ddgxwx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiWEPUTw8RAJfz42vj5dRyOCNa0rvwjoJgzDPny6EvQ=;
 b=GJ8Dy4HM4mQMFhiSRtaqY4LtUevO34EvSARXS/1aHTRTCtY+VBnIG/GTTuBz9fPtRk+a825V8W+lMYdEGwN8viY1qZayUBU7U8tIhZsAwX24wBZml6cJx0ddM8tFf+E50CAcvCOVb6tfW6Eqs24R+btXdxtykbmgZP4+SyiGVkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 16:17:12 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 16:17:12 +0000
Message-ID: <38686d55-552f-4312-8c30-e76942553a5f@amd.com>
Date: Fri, 24 Nov 2023 17:17:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] fix some url for amd / xilinx models
Content-Language: en-US
To: Frederic Konrad <fkonrad@amd.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, luc.michel@amd.com
References: <20231124143505.1493184-1-fkonrad@amd.com>
 <20231124143505.1493184-3-fkonrad@amd.com>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <20231124143505.1493184-3-fkonrad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0031.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a640b1-7842-49a2-cd4c-08dbed08d0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+0K40L6auyKQxDCPqzFXAa/YEuXXzmydQWjaukq+7E3Q81L93/94xtWmN3NFhUNhiBXdxM/4Db5NYz+WV+Q/mkLiIHFZ0oNhETqGHWheFsieFFSbl1OiqOeZObwCsSNIz/tbRJJUtDn/if5iVSnstEg9PMnxWgMAUOlCFFr1FoOcFhwxEW/rwUWZhFmtbb2C7xXwSmRy3GZZbui52NpG2PDgQ5eJieS9HrKkMFqcQMJ+REx1TNGuMmpt3mp2On0DeU4oidv2A3ZU4zcfKksSuGvsJBk7MoxFMJ693MkeAD9D1klLOiohhUTHeYoUiqjnBC66OhJPgKIBChB8P7iWwuaG8zJjvzUodVgxiXGySfzVDAzqemkK1bUOc8iXijB+v4WFb2puQWZyYAp5IHVGd4UzJbzgCOC1Yv+/2XRZ5y0QI+XMUI1vMX4slA29ItEvnqhxjcb2yPiKIokBfE85c6fgDnKCqBbZyaLIKvZsK8wZhyKUO8QOHuiziIwTDZ3KnaB+jjXESYAzzzx3dcwzri+6KNXEDoPONLRkJls6sV1u4PrfT14ABmGwFOkOSk/jTUwN0KQGPjwyrnhRAxZPLM3ETwWpLSm19qM0NHtE8HYG31M06FJ2JIBwvn2P66tKKz0K4AFhDa/aoivFX+rqflEvMl2XPZTO2B4YnHqVqhlsSdL0tIr417TjTec4tWYCj6viSOuykYjJ2rJkuNV0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(36756003)(4001150100001)(2906002)(44832011)(31696002)(86362001)(5660300002)(6512007)(6666004)(53546011)(6506007)(26005)(2616005)(83380400001)(478600001)(966005)(6486002)(38100700002)(8936002)(316002)(66946007)(66556008)(66476007)(31686004)(4326008)(8676002)(170073001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xYLzltVmFZRnFic0VpeWdabFc3cUxMTGdKazVic0thdGhpOGxNcEtrYzJY?=
 =?utf-8?B?cmpwc01OQWRwY1EwMTJoenh3UkJqS0JPQmp0enYwS1pnaWdJZGkraVBJN05k?=
 =?utf-8?B?MklWRUkvMHl5YXMzUEpDWGFDTTBCcXRYd3puMi9mRzZOMHIrcXA5M1BNb2tC?=
 =?utf-8?B?YVVmVHZwcjRmd1dMRHZjdUUvWnlxT0c5RTVoWVBkUXFkZmZPK3N1d0N2VzB3?=
 =?utf-8?B?cVVJZFpZUDBWOFcxUTBEU0hiNzIxSTlISm51T1FJSW5iQlcwMjFhVGVZMHBN?=
 =?utf-8?B?RjdtQUVoY051V3Q1Tm9Qams4MFVZbFFjZGhjMUdtb3V5SDRkd2F3OUhRWTQ0?=
 =?utf-8?B?d1liT0RjLy9wWmNhSklvNWw1VVhTaDNJS2RLRjZKbnhCdGhsQlJ2bjdPbEkw?=
 =?utf-8?B?WlJDQkRWbVVQTnhueWFBNE1VVS9BV2l0c3BxZXRvSy9KMjJodnV0NVJqTGJM?=
 =?utf-8?B?K0J5L2NNTkhDVUVVd3NDQXRLSXRpemI0QWhuaml0azBiZnZVZDUrZkpBSWZt?=
 =?utf-8?B?MHQ4azhiYjRHZXo0ekJmRm1HUm1rQ3ZWQW1GdE85RE93NzYxVzdwaUl6LzlD?=
 =?utf-8?B?azZwV1B1Y1dPR0UrZWVoMmh2QTE3ZWh1QTZieVdJM3FVMjJ3RnV3K1VUU0dO?=
 =?utf-8?B?SDZQRVFCbDBXcDhDUU11UHEwSXlydndqRy9rYXY5dUNHRGNtR0ZRZEF1K1BX?=
 =?utf-8?B?OFE4L0x2VlJHSHh5aXlwckdzQTdWTG5SeFl6czZUaWVJOVVVYmpqQUZwRUtz?=
 =?utf-8?B?VEVzVUxnVHExWEtnQzlXcEpuTkNrMVpoTEYydlkrOTRqNVJPaHloYWgvQkRy?=
 =?utf-8?B?KytOZUFJYmRwRDUzc0RyRnNSK3BmVzJDcy93SFVIN0RaZE9JNU1nN2JXeW9s?=
 =?utf-8?B?N29CV3pqMXZjSng4azJGOFJ0RGJHa0xyZytQUTEzYWI3a1o2NVhlbHRtZ1dt?=
 =?utf-8?B?Z3ZwOVA1VHNObnk3ZlAzekczc1Y3S056c3NSV0VxZk5wa1MvUFFZYlU5d2NT?=
 =?utf-8?B?a2o2ZXlBMy9sZkhpdGxrMmlYai93czVZWEZIcWtjV2dQT3A5Y2JCbFB4SUV4?=
 =?utf-8?B?dkp6LzVBN2FGOSsyc1lkOWxNdU8wdVU4YkJleHdLbS83K3V5VWNMbldqRGl1?=
 =?utf-8?B?TTJLd0VZYTFIeHdqMmZ6ckJ1cWdtVWtTcXFqWU00NitoMktNQ28vSDdiOStD?=
 =?utf-8?B?Z2tJTS9GNzluWGovNFEyNjBSSmZ5Uk1UMFNVVVhCMUtsVHN3Vjg2V05mMld6?=
 =?utf-8?B?UkhpSGlaZ1JhRnhkTzJLSVhmRlZUWkcwVWhjemlGMkRRNndmYjI2RGRJQkFF?=
 =?utf-8?B?eVlKTjRtSVBtSGtEOGNZUEhKUXpWMythNCt0eG1NajdtbFhObDNCd0RHWkd3?=
 =?utf-8?B?ZHZBN01xWTVwNHgzL25aN1ljcUVpMmZGTTlscFZqeHpPdWkyMm8wQldXbmZ2?=
 =?utf-8?B?ZlpjNkM3d3JVWEFtUG81QWRhVkV1Y3BvaTk1SEgrVFRxcDJ1b0dlTDRXOHFm?=
 =?utf-8?B?SzI0cTlBNWVTaEpaTHFReElDRWZQSlYvUnFsN3VCc2FCc2gvZnJTdFdUUzRl?=
 =?utf-8?B?WWQzcXo2WEZVS0NQMVFSdmFBck1xcDloSC95bnB1R1M4TENmemd6QllzNTJ1?=
 =?utf-8?B?QW05STRqWllzSFpSUWY3SUVRTVVFeVRTd2FXbWVITktSNlBWMTltcEVWbTFJ?=
 =?utf-8?B?bjdzYVZURW14alIvYm44RkwvVWJwazQwMTBZeWwvVU5tY3hNTS96Vk8zVHd4?=
 =?utf-8?B?ZU1JZnhpZm1scldiM01uWm5qMlNNSGFidmdJZkZDQjNnc0JINzJ5R2xRd3dx?=
 =?utf-8?B?d1lEQVAyZnVjaURuY1ljTkYybTF4amNlaldBWUliM0xPMm8wd0s4Z3VTUVZ3?=
 =?utf-8?B?QlJ6RlhKeHVxZC94Y0FtLzV2amNybmNUYzArS3VqbWo3TG1wTjdLVXBoRU1q?=
 =?utf-8?B?ZDRROFlnRGZZa0h4QkpJQjA4TURJUVZZVzFxT1dhOEpUbi81THlTN29NTlp1?=
 =?utf-8?B?TWtyK2tUbURCOUI4WkYyOTJYV3haV0Y2MEFrRStWcmliRm1ubnd5eDNvc2F6?=
 =?utf-8?B?S1hVMnZTRFRRVGVBMm9FK2prMkpVcjBpQno3Q2YzMFluVWwwaUVpSGcvQ2Nh?=
 =?utf-8?Q?wIA6rl1TNnt46W8lIpxaZnCwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a640b1-7842-49a2-cd4c-08dbed08d0b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 16:17:12.2435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AAqJwiNlblu/u2DxeJl/1iPRxWtoZ/ZOWtDt4ZT3y3encnhUiDK57CmzuB/++ghXuLgkHS00JRhFHpZDdi8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::614;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
> It seems that the url changed a bit, and it triggers an error.  Fix the URLs so
> the documentation can be reached again.
> 
> Signed-off-by: Frederic Konrad <fkonrad@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>   hw/dma/xlnx_csu_dma.c                      | 2 +-
>   include/hw/misc/xlnx-versal-cframe-reg.h   | 2 +-
>   include/hw/misc/xlnx-versal-cfu.h          | 2 +-
>   include/hw/misc/xlnx-versal-pmc-iou-slcr.h | 2 +-
>   include/hw/ssi/xlnx-versal-ospi.h          | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
> index e89089821a..531013f35a 100644
> --- a/hw/dma/xlnx_csu_dma.c
> +++ b/hw/dma/xlnx_csu_dma.c
> @@ -33,7 +33,7 @@
>   
>   /*
>    * Ref: UG1087 (v1.7) February 8, 2019
> - * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers.html
> + * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers
>    * CSUDMA Module section
>    */
>   REG32(ADDR, 0x0)
> diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
> index a14fbd7fe4..0091505246 100644
> --- a/include/hw/misc/xlnx-versal-cframe-reg.h
> +++ b/include/hw/misc/xlnx-versal-cframe-reg.h
> @@ -12,7 +12,7 @@
>    *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
>    *
>    * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/CFRAME_REG-Module
>    */
>   #ifndef HW_MISC_XLNX_VERSAL_CFRAME_REG_H
>   #define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
> diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
> index 86fb841053..be62bab8c8 100644
> --- a/include/hw/misc/xlnx-versal-cfu.h
> +++ b/include/hw/misc/xlnx-versal-cfu.h
> @@ -12,7 +12,7 @@
>    *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
>    *
>    * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/CFU_CSR-Module
>    */
>   #ifndef HW_MISC_XLNX_VERSAL_CFU_APB_H
>   #define HW_MISC_XLNX_VERSAL_CFU_APB_H
> diff --git a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
> index f7d24c93c4..0c4a4fd66d 100644
> --- a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
> +++ b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
> @@ -34,7 +34,7 @@
>    *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
>    *
>    * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-register-reference.html#mod___pmc_iop_slcr.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/PMC_IOP_SLCR-Module
>    *
>    * QEMU interface:
>    * + sysbus MMIO region 0: MemoryRegion for the device's registers
> diff --git a/include/hw/ssi/xlnx-versal-ospi.h b/include/hw/ssi/xlnx-versal-ospi.h
> index 5d131d351d..4ac975aa2f 100644
> --- a/include/hw/ssi/xlnx-versal-ospi.h
> +++ b/include/hw/ssi/xlnx-versal-ospi.h
> @@ -34,7 +34,7 @@
>    *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
>    *
>    * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-register-reference.html#mod___ospi.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/OSPI-Module
>    *
>    *
>    * QEMU interface:

