Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7BB70E172
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UVr-00036l-To; Tue, 23 May 2023 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UVp-00032c-Gb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:05:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UVh-0002QL-B0
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:05:25 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso5066935f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684857915; x=1687449915;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOGr0xS3ZCy2vcLAuqxknwdV9hu1y6QANaKv4NtUiLo=;
 b=IcI7f9tTU3ECy+bS5vnlwkfSh8x0ROjcZIo7sf+6vgfCXqVnY/kf1zOh5TS7FIl9g8
 VUugOV1FS9FhJoc7dJlylT1f3bK90qwW1lEPDDrMHz8omuBKHT0gO8nqiDEqxAtrJZME
 AF2Vi65LHP/CLJLxT61KrUMrBuWPRzDUKD8O0QVELQcUMcGwLSQgLSk5NmXDh62S7nWY
 RtWYgxTClUbG7MN51CkYpQF/53iS3peqNWsT+YBU41YqMGLaH/ra/t0Y1+AKQCqBpOqV
 6Pv0ubIoiv65M20jEBLI1nyCNyk3nVN94tIM3h4bdTZBhk5Lb0vCKYM613Ny/VM5MqDs
 oRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684857915; x=1687449915;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BOGr0xS3ZCy2vcLAuqxknwdV9hu1y6QANaKv4NtUiLo=;
 b=YcUkpqP4ZhEtsrfvj68JEjh1Gj+G18Sc44e5EHpGL5z4eNLgGox8wtHKRDMSVusGjc
 A+gONDtp1rRi5raAsZQdZKzmFy0pmtC/VM0YLCYnZ31ALthol7oInqNj27xbSiNNNDnR
 4ejxm+qIFOgLKcT5kpsx5UpTHgk2KZXRi3wWkxMw5LFTFNn+5WrKpjPvM0+0hcZqrKIS
 P0pWiRG0GiELwFX4WGqYuFg/TJabiWNUrksEZSPKk7ez6g4ECUqfiukolvElxtI1Vx9b
 ckeQFYzRda2SP3Yn212/Ub9kGESZX4JbachcGDT973PI68Tq0/cmwL7IT6BgYvS7O/O1
 oMeA==
X-Gm-Message-State: AC+VfDzrq9y9zMPrx0fbZBg0BSa0NBleLfvpzdQHF5qrK2Z2DuZ/NH/m
 UucvXPd9u2YjVNhPIxrwUUgKuQ==
X-Google-Smtp-Source: ACHHUZ77OCVZ8ywXVlgpSf5Cjui0FqFvjP/S/R1BYdW0I/XNj4K2UPxgz8JUAc68PfCwe8pn7DHBNg==
X-Received: by 2002:adf:ea02:0:b0:309:475c:c90e with SMTP id
 q2-20020adfea02000000b00309475cc90emr11349515wrm.37.1684857915183; 
 Tue, 23 May 2023 09:05:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a056000010a00b002c70ce264bfsm11454310wrx.76.2023.05.23.09.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:05:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 220F21FFBB;
 Tue, 23 May 2023 17:05:14 +0100 (BST)
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-3-richard.henderson@linaro.org>
 <b51a6df0-b53b-c6dc-b496-0c320aad463d@linaro.org>
 <dddfb5fc-31b6-9561-5d71-1e83534dc269@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 02/27] util: Add cpuinfo-i386.c
Date: Tue, 23 May 2023 17:01:47 +0100
In-reply-to: <dddfb5fc-31b6-9561-5d71-1e83534dc269@linaro.org>
Message-ID: <87r0r72fut.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

> On 5/21/23 04:28, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 20/5/23 18:26, Richard Henderson wrote:
>>> Add cpuinfo.h for i386 and x86_64, and the initialization
>>> for that in util/.=C2=A0 Populate that with a slightly altered
>>> copy of the tcg host probing code.=C2=A0 Other uses of cpuid.h
>>> will be adjusted one patch at a time.
>>>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>> =C2=A0 host/include/i386/host/cpuinfo.h=C2=A0=C2=A0 | 38 ++++++++++++
>>> =C2=A0 host/include/x86_64/host/cpuinfo.h |=C2=A0 1 +
>>> =C2=A0 util/cpuinfo-i386.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 97 ++++++++++++++++++++++++=
++++++
>>> =C2=A0 util/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++
>>> =C2=A0 4 files changed, 140 insertions(+)
>>> =C2=A0 create mode 100644 host/include/i386/host/cpuinfo.h
>>> =C2=A0 create mode 100644 host/include/x86_64/host/cpuinfo.h
>>> =C2=A0 create mode 100644 util/cpuinfo-i386.c
>> Missing F: entry in MAINTAINERS file. We probably need new sections.
>
> What would you put there?

Part of Guest CPU cores (TCG) I guess.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

