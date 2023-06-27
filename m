Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF94873F957
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5Rx-0005Aq-Ht; Tue, 27 Jun 2023 05:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5Re-0005AD-Ja
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:57:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5Rb-0004YU-Ac
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:57:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so1952718f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687859825; x=1690451825;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNwbL/Q8UCWKQ9ho/Rhs8oROP/clr0UArNRI1lSVmlI=;
 b=UsxXC4cyQroN6XxP4VZeE097M/aqNYs6krmE3dYWdBntYniLeSfhso4S4OGNoxLQ0u
 UY3RrGh5QbrP1bB5Yd82fTxqtZzHGP/LVSHq6SQe6twB7LIotRUVtxFdzqay9mvATTBk
 SWlWHiYMOpx2/EFUf5ZD9GqmCExfSQzxCnANTWYgGSu8JxKQECwTucNEzM64dcgr3WjS
 Qlq3xAZ2puARVIXhjnySaV//wy4oS8wvc7puki1qIRXkc0Cwj4E1TcEd+jpzVSRaWYCf
 wQ30KsEO7YnW6u4W+zQIBdB0Y8logm+8R/x0Z/zXm9ibdYI5m2Cd6P38vs2luohu9j6r
 0GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687859825; x=1690451825;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xNwbL/Q8UCWKQ9ho/Rhs8oROP/clr0UArNRI1lSVmlI=;
 b=GJG+FIBqKrffUkqZXHSZGqP7mNHLo55m9OwwDJEvLk6Urd8YuoVXGbNriHH8sdzIem
 WBgI8PaORTNxJxkjo1UInqsd5OuHpeStRha6tCtKHOw3gyvLd4iX8Yp7s6xIB+mlcvJE
 sh9DwIrOGKMKtG8JrR27/4LcFBU536bo15Kfy6xVVEn+0hDHr7ukxiyBKu4p1YIY2KYn
 fx15c/bE3gyw+FVRDrhfEsbFUTpWizNVoMmNvefyVI7blYR+n78bTlu5W5vdAmwVJGlM
 ZFyYTRAWUC8YCKqpXp10ftvn64KNoQSew13a4c9/mp8HnPnGAcW1Ky1Di5P4YQFNWcmJ
 yRUQ==
X-Gm-Message-State: AC+VfDxCcJD87qHowyBDbxte5yLbbTM2+u+yaHw2zBJLTbXcgToZb9gt
 FCZ7KUBdxkCMuzIDlE2Ge9F3x+a0CGRLonqgBl4=
X-Google-Smtp-Source: ACHHUZ5ys3xM7kDD4+ZAR2FjzlIskex9prVGpdEBQo9SPigKO1MhsJiRpm0Kv/rcNAbCMTkAnrVWGA==
X-Received: by 2002:a5d:6a52:0:b0:313:eadf:b827 with SMTP id
 t18-20020a5d6a52000000b00313eadfb827mr5374091wrw.56.1687859825331; 
 Tue, 27 Jun 2023 02:57:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a5d58ca000000b0031128382ed0sm9878766wrf.83.2023.06.27.02.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:57:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 880771FFBB;
 Tue, 27 Jun 2023 10:57:04 +0100 (BST)
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-7-alex.bennee@linaro.org>
 <32624588-a714-6317-77e3-39ce7cdaa8db@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 06/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Tue, 27 Jun 2023 10:56:08 +0100
In-reply-to: <32624588-a714-6317-77e3-39ce7cdaa8db@linaro.org>
Message-ID: <87v8f91b4f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/26/23 23:59, Alex Benn=C3=A9e wrote:
>> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
>> as an overly wide shift attempt.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   qemu-keymap.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>> diff --git a/qemu-keymap.c b/qemu-keymap.c
>> index 229866e004..8c80f7a4ed 100644
>> --- a/qemu-keymap.c
>> +++ b/qemu-keymap.c
>> @@ -140,6 +140,18 @@ static void usage(FILE *out)
>>               names.options ?: "-");
>>   }
>>   +static xkb_mod_mask_t get_mod(struct xkb_keymap *map, const char
>> *name)
>> +{
>> +    xkb_mod_index_t mod;
>> +    xkb_mod_mask_t mask =3D 0;
>> +
>> +    mod =3D xkb_keymap_mod_get_index(map, name);
>> +    if (mod !=3D XKB_MOD_INVALID) {
>> +        mask =3D (1 << mod);
>> +    }
>> +    return mask;
>> +}
>
> You have yet to answer Peter's question -- asked twice -- about what
> changes in the keymaps with this. If nothing, should it in fact be an
> assert instead?

Ahh in the other thread. No change, it looks like AltGr just doesn't
exist for some keymaps:

  =F0=9F=95=9921:20:36 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING 2/=
22) [$!?]=20
  =E2=9E=9C  diff -ub gb.before gb.after
  =F0=9F=95=9921:20:43 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING 2/=
22) [$!?]=20
  =E2=9E=9C  diff -ub ara.before ara.after
  =F0=9F=95=9921:20:50 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING 2/=
22) [$!?]=20
  =E2=9E=9C  ag "Alt" ara.after=20
  21:#     9: Alt
  23:#    11: LAlt
  24:#    12: RAlt
  29:#    17: AltGr
  294:Alt_L 0x38
  1711:Alt_R 0xb8
  =F0=9F=95=9921:22:14 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING 2/=
22) [$!?]=20
  =E2=9E=9C  ag "Alt" gb.after=20
  21:#     9: Alt
  23:#    11: LAlt
  24:#    12: RAlt
  29:#    17: AltGr
  338:Alt_L 0x38
  1757:Alt_R 0xb8


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

