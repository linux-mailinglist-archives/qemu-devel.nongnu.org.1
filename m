Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF17FB8A8
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:54:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7viI-0005Ow-KO; Tue, 28 Nov 2023 05:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r7viG-0005OA-4p; Tue, 28 Nov 2023 05:53:08 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r7viE-0007It-Bf; Tue, 28 Nov 2023 05:53:07 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7c461a8cb0dso1171361241.0; 
 Tue, 28 Nov 2023 02:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701168784; x=1701773584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HkOF4tHy827yNuv4IkL/EuN+FpuPqik8P0UBrUXv0w=;
 b=i3bl4wqJgdpvUpIKpcHrHOowf6RfmSktD5ULy1H8/9wOdjiPmXtGou9Gd+LDNMKhQd
 7ipb2j34UOX3x2jrISSPE1+YuVq10YD3CUIBLSVUW/tnwH7fYIH+ZwEnpcCqB/wIF344
 e2b2Uym2eFnNnHVb/Sz5OyUTnK4Q8qvV5v3xX7zoQ9SX+LIThePUgv45i9Xwr74YwdKP
 6MM/vdxgn44a65zIS0OFTowF/pGqLtDLedZ46fUL/vN+Ukb7FtH9uiGdxxbUFoSG7L2y
 1L//iziMuuKjAyVDRITx//tzD6mpa1BiK5wDPwb/hNCcwDutUUIhguN6Xfemniw9eZI7
 +qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701168784; x=1701773584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HkOF4tHy827yNuv4IkL/EuN+FpuPqik8P0UBrUXv0w=;
 b=ntVv3rn5F1SDkf7OmchVgFVw8AbhwuKtDA3ftCPpS61eScd7HcUIgdoq0QzcwUKaoP
 7qExg523sq2fUeH4JOAuvFtZEoju4CJ1xpVDyDR1+2P8VQVUlkCl9jQGDl+fvVgG18vi
 ty4zHujAlOmWKb4MyblawU5qRbitgQZlfARnb1p/z0fI4Q5I+V3ggRczfzvUDykI6St6
 YxKuXfHTS6/OnAqvGXkiRLYhu04ogAyhAIJIYJCWiy4M+w5TSazETD1QMQDNdN0U+DjF
 wvFYnQ4fedVnzI7wS+uxKLLIEtL2/zCOvFhLfbJdTQun1JsKfhHDy/Gl9EorD6FQAm1Q
 Qd0w==
X-Gm-Message-State: AOJu0YwFkUKQKU7Az69Mt7cmANiikbF/9+YALHPkwASOZ159R8qqUhWO
 +wtpJyU7LPDL5PRmPw3/9LC7mjuK2ZC+CWbNWbk=
X-Google-Smtp-Source: AGHT+IGeqqLwcvHRd3KEyo3yiSYvP0voKxiERDZIcoXhW8fqfhCjIyAWUMOiMg+nHreR/qFfrJjqSmn37QR9zp/uAqI=
X-Received: by 2002:a05:6122:9a1:b0:4ac:bf09:4c1 with SMTP id
 g33-20020a05612209a100b004acbf0904c1mr11087405vkd.10.1701168784439; Tue, 28
 Nov 2023 02:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231122125826.228189-1-f.ebner@proxmox.com>
 <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
 <b5419999-625f-45a3-9a61-b6cb8356cdbe@proxmox.com>
 <CAJ+F1C+CV-PbMAhw9V+OzDHnFiSyFW8+kFBZZ-n_7usoNP_S5w@mail.gmail.com>
 <1bf79e54-d4de-4ac4-b75d-c79bd52c3eb0@proxmox.com>
 <CAJ+F1CK2KqnN2ZpZAz=kD7Pwn0SbZkmi_jMPxi4ePwPAubDmkg@mail.gmail.com>
 <b5e09800-1d75-4108-8222-72360b8144bf@proxmox.com>
In-Reply-To: <b5e09800-1d75-4108-8222-72360b8144bf@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Nov 2023 14:52:52 +0400
Message-ID: <CAJ+F1CJk4=7DL0NhC9fOG_QnykVOB_yv89PKr3KpeS5LmuuK3w@mail.gmail.com>
Subject: Re: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com, 
 mcascell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x92e.google.com
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

On Mon, Nov 27, 2023 at 2:52=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 27.11.23 um 10:15 schrieb Marc-Andr=C3=A9 Lureau:
> >
> > It seems like a bug in tigervnc then. For some reason, the compressed
> > data doesn't trigger Z_STREAM_END on the decompression side. Have you
> > investigated or reported an issue to them?
> >
>
> This was with noVNC. A colleague tested with TigerVNC. I haven't stepped
> through with GDB there, but it might be similar. No, I haven't
> reported/investigated for the VNC clients yet. Unfortunately, I've got
> my hands full with other things at the moment, so it will be a while
> until I can do that.
>
> Even if it's a bug in the clients, this was working before d921fea338
> ("ui/vnc-clipboard: fix infinite loop in inflate_buffer
> (CVE-2023-3255)") so I still feel like it might be worth handling in QEMU=
.
>
> But is it really a client error? What I don't understand is why the
> return value of inflate() is Z_BUF_ERROR even though all the input was
> handled.
>
> From https://www.zlib.net/manual.html
>
> "inflate() returns [...] Z_BUF_ERROR if no progress was possible or if
> there was not enough room in the output buffer when Z_FINISH is used."

At the end of the input stream, subsequent calls could not make
progress. We never reached Z_STREAM_END

It seems to me the callers do not flush the streams with Z_FINISH
(https://github.com/TigerVNC/tigervnc/blob/master/common/rdr/ZlibOutStream.=
cxx),
and this is what marks the end of a zlib stream ultimately...

>
> > 51            ret =3D inflate(&stream, Z_FINISH);
> > (gdb) p stream
> > $23 =3D {next_in =3D 0x555557652708 "", avail_in =3D 5, total_in =3D 12=
, next_out =3D 0x555557627378 "", avail_out =3D 8, total_out =3D 8, msg =3D=
 0x0, state =3D 0x5555578df5c0, zalloc =3D 0x7ffff7bc1560, zfree =3D 0x7fff=
f7bc1570,
> >   opaque =3D 0x0, data_type =3D 5, adler =3D 71434672, reserved =3D 0}
> > (gdb) n
> > 52            switch (ret) {
> > (gdb) p stream
> > $24 =3D {next_in =3D 0x55555765270d "", avail_in =3D 0, total_in =3D 17=
, next_out =3D 0x555557627379 "", avail_out =3D 7, total_out =3D 9, msg =3D=
 0x0, state =3D 0x5555578df5c0, zalloc =3D 0x7ffff7bc1560, zfree =3D 0x7fff=
f7bc1570,
> >   opaque =3D 0x0, data_type =3D 128, adler =3D 99746224, reserved =3D 0=
}
> > (gdb) p ret
> > $25 =3D -5
> > (gdb) p out + 4
> > $26 =3D (uint8_t *) 0x555557627374 "fish"
>
> Progress was made and there was enough space for the output (avail_out =
=3D
> 7 after the call), so it really shouldn't return Z_BUF_ERROR, right?
>
> zlib version is 1:1.2.13.dfsg-1 (Debian 12 Bookworm)


It's hard to make the best decision.

We could return the uncompressed data so far, that would fix the
regression. But potentially, we have incomplete data returned. Clients
should be fixed to include Z_STREAM_END marker (using Z_FINISH).


--=20
Marc-Andr=C3=A9 Lureau

