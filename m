Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C7979158C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:14:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6aM-00070u-Tq; Mon, 04 Sep 2023 06:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6aL-00070e-O7
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:13:33 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6aJ-0001Zz-4F
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:13:33 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso1645491a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693822409; x=1694427209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKR6zH0T2EEOzCS7+oHb91oVomkFLDedhDQFDmRzGF8=;
 b=lpcgB1wPaAQYaOqW91M65AJ1f+BdsrbzoZzS0n3q/O6z5utxIJYteZ8WGvJdlq8UwE
 UKaXUcY94/GAjoIgJWrZytFbDEAMewAruGT8bnhtdssi80awd4YvqCAUrQ1eBUu2hW+O
 GugQuEkNwktRI12+tjh12/LEJQXuwCmpaI/pqqFOa5lE7Kbbj5Uan/TooCEaxyoVM/LT
 X9ZoH758TpgMTad2tylTYhjRfiOA2PezEAcIXjhwGGp/oD45wjen/3TSho4Z/m8CxLeV
 lQNY6ph/ahv0/LSMorqxDz7YUi3DlGJjyH5vrHtu7o06AFLaCBkZb/iSqV2xzQ96TcuU
 T7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693822409; x=1694427209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKR6zH0T2EEOzCS7+oHb91oVomkFLDedhDQFDmRzGF8=;
 b=gk9AtYov4R+BfrB1DAUzQipWrKj1kGKAhnNhxqmtTARyHtdpXRx16hMeydvBXU/8fe
 0b777BTn9LH/rrrJ2B7mEH4XoRCK/QQBjXJN0wrWBySrdB7avI8ztLrSroA009DbdZzU
 cgk/3SspjrtUHnJUTu9tKj2PDydjNRFpOlW1S7DDkf2pRjCS2Qghz+0hKcDBBEW3WAvT
 n3Y8a7tzWqk8I1yecmd3Vgv/fmnAVEY3l8a/fswBId2cYGbwxFHzSy8yMjXS97WEO5ig
 C4OeySPdRQjqbhf2xYHMIVyi4p0AjD/FfFp1BcGlDUilJ2HFFak07TaBFwo6pwULNXeT
 dXBw==
X-Gm-Message-State: AOJu0YxiMDdBPdvRpoYoO++mlv6aGGFSefIZq0xrwtekszPNYJCYVoHl
 9x5zKq2gODjkX+GLe7PSKc471Q==
X-Google-Smtp-Source: AGHT+IH62Ee1Y2JKgye1a07SFI3AcQq82+cXduGSCzisgNKJ119q4qD/GrFJocH/tFK6CeGD+n1yGg==
X-Received: by 2002:aa7:da50:0:b0:521:8777:b00d with SMTP id
 w16-20020aa7da50000000b005218777b00dmr6174724eds.15.1693822409467; 
 Mon, 04 Sep 2023 03:13:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a056402349200b0052e1783ab25sm1614551edc.70.2023.09.04.03.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 03:13:29 -0700 (PDT)
Message-ID: <30dde76a-099c-1f03-93e3-0c962f15404d@linaro.org>
Date: Mon, 4 Sep 2023 12:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 05/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO
 request
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
 <974d88412dd4ee18ae35efdbec657fa558c13fbf.1693252037.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <974d88412dd4ee18ae35efdbec657fa558c13fbf.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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
> Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
> of each requested PCM stream.
> 
> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/trace-events |  1 +
>   hw/virtio/virtio-snd.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 77 insertions(+)


> +/*
> + * Handle the VIRTIO_SND_R_PCM_INFO request.
> + * The function writes the info structs to the request element.
> + *
> + * @s: VirtIOSound device
> + * @cmd: The request command queue element from VirtIOSound cmdq field
> + */
> +static void virtio_snd_handle_pcm_info(VirtIOSound *s,
> +                                       virtio_snd_ctrl_command *cmd)
> +{
> +    virtio_snd_query_info req;
> +    VirtIOSoundPCMStream *stream = NULL;
> +    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
> +    size_t sz = iov_to_buf(cmd->elem->out_sg,
> +                           cmd->elem->out_num,
> +                           0,
> +                           &req,
> +                           sizeof(req));
> +    if (sz != sizeof(virtio_snd_query_info)) {
> +        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
> +        return;
> +    }
> +
> +    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
> +        sizeof(virtio_snd_hdr) + req.size * req.count) {
> +        error_report("pcm info: buffer too small, got: %zu, needed: %zu",
> +                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
> +                sizeof(virtio_snd_pcm_info));
> +        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
> +        return;
> +    }
> +
> +    pcm_info = g_new0(virtio_snd_pcm_info, req.count);
> +    for (uint32_t i = req.start_id; i < req.start_id + req.count; i++) {

Starting from req.start_id seems to increase this code complexity.

> +        trace_virtio_snd_handle_pcm_info(i);
> +        stream = virtio_snd_pcm_get_stream(s, i);
> +
> +        if (!stream) {
> +            error_report("Invalid stream id: %"PRIu32, i);
> +            cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
> +            return;
> +        }
> +
> +        pcm_info[i - req.start_id].hdr.hda_fn_nid = stream->info.hdr.hda_fn_nid;
> +        pcm_info[i - req.start_id].features = stream->features;
> +        pcm_info[i - req.start_id].formats = stream->formats;
> +        pcm_info[i - req.start_id].rates = stream->rates;
> +        pcm_info[i - req.start_id].direction = stream->direction;
> +        pcm_info[i - req.start_id].channels_min = stream->channels_min;
> +        pcm_info[i - req.start_id].channels_max = stream->channels_max;
> +    }
> +
> +    cmd->resp.code = VIRTIO_SND_S_OK;
> +
> +    iov_from_buf(cmd->elem->in_sg,
> +                 cmd->elem->in_num,
> +                 sizeof(virtio_snd_hdr),
> +                 pcm_info,
> +                 sizeof(virtio_snd_pcm_info) * req.count);
> +}


