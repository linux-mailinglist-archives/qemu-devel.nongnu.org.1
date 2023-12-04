Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E5802C11
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 08:31:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3Q7-00064U-2C; Mon, 04 Dec 2023 02:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3Pr-0005zm-8b; Mon, 04 Dec 2023 02:31:02 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3Po-0006S0-SI; Mon, 04 Dec 2023 02:30:54 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4239f5c1ec2so34474281cf.0; 
 Sun, 03 Dec 2023 23:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701675050; x=1702279850; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRUwvc8Hr8HPtvWpfWqakoh6AQwPkqmHS+nYkotsOpY=;
 b=bSE/eS3XA/dR8FUUmnDZO+Unhu8I+coq84p4Wo8e+p1PYmyNSuW8NAk20xfVJzrnN6
 a/gu9kmLDDN6k+UBltUOkkq5cY8J4IN8wiRU5m3kBd+jH7cb4GnezngCN2l6/kJ185jt
 MsWf5kSJz7HbRrW98mdFEwFQgwAWLjxfOn/07Wp71DIWTGDeZtG6q1QWDuOMvWP+FmGX
 1SbFzqoKtyMCY5yKAmfvdhCwog4P1OCEujqoSklM8ZWcW5w2s/qmaxh1ODWJuMbvnww2
 WTR0AqvVbZW2FvkDSEc45iWmwyXJgyzurF2tJzMHo2UKSqp8VT/5s2+BoI3m7GxPGwbl
 dgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701675050; x=1702279850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRUwvc8Hr8HPtvWpfWqakoh6AQwPkqmHS+nYkotsOpY=;
 b=RHEgRogURyrkhyE40uqLowfFCEt3bSCslb1/5bNMj3rzsWELq9YUJVe/EK6YVZdmiN
 ZbGlhjMfWi8rJclbQEAdvuPjLtYyYSOUAzBgR6eSZSyxmUwctPFQIlAijzt0M/OBhMz7
 PJPKqqjEtiKzORwcDKJwCIzF3lY5ScesyQhRPhaOYftpGGhYJMIghGGGA4kZA/IoH5/p
 siQLQbhEGf3sCmW4t1swcqgIL1fPRQTpsHeJ9PtBiF6PgUe2GcVlqYfnw18FhGIQR7j5
 V9r8z5TejySWmJjbhJ/W+0Lt6tYw78gjrMEv3B5MUj4i/QoGaFWV6JuqiVB82Iwem1Wt
 +1+Q==
X-Gm-Message-State: AOJu0YwOJdxizv8uswcbR4iLGw5eHFn5Slj/v7t1d1DuK1zgl3/sqhMe
 pRn5MN+fBKa+ZNer5/npENflpB+VKQat8S+maPE=
X-Google-Smtp-Source: AGHT+IG7YUVc1vzUGY9rr/ujweTSEzyIJ7gNvLTs2hdnAurGXzXSwyJ4RMol8MT0cgjvLQr1U4VCiZmfs8jEl51Hpgc=
X-Received: by 2002:a05:622a:6995:b0:423:a00c:2146 with SMTP id
 ie21-20020a05622a699500b00423a00c2146mr22500488qtb.19.1701675050031; Sun, 03
 Dec 2023 23:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20231122125826.228189-1-f.ebner@proxmox.com>
 <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
 <b5419999-625f-45a3-9a61-b6cb8356cdbe@proxmox.com>
 <CAJ+F1C+CV-PbMAhw9V+OzDHnFiSyFW8+kFBZZ-n_7usoNP_S5w@mail.gmail.com>
 <1bf79e54-d4de-4ac4-b75d-c79bd52c3eb0@proxmox.com>
 <CAJ+F1CK2KqnN2ZpZAz=kD7Pwn0SbZkmi_jMPxi4ePwPAubDmkg@mail.gmail.com>
 <b5e09800-1d75-4108-8222-72360b8144bf@proxmox.com>
 <CAJ+F1CJk4=7DL0NhC9fOG_QnykVOB_yv89PKr3KpeS5LmuuK3w@mail.gmail.com>
In-Reply-To: <CAJ+F1CJk4=7DL0NhC9fOG_QnykVOB_yv89PKr3KpeS5LmuuK3w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Dec 2023 11:30:38 +0400
Message-ID: <CAJ+F1CKPQ_6p8Lc3iBP-FM=ke1VS4bjL=JzHm+H-uiNR=x_R+A@mail.gmail.com>
Subject: Re: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com, 
 mcascell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Tue, Nov 28, 2023 at 2:52=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Nov 27, 2023 at 2:52=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com>=
 wrote:
> >
> > Am 27.11.23 um 10:15 schrieb Marc-Andr=C3=A9 Lureau:
> > >
> > > It seems like a bug in tigervnc then. For some reason, the compressed
> > > data doesn't trigger Z_STREAM_END on the decompression side. Have you
> > > investigated or reported an issue to them?
> > >
> >
> > This was with noVNC. A colleague tested with TigerVNC. I haven't steppe=
d
> > through with GDB there, but it might be similar. No, I haven't
> > reported/investigated for the VNC clients yet. Unfortunately, I've got
> > my hands full with other things at the moment, so it will be a while
> > until I can do that.
> >
> > Even if it's a bug in the clients, this was working before d921fea338
> > ("ui/vnc-clipboard: fix infinite loop in inflate_buffer
> > (CVE-2023-3255)") so I still feel like it might be worth handling in QE=
MU.
> >
> > But is it really a client error? What I don't understand is why the
> > return value of inflate() is Z_BUF_ERROR even though all the input was
> > handled.
> >
> > From https://www.zlib.net/manual.html
> >
> > "inflate() returns [...] Z_BUF_ERROR if no progress was possible or if
> > there was not enough room in the output buffer when Z_FINISH is used."
>
> At the end of the input stream, subsequent calls could not make
> progress. We never reached Z_STREAM_END
>
> It seems to me the callers do not flush the streams with Z_FINISH
> (https://github.com/TigerVNC/tigervnc/blob/master/common/rdr/ZlibOutStrea=
m.cxx),
> and this is what marks the end of a zlib stream ultimately...
>
> >
> > > 51            ret =3D inflate(&stream, Z_FINISH);
> > > (gdb) p stream
> > > $23 =3D {next_in =3D 0x555557652708 "", avail_in =3D 5, total_in =3D =
12, next_out =3D 0x555557627378 "", avail_out =3D 8, total_out =3D 8, msg =
=3D 0x0, state =3D 0x5555578df5c0, zalloc =3D 0x7ffff7bc1560, zfree =3D 0x7=
ffff7bc1570,
> > >   opaque =3D 0x0, data_type =3D 5, adler =3D 71434672, reserved =3D 0=
}
> > > (gdb) n
> > > 52            switch (ret) {
> > > (gdb) p stream
> > > $24 =3D {next_in =3D 0x55555765270d "", avail_in =3D 0, total_in =3D =
17, next_out =3D 0x555557627379 "", avail_out =3D 7, total_out =3D 9, msg =
=3D 0x0, state =3D 0x5555578df5c0, zalloc =3D 0x7ffff7bc1560, zfree =3D 0x7=
ffff7bc1570,
> > >   opaque =3D 0x0, data_type =3D 128, adler =3D 99746224, reserved =3D=
 0}
> > > (gdb) p ret
> > > $25 =3D -5
> > > (gdb) p out + 4
> > > $26 =3D (uint8_t *) 0x555557627374 "fish"
> >
> > Progress was made and there was enough space for the output (avail_out =
=3D
> > 7 after the call), so it really shouldn't return Z_BUF_ERROR, right?
> >
> > zlib version is 1:1.2.13.dfsg-1 (Debian 12 Bookworm)
>
>
> It's hard to make the best decision.
>
> We could return the uncompressed data so far, that would fix the
> regression. But potentially, we have incomplete data returned. Clients
> should be fixed to include Z_STREAM_END marker (using Z_FINISH).
>

I'll queue your patch for 8.2. thanks



--=20
Marc-Andr=C3=A9 Lureau

