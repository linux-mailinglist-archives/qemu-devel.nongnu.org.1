Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3582DD28
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:15:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPbu-0003VY-JT; Mon, 15 Jan 2024 11:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPPbr-0003V8-Br
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:14:47 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPPbp-0003U9-Fs
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:14:47 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55969c01168so1019891a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705335283; x=1705940083; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NqdtWvtAFs9102sLZunU0LxpsEXynT3pgJ1dkuZkHXU=;
 b=fnlVDuXOJHcerDrEqR2GUX4QMysa9ZGO9E7nGpIMJs19eWZ/YJwXjjAW6F0UVKPjP8
 7yy4ViQoUkpPF0EzgA3tktompJ91ontmMLVyEW6BvUzF/byw6B6cfg3o2lGAu5hslg3m
 4bMaW9LSUbzfGUGUyO4W/653CC5JWmsBSo9cmFTOwkLB23vlGQTvobBrmF5g5CYn7kLl
 2JuTeHpDkGGwXLhrNu/qbmv9OOcPCynsdwQE0K7CsB2aE+BPqS9f7sXbbL5GzuEw0c3g
 oulEJ0wdAt56NYVqU7jIj8HVChACm1zSYuVNiF1UrVhLyE8jyVo8wazk7V1qATszWSU4
 F3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705335283; x=1705940083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NqdtWvtAFs9102sLZunU0LxpsEXynT3pgJ1dkuZkHXU=;
 b=TK7y6BlgHRB0aSihKygnmz0wFAfCKNw2M0S/N+vfTeBK1qJ8ggoEzOexe5XRfb9T6j
 sGHOYsD//FF82KKSP3oan62ns1RNYA8wRp1FVA1QrLYr9gVIoiWHdkT+wkqv1WoAKHnd
 BjSzP0XP/aXA99CbeDI/xZT0OQSc7zPo4a2uSN7KgV9BeS9gtvLx+E+ylDRJlKVNPuRr
 EFFsMBfQ//pBorHq/BdKZHCFsU6PY4maRqyHbUQQG99qWNYaXLEQ3pQvPsdUgl2lDn9S
 rkdRk66MAWHQehqzzKqqzBNRIS7Tg2XgWoBtDp4dIZgR/MohdMXMGKsyGZeWx9JO1Uke
 D/jg==
X-Gm-Message-State: AOJu0YwKb0mobeCs+xSBEmsCUlzQQ517XGVdkLMJklNCVksxMpsk0DKZ
 +oS+B4hWqhixK3yEX3eB7LUmgBK+YXUt+iehfCkN+KvGhlFKSw==
X-Google-Smtp-Source: AGHT+IFEfn8A+hZbFHnRDMBiJnPAASeKxb1BzXuPr7pHGyZnvv4FlHfTomEB/h3TcENf0z6PfZUN+bAiVUzlV8GqAms=
X-Received: by 2002:aa7:c793:0:b0:557:7037:1a41 with SMTP id
 n19-20020aa7c793000000b0055770371a41mr5488644eds.25.1705335282759; Mon, 15
 Jan 2024 08:14:42 -0800 (PST)
MIME-Version: 1.0
References: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
In-Reply-To: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 16:14:30 +0000
Message-ID: <CAFEAcA_5ip7q0Wp=jJkV7sJg=w=e08JCRqPmQuOObNe8AMZLDA@mail.gmail.com>
Subject: Re: [PATCH] Fixed '-serial none' usage breaks following '-serial ...'
 usage
To: Bohdan Kostiv <bogdan.kostiv@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

(I've cc'd a few people who might have opinions on possible
command-line compatibility breakage.)

On Wed, 10 Jan 2024 at 14:38, Bohdan Kostiv <bogdan.kostiv@gmail.com> wrote:
>
> Hello,
>
> I have faced an issue in using serial ports when I need to skip a couple of ports in the CLI.
>
> For example the ARM machine netduinoplus2 supports up to 7 UARTS.
> Following case works (the first UART is used to send data in the firmware):
> qemu-system-arm -machine netduinoplus2 -nographic -serial mon:stdio -kernel path-to-fw/firmware.elf
> But this one doesn't  (the third UART is used to send data in the firmware):
> qemu-system-arm -machine netduinoplus2 -nographic -serial none -serial none -serial mon:stdio -kernel path-to-fw/firmware.elf

Putting the patch inline for more convenient discussion:

> Subject: [PATCH] Fixed '-serial none' usage breaks following '-serial ...' usage
>
> Signed-off-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
> ---
>  system/vl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 2bcd9efb9a..b8744475cd 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1442,8 +1442,11 @@ static int serial_parse(const char *devname)
>      int index = num_serial_hds;
>      char label[32];
>
> -    if (strcmp(devname, "none") == 0)
> +    if (strcmp(devname, "none") == 0) {
> +        num_serial_hds++;
>          return 0;
> +    }
> +
>      snprintf(label, sizeof(label), "serial%d", index);
>      serial_hds = g_renew(Chardev *, serial_hds, index + 1);
>
> --
> 2.39.3 (Apple Git-145)

I agree that it's the right thing to do -- '-serial none
-serial foo' ought to set serial_hds(0) as 'none' and
serial_hds(1) as 'foo'.

My only concern here is that this is a very very
longstanding bug -- as far as I can see it was
introduced in commit 998bbd74b9d81 in 2009. So I am
a little worried that maybe some existing command lines
accidentally rely on the current behaviour.

I think the current behaviour is:

 * "-serial none -serial something" is the same as
   "-serial something"
 * "-serial none" on its own disables the default serial
   device (the docs say it will "disable all serial ports"
   but I don't think that is correct...)
which amounts to "the only effectively useful use of
'-serial none' is to disable the default serial device"

and if we apply this patch:
 * "-serial none -serial something" has the sensible behaviour
   of "first serial port not connected/present, second serial
   port exists" (which of those you get depends on the machine
   model)
 * "-serial none" on its own has no behaviour change

So I think the only affected users would be anybody who
accidentally had an extra "-serial none" in their command
line that was previously being overridden by a later
"-serial" option. That doesn't seem very likely to me,
so I think I'd be in favour of making this change and
having something in the release notes about it.

Does anybody on the CC list have a different opinion /
think I've mis-analysed what the current code is doing ?

thanks
-- PMM

