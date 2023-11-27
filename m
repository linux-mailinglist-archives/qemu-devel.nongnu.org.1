Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 622367F9C76
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:16:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7XiM-00035f-RR; Mon, 27 Nov 2023 04:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r7Xi8-000355-5a; Mon, 27 Nov 2023 04:15:25 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r7Xi0-0003Uy-Bm; Mon, 27 Nov 2023 04:15:22 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-58d9a4e9464so84836eaf.0; 
 Mon, 27 Nov 2023 01:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701076514; x=1701681314; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RpdMrsijJz89Lg6Oyx/ul1nUSltpdo7WKt8WKKD8Ts=;
 b=C+++tFC8pVme1iWYeDJFuUDrJYZvxZS5bN3ssqcZ3IH6hw0mPAnoGOgq2pwC0cJT5s
 /Ta2QCi6Fxwwi3GOE4a3j1psHL2bCvTeRt+Mv/BEf8tmN0Qmt2H1+6FC/ap7K5domkVU
 9LvKCC5kTRolUCH9qvwwFy55J9z1aDYv9vztOIR+XBOnmFKwJ79p6kUHCyT5EITmaiEx
 VaqPJEbi9KbvaJLQu0a5a8Uzd+r9euytNybNpEC6p+Pf4HP5h+/le8+SzyRIubuLRbHx
 ThvcdRKvhUPW6Ex7zo60BiMaOXM8ICMQ9ToERULExV+woycWpI/seUX7TKG5TSdnMVjI
 +llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701076514; x=1701681314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RpdMrsijJz89Lg6Oyx/ul1nUSltpdo7WKt8WKKD8Ts=;
 b=L6yrLDOkgvcZLXVNgaQDMpFJvtTyIFZYyLyjw6GuuPsCEZlMjlx8QhSK3Qt9FLrfEZ
 EWDqtrxWhb7BZe+2pjVKqGm764a2hG7/WizdtJHY+kw5ixxLJKGbe0qblOTgaGojqfXR
 uAMDvLPAJt8Dzy08kM90QNXbrzJyVVM/d18E14kIhhlx5wX9phv6AW2sO9yqjZEWHtvf
 U55r19DDBYBoq7W5GWna2G/r27b216OeF4xdoa95TB8JfrNjmEDPCujfyjsvfSaMcL6/
 /FVpsEidFuGbRlDeh2pwBgEVuMkkxBJjKdtLqAx3LHnkjpG7mo8i83GlYn1Rg6VHKWq7
 hkbg==
X-Gm-Message-State: AOJu0YxR4PYQoMZUGPwHtQYKSB676QcwvUDIYSx+E7NDfbpfjhYjGSVW
 vR2eWxSf6h7vc2tBZnePqyu0UZHfah64efadSrg=
X-Google-Smtp-Source: AGHT+IHgKWaFORdj5BRU0D5mJQ3ECaC0kCxvumUGQa1H6j+xhxCejrm/xo34XpK513hxyuBwZFKcOSFnbwJlNoO5oNo=
X-Received: by 2002:a05:6358:998a:b0:168:e707:2e56 with SMTP id
 j10-20020a056358998a00b00168e7072e56mr6018576rwb.16.1701076514389; Mon, 27
 Nov 2023 01:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20231122125826.228189-1-f.ebner@proxmox.com>
 <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
 <b5419999-625f-45a3-9a61-b6cb8356cdbe@proxmox.com>
 <CAJ+F1C+CV-PbMAhw9V+OzDHnFiSyFW8+kFBZZ-n_7usoNP_S5w@mail.gmail.com>
 <1bf79e54-d4de-4ac4-b75d-c79bd52c3eb0@proxmox.com>
In-Reply-To: <1bf79e54-d4de-4ac4-b75d-c79bd52c3eb0@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Nov 2023 13:15:01 +0400
Message-ID: <CAJ+F1CK2KqnN2ZpZAz=kD7Pwn0SbZkmi_jMPxi4ePwPAubDmkg@mail.gmail.com>
Subject: Re: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com, 
 mcascell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oo1-xc35.google.com
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

Hi

On Thu, Nov 23, 2023 at 12:46=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> =
wrote:
>
> Am 23.11.23 um 07:52 schrieb Marc-Andr=C3=A9 Lureau:
> > Hi
> >
> > On Wed, Nov 22, 2023 at 5:25=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> >>
> >> Am 22.11.23 um 14:06 schrieb Marc-Andr=C3=A9 Lureau:
> >>> Hi
> >>>
> >>> On Wed, Nov 22, 2023 at 5:00=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.=
com> wrote:
> >>>>
> >>>> Commit d921fea338 ("ui/vnc-clipboard: fix infinite loop in
> >>>> inflate_buffer (CVE-2023-3255)") removed this hunk, but it is still
> >>>> required, because it can happen that stream.avail_in becomes zero
> >>>> before coming across a return value of Z_STREAM_END in the loop.
> >>>
> >>> Isn't this an error from the client side then?
> >>>
> >>
> >> In my test just now I get Z_BUF_ERROR twice and after the second one,
> >> stream.avail_in is zero. Maybe if you'd call inflate() again, you'd ge=
t
> >> Z_STREAM_END, but no such call is made, because we exit the loop.
> >
> > It should exit the loop after calling inflate() again though.
> >
> > Or do you mean that it goes to Z_BUF_ERROR a second time with
> > stream.avail_in =3D=3D 0, thus exit the loop quickly after ?
>
> Yes, sorry if I wasn't clear. After the second inflate() call,
> stream.avail_in =3D=3D 0. See below.
>
> >
> > That could mean that the input buffer is not complete.
> >
> > "Note that Z_BUF_ERROR is not fatal, and inflate() can be called again
> > with more input..."
> >
> > Something is fishy.. Is it easy to reproduce?
> >
>
> Yes, always. For example when entering "foobar" in the clipboard on the
> host side:
>
> > Thread 1 "qemu-system-x86" hit Breakpoint 2, inflate_buffer (in=3D0x555=
557a2980c "x^b```O\313\317OJ,b", in_len=3D19, size=3D0x7fffffffd058) at ../=
ui/vnc-clipboard.c:44
> > 44        ret =3D inflateInit(&stream);
> > (gdb) n
> > [Thread 0x7ffec7c166c0 (LWP 20918) exited]
> > 45        if (ret !=3D Z_OK) {
> > (gdb) p stream
> > $18 =3D {next_in =3D 0x555557a2980c "x^b```O\313\317OJ,b", avail_in =3D=
 19, total_in =3D 0, next_out =3D 0x555557173d20 "\303\337:\002PU", avail_o=
ut =3D 8, total_out =3D 0, msg =3D 0x0, state =3D 0x555557654200,
> >   zalloc =3D 0x7ffff7bc1560, zfree =3D 0x7ffff7bc1570, opaque =3D 0x0, =
data_type =3D 0, adler =3D 1, reserved =3D 0}
> > (gdb) c
> > Continuing.
> > [New Thread 0x7ffec7c166c0 (LWP 21011)]
> >
> > Thread 1 "qemu-system-x86" hit Breakpoint 3, inflate_buffer (in=3D0x555=
557a2980c "x^b```O\313\317OJ,b", in_len=3D19, size=3D0x7fffffffd058) at ../=
ui/vnc-clipboard.c:50
> > 50            ret =3D inflate(&stream, Z_FINISH);
> > (gdb) n
> > [Thread 0x7ffec7c166c0 (LWP 21011) exited]
> > 51            switch (ret) {
> > (gdb) p ret
> > $19 =3D -5
> > (gdb) p stream
> > $20 =3D {next_in =3D 0x555557a29818 "b", avail_in =3D 7, total_in =3D 1=
2, next_out =3D 0x555557173d28 "", avail_out =3D 0, total_out =3D 8, msg =
=3D 0x0, state =3D 0x555557654200, zalloc =3D 0x7ffff7bc1560, zfree =3D 0x7=
ffff7bc1570,
> >   opaque =3D 0x0, data_type =3D 5, adler =3D 72352174, reserved =3D 0}
> > (gdb) c
> > Continuing.
> > [New Thread 0x7ffec7c166c0 (LWP 21131)]
> >
> > Thread 1 "qemu-system-x86" hit Breakpoint 3, inflate_buffer (in=3D0x555=
557a2980c "x^b```O\313\317OJ,b", in_len=3D19, size=3D0x7fffffffd058) at ../=
ui/vnc-clipboard.c:50
> > 50            ret =3D inflate(&stream, Z_FINISH);
> > (gdb) n
> > [Thread 0x7ffec7c166c0 (LWP 21131) exited]
> > 51            switch (ret) {
> > (gdb) p ret
> > $21 =3D -5
> > (gdb) p stream
> > $22 =3D {next_in =3D 0x555557a2981f "", avail_in =3D 0, total_in =3D 19=
, next_out =3D 0x555557173d2b "", avail_out =3D 5, total_out =3D 11, msg =
=3D 0x0, state =3D 0x555557654200, zalloc =3D 0x7ffff7bc1560, zfree =3D 0x7=
ffff7bc1570,
> >   opaque =3D 0x0, data_type =3D 128, adler =3D 190907009, reserved =3D =
0}
> > (gdb) p out + 4
> > $23 =3D (uint8_t *) 0x555557173d24 "foobar"
> > (gdb) p *size
> > $24 =3D 0
>
> Now we exit the loop and without the hunk this patch re-adds, we don't
> update *size and don't return 'out'.
>

It seems like a bug in tigervnc then. For some reason, the compressed
data doesn't trigger Z_STREAM_END on the decompression side. Have you
investigated or reported an issue to them?

thanks

--=20
Marc-Andr=C3=A9 Lureau

