Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A189171FB03
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:32:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4zFE-0001oJ-4i; Fri, 02 Jun 2023 03:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4zFA-0001l9-2n
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:30:40 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4zF8-0003vh-2S
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:30:39 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2af1822b710so24936571fa.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 00:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685691036; x=1688283036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmjsx7/aQuPxY7+koDqYM+GmeGduwQa3k44K3VetQRk=;
 b=lKz84+StebpvxCDNlKAFETywGW361KNRj7H6qBA42jHX2+Ca2H7vMyNN90PWRGQ9bW
 TE4P7j/JvvBd0uv8dSRk6YPZU4HvXEuloya4rdCEABsqTlaSnEllIxw3CsrIhyL6bVAn
 eV3U4+/6614rgOzuIr/id5uTZOstPLoa7YzIai53oQqoSPYiKk6oOYzgaoq0I/AkLhjb
 8O44r5hHfXupejR58gdKGgFNHnOttvFI8KKcAadCoKa7Z2ENYrfiHXktKFLRdlhA4QEk
 UwdYrCfb4Cf8aB3pWgfVI5+gEoZLeVr4s+rjaYXbNx4PnJekcneiF3lFj0XURd2OH4Wz
 CL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685691036; x=1688283036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmjsx7/aQuPxY7+koDqYM+GmeGduwQa3k44K3VetQRk=;
 b=UGJPrkpcTiNwpHtzH/JLG2DO1YWR3bLurMifS4/REgrgGPGXex7pZb++tFJiaQshSS
 zK4VMp0s7CoivOy1ujWSzvFQXfjsoh42k2BgN6wWOlVzH9RbpvGjS0Ag22t3HDEDKDSb
 f9KOWkx+HcdigqBszUJGGO7kVrLVMAlosQ+LYQd36w3eE4DSCq+bSlz95w7+61gwrrls
 YneKjOQD6iHArkMgIt0pNP2XjxAbYkb9ClQXLJpazGA+RaLOt3CE3Sm1HhIC9gNIwIYA
 xWQOzbOOaR0s4CbD5oQMqzrGIyj5E34YHzDh9sGQJixsFYcAoiN0+hRDA4gp+7dbn7RL
 J7iw==
X-Gm-Message-State: AC+VfDxGVBYeNa+8YxKMC5OwcuAHxHmyRdmnmZUcXunv2ewzrnmxVwFr
 jUf6rgQzDUpHdKMV/7kdqCwZACh7XQ0qfqPs2e8=
X-Google-Smtp-Source: ACHHUZ5aLOict8l5X5vbuRiuUWEjxIs1VfCYDWUMmyXLew3V/apJ/MdR7Q641yw2hwol/AxBPJ2ApNOPf6V52AnYCDs=
X-Received: by 2002:a2e:300f:0:b0:2b0:a4b1:df6 with SMTP id
 w15-20020a2e300f000000b002b0a4b10df6mr1021117ljw.49.1685691035701; Fri, 02
 Jun 2023 00:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <afa2e25ae333dba5867e3d839fba785d5d3508c0.1685623090.git.yin31149@gmail.com>
 <CAJaqyWcS6enrAxwcGsi2qVt+7pHOkZg4E+t-=rmvsdPFbN-S6w@mail.gmail.com>
In-Reply-To: <CAJaqyWcS6enrAxwcGsi2qVt+7pHOkZg4E+t-=rmvsdPFbN-S6w@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Fri, 2 Jun 2023 15:30:23 +0800
Message-ID: <CAKrof1OSb=0rQJeWgvhiND3jszwYu2X8cNe5o88q7eX61vNehg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] vdpa: Add vhost_vdpa_net_load_offloads()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x236.google.com
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

On 2023/6/1 22:12, Eugenio Perez Martin wrote:
> On Thu, Jun 1, 2023 at 3:49=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>>
>> This patch introduces vhost_vdpa_net_load_offloads() to
>> restore offloads state at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index e907a3c792..0e647886d1 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -678,6 +678,40 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>>       return *s->status !=3D VIRTIO_NET_OK;
>>   }
>>
>> +static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
>> +                                        const VirtIONet *n)
>> +{
>> +    uint64_t offloads;
>> +    ssize_t dev_written;
>> +
>> +    if (!virtio_vdev_has_feature(&n->parent_obj,
>> +                                 VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
>> +        return 0;
>> +    }
>> +
>> +    offloads =3D cpu_to_le64(n->curr_guest_offloads);
>
> n->curr_guest_offloads is already stored in CPU order, we should only
> byte-swap it by the time of sending.

Yes, you are right.

I will correct it in the v4 patch.

Thanks!


>
> Thanks!
>
>> +
>> +    if (offloads =3D=3D virtio_net_supported_guest_offloads(n)) {
>> +        /*
>> +         * According to VirtIO standard, "Upon feature negotiation
>> +         * corresponding offload gets enabled to preserve
>> +         * backward compatibility."
>> +         * So we do not need to send this CVQ command if the guest
>> +         * also enables all supported offloads.
>> +         */
>> +        return 0;
>> +    }
>> +
>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OF=
FLOADS,
>> +                                          VIRTIO_NET_CTRL_GUEST_OFFLOAD=
S_SET,
>> +                                          &offloads, sizeof(offloads));
>> +    if (unlikely(dev_written < 0)) {
>> +        return dev_written;
>> +    }
>> +
>> +    return *s->status !=3D VIRTIO_NET_OK;
>> +}
>> +
>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>   {
>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>> @@ -700,6 +734,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> +    r =3D vhost_vdpa_net_load_offloads(s, n);
>> +    if (unlikely(r)) {
>> +        return r;
>> +    }
>>
>>       return 0;
>>   }
>> --
>> 2.25.1
>>
>

