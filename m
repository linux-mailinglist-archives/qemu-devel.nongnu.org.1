Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 902067E6C6F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:32:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r163I-0000kh-Ot; Thu, 09 Nov 2023 09:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r163G-0000kQ-CS
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:30:34 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r163E-0005Uj-Hs
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:30:33 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so156171166b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699540229; x=1700145029; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mk2aQsfgdq2c8wYpQ0cOR3AUL4N7GJYj8RnSI18L0Xo=;
 b=GO/cLyjMaL0LTPkBJaG2WBBhG6nceJv9wY7ziBIbz0qcwJzNRDoaieefkoOkBEjUt2
 20I2xaUYfF/nvVflrLZ84hUK/vXt2V0wJFr70IhbKAfS3lPKcXE3CDHb1BVr1YsOJpuv
 sOJXR9ZJwkOK2b+ab+7KAdce81nos7O9QBEVBdjQka0EOEK8eMagKwppsABNtfM+vg0s
 1aFQoJGLF4eLv7X0jFYWrjD8QLSUAW6sACbMvo6oH6pCkVaDp5A1KOY5Ec/OaUDnTcHF
 hr9DkejkqN8tLwZ0Q3EB/F+gtwfYZgY0mZi53dfUiAeIcYggAZaAQoHq8HJAv+HPn+Rz
 YUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699540229; x=1700145029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mk2aQsfgdq2c8wYpQ0cOR3AUL4N7GJYj8RnSI18L0Xo=;
 b=gsNCFjFQ4tSXil9J6pKBgEJfTsvEQCnczf7+fW9GMi9KzhBJt38w1udFgPmtlvfbiW
 PhZo/4+N3NUBNsCA7ZTu94WlKZ7DMF8QAk79KvpU4F7IacDdV2MnFpeKsz/beAMNmf+G
 9oF6q9Dlq1C/WShSRorvytORgwhLSB8km21Sj1OVs6Vra3yRaaCKqGgJadS2mocVYNET
 ojn1EUkAJNvVXF1YoILd5qa+4HcBGHNwOLSZcPm9gEB4nQQzElrmF7b98SFtEQUXeqwK
 ZKHtsM/5QELEysA5NZUdgWMjB1rieH893hLP8ZaK2K69fpCUwHsXDjfV+vTtXLxycjmy
 8nvg==
X-Gm-Message-State: AOJu0YxyAqfb1IsBGjRRFeLRn3rHe8AEMLoE/yQt/DdKM2wvHz752++T
 l2bo4UJlYh/c3qTP5MrmFJs3Ox19VG6hHN9XeIFfgQ==
X-Google-Smtp-Source: AGHT+IH7vUspuJFG28ikvU6huOGDbmNeGOjE96Q/SfNqqIyjI3ll/wMYBwkcwWX1reiUH7o/1Dg5FBAzOtr0HEcigjA=
X-Received: by 2002:a17:907:2da9:b0:9da:ef1a:958c with SMTP id
 gt41-20020a1709072da900b009daef1a958cmr4348782ejc.40.1699540229581; Thu, 09
 Nov 2023 06:30:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699351720.git.mst@redhat.com>
 <2880e676c000a62828d3d9ece7b2ec7a513560a2.1699351720.git.mst@redhat.com>
In-Reply-To: <2880e676c000a62828d3d9ece7b2ec7a513560a2.1699351720.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 14:30:18 +0000
Message-ID: <CAFEAcA_TS-B0gc-DUYT6BaKnm8Uauhsx3rW2dmVNUgTToVjSJg@mail.gmail.com>
Subject: Re: [PULL 08/63] Add virtio-sound device stub
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 7 Nov 2023 at 10:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
> Add a new VIRTIO device for the virtio sound device id. Functionality
> will be added in the following commits.
>


> +static void virtio_snd_realize(DeviceState *dev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    VirtIOSound *vsnd = VIRTIO_SND(dev);
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +
> +    vsnd->vmstate =
> +        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
> +
> +    trace_virtio_snd_realize(vsnd);
> +
> +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
> +    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
> +
> +    /* set number of jacks and streams */
> +    if (vsnd->snd_conf.jacks > 8) {
> +        error_setg(errp,
> +                   "Invalid number of jacks: %"PRIu32,
> +                   vsnd->snd_conf.jacks);
> +        return;
> +    }
> +    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
> +        error_setg(errp,
> +                   "Invalid number of streams: %"PRIu32,
> +                    vsnd->snd_conf.streams);
> +        return;
> +    }
> +
> +    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
> +        error_setg(errp,
> +                   "Invalid number of channel maps: %"PRIu32,
> +                   vsnd->snd_conf.chmaps);
> +        return;
> +    }
> +
> +    AUD_register_card("virtio-sound", &vsnd->card, errp);

Hi; Coverity points out (CID 1523899) that we don't check the
error from this function. We should check for failure and return
early if so.

> +
> +    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
> +    vsnd->queues[VIRTIO_SND_VQ_EVENT] =
> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
> +    vsnd->queues[VIRTIO_SND_VQ_TX] =
> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
> +    vsnd->queues[VIRTIO_SND_VQ_RX] =
> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
> +}

thanks
-- PMM

