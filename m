Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE0707A6F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzXXY-0005FA-EA; Thu, 18 May 2023 02:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1pzXXV-0005Ez-UW
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:55:05 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1pzXXS-0003x1-I8
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:55:05 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4eff4ea8e39so1876638e87.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684392901; x=1686984901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OzEdlFax0KpN9foi2lZbvUwqBTg2vDaYuKEe5VQbj4I=;
 b=PGZSjxyXmU1Q7BrxVIN4kQGWPT2tkLOUx9hcdZh9Mlk9hYt9qgbxMvL83TCOgo0JtB
 nKL4XrmEfqc73QsMsnEkERrDa3mASmjW8v07tuGe689GiRc72LDJIA7n5ltj9qFAEPOm
 QGY6+zR2OoHGjNNT6fCP0AoaiLi4kbW+IoMkR6GPSpPY9dP+xkwE4c1Z7Phr/3UdZvjV
 RDR2QYYycE9QCBHhEhLkobgxaQBEWQAi47pi/4pP1IRieTVmWnS58GdE9LeTrPvSZsaJ
 CRwiNuNAA7RzXngP+Re62ZfFWw4KorXGxaNHxGNZi20dizoav6ZjL4gHmiXkQvpSp2T2
 Fj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684392901; x=1686984901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzEdlFax0KpN9foi2lZbvUwqBTg2vDaYuKEe5VQbj4I=;
 b=Jqxrkiiv3s+RSNl12SH6cv/e3dchGAle8RsxU1LsL+/LwaJJN3ENWapG9KFp8M3BsP
 icGyu5If4ghyOm2J7PcYEEqdfQR+PP2hIDdcvgKSdRfvsB9TLm5msaLWAK0JCyxX4f7K
 FST4H52aHE2sdH8gY805+skWpp65G+FgL/tCZXlLQhfrtOo1FL1JURX52qrJ0CHu4vIh
 TBxpxLccphbmVrwgzQ25n8scjemL2J4VZnQEcs7eS6oLvYqAPoh2A2QnlJ8gMY59POMs
 me/9AM5iqNmdNJGFcy79uSvDXeKDFIGRriIDZktstEdo4l5OSHJrieCA8ICKa4TEpbA8
 FvoA==
X-Gm-Message-State: AC+VfDxs3IyTCJ/vxpYdVsJ68SmV8TNRRtPHMyiXMLQGfNfboGEnwBX4
 R4dZcGQfksBJnRuJXuXWgkZIyp1qIKiVFXE1ClI=
X-Google-Smtp-Source: ACHHUZ7rrXxKCsr9nbMth+dRwUUrEONDPQ9Y8ONO6HcsqToyiylD3mkAHnpwh4l4toA/gC/RCjyd9Htcq9y2MHnomuI=
X-Received: by 2002:ac2:5491:0:b0:4f0:ff66:b4f1 with SMTP id
 t17-20020ac25491000000b004f0ff66b4f1mr997299lfk.22.1684392900120; Wed, 17 May
 2023 23:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
 <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
 <CAJaqyWc2hHKb_F11ZCF0ewCk8bc7g5O-U08OxMHLWDx1erg8Sg@mail.gmail.com>
 <CAKrof1MCLXB4CG9umV4oTo_Wfkaw4ADXxyD925ej9NM0ccgjzg@mail.gmail.com>
 <CACGkMEuKYnu0st4UttOhGb56Y5tvi3pnFPRM_RgSTj_rQicZqg@mail.gmail.com>
 <CAJaqyWde_GrJHp9zbY4vfDdkMeUpemE24J=zvSqdZ1ji2CXhxQ@mail.gmail.com>
 <CACGkMEtWpDvv-_Y6CcQo3xOQun+xYYqCv10sfh0obd-FMaX7XQ@mail.gmail.com>
In-Reply-To: <CACGkMEtWpDvv-_Y6CcQo3xOQun+xYYqCv10sfh0obd-FMaX7XQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Thu, 18 May 2023 14:54:47 +0800
Message-ID: <CAKrof1MhLekbSYJYGr8kQTc9sQeY_8xvfx763w+iKOGnwp+oSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: send CVQ state load commands in parallel
To: Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: 18801353760@163.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/5/18 14:12, Jason Wang wrote:
> On Thu, May 18, 2023 at 2:00=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
>>
>> On Thu, May 18, 2023 at 7:47=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
>>>
>>> On Wed, May 17, 2023 at 11:02=E2=80=AFPM Hawkins Jiawei <yin31149@gmail=
.com> wrote:
>>>>
>>>> Sorry for forgetting cc when replying to the email.
>>>>
>>>> On Wed, 17 May 2023 at 16:22, Eugenio Perez Martin <eperezma@redhat.co=
m> wrote:
>>>>>
>>>>> On Wed, May 17, 2023 at 7:22=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
>>>>>>
>>>>>> On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@gma=
il.com> wrote:
>>>>>>>
>>>>>>> This patch introduces the vhost_vdpa_net_cvq_add() and
>>>>>>> refactors the vhost_vdpa_net_load*(), so that QEMU can
>>>>>>> send CVQ state load commands in parallel.
>>>>>>>
>>>>>>> To be more specific, this patch introduces vhost_vdpa_net_cvq_add()
>>>>>>> to add SVQ control commands to SVQ and kick the device,
>>>>>>> but does not poll the device used buffers. QEMU will not
>>>>>>> poll and check the device used buffers in vhost_vdpa_net_load()
>>>>>>> until all CVQ state load commands have been sent to the device.
>>>>>>>
>>>>>>> What's more, in order to avoid buffer overwriting caused by
>>>>>>> using `svq->cvq_cmd_out_buffer` and `svq->status` as the
>>>>>>> buffer for all CVQ state load commands when sending
>>>>>>> CVQ state load commands in parallel, this patch introduces
>>>>>>> `out_cursor` and `in_cursor` in vhost_vdpa_net_load(),
>>>>>>> pointing to the available buffer for in descriptor and
>>>>>>> out descriptor, so that different CVQ state load commands can
>>>>>>> use their unique buffer.
>>>>>>>
>>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
>>>>>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>>>>>> ---
>>>>>>>   net/vhost-vdpa.c | 152 +++++++++++++++++++++++++++++++++++++-----=
-----
>>>>>>>   1 file changed, 120 insertions(+), 32 deletions(-)
>>>>>>>
>>>>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>>>>> index 10804c7200..14e31ca5c5 100644
>>>>>>> --- a/net/vhost-vdpa.c
>>>>>>> +++ b/net/vhost-vdpa.c
>>>>>>> @@ -590,6 +590,44 @@ static void vhost_vdpa_net_cvq_stop(NetClientS=
tate *nc)
>>>>>>>       vhost_vdpa_net_client_stop(nc);
>>>>>>>   }
>>>>>>>
>>>>>>> +/**
>>>>>>> + * vhost_vdpa_net_cvq_add() adds SVQ control commands to SVQ,
>>>>>>> + * kicks the device but does not poll the device used buffers.
>>>>>>> + *
>>>>>>> + * Return the number of elements added to SVQ if success.
>>>>>>> + */
>>>>>>> +static int vhost_vdpa_net_cvq_add(VhostVDPAState *s,
>>>>>>> +                                void **out_cursor, size_t out_len,
>>>>>>
>>>>>> Can we track things like cursors in e.g VhostVDPAState ?
>>>>>>
>>>>>
>>>>> Cursors will only be used at device startup. After that, cursors are
>>>>> always the full buffer. Do we want to "pollute" VhostVDPAState with
>>>>> things that will not be used after the startup?
>>>
>>> So it's the cursor of the cvq_cmd_out_buffer, it would be more elegant
>>> to keep it with where the cvq_cmd_out_buffer is placed. It can avoid
>>> passing cursors in several levels.
>>> >>
>> That's right, there is no reason to update at vhost_vdpa_net_cvq_add.
>> It can be done at the caller.

But in any case, these cursors need to be passed as alone parameters to
vhost_vdpa_net_cvq_add(), so that they can be accessed for
`struct iovec` `iov_base` field, right? Considering that
we always pass these parameters, so I also update them together in
vhost_vdpa_net_cvq_add() in this patch.

If we want to avoid passing cursors in several levels, is it okay
to backup `cvq_cmd_out_buffer` and `status` in vhost_vdpa_net_load(),
access and update them through `VhostVDPAState` directly during loading,
and restore them when finishing loading.

>>
>>> Or it would be even better to have some buffer allocation helpers to
>>> alloc and free in and out buffers.
>>>
>>
>> I think that's overkill, as the buffers are always the in and out CVQ
>> buffers. They are allocated at qemu initialization, and mapped /
>> unmapped at device start / stop for now.
>
> It's not a must, we can do it if it has more users for sure.
>
>>
>> To manage them dynamically would need code to map them at any time etc.
>
> Thanks
>
>>
>> Thanks!
>>
>>> Thanks
>>>
>>>>>
>>>>> Maybe we can create a struct for them and then pass just this struct?
>>>>
>>>> Yes, Currently, the new version of vhost_vdpa_net_cvq_add() is only
>>>> called in vhost_vdpa_net_load() at startup, so these cursors will not =
be
>>>> used after startup.
>>>>
>>>> If needed, we can create a `VhostVDPACursor` as suggested by Eugenio.
>>>>
>>>>>
>>>>> Thanks!
>>>>>
>>>>>>> +                                virtio_net_ctrl_ack **in_cursor, s=
ize_t in_len)
>>>>>>> +{
>>>>>>> +    /* Buffers for the device */
>>>>>>> +    const struct iovec out =3D {
>>>>>>> +        .iov_base =3D *out_cursor,
>>>>>>> +        .iov_len =3D out_len,
>>>>>>> +    };
>>>>>>> +    const struct iovec in =3D {
>>>>>>> +        .iov_base =3D *in_cursor,
>>>>>>> +        .iov_len =3D sizeof(virtio_net_ctrl_ack),
>>>>>>> +    };
>>>>>>> +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.=
shadow_vqs, 0);
>>>>>>> +    int r;
>>>>>>> +
>>>>>>> +    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
>>>>>>> +    if (unlikely(r !=3D 0)) {
>>>>>>> +        if (unlikely(r =3D=3D -ENOSPC)) {
>>>>>>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device=
 queue\n",
>>>>>>> +                          __func__);
>>>>>>> +        }
>>>>>>> +        return r;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    /* Update the cursor */
>>>>>>> +    *out_cursor +=3D out_len;
>>>>>>> +    *in_cursor +=3D 1;
>>>>>>> +
>>>>>>> +    return 1;
>>>>>>> +}
>>>>>>> +
>>>>>>>   /**
>>>>>>>    * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands to=
 SVQ,
>>>>>>>    * kicks the device and polls the device used buffers.
>>>>>>> @@ -628,69 +666,82 @@ static ssize_t vhost_vdpa_net_cvq_add_and_wai=
t(VhostVDPAState *s,
>>>>>>>       return vhost_svq_poll(svq);
>>>>>>>   }
>>>>>>>
>>>>>>> -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t =
class,
>>>>>>> -                                       uint8_t cmd, const void *da=
ta,
>>>>>>> -                                       size_t data_size)
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * vhost_vdpa_net_load_cmd() restores the NIC state through SVQ.
>>>>>>> + *
>>>>>>> + * Return the number of elements added to SVQ if success.
>>>>>>> + */
>>>>>>> +static int vhost_vdpa_net_load_cmd(VhostVDPAState *s,
>>>>>>> +                                void **out_cursor, uint8_t class, =
uint8_t cmd,
>>>>>>> +                                const void *data, size_t data_size=
,
>>>>>>> +                                virtio_net_ctrl_ack **in_cursor)
>>>>>>>   {
>>>>>>>       const struct virtio_net_ctrl_hdr ctrl =3D {
>>>>>>>           .class =3D class,
>>>>>>>           .cmd =3D cmd,
>>>>>>>       };
>>>>>>>
>>>>>>> -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(=
ctrl));
>>>>>>> +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
>>>>>>> +                          (*out_cursor - s->cvq_cmd_out_buffer));
>>>>>>> +    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(=
ctrl) -
>>>>>>> +                       (*out_cursor - s->cvq_cmd_out_buffer));
>>>>>>>
>>>>>>> -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
>>>>>>> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
>>>>>>> +    memcpy(*out_cursor, &ctrl, sizeof(ctrl));
>>>>>>> +    memcpy(*out_cursor + sizeof(ctrl), data, data_size);
>>>>>>>
>>>>>>> -    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + data_=
size,
>>>>>>> -                                  sizeof(virtio_net_ctrl_ack));
>>>>>>> +    return vhost_vdpa_net_cvq_add(s, out_cursor, sizeof(ctrl) + da=
ta_size,
>>>>>>> +                                  in_cursor, sizeof(virtio_net_ctr=
l_ack));
>>>>>>>   }
>>>>>>>
>>>>>>> -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIO=
Net *n)
>>>>>>> +/**
>>>>>>> + * vhost_vdpa_net_load_mac() restores the NIC mac through SVQ.
>>>>>>> + *
>>>>>>> + * Return the number of elements added to SVQ if success.
>>>>>>> + */
>>>>>>> +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIO=
Net *n,
>>>>>>> +                            void **out_cursor, virtio_net_ctrl_ack=
 **in_cursor)
>>>>>>>   {
>>>>>>>       uint64_t features =3D n->parent_obj.guest_features;
>>>>>>>       if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
>>>>>>> -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_=
NET_CTRL_MAC,
>>>>>>> -                                                  VIRTIO_NET_CTRL_=
MAC_ADDR_SET,
>>>>>>> -                                                  n->mac, sizeof(n=
->mac));
>>>>>>> -        if (unlikely(dev_written < 0)) {
>>>>>>> -            return dev_written;
>>>>>>> -        }
>>>>>>> -
>>>>>>> -        return *s->status !=3D VIRTIO_NET_OK;
>>>>>>> +        return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_C=
TRL_MAC,
>>>>>>> +                                       VIRTIO_NET_CTRL_MAC_ADDR_SE=
T,
>>>>>>> +                                       n->mac, sizeof(n->mac), in_=
cursor);
>>>>>>>       }
>>>>>>>
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>>
>>>>>>> -static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>>>>>> -                                  const VirtIONet *n)
>>>>>>> +/**
>>>>>>> + * vhost_vdpa_net_load_mac() restores the NIC mq state through SVQ=
.
>>>>>>> + *
>>>>>>> + * Return the number of elements added to SVQ if success.
>>>>>>> + */
>>>>>>> +static int vhost_vdpa_net_load_mq(VhostVDPAState *s, const VirtION=
et *n,
>>>>>>> +                            void **out_cursor, virtio_net_ctrl_ack=
 **in_cursor)
>>>>>>>   {
>>>>>>>       struct virtio_net_ctrl_mq mq;
>>>>>>>       uint64_t features =3D n->parent_obj.guest_features;
>>>>>>> -    ssize_t dev_written;
>>>>>>>
>>>>>>>       if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
>>>>>>>           return 0;
>>>>>>>       }
>>>>>>>
>>>>>>>       mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
>>>>>>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
>>>>>>> -                                          VIRTIO_NET_CTRL_MQ_VQ_PA=
IRS_SET, &mq,
>>>>>>> -                                          sizeof(mq));
>>>>>>> -    if (unlikely(dev_written < 0)) {
>>>>>>> -        return dev_written;
>>>>>>> -    }
>>>>>>> -
>>>>>>> -    return *s->status !=3D VIRTIO_NET_OK;
>>>>>>> +    return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTRL_=
MQ,
>>>>>>> +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=
,
>>>>>>> +                                   &mq, sizeof(mq), in_cursor);
>>>>>>>   }
>>>>>>>
>>>>>>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>>>>>>   {
>>>>>>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>>>>>>> +    VhostShadowVirtqueue *svq;
>>>>>>> +    void *out_cursor;
>>>>>>> +    virtio_net_ctrl_ack *in_cursor;
>>>>>>>       struct vhost_vdpa *v =3D &s->vhost_vdpa;
>>>>>>>       const VirtIONet *n;
>>>>>>> -    int r;
>>>>>>> +    ssize_t cmds_in_flight =3D 0, dev_written, r;
>>>>>>>
>>>>>>>       assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>>>>>>>
>>>>>>> @@ -699,14 +750,51 @@ static int vhost_vdpa_net_load(NetClientState=
 *nc)
>>>>>>>       }
>>>>>>>
>>>>>>>       n =3D VIRTIO_NET(v->dev->vdev);
>>>>>>> -    r =3D vhost_vdpa_net_load_mac(s, n);
>>>>>>> +    out_cursor =3D s->cvq_cmd_out_buffer;
>>>>>>> +    in_cursor =3D s->status;
>>>>>>> +
>>>>>>> +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
>>>>>>>       if (unlikely(r < 0))
>>>>>>>           return r;
>>>>>>>       }
>>>>>>> -    r =3D vhost_vdpa_net_load_mq(s, n);
>>>>>>> -    if (unlikely(r)) {
>>>>>>> +    cmds_in_flight +=3D r;
>>>>>>> +
>>>>>>> +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
>>>>>>> +    if (unlikely(r < 0)) {
>>>>>>>           return r;
>>>>>>>       }
>>>>>>> +    cmds_in_flight +=3D r;
>>>>>>> +
>>>>>>> +    /* Poll for all used buffer from device */
>>>>>>> +    svq =3D g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
>>>>>>> +    while (cmds_in_flight > 0) {
>>>>>>> +        /*
>>>>>>> +         * We can poll here since we've had BQL from the time we s=
ent the
>>>>>>> +         * descriptor. Also, we need to take the answer before SVQ=
 pulls
>>>>>>> +         * by itself, when BQL is released
>>>>>>> +         */
>>>>>>> +        dev_written =3D vhost_svq_poll(svq);
>>>>>>
>>>>>> I'd tweak vhost_svq_poll to accept cmds_in_flight.
>>>>
>>>> That sounds great!
>>>> I will refactor the code here and send the v2 patch after
>>>> your patch.
>>>>
>>>> Thanks!
>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>> +
>>>>>>> +        if (unlikely(!dev_written)) {
>>>>>>> +            /*
>>>>>>> +             * vhost_svq_poll() return 0 when something wrong, suc=
h as
>>>>>>> +             * QEMU waits for too long time or no available used b=
uffer
>>>>>>> +             * from device, and there is no need to continue polli=
ng
>>>>>>> +             * in this case.
>>>>>>> +             */
>>>>>>> +            return -EINVAL;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        --cmds_in_flight;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    /* Check the buffers written by device */
>>>>>>> +    for (virtio_net_ctrl_ack *status =3D s->status; status < in_cu=
rsor;
>>>>>>> +         ++status) {
>>>>>>> +        if (*status !=3D VIRTIO_NET_OK) {
>>>>>>> +            return -EINVAL;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>>
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>> --
>>>>>>> 2.25.1
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>

