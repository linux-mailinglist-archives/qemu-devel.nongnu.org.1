Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E7765309
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOzXT-0008JA-Td; Thu, 27 Jul 2023 07:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qOzXS-0008Ix-8c; Thu, 27 Jul 2023 07:52:14 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qOzXQ-0006gz-Nf; Thu, 27 Jul 2023 07:52:14 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so1796111a12.0; 
 Thu, 27 Jul 2023 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690458730; x=1691063530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQ2QGJQmltGx8mQaWCntuf83gcCv5XwWImyUXoZALwg=;
 b=U8AyKuGPvMmC3p9fKT/FpzuJWUePM5tUNNvNMWRuHPaBnDIDmHWAedrRyE5X5vJJKI
 Jf5Z1hB9tGcvQZ0LDXovUJEPNusKoeUYdvUB4n5mjBqkNjF+0ItQ8h93ZCDywACT2LlN
 QqTtreeAi+sZORv3KS6AjOtvkYrs9Vg3AMJyy2H3O6JiRPGYg2V6Nt4MgSC1SRwcJzyL
 FRk6DKMw44ffkRxtuq8X9YMEZu2nl12fAbgHwKyfauXPmNv1hY4RjIFxEU05bcWDIuTZ
 E3jctWcJIE8AlCdgEIFWKPEJy8iU32ZzpGCIyo8M3GJLqCgLHcZbCE0ghfaIRmxzkcME
 kwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690458730; x=1691063530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQ2QGJQmltGx8mQaWCntuf83gcCv5XwWImyUXoZALwg=;
 b=BmiUYl49/+/NWUSf5f87MrhaOM6x+aSUJiLLH2LnBKmgaAy6X2R03NA/T72Pniwh8j
 X0WFvvQxEPTjLZxm6vq20qoiKyy++GJdwZmhsxnyrdv1Oc442uTBtSPofdLG29POJM25
 7i270mJk5lLum028Y7muL6V3B5J+JijxHroqOD2zvEzQjUeZ+9P9ad156AdbEix+oEwH
 bb5xgJemfpq7zGFIQQzS5Dj6ZfMvnl8fsJsCtYlc2MbPqKkgW8vKOHZH2IMNf0w1Q0lp
 tkKdAUJRItC7nwlgmf2zlTFJIy8XXKK1MRTB7SCr2URNgDpEB+8npqlR0lMXAUn7uGFE
 ZyxQ==
X-Gm-Message-State: ABy/qLaabYABx+r8EcGkREaP4zdk965taBsr+s7AFlxE6G9h9tuc/XEA
 /UTxe80fwoqr4DbRexlFavUVrLXQxbDNQSQvrb8=
X-Google-Smtp-Source: APBJJlHt9g/0zHiIQ7EawznxPr4jr3lzdlomBkhSHHAR7y+yPdCnpodN86fqyBImKakABlNAu2U6m42PVnhYlUjDLwA=
X-Received: by 2002:aa7:da94:0:b0:521:d2ab:e4df with SMTP id
 q20-20020aa7da94000000b00521d2abe4dfmr1999253eds.19.1690458729176; Thu, 27
 Jul 2023 04:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230604061658.49004-1-faithilikerun@gmail.com>
 <96628b6b-a9e9-c817-7d2a-211bb47f5eb5@linux.ibm.com>
 <648eecec-3035-22a5-3040-cd9906534d29@linux.ibm.com>
In-Reply-To: <648eecec-3035-22a5-3040-cd9906534d29@linux.ibm.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Thu, 27 Jul 2023 19:51:40 +0800
Message-ID: <CAAAx-8L=H4wwUTMR6AEHFSK4K_L_sqBULm8CEPPK011Cm5hwEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/file-posix: fix g_file_get_contents return path
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, dlemoal@kernel.org,
 dmitry.fomichev@wdc.com, hare@suse.de, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x534.google.com
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

Matthew Rosato <mjrosato@linux.ibm.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 19:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/5/23 10:54 AM, Matthew Rosato wrote:
> > On 6/4/23 2:16 AM, Sam Li wrote:
> >> The g_file_get_contents() function returns a g_boolean. If it fails, t=
he
> >> returned value will be 0 instead of -1. Solve the issue by skipping
> >> assigning ret value.
> >>
> >> This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} back=
ed
> >> by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.
> >>
> >> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >
> > Polite ping on this patch -- this issue still exists in master as of to=
day and this patch resolves it for me.  Just want to make sure it gets into=
 8.1
> >
>
> Ping -- I can still reproduce this crash on -rc1.  Any chance this patch =
can get picked up for the 8.1 release?
>
> @Sam I see you sent a v2 of only patch #2 in this series ('block/file-pos=
ix: fix wps checking in raw_co_prw')..  I wonder if this one just got forgo=
tten since it wasn't sent as part of v2.  Maybe try a resend of this patch =
by itself (plus the review tags added)?

Ok, I will resend it as a separate patch.

>
> Thanks,
> Matt
>
> >
> >> ---
> >>  block/file-posix.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/block/file-posix.c b/block/file-posix.c
> >> index ac1ed54811..0d9d179a35 100644
> >> --- a/block/file-posix.c
> >> +++ b/block/file-posix.c
> >> @@ -1232,7 +1232,6 @@ static int hdev_get_max_hw_transfer(int fd, stru=
ct stat *st)
> >>  static int get_sysfs_str_val(struct stat *st, const char *attribute,
> >>                               char **val) {
> >>      g_autofree char *sysfspath =3D NULL;
> >> -    int ret;
> >>      size_t len;
> >>
> >>      if (!S_ISBLK(st->st_mode)) {
> >> @@ -1242,8 +1241,7 @@ static int get_sysfs_str_val(struct stat *st, co=
nst char *attribute,
> >>      sysfspath =3D g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
> >>                                  major(st->st_rdev), minor(st->st_rdev=
),
> >>                                  attribute);
> >> -    ret =3D g_file_get_contents(sysfspath, val, &len, NULL);
> >> -    if (ret =3D=3D -1) {
> >> +    if (!g_file_get_contents(sysfspath, val, &len, NULL)) {
> >>          return -ENOENT;
> >>      }
> >>
> >> @@ -1253,7 +1251,7 @@ static int get_sysfs_str_val(struct stat *st, co=
nst char *attribute,
> >>      if (*(p + len - 1) =3D=3D '\n') {
> >>          *(p + len - 1) =3D '\0';
> >>      }
> >> -    return ret;
> >> +    return 0;
> >>  }
> >>  #endif
> >>
> >
> >
>

