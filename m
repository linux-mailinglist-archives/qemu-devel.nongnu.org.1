Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A77099BB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:30:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q017S-0003ai-FM; Fri, 19 May 2023 10:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1q017O-0003Zw-Tm; Fri, 19 May 2023 10:30:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1q017N-0007um-1D; Fri, 19 May 2023 10:30:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34JD04b5023060; Fri, 19 May 2023 14:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uLhjUzQQt1+AApRcBY9d6rORrc/G51JhCn3qL3G2CJc=;
 b=RChCHAfAUmXf2hLTSC+GfDrRdq5ioWm7d09L95c8nwN9y8lAJ5CDL2SJh0Rl9DvNpSOx
 ++t2Ca7Pq2WVjiw5VFxD9+0CSI8EfESfB/M8ZCYebtR/ZM9Q35RePm7GQgzubr0A0hna
 9LaGg6q+EODsGX20fyspP3i3wUbf7aFaidMY0uB83XMqkFEXYzuDTFe57m1Re5QstQdB
 /AAKxj4/vU2Xt32bdVdc+GBexFmQ3Iq+b2Za3xIPBcudxe+JK/DtKaIt7vuhJQzMYyJ9
 LCoWGKe1KH9c0Os9PSbTVsDP2ys39fHUjp3Su3hzjQrqgFK+ws9PRTpNIn5XsxXldLji Dg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4ccrt74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 14:30:00 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JETOwa006006
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 14:29:24 GMT
Received: from [10.111.133.230] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 07:29:22 -0700
Message-ID: <1c322d4a-64f8-5c94-6f39-1bac8afb0fdd@quicinc.com>
Date: Fri, 19 May 2023 15:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] hw/arm/sbsa-ref: add GIC node into DT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20230517105303.453161-1-marcin.juszkiewicz@linaro.org>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <20230517105303.453161-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: TQ3XKVDzgqEroiK8oruGF9s0FTUne4JI
X-Proofpoint-ORIG-GUID: TQ3XKVDzgqEroiK8oruGF9s0FTUne4JI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190123
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023-05-17 11:53, Marcin Juszkiewicz wrote:
> Let add GIC information into DeviceTree as part of SBSA-REF versioning.
> 
> Trusted Firmware will read it and provide to next firmware level.
> 
> Bumps platform version to 0.1 one so we can check is node is present.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>

> ---
>   hw/arm/sbsa-ref.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 792371fdce..9204e8605f 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -29,6 +29,7 @@
>   #include "exec/hwaddr.h"
>   #include "kvm_arm.h"
>   #include "hw/arm/boot.h"
> +#include "hw/arm/fdt.h"
>   #include "hw/arm/smmuv3.h"
>   #include "hw/block/flash.h"
>   #include "hw/boards.h"
> @@ -168,6 +169,20 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>       return arm_cpu_mp_affinity(idx, clustersz);
>   }
>   
> +static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
> +{
> +    char *nodename;
> +
> +    nodename = g_strdup_printf("/intc");
> +    qemu_fdt_add_subnode(sms->fdt, nodename);
> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> +                                 2, sbsa_ref_memmap[SBSA_GIC_DIST].base,
> +                                 2, sbsa_ref_memmap[SBSA_GIC_DIST].size,
> +                                 2, sbsa_ref_memmap[SBSA_GIC_REDIST].base,
> +                                 2, sbsa_ref_memmap[SBSA_GIC_REDIST].size);
> +
> +    g_free(nodename);
> +}
>   /*
>    * Firmware on this machine only uses ACPI table to load OS, these limited
>    * device tree nodes are just to let firmware know the info which varies from
> @@ -204,7 +219,7 @@ static void create_fdt(SBSAMachineState *sms)
>        *                        fw compatibility.
>        */
>       qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
> -    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 0);
> +    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 1);
>   
>       if (ms->numa_state->have_numa_distance) {
>           int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
> @@ -260,6 +275,8 @@ static void create_fdt(SBSAMachineState *sms)
>   
>           g_free(nodename);
>       }
> +
> +    sbsa_fdt_add_gic_node(sms);
>   }
>   
>   #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)


