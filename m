Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F107BF9FA
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:42:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqB7T-0002ep-Va; Tue, 10 Oct 2023 07:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1qqB7F-0002dx-Lt
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:41:35 -0400
Received: from madras.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e5ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1qqB7C-00057d-LB
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:41:32 -0400
Received: from [192.168.2.166] (109-252-153-31.dynamic.spd-mgts.ru
 [109.252.153.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BD9866072AE;
 Tue, 10 Oct 2023 12:41:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696938087;
 bh=Cu2AL7ysZU6zdFI02/HLm99aCHAoK8R3r7kMZ6tAY9c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ht+//PK6HzadiUhAghbBQ7eBJB3KqcDaMr01ruj7+mGbSxfMHjus+dLFz2R6/Ii4H
 paekH4nuo4QfB4IkshpdgAXCbpvjicrxeIXsetPl9OjE4N+2YsK9IJ6+sAA6n6hZIc
 ubWyMthhvGwYuSuoPIIJ1lDObQvuFmhWp6/HXauv6LwRwbG7yaeNHoRParPQNXKeTS
 zkVymWfv5MyYZHIkSQiaac2k0uxoOPrqJymTg4A7Gml98uC+HRu7ZfyBUgXoZkGf98
 SYoxrpoQDMUZ/2Mjsa/o+PQHProVoMNLaTUZkRRbgOJ3kjEQvUYT2bWShkWJARbHZI
 x+NL5DbPykHvw==
Message-ID: <16520a76-7177-f97c-049b-302d8baea616@collabora.com>
Date: Tue, 10 Oct 2023 14:41:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [QEMU PATCH v5 05/13] virtio-gpu: Configure context init for
 virglrenderer
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Albert Esteve <aesteve@redhat.com>, ernunes@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-6-ray.huang@amd.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230915111130.24064-6-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1098:0:82:1000:25:2eeb:e5ab;
 envelope-from=dmitry.osipenko@collabora.com; helo=madras.collabora.co.uk
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 9/15/23 14:11, Huang Rui wrote:
> Configure context init feature flag for virglrenderer.
> 
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> V4 -> V5:
>     - Inverted patch 5 and 6 because we should configure
>       HAVE_VIRGL_CONTEXT_INIT firstly. (Philippe)
> 
>  meson.build | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..ff20d3c249 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1068,6 +1068,10 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>                                         prefix: '#include <virglrenderer.h>',
>                                         dependencies: virgl))
>    endif
> +  config_host_data.set('HAVE_VIRGL_CONTEXT_INIT',
> +                       cc.has_function('virgl_renderer_context_create_with_flags',
> +                                       prefix: '#include <virglrenderer.h>',
> +                                       dependencies: virgl))
The "cc.has_function" doesn't work properly with PKG_CONFIG_PATH. It ignores the the given pkg and uses system includes. Antonio was aware about that problem [1].

[1] https://gitlab.freedesktop.org/Fahien/qemu/-/commit/ea1c252a707940983ccce71e92a292b49496bfcd

Given that virglrenderer 1.0 has been released couple weeks ago, can we make the v1.0 a mandatory requirement for qemu and remove all the ifdefs? I doubt that anyone is going to test newer qemu using older libviglrenderer, all that ifdef code will be bitrotting.

@@ -1060,6 +1060,7 @@ virgl = not_found
 have_vhost_user_gpu = have_tools and targetos == 'linux' and pixman.found()
 if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
+                     version: '>=1.0.0',
                      method: 'pkg-config',
                      required: get_option('virglrenderer'))
   if virgl.found()


Best regards,
Dmitry


