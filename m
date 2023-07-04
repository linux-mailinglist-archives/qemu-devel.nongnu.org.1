Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223F74760D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiUS-0006B8-Gd; Tue, 04 Jul 2023 12:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGiU7-00060g-5S
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:02:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGiU2-00029N-Nr
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:02:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3142860734aso3184745f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688486548; x=1691078548;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMeChzpUyW5jyTGUQxxuoOuKKOO34rjMfXyYLTTUTA4=;
 b=JoFOLJQaicC97cvRmuLUZJTxrvHRNQloUfmqXUYVlVlcByYDXjxuv9kfwDCavwvUaR
 LuP/QAXH51jmCl4BKJE9FCbC6Dfyt79eur4OsEY4YH2NR7Gtpu/WQM4F3GJO3UIFmWY5
 AUpSkwFnhoz5vh3S2fPz6wO2VfvANQSbeOT04YZU1AyNTa2Up75NWW8KR4mVonj5Ir7R
 0xaP9Su/mx1hsQqGOlwQA8k3QSZGu/CpHVrjppt/0SoWwdrM8TdTwj6aJ1bVc3m0t/ob
 ED3twg3PCieH7rrW4FBncWMcN0VnaJEbIAoSJh6OImVy5YCQXSMwHS9sgEbQiSvTHhSk
 shqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688486548; x=1691078548;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fMeChzpUyW5jyTGUQxxuoOuKKOO34rjMfXyYLTTUTA4=;
 b=DR07dtGZhIgbSGJ4bGMxjAife+37o6N2fMvVgSPLaQHW9DXOvS1cVintuFeXpMC718
 8UTZaDFTG90wm97rkeYDPj91OAcK/ICnNor5hF53hpWS4iJAFW5KPsQMhCUMIHmRl2ES
 KN/lxgs3vlJvapLIzfmowPxZc9ns1g6LQrivk/HK8O+M2FNXUNVMZ/2qVaynQE0HV0bq
 AtYlgjEE1M24qHtQcJ27SH5gZffASa2YeMM2MdlbcgIIzV/NalbqXJTW9JqyVTFYyTLV
 sxBP17pOWamwdJQKXt5nJlgKxaJdcYdxQItd2IJnLwgNboQ1VE34ksKEEWIpBKANoVue
 dPqw==
X-Gm-Message-State: ABy/qLaSVJ//KkMBAfttMskWD4ADATzWFZvtz2v9ppBqQaqfhqDEvVvY
 dI1ONxCnV5w2N23Sp3Ccbjuuhw==
X-Google-Smtp-Source: APBJJlHFEzIE7SafOU4WPj9/EimYMClEl/wXpfSVrvtycvXRXO+j31FmaLCz+LAZ3GSvzEpMgRJWHA==
X-Received: by 2002:adf:cc90:0:b0:306:3352:5b8c with SMTP id
 p16-20020adfcc90000000b0030633525b8cmr13220088wrj.7.1688486547785; 
 Tue, 04 Jul 2023 09:02:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a5d4f91000000b0031433d8af0dsm6999544wru.18.2023.07.04.09.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:02:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8C3D1FFBB;
 Tue,  4 Jul 2023 17:02:26 +0100 (BST)
References: <20230704154332.3014896-1-peter.maydell@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH] target/arm: Avoid over-length shift in
 arm_cpu_sve_finalize() error case
Date: Tue, 04 Jul 2023 17:00:33 +0100
In-reply-to: <20230704154332.3014896-1-peter.maydell@linaro.org>
Message-ID: <87jzvffywd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

> If you build QEMU with the clang sanitizer enabled, you can see it
> fire when running the arm-cpu-features test:
>
> $ QTEST_QEMU_BINARY=3D./build/arm-clang/qemu-system-aarch64 ./build/arm-c=
lang/tests/qtest/arm-cpu-features
> [...]
> ../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is too =
large for 64-bit type 'unsigned long long'
> [...]
>
> This happens because the user can specify some incorrect SVE
> properties that result in our calculating a max_vq of 0.  We catch
> this and error out, but before we do that we calculate
>
>  vq_mask =3D MAKE_64BIT_MASK(0, max_vq);$
>
> and the MAKE_64BIT_MASK() call is only valid for lengths that are
> greater than zero, so we hit the undefined behaviour.

Hmm that does make me worry we could have more land mines waiting to be
found. Would converting MAKE_64BIT_MASK into an inline function and
asserting be a better solution?

>
> Change the logic so that if max_vq is 0 we specifically set vq_mask
> to 0 without going via MAKE_64BIT_MASK().  This lets us drop the
> max_vq check from the error-exit logic, because if max_vq is 0 then
> vq_map must now be 0.
>
> The UB only happens in the case where the user passed us an incorrect
> set of SVE properties, so it's not a big problem in practice.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

