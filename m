Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3A791582
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:10:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6W3-0005e7-Rs; Mon, 04 Sep 2023 06:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6W0-0005d0-2F
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:09:04 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6Vx-0000lS-9p
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:09:03 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcfdadd149so20670971fa.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693822139; x=1694426939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w4MSWW3/yX9rKp1XcDaq2LsuXtcRlyjuTwOHUK90LwI=;
 b=e6kUMGsRka+xeG3xoc5V4DdxcoAH2lMp6ogswjJFotuNcFQIU0Wv8QklDZriCWfCwW
 jFoYsPAG3vCeVauo6KhUu6DERpymCVaIpjPt+81jYZy4iJs1v9yXoOrfgoVgYljYvVaL
 Acd0UYGPEnwd89U9YekwEI9V3EZMdNnWXCYRv0cmbYCvnPKxsYhNWGITeqoYkXOg42+4
 NwAMo6H5L1MbB2W68DwNj1hC5xH9tlnJKBvgYF01fFgvw964YWWVMbqwnoJ2LrlKhbYu
 eTzZm5dAAAizb4Rzo/hfd12L4Zmj6WFjVWXE0yJ1Ab6Sl9ZnsJUQcFJiPwyJGQAmpz5X
 dnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693822139; x=1694426939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w4MSWW3/yX9rKp1XcDaq2LsuXtcRlyjuTwOHUK90LwI=;
 b=gQG5YUUhEG/PEBIswF/rFZqpLed5+yeFPW2F0Ywy+1j0gnYrvgeUA5oXRfqzLVJg/t
 tzO3TvoWB/+g25UFCCzBER3CgUO1StMGsQU2gzuu8L91K3EeH/n4hGTwX0qc3yGB5XY9
 RapaYiFJ47Kjh7+N+H1j0ZMlVz/A8172hP+KegBGdZHIQIkx88CTuv+IJEdPGyeX93nF
 XoT3T9j0r8rdLzPYaU5IfB1oECtbfE8WsCHpBp/kwwPOcROobMHQePiBpz91tiaDiBNo
 BOiNoSwiA6ST4KqsMnUyb/lEgc5fWmO4XR4iKvo0ul1Sh4WXNbfCJz9A0+SKHCJQaXba
 nAcA==
X-Gm-Message-State: AOJu0Yy7CEhP152RIS5D01JYYJ12kN/nty2xQ2GKSqfl4Xh18hsA/3n1
 FAXYkSHDQyiqt5ZpyklcamhVrw==
X-Google-Smtp-Source: AGHT+IE2AXL27xbR8iyLWOjQwjK6HAN/bIwqN4ESXTLtAryWpKFH9G2a8fAhuifcwEiiDxEIFr4M+Q==
X-Received: by 2002:a2e:9c50:0:b0:2bc:c650:81b with SMTP id
 t16-20020a2e9c50000000b002bcc650081bmr6167349ljj.15.1693822139155; 
 Mon, 04 Sep 2023 03:08:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 mc24-20020a170906eb5800b00997e99a662bsm5962789ejb.20.2023.09.04.03.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 03:08:58 -0700 (PDT)
Message-ID: <e5f5edcf-6a53-bf61-25cd-4b5ea6dd1d4e@linaro.org>
Date: Mon, 4 Sep 2023 12:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 03/12] virtio-sound: handle control messages and streams
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <e3e57dd125611eeb5e563eb7fab8eb89194ed50e.1693252037.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e3e57dd125611eeb5e563eb7fab8eb89194ed50e.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi Emmanouil,

On 28/8/23 21:55, Emmanouil Pitsidianakis wrote:
> Receive guest requests in the control (CTRL) queue of the virtio sound
> device and reply with a NOT SUPPORTED error to all control commands.
> 
> The receiving handler is virtio_snd_handle_ctrl(). It stores all control
> messages in the queue in the device's command queue. Then it calls
> virtio_snd_process_cmdq() to handle each message.
> 
> The handler is process_cmd() which replies with VIRTIO_SND_S_NOT_SUPP.
> 
> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/trace-events         |   4 +
>   hw/virtio/virtio-snd.c         | 227 ++++++++++++++++++++++++++++++++-
>   include/hw/virtio/virtio-snd.h |  70 +++++++++-
>   3 files changed, 292 insertions(+), 9 deletions(-)


>   /*
> - * Queue handler stub.
> + * The actual processing done in virtio_snd_process_cmdq().
> + *
> + * @s: VirtIOSound device
> + * @cmd: control command request
> + */
> +static inline void
> +process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
> +{
> +    size_t sz = iov_to_buf(cmd->elem->out_sg,
> +                           cmd->elem->out_num,
> +                           0,
> +                           &cmd->ctrl,
> +                           sizeof(cmd->ctrl));
> +    if (sz != sizeof(cmd->ctrl)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: virtio-snd command size incorrect %zu vs \
> +                %zu\n", __func__, sz, sizeof(cmd->ctrl));
> +        return;
> +    }
> +
> +    trace_virtio_snd_handle_code(cmd->ctrl.code,
> +                                 print_code(cmd->ctrl.code));
> +
> +    switch (cmd->ctrl.code) {
> +    case VIRTIO_SND_R_JACK_INFO:
> +    case VIRTIO_SND_R_JACK_REMAP:
> +        qemu_log_mask(LOG_UNIMP,
> +                     "virtio_snd: jack functionality is unimplemented.");
> +        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
> +        break;
> +    case VIRTIO_SND_R_PCM_INFO:
> +    case VIRTIO_SND_R_PCM_SET_PARAMS:
> +    case VIRTIO_SND_R_PCM_PREPARE:
> +    case VIRTIO_SND_R_PCM_START:
> +    case VIRTIO_SND_R_PCM_STOP:
> +    case VIRTIO_SND_R_PCM_RELEASE:
> +        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
> +        break;
> +    case VIRTIO_SND_R_CHMAP_INFO:
> +        qemu_log_mask(LOG_UNIMP,
> +                     "virtio_snd: chmap info functionality is unimplemented.");
> +        trace_virtio_snd_handle_chmap_info();
> +        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
> +        break;
> +    default:
> +        /* error */
> +        error_report("virtio snd header not recognized: %"PRIu32,
> +                     cmd->ctrl.code);
> +        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    iov_from_buf(cmd->elem->in_sg,
> +                 cmd->elem->in_num,
> +                 0,
> +                 &cmd->resp,
> +                 sizeof(cmd->resp));
> +    virtqueue_push(cmd->vq, cmd->elem, sizeof(cmd->elem));
> +    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);

I have very few understanding of virtio, but I'm wondering here,
since this function is called under cmdq_mutex(), could it be
useful to batch the queue by calling virtio_notify() only once
in the caller once the whole cmdq is processed ...

> +}
> +
> +/*
> + * Consume all elements in command queue.
> + *
> + * @s: VirtIOSound device
> + */
> +static void virtio_snd_process_cmdq(VirtIOSound *s)
> +{
> +    virtio_snd_ctrl_command *cmd;
> +
> +    if (unlikely(qatomic_read(&s->processing_cmdq))) {
> +        return;
> +    }
> +
> +    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
> +        qatomic_set(&s->processing_cmdq, true);
> +        while (!QTAILQ_EMPTY(&s->cmdq)) {
> +            cmd = QTAILQ_FIRST(&s->cmdq);
> +
> +            /* process command */
> +            process_cmd(s, cmd);
> +
> +            QTAILQ_REMOVE(&s->cmdq, cmd, next);
> +
> +            g_free(cmd);
> +        }

... here?

> +        qatomic_set(&s->processing_cmdq, false);
> +    }
> +}


