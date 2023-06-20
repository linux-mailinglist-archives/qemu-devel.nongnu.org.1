Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6C736FD7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcxU-0000Mn-9H; Tue, 20 Jun 2023 11:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qBcxR-0000LH-O3; Tue, 20 Jun 2023 11:07:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qBcxP-0005ZM-EH; Tue, 20 Jun 2023 11:07:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f901f87195so28136345e9.1; 
 Tue, 20 Jun 2023 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687273665; x=1689865665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIPUHZ9Fl7QoCTEip84uU0/nP0kd2MocqpBenoWibzM=;
 b=rrZZmtsZbO20QzZkpoeqMAco7tSIg2qoo7FbLmO/nhivrQugCnMNxm/2m1ac2/XoIa
 h3TbXdTKQO5qwJARQbxT+ck/Vkqhkz6fJj7Gh8p02aNYjzpcInUowowgS2N3lS4c647h
 tCNTw2p3I+B9uAKDblfPmykB8bM17VeLTy5EhGEjL4HcoqOXysnyJfSgMzsYcWx0MzWU
 B0VsrlzQk9CCpyKdKoVdxEAs2ekrMYejEA8j3yMd7MKRMTq+oPMy64tS1MpFxAOf7jUt
 xi9PUKC/g5AbSMzSVoOylhYWFniKj7JkVv4xNkkheCuZsGtuk3YZH4bvWgi5QAU/nTex
 rbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273665; x=1689865665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIPUHZ9Fl7QoCTEip84uU0/nP0kd2MocqpBenoWibzM=;
 b=DAGkfkPfIR6VPobPe7w8vGgOKkns6TH5RAR/Oj+gcgIfdnjmH8cCy5smW6blsK1mOj
 tYd607GOcv86El7AxS9VMyfMdKN1C3yRmB/npK0BVeq4AsraiwjJZfYFd9FaftCHKh3w
 VItM8Th4Hv9vNknnviRACJE9ZB4Lm78OcZQcNUWyA/lrCeK4kr7jp4CrR4ovn3pdocnO
 dcIsA1U+/bmKal03a5l2QSyMp8A9Z1g44QzqVhxg92MLE4V15IhBpGmN6GDATR0naSva
 kpbBawW7y382sc4Pgrp0Y5Wgq0xrIULpQBJOKIDmr8A+y+Vx6opr87OH9a3OM9jpmaXH
 VxLA==
X-Gm-Message-State: AC+VfDwVxd5ZJ/k7qSKfFpdi8ACz8V3wfRiha35pHwNb4m3hudYFKWC3
 FQKHel6V5ZSoa8fX9uDf/7uwE0Iojo3ygqyogTM=
X-Google-Smtp-Source: ACHHUZ6aTpebiLEO6mt0wKbCa5B7CZIm2EOQD/7vtlRT/3j8di01VPWWwSPwEly13yGxpfS2J35dYf050YoXYbOi1UE=
X-Received: by 2002:a1c:7705:0:b0:3f9:6f7:9d7d with SMTP id
 t5-20020a1c7705000000b003f906f79d7dmr8165005wmi.0.1687273664312; Tue, 20 Jun
 2023 08:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-3-faithilikerun@gmail.com>
 <20230619101031.GC2497337@fedora>
 <CAAAx-8+WmeTGM=PoRxorGmexYqM8uUGyqGeLYyQPLQ0+K6iaUA@mail.gmail.com>
 <20230619144215.GF2497337@fedora>
 <CAAAx-8+Jnpx7AvytRdGCwA00QpuDM9F3=GiWY2UCrZNjWC3czg@mail.gmail.com>
 <20230620144425.GE2625194@fedora>
In-Reply-To: <20230620144425.GE2625194@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 20 Jun 2023 23:07:17 +0800
Message-ID: <CAAAx-8LVMA=FHQGAD+ehqHm-9=k06v2hkJONC7VDykGgppSgeA@mail.gmail.com>
Subject: Re: [RFC 2/4] qcow2: add configurations for zoned format extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com, 
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=faithilikerun@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 19, 2023 at 10:50:31PM +0800, Sam Li wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=80 22:42=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Jun 19, 2023 at 06:32:52PM +0800, Sam Li wrote:
> > > > Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=B8=80 18:10=E5=86=99=E9=81=93=EF=BC=9A
> > > > > On Mon, Jun 05, 2023 at 06:41:06PM +0800, Sam Li wrote:
> > > > > > diff --git a/block/qcow2.h b/block/qcow2.h
> > > > > > index 4f67eb912a..fe18dc4d97 100644
> > > > > > --- a/block/qcow2.h
> > > > > > +++ b/block/qcow2.h
> > > > > > @@ -235,6 +235,20 @@ typedef struct Qcow2CryptoHeaderExtension =
{
> > > > > >      uint64_t length;
> > > > > >  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> > > > > >
> > > > > > +typedef struct Qcow2ZonedHeaderExtension {
> > > > > > +    /* Zoned device attributes */
> > > > > > +    BlockZonedProfile zoned_profile;
> > > > > > +    BlockZoneModel zoned;
> > > > > > +    uint32_t zone_size;
> > > > > > +    uint32_t zone_capacity;
> > > > > > +    uint32_t nr_zones;
> > > > > > +    uint32_t zone_nr_conv;
> > > > > > +    uint32_t max_active_zones;
> > > > > > +    uint32_t max_open_zones;
> > > > > > +    uint32_t max_append_sectors;
> > > > > > +    uint8_t padding[3];
> > > > >
> > > > > This looks strange. Why is there 3 bytes of padding at the end? N=
ormally
> > > > > padding would align to an even power-of-two number of bytes like =
2, 4,
> > > > > 8, etc.
> > > >
> > > > It is calculated as 3 if sizeof(zoned+zoned_profile) =3D 8. Else if=
 it's
> > > > 16, the padding is 2.
> > >
> > > I don't understand. Can you explain why there is padding at the end o=
f
> > > this struct?
> >
> > The overall size should be aligned with 64 bit, which leaves use one
> > uint32_t and two fields zoned, zoned_profile. I am not sure the size
> > of macros here and it used 4 for each. So it makes 3 (*8) + 32 + 8 =3D
> > 64 in the end. If the macro size is wrong, then the padding will
> > change as well.
>
> The choice of the type (char or int) representing an enum is
> implementation-defined according to the C17 standard (see "6.7.2.2
> Enumeration specifiers").
>
> Therefore it's not portable to use enums in structs exposed to the
> outside world (on-disk formats or network protocols).
>
> Please use uint8_t for the zoned_profile and zoned fields and move them
> to the end of the struct so the uint32_t fields are naturally aligned.
>
> I think only 2 bytes of padding will be required to align the struct to
> a 64-bit boundary once you've done that.

I see. Thanks!

Sam

