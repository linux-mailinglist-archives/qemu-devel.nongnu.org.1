Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60277F437
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWa6F-0006MF-LR; Thu, 17 Aug 2023 06:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWa6D-0006Lr-U1
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWa6B-0004Is-HC
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692267566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+sWPeW0BR6h0TFhefj2hK/HPtiuKaE381U0G1SP0mY=;
 b=fsmI9Pi5iopHWkJMUOkqxZGJ6y4OyJb+GT5fpKaZRgKr/pJpQdbAQnj5Ji5q3uioZdkbs/
 fbXBg7Y33OPqia622+DWN+2pBG9SElAqw83kqf+o0z3k8nvhbkSv8EK3ytHmk5HPI96ssI
 AqY3N/F6H/+HQzAdlVgKrL5jZh9BICs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-vIOmEej5NDKFR9a7W_Nshg-1; Thu, 17 Aug 2023 06:19:24 -0400
X-MC-Unique: vIOmEej5NDKFR9a7W_Nshg-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6b9c744df27so5988030a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 03:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692267564; x=1692872364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+sWPeW0BR6h0TFhefj2hK/HPtiuKaE381U0G1SP0mY=;
 b=Ok7vwXhkilAXbvr5aGWXIw3r8bLzeWlmyFhgpLXKomW4y/kjbxkyP0LBPAqE6lM68X
 DYQRLE/E/KsbTsokBzzr4dfS5c0dxv28u2KG5Pqi38drvxvUUMTlrruOfpZxXgalOtdT
 ovIA/G6blK4BNI2GkbS0/uPCyvi1rIpSMvgJ9S88LrXzjNJbuc9rrY4QAuj3cWhTqy/k
 0+FXkIBkyG31VBRxT0yz52r+/Q1+INwqOvbFXpHrW5tyWyPvGRN+e1FQxUIl7TKeQAga
 P9qmjSg9KlVWOU87QWVKW7I3YV/5OtM2rggg3lORE/isaKG2dt63a/CRsJGJCf+HtuLp
 253w==
X-Gm-Message-State: AOJu0YxsWXuicx9zZsMOFgT9pfnZt93qzp3VxlAk0X+N1pVjc4g0Ya1M
 jbOLiVjJHWE68KnjP2+ZhQDCH4zhx1RjomF70pMqkrshE2L2y/4logNXOuMlGdfsAFl7ICLITLN
 MjN6ipg7HzKwy4KGCgMF590Axmjvw6w4=
X-Received: by 2002:a05:6358:4297:b0:130:faea:a81f with SMTP id
 s23-20020a056358429700b00130faeaa81fmr2893537rwc.28.1692267564123; 
 Thu, 17 Aug 2023 03:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3bPMna6h2ILwUuBwsZzixQ99cT1RkfHKDDtK1GLR6k5djgk2RFIeBIZz7o7fWjXCwvYHOJxR+WaFlCegAKak=
X-Received: by 2002:a05:6358:4297:b0:130:faea:a81f with SMTP id
 s23-20020a056358429700b00130faeaa81fmr2893523rwc.28.1692267563813; Thu, 17
 Aug 2023 03:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <4b9550c14bc8c98c8f48e04dbf3d3ac41489d3fd.1688743107.git.yin31149@gmail.com>
In-Reply-To: <4b9550c14bc8c98c8f48e04dbf3d3ac41489d3fd.1688743107.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 12:18:47 +0200
Message-ID: <CAJaqyWeWuXn5=OvW99cgnniaZyW=wSp2EutxzROE5Xnp=xvjQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] vdpa: Restore MAC address filtering state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> This patch refactors vhost_vdpa_net_load_mac() to
> restore the MAC address filtering state at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v3:
>   - return early if mismatch the condition suggested by Eugenio
>
> v2: https://lore.kernel.org/all/2f2560f749186c0eb1055f9926f464587e419eeb.=
1688051252.git.yin31149@gmail.com/
>   - use iovec suggested by Eugenio
>   - avoid sending CVQ command in default state
>
> v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.=
1687402580.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 31ef6ad6ec..7189ccafaf 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -660,6 +660,58 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n)
>          }
>      }
>
> +    /*
> +     * According to VirtIO standard, "The device MUST have an
> +     * empty MAC filtering table on reset.".
> +     *
> +     * Therefore, there is no need to send this CVQ command if the
> +     * driver also sets an empty MAC filter table, which aligns with
> +     * the device's defaults.
> +     *
> +     * Note that the device's defaults can mismatch the driver's
> +     * configuration only at live migration.
> +     */
> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX) |=
|
> +        n->mac_table.in_use =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    uint32_t uni_entries =3D n->mac_table.first_multi,

QEMU coding style prefers declarations at the beginning of the code
block. Previous uses of these variable names would need to be
refactored to met this rule.

Apart from that,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +             uni_macs_size =3D uni_entries * ETH_ALEN,
> +             mul_entries =3D n->mac_table.in_use - uni_entries,
> +             mul_macs_size =3D mul_entries * ETH_ALEN;
> +    struct virtio_net_ctrl_mac uni =3D {
> +        .entries =3D cpu_to_le32(uni_entries),
> +    };
> +    struct virtio_net_ctrl_mac mul =3D {
> +        .entries =3D cpu_to_le32(mul_entries),
> +    };
> +    const struct iovec data[] =3D {
> +        {
> +            .iov_base =3D &uni,
> +            .iov_len =3D sizeof(uni),
> +        }, {
> +            .iov_base =3D n->mac_table.macs,
> +            .iov_len =3D uni_macs_size,
> +        }, {
> +            .iov_base =3D &mul,
> +            .iov_len =3D sizeof(mul),
> +        }, {
> +            .iov_base =3D &n->mac_table.macs[uni_macs_size],
> +            .iov_len =3D mul_macs_size,
> +        },
> +    };
> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
> +                                VIRTIO_NET_CTRL_MAC,
> +                                VIRTIO_NET_CTRL_MAC_TABLE_SET,
> +                                data, ARRAY_SIZE(data));
> +    if (unlikely(dev_written < 0)) {
> +        return dev_written;
> +    }
> +    if (*s->status !=3D VIRTIO_NET_OK) {
> +        return -EIO;
> +    }
> +
>      return 0;
>  }
>
> --
> 2.25.1
>


