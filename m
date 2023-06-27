Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A573FADA
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6fN-0002zg-IR; Tue, 27 Jun 2023 07:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE6fI-0002yz-Va
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:15:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE6fH-0004i3-At
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:15:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-312826ffedbso4903689f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687864517; x=1690456517;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpOzSrkNnZ2g7eu+NUnEYfEGBT0SGZZEcJkSuYkv2Xo=;
 b=XBWTPXkgvjCS/n4+rtpUGxIHt85B7Lm0cpQF7Wr5ibWqsnm7GqIAM4vsn0Qb5Ybijf
 ZQvQOgWm9yTrZKaq/v0CndN+j7wxMRLvGikLK/RczLE3QhgGEhswLlYFjVwXU6fFBV07
 fUgTHmeJm3iNQsPeYFPeoLnaKC5Yos8lAkaeD0RMdn8Nm4Diq65KpqTOKuMy94Q3P/Ur
 VQB0/UuHE/u+lT+Qnr3H5fC9Eq1gkXZUJyJUotG644YZkyIz9gWjB8VLtmWKQE/e0Xev
 RD9rC59Ikuw92lKhr9hCtdUxU5P+Gd9sQ06nWyGw6ZOm51d+3yLWIH59zqDixdCyquMG
 ko/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687864517; x=1690456517;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KpOzSrkNnZ2g7eu+NUnEYfEGBT0SGZZEcJkSuYkv2Xo=;
 b=eTZktsG+9TX/zqooAMbDtPEXw1kTne5/LOAloiUEGrSRIPNUbtVr7DtSNMusVqu4IR
 vDf55C67M9jlRD3x4wNDzL2uxjFQ3Qjfp/BW1k9ToPIKVHyDWamwAtowxwnO2owH3CQW
 EsYN3ci7ycxW22brlYinjWwoL7K1YKM6But3ExXJ1dKK0ZLPYCCNK1ICgP6UmlP+umnX
 UIAHiE5v9BcEfrnQ5CizKwA6FoMLmegbA+GBI5veK6NUxrs9Kj46TB5NZlw35Jh/zOrl
 Am9wPzbbIzRPOmDQWlwCQgy4KivMsGDomB0ojm/y+mZIs0/alH5jUJpObktOA1qdPnxz
 ODew==
X-Gm-Message-State: AC+VfDykEYW1HjYr6D4Xo7qFQ+kwJ5eJVve5pGHy/536AgnN396yuWDC
 3M4rnV8Qc3GVVdWcImnWVvZX9BZO49ocwahH7T4=
X-Google-Smtp-Source: ACHHUZ4J5uB0z1JRt+//2e0ILgW+mWy5YTzMYMz4cwwt8adwBmfty0ph82ZzfgFbpMm2rjB+smMGzw==
X-Received: by 2002:adf:e549:0:b0:313:e9f6:3378 with SMTP id
 z9-20020adfe549000000b00313e9f63378mr6553570wrm.4.1687864517106; 
 Tue, 27 Jun 2023 04:15:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v1-20020adfe281000000b00311299df211sm10145459wri.77.2023.06.27.04.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 04:15:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D2FF1FFBB;
 Tue, 27 Jun 2023 12:15:16 +0100 (BST)
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-7-alex.bennee@linaro.org>
 <32624588-a714-6317-77e3-39ce7cdaa8db@linaro.org>
 <87v8f91b4f.fsf@linaro.org>
 <CAFEAcA_cOT9phmZevCz6mu+4U92sk9SeBsP-eux3w-c3tDcToA@mail.gmail.com>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Tue, 27 Jun 2023 12:10:20 +0100
In-reply-to: <CAFEAcA_cOT9phmZevCz6mu+4U92sk9SeBsP-eux3w-c3tDcToA@mail.gmail.com>
Message-ID: <87ttutyx4r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 27 Jun 2023 at 10:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> Ahh in the other thread. No change, it looks like AltGr just doesn't
>> exist for some keymaps:
>>
>>   =F0=9F=95=9921:20:36 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING=
 2/22) [$!?]
>>   =E2=9E=9C  diff -ub gb.before gb.after
>>   =F0=9F=95=9921:20:43 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING=
 2/22) [$!?]
>>   =E2=9E=9C  diff -ub ara.before ara.after
>>   =F0=9F=95=9921:20:50 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING=
 2/22) [$!?]
>>   =E2=9E=9C  ag "Alt" ara.after
>>   21:#     9: Alt
>>   23:#    11: LAlt
>>   24:#    12: RAlt
>>   29:#    17: AltGr
>>   294:Alt_L 0x38
>>   1711:Alt_R 0xb8
>>   =F0=9F=95=9921:22:14 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING=
 2/22) [$!?]
>>   =E2=9E=9C  ag "Alt" gb.after
>>   21:#     9: Alt
>>   23:#    11: LAlt
>>   24:#    12: RAlt
>>   29:#    17: AltGr
>>   338:Alt_L 0x38
>>   1757:Alt_R 0xb8
>
> I'm having some difficulty interpreting this output. It
> seems to show that there is an AltGr modifier in both
> mappings (that's why it appears in the modifier listing).
> And for me (xkeyboard-config 2.33) in the gb mapping it's
> used too:
>
> # evdev 2 (0x2), QKeyCode "1", number 0x2
> 1 0x02
> exclam 0x02 shift
> onesuperior 0x02 altgr
> exclamdown 0x02 shift altgr
>
> (i.e. the '1' key is 1 with no modifiers, ! with shift,
> superscript-1 with altgr, and inverted exclamation mark
> with shift-altgr).
>
> The 'ara' keymap likewise has and uses altgr:
> # evdev 2 (0x2), QKeyCode "1", number 0x2
> 1 0x02
> exclam 0x02 shift
> Arabic_1 0x02 altgr

Ahh right I see those too.

>
> So on the machines where we were running into this,
> what's the version of xkeyboard-config and do we
> output the same mapping as we do on machines with
> the older xkeyboard-config ?

2.35 I think:

ii  xkb-data                       2.35.1-1                    all         =
 X Keyboard Extension (XKB) configuration data

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

