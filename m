Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F8C800E5F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:17:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95Fi-0001tr-HE; Fri, 01 Dec 2023 10:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Fg-0001sc-9n
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:16:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Fd-0005me-9I
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:16:23 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b40423df8so19542825e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443778; x=1702048578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyWKN675Mp/AhD1Z4srHmHehDQ8aHFa/YesOt9qdJE4=;
 b=Xn87V8WY7Vujes8rItUa6l/PoVONCzZxWunFB7sdKWndd5eAPgyF8eMNLAc9rWgYxz
 +haIFxoiJfBEgJ+frSS3P2YFgwyczpKo4HBpAEkW0M+FMQoCAC5lzJpdBrYB5E+G7wiQ
 grza9ve8hJC79Hq0ykDh58qeYEXpx8B6Y4so2G/Iflv7HNO2vfIjwbwAYZD2h/kf1qnn
 m3XnjPUl/ko5FC3ZrytuVBd+EgdQCBYHs0OlkM5Y7zFpXVX/B9+L2SCd4kffrXxbbqE4
 StbfYyLeC5DDZ5VR0zR3pDIbm+u0G/xmzPOtCUdk6I0vDdeATlgbUqAH9I1VHvzUlfO0
 Tojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443778; x=1702048578;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CyWKN675Mp/AhD1Z4srHmHehDQ8aHFa/YesOt9qdJE4=;
 b=vowDNOUEcPKOsrgwTpivfD/70OlMs4mVW+n/F3iGzp6sAuAJn/3HeZn+JU7OfBY3C/
 ggLatRd3aSUr0chCUVDu5uAyr/IjHGtA90qS8I0W00pX/UoJq/kB8PPgAigHpzX2EDbo
 ZWgXfv5IkxqmGFkhvhPYZSQyqgvPrjTsJZlTlsfMfvVuXisC7aVMYEqPoE0eiGt9EyBv
 jwoo84OzDkXgQmXqTQ2IBiy3iK3OxXTK7iFHsdkbEoLpDIFdfxzasH0eJ8sFs9fFgPTI
 +fYJI71J7zvw77pgvOBaEypaBeErp6OzFUA/q2I2w3oczbFgh4YWz1tv5iGD4e45nE7G
 YG3g==
X-Gm-Message-State: AOJu0YzGSf9Q+c5j3WYP8BBQnockfX260tyIG4yHDbD/ePHR33htpeuf
 x2RMtXe29u1ITpbkxY5HgTv8wg==
X-Google-Smtp-Source: AGHT+IHaRCIE4y4wqjJjCi3MOWstu3TCbsIKk2lODrjqTxQE7eP8sKA8U7pZcsBy8J/A0CcuAn4ytQ==
X-Received: by 2002:a05:600c:6009:b0:40b:5e4a:4086 with SMTP id
 az9-20020a05600c600900b0040b5e4a4086mr372183wmb.166.1701443778395; 
 Fri, 01 Dec 2023 07:16:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fa10-20020a05600c518a00b00405442edc69sm9342448wmb.14.2023.12.01.07.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:16:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC9BF5FB5F;
 Fri,  1 Dec 2023 15:16:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org,  Eric Farman <farman@linux.ibm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Beraldo Leal <bleal@redhat.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Yoshinori
 Sato <ysato@users.sourceforge.jp>,  Eric Auger <eric.auger@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  qemu-s390x@nongnu.org,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Aurelien Jarno
 <aurelien@aurel32.net>,  Cleber Rosa <crosa@redhat.com>,  Joel Stanley
 <joel@jms.id.au>
Subject: Re: [PATCH v2 4/7] tests/avocado: drop malta yamon tests
In-Reply-To: <f8738d36-2527-4620-9532-fca530ef8f0d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 1 Dec 2023 15:05:02
 +0100")
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-5-alex.bennee@linaro.org>
 <45077c53-ed18-4821-bfbe-6dba3ca994d4@linaro.org>
 <87ttp25bqh.fsf@draig.linaro.org>
 <f8738d36-2527-4620-9532-fca530ef8f0d@linaro.org>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 01 Dec 2023 15:16:16 +0000
Message-ID: <87il5i54xr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 1/12/23 13:49, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> Hi Alex,
>>>
>>> On 1/12/23 10:36, Alex Benn=C3=A9e wrote:
>>>> The assets are no longer available on the website so these are
>>>> blocking CI.
>>>>
>>>
>>> How are these "blocking CI"? Missing artifact wasn't be fatal,
>>> is it now? Also, did the artifact cache got flushed? These tests
>>> pass locally, I disagree with removing them.
>>>
>>> I can send a patch using YAMON_PATH like we have with RESCUE_YL_PATH,
>>> but I still consider missing artifact shouldn't be an issue. We are
>>> missing the point of the Avocado cache and the possibility to manually
>>> add artifacts.
>> Sure but in this case the binaries are gone, you can't share them
>> and no
>
> Per https://mips.com/develop/tools/boot-loaders/:
> "To support existing users of these, and the QEMU project, YAMON is
> now available under the GPL License."

Maybe we should build it like the other ROMs?

Anyway I've dropped this commit from the PR so I'll leave it to you to
fix up however you want.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

