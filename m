Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D378D573
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJ7t-0006VR-Jz; Wed, 30 Aug 2023 07:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qbJ7s-0006V0-73
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:12:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qbJ7p-0004HE-0m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:12:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37UAp2og020328
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pHhKoErxIv8626/W5wGvY4SFoNd3XT18IQgFV2uM+W4=;
 b=NzTuSs+VJQ9nXQfo4UL+gQs6dkY7FUZhkJdh2qL5Fs3DERRruTqhNulLOjMsv63dnyWn
 XOYVlQPti1o1JVPL08MQLdf2rdiBQGCvxOekqEYSDHsjvdxLWm2IRgXBcRKHrvE3+A9k
 l0HsIQBOoJ5MOFEeYLiND8X5X5e8/YUtOKwsUnKYkWn2z5hhpLocG95bhI4pCV89PY1v
 DqMc/hNPCHb0Tx8pZur2TK9SkYVI9g9fpOq5I7zHkjUxwUbVCkVV/M/Bt0UNFoROE7TY
 Lq6wqaxWi2sHhRJxZ2sQ4peVcGjy3sSoSzrvohAXN6n1UwX46Nr39OAUmOYm8m4LURge xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssjvb26fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:12:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UBCa42020660
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:12:36 GMT
Received: from [10.111.129.169] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 30 Aug
 2023 04:12:36 -0700
Message-ID: <032f5478-edde-b47a-5753-d503886d42ca@quicinc.com>
Date: Wed, 30 Aug 2023 13:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] virtio-gpu-virgl: teach it to get the QEMU EGL
 display
Content-Language: en-US
To: <qemu-devel@nongnu.org>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
 <20230606115658.677673-18-marcandre.lureau@redhat.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20230606115658.677673-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: tTssOBp728R37St6mxZ3s2EqH29OFaDW
X-Proofpoint-GUID: tTssOBp728R37St6mxZ3s2EqH29OFaDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Marc-André,

I've been testing this, but I can't find where qemu_egl_display is set 
when using sdl.

Whil ui/gtk.c sets that in gl_area_realize, from my understanding there 
is no equivalent call in ui/sdl2-gl.c

Also, in which case SDL would use EGL, and is there a way to request 
that (e.g. as opposed to GLX)?

Kind regards,
Antonio Caggiano

On 06/06/2023 13:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virgl offers a few features that require to have access to the
> underlying EGLDisplay. This is the case for the D3D texture sharing support.
> 
> The API callback is merged for virgl 1.0:
> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1113
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 1c47603d40..9831c482e5 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -18,9 +18,17 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-gpu.h"
>   
> +#include "ui/egl-helpers.h"
> +
>   #include <virglrenderer.h>
>   
> -static struct virgl_renderer_callbacks virtio_gpu_3d_cbs;
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
> +static void *
> +virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
> +{
> +    return qemu_egl_display;
> +}
> +#endif
>   
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
> @@ -608,6 +616,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>   {
>       int ret;
>   
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
> +    if (qemu_egl_display) {
> +        virtio_gpu_3d_cbs.version = 4;
> +        virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
> +    }
> +#endif
> +
>       ret = virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
>       if (ret != 0) {
>           error_report("virgl could not be initialized: %d", ret);

