Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE247915D5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd767-0000ZK-53; Mon, 04 Sep 2023 06:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd75y-0000W8-QZ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:46:17 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd75u-0000dD-JY
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:46:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c136ee106so201784066b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693824367; x=1694429167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4GZcdAQfd2ukPAR/rltlccRuGLnWFN40RI1KU+tAYF4=;
 b=cbWqcPKaWbuBZ6Ms9GCvNJqNtDikzqVadShopqvg04QoZCw+ay23q2GJYU1BfNS9Zg
 1aT0UNzMXlmRLyX6Kg7tjSlioVsbnB4wkpWtfCR4t50juWefuToMuUQJ1gL6eobVdxEz
 oM6o++x0fwc9iC0x7E1lrma606IbsMmeRY0apkr/HlESj2SUI7M1A0dbjzRLAf7Q5P5m
 x+5QX0Op5LCeEG1VFbE8SBDHPmTa++88Oge5adf8dvSE7X6upo2bqYmPWTfwQCXhglu+
 XjHox2qsDElFRDIVks4lqUDb0tkKRZCYKg2+zPEnd2DJ982bMqJQjen6EcdgYWuoulXN
 RTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693824367; x=1694429167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4GZcdAQfd2ukPAR/rltlccRuGLnWFN40RI1KU+tAYF4=;
 b=KV4INiTBKBAjQQwqypkbftg8XJN6Sks0gl9EivknX8eQH70O5NXnY01Ka5U4oNlwtc
 e5l1ZO76GSICER2oqhstjOv7LfXVc84B3DkYpp5AcFdCrevnX93A+BobShN6bnc5CDy7
 YsrjJ9dZvVlIzv6xY0xPrjrWJg2coWZEX/wjMJbDyFOqdBRi2EXC6ZKMZFnCezpZbDYx
 K0b9icjwTesoVjP7DMl3LOmAAnCyTvlWwE3ZvO2hlgke3sD3aE0iXlR8sL2gfrb7Iwr3
 Ctwd5zF9ipoZuS7x1cr9BDHnDDxgs1XMg/WJNG2/t4xDTyvJKImiCwVtabrqlkBlyyPq
 DJew==
X-Gm-Message-State: AOJu0YwmrfMns9YjH+RJlnCoiehoZvyDiD5CPFvkeV2vHGRk9hQpAFar
 89oIvDNe56tqPyMpcYOW8qbqLw==
X-Google-Smtp-Source: AGHT+IESJS4WIFEjlmtA+PyNIJ6O2ss8K/ehD8IkB1iBFKbUqUxGeEZiR+lT/rRGNgMwwUVL+wPgqg==
X-Received: by 2002:a17:906:7497:b0:9a1:fb4c:3b6c with SMTP id
 e23-20020a170906749700b009a1fb4c3b6cmr6038259ejl.59.1693824367400; 
 Mon, 04 Sep 2023 03:46:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 cf20-20020a170906b2d400b00988dbbd1f7esm5945070ejb.213.2023.09.04.03.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 03:46:06 -0700 (PDT)
Message-ID: <198a502c-d7bb-5e83-08b4-f29222dd4d83@linaro.org>
Date: Mon, 4 Sep 2023 12:46:04 +0200
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
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

IIUC the spec, this structure is in little endian, is that right?
So shouldn't swap various fields in this series?

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
> +}


