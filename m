Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C897FDDCA
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:58:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Nsu-0004hN-W5; Wed, 29 Nov 2023 11:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8Nst-0004dz-1j
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:57:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8Nsr-00010F-Hy
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:57:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b4746ae51so28359905e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701277076; x=1701881876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF0WsKY8zAGsrs/mGWJd2fM9bhE9+AnmOo9yKHngfB0=;
 b=HgkVuZaW8h/uSINhAwE+AUeGLAKtX0P0WoqCnB9LT1AMTPMlDwNJ4HrzS/sczFee2C
 GwwNkUld/7gEDqck69d1Xp9ZwEXEAAQJtUp3WTN3Oy2jkF6DsrGUzg2eepw0YU0YRxpU
 B1n7XueP0+4eNXFckxVmf/pXuEZNYkMA8eaZlTJry1St3l4zSlEnDqOfokh8IdRFt+SM
 ZGyNWUiQOC2HMubM3GGOo/LA53nfp7iIlXVow1dH+/skXpG1FIhiOG5ISXECqXRvjdbD
 7kksxAC6e/AMzgu+nLIylAcar3tXXQpnudWFTOcJTVJ3USYbiDsLtAC7+2I5MyLWrIq5
 yMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277076; x=1701881876;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BF0WsKY8zAGsrs/mGWJd2fM9bhE9+AnmOo9yKHngfB0=;
 b=KQ9Dku8VRQaVHrS6TYy/xMmRlhVLu+1UOA5Wyrlam2HuLe7ZVhJy3XZuWNQLCVZ6sd
 N8342u9QGvUCATGHf71TmdfEEiC52XG529PTBBDW3Wbz6ZtAiXfJkH/aGOu8zouNHWmj
 cy8U4ZYnpHE/ZflZj7Sv0X9HOcq8RWCxosuAIiBEODCcz4mpi1C1b4fT5Qvxn9ZyTUFX
 L6ERSer1EmVBEe99Xim5wuQxfBzvMYBoB5oDVHhyIwjx0L0Kqhkfb8w+brkQTUKJmq1S
 mws2qtNtzo74xzk8Fm/PIVFOYTB+UqGptVDeNBf6WG9owYniGtErKrhrBN2ha88X6L2n
 RsjQ==
X-Gm-Message-State: AOJu0YzX0e4ppPj7j/SHx2URmO1Uxg/fApQliaPoqtaguSolgcvwqg3v
 cKRwdk7N0ELS5uSk0pS47bYZJg==
X-Google-Smtp-Source: AGHT+IG8jrpwMvX26E1id8I58Q5M2fNw5j57wVIIaXpQQeDUT5nmJy6H+OVVM8EndD0yduhf9Bzh6A==
X-Received: by 2002:a05:600c:3553:b0:40b:42e2:1c53 with SMTP id
 i19-20020a05600c355300b0040b42e21c53mr9084734wmq.13.1701277075926; 
 Wed, 29 Nov 2023 08:57:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fm24-20020a05600c0c1800b0040b3e26872dsm2929223wmb.8.2023.11.29.08.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:57:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D4B25F7AF;
 Wed, 29 Nov 2023 16:57:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell
 <peter.maydell@linaro.org>,  QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU Summit Minutes 2023
In-Reply-To: <CAJSP0QVSe6MZOS=20d9NMkJOAwsXaFF3aOOxZFkzhT-XZogG-w@mail.gmail.com>
 (Stefan Hajnoczi's message of "Wed, 29 Nov 2023 10:53:00 -0500")
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
 <CAJSP0QVzwJ8GFAaprwt6892zhxC9-uuKAk9d2cftXebFkMoVog@mail.gmail.com>
 <CAJSP0QVSe6MZOS=20d9NMkJOAwsXaFF3aOOxZFkzhT-XZogG-w@mail.gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 16:57:55 +0000
Message-ID: <877cm08pkc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> To give a picture of the state of the CI, I'd say it fails 80% of the
> time. Usually 2 or 3 of the tests fail randomly from a group of <10
> tests that commonly fail randomly.

Do you have a list anywhere?

>
> In order for the CI to be usable to submaintainers I think it should
> _pass_ at least 90% of the time.
>
> There is still some way to go but I think this goal is achievable in
> the next 2 or 3 months because the set of problematic tests is not
> that large.
>
> Stefan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

