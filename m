Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FD78893D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:57:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZXHb-0000ra-E3; Fri, 25 Aug 2023 09:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qZXHW-0000rL-CA
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:55:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qZXHS-00086b-Qg
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:55:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37PCG94w021171; Fri, 25 Aug 2023 13:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oACcyQfhzRkgYywQKT2dnrSI2d0b+HWKyCYm/rpWPFI=;
 b=h7DS17xOCGLtnxNfJGF3dPcATVu1HZrfz87Fl1KDQhAjCJXRqLXaxoRlvPu1TY2wx4+V
 6ZHUwXJfK5j8jKStif+hRPECkbt1dHtRtfUW67RR3jti7bhz9+k77XDuGHWp7+JbcXQV
 5t11rYJXBUHVxVZ4Ty8pxko4GxD/664mPGObNy0ZK/dc67XWMgnRs9U1z4EpzFmmXMrn
 36fi1rOK6PQl18DV3evOxVtCH0VZA5EP7362/g/2v+VgYjL+jMl5UmQWf4DLPnE2bMLi
 piIafuDr00zFopJs0HfPo2kMdyp8b8W0XxB5PzD2S5zn9/phaSknUPDZ5Df1SnQw7loM yA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmn6122s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Aug 2023 13:54:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PDsTbJ017519
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Aug 2023 13:54:29 GMT
Received: from [10.111.137.100] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 25 Aug
 2023 06:54:26 -0700
Message-ID: <f051c45d-5498-c34c-1a41-286af4dd4656@quicinc.com>
Date: Fri, 25 Aug 2023 15:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 8/9] gfxstream + rutabaga: enable rutabaga
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, <qemu-devel@nongnu.org>
CC: <marcandre.lureau@redhat.com>, <akihiko.odaki@gmail.com>,
 <ray.huang@amd.com>, <alex.bennee@linaro.org>, <shentey@gmail.com>,
 <hi@alyssa.is>, <ernunes@redhat.com>, <manos.pitsidianakis@linaro.org>,
 <philmd@linaro.org>, <mark.cave-ayland@ilande.co.uk>
References: <20230824234046.499-1-gurchetansingh@chromium.org>
 <20230824234046.499-9-gurchetansingh@chromium.org>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20230824234046.499-9-gurchetansingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: XnGwLCsBN_Uo1vkkldPYHhjxZ_a36e8z
X-Proofpoint-ORIG-GUID: XnGwLCsBN_Uo1vkkldPYHhjxZ_a36e8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_12,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250123
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

Hi Gurchetan,

Thank you for this series and for including some of my patches :)

On 25/08/2023 01:40, Gurchetan Singh wrote:
> This change enables rutabaga to receive virtio-gpu-3d hypercalls
> when it is active.
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> v3: Whitespace fix (Akihiko)
> v9: reorder virtio_gpu_have_udmabuf() after checking if rutabaga
>      is enabled to avoid spurious warnings (Akihiko)
> 
>   hw/display/virtio-gpu-base.c | 3 ++-
>   hw/display/virtio-gpu.c      | 5 +++--
>   softmmu/qdev-monitor.c       | 3 +++
>   softmmu/vl.c                 | 1 +
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 4f2b0ba1f3..50c5373b65 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -223,7 +223,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>   {
>       VirtIOGPUBase *g = VIRTIO_GPU_BASE(vdev);
>   
> -    if (virtio_gpu_virgl_enabled(g->conf)) {
> +    if (virtio_gpu_virgl_enabled(g->conf) ||
> +        virtio_gpu_rutabaga_enabled(g->conf)) {
>           features |= (1 << VIRTIO_GPU_F_VIRGL);
>       }
>       if (virtio_gpu_edid_enabled(g->conf)) {
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 3e658f1fef..fe094addef 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1361,8 +1361,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>   
>       if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> -        if (!virtio_gpu_have_udmabuf()) {
> -            error_setg(errp, "cannot enable blob resources without udmabuf");
> +        if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
> +            !virtio_gpu_have_udmabuf()) {
> +            error_setg(errp, "need rutabaga or udmabuf for blob resources");

Does that mean udmabuf is not required at all when using rutabaga?
How does rutabaga handle blob resources?

>               return;
>           }
>   
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index 74f4e41338..1b8005ae55 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -86,6 +86,9 @@ static const QDevAlias qdev_alias_table[] = {
>       { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
>       { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
>       { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
> +    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
> +      QEMU_ARCH_VIRTIO_MMIO },
> +    { "virtio-gpu-rutabaga-pci", "virtio-gpu-rutabaga", QEMU_ARCH_VIRTIO_PCI },
>       { "virtio-input-host-device", "virtio-input-host", QEMU_ARCH_VIRTIO_MMIO },
>       { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_VIRTIO_CCW },
>       { "virtio-input-host-pci", "virtio-input-host", QEMU_ARCH_VIRTIO_PCI },
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..2f98eefdf3 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -216,6 +216,7 @@ static struct {
>       { .driver = "ati-vga",              .flag = &default_vga       },
>       { .driver = "vhost-user-vga",       .flag = &default_vga       },
>       { .driver = "virtio-vga-gl",        .flag = &default_vga       },
> +    { .driver = "virtio-vga-rutabaga",  .flag = &default_vga       },
>   };
>   
>   static QemuOptsList qemu_rtc_opts = {

Patches 5 to 9:
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>

Cheers,
Antonio

