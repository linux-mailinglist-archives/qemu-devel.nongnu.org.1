Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742278F09D
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 17:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbjxn-0006hs-Ml; Thu, 31 Aug 2023 11:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1qbjxl-0006hP-06
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:52:05 -0400
Received: from madras.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e5ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1qbjxg-0006cV-Rc
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:52:02 -0400
Received: from [192.168.2.167] (109-252-153-31.dynamic.spd-mgts.ru
 [109.252.153.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 5782C66072A7;
 Thu, 31 Aug 2023 16:51:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1693497114;
 bh=txqORZvT2425jW7L7Z5f4tUBxUB98IXFLVxcJ2amFPo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ofuM53N6rjbsDfD2gPoyX+wfNxrnJFSq/UyO9QbSurqmGQ+ErXv2xqAaiPk09apkv
 8A2oVgidG33v58DDwdzpFMPQ4gukM3rbqRMAng83bFK2x/t7vb2To/Eg/GfjKo51an
 x1CH3dl3u5XFJ/Qvm2D9Oy/55k6FbspQJPvGOhVL7qxoVX4n8yO38QK1rzFkflpDhH
 XKVcs09Z9IqwRPawDUPoZx/fYx8e10nWUb4sOy+Yf4GtKkp5/EbcqxzwUiL10rrNzA
 FIXhsWQu+Qvov3/2Np2+8HPaThFpH0iL4+oSiLDBtNfG5dNknaTUw7mgxjiLzURolJ
 3FDkiMsBGuz+g==
Message-ID: <5462a77f-c66d-af2d-fc07-df9f787558c2@collabora.com>
Date: Thu, 31 Aug 2023 18:51:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [QEMU PATCH v4 12/13] virtio-gpu: Initialize Venus
Content-Language: en-US
To: Antonio Caggiano <quic_acaggian@quicinc.com>,
 Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-13-ray.huang@amd.com>
 <ca8bcf9a-2886-aed0-5229-4787808bd39c@quicinc.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ca8bcf9a-2886-aed0-5229-4787808bd39c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:0:82:1000:25:2eeb:e5ab;
 envelope-from=dmitry.osipenko@collabora.com; helo=madras.collabora.co.uk
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/31/23 13:40, Antonio Caggiano wrote:
> Hi Huang,
> 
> Thank you for pushing this forward!
> 
> On 31/08/2023 11:32, Huang Rui wrote:
>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>
>> Request Venus when initializing VirGL.
>>
>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> ---
>>
>> v1->v2:
>>      - Rebase to latest version
>>
>>   hw/display/virtio-gpu-virgl.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c
>> b/hw/display/virtio-gpu-virgl.c
>> index 83cd8c8fd0..c5a62665bd 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -887,6 +887,8 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>       }
>>   #endif
>>   +    flags |= VIRGL_RENDERER_VENUS;
>> +
> 
> VIRGL_RENDERER_VENUS is a symbol only available from virglrenderer 0.9.1
> [0] and only if VIRGL_RENDERER_UNSTABLE_APIS is defined.
> 
> Luckily for us, VIRGL_RENDERER_UNSTABLE_APIS is defined unconditionally
> from virglrenderer 0.9.0 [1], so we could check for that in
> qemu/meson.build
> 
> e.g.
> 
> 
>   if virgl.version().version_compare('>= 0.9.0')
>     message('Enabling virglrenderer unstable APIs')
>     virgl = declare_dependency(compile_args:
> '-DVIRGL_RENDERER_UNSTABLE_APIS',
>                                dependencies: virgl)
>   endif
> 
> 
> Also, while testing this with various versions of virglrenderer, I
> realized there are no guarantees for Venus backend to be available in
> the linked library. Virglrenderer should be built with
> -Dvenus_experimental=true, and if that is not the case, the following
> virgl_renderer_init would fail for previous versions of virglrenderer or
> in case it has not been built with venus support.
> 
> I would suggest another approach for that which tries initializing Venus
> only if VIRGL_RENDERER_VENUS is actually defined. Then, if it fails
> cause virglrenderer has not been built with venus support, try again
> falling back to virgl only.

All the APIs will be stabilized with the upcoming virglrender 1.0
release that will happen soon. There is also a venus protocol bump, qemu
will have to bump virglrenderer's version dependency to 1.0 for venus
and other new features.

-- 
Best regards,
Dmitry


