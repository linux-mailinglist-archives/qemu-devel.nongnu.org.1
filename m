Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4D836CDF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:19:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxx6-0003e8-Ef; Mon, 22 Jan 2024 12:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRxx4-0003di-T5
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:19:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRxx1-0000D1-DT
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:19:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso38216345e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705943948; x=1706548748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agKtL+k3Dq+BSli4miMY6vEaDpGimuTEDFWJnn0H/nc=;
 b=Tk5Jp0mPWG0HqJ7zwhALXZKgurZuHvL393MN9rw0WSO+2ECJObxBCcOWxvdPBq/cI8
 dp/aEta310d262H+qBbsAIy1jl9z+4GvJiKx7Xtn26cSDed2gblTC5qgA8Di5FV8Yl9x
 tLqfwcR8ZWfeQjy5c1BPKk7h6j6vJpefHW/gU1AgHH3GrklSaFGcqfZQyh3xsaqR1DJR
 lFQSMyAPqtI7SRadxTnhCJ09YIh3QlanMvO1B1r1Fi0/gry+rl0j9iUCy4GIKygyHSmq
 boTgqkC0Js5S5fLThWmbDvC0zUct7EClN8nfVOkJ0xnz/0/VrNN4tbfKcGpDFz8hNSUu
 UwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705943948; x=1706548748;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=agKtL+k3Dq+BSli4miMY6vEaDpGimuTEDFWJnn0H/nc=;
 b=NPRaM6/SxVSVPGyrOgZdcVkTp8G6lrWGshgPerf6jiyVS7pd3T1OMCrWpfTEJ7XaGg
 eLpaEKcsNKN/reAxP06/RL/f3n8je2fa2s+WK+3Itm7MS50ZQfejzYXL7nOsFXsO+LzM
 FPcg6GShJ1C7BRhrjTLU0WTD4Qg7vkwGh++Mhahr1fOjEXdUnDIXSd1KKJ5h+KCmetEV
 t2vEwecfMz2vM1unXWzL6OqGZDFKIhmwr9U8Oo3vynvH5H3Do52kg+UfSHvB+7uxzdOb
 39KedJ6b5OMfuSdlz/MsvIZyRb3jiW16GITB1kQnDnCqtIQmVEi/Q0ntRBlyEqEIHGS/
 HkRg==
X-Gm-Message-State: AOJu0YzH2yJv2jTWWPVJK1jGFOVrC+EsxDf5NtYDwQ9inI4LbEASxep+
 kSrpc10NrgsOPW1bj5BZ73cdlolP14rM5rsS/SKF3RaRMUgGq9uveKo0M7VeO68=
X-Google-Smtp-Source: AGHT+IH17S2AGyvOuh5OsFYm+SkAb/+SkQljPl1YoZCZQwHzBEoj/BPle36U4vUNactueW4c8TbcvA==
X-Received: by 2002:a05:600c:b93:b0:40e:ac15:8791 with SMTP id
 fl19-20020a05600c0b9300b0040eac158791mr1243594wmb.33.1705943948375; 
 Mon, 22 Jan 2024 09:19:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d7-20020a05600c3ac700b0040ea64a7bbasm8793065wms.30.2024.01.22.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 09:19:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 993665F794;
 Mon, 22 Jan 2024 17:19:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
In-Reply-To: <3b4481cf-e1c4-4515-a7e4-80915cbe2bec@web.de> (Jan Kiszka's
 message of "Mon, 22 Jan 2024 17:30:35 +0100")
References: <20231103182750.855577-1-peter.maydell@linaro.org>
 <871qadh8g8.fsf@draig.linaro.org>
 <9dff82f7-d997-4092-8b5a-cd21963826da@web.de>
 <87r0i9ofxi.fsf@draig.linaro.org>
 <3b4481cf-e1c4-4515-a7e4-80915cbe2bec@web.de>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 22 Jan 2024 17:19:07 +0000
Message-ID: <87plxtmgl0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> On 22.01.24 10:50, Alex Benn=C3=A9e wrote:
>> Jan Kiszka <jan.kiszka@web.de> writes:
>>
>>> On 19.01.24 12:24, Alex Benn=C3=A9e wrote:
>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>
>>>>> Convert the musicpal key input device to use
>>>>> qemu_add_kbd_event_handler().  This lets us simplify it because we no
>>>>> longer need to track whether we're in the middle of a PS/2 multibyte
>>>>> key sequence.
>> <snip>
>>>>
>>>> Well the key input all works as intended and looks good to me. I'm a
>>>> little disappointed I couldn't get audio working on the musicpal machi=
ne
>>>> but that is not a problem for this patch.
>>>>
>>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>
>>>
>>> Looks good to me as well, all keys still work fine.
>>>
>>> No idea what's the issue with sound, though. I think I haven't run the
>>> whole stuff in a decade or so, had to search for all the pieces first of
>>> all again. The webradio service original behind this stopped their
>>> operations, at least for this device, but manually entered favorits
>>> still work on the real device - I still have one, though that is
>>> starting to get some issues as well.
>>
>> I navigated through the favourites and after pressing some keys it seems
>> to indicate there was a stream of some sort (or at least a bitrate was
>> reported ;-).
>>
>> The main issue I was having with sound was with pipewire - this would
>> eventually generate a lot of warning messages because input devices are
>> created but I guess the model wasn't draining the input buffers so
>> eventually we get:
>>
>>   qemu: 0x7f1490259500: overrun write:5859188 filled:5842804 + size:940 =
> max:4194304
>>   qemu: 0x7f14902680a0: overrun write:5860128 filled:5843744 + size:940 =
> max:4194304
>>   qemu: 0x7f1490259500: overrun write:5861068 filled:5844684 + size:940 =
> max:4194304
>>   qemu: 0x7f14902680a0: overrun write:5862008 filled:5845624 + size:940 =
> max:4194304
>>
>
> I'm getting these here:
>
> pulseaudio: set_source_output_volume() failed
> pulseaudio: Reason: Invalid argument
> ...

Yeah I get that with -M musicpal,audiodev=3Dsystem ... -audiodev pa,id=3Dsy=
stem

>
>> Is your image just a hacked up version of the original firmware or
>> something we have source for? I guess there was never a rockbox port for
>> the device?
>>
>
> It's an original firmware, nothing hacked. I do have some sources here,
> but just partial ones: U-Boot, kernel, not the complete userland and
> even not all kernel drivers IIRC.

With -nic user,hostfwd=3Dtcp::8888-:80 I'm able to attempt to connect to
the webpage bit the documented admin:admin doesn't work. I can see
/etc/passwd has something set for admin.

I did find:

  https://musicpal.mcproductions.nl/

which has a bunch of firmwares but the mpimage.bin is raw data (not a
jffs2 partition) so I suspect that is something that gets unpacked
during the flashing:

  =E2=9E=9C  file Firmware\ 1.68/mp*
  Firmware 1.68/mp2image.bin: data
  Firmware 1.68/mpimage.bin:  data
  =F0=9F=95=9917:17:29 alex@draig:tests/testcases/FreecomMusicPalFirmware=
=20=20
  =E2=9E=9C  file ../musicpal/musicpal.image=20
  ../musicpal/musicpal.image: Linux jffs2 filesystem data little endian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

