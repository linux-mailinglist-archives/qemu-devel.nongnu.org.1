Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3CE7F13B8
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 13:44:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r53cW-0005PJ-Qi; Mon, 20 Nov 2023 07:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r53cR-0005Oe-U2
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 07:43:16 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r53cA-0003fE-RP
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 07:43:12 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-548696eac92so2928981a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 04:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700484175; x=1701088975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42wyQOpToypjfoi85NnNYDU1S5TK9R/Q58lCsvQzdIg=;
 b=yDlFwQYrtDaJwo8LUO8B7ctVci6rjgQRAZ/chH5yrLvgqqN447cY6slBBKoEq0382f
 oAYxfbepOghNgq3ve50BiGlAQfsEzEZza1mMEhLO4TC93TAxpaxxyRCkayYHeH6I+H4p
 EuVNuEvxf6tdCvWlhFYcD8YP6gZMwkBN7jR5YYgsmEkIFI40k2TadNol71wM8nNwkMjO
 0SIprQu322XxaxCYKcDB+XsLJBtZqXOzXjImqKXMMxA+zo2XYYbT8Rv72aywKfVptPA/
 5LL6nvJ+9PZ6LcHTJrJgOaPZ9acqoMADfDo3T/FL2PeNXJeLSWiG1K5kMPvzv/D1Zz+V
 oJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700484175; x=1701088975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42wyQOpToypjfoi85NnNYDU1S5TK9R/Q58lCsvQzdIg=;
 b=A/0HyyyYsl3uBd3b/RXETd38Pw2W0Ts0JkxlbZGskHwzqK3aTJKt5rww7Fj4i9f9Yi
 gpLL/0Dj4wfvzuVhe2d/WYiAJM9DtBXzHB/sfk0au5Y7SQC39ToHmX59RzeVW3SJ23JF
 PhNzZbPsO21vsTlAZUcVzjgGq5pTcm8a8ezN575eXowBmC0JAKuJ/SuAMmwHF/D5ORrG
 4Y5kSthW7+mSLIGYoQ9FD4UJ8N6iDGHKGTTjlyBitS+hFlTiT42Coe1Gbsb+tJlD4KqF
 4AfU1DszW72nqGJbX2zIpaLa9QQeoSUViOHzTBfMz3+IcnbDzQwZ5MxIkRzBjKc5fB50
 +TOg==
X-Gm-Message-State: AOJu0YwTLMy1/GPNK71wE7aeRJOxH7MJF2ZvLH+0zLeDmTFRWLgaXqBZ
 ns+mfgE8AwYqMf4YUPyb6EFNGDwdFfHqU2VRGpgsoQ==
X-Google-Smtp-Source: AGHT+IF9tToIiLMZgBBUEc6eYxCrR9s3cd0DegmWfw447Bq9XFxStHly6OgKRGV+cjG2F3QzdFUQ0iVlY1gWwnJz3HI=
X-Received: by 2002:a05:6402:1a54:b0:53b:3225:93c2 with SMTP id
 bf20-20020a0564021a5400b0053b322593c2mr6328457edb.8.1700484175192; Mon, 20
 Nov 2023 04:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
 <20231117143506.1521718-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231117143506.1521718-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 12:42:43 +0000
Message-ID: <CAFEAcA9v76xoU8APDUiztRaxEANRWDWNoFqCMTBZ1L_W2G64jg@mail.gmail.com>
Subject: Re: [PATCH for-8.2 1/3] vl: revert behaviour for -display none
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 17 Nov 2023 at 14:35, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Commit 1bec1cc0d ("ui/console: allow to override the default VC") changed
> the behaviour of the "-display none" option, so that it now creates a
> QEMU monitor on the terminal. "-display none" should not be tangled up
> with whether we create a monitor or a serial terminal; it should purely
> and only disable the graphical window. Changing its behaviour like this
> breaks command lines which, for example, use semihosting for their
> output and don't want a graphical window, as they now get a monitor they
> never asked for.
>
> It also breaks the command line we document for Xen in
> docs/system/i386/xen.html:
>
>  $ ./qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kernel-irqchip=
=3Dsplit \
>     -display none -chardev stdio,mux=3Don,id=3Dchar0,signal=3Doff -mon ch=
ar0 \
>     -device xen-console,chardev=3Dchar0  -drive file=3D${GUEST_IMAGE},if=
=3Dxen
>
> qemu-system-x86_64: cannot use stdio by multiple character devices
> qemu-system-x86_64: could not connect serial device to character backend
> 'stdio'
>
> When qemu is compiled without PIXMAN, by default the serials aren't
> muxed with the monitor anymore on stdio. The serials are redirected to
> "null" instead, and the monitor isn't set up.
>
> Fixes: commit 1bec1cc0d ("ui/console: allow to override the default VC")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  system/vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 5af7ced2a1..14bf0cf0bf 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1391,7 +1391,7 @@ static void qemu_create_default_devices(void)
>          }
>      }
>
> -    if (nographic || (!vc && !is_daemonized() && isatty(STDOUT_FILENO)))=
 {
> +    if (nographic) {
>          if (default_parallel) {
>              add_device_config(DEV_PARALLEL, "null");
>          }

This fixes the regression I was seeing with the semihosting
use case. I haven't checked the Xen setup.

Tested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

