Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B79761C3E
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:49:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJKL-0003IT-Bx; Tue, 25 Jul 2023 10:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOJK0-0003Fm-Ag
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOJJa-0006ze-3X
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690296424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czMKqJh4tcRlGsMME4usdcq5yW6VzVd1f5KA80dPiWs=;
 b=YfHALrbFGH58QS0oFakuRHtdGYZbW/h7cQfTXDJ8u3hU/iwlxLAwdwUr/5GiD4J4okhLxf
 D3lnLzMZprmHCyrTt5lG89Sj4zXHdVSpDOWPwxWdLBi361/YSnFkKeVg3/NEbA2kL3yYp8
 Yc0wSj73xW31l4daNeMWrVBTuQ5IfMU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-9fzk2l76M1eC0ICfEhzqnQ-1; Tue, 25 Jul 2023 10:47:03 -0400
X-MC-Unique: 9fzk2l76M1eC0ICfEhzqnQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993d41cbc31so446934866b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690296422; x=1690901222;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=czMKqJh4tcRlGsMME4usdcq5yW6VzVd1f5KA80dPiWs=;
 b=Y6MnB8mWSicaZ2O5kQ1q8t2gmDLBxPS0WoYg4vcEi5LHCKHyRzuZViAX6vaS2ZFO/e
 2TUQ/Lpr4f418p78CVvbLKy2c8DT5mYVUr+bPt54/6iLFwseby820UOBFsoPi8hFC5cM
 ACJBtRfvzDH0Z8uwqLfvybbTSj2HeQHqMwBojyoYiYSSQND9j+WE8ottCjXW8Esm5uSN
 vnlOCHg2TQ56nhBYS439hlP5mOJidahHDYSWK5LnEy0q5ZjelxgC5YcU0HP6wochkIq1
 lKTKBG2dYIZKY4DwkHhvscmCyK/QJLrJ9BQWsRtu+IVZ9fsDJkgA3GvRjyYLfbGlL3kr
 m0GQ==
X-Gm-Message-State: ABy/qLbZ36tXfi4EEZBaqR3LGSJ6hR4W5lTZFYVdryyI9lc0rFAKBgAk
 NKhxtpMpAOm28Mxy/m9xV9G5sPR80u9J4VXKqZcT2mG7U4RcAfjaE1McgQMDcFY6WDPTQ+wKDPI
 jJOHbgGFTICKEepQ=
X-Received: by 2002:a17:906:5a4e:b0:982:30e3:ddcb with SMTP id
 my14-20020a1709065a4e00b0098230e3ddcbmr13405784ejc.65.1690296421807; 
 Tue, 25 Jul 2023 07:47:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOCleY8fOsjS2F1XQ53o8zv04LiA5HyRSDnayGvOo4Lz2cb7LsSC8MtycMI6vEnEnBy6BLGg==
X-Received: by 2002:a17:906:5a4e:b0:982:30e3:ddcb with SMTP id
 my14-20020a1709065a4e00b0098230e3ddcbmr13405767ejc.65.1690296421417; 
 Tue, 25 Jul 2023 07:47:01 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 qt9-20020a170906ece900b009927d4d7a6bsm8284290ejb.53.2023.07.25.07.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 07:47:00 -0700 (PDT)
Date: Tue, 25 Jul 2023 10:46:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 Alex Bennee <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO
 request
Message-ID: <20230725104417-mutt-send-email-mst@kernel.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
 <f267d41957025b3849324f459a8ed476aa89f828.1689857559.git.manos.pitsidianakis@linaro.org>
 <CAJ+F1C+H+82cA=mhpju-2nxRSA3BWnWJmp4-pi+G=Lsri0oGTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+H+82cA=mhpju-2nxRSA3BWnWJmp4-pi+G=Lsri0oGTw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 25, 2023 at 06:29:58PM +0400, Marc-André Lureau wrote:
> 
> 
> On Thu, Jul 20, 2023 at 4:59 PM Emmanouil Pitsidianakis <
> manos.pitsidianakis@linaro.org> wrote:
> 
>     Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
>     of each requested PCM stream.
> 
>     Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>     ---
>      hw/virtio/trace-events |  1 +
>      hw/virtio/virtio-snd.c | 78 ++++++++++++++++++++++++++++++++++++++++++
>      2 files changed, 79 insertions(+)
> 
>     diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>     index 8a223e36e9..3e619f778b 100644
>     --- a/hw/virtio/trace-events
>     +++ b/hw/virtio/trace-events
>     @@ -164,6 +164,7 @@ virtio_snd_vm_state_stopped(void) "vm state stopped"
>      virtio_snd_realize(void *snd) "snd %p: realize"
>      virtio_snd_unrealize(void *snd) "snd %p: unrealize"
>      virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event
>     for queue %p"
>     +virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called
>     for stream %"PRIu32
>      virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val
>     = %"PRIu32" == %s"
>      virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
>      virtio_snd_handle_event(void) "event queue callback called"
>     diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
>     index ca09c937c7..3f8b46f372 100644
>     --- a/hw/virtio/virtio-snd.c
>     +++ b/hw/virtio/virtio-snd.c
>     @@ -134,6 +134,19 @@ virtio_snd_set_config(VirtIODevice *vdev, const
>     uint8_t *config)
>          memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
>      }
> 
>     +/*
>     + * Get a specific stream from the virtio sound card device.
>     + * Returns NULL if @stream_id is invalid or not allocated.
>     + *
>     + * @s: VirtIOSound device
>     + * @stream_id: stream id
>     + */
>     +static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
>     +                                                       uint32_t stream_id)
>     +{
>     +    return stream_id >= s->snd_conf.streams ? NULL : s->pcm->streams
>     [stream_id];
>     +}
>     +
>      /*
>       * Get params for a specific stream.
>       *
>     @@ -147,6 +160,69 @@ static VirtIOSoundPCMParams *virtio_snd_pcm_get_params
>     (VirtIOSound *s,
>              : s->pcm->pcm_params[stream_id];
>      }
> 
>     +/*
>     + * Handle the VIRTIO_SND_R_PCM_INFO request.
>     + * The function writes the info structs to the request element.
>     + *
>     + * @s: VirtIOSound device
>     + * @cmd: The request command queue element from VirtIOSound cmdq field
>     + */
>     +static void virtio_snd_handle_pcm_info(VirtIOSound *s,
>     +                                       virtio_snd_ctrl_command *cmd)
>     +{
>     +    virtio_snd_query_info req;
>     +    VirtIOSoundPCMStream *stream = NULL;
>     +    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
>     +    size_t sz = iov_to_buf(cmd->elem->out_sg,
>     +                           cmd->elem->out_num,
>     +                           0,
>     +                           &req,
>     +                           sizeof(req));
>     +    if (sz != sizeof(virtio_snd_query_info)) {
>     +        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
>     +        return;
>     +    }
>     +
>     +    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
>     +        sizeof(virtio_snd_hdr) + req.size * req.count) {
>     +        error_report("pcm info: buffer too small, got: %lu, needed: %lu",
>     +                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
> 
>  
> 
>     +                sizeof(virtio_snd_pcm_info));
>     +        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
>     +        return;
>     +    }
>     +
>     +    pcm_info = g_new0(virtio_snd_pcm_info, req.count);
>     +    for (uint32_t i = req.start_id; i < req.start_id + req.count; i++) {
>     +        trace_virtio_snd_handle_pcm_info(i);
>     +        stream = virtio_snd_pcm_get_stream(s, i);
>     +
>     +        if (!stream) {
>     +            error_report("Invalid stream id: %"PRIu32, i);
>     +            cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
>     +            return;
>     +        }
>     +
>     +        pcm_info[i - req.start_id].hdr.hda_fn_nid = stream->
>     info.hdr.hda_fn_nid;
>     +        pcm_info[i - req.start_id].features = stream->features;
>     +        pcm_info[i - req.start_id].formats = stream->formats;
>     +        pcm_info[i - req.start_id].rates = stream->rates;
>     +        pcm_info[i - req.start_id].direction = stream->direction;
>     +        pcm_info[i - req.start_id].channels_min = stream->channels_min;
>     +        pcm_info[i - req.start_id].channels_max = stream->channels_max;
>     +
>     +        memset(&pcm_info[i].padding, 0, sizeof(pcm_info[i].padding));
>     +    }
>     +
>     +    cmd->resp.code = VIRTIO_SND_S_OK;
>     +
>     +    iov_from_buf(cmd->elem->in_sg,
>     +                 cmd->elem->in_num,
>     +                 sizeof(virtio_snd_hdr),
>     +                 pcm_info,
>     +                 sizeof(virtio_snd_pcm_info) * req.count);
>     +}
>     +
>      /*
>       * Set the given stream params.
>       * Called by both virtio_snd_handle_pcm_set_params and during device
>     @@ -358,6 +434,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command
>     *cmd)
>              cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
>              break;
>          case VIRTIO_SND_R_PCM_INFO:
>     +        virtio_snd_handle_pcm_info(s, cmd);
>     +        break;
>          case VIRTIO_SND_R_PCM_SET_PARAMS:
>          case VIRTIO_SND_R_PCM_PREPARE:
>          case VIRTIO_SND_R_PCM_START:
>     --
>     2.39.2
> 
> 
> 


Marc-André can you please stop with trying to use gmail web client?
Look here to see how it corrupts text by wrapping lines:
https://lore.kernel.org/all/CAJ+F1C+H+82cA=mhpju-2nxRSA3BWnWJmp4-pi+G=Lsri0oGTw@mail.gmail.com/

And please cut out irrelevant parts of message - I've no idea what you tried to say here.

-- 
MST


