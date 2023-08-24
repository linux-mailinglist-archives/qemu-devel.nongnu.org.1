Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6A787827
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFI4-0003N3-Vt; Thu, 24 Aug 2023 14:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZFI0-0003Mr-QU
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:42:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZFHx-0000LY-Lc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:42:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso72774f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692902554; x=1693507354;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvP+G6vvvjC3gYWaC9D1rIPsXuMOCOoANCVsdwiLWyk=;
 b=ZUaXvYmOOrmV7olvv5eCMjv/AodPoszB9o2TZsxyWA/LnNYp2DJ9y4Oeogylw3z9hv
 CxaPoW5aa0dOv8jkHlMqZkNHFsLSS66eU1vjdg3fO2XuewsTS872erdOiHD/3011DIOm
 PMdEqEhNRzEf5wNXruC/wSUTp1qS4nNplb/I6ig2Wb5XpBbp7ZMfnhUobIgQFEGsgj0e
 cEW636mHrfMppiNPRXISq1mcMxl//rKK+7H4zAt3yMPZa6h/BcW6RvZ5hBFEoXdHGxRh
 hGKClUA8xesvXspLb22i8KoCQCPYfv4BiYDs29cz2v797MZIZTvPPRUTjno0kNDBN1lP
 fJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692902554; x=1693507354;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yvP+G6vvvjC3gYWaC9D1rIPsXuMOCOoANCVsdwiLWyk=;
 b=Ehi1zcdKlnL34m3gvRTuuohuxbZCnfJempTmpTIDApCcBm0tQhMMsiFzZPxPiCgze9
 Gnzm7BtF6HQ1phnq/MZSV8LCUdZKeXGAM4oHpYW0YgtJ0DN5V7ykPFZqJr/flvqnZMJ0
 PpA/awhmKxBJdV1UTxtsZAiwSPVSr6eJXrlWLk2CGeZLbBPWSkToXcTkidD2O3VBIF8c
 lm229GYOJi12p9mXmoO3jB2bPeZ6KsjRae+62mnUUawimbgaSFJURI1ARVW0fQYGKOk5
 fCFC12IS8LyeNwD3Q7SUAHu8esX0ix2lYlDNCH20gGE3Xq+YVEchQoec3oWHddKekLqC
 2oaA==
X-Gm-Message-State: AOJu0YwdyRBU3K26hmkMXe1qmLVe0EWhSBjs5eTvsnGsngwaGuO3UEp2
 OrVTbYT0CKu+rczB0J5jMiiOAQ==
X-Google-Smtp-Source: AGHT+IEm3VZ35Rb/gGfyWSyJaAuHiX9iGRNWnxXyYJTqypV8DXjw7XlldTe7EraZk6AyRNSJGmiUww==
X-Received: by 2002:adf:e886:0:b0:31a:d716:fd7e with SMTP id
 d6-20020adfe886000000b0031ad716fd7emr11054781wrm.71.1692902554505; 
 Thu, 24 Aug 2023 11:42:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a5d6304000000b0031431fb40fasm22917748wru.89.2023.08.24.11.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:42:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 12CC31FFBB;
 Thu, 24 Aug 2023 19:42:33 +0100 (BST)
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
 <3f43057c323a6e52a863f2b8c49419bfb3652a6d.1692731646.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 03/12] virtio-sound: handle control messages and streams
Date: Thu, 24 Aug 2023 18:50:41 +0100
In-reply-to: <3f43057c323a6e52a863f2b8c49419bfb3652a6d.1692731646.git.manos.pitsidianakis@linaro.org>
Message-ID: <87fs48ffjb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Receive guest requests in the control (CTRL) queue of the virtio sound
> device and reply with a NOT SUPPORTED error to all control commands.
>
> The receiving handler is virtio_snd_handle_ctrl(). It stores all control
> messages in the queue in the device's command queue. Then it calls
> virtio_snd_process_cmdq() to handle each message.
>
> The handler is process_cmd() which replies with VIRTIO_SND_S_NOT_SUPP.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/virtio/trace-events         |   4 +
>  hw/virtio/virtio-snd.c         | 227 ++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-snd.h |  70 +++++++++-
>  3 files changed, 292 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 3ed7da35f2..8a223e36e9 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -163,3 +163,7 @@ virtio_snd_vm_state_running(void) "vm state running"
>  virtio_snd_vm_state_stopped(void) "vm state stopped"
>  virtio_snd_realize(void *snd) "snd %p: realize"
>  virtio_snd_unrealize(void *snd) "snd %p: unrealize"
> +virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event =
for queue %p"
> +virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg va=
l =3D %"PRIu32" =3D=3D %s"
> +virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
> +virtio_snd_handle_event(void) "event queue callback called"
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> index 0498e660a5..b23f8040e1 100644
> --- a/hw/virtio/virtio-snd.c
> +++ b/hw/virtio/virtio-snd.c
> @@ -30,6 +30,29 @@
>  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
>  #define VIRTIO_SOUND_HDA_FN_NID 0
>=20=20
> +static const char *print_code(uint32_t code)
> +{
> +    #define CASE(CODE)            \
> +    case VIRTIO_SND_R_##CODE:     \
> +        return "VIRTIO_SND_R_"#CODE
> +
> +    switch (code) {
> +    CASE(JACK_INFO);
> +    CASE(JACK_REMAP);
> +    CASE(PCM_INFO);
> +    CASE(PCM_SET_PARAMS);
> +    CASE(PCM_PREPARE);
> +    CASE(PCM_RELEASE);
> +    CASE(PCM_START);
> +    CASE(PCM_STOP);
> +    CASE(CHMAP_INFO);
> +    default:
> +        return "invalid code";
> +    }
> +
> +    #undef CASE
> +};
> +
>  static const VMStateDescription vmstate_virtio_snd_device =3D {
>      .name =3D TYPE_VIRTIO_SND,
>      .version_id =3D VIRTIO_SOUND_VM_VERSION,
> @@ -88,12 +111,148 @@ virtio_snd_set_config(VirtIODevice *vdev, const uin=
t8_t *config)
>  }
>=20=20
>  /*
> - * Queue handler stub.
> + * The actual processing done in virtio_snd_process_cmdq().
> + *
> + * @s: VirtIOSound device
> + * @cmd: control command request
> + */
> +static inline void
> +process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
> +{
> +    size_t sz =3D iov_to_buf(cmd->elem->out_sg,
> +                           cmd->elem->out_num,
> +                           0,
> +                           &cmd->ctrl,
> +                           sizeof(cmd->ctrl));
> +    if (sz !=3D sizeof(cmd->ctrl)) {
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
> +        cmd->resp.code =3D VIRTIO_SND_S_NOT_SUPP;
> +        break;
> +    case VIRTIO_SND_R_PCM_INFO:
> +    case VIRTIO_SND_R_PCM_SET_PARAMS:
> +    case VIRTIO_SND_R_PCM_PREPARE:
> +    case VIRTIO_SND_R_PCM_START:
> +    case VIRTIO_SND_R_PCM_STOP:
> +    case VIRTIO_SND_R_PCM_RELEASE:
> +        cmd->resp.code =3D VIRTIO_SND_S_NOT_SUPP;
> +        break;
> +    case VIRTIO_SND_R_CHMAP_INFO:
> +        qemu_log_mask(LOG_UNIMP,
> +                     "virtio_snd: chmap info functionality is unimplemen=
ted.");
> +        trace_virtio_snd_handle_chmap_info();
> +        cmd->resp.code =3D VIRTIO_SND_S_NOT_SUPP;
> +        break;
> +    default:
> +        /* error */
> +        error_report("virtio snd header not recognized: %"PRIu32,
> +                     cmd->ctrl.code);
> +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
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
> +            cmd =3D QTAILQ_FIRST(&s->cmdq);
> +
> +            /* process command */
> +            process_cmd(s, cmd);
> +
> +            QTAILQ_REMOVE(&s->cmdq, cmd, next);
> +
> +            g_free(cmd);
> +        }
> +        qatomic_set(&s->processing_cmdq, false);
> +    }
> +}
> +
> +/*
> + * The control message handler. Pops an element from the control virtque=
ue,
> + * and stores them to VirtIOSound's cmdq queue and finally calls
> + * virtio_snd_process_cmdq() for processing.
> + *
> + * @vdev: VirtIOSound device
> + * @vq: Control virtqueue
> + */
> +static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    VirtQueueElement *elem;
> +    virtio_snd_ctrl_command *cmd;
> +
> +    trace_virtio_snd_handle_ctrl(vdev, vq);
> +
> +    if (!virtio_queue_ready(vq)) {
> +        return;
> +    }
> +
> +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    while (elem) {
> +        cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> +        cmd->elem =3D elem;
> +        cmd->vq =3D vq;
> +        cmd->resp.code =3D VIRTIO_SND_S_OK;
> +        QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
> +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    }
> +
> +    virtio_snd_process_cmdq(s);
> +}
> +
> +/*
> + * The event virtqueue handler.
> + * Not implemented yet.
> + *
> + * @vdev: VirtIOSound device
> + * @vq: event vq
> + */
> +static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented."=
);
> +    trace_virtio_snd_handle_event();
> +}
> +
> +/*
> + * Stub buffer virtqueue handler.
>   *
>   * @vdev: VirtIOSound device
>   * @vq: virtqueue
>   */
> -static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) {}
> +static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
>=20=20
>  static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
>                               Error **errp)
> @@ -111,6 +270,18 @@ static uint64_t get_features(VirtIODevice *vdev, uin=
t64_t features,
>      return features;
>  }
>=20=20
> +static void virtio_snd_set_pcm(VirtIOSound *snd)
> +{
> +    VirtIOSoundPCM *pcm;
> +
> +    pcm =3D g_new0(VirtIOSoundPCM, 1);
> +    pcm->snd =3D snd;
> +    pcm->streams =3D g_new0(VirtIOSoundPCMStream *, snd->snd_conf.stream=
s);
> +    pcm->pcm_params =3D g_new0(VirtIOSoundPCMParams, snd->snd_conf.strea=
ms);
> +
> +    snd->pcm =3D pcm;
> +}
> +
>  static void virtio_snd_common_realize(DeviceState *dev,
>                                        VirtIOHandleOutput ctrl,
>                                        VirtIOHandleOutput evt,
> @@ -121,6 +292,8 @@ static void virtio_snd_common_realize(DeviceState *de=
v,
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIOSound *vsnd =3D VIRTIO_SND(dev);
>=20=20
> +    virtio_snd_set_pcm(vsnd);
> +
>      virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
>      virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
>=20=20
> @@ -151,6 +324,8 @@ static void virtio_snd_common_realize(DeviceState *de=
v,
>      vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D virtio_add_queue(vdev, 64, evt=
);
>      vsnd->queues[VIRTIO_SND_VQ_TX] =3D virtio_add_queue(vdev, 64, txq);
>      vsnd->queues[VIRTIO_SND_VQ_RX] =3D virtio_add_queue(vdev, 64, rxq);
> +    qemu_mutex_init(&vsnd->cmdq_mutex);
> +    QTAILQ_INIT(&vsnd->cmdq);
>  }
>=20=20
>  static void
> @@ -168,35 +343,73 @@ static void virtio_snd_realize(DeviceState *dev, Er=
ror **errp)
>      ERRP_GUARD();
>      VirtIOSound *vsnd =3D VIRTIO_SND(dev);
>=20=20
> +    vsnd->pcm =3D NULL;
>      vsnd->vmstate =3D
>          qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsn=
d);
>=20=20
>      trace_virtio_snd_realize(vsnd);
>=20=20
>      virtio_snd_common_realize(dev,
> -                              virtio_snd_handle_queue,
> -                              virtio_snd_handle_queue,
> -                              virtio_snd_handle_queue,
> -                              virtio_snd_handle_queue,

Given handle queue only lasts for 2 patches you might as well start with
3 stubs for the queues in the first patch.

> +                              virtio_snd_handle_ctrl,
> +                              virtio_snd_handle_event,
> +                              virtio_snd_handle_xfer,
> +                              virtio_snd_handle_xfer,
>                                errp);
>  }

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

