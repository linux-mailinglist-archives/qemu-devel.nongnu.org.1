Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3C818576
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 11:43:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFXYH-00016c-Vh; Tue, 19 Dec 2023 05:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierre-eric@damsy.net>)
 id 1rFXYG-00016U-BU
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 05:42:16 -0500
Received: from mail.damsy.net ([85.90.245.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierre-eric@damsy.net>)
 id 1rFXYE-0003bQ-Fi
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 05:42:16 -0500
Message-ID: <31891dcd-d72a-4d81-8bb1-579c6a8e6365@damsy.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damsy.net; s=201803;
 t=1702982523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3575rjkDpAj2qDIT9c9EXnf7PqaPnB51hWsSon8Voos=;
 b=bJd2yQAW9oaHXk5iTSIzLjsmuhJZxrxpEUIMh345UF3XZS3+xAsl1GPXy8Y6NAfwp1Pm7i
 YD4yTTxMEaDPJwhl4b5oSt7E6MR9zQUqhBaAaAWGLv8D6v65dtEdOMVt+LT9z0ER164xMq
 Pl5gqgbDRJxvJkBYmBNkbjZ3ZpvIKYJJAa6kZYU87GWTaUuYumbX/no+X5NWmd08+T1z07
 SLrCdWIBMP6sJRPVRt4CXgTsyN1lDL0Dz1jzkjcSt0Jae8eYQRB1zIeRkH7ORn7DrgQ9r4
 HdZq8cHOIX+y60mDkvkNCzmnzRGIl/800IOb1seWgdhqpeod75eXqE0jykUwiA==
Date: Tue, 19 Dec 2023 11:42:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v6 09/11] virtio-gpu: Support Venus capset
To: Huang Rui <ray.huang@amd.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-10-ray.huang@amd.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20231219075320.165227-10-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.90.245.9; envelope-from=pierre-eric@damsy.net;
 helo=mail.damsy.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Ray, Antonio,


Le 19/12/2023 à 08:53, Huang Rui a écrit :
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Add support for the Venus capset, which enables Vulkan support through
> the Venus Vulkan driver for virtio-gpu.
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> No change in v6.
> 
>   hw/display/virtio-gpu-virgl.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index be9da6e780..f35a751824 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -506,6 +506,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>           virgl_renderer_get_cap_set(resp.capset_id,
>                                      &resp.capset_max_version,
>                                      &resp.capset_max_size);
> +    } else if (info.capset_index == 2) {
> +        resp.capset_id = VIRTIO_GPU_CAPSET_VENUS;
> +        virgl_renderer_get_cap_set(resp.capset_id,
> +                                   &resp.capset_max_version,
> +                                   &resp.capset_max_size);
>       } else {
>           resp.capset_max_version = 0;
>           resp.capset_max_size = 0;
> @@ -978,10 +983,18 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>   
>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>   {
> -    uint32_t capset2_max_ver, capset2_max_size;
> +    uint32_t capset2_max_ver, capset2_max_size, num_capsets;
> +    num_capsets = 1;
> +
>       virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> -                              &capset2_max_ver,
> -                              &capset2_max_size);
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets += capset2_max_ver ? 1 : 0;
> +
> +    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets += capset2_max_size ? 1 : 0;

IMHO the logic here doesn't work.

The kernel will use num_capset like this:

	for (i = 0; i < num_capsets; i++) {
		virtio_gpu_cmd_get_capset_info(vgdev, i);

So if num_capset = 2, it will query the capset info of index 0 and 1.
Capset 0 is alway VIRGL so it's fine. But since VIRL2 support is optional,
QEMU has no way to know if index 1 is VIRGL2 (if it's supported)
or VENUS (if VIRGL2 support is missing).
And it'll get worse when we will want to support CAPSET_DRM.

Ray: we have a patch internally for this (virtio-gpu: fix capset query), you
may want to add it to this series, before this patch.

Regards,
Pierre-Eric



>   
> -    return capset2_max_ver ? 2 : 1;
> +    return num_capsets;
>   }

