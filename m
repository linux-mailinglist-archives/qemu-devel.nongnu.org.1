Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 110987BCB99
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 03:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpIhe-00081X-Qt; Sat, 07 Oct 2023 21:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpIhb-00081J-2u
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 21:35:27 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpIhQ-0001Fp-Tx
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 21:35:26 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50435a9f800so4419766e87.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 18:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696728914; x=1697333714; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUH2OirCBs16S0uy9Zjjfnreaal+GFmGPDQ+dvt+h8E=;
 b=lYQB0A5NUvNWX3l/iTe6tnTndyZwF/hEKJLaFnleiy9yRxKtnLOHNth+Zo265F77Hs
 lX9VGRzuwiuzhdFdiFmuU4fgGlKyQjMrNHUGVHOF+kd4ws2QBh3R2zA5Xfx1/vpcCM+W
 SXtcYq/tRWt/1qw+2kpnOteEGlPUzeLwjr2KTE12jadnYrNoyb1hHtvuixxbQNP1SEJH
 w+Xz7KQTgroWJzSJNwKU4HR0R1LoqNYVUg6lKZdtYhRhR/7Ztf/CxNZL/cjsXLzGOLw/
 VfaADUKZHaEswIvzXuM1Cm3hTVnQoksR4ygwqLMpGLAdMJLIEcQfXI09KIyQ2p/aTg/4
 CxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696728914; x=1697333714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUH2OirCBs16S0uy9Zjjfnreaal+GFmGPDQ+dvt+h8E=;
 b=EjBKxG0pi0OMxeu3Z+04qFHYkltt+GyPgfmqaC3mHZqzASmgxYf55eD1vdE6g7TGJf
 LmPY0H1FoizNLLkM4TzlRIdDb/oPP9YCuIxauAjR23YBCxdg2VG6SgsGuiSIoBTyGhYP
 vmURM479vUCFqXv0U9zIX9Eh/0wfExFb/EwqSmoMCUsPd+jNqaBaCDdj/LCzMnIq0TBh
 EiOM8vMUNNnzI5xbaetZQ3Tuy+mnSeF4MA3c6xAhoc8cWMC/sJD8F2tdL6bZKdRS49mu
 k2hc4jlWspqEjsXvYBteQHGKKo+9xEl06QTLCM7KSK0V9jUVJ3aQbrgorV9gTsrGIltd
 zjSA==
X-Gm-Message-State: AOJu0YyaoHD36wjarVRAQXitFvxhxydxisd8MpdkayU2AKNphqaA+wpw
 nfxYstlnDTotv9EvLUl2G2HLqkWU+ObvVVWnlQEEnZruqFLnqdC2
X-Google-Smtp-Source: AGHT+IHNepTPig18thLQ1N2UxctYwIuZyZXoDO2QmhELxoP/X3D8P8ZUqUy2sgJlvo+xzKsD8dV8zQFQ4D9CRNCTwBc=
X-Received: by 2002:ac2:4ec7:0:b0:503:317b:8b7c with SMTP id
 p7-20020ac24ec7000000b00503317b8b7cmr7756090lfr.9.1696728913480; Sat, 07 Oct
 2023 18:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <13b3a36cc33c443a47525957ea38e80594d90595.1693287885.git.yin31149@gmail.com>
 <CAJaqyWf-jE79jq33FJM8HU=nAjq4qAd+TLHu6Xxt8SS-xYWbJw@mail.gmail.com>
In-Reply-To: <CAJaqyWf-jE79jq33FJM8HU=nAjq4qAd+TLHu6Xxt8SS-xYWbJw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 8 Oct 2023 09:35:01 +0800
Message-ID: <CAKrof1O372z2dRocUzNFhQbHRqwCuuLsp2+UDiJQdRBz_rbsxA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] vhost: Expose vhost_svq_available_slots()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

=E5=9C=A8 2023/10/4 01:44, Eugenio Perez Martin =E5=86=99=E9=81=93:
> On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> Next patches in this series will delay the polling
>> and checking of buffers until either the SVQ is
>> full or control commands shadow buffers are full,
>> no longer perform an immediate poll and check of
>> the device's used buffers for each CVQ state load command.
>>
>> To achieve this, this patch exposes
>> vhost_svq_available_slots() and introduces a helper function,
>> allowing QEMU to know whether the SVQ is full.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>> ---
>>   hw/virtio/vhost-shadow-virtqueue.c | 2 +-
>>   hw/virtio/vhost-shadow-virtqueue.h | 1 +
>>   net/vhost-vdpa.c                   | 9 +++++++++
>>   3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow=
-virtqueue.c
>> index e731b1d2ea..fc5f408f77 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>> @@ -66,7 +66,7 @@ bool vhost_svq_valid_features(uint64_t features, Error=
 **errp)
>>    *
>>    * @svq: The svq
>>    */
>> -static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *s=
vq)
>> +uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
>>   {
>>       return svq->num_free;
>>   }
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow=
-virtqueue.h
>> index 5bce67837b..19c842a15b 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.h
>> +++ b/hw/virtio/vhost-shadow-virtqueue.h
>> @@ -114,6 +114,7 @@ typedef struct VhostShadowVirtqueue {
>>
>>   bool vhost_svq_valid_features(uint64_t features, Error **errp);
>>
>> +uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
>>   void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
>>                            const VirtQueueElement *elem, uint32_t len);
>>   int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_s=
g,
>
> I think it is ok to split this export in its own patch. If you decide
> to do it that way, you can add my Acked-by.

I will split this in its own patch, thanks for your suggestion!

>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index a875767ee9..e6342b213f 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -620,6 +620,13 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAStat=
e *s,
>>       return vhost_svq_poll(svq, 1);
>>   }
>>
>> +/* Convenience wrapper to get number of available SVQ descriptors */
>> +static uint16_t vhost_vdpa_net_svq_available_slots(VhostVDPAState *s)
>> +{
>> +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shado=
w_vqs, 0);
>
> This is not really generic enough for all VhostVDPAState, as dataplane
> ones have two svqs.
>
> I think the best is to just inline the function in the caller, as
> there is only one, isn't it? If not, would it work to just replace
> _net_ by _cvq_ or similar?
>

Yes, there should be only one user for this function, I will inline
the function in the caller.

>> +    return vhost_svq_available_slots(svq);
>> +}
>> +
>>   static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t clas=
s,
>>                                          uint8_t cmd, const struct iovec=
 *data_sg,
>>                                          size_t data_num)
>> @@ -640,6 +647,8 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAStat=
e *s, uint8_t class,
>>       };
>>
>>       assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
));
>> +    /* Each CVQ command has one out descriptor and one in descriptor */
>> +    assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>>
>
> I think we should remove this assertion. By the end of the series
> there is an "if" checks explicitly for the opposite condition, and
> flushing the queue in that case, so the code can never reach it.
>

Yes, you are right. I will remove this assertion.

Thanks!


>>       /* pack the CVQ command header */
>>       memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
>> --
>> 2.25.1
>>
>

