Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E890706F0B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:08:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKbe-0001fZ-J0; Wed, 17 May 2023 13:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzKbY-0001ei-S7
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzKbW-0004hm-3e
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684343181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8wFFpXJ5pNgzAZu3GVCuTahYgOyLaDI0F+rRTx7G/I=;
 b=aIZWJo+k+TCtN0O0rB83Cx7IFZXIQBU5ynNs1eSEcHyRa4OmBTjXXURMmwrS1eKCDgO5+a
 CBG9mtpqjGej3x/kX7n1hgxZg343VKPZrgIkWCzVbmK4Le2+tCpACOsRYslhK8w0hm5bnZ
 tCg0B6DircjFiBaa2KjJHWpStwlB77o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-aJMwx9sxOtSpX9p3ldN2QQ-1; Wed, 17 May 2023 13:06:18 -0400
X-MC-Unique: aJMwx9sxOtSpX9p3ldN2QQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2533b1e6e66so709891a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684343177; x=1686935177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8wFFpXJ5pNgzAZu3GVCuTahYgOyLaDI0F+rRTx7G/I=;
 b=TDUnsidC+VRzpH6DSlWCHwGbAjj9h8GxlgfsoZwgWUSRb6K6ZJT9jmjQwKurM51VIl
 Xju93RmJ1wvVtHJPZqmick4jIsFgbrVfwV3HB3I6B7p2PA2OWagtJsuisNKcQlh8oc6T
 TJzaFtpK2m02+kayh6mLW5eWqBe4IeD8FAH81I5I2Tz1Ml+CAmw4dxkOjqh9fMhijtNy
 PZbvUTc+1fN6KMECKWjSZDoFXDa9FjksWWyQHxJoV15O1YG+SephYhfsNHDBd0i85Sby
 3DAUrW4bYq39iJQ12X3Z8N5NshuFBMkztcTVTsZHZe1gu1g08OlLcHpIBu8VEasbGCOj
 CnpQ==
X-Gm-Message-State: AC+VfDw7QkAwSeCnzJIpvyk4pJrjuurjzgmIh40CvtjQCKc1gnnaX+3Z
 nyMc+tZXPnvLCaLfdrI72L3wkdjCzZs0g6R9VzrroBWVdgFMKHwN14iojRP06bSO/J1ATZMZdJW
 YPmr4BdLziK4bvnIDx0nMreeT6gOMq28=
X-Received: by 2002:a17:90a:e612:b0:250:ca6c:d7a8 with SMTP id
 j18-20020a17090ae61200b00250ca6cd7a8mr354643pjy.29.1684343177552; 
 Wed, 17 May 2023 10:06:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4YvWfdPHGYz/5d/DdJM87CUwJuyp64vCnjYy3pstt9wvQo4jat8T1VjBBVGhLhHrlr617Qorh1IYXNZyhf25k=
X-Received: by 2002:a17:90a:e612:b0:250:ca6c:d7a8 with SMTP id
 j18-20020a17090ae61200b00250ca6cd7a8mr354622pjy.29.1684343177245; Wed, 17 May
 2023 10:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132124.670840-1-nks@flawful.org>
In-Reply-To: <20230428132124.670840-1-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 13:06:06 -0400
Message-ID: <CAFn=p-Zk37sNFjHd5e77UCqeCUczZmEOvFQ2QKZcE3eQJau5Nw@mail.gmail.com>
Subject: Re: [PATCH 0/9] misc AHCI cleanups
To: Niklas Cassel <nks@flawful.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 28, 2023 at 9:22=E2=80=AFAM Niklas Cassel <nks@flawful.org> wro=
te:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> Hello John,
>

Hi Niklas!

I haven't been actively involved with AHCI for a while, so I am not
sure I can find the time to give this a deep scrub. I'm going to
assume based on '@wdc.com` that you probably know a thing or two more
about AHCI than I do, though. Can you tell me what testing you've
performed on this? As long as it doesn't cause any obvious
regressions, we might be able to push it through, but it might not be
up to me anymore. I can give it a review on technical merit, but with
regards to "correctness" I have to admit I am flying blind.

(I haven't looked at the patches yet, but if in your commit messages
you can point to the relevant sections of the relevant specifications,
that'd help immensely.)

> Here comes some misc AHCI cleanups.
>
> Most are related to error handling.

I've always found this the most difficult part to verify. In a real
system, the registers between AHCI and the actual hard disk are
*physically separate*, and they update at specific times based on the
transmission of the FIS packets. The model in QEMU doesn't bother with
a perfect reproduction of that, and so it's been a little tough to
verify correctness. I tried to improve it a bit back in the day, but
my understanding has always been a bit limited :)

Are there any vendor tools you're aware of that have test suites we
could use to verify behavior? Our AHCI tests are very rudimentary - I
wrote them straight out of undergrad as my first project at RH - and
likely gloss over and misunderstand many things about the
ATA/SATA/AHCI specifications.

>
> Please review.
>
> (I'm also working on a second series which will add support for
> READ LOG EXT and READ LOG DMA EXT, but I will send that one out
> once it is ready.)

Wow!

A question for you: is it worth solidifying which ATA specification we
conform to? I don't believe we adhere to any one specific model,
because a lot of the code is shared between PATA and SATA, and we "in
theory" support IDE hard drives for fairly old guest operating systems
that may or may not predate the DMA extensions. As a result, the
actual device emulation is kind of a mish-mash of different ATA
specifications, generally whichever version provided the
least-abstracted detail and was easy to implement.

If you're adding the logging features, that seems to push us towards
the newer end of the spectrum, but I'm not sure if this causes any
problems for guest operating systems doing probing to guess what kind
of device they're talking to.

Any input?

>
>
> Kind regards,
> Niklas
>
>
> Niklas Cassel (9):
>   hw/ide/ahci: remove stray backslash
>   hw/ide/core: set ERR_STAT in unsupported command completion
>   hw/ide/ahci: write D2H FIS on when processing NCQ command
>   hw/ide/ahci: simplify and document PxCI handling
>   hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>   hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
>   hw/ide/ahci: trigger either error IRQ or regular IRQ, not both
>   hw/ide/ahci: fix ahci_write_fis_sdb()
>   hw/ide/ahci: fix broken SError handling
>
>  hw/ide/ahci.c | 111 +++++++++++++++++++++++++++++++++++---------------
>  hw/ide/core.c |   2 +-
>  2 files changed, 80 insertions(+), 33 deletions(-)
>
> --
> 2.40.0
>


