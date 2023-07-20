Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 176AF75B398
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 17:55:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMVyU-0006z2-I4; Thu, 20 Jul 2023 11:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qMVyR-0006yi-V4
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:53:51 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qMVyO-00034F-K6
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:53:51 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b6f943383eso14171751fa.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689868426; x=1690473226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yNssfDQNDqD5NsGs/hj6bElsIee9xL+WTI5Qi+BzeXI=;
 b=yEUFFQ7iAhPfxzgZVhyCir+70iyfkltil8efhZTd0gLyJVqHLYd6uRvq5wh7mnDTG0
 dCN6T684q56a9j+t+gTW7DaYktVrKSJia8Z5JaVA19dlISKqCASAUM8NZyNuUgGVmHR7
 PDUZUx3W0P6ktjGfTBS6OmlDho/XEYDALgcPYnsaY7LY9O0PrFAPHAqbMsJojKKKlzbD
 E9xS9/1XHrcpr80M4ArkmFzPr9XcEg64Su/vPIFeJy1YH68LgF9XXUMIz0NmVpZvWLgK
 Qm8Wjwt1SeYajWvGef6iC1RUHwz6+x4WRJ9lDIDy+iKa8zA+4wK/Y7tq6tLc+RC+ob53
 65Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689868426; x=1690473226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNssfDQNDqD5NsGs/hj6bElsIee9xL+WTI5Qi+BzeXI=;
 b=c4nqyZxtG9nuY7D4thwGFFnyNfTr4iCDCpbHUPMg13nzsQrHXuJ7JCeroieoMM+2W5
 P0iLVCe/KIhidNipgzygaYtGE1q4B0ycjgnExStbGJzex4wg64r1P/8lTZIiVHerdSPg
 tG/30ZHqI7E8pdlz/eytUGYZa2IlfBv803CUXLxwTRK2wBnb+Wa5ySHLeJESjcBb7TZV
 UMmThKePKPsyIvI/Ji31JSu/QCaplCkyprAFH9rM1vOFTGJx0N4GGj1Qb52sPtJGHa3W
 rYBjHFuER2iYhurJ3yDrcCgBmf5YxXkg9NSjdWw2k+dbzzUuyxHi6jVwgVjx96zrOfxp
 kL2g==
X-Gm-Message-State: ABy/qLaujujtGMf0VIIA0/KNTCDdZQUUF458SfdGXGH34JYGNK/WDvXA
 nUJVdehmw7kf0yUV+BnK9mj7SC4crfmDHKphKJ4q4w==
X-Google-Smtp-Source: APBJJlF6q3OSBhbkII5ymrIfhq5omEoboLHlINLkXI8a37Ist09QKtS5iuD/GaitcSdBy+cfWuFI6nON3XdB2u+4lHI=
X-Received: by 2002:a2e:9b5a:0:b0:2b9:4841:9652 with SMTP id
 o26-20020a2e9b5a000000b002b948419652mr2551014ljj.25.1689868426298; Thu, 20
 Jul 2023 08:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
 <20230719152139.1316570-2-yuri.benditovich@daynix.com>
 <d6906dd9-cb4a-065d-1755-c8cf9b5dcda8@daynix.com>
In-Reply-To: <d6906dd9-cb4a-065d-1755-c8cf9b5dcda8@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 20 Jul 2023 18:53:34 +0300
Message-ID: <CAOEp5OfC89QCW79+SyZnzRAOZ1YOu5whZ0z6YZepsUk8AdYWBg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tap: Added USO support to tap device.
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, mst@redhat.com,
 Stefan Weil <sw@weilnetz.de>, 
 qemu-devel@nongnu.org, yan@daynix.com, andrew@daynix.com
Content-Type: multipart/alternative; boundary="0000000000004459c10600ed277f"
Received-SPF: none client-ip=2a00:1450:4864:20::234;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--0000000000004459c10600ed277f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 3:31=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> Nitpicking: the subject of this patch is somewhat unconventional. What
> about: "tap: Add USO support to tap device"?
>
> Will take it in account in v2


> On 2023/07/20 0:21, Yuri Benditovich wrote:
> > From: Andrew Melnychenko <andrew@daynix.com>
> >
> > Passing additional parameters (USOv4 and USOv6 offloads) when
> > setting TAP offloads
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   hw/net/e1000e_core.c |  2 +-
> >   hw/net/igb_core.c    |  2 +-
> >   hw/net/virtio-net.c  |  4 +++-
> >   hw/net/vmxnet3.c     |  2 ++
> >   include/net/net.h    |  4 ++--
> >   net/net.c            |  4 ++--
> >   net/tap-bsd.c        |  2 +-
> >   net/tap-linux.c      | 15 ++++++++++++---
> >   net/tap-linux.h      |  2 ++
> >   net/tap-solaris.c    |  2 +-
> >   net/tap-stub.c       |  2 +-
> >   net/tap-win32.c      |  2 +-
> >   net/tap.c            |  6 +++---
> >   net/tap_int.h        |  3 ++-
> >   14 files changed, 34 insertions(+), 18 deletions(-)
> >
> > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> > index f8aeafa16b..d4055956ad 100644
> > --- a/hw/net/e1000e_core.c
> > +++ b/hw/net/e1000e_core.c
> > @@ -2852,7 +2852,7 @@ e1000e_update_rx_offloads(E1000ECore *core)
> >
> >       if (core->has_vnet) {
> >           qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> > -                         cso_state, 0, 0, 0, 0);
> > +                         cso_state, 0, 0, 0, 0, 0, 0);
> >       }
> >   }
> >
> > diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> > index 8b6b75c522..389eef1549 100644
> > --- a/hw/net/igb_core.c
> > +++ b/hw/net/igb_core.c
> > @@ -2753,7 +2753,7 @@ igb_update_rx_offloads(IGBCore *core)
> >
> >       if (core->has_vnet) {
> >           qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> > -                         cso_state, 0, 0, 0, 0);
> > +                         cso_state, 0, 0, 0, 0, 0, 0);
> >       }
> >   }
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 7102ec4817..d2311e7d6e 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -859,7 +859,9 @@ static void
> virtio_net_apply_guest_offloads(VirtIONet *n)
> >               !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_TSO4)),
> >               !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_TSO6)),
> >               !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_ECN)),
> > -            !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_UFO)));
> > +            !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_UFO)),
> > +            !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_USO4)),
> > +            !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_USO6)));
> >   }
> >
> >   static uint64_t virtio_net_guest_offloads_by_features(uint32_t
> features)
> > diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> > index 5dfacb1098..886adae42b 100644
> > --- a/hw/net/vmxnet3.c
> > +++ b/hw/net/vmxnet3.c
> > @@ -1341,6 +1341,8 @@ static void vmxnet3_update_features(VMXNET3State
> *s)
> >                            s->lro_supported,
> >                            s->lro_supported,
> >                            0,
> > +                         0,
> > +                         0,
> >                            0);
> >       }
> >   }
> > diff --git a/include/net/net.h b/include/net/net.h
> > index 1448d00afb..b5ccfbbffb 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -58,7 +58,7 @@ typedef bool (HasVnetHdr)(NetClientState *);
> >   typedef bool (HasVnetHdrLen)(NetClientState *, int);
> >   typedef bool (GetUsingVnetHdr)(NetClientState *);
> >   typedef void (UsingVnetHdr)(NetClientState *, bool);
> > -typedef void (SetOffload)(NetClientState *, int, int, int, int, int);
> > +typedef void (SetOffload)(NetClientState *, int, int, int, int, int,
> int, int);
> >   typedef int (GetVnetHdrLen)(NetClientState *);
> >   typedef void (SetVnetHdrLen)(NetClientState *, int);
> >   typedef int (SetVnetLE)(NetClientState *, bool);
> > @@ -192,7 +192,7 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int
> len);
> >   bool qemu_get_using_vnet_hdr(NetClientState *nc);
> >   void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
> >   void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso=
6,
> > -                      int ecn, int ufo);
> > +                      int ecn, int ufo, int uso4, int uso6);
> >   int qemu_get_vnet_hdr_len(NetClientState *nc);
> >   void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
> >   int qemu_set_vnet_le(NetClientState *nc, bool is_le);
> > diff --git a/net/net.c b/net/net.c
> > index 6492ad530e..543e6dec43 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -532,13 +532,13 @@ void qemu_using_vnet_hdr(NetClientState *nc, bool
> enable)
> >   }
> >
> >   void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso=
6,
> > -                          int ecn, int ufo)
> > +                          int ecn, int ufo, int uso4, int uso6)
> >   {
> >       if (!nc || !nc->info->set_offload) {
> >           return;
> >       }
> >
> > -    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo);
> > +    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo, uso4, uso6);
> >   }
> >
> >   int qemu_get_vnet_hdr_len(NetClientState *nc)
> > diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> > index 4c98fdd337..abd16a2ad2 100644
> > --- a/net/tap-bsd.c
> > +++ b/net/tap-bsd.c
> > @@ -232,7 +232,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
> >   }
> >
> >   void tap_fd_set_offload(int fd, int csum, int tso4,
> > -                        int tso6, int ecn, int ufo)
> > +                        int tso6, int ecn, int ufo, int uso4, int uso6=
)
> >   {
> >   }
> >
> > diff --git a/net/tap-linux.c b/net/tap-linux.c
> > index f54f308d35..30fcca1bc2 100644
> > --- a/net/tap-linux.c
> > +++ b/net/tap-linux.c
> > @@ -237,7 +237,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
> >   }
> >
> >   void tap_fd_set_offload(int fd, int csum, int tso4,
> > -                        int tso6, int ecn, int ufo)
> > +                        int tso6, int ecn, int ufo, int uso4, int uso6=
)
> >   {
> >       unsigned int offload =3D 0;
> >
> > @@ -256,13 +256,22 @@ void tap_fd_set_offload(int fd, int csum, int tso=
4,
> >               offload |=3D TUN_F_TSO_ECN;
> >           if (ufo)
> >               offload |=3D TUN_F_UFO;
> > +        if (uso4) {
> > +            offload |=3D TUN_F_USO4;
> > +        }
> > +        if (uso6) {
> > +            offload |=3D TUN_F_USO6;
> > +        }
> >       }
> >
> >       if (ioctl(fd, TUNSETOFFLOAD, offload) !=3D 0) {
> > -        offload &=3D ~TUN_F_UFO;
> > +        offload &=3D ~(TUN_F_USO4 | TUN_F_USO6);
>
> Shouldn't we just report an error when USO is requested on a system that
> does not support it?
>

Existing approach to non-critical features is silently drop them when not
supported by the kernel


>
> >           if (ioctl(fd, TUNSETOFFLOAD, offload) !=3D 0) {
> > -            fprintf(stderr, "TUNSETOFFLOAD ioctl() failed: %s\n",
> > +            offload &=3D ~TUN_F_UFO;
> > +            if (ioctl(fd, TUNSETOFFLOAD, offload) !=3D 0) {
> > +                fprintf(stderr, "TUNSETOFFLOAD ioctl() failed: %s\n",
> >                       strerror(errno));
> > +            }
> >           }
> >       }
> >   }
> > diff --git a/net/tap-linux.h b/net/tap-linux.h
> > index bbbb62c2a7..9a58cecb7f 100644
> > --- a/net/tap-linux.h
> > +++ b/net/tap-linux.h
> > @@ -50,5 +50,7 @@
> >   #define TUN_F_TSO6    0x04    /* I can handle TSO for IPv6 packets */
> >   #define TUN_F_TSO_ECN 0x08    /* I can handle TSO with ECN bits. */
> >   #define TUN_F_UFO     0x10    /* I can handle UFO packets */
> > +#define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
> > +#define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
> >
> >   #endif /* QEMU_TAP_LINUX_H */
> > diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> > index 38e15028bf..a617a10e5c 100644
> > --- a/net/tap-solaris.c
> > +++ b/net/tap-solaris.c
> > @@ -236,7 +236,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
> >   }
> >
> >   void tap_fd_set_offload(int fd, int csum, int tso4,
> > -                        int tso6, int ecn, int ufo)
> > +                        int tso6, int ecn, int ufo, int uso4, int uso6=
)
> >   {
> >   }
> >
> > diff --git a/net/tap-stub.c b/net/tap-stub.c
> > index a0fa25804b..ac8dfc03b4 100644
> > --- a/net/tap-stub.c
> > +++ b/net/tap-stub.c
> > @@ -67,7 +67,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
> >   }
> >
> >   void tap_fd_set_offload(int fd, int csum, int tso4,
> > -                        int tso6, int ecn, int ufo)
> > +                        int tso6, int ecn, int ufo, int uso4, int uso6=
)
> >   {
> >   }
> >
> > diff --git a/net/tap-win32.c b/net/tap-win32.c
> > index f327d62ab0..7b8b4be02c 100644
> > --- a/net/tap-win32.c
> > +++ b/net/tap-win32.c
> > @@ -741,7 +741,7 @@ static void tap_using_vnet_hdr(NetClientState *nc,
> bool using_vnet_hdr)
> >   }
> >
> >   static void tap_set_offload(NetClientState *nc, int csum, int tso4,
> > -                     int tso6, int ecn, int ufo)
> > +                     int tso6, int ecn, int ufo, int uso4, int uso6)
> >   {
> >   }
> >
> > diff --git a/net/tap.c b/net/tap.c
> > index 1bf085d422..14ea4ef26f 100644
> > --- a/net/tap.c
> > +++ b/net/tap.c
> > @@ -307,14 +307,14 @@ static int tap_set_vnet_be(NetClientState *nc,
> bool is_be)
> >   }
> >
> >   static void tap_set_offload(NetClientState *nc, int csum, int tso4,
> > -                     int tso6, int ecn, int ufo)
> > +                     int tso6, int ecn, int ufo, int uso4, int uso6)
> >   {
> >       TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
> >       if (s->fd < 0) {
> >           return;
> >       }
> >
> > -    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo);
> > +    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo, uso4, uso6);
> >   }
> >
> >   static void tap_exit_notify(Notifier *notifier, void *data)
> > @@ -414,7 +414,7 @@ static TAPState *net_tap_fd_init(NetClientState
> *peer,
> >       s->using_vnet_hdr =3D false;
> >       s->has_ufo =3D tap_probe_has_ufo(s->fd);
> >       s->enabled =3D true;
> > -    tap_set_offload(&s->nc, 0, 0, 0, 0, 0);
> > +    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
> >       /*
> >        * Make sure host header length is set correctly in tap:
> >        * it might have been modified by another instance of qemu.
> > diff --git a/net/tap_int.h b/net/tap_int.h
> > index 547f8a5a28..d8861d81ba 100644
> > --- a/net/tap_int.h
> > +++ b/net/tap_int.h
> > @@ -37,7 +37,8 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions
> *tap, Error **errp);
> >   int tap_probe_vnet_hdr(int fd, Error **errp);
> >   int tap_probe_vnet_hdr_len(int fd, int len);
> >   int tap_probe_has_ufo(int fd);
> > -void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn,
> int ufo);
> > +void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn,
> int ufo,
> > +                        int uso4, int uso6);
> >   void tap_fd_set_vnet_hdr_len(int fd, int len);
> >   int tap_fd_set_vnet_le(int fd, int vnet_is_le);
> >   int tap_fd_set_vnet_be(int fd, int vnet_is_be);
>

--0000000000004459c10600ed277f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 20, 2023 at 3:31=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Nitpicking: the subject of this patch is somewhat unconventio=
nal. What <br>
about: &quot;tap: Add USO support to tap device&quot;?<br>
<br></blockquote><div>Will take it in account in v2=C2=A0</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
On 2023/07/20 0:21, Yuri Benditovich wrote:<br>
&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" targ=
et=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; <br>
&gt; Passing additional parameters (USOv4 and USOv6 offloads) when<br>
&gt; setting TAP offloads<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/e1000e_core.c |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/net/igb_core.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 |=C2=A0 4 +++-<br>
&gt;=C2=A0 =C2=A0hw/net/vmxnet3.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0include/net/net.h=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 =C2=A0net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 4 ++--<br>
&gt;=C2=A0 =C2=A0net/tap-bsd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0net/tap-linux.c=C2=A0 =C2=A0 =C2=A0 | 15 ++++++++++++---<b=
r>
&gt;=C2=A0 =C2=A0net/tap-linux.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0net/tap-solaris.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0net/tap-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0net/tap-win32.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 6 +++---<br>
&gt;=C2=A0 =C2=A0net/tap_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 =C2=A014 files changed, 34 insertions(+), 18 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c<br>
&gt; index f8aeafa16b..d4055956ad 100644<br>
&gt; --- a/hw/net/e1000e_core.c<br>
&gt; +++ b/hw/net/e1000e_core.c<br>
&gt; @@ -2852,7 +2852,7 @@ e1000e_update_rx_offloads(E1000ECore *core)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (core-&gt;has_vnet) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_offload(qemu_get_queu=
e(core-&gt;owner_nic)-&gt;peer,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cso_state, 0, 0, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cso_state, 0, 0, 0, 0, 0, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c<br>
&gt; index 8b6b75c522..389eef1549 100644<br>
&gt; --- a/hw/net/igb_core.c<br>
&gt; +++ b/hw/net/igb_core.c<br>
&gt; @@ -2753,7 +2753,7 @@ igb_update_rx_offloads(IGBCore *core)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (core-&gt;has_vnet) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_offload(qemu_get_queu=
e(core-&gt;owner_nic)-&gt;peer,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cso_state, 0, 0, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cso_state, 0, 0, 0, 0, 0, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 7102ec4817..d2311e7d6e 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -859,7 +859,9 @@ static void virtio_net_apply_guest_offloads(VirtIO=
Net *n)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!!(n-&gt;curr_gu=
est_offloads &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_TSO4)),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!!(n-&gt;curr_gu=
est_offloads &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_TSO6)),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!!(n-&gt;curr_gu=
est_offloads &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_ECN)),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!(n-&gt;curr_guest_offload=
s &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_UFO)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!(n-&gt;curr_guest_offload=
s &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_UFO)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!(n-&gt;curr_guest_offload=
s &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_USO4)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!(n-&gt;curr_guest_offload=
s &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_USO6)));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static uint64_t virtio_net_guest_offloads_by_features(uint=
32_t features)<br>
&gt; diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c<br>
&gt; index 5dfacb1098..886adae42b 100644<br>
&gt; --- a/hw/net/vmxnet3.c<br>
&gt; +++ b/hw/net/vmxnet3.c<br>
&gt; @@ -1341,6 +1341,8 @@ static void vmxnet3_update_features(VMXNET3State=
 *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;lro_supported,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;lro_supported,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; diff --git a/include/net/net.h b/include/net/net.h<br>
&gt; index 1448d00afb..b5ccfbbffb 100644<br>
&gt; --- a/include/net/net.h<br>
&gt; +++ b/include/net/net.h<br>
&gt; @@ -58,7 +58,7 @@ typedef bool (HasVnetHdr)(NetClientState *);<br>
&gt;=C2=A0 =C2=A0typedef bool (HasVnetHdrLen)(NetClientState *, int);<br>
&gt;=C2=A0 =C2=A0typedef bool (GetUsingVnetHdr)(NetClientState *);<br>
&gt;=C2=A0 =C2=A0typedef void (UsingVnetHdr)(NetClientState *, bool);<br>
&gt; -typedef void (SetOffload)(NetClientState *, int, int, int, int, int);=
<br>
&gt; +typedef void (SetOffload)(NetClientState *, int, int, int, int, int, =
int, int);<br>
&gt;=C2=A0 =C2=A0typedef int (GetVnetHdrLen)(NetClientState *);<br>
&gt;=C2=A0 =C2=A0typedef void (SetVnetHdrLen)(NetClientState *, int);<br>
&gt;=C2=A0 =C2=A0typedef int (SetVnetLE)(NetClientState *, bool);<br>
&gt; @@ -192,7 +192,7 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int=
 len);<br>
&gt;=C2=A0 =C2=A0bool qemu_get_using_vnet_hdr(NetClientState *nc);<br>
&gt;=C2=A0 =C2=A0void qemu_using_vnet_hdr(NetClientState *nc, bool enable);=
<br>
&gt;=C2=A0 =C2=A0void qemu_set_offload(NetClientState *nc, int csum, int ts=
o4, int tso6,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int ecn, int ufo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int ecn, int ufo, int uso4, int uso6);<br>
&gt;=C2=A0 =C2=A0int qemu_get_vnet_hdr_len(NetClientState *nc);<br>
&gt;=C2=A0 =C2=A0void qemu_set_vnet_hdr_len(NetClientState *nc, int len);<b=
r>
&gt;=C2=A0 =C2=A0int qemu_set_vnet_le(NetClientState *nc, bool is_le);<br>
&gt; diff --git a/net/net.c b/net/net.c<br>
&gt; index 6492ad530e..543e6dec43 100644<br>
&gt; --- a/net/net.c<br>
&gt; +++ b/net/net.c<br>
&gt; @@ -532,13 +532,13 @@ void qemu_using_vnet_hdr(NetClientState *nc, boo=
l enable)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void qemu_set_offload(NetClientState *nc, int csum, int ts=
o4, int tso6,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int ecn, int ufo)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int ecn, int ufo, int uso4, int uso6)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!nc || !nc-&gt;info-&gt;set_offload) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 nc-&gt;info-&gt;set_offload(nc, csum, tso4, tso6, ecn, =
ufo);<br>
&gt; +=C2=A0 =C2=A0 nc-&gt;info-&gt;set_offload(nc, csum, tso4, tso6, ecn, =
ufo, uso4, uso6);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int qemu_get_vnet_hdr_len(NetClientState *nc)<br>
&gt; diff --git a/net/tap-bsd.c b/net/tap-bsd.c<br>
&gt; index 4c98fdd337..abd16a2ad2 100644<br>
&gt; --- a/net/tap-bsd.c<br>
&gt; +++ b/net/tap-bsd.c<br>
&gt; @@ -232,7 +232,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void tap_fd_set_offload(int fd, int csum, int tso4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo, int uso4, int uso6)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/net/tap-linux.c b/net/tap-linux.c<br>
&gt; index f54f308d35..30fcca1bc2 100644<br>
&gt; --- a/net/tap-linux.c<br>
&gt; +++ b/net/tap-linux.c<br>
&gt; @@ -237,7 +237,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void tap_fd_set_offload(int fd, int csum, int tso4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo, int uso4, int uso6)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int offload =3D 0;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -256,13 +256,22 @@ void tap_fd_set_offload(int fd, int csum, int ts=
o4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offload |=3D TUN=
_F_TSO_ECN;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ufo)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offload |=3D TUN=
_F_UFO;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uso4) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload |=3D TUN_F_USO4;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uso6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload |=3D TUN_F_USO6;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(fd, TUNSETOFFLOAD, offload) !=3D 0=
) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 offload &amp;=3D ~TUN_F_UFO;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 offload &amp;=3D ~(TUN_F_USO4 | TUN_F_USO=
6);<br>
<br>
Shouldn&#39;t we just report an error when USO is requested on a system tha=
t <br>
does not support it?<br></blockquote><div><br></div><div>Existing approach =
to non-critical=C2=A0features is silently drop them when not supported by t=
he kernel</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(fd, TUNSETOFFLOAD, o=
ffload) !=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;TUNSE=
TOFFLOAD ioctl() failed: %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload &amp;=3D ~TUN_F_UFO=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ioctl(fd, TUNSETOFFLOAD=
, offload) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stder=
r, &quot;TUNSETOFFLOAD ioctl() failed: %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0strerror(errno));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; diff --git a/net/tap-linux.h b/net/tap-linux.h<br>
&gt; index bbbb62c2a7..9a58cecb7f 100644<br>
&gt; --- a/net/tap-linux.h<br>
&gt; +++ b/net/tap-linux.h<br>
&gt; @@ -50,5 +50,7 @@<br>
&gt;=C2=A0 =C2=A0#define TUN_F_TSO6=C2=A0 =C2=A0 0x04=C2=A0 =C2=A0 /* I can=
 handle TSO for IPv6 packets */<br>
&gt;=C2=A0 =C2=A0#define TUN_F_TSO_ECN 0x08=C2=A0 =C2=A0 /* I can handle TS=
O with ECN bits. */<br>
&gt;=C2=A0 =C2=A0#define TUN_F_UFO=C2=A0 =C2=A0 =C2=A00x10=C2=A0 =C2=A0 /* =
I can handle UFO packets */<br>
&gt; +#define TUN_F_USO4=C2=A0 =C2=A0 0x20=C2=A0 =C2=A0 /* I can handle USO=
 for IPv4 packets */<br>
&gt; +#define TUN_F_USO6=C2=A0 =C2=A0 0x40=C2=A0 =C2=A0 /* I can handle USO=
 for IPv6 packets */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_TAP_LINUX_H */<br>
&gt; diff --git a/net/tap-solaris.c b/net/tap-solaris.c<br>
&gt; index 38e15028bf..a617a10e5c 100644<br>
&gt; --- a/net/tap-solaris.c<br>
&gt; +++ b/net/tap-solaris.c<br>
&gt; @@ -236,7 +236,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void tap_fd_set_offload(int fd, int csum, int tso4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo, int uso4, int uso6)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/net/tap-stub.c b/net/tap-stub.c<br>
&gt; index a0fa25804b..ac8dfc03b4 100644<br>
&gt; --- a/net/tap-stub.c<br>
&gt; +++ b/net/tap-stub.c<br>
&gt; @@ -67,7 +67,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void tap_fd_set_offload(int fd, int csum, int tso4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int tso6, int ecn, int ufo, int uso4, int uso6)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/net/tap-win32.c b/net/tap-win32.c<br>
&gt; index f327d62ab0..7b8b4be02c 100644<br>
&gt; --- a/net/tap-win32.c<br>
&gt; +++ b/net/tap-win32.c<br>
&gt; @@ -741,7 +741,7 @@ static void tap_using_vnet_hdr(NetClientState *nc,=
 bool using_vnet_hdr)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void tap_set_offload(NetClientState *nc, int csum, =
int tso4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int tso6, int ecn, int ufo)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int tso6, int ecn, int ufo, int uso4, int uso6)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/net/tap.c b/net/tap.c<br>
&gt; index 1bf085d422..14ea4ef26f 100644<br>
&gt; --- a/net/tap.c<br>
&gt; +++ b/net/tap.c<br>
&gt; @@ -307,14 +307,14 @@ static int tap_set_vnet_be(NetClientState *nc, b=
ool is_be)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void tap_set_offload(NetClientState *nc, int csum, =
int tso4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int tso6, int ecn, int ufo)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int tso6, int ecn, int ufo, int uso4, int uso6)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TAPState *s =3D DO_UPCAST(TAPState, nc, nc);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;fd &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 tap_fd_set_offload(s-&gt;fd, csum, tso4, tso6, ecn, ufo=
);<br>
&gt; +=C2=A0 =C2=A0 tap_fd_set_offload(s-&gt;fd, csum, tso4, tso6, ecn, ufo=
, uso4, uso6);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void tap_exit_notify(Notifier *notifier, void *data=
)<br>
&gt; @@ -414,7 +414,7 @@ static TAPState *net_tap_fd_init(NetClientState *p=
eer,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;using_vnet_hdr =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;has_ufo =3D tap_probe_has_ufo(s-&gt;fd=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;enabled =3D true;<br>
&gt; -=C2=A0 =C2=A0 tap_set_offload(&amp;s-&gt;nc, 0, 0, 0, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 tap_set_offload(&amp;s-&gt;nc, 0, 0, 0, 0, 0, 0, 0);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Make sure host header length is set corre=
ctly in tap:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it might have been modified by another in=
stance of qemu.<br>
&gt; diff --git a/net/tap_int.h b/net/tap_int.h<br>
&gt; index 547f8a5a28..d8861d81ba 100644<br>
&gt; --- a/net/tap_int.h<br>
&gt; +++ b/net/tap_int.h<br>
&gt; @@ -37,7 +37,8 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *=
tap, Error **errp);<br>
&gt;=C2=A0 =C2=A0int tap_probe_vnet_hdr(int fd, Error **errp);<br>
&gt;=C2=A0 =C2=A0int tap_probe_vnet_hdr_len(int fd, int len);<br>
&gt;=C2=A0 =C2=A0int tap_probe_has_ufo(int fd);<br>
&gt; -void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn=
, int ufo);<br>
&gt; +void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn=
, int ufo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int uso4, int uso6);<br>
&gt;=C2=A0 =C2=A0void tap_fd_set_vnet_hdr_len(int fd, int len);<br>
&gt;=C2=A0 =C2=A0int tap_fd_set_vnet_le(int fd, int vnet_is_le);<br>
&gt;=C2=A0 =C2=A0int tap_fd_set_vnet_be(int fd, int vnet_is_be);<br>
</blockquote></div></div>

--0000000000004459c10600ed277f--

