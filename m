Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6256C7824DB
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:50:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzed-0006U0-4z; Mon, 21 Aug 2023 03:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qXzeZ-0006Sk-OL
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:48:47 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qXzeX-0000aN-Ll
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:48:47 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-40849e69eb5so20556201cf.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692604124; x=1693208924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gYmpiULw8HwJhH7Z+Nas4PnlBTodZE7X8s5pKgyk1c=;
 b=YY6vaVnSN2ezoa3nBplF0obSYTo54OY6NrjHudRprZ+vJQMyHWqbhRdDhbZhpIG6pG
 Px9xK1HJkbXc9fICeYDM+gcLmyD4ESIQSbuw1iqgN+u5WCUlE0+2edAwW1WuJIm6rvDI
 kFNx3R9laB8800IckLg9SdL4X/4ZGz/uo8gcDvY7SKNwYQX6JJfWzsj1ldkW1VGgri7E
 oDuiM5MMOiwIHDQZGcjrS1HiRf1YVygFvfSerLQsHGk1SSLWzTZFn2U6uBD2yRqzx71B
 ZIfspdEUZ+nly4RuM6EubSbc84Ry3dLVbq7ZZeRxrC+/hjNwKkZL+7PX4dv10CguPflT
 Sz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692604124; x=1693208924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gYmpiULw8HwJhH7Z+Nas4PnlBTodZE7X8s5pKgyk1c=;
 b=IUvH9gU2AJ7t/K5fIdIbuzt3jTUKuthibvzJ9vRER7KKzfyNaXr3dNRW1XowGukZF6
 eYFX0H32dvPVbFEMHdzsI8X4mocoCWjkUsJu9xvQYaJemtZNl9XMJEmyc0mTMstGh6I1
 Ufm+HRXOASI85WxHIjhQydpeCCbK6zeRv1vekZnd6CYycWcXogXloXi42uJEYemIzNTc
 1KBuJPYfOHh6o9J2kFOn2q+fRE1vPUluFBR98t0IcSUoR6RFcfk2EkAYMFMD/p8FSNMx
 szDZO3gBR3ij7RPP6FUL/7/ycdd5REfh1us/vJwkRbjtCzvz2+2V2JvtERIWc2mftPb0
 FUJg==
X-Gm-Message-State: AOJu0YxCuMwBgJ+FQVAz7zjfs8OSlAd0jvx6+W2iaTk6OMN8+7tZYSUO
 X7cSodvfx9FukUzh7D16CUmyNPsm9OkrJlRQx6w=
X-Google-Smtp-Source: AGHT+IECORz/4P9VijdVGWL51K85S6PU3M67vIAxUFVayg9OiROei6Mf23rMp3Xa/XRfD7+YAO6aETR0iofIkRNrMFA=
X-Received: by 2002:a05:622a:120a:b0:403:ef20:5142 with SMTP id
 y10-20020a05622a120a00b00403ef205142mr8588819qtx.40.1692604124432; Mon, 21
 Aug 2023 00:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
In-Reply-To: <20230818155846.1651287-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 21 Aug 2023 11:48:33 +0400
Message-ID: <CAJ+F1CK6Ekf1Q+HjBNvdnG4ioOyv=qHHx4Ovi7NV=GV_b7Qf3g@mail.gmail.com>
Subject: Re: [PATCH 0/2] audio/jackaudio: avoid dynamic stack allocations
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

On Fri, Aug 18, 2023 at 7:59=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> This patchset removes two variable length arrays from the jack audio
> backend.  The codebase has very few VLAs, and if we can get rid of
> them all we can make the compiler error on new additions.  This is a
> defensive measure against security bugs where an on-stack dynamic
> allocation isn't correctly size-checked (e.g.  CVE-2021-3527).
>
> The first one is fairly straightforward (although the JACK API's
> requirement that (a) you don't pass it an overlong client name and
> (b) that maximum length is provided by calling a function, not as a
> compile time constant makes it a little less clean than it might be.
>
> The second one avoids the dynamic allocation, but if the audio
> subsystem has a compile-time upper bound on the number of
> channels then we could use a fixed-size stack array rather than
> the awkward "allocate a working buffer at init time" that I
> have in this patch. Suggestions for improvements welcome.
>
> Disclaimer: tested only with "make check", which doesn't actually
> exercise the audio subsystem.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

