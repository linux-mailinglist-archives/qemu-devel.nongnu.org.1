Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B1C722292
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66ox-0000OB-Bw; Mon, 05 Jun 2023 05:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q66oT-0000FS-88
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:47:47 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q66oG-0005yf-MP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:47:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51456392cbbso11982192a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685958451; x=1688550451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ztVesaHbljPqzJ4I07QjLsGcRO8DfGFDx7Uq8E0uKM4=;
 b=aAIBfIx3hjioTZOev22cIYTLT73TEhHmEi9FxuVAkaS486FR68WXTBCLTShCrh6Ee6
 O0GE4bRHfTqbavxuudv5/gwb9HTP+BsWYTZE3hoJQf8BjpKEzKX6G9chHUCwYfONfibl
 77OJjHzvex/n3eehIlV3767HdOZmGt8mwTzU7C9du8J088U4ut60cGVWddr1O1jSKemY
 epbYcXS/ULeMCgNVqIF2WgSp5UaYT7gAGIi5uZgKsHkZ/zqsgxpxwNlm0eHQzIUzIKpe
 4gok+sN6LSr5dh+ZayqOF2pU3nvcpDj3gF4loQpsAo7FjcNoVVPJZXgGjmqhVgxZSrKK
 xFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958451; x=1688550451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ztVesaHbljPqzJ4I07QjLsGcRO8DfGFDx7Uq8E0uKM4=;
 b=MNaT7yPAPBBEtdjsRKaqVo3SOMWKxKiYYP8uRvKdWUeJ8edV+2oJByTX7oPC0fULfJ
 ECZ2LLOVKZJbiYSr72/kwLzTL6C1AU9E2WmMvnF+kRafZakgW3mZR1IZAismZ4oTeuJy
 ZGo8SUhr0Z4gXXYYMJbwN6I0WrNhKw1M+7R+XZw6XJRHFZwal3wgVHXW2uHnBkF7gz68
 w0/BRRxC0aixX0XWSCR/4uGik8Hjsf6zxMW/X9+/s1ginG1dKrXtBg6gW8mzn/Z5qjp5
 13ZroTHJG/tzIJoyeea7FUKqXhf0wRXIGU18Pm79VHq7DPwlXV+kFpmocxVHy/h8/y6s
 gCcA==
X-Gm-Message-State: AC+VfDyrUQfhh4tDhXHWCIZWPHdhFk6AoJVXjEnTLPeoStqT75NPL/CO
 xfLL7wIiQVwV+J7Fl21DeTRSWE0iFWPWK90y5ixSxg==
X-Google-Smtp-Source: ACHHUZ5RE6aKkOA9tGGYaEXIizxaBQaBMxvO34QXyM/HXi8/oKdRN1K71XC5HYwSLN1U/2h5Vzw6Hm6IL/gJBsuzBMA=
X-Received: by 2002:a05:6402:1d50:b0:506:bbf8:5152 with SMTP id
 dz16-20020a0564021d5000b00506bbf85152mr10262927edb.9.1685958450814; Mon, 05
 Jun 2023 02:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230605075823.48871-1-pbonzini@redhat.com>
In-Reply-To: <20230605075823.48871-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 10:46:57 +0100
Message-ID: <CAFEAcA8fRWdFMrcy6G6yT-8320UZUf6QA9XO70f7P1ssraedRQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix venv issues with Avocado by reverting to an older
 version
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, alex.bennee@linaro.org, 
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 5 Jun 2023 at 08:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Bumping avocado to version 101 has two issues.  First, there are problems
> where Avocado is not logging of command lines or terminal output, and not
> collecting Python logs outside the avocado namespace.
>
> Second, the recent changes to Python handling mean that there is a single
> virtual environment for all the build, instead of a separate one for testing.
> Requiring a too-new version of avocado causes conflicts with any avocado
> plugins installed on the host:
>
>    $ make check-venv
>    make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
>      GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/berkeley-softfloat-3 dtc
>      VENVPIP install -e /home/berrange/src/virt/qemu/python/
>      VENVPIP install -r /home/berrange/src/virt/qemu/tests/requirements.txt
>    ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
>    avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
>    avocado-framework-plugin-result-html 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
>    make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'
>
> To avoid this issue, tests/requirements.txt should use a ">=" constraint
> and the version of Avocado should be limited to what distros provide
> in the system packages.  Only Fedora has Avocado, and more specifically
> version 92.0.  For now, this series reverts to the older requirement
> (version >=88.1) while leaving further version bumps to future changes.

If the new Avocado version is broken, don't we also need a < constraint
so we don't get it by mistake ?

In particular, for a local build tree that currently has 101 installed,
if the tree is updated to include these two patches together, will that
correctly downgrade it to 88.1?

thanks
-- PMM

