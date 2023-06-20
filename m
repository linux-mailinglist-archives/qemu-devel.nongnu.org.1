Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB3736B8F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:06:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBa7C-0003fh-IT; Tue, 20 Jun 2023 08:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBa79-0003ez-K1
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:05:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBa77-0001B9-Qr
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:05:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3111547c8f9so5376509f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687262736; x=1689854736;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gyCpUtU5oiSLAURYS5kQSgG2JB9prXaU2atQQYvMjc=;
 b=O24NBGSX00zM+MHeZh9rU0TvE7lNtqV5BEpuvG2HQnQXOYXJUooQ3tDT+N8OYv22Qk
 VwYTrPe0QSEStHsmewAClnImTmE/MmD3M6k8YP8qU1Gmbo/20EQ4Y5r2JjAB/fP5kUfk
 Tfb7YKuoiGMJ3+O+Ul6twk4N73TJ7OVzwnOyWygmT3UNCJAQ5xv+kNqAaBm1KNJtiKe+
 10HXeOUPm0oHvYMYtBfe1Zqbsp6cfSymG8YsxyQEDvshkmto5iYVqZpwmRI/PqwT6UJW
 ORHEZdhk7FCEQ5Sns1UILMEok6RZIdzpjQhtvWNix1oi2P397WpVPxJInA8w2B9mxFs3
 OdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687262736; x=1689854736;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/gyCpUtU5oiSLAURYS5kQSgG2JB9prXaU2atQQYvMjc=;
 b=WwS4ZcoXzrFyMFX1ceVgNA13nvpdVc7cLOmc8eDkb8i0y9AtMssP7t2PxfUzfAPEtl
 lzPGtc0eBwf4ybD8540TslbzPJe8mVv3jlqXCtiK7SOvlMQqdYrwjrHhOb1MpdaLa8Ia
 UE/JoGH/LpQG1FFvXpCjnjY++ynRif0zeEmaXpkETNsPxt3gT1rGzFfisb8aczXHzDwZ
 jVh+C/+omFn/ke8vWbOyE/jYuamWM3Q3a/+n1ESQFx94ST6/9+1d0xau9hOzOdeREYLm
 MPkm4oQVicyek8i+0c4uGX+0RB0WynRYubh7WPysOvYiuuFhsSC9aP6Ax9bei6Dgxxtp
 LEnA==
X-Gm-Message-State: AC+VfDzW6scvETxBm4x5Gcsws6s/R9HXzXNMRqR5UFRYjgFLBCYizArf
 xTcTqA4lCiSG+dZRhZWBT0wS0cSRwp3/cUWFjHM=
X-Google-Smtp-Source: ACHHUZ4gwOKZkMlZNzmRhf8I2q9cvQJRMsAmTh/1OaKgbul1u0By9MOK9/6uhHy1SPOHg/2CGyxAfw==
X-Received: by 2002:adf:de87:0:b0:311:1029:e325 with SMTP id
 w7-20020adfde87000000b003111029e325mr10375163wrl.70.1687262736052; 
 Tue, 20 Jun 2023 05:05:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g3-20020adff3c3000000b0030e52d4c1bcsm1841589wrp.71.2023.06.20.05.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:05:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 320341FFBB;
 Tue, 20 Jun 2023 13:05:35 +0100 (BST)
References: <20230610171959.928544-1-richard.henderson@linaro.org>
 <87ttvee4tf.fsf@linaro.org>
 <ba4c99fc-7b3d-3969-260c-96c7c244cc46@linaro.org>
 <1199d248-8aee-4e93-95cd-ad8847ed2255@linaro.org>
 <87mt0vjqxi.fsf@linaro.org>
 <d0641e1a-4461-71b1-c108-d226e1885906@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Tue, 20 Jun 2023 13:05:07 +0100
In-reply-to: <d0641e1a-4461-71b1-c108-d226e1885906@linaro.org>
Message-ID: <87sfamibjk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

> On 6/19/23 19:34, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 6/12/23 04:50, Richard Henderson wrote:
>>>> On 6/11/23 02:14, Alex Benn=C3=A9e wrote:
>>>>>
>>>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>>>
>>>>>> This is a perfectly natural occurrence for x86 "rep movb",
>>>>>> where the "rep" prefix forms a counted loop of the one insn.
>>>>>>
>>>>>> During the tests/tcg/multiarch/memory test, this logging is
>>>>>> triggered over 350000 times.=C2=A0 Within the context of cross-i386-=
tci
>>>>>> build, which is already slow by nature, the logging is sufficient
>>>>>> to push the test into timeout.
>>>>>
>>>>> How does this get triggered because I added these:
>>>>>
>>>>> # non-inline runs will trigger the duplicate instruction heuristics i=
n libinsn.so
>>>>> run-plugin-%-with-libinsn.so:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0$(call run-test, $@, \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(QEMU) -monitor none -display none \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -chardev file=
$(COMMA)path=3D$@.out$(COMMA)id=3Doutput \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -plugin ../../plugin/libinsn.so$=
(COMMA)inline=3Don \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -d plugin -D $*-with-libinsn.so.pout \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(QEMU_OPTS) =
$*)
>>>>>
>>>>> to prevent the callback versions from being called for x86. The origi=
nal
>>>>> intent of the check was to detect failures due to cpu_io_recompile, s=
ee
>>>>> e025d799af (tests/plugin: expand insn test to detect duplicate instru=
ctions)
>>>> I have no idea how, but it's happening.
>>>>
>>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>>> ---
>>>>>> Irritatingly, it doesn't timeout locally, so I used staging to doubl=
e-check:
>>>>>>
>>>>>> Fail: https://gitlab.com/qemu-project/qemu/-/jobs/4450754282#L5062
>>>>>> Pass: https://gitlab.com/qemu-project/qemu/-/jobs/4450927108
>>>> Note that in the pass case, we don't even log that the test ran.
>>>
>>> Any further thoughts on this?  Otherwise I'll merge it to get rid of
>>> the cross-i386-tci failure...
>>>
>>>
>>> r~
>> I'm happy to drop the feature from the plugin but the clean-up also
>> needs to be applied to the run-plugin-%-with-libinsn.so: rules for i386
>> and x86_64.
>
> Pardon?  I don't know what you mean wrt changing the makefile.

There are a couple of places that do:

# non-inline runs will trigger the duplicate instruction heuristics in libi=
nsn.so
run-plugin-%-with-libinsn.so:
	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
	       -plugin ../../plugin/libinsn.so$(COMMA)inline=3Don \
	       -d plugin -D $*-with-libinsn.so.pout $*)

to prevent triggering the assert for x86

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

