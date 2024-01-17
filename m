Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A15830498
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:35:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ4BO-0003QS-AV; Wed, 17 Jan 2024 06:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ4BL-0003Ok-Lt; Wed, 17 Jan 2024 06:34:07 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ4BJ-0005Ha-3s; Wed, 17 Jan 2024 06:34:06 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-429cafdc6c1so33911151cf.1; 
 Wed, 17 Jan 2024 03:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705491243; x=1706096043; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbRdYF6W/desPaz0GWHbRbds0lNNxcJa2//PZj5iNoU=;
 b=aGdd/giaJEh/mitfaXq6WC7LoAspozWkoif8a1Mmy3nGUjiCN5/TWULzLETbJIxqLx
 Je/g5eLB2InNSfqpUD429kSpoxVf0Ccagrm+dvdlsUxGbeb62HfOcfN8/TmBXPKIEMkf
 tmsjvovNBZvPC2DKXPpK0D/ZemlNfEK61I0gqN33OVZ1KNAfrL0lS4cgV3mRS/f3Q7XO
 n48Tmf6y7p59ihJyIuBgIqRlAJbLZjh7UiA88EevaYEGbh0/ufeQuH1EsjrGb4/WRv+f
 9z3pIWqngwrYDPs5eaLOmlLdqvoW6mBRZliLce7zbh/2gH8rZtdN7b63TBRXQzkzU+DW
 cljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705491243; x=1706096043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbRdYF6W/desPaz0GWHbRbds0lNNxcJa2//PZj5iNoU=;
 b=fmQYBv46jnzDE47i3o9ULo9YDfbRZqFqxYa6DbrDds8T+gBGW81eTSefREGTiZynit
 33cIfSJ30cT4ylGLJISier7VqsnabWE7xI0fv0HhzN+zXsYra9wjO4P5DrBDQZ4ccqWQ
 IvhNekmGDR6wfEdR5t/rhIbkMvUe5JifH3dj5brpZQH16sTK+UAa4JO8LVFpoNeYLeFo
 OTgd7a/ORYorC3LalzF2mFBG8q40to31f+JT1AHbOiUJJUw31wfih0V4O9MC7frEYJ4L
 RcQ9pP+Tcn8yyXkHDfJ0zcBja7wpTwE8C295EKqbgMspFfCsCieY+iK6l9gyVicTU+pN
 KPHQ==
X-Gm-Message-State: AOJu0YxwSpjiJFAnR1podU/gvhAFp9a9pWKw9hQw14MCpBM0oQeOamTA
 bgu8CjFW4bdg3vU8dhKCD2S8aQstxUuDZOzdQdI=
X-Google-Smtp-Source: AGHT+IHEk7MqUxs0f12jcVGKS7YJPz5gZK2zKzPVtJQ4PesJfD9M7H3H2qrZ5M+1bpqjml7VBnjT+hAibx/W9alRXoY=
X-Received: by 2002:ac8:5f87:0:b0:429:cef4:4cc6 with SMTP id
 j7-20020ac85f87000000b00429cef44cc6mr12363944qta.131.1705491243393; Wed, 17
 Jan 2024 03:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20240117110109.287430-1-f.ebner@proxmox.com>
 <CAMxuvayHZiXp=VRm=e=HT8u91p3MTut1KXyWOaooEUv7=wZwFg@mail.gmail.com>
 <4d6f1a47-3311-4a44-b47c-19035d6cfee0@proxmox.com>
In-Reply-To: <4d6f1a47-3311-4a44-b47c-19035d6cfee0@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jan 2024 15:33:51 +0400
Message-ID: <CAJ+F1CJ4gF=kx1xedYsnU9MYqTS24xobYrf4ObOAgDnSFGFrnA@mail.gmail.com>
Subject: Re: [PATCH v2] ui/clipboard: ensure data is available or request
 callback is set upon update
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

On Wed, Jan 17, 2024 at 3:30=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 17.01.24 um 12:11 schrieb Marc-Andr=C3=A9 Lureau:
> > Hi
> >
> > On Wed, Jan 17, 2024 at 3:01=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> >>
> >> +    for (type =3D 0; type < QEMU_CLIPBOARD_TYPE__COUNT && !missing_da=
ta; type++) {
> >> +        if (!info->types[type].data) {
> >> +            missing_data =3D true;
> >> +        }
> >> +    }
> >> +    /*
> >> +     * If data is missing, the clipboard owner's 'request' callback n=
eeds to be
> >> +     * set. Otherwise, there is no way to get the clipboard data and
> >> +     * qemu_clipboard_request() cannot be called.
> >> +     */
> >> +    if (missing_data && info->owner && !info->owner->request) {
> >> +        return;
> >> +    }
> >
> > It needs to check whether the type is "available". If not data is
> > provided, owner should be set as well, it should assert() that.
> >
> > That should do the job:
> >
> > for (type =3D 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
> >     /*
> >      * If data is missing, the clipboard owner's 'request' callback nee=
ds to
> >      * be set. Otherwise, there is no way to get the clipboard data and
> >      * qemu_clipboard_request() cannot be called.
> >      */
> >     if (info->types[type].available && !info->types[type].data) {
> >         assert(info->owner && info->owner->request);
> >     }
> > }
> >
>
> Okay, thanks! But we can't assert, because that doesn't resolve the CVE
> as it would still crash. The VNC client might not have the
> VNC_FEATURE_CLIPBOARD_EXT feature, and the request callback is currently
> only set in that case. But we can return instead of assert to just avoid
> clipboard update. I'll send a v3.

If it doesn't have VNC_FEATURE_CLIPBOARD_EXT, it shouldn't update the
clipboard without data. (ClientCutText/ServerCutText always have data,
even if 0-length)

--=20
Marc-Andr=C3=A9 Lureau

