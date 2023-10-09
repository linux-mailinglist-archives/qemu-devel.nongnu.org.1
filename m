Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CB7BD491
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkvk-0005V1-Mn; Mon, 09 Oct 2023 03:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qpkvi-0005UZ-OM; Mon, 09 Oct 2023 03:43:54 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qpkvg-0007kL-Tp; Mon, 09 Oct 2023 03:43:54 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-533cbbd0153so7221299a12.0; 
 Mon, 09 Oct 2023 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696837430; x=1697442230; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPyTY+fdVze7+Hd0DVsRzPfhK7CvUUyJ47HStWmraGA=;
 b=NjuK62BSZQynE+P50Ox2ab/LdSo2q5L9Mkl94/NBGbzXTJuZTgf5DHsOS4TRQrIQwl
 PNi4i6/q/o1QCNUUUN8kU2uNRA+4JKnhCjjvisVyQKHTAzdDMsCYQ6fYIDzs7XGqd7br
 pc80s84qmUZGT+69aQIAnkHcZkggAhrpjxcOxICyP3fjIcoRmdrbLZ2JkM99vhuwSPuA
 WaDafQtMUIkHtdbFI2SdmZ/AjDO9q0Mmg3+7NmRHmamQAz8mqccKHPYgO0Vde7fj/JZP
 9BdV3stuN1I0t3MPTDKkFqn3hS+3El0HS9r6CsDYqsopJ10+LDhd+ggR/ABCE1cQhk7A
 6aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696837430; x=1697442230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPyTY+fdVze7+Hd0DVsRzPfhK7CvUUyJ47HStWmraGA=;
 b=UF/I0QZzMnFE/eiBPH/IFPUnYcXMEKxC6INRKoir3V0W0PL10543Qs+GP8hsHrHEL3
 N0HLfTYAerkgxHE1RY9RMFufGgX0A8ej382ZioIr70QQoA3g6dTtHK/70pt4baUNSq7w
 wH2gHKPTfA35Xs3n2WGuZ8TYaCjGx/t+MqZ2wq2cZmPjjZCTc/kQYmjHQQbFrrBerLoG
 ZZBIQv97DNM9dPhsUFgcvyXbnwb/2q8T1LqsjKVNNfao8NyPQPYfPiWz07U4lBfeAoWm
 6s5BKC+ENNFcpwhU+9PmSkjgOyIDpxPjSgxaZqiTpIzGFa+A4L80QvLGE9u26IlXaR7V
 KonA==
X-Gm-Message-State: AOJu0YzzuyeGmklxgATyAye7ZnykGf5x7Lm/x1jLl2vab0clTz/253Dd
 5853GbiCZkyBJjEy1kisgP5CyHmFTMH4zM3i74A=
X-Google-Smtp-Source: AGHT+IHUzZIXjGq35yh33kWC7Awytzvz54iGeKpbzEH2nL9vbanOjUrOo/4CHUrcJl6B9gvBKPFAxf4CmH6GT4zhk74=
X-Received: by 2002:a17:906:8465:b0:9b7:2e2d:9bc3 with SMTP id
 hx5-20020a170906846500b009b72e2d9bc3mr14221558ejc.9.1696837429793; Mon, 09
 Oct 2023 00:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230918095313.5492-1-faithilikerun@gmail.com>
 <20230918095313.5492-4-faithilikerun@gmail.com>
 <grw7r46o3mkaszignhfexvdquamlau3ycazdiz26lpfs4jiepv@etfjsofexr5x>
In-Reply-To: <grw7r46o3mkaszignhfexvdquamlau3ycazdiz26lpfs4jiepv@etfjsofexr5x>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 9 Oct 2023 15:43:21 +0800
Message-ID: <CAAAx-8+eA9GKR4rvpHzqLEzqbHKpyV1d3xPDcftcWDuGeizKfw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] qcow2: add zoned emulation capability
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, 
 stefanha@redhat.com, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x531.google.com
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

Eric Blake <eblake@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=BA=94 03:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 18, 2023 at 05:53:12PM +0800, Sam Li wrote:
> > By adding zone operations and zoned metadata, the zoned emulation
> > capability enables full emulation support of zoned device using
> > a qcow2 file. The zoned device metadata includes zone type,
> > zoned device state and write pointer of each zone, which is stored
> > to an array of unsigned integers.
> >
> > Each zone of a zoned device makes state transitions following
> > the zone state machine. The zone state machine mainly describes
> > five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
> > READ ONLY and OFFLINE states will generally be affected by device
> > internal events. The operations on zones cause corresponding state
> > changing.
> >
> > Zoned devices have a limit on zone resources, which puts constraints on
> > write operations into zones.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/qcow2.c          | 709 ++++++++++++++++++++++++++++++++++++++++-
> >  block/qcow2.h          |   2 +
> >  block/trace-events     |   2 +
> >  docs/interop/qcow2.txt |   6 +
> >  4 files changed, 717 insertions(+), 2 deletions(-)
>
> You may want to look at scripts/git.orderfile; putting spec changes
> (docs/*) first in your output before implementation is generally
> beneficial to reviewers.
>
> > +++ b/docs/interop/qcow2.txt
> > @@ -367,6 +367,12 @@ The fields of the zoned extension are:
> >                      The maximal number of 512-byte sectors of a zone
> >                      append request that can be issued to the device.
> >
> > +          36 - 43:  zonedmeta_offset
> > +                    The offset of zoned metadata structure in the file=
 in bytes.
>
> For the spec to be useful, you also need to add a section describing
> the layout of the zoned metadata structure actually is.
>
> > +
> > +          44 - 51:  zonedmeta_size
> > +                    The size of zoned metadata in bytes.
> > +
>
> Can the zoned metadata structure ever occupy more than 4G, or can this
> field be sized at 4 bytes instead of 8?

The zoned metadata is the write pointers of all zones. The size of it
is nr_zones (uint32_t) * write_pointer size (uint64_t). So it will not
occupy more than 4G. But it still need more than 4 bytes.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>

