Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C22EE780F94
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:49:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1iq-000252-RL; Fri, 18 Aug 2023 11:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1in-00024Y-2Q
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1ik-0002XR-3N
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692373745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZdh+M3crBxuQgKTpCBeWHJTDRzEhYcZahnBOc9Wg9I=;
 b=A0INQ48bblTQBpwPvhhVa5RIeHEQPtESEFdcJKOfZBBRZPtv1omUIKNWChIJpkt8lHj8o8
 DvPDwZ6+UvcJw6suTpU39bVTT2mZedM7+JlN1JnFvSZjSibYlpS1cAPrm0RYVphogZ7207
 2W7k6iYH6OseUdBk5LnsTRTOpGlgSYw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-CsBzyPpDN966wjs7aq8bKw-1; Fri, 18 Aug 2023 11:49:03 -0400
X-MC-Unique: CsBzyPpDN966wjs7aq8bKw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d72f3290e6eso1190866276.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692373743; x=1692978543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZdh+M3crBxuQgKTpCBeWHJTDRzEhYcZahnBOc9Wg9I=;
 b=dJuTCN1lLOzkUApafcL+FFxNxPmbNSFuL2PGum9Uc9AvJzxVk9kBPVPAWie0vL6Nj9
 6MUFMmQtkVOzoFIaq1DErTVaCEwqVhDUOxCxE+YxI/aliYTojmrzWJTs8ZAQaQcZ6tpd
 Q34QPvP/KIxa7SkfjE1wYYqjOrJUo8yx+05J1eX1E/HpQl9RVm5abcZTarUkKlG99hER
 RI1sepsvMz9PRrMu1/65Jp9v3C8DCCsp1nwe7IJsVeNWwPgcJG7ZYXk9XBAcQlqcf5f2
 IefgADNwQH17wf0+p9yefYcnIgd3W9i+gbS8sEW9zdCWBaQ0LPLrd/LBv0vcags+zoZa
 wWXg==
X-Gm-Message-State: AOJu0YzyOFK9Ji/ujdBXVPslzL34I008TxwasRprG0n3KXWQbKK/FTFu
 eQ2M5SQ6D5jCzhMd28lNKthMqwHDwLDh4VWP6D+dwqStP62UY73Wn099BlqPVcsFf71grTmWL+b
 T/UPLHa1KbBmKj8LW5ZPREzTj+vdNfZinBTO3W80FGg==
X-Received: by 2002:a25:250f:0:b0:d11:45d3:b25d with SMTP id
 l15-20020a25250f000000b00d1145d3b25dmr3189382ybl.46.1692373742780; 
 Fri, 18 Aug 2023 08:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhfBAsiwc7zzKL2z3t15s0Rb1cWB5SKhzZaZEAGf39h2KSZ2hAzDB2RRlQpoovbuhK13XMkmxvPGSdTo6RdLY=
X-Received: by 2002:a25:250f:0:b0:d11:45d3:b25d with SMTP id
 l15-20020a25250f000000b00d1145d3b25dmr3189367ybl.46.1692373742509; Fri, 18
 Aug 2023 08:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <152177c4e7082236fba9d31d535e40f8c2984349.1689748694.git.yin31149@gmail.com>
In-Reply-To: <152177c4e7082236fba9d31d535e40f8c2984349.1689748694.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 18 Aug 2023 17:48:26 +0200
Message-ID: <CAJaqyWez2iz1Ew67W_zwY8oqTwG14F4uwJgiint5n+G6fDEPwQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] vdpa: Move vhost_svq_poll() to the caller of
 vhost_vdpa_net_cvq_add()
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

On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch moves vhost_svq_poll() to the caller of
> vhost_vdpa_net_cvq_add() and introduces a helper funtion.
>
> By making this change, next patches in this series is
> able to refactor vhost_vdpa_net_load_x() only to delay
> the polling and checking process until either the SVQ
> is full or control commands shadow buffers are full.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 50 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index fe0ba19724..d06f38403f 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -609,15 +609,21 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAStat=
e *s,
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue=
\n",
>                            __func__);
>          }
> -        return r;
>      }
>
> -    /*
> -     * We can poll here since we've had BQL from the time we sent the
> -     * descriptor. Also, we need to take the answer before SVQ pulls by =
itself,
> -     * when BQL is released
> -     */
> -    return vhost_svq_poll(svq, 1);
> +    return r;
> +}
> +
> +/*
> + * Convenience wrapper to poll SVQ for multiple control commands.
> + *
> + * Caller should hold the BQL when invoking this function, and should ta=
ke
> + * the answer before SVQ pulls by itself when BQL is released.
> + */
> +static ssize_t vhost_vdpa_net_svq_poll(VhostVDPAState *s, size_t cmds_in=
_flight)
> +{
> +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shadow=
_vqs, 0);
> +    return vhost_svq_poll(svq, cmds_in_flight);
>  }
>
>  /* Convenience wrapper to get number of available SVQ descriptors */
> @@ -645,6 +651,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s, uint8_t class,
>          .iov_base =3D s->status,
>          .iov_len =3D sizeof(*s->status),
>      };
> +    ssize_t r;
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
>      /* Each CVQ command has one out descriptor and one in descriptor */
> @@ -657,7 +664,16 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAStat=
e *s, uint8_t class,
>      iov_to_buf(data_sg, data_num, 0,
>                 s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
>
> -    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
> +    r =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
> +    /*
> +     * We can poll here since we've had BQL from the time
> +     * we sent the descriptor.
> +     */
> +    return vhost_vdpa_net_svq_poll(s, 1);
>  }
>
>  static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
)
> @@ -1152,6 +1168,12 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq=
_add(VhostVDPAState *s,
>      if (unlikely(r < 0)) {
>          return r;
>      }
> +
> +    /*
> +     * We can poll here since we've had BQL from the time
> +     * we sent the descriptor.
> +     */
> +    vhost_vdpa_net_svq_poll(s, 1);

Don't we need to check the return value of vhost_vdpa_net_svq_poll here?

>      if (*s->status !=3D VIRTIO_NET_OK) {
>          return sizeof(*s->status);
>      }
> @@ -1266,10 +1288,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(Vhost=
ShadowVirtqueue *svq,
>              goto out;
>          }
>      } else {
> -        dev_written =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
> -        if (unlikely(dev_written < 0)) {
> +        ssize_t r;
> +        r =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
> +        if (unlikely(r < 0)) {
> +            dev_written =3D r;
>              goto out;
>          }
> +
> +        /*
> +         * We can poll here since we've had BQL from the time
> +         * we sent the descriptor.
> +         */
> +        dev_written =3D vhost_vdpa_net_svq_poll(s, 1);
>      }
>
>      if (unlikely(dev_written < sizeof(status))) {
> --
> 2.25.1
>


