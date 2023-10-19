Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7737D0215
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:51:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtY65-0007Hw-Vr; Thu, 19 Oct 2023 14:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtY64-0007HX-Hx
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:50:16 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtY62-00081R-GA
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:50:16 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-581cb88f645so11074eaf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697741412; x=1698346212; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fip/cGBcwRorh4K6xzMOlRVOKxywtad9Q+8WzIseqdw=;
 b=MscvJGHkVW11iLiUue7yl7hBVQkY3qLhHlAnIMFUE7/HQOnofS2zEYA6+K6SQ/s/nV
 XkSvTFITLG6mbbjpNvc7UKswDYc6uD0Gl8NgbKssqiRRrvg5vKZTZHpZmBDafOZfALSP
 1ZfBkIsmHoLQLdebzTXZcFFNYScCnTdprxdLj5KmhJzehlZYOx/FsTk4r83jMf//inua
 dGeWWBsGhM5jM9eD8U4LFtkl416HN6pnehAJnDKlgvCCY1Z4vX27BNsQ8aWkVHhTTjMx
 PGGBX99CR8dYGPj5UrdM00RZ3DR3QODXk5oQbycH7tXKQ37KOk6kLpWjyuKBONaUOb2t
 wDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697741412; x=1698346212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fip/cGBcwRorh4K6xzMOlRVOKxywtad9Q+8WzIseqdw=;
 b=ezUukI9iWSsHQvyHJR1Um0VS1ps5oJCIsoMMzXB6cD6EZMHQjnbCFnwRdtoKPrMYJR
 5SPeXxhN1DIkRuXoYPmAgWTkDcJ5jcdMpuQIiYjjaaH1Sf3M580PnCB49Sh+wqnTe9sA
 S1q9Z3Kd5zguVP9n9gxISrb/5Jo0cyAsBfQ4ZX3+ZyEEPpsmmTPfQB1YzhJI3va9ucxm
 ecwuB8qajkL0YghALFd02LVyOytCUG2JsfPbH2ZFKeE/B4uy/7l0VetonARySFYMMnNB
 8iFYd3YB7pK4vgoSQvW+EhznLbmLbz9UC8FMRF2d5Kle3M+jBbR5I++5yD/6Fq/m4L89
 44kQ==
X-Gm-Message-State: AOJu0YwH72tRCKnDsT1vYhtvaBHEgZgZ5DhKheeQzToteiRVp1IN6FdC
 YY7P8IO9UJeqWQGLgfUQyuH8WjvqoM3MURYBM5Q=
X-Google-Smtp-Source: AGHT+IHtraIPqXetxIqY0TrWmOGLArOohRkHEqoqCmlDchcy3zN6aNiiKY4TEY4b7pF0fMeoTXaK1JXtgZweSfzocMc=
X-Received: by 2002:a4a:b441:0:b0:581:ea96:f7f3 with SMTP id
 h1-20020a4ab441000000b00581ea96f7f3mr3314538ooo.7.1697741411955; Thu, 19 Oct
 2023 11:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697644299.git.mst@redhat.com>
 <1908cfd6e1748d94680e468b9df6321087b8fcf2.1697644299.git.mst@redhat.com>
 <CAJSP0QVTi2QxMdzmPoPF2w5xm-r19W_0GtTaqJzGnoibT9iDNg@mail.gmail.com>
 <20231019143240-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231019143240-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Oct 2023 11:49:59 -0700
Message-ID: <CAJSP0QUH70gF04XR4KcAXcwmGaxD8AK0c=8e7t95_wZoT_uuuw@mail.gmail.com>
Subject: Re: [PULL 08/83] vdpa: Restore hash calculation state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 19 Oct 2023 at 11:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 19, 2023 at 09:32:28AM -0700, Stefan Hajnoczi wrote:
> > On Wed, 18 Oct 2023 at 08:56, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> > >
> > > From: Hawkins Jiawei <yin31149@gmail.com>
> > >
> > > This patch introduces vhost_vdpa_net_load_rss() to restore
> > > the hash calculation state at device's startup.
> > >
> > > Note that vhost_vdpa_net_load_rss() has `do_rss` argument,
> > > which allows future code to reuse this function to restore
> > > the receive-side scaling state when the VIRTIO_NET_F_RSS
> > > feature is enabled in SVQ. Currently, vhost_vdpa_net_load_rss()
> > > could only be invoked when `do_rss` is set to false.
> > >
> > > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > > Message-Id: <f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.=
yin31149@gmail.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  net/vhost-vdpa.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 91 insertions(+)
> > >
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > index 4b7c3b81b8..40d0bcbc0b 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -817,6 +817,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAStat=
e *s, const VirtIONet *n,
> > >      return 0;
> > >  }
> > >
> > > +static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONe=
t *n,
> > > +                                   struct iovec *out_cursor,
> > > +                                   struct iovec *in_cursor, bool do_=
rss)
> > > +{
> > > +    struct virtio_net_rss_config cfg;
> > > +    ssize_t r;
> > > +    g_autofree uint16_t *table =3D NULL;
> > > +
> > > +    /*
> > > +     * According to VirtIO standard, "Initially the device has all h=
ash
> > > +     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE."=
.
> > > +     *
> > > +     * Therefore, there is no need to send this CVQ command if the
> > > +     * driver disable the all hash types, which aligns with
> > > +     * the device's defaults.
> > > +     *
> > > +     * Note that the device's defaults can mismatch the driver's
> > > +     * configuration only at live migration.
> > > +     */
> > > +    if (!n->rss_data.enabled ||
> > > +        n->rss_data.hash_types =3D=3D VIRTIO_NET_HASH_REPORT_NONE) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    cfg.hash_types =3D cpu_to_le32(n->rss_data.hash_types);
> > > +
> > > +    /*
> > > +     * According to VirtIO standard, "Field reserved MUST contain ze=
roes.
> > > +     * It is defined to make the structure to match the layout of
> > > +     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> > > +     *
> > > +     * Therefore, we need to zero the fields in struct virtio_net_rs=
s_config,
> > > +     * which corresponds the `reserved` field in
> > > +     * struct virtio_net_hash_config.
> > > +     */
> > > +    memset(&cfg.indirection_table_mask, 0,
> > > +           sizeof_field(struct virtio_net_hash_config, reserved));
> >
> > Please take a look at the following CI failure:
> >
> > In file included from /usr/include/string.h:495,
> > from /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/include/qe=
mu/osdep.h:116,
> > from ../net/vhost-vdpa.c:12:
> > In function =E2=80=98memset=E2=80=99,
> > inlined from =E2=80=98vhost_vdpa_net_load_rss=E2=80=99 at ../net/vhost-=
vdpa.c:874:9:
> > /usr/include/s390x-linux-gnu/bits/string_fortified.h:71:10: error:
> > =E2=80=98__builtin_memset=E2=80=99 offset [7, 12] from the object at =
=E2=80=98cfg=E2=80=99 is out of
> > the bounds of referenced subobject =E2=80=98indirection_table_mask=E2=
=80=99 with type
> > =E2=80=98short unsigned int=E2=80=99 at offset 4 [-Werror=3Darray-bound=
s]
> > 71 | return __builtin___memset_chk (__dest, __ch, __len, __bos0 (__dest=
));
> > | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/5329820077
>
> I wonder how come CI passed for me with this commit included:
>
> https://gitlab.com/mstredhat/qemu/-/pipelines/1041296083
>
> do you know?

The failing ubuntu-20.04-s390x-all only runs on an s390 private
runner. That private runner was not available to you, so the test was
skipped and the failure did not occur in your run.

Stefan

>
>
> > > +
> > > +    table =3D g_malloc_n(n->rss_data.indirections_len,
> > > +                       sizeof(n->rss_data.indirections_table[0]));
> > > +    for (int i =3D 0; i < n->rss_data.indirections_len; ++i) {
> > > +        table[i] =3D cpu_to_le16(n->rss_data.indirections_table[i]);
> > > +    }
> > > +
> > > +    /*
> > > +     * Consider that virtio_net_handle_rss() currently does not rest=
ore the
> > > +     * hash key length parsed from the CVQ command sent from the gue=
st into
> > > +     * n->rss_data and uses the maximum key length in other code, so=
 we also
> > > +     * employthe the maxium key length here.
> > > +     */
> > > +    cfg.hash_key_length =3D sizeof(n->rss_data.key);
> > > +
> > > +    const struct iovec data[] =3D {
> > > +        {
> > > +            .iov_base =3D &cfg,
> > > +            .iov_len =3D offsetof(struct virtio_net_rss_config,
> > > +                                indirection_table),
> > > +        }, {
> > > +            .iov_base =3D table,
> > > +            .iov_len =3D n->rss_data.indirections_len *
> > > +                       sizeof(n->rss_data.indirections_table[0]),
> > > +        }, {
> > > +            .iov_base =3D &cfg.max_tx_vq,
> > > +            .iov_len =3D offsetof(struct virtio_net_rss_config, hash=
_key_data) -
> > > +                       offsetof(struct virtio_net_rss_config, max_tx=
_vq),
> > > +        }, {
> > > +            .iov_base =3D (void *)n->rss_data.key,
> > > +            .iov_len =3D sizeof(n->rss_data.key),
> > > +        }
> > > +    };
> > > +
> > > +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> > > +                                VIRTIO_NET_CTRL_MQ,
> > > +                                VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
> > > +                                data, ARRAY_SIZE(data));
> > > +    if (unlikely(r < 0)) {
> > > +        return r;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> > >                                    const VirtIONet *n,
> > >                                    struct iovec *out_cursor,
> > > @@ -842,6 +924,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState=
 *s,
> > >          return r;
> > >      }
> > >
> > > +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_R=
EPORT)) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false=
);
> > > +    if (unlikely(r < 0)) {
> > > +        return r;
> > > +    }
> > > +
> > >      return 0;
> > >  }
> > >
> > > --
> > > MST
> > >
> > >
>

