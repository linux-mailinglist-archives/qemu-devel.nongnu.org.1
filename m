Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E177370A9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:38:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdR8-0008UU-AV; Tue, 20 Jun 2023 11:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBdQx-0008K9-T9
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:38:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBdQw-0007ul-0l
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:38:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-311394406d0so2409808f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687275496; x=1689867496;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIEOhBvNPHE/Cf38AWPzOiuTpYIgaV7uqF9dbB5fE0E=;
 b=YuWVc4b9b8vFFitNgxoXzk5E9zYP84TUmNvA+4PXI+Bu9IJamuHDj6IAkU2ZTFZM3q
 KsrN73oiOUF61NybouWLL8GurN44/AqfbS7iGZHd/fmB0xFXz+Wdb9bLHfZihUn6PgDQ
 VOEg7QqhLMksk0uNTAAWbP/zhFWm6kt5uXqOTWK09XJa2MGDOnf/S43Hnt058RjzyXyr
 QAUfFqgGPdhg2zO3ZwxGZ0tdonqjOdI3xDcRGB1sy/KFpR8hWthrwfg/uar7UD09F0p0
 PuN9ig66gJCX+rNmt+LGxZ7OU95AECvM+JESrVsQUzR8a90dobiFUtULP/w4p/RNF5Ww
 PmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275496; x=1689867496;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HIEOhBvNPHE/Cf38AWPzOiuTpYIgaV7uqF9dbB5fE0E=;
 b=eLow88hubbs3O04hZ5nx82kovgpA6CMGpToCoz1IQWNplT+KLUgrC4uXXkbAdoUdAX
 U1UdSU4c33E+Vi2lfC5qM9wxc8G60w8yT6HK+qju+czycF8p+u3KVew2vGj6qsmfF3gd
 vxvCM9/pO6qK0qoyiqIHQWnzMhDQnSESSfebYiuj33SsLsiqeHe2bCWh5fRX/YHJke+p
 iWd+XD3Pd7xwEZZVWWUeP0ByfDReK/4QhlNsihfB4Yu2itczQ0B6GizqD6YasHc6VOcf
 thldYbc4Spj09Y2HN9cYm+FL8Pi9mqlckpFOEW7K3fpR3lLJfz5hlbhTmOootSoWMP+k
 B7YA==
X-Gm-Message-State: AC+VfDzOJmwWRBtudZtTXnwFJ4+ALUwWZeNgt112B+C2CSOBtjxrA/a/
 JXG6cHaOwAjs/KPJH8L7CIFHqdo8xk5nKWDXBCA=
X-Google-Smtp-Source: ACHHUZ79JX66iT3cvTcaEC/wCo/EUWm7CPLPtWa+Hefye8BCGxpilAbeym7gCgpxSamxCykJw+PbfA==
X-Received: by 2002:adf:efcc:0:b0:309:3c0c:b2c1 with SMTP id
 i12-20020adfefcc000000b003093c0cb2c1mr8795469wrp.23.1687275496441; 
 Tue, 20 Jun 2023 08:38:16 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a056000109100b0030c6751a49dsm2199167wrw.115.2023.06.20.08.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:38:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B0D881FFBB;
 Tue, 20 Jun 2023 16:38:15 +0100 (BST)
References: <20230620150335.814005-1-alex.bennee@linaro.org>
 <CAFEAcA9jWuxVVb-+rbv4dEF+0_P1+5z7Z6HQajGv5Jg3yje11g@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Tue, 20 Jun 2023 16:37:28 +0100
In-reply-to: <CAFEAcA9jWuxVVb-+rbv4dEF+0_P1+5z7Z6HQajGv5Jg3yje11g@mail.gmail.com>
Message-ID: <87bkhai1p4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

> On Tue, 20 Jun 2023 at 16:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
>> as an overly wide shift attempt.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  qemu-keymap.c | 24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> Looking at the code that works with the mask values
> we are getting here, I think this ought to work
> (if there's no AltGr modifier then the 0 mask means
> the key state will be the same in normal and with the
> altgr mask supplied, which we already check for).
> Did you eyeball the output, though?
>
> Also, which keymap runs into this? Is it every keymap
> for some new version of the xkb data (which would imply
> that the problem is that the AltGr modifier has changed
> name), or is it only one specific keymap that happens
> to have no AltGr key?

ar maybe? it only got flagged in clang-system once fedora was updated (I
assume with better sanitizers):

  [2773/3696] Generating pc-bios/keymaps/ar with a custom command
  FAILED: pc-bios/keymaps/ar=20
  /builds/stsquad/qemu/build/qemu-keymap -f pc-bios/keymaps/ar -l ar
  ../qemu-keymap.c:223:16: runtime error: shift exponent 4294967295 is too =
large for 32-bit type 'int'
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../qemu-keymap.c:=
223:16 in=20
  [2774/3696] Generating pc-bios/edk2-x86_64-code.fd with a custom command =
(wrapped by meson to capture output)
  [2775/3696] Generating pc-bios/edk2-x86_64-secure-code.fd with a custom c=
ommand (wrapped by meson to capture output)
  ninja: build stopped: subcommand failed.
  make: *** [Makefile:153: run-ninja] Error 1

https://gitlab.com/stsquad/qemu/-/jobs/4500683186#L3957

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

