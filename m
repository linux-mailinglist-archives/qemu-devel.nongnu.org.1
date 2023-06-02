Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC57208C8
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 20:05:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5988-0005oD-Iy; Fri, 02 Jun 2023 14:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q5986-0005nz-Fw; Fri, 02 Jun 2023 14:04:02 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q5984-00052N-Ko; Fri, 02 Jun 2023 14:04:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so3444673a12.2; 
 Fri, 02 Jun 2023 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685729037; x=1688321037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQxJldLhzzA+0rqEwavsU8CI64WohuonIQmvgJb66ew=;
 b=CDROm0jQDdbJ09BKDDJewlFIZdEfzzhXFhDc0XvoYXHRpIcq+j6Bt03yXtUCRstgdA
 tZa9ufplgj3rj4ldjtG23U/z955cCU1PJLroz4lLdkS8eyOrqw1sd72IqeOMElHcapNL
 FZaGddx4ryhh01II0T7ECQWX56xe6xCHjkC1MIn7ZFLrmKI3rdFlPBYl4kx3bHM4Ijf3
 udtpmct/Vd4Z9V97NmDEGB+X+j8GO0dgC1zHNclDx1G8fbAsy70v9AmiOopSC0EFq4oP
 BPl0mwNcJG6O3pMIemcFWUNLVV4XfgKAl+9gs0L63dTXCVMN5QjlKohmSiIXaMc98oZz
 4/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685729037; x=1688321037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQxJldLhzzA+0rqEwavsU8CI64WohuonIQmvgJb66ew=;
 b=eu5JZhWU6iUS0qrRQUjf7SmwMSxZKGtbsHxQVTlGbYHfrnm6SWh4SX4IMXu0sj+tKU
 HgqBRVHLLLAj1NUNZv1dcI4pz3uq596Xn62E341T1ZPJU29vI4i+V/7v2VqHRNlpiNiH
 yKO53F3JpxRW10hp/7Vu6vTAYuOKBDkvXYK8t+bACewNyGOrqIg2mC9cZTung0PqEzq2
 B7fnLIsBjE4Ixl720FvoSkjzh960N3Gqkt9WIlo1T8Z8plGHS6gzW9npeJ/Q1HlCgPgN
 SNIRa+zJTtxvtTesAj/ZZbl/Hg1gL06VHE569u282n4uNMhLjbnE1G7BqFVXfkLjQ/FT
 LxJA==
X-Gm-Message-State: AC+VfDy9twPuPXsST2yA+YUp94hPM+EbpZl5WcTP6CG1adjF68Lm+zla
 BELFDYHaAINkc0iLU4k7c3OWazx47adE8auGDUE=
X-Google-Smtp-Source: ACHHUZ4rCDkxlaqapiaYIuUD4L/j++WA3AV1C7shjVCpFWwwvDaZPQ1LWy5T8QKC8M8y5H3UD1hDU0L7fcVLII1+FgI=
X-Received: by 2002:a17:907:78b:b0:966:3310:50ae with SMTP id
 xd11-20020a170907078b00b00966331050aemr11454542ejb.47.1685729036990; Fri, 02
 Jun 2023 11:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-11-stefanha@redhat.com>
 <CAFEAcA9bDh12FSk8CjEkBZjQOEBVd6-=fVwnM9bx8aoXvQdMuw@mail.gmail.com>
 <CAAAx-8L4Z3tBzV5DMEy0WnG=3y67bp_1g-+2kUhrY+rp2knNKA@mail.gmail.com>
 <CAFEAcA-WMkcreH7csiNyMBXCsS5XhcPK0vdRKiL70M_r18oYYg@mail.gmail.com>
 <CAAAx-8LY9NX8veVhin=ThpqbpgP82GV4X9sXMzD9D0r2BqANxw@mail.gmail.com>
 <CAFEAcA-2-70rwHCxcQvpE-tZRn4qytBSx4b31ZtFhZ97ZpHZNg@mail.gmail.com>
In-Reply-To: <CAFEAcA-2-70rwHCxcQvpE-tZRn4qytBSx4b31ZtFhZ97ZpHZNg@mail.gmail.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Sat, 3 Jun 2023 02:03:30 +0800
Message-ID: <CAAAx-8LneVxfD1onK076-n5B2ZfVveQoiKtRDr-h+FaF0wwmng@mail.gmail.com>
Subject: Re: [PULL v2 10/16] block: introduce zone append write for zoned
 devices
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52f.google.com
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

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=883=
=E6=97=A5=E5=91=A8=E5=85=AD 01:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2 Jun 2023 at 18:35, Sam Li <faithilikerun@gmail.com> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=
=883=E6=97=A5=E5=91=A8=E5=85=AD 01:30=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, 2 Jun 2023 at 18:23, Sam Li <faithilikerun@gmail.com> wrote:
> > > > Thanks for spotting this. You are right that bs->wps is not checked=
 in
> > > > this code path. I think the get_zones_wp() should handle a NULL
> > > > bs->wps which is the function calling wps directly.
> > > >
> > > > Would you like to submit a patch for this? Or I can do it if you ar=
e
> > > > not available.
> > >
> > > I don't know anything about this code, so I'm not really in
> > > a position to write a patch. I'm just passing on the information
> > > from the Coverity scanner -- it scales a lot better that way
> > > than trying to write fixes for everything myself :-)
> >
> > I see. I'll fix it. Wish I had known more about this tool when I was
> > testing this code.
>
> Coverity is a bit awkward because the free online scanner only
> runs on code that's already been committed to QEMU, so it doesn't
> tell us about issues until we've already gone through the
> whole code-review-test cycle. Plus it often complains about
> things that aren't bugs, so you have to be a bit cautious
> about interpreting its reports. But it's still a nice tool
> to have.
>
> The online UI is at https://scan.coverity.com/projects/qemu
> and you can create an account and apply for permission to look
> at the recorded defects if you like.

Good to know. Thanks!

Sam

