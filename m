Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F87718B6
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 05:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSqbp-0007gg-AK; Sun, 06 Aug 2023 23:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.cromie@gmail.com>)
 id 1qSqbm-0007gY-Kv
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 23:08:38 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.cromie@gmail.com>)
 id 1qSqbl-0000jL-4g
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 23:08:38 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-79b4d2c0621so5150241.2
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691377715; x=1691982515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CBcw6g+B1D4tUJpK4I7gE99+eMJubM0GowA7vpvQ3E=;
 b=lGUGUFYn/wjtFJLCgBM4OXR0qhFuYtrmuzKJLsN+ZA9h4qpVJZKKlMAVbcpihAJkV2
 wZFKdPqWRcHsEFi79fksFRKLE0sJpBmQ8zyaRfVLQoicZRCiibr94lLoVyHTHeAfMPcJ
 zjFQg4DP2fTWyIG+yUcn8ZC5zyDhQfbkWabWlo6wicNYTLR52vThZUu962jvP9UVXeZN
 i0yDjzyNuQWMBNxbZEvCt7V09f7XOgHwB3XUFfh5EEE035isCYHTQUgY8WxQeNXGs+1F
 OVV0GSePT+5AKTQfflxU+SmPkBu4JpSPwme6sIVOIVZf+tyh8p1Ej8ALKhzKXNb7M8br
 WEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691377715; x=1691982515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CBcw6g+B1D4tUJpK4I7gE99+eMJubM0GowA7vpvQ3E=;
 b=jAUn6FYNgFhGTYalnDj1eAYBRLY2cwBGTEOc9Azilo6XVUkW4gIOEhLgxH4pkHgkwF
 ZChXPnHCcXLURmUJfj2tV/BlgriPvy+9LXd6i7ywkbHTUIfQDFZn7x30Srk8D71U3dMe
 oRhsTp6Sw84t71MJEzcsJH8hT6gYMB45LZofRP9+/GA+EEVX9tOtecEfxjzdoGTgOg1/
 IiP+HFUGAFjC5IIvs0FoFvZiMkQWLXJdbWvQEfM0rS5ItZetz3rCl4Q7sXGfJ2vnUWdn
 Q922HnEO9ZzFfzl/4FhsSfqjgmeWXNxPHcWlsVZJum9Lm75Ci0HTgr+pGxPnqqsE3Wsk
 U6DQ==
X-Gm-Message-State: AOJu0Yz6LVTER031Jk7c9qwoM4e4lyTCfTH7bg6aVRVMfNPhWxv4VOV6
 vclDAKxCDVVhbUriFTzgIjDafmnAeRY/NNwpU2k=
X-Google-Smtp-Source: AGHT+IEXJohVZqT1/MwMRRijCCTFo+Ss2708952SaHXYbYQj6oLXZ6VhHA4uGDgAMtPg6JseqOj1qTFUlgnKANJn3nA=
X-Received: by 2002:a67:f24b:0:b0:447:48ab:cff2 with SMTP id
 y11-20020a67f24b000000b0044748abcff2mr2552185vsm.19.1691377714839; Sun, 06
 Aug 2023 20:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230804190101.759753-1-jim.cromie@gmail.com>
 <87r0oiypgk.fsf@pond.sub.org>
In-Reply-To: <87r0oiypgk.fsf@pond.sub.org>
From: jim.cromie@gmail.com
Date: Sun, 6 Aug 2023 21:08:08 -0600
Message-ID: <CAJfuBxwxwLp7j_zgVmr8WsKkPtdYH5=onScnsOQms7gtEGo0Ww@mail.gmail.com>
Subject: Re: [PATCH] print memory in MB units in initrd-too-large errmsg
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=jim.cromie@gmail.com; helo=mail-ua1-x935.google.com
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

On Sat, Aug 5, 2023 at 12:26=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Jim Cromie <jim.cromie@gmail.com> writes:
>
> > Change 2 error messages to display sizes in MB, not bytes.
> >
> > qemu: initrd is too large, cannot support this. (max: 2047 MB, need 583=
3 MB)
> >
> > Also, distinguish 2 sites by adding "it" and "this" respectively.
> > This tells a careful reader that the error above is from the 2nd size
> > check.
>
> I don't like this part.
>
> > With MB displayed, I have to ask: is it coincidence that max =3D=3D 204=
8-1 ?
>
> I don't know.
>

I found this in hw/i386/x86.c

    924         /*
    925          * Linux has supported initrd up to 4 GB for a very
long time (2007,
    926          * long before XLF_CAN_BE_LOADED_ABOVE_4G which was
added in 2013),
    927          * though it only sets initrd_max to 2 GB to "work
around bootloader
    928          * bugs". Luckily, QEMU firmware(which does something
like bootloader)
    929          * has supported this.
    930          *
    931          * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is
set, initrd can
    932          * be loaded into any address.
    933          *
    934          * In addition, initrd_max is uint32_t simply because
QEMU doesn't
    935          * support the 64-bit boot protocol (specifically the
ext_ramdisk_image
    936          * field).
    937          *
    938          * Therefore here just limit initrd_max to UINT32_MAX
simply as well.
    939          */



> You're rounding both values down.  Consider
>
>     initrd_max =3D 1000.5MiB - 1 exactly
>     initrd_size =3D 1000.5MiB + 4096
>
> Before the patch, we report
>
>     (max: 1049100287, need 1049104384)
>
> Unfriendly, but at least it's correct.  Afterwards
>
>     (max: 1000 MB, need 1000 MB)
>
> Wat?  Long-suffering users may guess the rounding issue.  But let's not
> make users guess.
>
> Better would be something like
>
>     size of initrd exceeds the limit of X MiB by Y Bytes
>
> *if* X is actually a multiple of 1 MiB.  Else, we need to consider
> showing a suitably rounded fractional part, or stick to Bytes after all.
>

ok, that makes sense.

But 1st I gotta figure out why a 2gb initrd size limit
is not a show-stopper problem for lkp-robot.

https://lore.kernel.org/oe-lkp/202308031432.fcb4197-oliver.sang@intel.com/
has reproducer, that I cannot execute.
I have deleted ~/.lkp and /lkp has 2 empty subdirs

