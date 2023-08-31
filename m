Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288978EA54
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbf6b-0001b0-8Z; Thu, 31 Aug 2023 06:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qbf6Z-0001ao-1N
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:40:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qbf6J-0003F1-GY
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:40:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VAPWlS029502; Thu, 31 Aug 2023 10:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=znF0BF1kUSuueMdP2rNueLOh4tYw4WJJ9faw+zW9ezE=;
 b=ELQ9F/3ZU0zebAto+M91FILiBhz/DQXgs5NK032d7uTi7rI/0PAJVoCP9YYtYpaKkag9
 NHdp3y0kTUMyStycA0deIeSIJyylGiRugrZoFY8zicKsIzFaMpcwcc9hgT+6ESNiM3GC
 KXnCnTf8IF/bwaxq9IIgcrknWCfwBOU7i84qQTWnp+o+3KWyG7fr272KGlHOGF3jR3jG
 bqZU3/tabQx3cxvQ4vX5zeyvmMM6VaKNk7rzw4sK9SLlxxhZv2gi4OIPKalnkU4OIOLN
 ptOlrfISRvBhuEsWoXtXu/dpiHOK8oj4dv6yh8BynsXLol1+dQtMbR3oSUbkEcg0IMnk zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st6cta50c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 10:40:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VAeJ2U026136
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 10:40:19 GMT
Received: from [10.111.142.103] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 31 Aug
 2023 03:40:13 -0700
Message-ID: <ca8bcf9a-2886-aed0-5229-4787808bd39c@quicinc.com>
Date: Thu, 31 Aug 2023 12:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 12/13] virtio-gpu: Initialize Venus
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Gurchetan Singh
 <gurchetansingh@chromium.org>, <ernunes@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Honglei
 Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>, Chen
 Jiqian <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-13-ray.huang@amd.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20230831093252.2461282-13-ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: IyA5KR4iV1dHZO-i5Zd2-Cub9Bp8YLb6
X-Proofpoint-ORIG-GUID: IyA5KR4iV1dHZO-i5Zd2-Cub9Bp8YLb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=961
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Huang,

Thank you for pushing this forward!

On 31/08/2023 11:32, Huang Rui wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Request Venus when initializing VirGL.
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> v1->v2:
>      - Rebase to latest version
> 
>   hw/display/virtio-gpu-virgl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 83cd8c8fd0..c5a62665bd 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -887,6 +887,8 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       }
>   #endif
>   
> +    flags |= VIRGL_RENDERER_VENUS;
> +

VIRGL_RENDERER_VENUS is a symbol only available from virglrenderer 0.9.1 
[0] and only if VIRGL_RENDERER_UNSTABLE_APIS is defined.

Luckily for us, VIRGL_RENDERER_UNSTABLE_APIS is defined unconditionally 
from virglrenderer 0.9.0 [1], so we could check for that in qemu/meson.build

e.g.


   if virgl.version().version_compare('>= 0.9.0')
     message('Enabling virglrenderer unstable APIs')
     virgl = declare_dependency(compile_args: 
'-DVIRGL_RENDERER_UNSTABLE_APIS',
                                dependencies: virgl)
   endif


Also, while testing this with various versions of virglrenderer, I 
realized there are no guarantees for Venus backend to be available in 
the linked library. Virglrenderer should be built with 
-Dvenus_experimental=true, and if that is not the case, the following 
virgl_renderer_init would fail for previous versions of virglrenderer or 
in case it has not been built with venus support.

I would suggest another approach for that which tries initializing Venus 
only if VIRGL_RENDERER_VENUS is actually defined. Then, if it fails 
cause virglrenderer has not been built with venus support, try again 
falling back to virgl only.

e.g.

#ifdef VIRGL_RENDERER_VENUS
     ret = virgl_renderer_init(g, VIRGL_RENDERER_VENUS, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         warn_report("Failed to initialize virglrenderer with venus: 
%d", ret);
         warn_report("Falling back to virgl only");
         ret = virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
     }
#else
     ret = virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
#endif


>       ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>       if (ret != 0) {
>           error_report("virgl could not be initialized: %d", ret);

[0] 
https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/6c31f85330bb4c5aba8b82eba606971e598c6e25
[1] 
https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/491afdc42a49ec6a1b8d7cbc5c97360229002d41

Best regards,
Antonio Caggiano

