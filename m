Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2517EE656
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:03:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ggO-0000y8-6b; Thu, 16 Nov 2023 13:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r3ggK-0000xp-Sl; Thu, 16 Nov 2023 13:01:37 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r3ggI-0002QI-NZ; Thu, 16 Nov 2023 13:01:36 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso1697687a12.3; 
 Thu, 16 Nov 2023 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700157692; x=1700762492; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrZoE2RAshPUg3s4PRjlTQD6BKAoKYIVmreeXNy9wEU=;
 b=aXnOceKI0UndbeKBRnUM6l1tQBKNLEFU0IA6w/FJ350kDUPE67Q/2oAhlx8xzlOTAy
 NQVvH3IFVw7BINZ8g5IJG20x8ENk3vXrpS8jJhKFvQFoOjIGL50PuVupR6y0hi75PwJP
 /Kc8fYfQBGBV1B+8utStrjrc/wOPGTTg/eUbiEKOBQDk1VgqlINoQwAtki/8V19OQhdR
 xq0iupfMZVmqNUfB5qrA6YjbURPG6Kw5PCbf6dwyZ7EseOnIdKoLnEamrX1Ld3LB41T4
 spXsfJy2jZfX460zXou40IC053Eu4IyIRou71rVc3deBUVi+P0hAXZ92139Nu6uoUvym
 1d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700157692; x=1700762492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrZoE2RAshPUg3s4PRjlTQD6BKAoKYIVmreeXNy9wEU=;
 b=fqk5BoDccvC/bTxu+ZnfAAZyk8vph+q01m3V+JLFkQUcbrOd52ttdAQbPqRQyebvnj
 AJQAzHy8irR/V5xL+W1eob8PZ6iDWWmXPOV/yS3Ab5Dytb0WJW7D0gjWxQZxzWjO19QV
 YrF7tsCf61RfQYltP411a/7I9y56336CvSR2TrHUekfErpzX4vaigVuCa2YqD4H2SEHX
 PFyu7mTDRFZHNPjcL17kcybe5dquXoo8of7BhQ0VsC9m48UZUfp/XYVNVTDKAJMQkvvJ
 IO+97S+to85FaJkO852XoO2HfcvEq+I/RTmoYSwH/V6x8Fwr9tMg/d1zF3FXlFJRF693
 ITdw==
X-Gm-Message-State: AOJu0YysJxqtIYjup3Zx/yzBng00SAHNH+1bSGhbPzxp0i6I3Afa26a8
 lQpZxGfCFiMxiLgQlgB7xJt5lkcLu0Cj3OOP/ic=
X-Google-Smtp-Source: AGHT+IH++Va6W/3Q4jp9VhW2JId8JatMjaF4Eu0N7b8C0vw5rnayvq+X5pHxoguD5gEi0vhZu3cqNqbL1NtEBuB7LaM=
X-Received: by 2002:a17:906:1188:b0:9d5:9ff5:ce with SMTP id
 n8-20020a170906118800b009d59ff500cemr11173876eja.34.1700157691534; Thu, 16
 Nov 2023 10:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-3-faithilikerun@gmail.com>
 <i43illqyyzu7wbotuw2fbuft7izdmfo7jkwnds4yrigewachhw@7pudpozwjer5>
 <878r7f19xm.fsf@pond.sub.org>
In-Reply-To: <878r7f19xm.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 17 Nov 2023 02:01:05 +0800
Message-ID: <CAAAx-8JLLzk+GeGM1b8gVKZO+j_HFL6ugceUU6RTn+x0nDJo0w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, dlemoal@kernel.org, hare@suse.de, 
 dmitry.fomichev@wdc.com, stefanha@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52d.google.com
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=94 17:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Eric Blake <eblake@redhat.com> writes:
>
> > On Mon, Oct 30, 2023 at 08:18:45PM +0800, Sam Li wrote:
> >> To configure the zoned format feature on the qcow2 driver, it
> >> requires settings as: the device size, zone model, zone size,
> >> zone capacity, number of conventional zones, limits on zone
> >> resources (max append bytes, max open zones, and max_active_zones).
> >>
> >> To create a qcow2 file with zoned format, use command like this:
> >> $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> >> zone_size=3D64M -o zone_capacity=3D64M -o conventional_zones=3D0 -o
> >> max_append_bytes=3D4096 -o max_open_zones=3D0 -o max_active_zones=3D0
> >> -o zone_model=3Dhost-managed
> >>
> >> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >>
> >> fix config?
> >
> > Is this comment supposed to be part of the commit message?  If not,...
> >
> >> ---
> >
> > ...place it here under the divider, so 'git am' won't include it, if th=
ere is nothing further to change on this patch.
>
> [...]
>
> >> +++ b/qapi/block-core.json
> >> @@ -4981,6 +4981,21 @@
> >>  { 'enum': 'Qcow2CompressionType',
> >>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >>
> >> +##
> >> +# @Qcow2ZoneModel:
> >> +#
> >> +# Zoned device model used in qcow2 image file
> >> +#
> >> +# @non-zoned: non-zoned model is for regular block devices
> >> +#
> >> +# @host-managed: host-managed model only allows sequential write over=
 the
> >> +#     device zones
> >> +#
> >> +# Since 8.2
> >> +##
> >> +{ 'enum': 'Qcow2ZoneModel',
> >> +  'data': ['non-zoned', 'host-managed'] }
> >> +
> >>  ##
> >>  # @BlockdevCreateOptionsQcow2:
> >>  #
> >> @@ -5023,6 +5038,27 @@
> >>  # @compression-type: The image cluster compression method
> >>  #     (default: zlib, since 5.1)
> >>  #
> >> +# @zone-model: @Qcow2ZoneModel.  The zone device model.
> >> +#     (default: non-zoned, since 8.2)
> >> +#
> >> +# @zone-size: Total number of bytes within zones (since 8.2)
> >
> > If @zone-model is "non-zoned", does it make sense to even allow
> > @zone-size and friends?  Should this use a QMP union, where you can
> > pass in the remaining zone-* fields only when zone-model is set to
> > host-managed?
>
> Valid question; needs an answer.

Yes, it should use a QMP union. It's better to separate those fields
for zoned and non-zoned.

>
> >> +#
> >> +# @zone-capacity: The number of usable logical blocks within zones
> >> +#     in bytes.  A zone capacity is always smaller or equal to the
> >> +#     zone size (since 8.2)
> >> +#
> >> +# @conventional-zones: The number of conventional zones of the
> >> +#     zoned device (since 8.2)
> >> +#
> >> +# @max-open-zones: The maximal number of open zones (since 8.2)
> >> +#
> >> +# @max-active-zones: The maximal number of zones in the implicit
> >> +#     open, explicit open or closed state (since 8.2)
> >> +#
> >> +# @max-append-bytes: The maximal number of bytes of a zone
> >> +#     append request that can be issued to the device.  It must be
> >> +#     512-byte aligned (since 8.2)
> >> +#
> >>  # Since: 2.12
> >>  ##
> >>  { 'struct': 'BlockdevCreateOptionsQcow2',
> >> @@ -5039,7 +5075,14 @@
> >>              '*preallocation':   'PreallocMode',
> >>              '*lazy-refcounts':  'bool',
> >>              '*refcount-bits':   'int',
> >> -            '*compression-type':'Qcow2CompressionType' } }
> >> +            '*compression-type':'Qcow2CompressionType',
> >> +            '*zone-model':         'Qcow2ZoneModel',
> >> +            '*zone-size':          'size',
> >> +            '*zone-capacity':      'size',
> >> +            '*conventional-zones': 'uint32',
> >> +            '*max-open-zones':     'uint32',
> >> +            '*max-active-zones':   'uint32',
> >> +            '*max-append-bytes':   'uint32' } }
> >
> > In other words, I'm envisioning something like an optional
> > '*zone':'ZoneStruct', where:
> >
> > { 'struct': 'ZoneHostManaged',
> >   'data': { 'size': 'size', '*capacity': 'size', ..., '*max-append-byte=
s': 'uint32' } }
> > { 'union': 'ZoneStruct',
> >   'base': { 'model': 'Qcow2ZoneModel' },
> >   'discriminator': 'model',
> >   'data': { 'non-zoned': {},
> >             'host-managed': 'ZoneHostManaged' } }
> >
> > then over the wire, QMP can use the existing:
> > { ..., "compression-type":"zstd" }
> >
> > as a synonym for the new but explicit non-zoned:
> > { ..., "compression-type":"zstd", "zone":{"mode":"non-zoned"} }
>
> I.e. @zone is optional, and defaults to {"mode": "non-zoned"}.
>
> > and when we want to use zones, we pass:
> > { ..., "compression-type":"zstd", "zone":{"mode":"host-managed", "size"=
:16777216} }
> >
> > where you don't have to have zone- prefixing everywhere because it is
> > instead contained in the smart union object where it is obvious from
> > the 'mode' field what other fields should be present.
>

Yes, it's better. Thanks!

Sam

