Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD88307A1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:10:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6c1-0000CU-3y; Wed, 17 Jan 2024 09:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ6bz-0000BV-69
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:09:47 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ6bx-00022U-HS
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:09:46 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-361930931f0so3484665ab.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500584; x=1706105384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZw+E34l50Zzx83Iiy5EvcvnteBxbtNcsjQSAXYlZjs=;
 b=VmG8WpXFBTKS28mvcjLhnWhcerRYMos8OVRU9PfumDf4W2J2TNtsi+CSBN8guLF1I4
 7EJhlyNonj7G1DsxfugVXONjAbhI0MKgBW+8srAmzV/ROeq4Fsc2qTJymW506p4HaElW
 mTZuOMmIdtUpJyT/5Jw0WOALRHe05opyA0zNI40YEnhWoE/Ay8CXDItQtQy6fyuQ9m9b
 XXTHC/79QDmZpiade8/Zaz29hYPTi1fIAYfdmRlFi+SreKsU2Sc0tEdVRtKvdCpG+kWh
 J0IjtYIVxkqKdvi8Ws9MLRUKybzxA7y78q3w6WX7E5tZrN1qv/Vn32fyCkbsPhBYpjNW
 D0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500584; x=1706105384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZw+E34l50Zzx83Iiy5EvcvnteBxbtNcsjQSAXYlZjs=;
 b=n6Ckzb0Rlx+9xuodSAADJiVk+yBieXSA73pTUdlatr6G4hM+12OmMJACLGLzdXZPNk
 ewU+VXoatmAbZHdLLjwSLfu1zanx+80v3ROzJZLP9d0pFOE5ftr2R7QtYUIWUHJ33dC+
 jyT0v06c2wDPiQYhb8zAHEryEn4iWd0W6BNeTSay85xPztbpRg9XZ79HxBup6fM3Zjk9
 lyMhXZ0pffCFWaxe/X/TUKsfb5IA27fqFmiVtTlZIG4ISh+9qGU4y5+Ddp2Zx7Wqsiwd
 pipkE6cFQKYKTFPndoo1SUqARO3dHN33JGEmPuG0ovTXP5WFuijbNP4gGEzATIDi0NrI
 9NqA==
X-Gm-Message-State: AOJu0YzE7P6DaOtbyQC46cegiz9ypfZ9/8/2KQ87tzuSQZJndI75cqFa
 gdzTDhEtxHL2mlnaWudAEAxWu9lFKpzyBq0BjOE=
X-Google-Smtp-Source: AGHT+IGt89IiBzs3CVyKRjtKVqXOXPIDIOVpe57Vdk9fncUZOG2Kle22R1khUG6OV14odrV77OHqpHxmqqKu4HYCX8A=
X-Received: by 2002:a92:d943:0:b0:360:60e1:f94c with SMTP id
 l3-20020a92d943000000b0036060e1f94cmr8881364ilq.33.1705500584158; Wed, 17 Jan
 2024 06:09:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
 <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
In-Reply-To: <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 15:09:39 +0100
Message-ID: <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x130.google.com
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

Hello Philippe,
thank you for the feedback, I've checked that. The problem is that the
Hurd fails that test due to the following:

        #if defined __stub_copy_file_range || defined __stub___copy_file_ra=
nge
        fail fail fail this function is not going to work
        #endifefines the stub __copy_file_ran

rightfully so I'd say, because copy_file_range is just a stub on the Hurd.

As such, we really need to exclude the code that defines the stub in
qemu on the Hurd.

On Wed, Jan 17, 2024 at 2:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Manolo,
>
> On 17/1/24 13:31, Manolo de Medici wrote:
> > It's already defined as a stub on the GNU Hurd.
>
> Meson checks for this function and defines
> HAVE_COPY_FILE_RANGE if available, see in meson.build:
>
>    config_host_data.set('HAVE_COPY_FILE_RANGE',
>                         cc.has_function('copy_file_range'))
>
> Maybe some header is missing in "osdep.h" for GNU Hurd?
>
> > Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 35684f7e21..05426abb7d 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *=
opaque)
> >       return handle_aiocb_write_zeroes(aiocb);
> >   }
> >
> > -#ifndef HAVE_COPY_FILE_RANGE
> > +#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
> >   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> >                                off_t *out_off, size_t len, unsigned int=
 flags)
> >   {
> > ---
> >   block/file-posix.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 35684f7e21..05426abb7d 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *=
opaque)
> >       return handle_aiocb_write_zeroes(aiocb);
> >   }
> >
> > -#ifndef HAVE_COPY_FILE_RANGE
> > +#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
> >   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> >                                off_t *out_off, size_t len, unsigned int=
 flags)
> >   {
> > --
> > 2.43.0
> >
>

