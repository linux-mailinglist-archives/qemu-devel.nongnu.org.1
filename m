Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AA87BCB9A
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 03:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpIlH-0000Tr-53; Sat, 07 Oct 2023 21:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpIl8-0000Tc-OJ
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 21:39:07 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpIl6-00026t-Sk
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 21:39:06 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c296e6543fso40716041fa.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696729143; x=1697333943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jphMiIpWxDlbymSrNvb3ZaZRFaqu4UYI1LDwPsoATTk=;
 b=btKUFCX3l5TpxdqvDd56z8/t6oAi7iNUAdvMuhR9JyxLtvtwY01Cwof2RNEFbyE9Mk
 eis9LuojaqSQx8fWV5UDcaSsOtLL+lZvKhqKWBpX3PJBOeejyiELcjUGEodf3QXHfcQr
 3yoIaATsNsf/XbHdFknKFqzEPHkiSV/KGqYzmtPp34HDk3eBnX3EvaVWZsDeyaVY8ihD
 GRV5YdFUx9OB+2NzrYnTih2+Axnr8qvsIQTRbgg+C2v8BclI9pdE0kutSTBYtJOhhzA+
 nRUnLLZheCHhmSWdc/Tn9LjBmsuMw5M5Q69VonY1T419zSPSpJ33faSsrMRgcCnh2Cf/
 VceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696729143; x=1697333943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jphMiIpWxDlbymSrNvb3ZaZRFaqu4UYI1LDwPsoATTk=;
 b=KcdfN+j8wUHdTFdoF3BXziRGMoxpFZuJy+6tortpIAl3hJpkL2r9VgqI9t0Q9IuYrs
 PgRGMCJONJkFMvRwJ0dgtdfxSANWN+v1wELe58uoJH3SXUXGsswdEsQWDRoz0qZ80EGb
 siMomXGUXuik/jj/ZVd2Jbi3KjsJB9Rt5hx3XGvyaVsXvlADOLr3kxBBIWmBLR4kh2Jb
 r/7NDne2/L3TmcLppzPr8bqRpry0eNSsPZZcPm5ySa4gp9jWpYTg7zvJatHMcivgIzhX
 L3xGGBWOPEoMT4D2Pu0TSj3EYEZI/UUJGvoUsWIyIwjX+R50k08sMZAWMl4F1lIN23hM
 OHTQ==
X-Gm-Message-State: AOJu0Yw07LmZdMIz2pHXeGnJpg/k1E3MX7c1IyR+1XlwsjcIBF5JQykN
 CuKwsNK3Y9KRzezkST5o2XzPygkshx2YhvMJqRI=
X-Google-Smtp-Source: AGHT+IESvZwoQUuR/6xM9CqS7C5VJR99ySJ7RKCjThKmubXuZjQslCre8/HL+E/NYpvZxn2bsQYoo6lw9609qnGmWLM=
X-Received: by 2002:ac2:44cb:0:b0:4fe:279b:8a02 with SMTP id
 d11-20020ac244cb000000b004fe279b8a02mr10100190lfm.67.1696729142260; Sat, 07
 Oct 2023 18:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <a56d91c3cc2ab46f9be1770074c920f5375ddb5e.1693287885.git.yin31149@gmail.com>
 <CAJaqyWc8AiT0+OQffff22AkSMuwqB3EOJOVh=OknFKY0XL0FJg@mail.gmail.com>
In-Reply-To: <CAJaqyWc8AiT0+OQffff22AkSMuwqB3EOJOVh=OknFKY0XL0FJg@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 8 Oct 2023 09:38:51 +0800
Message-ID: <CAKrof1P+3+LEvqNH8KOrkcVKL7JUrsaN18qMf_LTVFVa_bj7Vg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22d.google.com
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

=E5=9C=A8 2023/10/4 01:48, Eugenio Perez Martin =E5=86=99=E9=81=93:
> On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
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
>> v4:
>>    - pack CVQ command by iov_from_buf() instead of accessing
>> `out` directly suggested by Eugenio
>>
>> v3: https://lore.kernel.org/all/428a8fac2a29b37757fa15ca747be93c0226cb1f=
.1689748694.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index e6342b213f..7c67063469 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -1097,12 +1097,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info =3D=
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
>> +                                                       const struct iov=
ec *in)
>>   {
>>       struct virtio_net_ctrl_mac mac_data, *mac_ptr;
>>       struct virtio_net_ctrl_hdr *hdr_ptr;
>>       uint32_t cursor;
>>       ssize_t r;
>> +    uint8_t on =3D 1;
>>
>>       /* parse the non-multicast MAC address entries from CVQ command */
>>       cursor =3D sizeof(*hdr_ptr);
>> @@ -1150,7 +1152,15 @@ static int vhost_vdpa_net_excessive_mac_filter_cv=
q_add(VhostVDPAState *s,
>>        * filter table to the vdpa device, it should send the
>>        * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mo=
de
>>        */
>> -    r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1)=
;
>> +    cursor =3D 0;
>
> I think this is redundant, as "cursor" is not used by the new code and
> it is already set to 0 before its usage, isn't it?
>

You are right, I will remove this code in the v5 patch.

>> +    hdr_ptr =3D out->iov_base;
>> +    out->iov_len =3D sizeof(*hdr_ptr) + sizeof(on);
>> +    assert(out->iov_len < vhost_vdpa_net_cvq_cmd_page_len());
>> +
>
> I think we can assume this assertion is never hit, as out->iov_len is
> controlled by this function.
>

Thanks for your suggestion, I will remove this assertion.

Thanks!


> Apart from these nits,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
>> +    hdr_ptr->class =3D VIRTIO_NET_CTRL_RX;
>> +    hdr_ptr->cmd =3D VIRTIO_NET_CTRL_RX_PROMISC;
>> +    iov_from_buf(out, 1, sizeof(*hdr_ptr), &on, sizeof(on));
>> +    r =3D vhost_vdpa_net_cvq_add(s, out, 1, in, 1);
>>       if (unlikely(r < 0)) {
>>           return r;
>>       }
>> @@ -1268,7 +1278,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostS=
hadowVirtqueue *svq,
>>            * the CVQ command direclty.
>>            */
>>           dev_written =3D vhost_vdpa_net_excessive_mac_filter_cvq_add(s,=
 elem,
>> -                                                                  &out)=
;
>> +                                                            &out, &vdpa=
_in);
>>           if (unlikely(dev_written < 0)) {
>>               goto out;
>>           }
>> --
>> 2.25.1
>>
>

