Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 265307B488D
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 18:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmyzJ-0000MT-P8; Sun, 01 Oct 2023 12:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qmyzH-0000M1-9w; Sun, 01 Oct 2023 12:08:07 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qmyzF-0002PN-JV; Sun, 01 Oct 2023 12:08:07 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41810cfc569so80461921cf.2; 
 Sun, 01 Oct 2023 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696176484; x=1696781284; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7Ecj5XabPXHng4L/Tp4VNESX6A3S7KZ6bYOX2Bo/SE=;
 b=bulJz6EiZQa4Jx3m1dw9Dp6O2xHQI2a5HXGu0L/8nQ5qHM00AlufkvjFF67ceCjrJ0
 8O6HctXwardj71yal6AEI0wYC0qo2htyuYxtn4IQ8juj7lmCzrXToammUlM3HLKuUnw/
 Xxf8VBNAWmWjTHph8jcIbHlronBvFImPwZu82PA6CZJAfK/10RfphKfQepfywj1XHYcX
 U0BdkoNE1OcRmh0+kVrP8HLgvu3ym0uFkZDQLnGoR0nr91CLJhgzrkzNyswMHE6bCZsf
 qIfOU8ZVs/Wb7oHw0GtPz5rpNofORCu8mCTwLsBZ2kOGm1NJ5jfIxGZrxa855dgwIcX/
 XcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696176484; x=1696781284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7Ecj5XabPXHng4L/Tp4VNESX6A3S7KZ6bYOX2Bo/SE=;
 b=GofH+PeRSRcZ8DuGAz9sqNoOTWSGj2qY1GbqeLwNXQ5oJ/KVAduOAk7FVsqPPD3XMF
 /169/0Qlnisa+BcOy1wrFBevCUOvBIZqvNF5NIUJfKKV8x3eOE56AphgEKCMNZzSzB16
 EYZgZyVgnSugjv1Tfw5UJDao+sCO0nHJZUjJl9SF6g1Iwmhqt2o9Ajy8fvqW13ddZXLe
 huBGKI447V3iB9EnWquRwLFdY0ntFVcDn8oKy3q4qFALue9VVRQ5RYleNAXc6B1PXH7b
 UBA4tRR1fos/IQT33u1tj+fO7aVRKQTJlLz730eBXKpbDak8Jb3P78vqKDDOggseDiTn
 TSYw==
X-Gm-Message-State: AOJu0YzTWv72vvn2kHjsj5cFB3195gzPslWc9DSAZ+8jUv8becWTHYpM
 VcBdHhsf+fNkRuUe/tM1JsBFS5Kv/Rk+zA25AWE=
X-Google-Smtp-Source: AGHT+IEm9fVfC0CohvSZj1A8z+X8a76Bb/z7VSEZjXkUWevRTdMkJhO4bJf+LSdOfjAH/qzvIE7ExfP978jFhuAIjzA=
X-Received: by 2002:ac8:5bc8:0:b0:401:e0b4:a93f with SMTP id
 b8-20020ac85bc8000000b00401e0b4a93fmr11691784qtb.41.1696176483922; Sun, 01
 Oct 2023 09:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230919131955.27223-1-lersek@redhat.com>
 <7ee37181-526e-2b6a-6b42-09340a9e70a9@redhat.com>
 <CAJ+F1CK0FaMfm-ZUz7KB0erFRLBWTa7yHMxhiX0+J0ZxNp34bw@mail.gmail.com>
 <4da39e48-c916-ed62-70ae-f0306845f01b@redhat.com>
 <d5358711-c6ad-2f4c-ad33-9227503f53b1@redhat.com>
In-Reply-To: <d5358711-c6ad-2f4c-ad33-9227503f53b1@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 1 Oct 2023 20:07:52 +0400
Message-ID: <CAJ+F1CLgHYbdu+KJzgbRZ7Ej1wkNAj9=hLd-zCpp+vACmDmEtA@mail.gmail.com>
Subject: Re: [PATCH] hw/display/ramfb: plug slight guest-triggerable leak on
 mode setting
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

Hi Laszlo

On Sun, Oct 1, 2023 at 4:20=E2=80=AFAM Laszlo Ersek <lersek@redhat.com> wro=
te:
>
> On 10/1/23 00:14, Laszlo Ersek wrote:
> > On 9/29/23 13:17, Marc-Andr=C3=A9 Lureau wrote:
[..]
> >> fwiw, my migration support patch is still unreviewed:
> >> https://patchew.org/QEMU/20230920082651.3349712-1-marcandre.lureau@red=
hat.com/
> >>
> >
> > I don't have a copy of that patch (not subscribed, sorry...), but how
> > simply you did it surprises me. I did expect to simulate an fw_cfg writ=
e
> > in post_load, but I thought we'd approach the device (for the sake of
> > including it in the migration stream) from the higher level device's
> > vmstate descriptors (dc->vmsd) that set up / depend on ramfb in the
> > first place. I didn't know that raw vmstate_register() was still accept=
ed.
> >
> > If it is, then, for that patch (with Gerd's comment addressed):
> >
> > Acked-by: Laszlo Ersek <lersek@redhat.com>
>
> I think I may have found one issue with that patch.
>
> The fields that we save into the migration stream are integer members of
> the RAMFBCfg structure that lives directly in the fw_cfg file. The ramfb
> device specifies those fields for the guest as big endian. This means
> that when ramfb_fw_cfg_write() runs, triggered by the guest, then on big
> endian hosts, be32_to_cpu() and be64_to_cpu() will be no-ops, as the
> integer representation inside the fw_cfg file will match the host CPU at
> once. And on little endian hosts, these functions will byte swap. In
> both cases, ramfb_create_display_surface() will have to be called with
> identical host-side integers. This means that *before* the be32_to_cpu()
> and be64_to_cpu() calls, the host side *values* read out from the fw_cfg
> file members *differ* between big endian and little endian hosts.
>
> And the problem is that we write precisely those values into the
> migration stream, via "vmstate_ramfb_cfg". The migration stream
> represents integers in big endian regardless of host endianness, but the
> question is the *values* that we encode in BE for the stream. And the
> values (from fw_cg) will differ between little endian and big endian host=
s.
>
> Thus, I think we should just use
>
>   VMSTATE_BUFFER(cfg, RAMFBState)
>
> in "vmstate_ramfb", and remove "vmstate_ramfb_cfg". For migration
> purposes, we should treat the fw_cfg file as an opaque blob.

I think I see your point. Using VMSTATE_BUFFER like that doesn't work
though. It's also more error-prone if fields are added in the struct,
imho.

However, we could simply have a post-load to convert the values to BE.
I wonder if new macros couldn't be introduced too.

> >
> > BTW: can you please assign
> > <https://bugzilla.redhat.com/show_bug.cgi?id=3D1859424> to yourself and
> > link your patch into it? The reason we ended up duplicating work here i=
s
> > that noone took RHBZ 1859424 before.

I thought I did that.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1859424#c17

> >
> > ... Well, the ticket is RHEL-7478 in JIRA now, in fact. :/

:/


--=20
Marc-Andr=C3=A9 Lureau

