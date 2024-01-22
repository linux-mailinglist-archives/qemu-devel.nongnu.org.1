Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69702835EA5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:50:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqwl-0007h4-C8; Mon, 22 Jan 2024 04:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRqwg-0007fj-5N
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:50:22 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRqwe-0003fl-G9
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:50:21 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3392b15ca41so840240f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705917018; x=1706521818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Da0gBi7XS2vcc2+a3NM52eQoDbF58qwkxk12PWR27s=;
 b=uY9NGm7gTqbi3tvOcVLkjtLTmGlYia3LNrshgrYayvt7Nws9JdeqcgNvhAsKKbf2ry
 eCTV5F7+vNliI5HoWWYWi7RliMjHcA6qpSLMf4+OeGVJ6P7f3ees4QGntNGsNcNaBAuM
 s1JLA9wh1oUylYIx6IaN/Icrh/h0b5ODjEFusQ2imt4rXx5/XZE6zAD9KTo81VZEDvWN
 oTER7TdgVq2pEZIjolVDrv6F743vYjTBS1WJ7LgBIlZaIFf/g2CerxOOb+kMTlJfDNs/
 iG2Ss5mSAuwja5lCy2jszRdQJ+6Sa4oNHPldhZtgU1RF0YGi50UflYJk6N4gD2kby21F
 u4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705917018; x=1706521818;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Da0gBi7XS2vcc2+a3NM52eQoDbF58qwkxk12PWR27s=;
 b=uDBoUgFDBRVL2RZXaysNzoY7t2VJfleSGEddSIgvNJa8DReHSLyQZlQ141sTKh0Fx9
 UKw7LZyLGyOFag1JlOXWo0/M+BliTJz8knUUDJqoLuA2u5sVlRkgzJ16VLPfRi7iis56
 ZBMv306HI+Nf9WXtWRBS+Te0r1k/95sIBKJk8pyqK+ULIzWKdQetsC7XiIOQQq3Hkl23
 3bZJj+jP3QjxTa2HMN096Imqqxd1LnynW2XKVX/pRy6IDODmJgCIndrHjs4VXeN7DrJM
 65rICYeUH+rd3gxW6fv6K+NExU9OB7MWkICF2yMNy7yRxsOzltrnTDjc9lcoMUTohPJ9
 d9MA==
X-Gm-Message-State: AOJu0YyQymOIMzhwfcWoChbOpa6dHTE1cJzf39M7pWKil2RPLszr7n95
 OwpeS6Be+rGCq5V/DcSbc72t0gPwGIwYa8MOie3TwnrdRVPOll+xJuZ6UMJyeWs=
X-Google-Smtp-Source: AGHT+IFjGqASW+NtNnKTszCvFirtPia/qxwMfAJ7yBI9GJH8gJ0vnJO7GsZ4gT4sGwJG2mp9TjIInA==
X-Received: by 2002:a05:6000:1043:b0:337:767f:c98c with SMTP id
 c3-20020a056000104300b00337767fc98cmr1633612wrx.13.1705917018400; 
 Mon, 22 Jan 2024 01:50:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4d85000000b00337d5aa55cdsm10350822wru.53.2024.01.22.01.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 01:50:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 76C505F7AE;
 Mon, 22 Jan 2024 09:50:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
In-Reply-To: <9dff82f7-d997-4092-8b5a-cd21963826da@web.de> (Jan Kiszka's
 message of "Sun, 21 Jan 2024 17:24:31 +0100")
References: <20231103182750.855577-1-peter.maydell@linaro.org>
 <871qadh8g8.fsf@draig.linaro.org>
 <9dff82f7-d997-4092-8b5a-cd21963826da@web.de>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 22 Jan 2024 09:50:17 +0000
Message-ID: <87r0i9ofxi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Jan Kiszka <jan.kiszka@web.de> writes:

> On 19.01.24 12:24, Alex Benn=C3=A9e wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> Convert the musicpal key input device to use
>>> qemu_add_kbd_event_handler().  This lets us simplify it because we no
>>> longer need to track whether we're in the middle of a PS/2 multibyte
>>> key sequence.
<snip>
>>
>> Well the key input all works as intended and looks good to me. I'm a
>> little disappointed I couldn't get audio working on the musicpal machine
>> but that is not a problem for this patch.
>>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>
> Looks good to me as well, all keys still work fine.
>
> No idea what's the issue with sound, though. I think I haven't run the
> whole stuff in a decade or so, had to search for all the pieces first of
> all again. The webradio service original behind this stopped their
> operations, at least for this device, but manually entered favorits
> still work on the real device - I still have one, though that is
> starting to get some issues as well.

I navigated through the favourites and after pressing some keys it seems
to indicate there was a stream of some sort (or at least a bitrate was
reported ;-).

The main issue I was having with sound was with pipewire - this would
eventually generate a lot of warning messages because input devices are
created but I guess the model wasn't draining the input buffers so
eventually we get:

  qemu: 0x7f1490259500: overrun write:5859188 filled:5842804 + size:940 > m=
ax:4194304
  qemu: 0x7f14902680a0: overrun write:5860128 filled:5843744 + size:940 > m=
ax:4194304
  qemu: 0x7f1490259500: overrun write:5861068 filled:5844684 + size:940 > m=
ax:4194304
  qemu: 0x7f14902680a0: overrun write:5862008 filled:5845624 + size:940 > m=
ax:4194304

Is your image just a hacked up version of the original firmware or
something we have source for? I guess there was never a rockbox port for
the device?

>
> Thanks,
> Jan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

