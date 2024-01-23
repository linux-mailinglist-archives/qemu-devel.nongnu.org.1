Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34F4839282
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:20:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIZA-0007rH-Ly; Tue, 23 Jan 2024 10:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rSIZ3-0007lV-QN; Tue, 23 Jan 2024 10:19:50 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rSIZ2-0003yQ-8W; Tue, 23 Jan 2024 10:19:49 -0500
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7bed8fee278so162884939f.2; 
 Tue, 23 Jan 2024 07:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706023186; x=1706627986; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sw6EVIsFx+oAF6CbewijJKoaePtDE6G+Gtlr0nDnTt0=;
 b=hcKH3lHGTUXUKTU/3Gv3+bbcGj697edXTMDdDutvATg+cmGCmXKZGq5Zfa02/jUSGg
 9WSEnamuBJqyLFNjdYvFVLI36lyJGY0fR/8Fyx5BaRmWF7aSCc6Rhq3UXSYw1nmteCbb
 w+TazjIdgSgwpujuQXJwRYV7QgJQj56+sRS9NzsIUbvOTx0eN/OMsR5W6KYHNt775OFy
 LvuYHD+izxpNpAHNg5x6tMX73Ngsc7IwpPBVTYJdi63xXTc2BJTXNY0yo1LoMyotRwvu
 hUCG2nVrBtMvKfuv0JR4tJQ/ww5uGJZd8z2wTjCNdAW6GEFObhL9dMmSp74uJbT1v2IV
 jI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706023186; x=1706627986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sw6EVIsFx+oAF6CbewijJKoaePtDE6G+Gtlr0nDnTt0=;
 b=tiNwZoCyv8mwDPdrjq6yZ0fx/5cmIg35K0t2lFJVOMOnqXgZzSWfKcSZ3aos+WjMmF
 TU++Tvbszd1AQSUfPuuQo9fSjid0cfOL+6hBB4nceihDQpxn+07z3t7RkNP11QvU5Seq
 0p+4p4Lni8onvpsoEbqJwIs7zwnGOreeokpa2D93NLy+4G6Hr2BLk/YcHh4xeiUTgXT0
 be+l6Sh+rT3a95dkUU6fSThsYqmKR0tlLxolD3G0Y0/ouMHypUmk/A0s9tCeD2iQUzy9
 3CHpCdGGijblwK+m8qzzok2YAeEW55AJtXmkIbFwAGnERBMdeA7LaSqwbP7jDbZ8XEd0
 iZoA==
X-Gm-Message-State: AOJu0Yzn98ViDKsud7f4HaUHt3ACUyhuCvl8mgVqRKHKiouDerQ3o7yL
 /K4r7MApaFwLLiGhwyU4p/FDPgaZIFbM8c4UHvEUGXmL0sWkgm1KGz2qrMroIk5LepvBgyJoM4S
 xOSJAOqDx1L03n7OnHVuA3WthfyZFw6vN
X-Google-Smtp-Source: AGHT+IHXlsrqo9+yUOGXJeaBxknSWA7C586sBSckqphfhcr3FZUvkIYn7Z4bkaqleGciWxQVfcVg7/IlME+AzPfXna4=
X-Received: by 2002:a92:d24d:0:b0:360:8bfd:78f1 with SMTP id
 v13-20020a92d24d000000b003608bfd78f1mr5937434ilg.47.1706023186511; Tue, 23
 Jan 2024 07:19:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mnyxgmwY39jKMHsZCrCXdozNwFO+RDTYMPUhfkGu_pfFQ@mail.gmail.com>
 <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
In-Reply-To: <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Tue, 23 Jan 2024 16:19:39 +0100
Message-ID: <CAHP40mnvG=5LtxUr7bpOUFs+1PQSK+bZ+fy0414p0D6u5qGkjw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Avoid conflicting types for 'copy_file_range'
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org, 
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=manolodemedici@gmail.com; helo=mail-io1-xd2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jan 22, 2024 at 6:04=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> (Cc'ing the block folks)
>
> On Thu, 18 Jan 2024 at 16:03, Manolo de Medici <manolodemedici@gmail.com>=
 wrote:
> >
> > Compilation fails on systems where copy_file_range is already defined a=
s a
> > stub.
>
> What do you mean by "stub" here ? If the system headers define
> a prototype for the function, I would have expected the
> meson check to set HAVE_COPY_FILE_RANGE, and then this
> function doesn't get defined at all. That is, the prototype
> mismatch shouldn't matter because if the prototype exists we
> use the libc function, and if it doesn't then we use our version.
>
> > The prototype of copy_file_range in glibc returns an ssize_t, not an of=
f_t.
> >
> > The function currently only exists on linux and freebsd, and in both ca=
ses
> > the return type is ssize_t
> >
> > Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> > ---
> >  block/file-posix.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 35684f7e21..f744b35642 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2000,12 +2000,13 @@ static int handle_aiocb_write_zeroes_unmap(void=
 *opaque)
> >  }
> >
> >  #ifndef HAVE_COPY_FILE_RANGE
> > -static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> > -                             off_t *out_off, size_t len, unsigned int =
flags)
> > +ssize_t copy_file_range (int infd, off_t *pinoff,
> > +                         int outfd, off_t *poutoff,
> > +                         size_t length, unsigned int flags)
>
> No space after "copy_file_range". No need to rename all the
> arguments either.

Ok

>
> >  {
> >  #ifdef __NR_copy_file_range
> > -    return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
> > -                   out_off, len, flags);
> > +    return (ssize_t)syscall(__NR_copy_file_range, infd, pinoff, outfd,
> > +                            poutoff, length, flags);
>
> Don't need a cast here, because returning the value will
> automatically cast it to the right thing.
>

Ok

> >  #else
> >      errno =3D ENOSYS;
> >      return -1;
>
> These changes aren't wrong, but as noted above I'm surprised that
> the Hurd gets into this code at all.
>

I think Sergey explained very well why the Hurd its this piece of code

> Note for Kevin: shouldn't this direct use of syscall() have
> some sort of OS-specific guard on it? There's nothing that
> says that a non-Linux host OS has to have the same set of
> arguments to an __NR_copy_file_range syscall. If this
> fallback is a Linux-ism we should guard it appropriately.
>
> For that matter, at what point can we just remove the fallback
> entirely? copy_file_range() went into Linux in 4.5, apparently,
> which is now nearly 8 years old. Maybe all our supported
> hosts now have a new enough kernel and we can drop this
> somewhat ugly syscall() wrapper...

I'd love to remove the syscall wrapper if you give me the ok to do it

Thanks

