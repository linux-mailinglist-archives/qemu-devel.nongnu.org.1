Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E9D781C2E
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 04:47:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXYS3-00055a-1F; Sat, 19 Aug 2023 22:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXYS1-00055S-Mk
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:46:01 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXYRz-0008DB-46
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:46:01 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bb97f2c99cso35076001fa.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 19:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692499556; x=1693104356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4vDaOZlOKastW42UWzzvtfoZv/QFt4vLE4cExrYLhs=;
 b=I116iSuxzZMKs+UvvMFrLVo21rXbalHSNb4om8g3Pco0oHM0S6/+14Op+lAUpd5lwa
 pnlac4JtrGcIui4G4IJyl/oQlV2+GZEz/ECcl2FqE3VyLmGS0S4aBsTx9f/o6TW6kLM8
 2opoDdND3CQENDCb7UHu6Je2A/OzJ8HdfKik33L1eUlzyq/unNR/sBSBo3UxgGBh3NHB
 vKhC6QhVTWlech8zGbkotGaSzzDjZIhx43tyiR4SqSpdBveTVhUyepCml+y2SwW4qF8d
 xRPy/UWp30jJy+nhaadyXrbd13I2FW07V92H+/Lom1lv/MVoCuTlcY/8Lgq9ljo1nao6
 075A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692499556; x=1693104356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4vDaOZlOKastW42UWzzvtfoZv/QFt4vLE4cExrYLhs=;
 b=ht2XtRdXdN8zDKam97wstgTpQ5TIRurUfFjxeEssluyfwYGASil6ReHYU+3WKiBB9K
 fbIQ7Jqq3zkxYFGU0E2anJXmpAw1I6IKtpb4uQYcxZMApVRtStLG9rX1+fXKUmkzaFcG
 XMgBLO4GJjbvtxb1mRu8sABPMqfU5LX6buS5YiwHmzQGIQKih/nBnvkrZ93SE70bhs9U
 xJF0naZ5Fo0IGPAKYwYrdt6SbEL5DhIGqXLHRIxZ/+GpiZHwGGxJqBueFxSL4jqPN+X+
 CS3igeg9+9a6QiLqyQEDJv7EAxdrwICjwjRc+orb5AoDQtT8cnDOHdpZZ5lOEzzu6lRy
 Th5Q==
X-Gm-Message-State: AOJu0YyGbkh0Fvr0vnxe/e7mCi6WbiVNPJn5UtmYbRjiAPN3SmUr9Cro
 fBIKrPds3tSPxk3xDt3WhhiY/lpa9dfgB38c1wE=
X-Google-Smtp-Source: AGHT+IGxYHvmh3pRYswnttwd3f7I3uafiU+4lWxN+ux2pJdn/WxpTNoAU/bNESRDnvmwX3DIr4Mn+k7v0wD583JdyPo=
X-Received: by 2002:a2e:9bd9:0:b0:2b9:b1b2:f97a with SMTP id
 w25-20020a2e9bd9000000b002b9b1b2f97amr2195863ljj.0.1692499555961; Sat, 19 Aug
 2023 19:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <428a8fac2a29b37757fa15ca747be93c0226cb1f.1689748694.git.yin31149@gmail.com>
 <CAJaqyWe42ykMaiwkdCOWXmtwD=p9F7gCj_TKypwOOU+yjYSdtg@mail.gmail.com>
In-Reply-To: <CAJaqyWe42ykMaiwkdCOWXmtwD=p9F7gCj_TKypwOOU+yjYSdtg@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 20 Aug 2023 10:45:44 +0800
Message-ID: <CAKrof1M5Ksz=gnMAouhPD+QJRRb7GZ2msf4=LBG8Z0m6zS7qiQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x229.google.com
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

On 2023/8/18 23:39, Eugenio Perez Martin wrote:
> On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> Next patches in this series will refactor vhost_vdpa_net_load_cmd()
>> to iterate through the control commands shadow buffers, allowing QEMU
>> to send CVQ state load commands in parallel at device startup.
>>
>> Considering that QEMU always forwards the CVQ command serialized
>> outside of vhost_vdpa_net_load(), it is more elegant to send the
>> CVQ commands directly without invoking vhost_vdpa_net_load_*() helpers.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index dd71008e08..ae8f59adaa 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -1098,12 +1098,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info =3D=
 {
>>    */
>>   static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState =
*s,
>>                                                          VirtQueueElemen=
t *elem,
>> -                                                       struct iovec *ou=
t)
>> +                                                       struct iovec *ou=
t,
>> +                                                       struct iovec *in=
)
>>   {
>>       struct virtio_net_ctrl_mac mac_data, *mac_ptr;
>>       struct virtio_net_ctrl_hdr *hdr_ptr;
>>       uint32_t cursor;
>>       ssize_t r;
>> +    uint8_t on =3D 1;
>>
>>       /* parse the non-multicast MAC address entries from CVQ command */
>>       cursor =3D sizeof(*hdr_ptr);
>> @@ -1151,7 +1153,16 @@ static int vhost_vdpa_net_excessive_mac_filter_cv=
q_add(VhostVDPAState *s,
>>        * filter table to the vdpa device, it should send the
>>        * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mo=
de
>>        */
>> -    r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1)=
;
>> +    cursor =3D 0;
>> +    hdr_ptr =3D out->iov_base;
>> +    out->iov_len =3D sizeof(*hdr_ptr) + sizeof(on);
>> +    assert(out->iov_len < vhost_vdpa_net_cvq_cmd_page_len());
>> +
>> +    hdr_ptr->class =3D VIRTIO_NET_CTRL_RX;
>> +    hdr_ptr->cmd =3D VIRTIO_NET_CTRL_RX_PROMISC;
>> +    cursor +=3D sizeof(*hdr_ptr);
>> +    *(uint8_t *)(out->iov_base + cursor) =3D on;
>> +    r =3D vhost_vdpa_net_cvq_add(s, out, 1, in, 1);
>
> Can this be done with iov_from_buf?

Hi Eugenio,

Yes, this should be done by iov_from_buf(), I will refactor the code
according to your suggestion.

Thanks!


>
>>       if (unlikely(r < 0)) {
>>           return r;
>>       }
>> @@ -1264,7 +1275,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostS=
hadowVirtqueue *svq,
>>            * the CVQ command direclty.
>>            */
>>           dev_written =3D vhost_vdpa_net_excessive_mac_filter_cvq_add(s,=
 elem,
>> -                                                                  &out)=
;
>> +                                                                  &out,=
 &in);
>>           if (unlikely(dev_written < 0)) {
>>               goto out;
>>           }
>> --
>> 2.25.1
>>
>

