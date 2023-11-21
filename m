Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CE7F2679
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:39:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5LKF-0008TT-7D; Tue, 21 Nov 2023 02:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5LKC-0008Sp-Ue
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:37:37 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5LKB-0001RR-KJ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:37:36 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41cba6e8e65so30784551cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 23:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700552254; x=1701157054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duLXC29QWCQJQW+a3lKc4mxV9gI5XuVsDlN9TzUM0rk=;
 b=AXpuvojTkg894gU8QnYutVRI8+d0hS/ZbeyHxzkrkjDelOI/GkNH026YIgWBM37Y4u
 R7s7HUbEbu7zsq6WSnkF+5iVQ2oa28Yjjvubc6jRKM1y2zHcTiHdDtWzU5WkxoyGxb9x
 v9yc+cFzUTqsZ0hDh4juNVdef0Dcadm3DGpFCt3x20sf1+s7oMDaE03arSv0Yy7F17n5
 keKQPkq32F9LMDQf5cVNbYB/GfhjrMQj10rrVJ6uSnsbClH1Xo1BkjYcO2wkg59WWNaX
 Ggpu6AuI6lt7rkPhXSxYeH5SfJV//GRP+GS9BwwfrLqP0qR+OkzzdaIwHLkvwYFBln89
 8hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700552254; x=1701157054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duLXC29QWCQJQW+a3lKc4mxV9gI5XuVsDlN9TzUM0rk=;
 b=cSVFEffhopZ4p5Fb6uWDo90jPMAal/CcYtAg6CyfkBsQ8jCaWMCgxfXKn4nx25nWGt
 Up2twMI97bEILBaxuXT8HkQMfHq+BA69QqHiNM4Q8jWbvYt3Hq0RKvEfnlL7rSHH9Y1X
 uUYAM5EjTf9WgZB2fiNh+ty4Gtqby6l+6ULC61ojcYmAds10mrDz8D6Aa2QgW7PDMV/u
 YhTwqWT67x8D4A5jbgsWZ+SK/EOzZcerllZhpV3h3r60i4cw22SYEl3m8JEiIHjMR7LD
 aT8zspuRC+peYV5APGslqNkWl2tbGhAcCuEYFD5ffCnouxS6f1QuzYmsWU8n8yegIPMe
 fYPA==
X-Gm-Message-State: AOJu0Yw7sgg2sZHkUG+71S+181KntDpBvVqMGjMtV/aATJ2hGVDdePdv
 4In16oSYPQhWTJzupHRkEKRO85p8FfAEDKjSeDtf9SBKj0W5BA==
X-Google-Smtp-Source: AGHT+IHNN5Cn04tpDbiKGF3SkCxmZdvMs6SzKYbpftghmoj6LDXBMFB653BzGJ9pGIJo3Xo/mndCrIIAhzqSgl0UI2g=
X-Received: by 2002:ac8:5dc9:0:b0:419:5162:5e0f with SMTP id
 e9-20020ac85dc9000000b0041951625e0fmr12438439qtx.13.1700552253787; Mon, 20
 Nov 2023 23:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
In-Reply-To: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Nov 2023 11:37:22 +0400
Message-ID: <CAJ+F1CL_a72vuH0ShLwVXKW-2sTzSX0LnWtSDT6BxKNx_ZUhzg@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/3] UI: fix default VC regressions
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org, 
 Paolo Bonzini <pbonzini@redhat.com>, dwmw@amazon.co.uk, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "gmaglione@gmail.com" <gmaglione@gmail.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

On Fri, Nov 17, 2023 at 6:36=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> There are a few annoying regressions with the default VCs introduced with=
 the
> pixman series. The "vl: revert behaviour for -display none" change solves=
 most
> of the issues. Another one is hit when using remote displays, and VCs are=
 not
> created as they used to, see: "ui/console: fix default VC when there are =
no
> display". Finally, "ui: use "vc" chardev for dbus, gtk & spice-app" was m=
eant to
> be included in the pixman series and also brings back default VCs creatio=
n.
>
> Marc-Andr=C3=A9 Lureau (3):
>   vl: revert behaviour for -display none
>   ui: use "vc" chardev for dbus, gtk & spice-app
>   ui/console: fix default VC when there are no display

I wish to send a PR (rc1 today), together with "[PATCH] vl: add
missing display_remote++".

Some R-B/A-B appreciated! thanks


--=20
Marc-Andr=C3=A9 Lureau

