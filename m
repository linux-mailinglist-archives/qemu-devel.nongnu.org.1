Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E87DDC0F
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 06:10:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy3TR-0002AP-Pz; Wed, 01 Nov 2023 01:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qy3TP-0002AG-PL
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 01:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qy3TN-0007xr-VL
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 01:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698815336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXbv80dGw38aVLMdL6igiVw1e81gtQrG8XzjpxlcubE=;
 b=RBDiqp+Vy5qB5IjpirQmKQpsqEwwo9dkW21eA74c6Q8rao8YaErz/dSy33PYy8qsRPOUZE
 y1ClCfu5VdAJ10BPbTKqQ/vTitCiQzDcRXli931bKAG2C8D7aatATevfibQqJdsiadp6jo
 Lsp1SZGflqnm6ps8aAIkYdg9Vh5jqAY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-c_uLuHi4MZ6vJY35wCgwgQ-1; Wed, 01 Nov 2023 01:08:55 -0400
X-MC-Unique: c_uLuHi4MZ6vJY35wCgwgQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so45480275e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 22:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698815334; x=1699420134;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PXbv80dGw38aVLMdL6igiVw1e81gtQrG8XzjpxlcubE=;
 b=Sd8NFOp/b8kUrFTkJW6D6KqRGPEWuXdqsWv31WxDKqVaPA3WtfWm/LgbW1WxDqg2Y0
 zEI+hM6/g2GV6mqP1rrjB1Pivmv51lBfrNKltQQsfB3pFU8dujIi3BErqL5uEpjH6W1O
 DGkhRHpYoIPTqoYwLtrwykr8VHVYrHnKlPQzWAkAZjo9MxSJ8hgertgBmTFIXYxOhzOr
 RSNeTlOlzOuarsGce2sTLzGzadEvntlAooGcHGDsOqUDSKXuXP0Wwro+8Zq7HdYAfTjy
 pUMAuFjwE7lpN854VWeBf0V+s4lLeXYoT4SAhKcf5tV3L3OYAPmdpl4AWfKNQvKQrPUK
 QQxg==
X-Gm-Message-State: AOJu0Yxib4wuy3OMzhfnSFBGfMfUjjWzhtGLNRsrVlX0PTe3TczJmYVs
 TAvk/wTxaFqfQ3SBK5TTvKiQ+dZNaijYa+iNsI0yPKR8aPlRKK+GAJyQOAj1sClm8VflYrE6Pgk
 npzVF6dOg1b0KbGU=
X-Received: by 2002:a1c:7917:0:b0:405:40ec:415d with SMTP id
 l23-20020a1c7917000000b0040540ec415dmr12108924wme.39.1698815333913; 
 Tue, 31 Oct 2023 22:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuu/jzzyhOKUeQ9xP8saX0SCECiJEdC94iXFz0GZSVkGgmZDF6exl7jnSbbSl/utfMXKqfFA==
X-Received: by 2002:a1c:7917:0:b0:405:40ec:415d with SMTP id
 l23-20020a1c7917000000b0040540ec415dmr12108911wme.39.1698815333567; 
 Tue, 31 Oct 2023 22:08:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:14b6:b6f1:4797:8f5d:fa41])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a5d618f000000b00327de0173f6sm3112447wru.115.2023.10.31.22.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 22:08:52 -0700 (PDT)
Date: Wed, 1 Nov 2023 01:08:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v13 00/11] Add VIRTIO sound card
Message-ID: <20231101010813-mutt-send-email-mst@kernel.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Oct 23, 2023 at 03:03:17PM +0300, Manos Pitsidianakis wrote:
> This patch series adds an audio device implementing the recent virtio
> sound spec (1.2) and a corresponding PCI wrapper device.
> 
> v13 can be found online at:
> 
> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v13
> 
> Ref e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c
> 
> Main differences with v12 patch series [^v12]:
> 
> - Fixed device aliases (thanks Volker Rümelin <vr_qemu@t-online.de>)

Acked-by: Michael S. Tsirkin <mst@redhat.com>

to merge through the audio tree.


> v11[^v11] -> v12[^v12]
> ======================
> 
> - Moved devices from hw/virtio under hw/audio.
> 
> v10[^v10] -> v11[^v11]
> ======================
> 
> - Rebased against upstream, which has minor changes to the AUD_* API.
> - Fixed noise in playback because of invalid bounds when accessing the
>   audio data in the VirtQueueElement.
> - Refactor invalid I/O message queue flushing into separate function.
> - Removed attempt to write unwritten bytes to QEMU sound backend when
>   flushing: it should only happen when the stream STARTs.
> - Set latency_bytes to buffer size when returning TX I/O message because
>   it happens immediately after writing the last bytes to the QEMU
>   backend, therefore there might be up to <buffer size> bytes to be
>   played before all the buffer data has finished playing.
> - Addressed [^v10] review comments:
>   - Refactored VirtIOSoundPCMBuffer return code into a function instead
>     of using goto labels in output/input audio callbacks. (Suggested by
>     <philmd@linaro.org>)
> 
> v9[^v9] -> v10[^v10]
> ====================
> 
> - Addressed [^v9] review comments.
> - Copy buffer data just before playing it on the host instead of when
>   the IO message arrives. This in most cases takes care of the buffer
>   not being populated with data from the guest application when it
>   firsts arrives.
> 
> v8[^v8] -> v9[^v9]
> ==================
> 
> - Addressed [^v8] review comments.
> - Add cpu_to_le32(_) and le32_to_cpu(_) conversions for messages from/to
>   the guest according to the virtio spec.
> - Inlined some functions and types to reduce review complexity.
> - Corrected the replies to IO messages; now both Playback and Capture
>   work correctly for me. (If you hear cracks in pulseaudio+guest, try
>   pipewire+guest).
> 
> v7[^v7] -> v8[^v8]
> ==================
> 
> - Addressed [^v7] review comments.
>   Functions that were called from more than one place for code re-use
>   are not created until they are actually needed.
> - Fixed cases where block->offset was not respected in Playback
> 
> v6[^v6] -> v7[^v7]
> ==================
> 
> - Removed minor stale/duplicate code.
> - Addressed [^v6] review comments.
>   Notably, the audio driver name is now `virtio` instead of
>   `virtio-sound`.
> - Fixed some invalid pointer logic.
> - Fixed minor typos and updated documentation.
> 
> v5[^v5] -> v6[^v6]
> ==================
> 
> - Free any existing PCM stream resources before allocating a new one.
> - Add docs.
> 
> v4[^v4] -> v5[^v5]
> ==================
> 
> - Use ERRP_GUARD() to propagate errors.
> - Use virtio_add_feature() instead of XORing constants.
> - Use %zu format specifier for size_t.
> 
> v3[^v3] -> v4[^v4]
> ==================
> 
> - Addressed review style comments.
> - Split patches for easier review.
> 
> v2[^v2] -> v3[^v3]
> ==================
> 
> - Addressed review comments.
> 
> v1[^v1] -> v2[^v2]
> ==================
> 
> - Split virtio-snd and virtio-snd-pci devices to two commits
> - Added audio capture support
> 
> Previously:
> 
> [^v12]:
> https://lore.kernel.org/qemu-devel/cover.1697709630.git.manos.pitsidianakis@linaro.org/
> [^v11]:
> https://lore.kernel.org/qemu-devel/cover.1696935992.git.manos.pitsidianakis@linaro.org/
> [^v10]:
> https://lore.kernel.org/qemu-devel/cover.1695996196.git.manos.pitsidianakis@linaro.org/
> [^v9]:
> https://lore.kernel.org/qemu-devel/cover.1694588927.git.manos.pitsidianakis@linaro.org/
> [^v8]:
> https://lore.kernel.org/qemu-devel/cover.1693252037.git.manos.pitsidianakis@linaro.org/
> [^v7]:
> https://lore.kernel.org/qemu-devel/cover.1692731646.git.manos.pitsidianakis@linaro.org/
> [^v6]:
> https://lore.kernel.org/qemu-devel/cover.1692089917.git.manos.pitsidianakis@linaro.org/
> [^v5]:
> https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/
> [^v4]:
> https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/
> [^v3]:
> https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/
> [^v2]:
> https://lore.kernel.org/qemu-devel/cover.1686238728.git.manos.pitsidianakis@linaro.org/
> [^v1]:
> https://lore.kernel.org/qemu-devel/20230526204845.673031-1-manos.pitsidianakis@linaro.org/
> 
> Manos Pitsidianakis (11):
>   Add virtio-sound device stub
>   Add virtio-sound-pci device
>   virtio-sound: handle control messages and streams
>   virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
>   virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
>   virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
>   virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
>   virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
>   virtio-sound: implement audio output (TX)
>   virtio-sound: implement audio capture (RX)
>   docs/system: add basic virtio-snd documentation
> 
>  MAINTAINERS                        |    9 +
>  docs/system/device-emulation.rst   |    1 +
>  docs/system/devices/virtio-snd.rst |   49 +
>  hw/audio/Kconfig                   |    5 +
>  hw/audio/meson.build               |    2 +
>  hw/audio/trace-events              |   20 +
>  hw/audio/virtio-snd-pci.c          |   93 ++
>  hw/audio/virtio-snd.c              | 1409 ++++++++++++++++++++++++++++
>  include/hw/audio/virtio-snd.h      |  235 +++++
>  system/qdev-monitor.c              |    2 +
>  10 files changed, 1825 insertions(+)
>  create mode 100644 docs/system/devices/virtio-snd.rst
>  create mode 100644 hw/audio/virtio-snd-pci.c
>  create mode 100644 hw/audio/virtio-snd.c
>  create mode 100644 include/hw/audio/virtio-snd.h
> 
> 
> base-commit: 384dbdda94c0bba55bf186cccd3714bbb9b737e9
> -- 
> 2.39.2


