Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F362279CF85
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1HA-0000nE-S7; Tue, 12 Sep 2023 07:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qg1H7-0000lu-Gc
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:09:46 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qg1H4-0006Dj-KK
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:09:44 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41512e0b773so20769841cf.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 04:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694516981; x=1695121781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8o0htE7esBXaoLlqly7lgDnjjBLRfm98uZFPC0LG+Zk=;
 b=fe7jsvejunb73EghXemRn7XvndtfNIplkwxYhtU8ZUOLeYhraT0UJEc47z65X4B1Lz
 xbjJSQ5on0u3qblhwBGLOKFjyMZFD7LdYXSSPKoJsHpV+E3tlwVQjjnhlPsWlIuH4yDu
 4k2tsaWQTjM5We35Fcpv+yZD3YU+uGVg5/hlbJWl1JaIMeUGtmuW9XznNRqb3Dnlj4wH
 7cykOeVKHMzw5iiKXxBle2xMG8VCZDwbMBjALVsbwhW23aHVrsQ+B2bzXxpmHmgbbxZf
 RWrrmt242UGYB0OhaY4to0514R733halv4EpOkXyFDf7Vil+FUEC+krnPoei5RQ1kkyL
 /czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694516981; x=1695121781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8o0htE7esBXaoLlqly7lgDnjjBLRfm98uZFPC0LG+Zk=;
 b=rr4zvkyFMkop8doGb+7hGz9yRsAoaWbwD7ZOVVEndL7WXi4Lzat8m8PYQd0m8Al/35
 NV/cpdNsER7xag2UWCAwPZVUktJW8pKo0xxXKvyZTW+mP2BPP1J7vf50U7HpaX0g04mT
 cRNpXxMDY4/9QeHuQhgbhIaukub/DXk4woWTCX+QjjepTd398mI2PfqZbgpS5+yeJWWL
 Uxchao9s81Ut/noCyanwv/sJii7sIqd4o0N9Jd2CFDO3cWiymBnfTmOAaEoWXZW2NGrf
 B+FBWCpVsJnQA/XDUdwTxNwA5SwUMd1bCYCFWxy+aCUPtYCpDCM1lb5OaWnDZEYeAR1+
 urew==
X-Gm-Message-State: AOJu0YwTZb0i4Q+u00uLlj5xMmJwrcqQxjqt1KRY0AYgDobn4M1HsQDR
 /DcWDfM4eRQ0gYf7PBwrFQcm2eGLgBdajbOUfks=
X-Google-Smtp-Source: AGHT+IH0JSjzbc/sINCB6yuPX7uhQYJJtcDtkJ0gpptJqEDQ8H9DfMpc8DHKjz6FKQF9b+CqQAy2HWWCagBtHS8Z3As=
X-Received: by 2002:a05:622a:1a05:b0:40f:ba4c:6222 with SMTP id
 f5-20020a05622a1a0500b0040fba4c6222mr13036846qtb.3.1694516981203; Tue, 12 Sep
 2023 04:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
 <20230912104649.1638640-14-marcandre.lureau@redhat.com>
 <6dc8152b-1098-56dd-c7dc-53814c106c7e@tls.msk.ru>
In-Reply-To: <6dc8152b-1098-56dd-c7dc-53814c106c7e@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Sep 2023 15:09:29 +0400
Message-ID: <CAJ+F1CKUnK_J0CKYhogeS5JyEFTOShKTnWRqC-Ppia+TMjoZFg@mail.gmail.com>
Subject: Re: [PULL 13/14] ui: fix crash when there are no active_console
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

Hi

On Tue, Sep 12, 2023 at 3:01=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 12.09.2023 13:46, marcandre.lureau@redhat.com =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> > 0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/consol=
e.c:812
> > 812       return con->hw_ops->ui_info !=3D NULL;
> > (gdb) bt
> > #0  0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/co=
nsole.c:812
> > #1  0x00005555558a44b1 in protocol_client_msg (vs=3D0x5555578c76c0, dat=
a=3D0x5555581e93f0 <incomplete sequence \373>, len=3D24) at ../ui/vnc.c:258=
5
> > #2  0x00005555558a19ac in vnc_client_read (vs=3D0x5555578c76c0) at ../u=
i/vnc.c:1607
> > #3  0x00005555558a1ac2 in vnc_client_io (ioc=3D0x5555581eb0e0, conditio=
n=3DG_IO_IN, opaque=3D0x5555578c76c0) at ../ui/vnc.c:1635
> >
> > Fixes:
> > https://issues.redhat.com/browse/RHEL-2600
>
> FWIW, this link does not work for me (requires auth).

hmm, should be ok now.

>
> Is there a commit which introduced this issue?

It was reported against v6.2 (2021). I think it was introduced with
commit 763deea7e9 ("vnc: add support for extended desktop resize"),
but it might have been reproducible earlier.

thanks


--=20
Marc-Andr=C3=A9 Lureau

