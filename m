Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F26197A202B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:50:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9Cd-0004fk-6g; Fri, 15 Sep 2023 09:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh9Ca-0004fQ-Ib
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:49:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh9CZ-0002XD-3D
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:49:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52f9a45b4bdso2570292a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694785780; x=1695390580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eFEkffusovehClr8bSOhOCkCIRJsuwxhzKdW/qZm+w=;
 b=PSbbFo9eUbw/tNnRtnT5v4f90ILvBWUhsa6S7ntiLz0Tqyd9WTv4lNcUzBx2zb8+Fx
 9Fw92dY3zJA/Uy3Le0R7pRprKN358AeyijmLLxIM56FkwcVfum3g5NF2WQ3m9nnAWW1q
 weQbnr6anfxubkmLTBnpkQlPoRqGAaYilct4V5KxU0fZG+skt1nHmWazb7hPV5Tz9K4I
 87XjwQ36j3qGQD9dxjM5dsuSLffT1eBMZzqz9DD+lvEjyNe/5epL69PyT7zDxEFIWz8K
 fCKOHCXbo/CktyCApe6fUTbGgT3vNtWFlkXbQBmo4RaC6GkgAUL/ET+nkWeuPJLX2fv2
 E58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694785780; x=1695390580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eFEkffusovehClr8bSOhOCkCIRJsuwxhzKdW/qZm+w=;
 b=PSAjcy7ZqxHWOVAB7iNZyBgM2JbcN6vvy8/I5UEN1MpYstrvaYAvjRjW0r4UqpyaMw
 5Si7zVVyhly7+QkfFw2peLjbrBSPX46DysxAIuURfjkF1Cp7ydObB2yX0/KYLrTqWAcg
 Y6KQNstgtMqZj0pvj8IO/2X6zYC7Mvo0qXxZ2b3Jj5yXM4lEgnmDqLP4JoMhVKTwcWuA
 zgPNhx0B/o/pPcdnS+f7yqOm8awWhZztw0BJio+uMlXsYoLECPlSk7gFcICcgKlvX18j
 ZPgi2u6+2d2pZmjLr7lpmtWmoRiqq0C7EBJvHecid/K6lRX+jCCg3NMZr3qpvzyna3B0
 0TTg==
X-Gm-Message-State: AOJu0Yz6N0peAcMSqiOHn+ryPd6S8CWf08Bv2O2ptc0lAhmtIx0oJllp
 hHFmeYNYiffDQnoeJPcN0mUmCWCLsOoT9rZBj3hs6g==
X-Google-Smtp-Source: AGHT+IGByFoA4k+mgCvWENnEGLu5d0m/j+QpKOMyysxD9jVRlRdYOv3WEb6e6OeNwY+EM7i7vik20ZBAoADgWcafFxY=
X-Received: by 2002:a05:6402:14c8:b0:52f:bd60:b54b with SMTP id
 f8-20020a05640214c800b0052fbd60b54bmr1715538edx.37.1694785780320; Fri, 15 Sep
 2023 06:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230914175835.382972-1-tfanelli@redhat.com>
 <ZQQplEOUE2GhBL07@redhat.com>
In-Reply-To: <ZQQplEOUE2GhBL07@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2023 14:49:20 +0100
Message-ID: <CAFEAcA-DnH4oQ5kUioTiQr7COEbAqCKdkDPkBS0iJ3XUrKzOLw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tyler Fanelli <tfanelli@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 15 Sept 2023 at 10:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> My summary, is that I'd personally be in favour of opening the door
> to Rust code as a mandatory pre-requisite for QEMU, at the very least
> for system emulators. Not because this particular series is compelling,
> but because I think Rust could be more beneficial to QEMU over the long
> term than we expect. In terms of consuming it though, if we're going
> to replace existing QEMU functionality, then I think we need to bundle
> the Rust code and natively integrate it into the build system, as we
> have recently started doing with our python deps, to detach ourselves
> from the limits of what distros ship.

I'm not against this, but there is a fair amount of work here
in figuring out how exactly to integrate Rust components
into the build system, questions like what our minimum required
rust version would be, liasing with downstream distros to
check that what we're proposing isn't a nightmare for them
to package, etc.

-- PMM

