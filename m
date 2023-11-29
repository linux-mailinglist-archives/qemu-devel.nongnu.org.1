Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6967FDBFF
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:54:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8MsK-0008Ly-O2; Wed, 29 Nov 2023 10:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8MsG-0008LC-GZ
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:53:16 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8MsE-0002Kx-Vg
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:53:16 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-58d18c224c7so3573947eaf.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701273193; x=1701877993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HWqPIFSvSqCC0qwOaqb8JkqLD5cRd07nuSBNeIYVDV0=;
 b=B5KjWLUYV5rRZo/oEKfVsAd2WZw3hB3mUjjSJMweqEx04ToEUPsKNTmki3v6YN5AP/
 2HRavx49KK2nlcNZA2mLYyGz1f/UUSvA1bRiIaqJqeQ7zpt0M0J0TTqX7gJs6rWaMTDe
 YGE0PAYH2Lt6BP8dW/KEhzfYt4+zANb3GXfg+Zf646hmtdpzIrtcyYpzEt9Zz9MMnKPN
 ObKpwjke9q+pYdUVERN8qrPZ13S7dFPiGaWHXIbO0r8kv5YMs+PGcajTCaonJDllnYNJ
 R9E92GBztaTN8USQCULoFzJVgP4V67WJ3pIi9z3CoF8wovpaIkd/XoJievpamO6pFKLi
 sDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701273193; x=1701877993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HWqPIFSvSqCC0qwOaqb8JkqLD5cRd07nuSBNeIYVDV0=;
 b=IujrfMxIj+XVZplScTczmLJHmXaNEsDIWroYKGCAddXKNBGQAO+Rl+/joYf85RGHaE
 euknnHjIicMYgye3S25SO707TADgoM+mLTCdyjnS9TyHEjn/LPshMxfT3xtBINmjL1ey
 veaWO2jp6C9sftJj7VXV1CcFKEtqSDTosKKT9wk5yOJiKbcGQSnjs9lmHd9gEHcwliAJ
 MuVrfl8bh2uGrd2XF2Kn+G5VU3U6AHvFoYCp5YcRxwKYZIH9A1bq3ErjwueWVXAfWKej
 e24aKN72BAiDZPZMu+hhWReMSUL6ISdJT2Dp99DgfFe0fLjeqBbUR22Q/k4czs/rwJfO
 9MiA==
X-Gm-Message-State: AOJu0Yyufrb9BwZ7NOa0gyXP9tzyisRwz2bMKfySOcJcTrHJqIDL4c7C
 npn98rCLrpQqs90toG0rG1nOTwQ/gOy5tndS2Rs=
X-Google-Smtp-Source: AGHT+IHWwZZBq3uAoPjEsP86VsHX1Uh2r290hDKXuuPldAgesZUzqNCibMrJOVKi3kKlFJaHH6VQ5/tt0wg6JeJfmrM=
X-Received: by 2002:a05:6820:1ca5:b0:589:d6c7:8573 with SMTP id
 ct37-20020a0568201ca500b00589d6c78573mr23554548oob.3.1701273192575; Wed, 29
 Nov 2023 07:53:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
 <CAJSP0QVzwJ8GFAaprwt6892zhxC9-uuKAk9d2cftXebFkMoVog@mail.gmail.com>
In-Reply-To: <CAJSP0QVzwJ8GFAaprwt6892zhxC9-uuKAk9d2cftXebFkMoVog@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 29 Nov 2023 10:53:00 -0500
Message-ID: <CAJSP0QVSe6MZOS=20d9NMkJOAwsXaFF3aOOxZFkzhT-XZogG-w@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

To give a picture of the state of the CI, I'd say it fails 80% of the
time. Usually 2 or 3 of the tests fail randomly from a group of <10
tests that commonly fail randomly.

In order for the CI to be usable to submaintainers I think it should
_pass_ at least 90% of the time.

There is still some way to go but I think this goal is achievable in
the next 2 or 3 months because the set of problematic tests is not
that large.

Stefan

