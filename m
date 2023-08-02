Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C43D176C539
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 08:22:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR5F6-0001re-Tp; Wed, 02 Aug 2023 02:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5F4-0001m3-M7
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:21:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5F2-0005P3-RP
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:21:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686fa3fc860so4249090b3a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690957311; x=1691562111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKxBZTzOjy/tIuhXTBA+q+PNRhy85ZXCv7wyMQYZ18M=;
 b=jURZU9uwqkMx1NnNaJm1oys4xr3a4Bij4xF2cWeY/ubm1ED0wB3qwea3gLhY4yH7y3
 KVQJtRBawbWnY7yeCLOK8MDd3+rqii05sZpL0fv7iyoo9tpNs0s6ZLPNmXQPotoluLMi
 y9pdRDNe32nUPVaAdZVyNGrDBZ1OzL61qpAkgOdSQeNlNjah3Hln5ya1a3V6qvgF/+vr
 X4m8eBXfuD74+SQA29KCH+Y+kD291PAzsMMaLLbEzXubuujpepXkK5EuKmlQvdv2L43J
 6/6bqb+hv5CpnErfNoOuJressJ4rPmtolrA0NAaj13us0Cx6I/DFZv+nPW1FIq5jsA81
 xH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690957311; x=1691562111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKxBZTzOjy/tIuhXTBA+q+PNRhy85ZXCv7wyMQYZ18M=;
 b=X38XhFtMYgS0IE0mups+VMAYqGguV8z2WEtWag1lJAQryKQJMGoMiO8gd9fuvtQsUj
 JLW9nUBfrLdkkifBDeqx6n8CJLVcplyJX059qRc2z1HrliMpyCk6ek6SU+niKPAbBivy
 X6gyXUxLUZUcLgcui2IUjn02L5Y7Mjgevyr4fkqzBbSuhWTKMnD9JRgjmdjPq2xneHqQ
 vYH2Ik38fb1rhXUU3f6o8SVc674Z31if8uMs8has9SYmo/rQehJQc5uZMEl7BCvoJFtd
 2vboAXcLdFpuLqFgGK5HviqlkfuCkZTe1g8+0nSWe5fJ7lRNP5dLCS0YIH1NLrKE4WKc
 6q7Q==
X-Gm-Message-State: ABy/qLbeR8aehJABcCHcLdk6b2UywRtouquf7wS0mBTNNy0Hi3khplmt
 NTZUhgdCCoazT04ukvrdZnM=
X-Google-Smtp-Source: APBJJlGGr47dphUkMBXs84Ep9dP7OtEtlL+g089kQXI9UutbPp88p+B8EhIr2rCDaPEbV8Me3YyzWw==
X-Received: by 2002:a05:6a20:12cb:b0:135:38b5:7e63 with SMTP id
 v11-20020a056a2012cb00b0013538b57e63mr17580199pzg.46.1690957310934; 
 Tue, 01 Aug 2023 23:21:50 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 a18-20020aa780d2000000b0068746ab9aebsm3856869pfn.14.2023.08.01.23.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 23:21:50 -0700 (PDT)
Message-ID: <882c59fe-f036-8ade-4ba1-d2163eb69125@gmail.com>
Date: Wed, 2 Aug 2023 15:21:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] gfxstream + rutabaga: meson support
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
References: <20230801011723.627-1-gurchetansingh@chromium.org>
 <20230801011723.627-8-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230801011723.627-8-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023/08/01 10:17, Gurchetan Singh wrote:
> - Add meson detection of rutabaga_gfx
> - Build virtio-gpu-rutabaga.c + associated vga/pci files when
>    present
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> ---
>   hw/display/meson.build        | 22 ++++++++++++++++++++++
>   meson.build                   |  7 +++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 34 insertions(+)
> 
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 413ba4ab24..10e41e4eef 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -79,6 +79,13 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>                            if_true: [files('virtio-gpu-gl.c', 'virtio-gpu-virgl.c'), pixman, virgl])
>       hw_display_modules += {'virtio-gpu-gl': virtio_gpu_gl_ss}
>     endif
> +
> +  if rutabaga.found()
> +    virtio_gpu_rutabaga_ss = ss.source_set()
> +    virtio_gpu_rutabaga_ss.add(when: ['CONFIG_VIRTIO_GPU', rutabaga],
> +                         if_true: [files('virtio-gpu-rutabaga.c'), pixman])

This line is a bit misaligned.

> +    hw_display_modules += {'virtio-gpu-rutabaga': virtio_gpu_rutabaga_ss}
> +  endif
>   endif
>   
>   if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
> @@ -95,6 +102,12 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
>                                if_true: [files('virtio-gpu-pci-gl.c'), pixman])
>       hw_display_modules += {'virtio-gpu-pci-gl': virtio_gpu_pci_gl_ss}
>     endif
> +  if rutabaga.found()
> +    virtio_gpu_pci_rutabaga_ss = ss.source_set()
> +    virtio_gpu_pci_rutabaga_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI', rutabaga],
> +                       if_true: [files('virtio-gpu-pci-rutabaga.c'), pixman])
> +    hw_display_modules += {'virtio-gpu-pci-rutabaga': virtio_gpu_pci_rutabaga_ss}
> +  endif
>   endif
>   
>   if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
> @@ -113,6 +126,15 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
>     virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
>                                               if_false: files('acpi-vga-stub.c'))
>     hw_display_modules += {'virtio-vga-gl': virtio_vga_gl_ss}
> +
> +  if rutabaga.found()
> +    virtio_vga_rutabaga_ss = ss.source_set()
> +    virtio_vga_rutabaga_ss.add(when: ['CONFIG_VIRTIO_VGA', rutabaga],
> +                         if_true: [files('virtio-vga-rutabaga.c'), pixman])
> +    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
> +                                                   if_false: files('acpi-vga-stub.c'))
> +    hw_display_modules += {'virtio-vga-rutabaga': virtio_vga_rutabaga_ss}
> +  endif
>   endif
>   
>   system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..293f388e53 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1069,6 +1069,12 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>                                          dependencies: virgl))
>     endif
>   endif
> +rutabaga = not_found
> +if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
> +  rutabaga = dependency('rutabaga_gfx_ffi',
> +                         method: 'pkg-config',
> +                         required: get_option('rutabaga_gfx'))
> +endif
>   blkio = not_found
>   if not get_option('blkio').auto() or have_block
>     blkio = dependency('blkio',
> @@ -4272,6 +4278,7 @@ summary_info += {'libtasn1':          tasn1}
>   summary_info += {'PAM':               pam}
>   summary_info += {'iconv support':     iconv}
>   summary_info += {'virgl support':     virgl}
> +summary_info += {'rutabaga support':  rutabaga}
>   summary_info += {'blkio support':     blkio}
>   summary_info += {'curl support':      curl}
>   summary_info += {'Multipath support': mpathpersist}
> diff --git a/meson_options.txt b/meson_options.txt
> index aaea5ddd77..dea3bf7d9c 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -224,6 +224,8 @@ option('vmnet', type : 'feature', value : 'auto',
>          description: 'vmnet.framework network backend support')
>   option('virglrenderer', type : 'feature', value : 'auto',
>          description: 'virgl rendering support')
> +option('rutabaga_gfx', type : 'feature', value : 'auto',
> +       description: 'rutabaga_gfx support')
>   option('png', type : 'feature', value : 'auto',
>          description: 'PNG support with libpng')
>   option('vnc', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 9da3fe299b..9a95b4f782 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -154,6 +154,7 @@ meson_options_help() {
>     printf "%s\n" '  rbd             Ceph block device driver'
>     printf "%s\n" '  rdma            Enable RDMA-based migration'
>     printf "%s\n" '  replication     replication support'
> +  printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
>     printf "%s\n" '  sdl             SDL user interface'
>     printf "%s\n" '  sdl-image       SDL Image support for icons'
>     printf "%s\n" '  seccomp         seccomp support'
> @@ -419,6 +420,8 @@ _meson_option_parse() {
>       --disable-replication) printf "%s" -Dreplication=disabled ;;
>       --enable-rng-none) printf "%s" -Drng_none=true ;;
>       --disable-rng-none) printf "%s" -Drng_none=false ;;
> +    --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
> +    --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
>       --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
>       --disable-safe-stack) printf "%s" -Dsafe_stack=false ;;
>       --enable-sanitizers) printf "%s" -Dsanitizers=true ;;

