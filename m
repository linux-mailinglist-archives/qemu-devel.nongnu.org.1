Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB1A73FF70
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:15:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAOh-0003It-B9; Tue, 27 Jun 2023 11:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEAOe-0003EA-Rv
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:14:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEAOV-00058m-DK
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:14:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fa9850bfd9so22823275e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687878853; x=1690470853;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RyMnAjjBSSOq3zaTdvT972DJCcOcquWn/+qjsJsWNU=;
 b=jY+MrflDodJ5iCExLF5jEzXFBNDtiensxy8gsQZSCl5vUmcMyKYahWjIk0eOykjc5v
 tNcucAslRMvAU2KA66kuSDQtzdG5UnZQfRKQpkpAWLrn9P8OGH41oYAQ0MysGOsZHbI8
 miMpmb84nG9x2RJhEur9gd+5+Es+rW6h7L4AkHBxlJOxdKnH9gvoDCG0XYIgVPcaYl15
 fXPMJNJx04qMgZYn91SasnETwqrlYy09UXGrf+fMYrsP3Hf6foskNlcWBrTmiW09GTyd
 rkw+sX69n3wxqsBhhW2a0qpHt+lU0g+6n3jQlEsegNVtJLyFZ70XHILlszNebkE+V6Tc
 KoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687878853; x=1690470853;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7RyMnAjjBSSOq3zaTdvT972DJCcOcquWn/+qjsJsWNU=;
 b=Z8TZU3dLibWcQz6sIJEP19XYQ43o8gHA3biKRUnlIOPG3U3u4qJ4zMseAji84Fn8iR
 GTISJ35xgGLhnAs9BeYLPco6cQLxwnr9olu3D98MPvXveCIfjzomagb+7rfUtzrfdTHt
 0Xo4+U+sA5Nrl/pmpQVS+AvnExxgA2h0PZIwxWUNQ04s/p1Cxh5R9OJchIQNzdysPpkO
 AlFPxtoi2Luitfa4bqXQEFf/F8YSfIrWitc4gOM4HMuUTpXJldpczA9CXGZBanSkPo22
 WXGpCT7PGLuK9ng+SiHUmE9LE5SXV0IukmlnusAhd2zLQkIzBWk7eZBrWl5dyedycwO3
 ewsw==
X-Gm-Message-State: AC+VfDyNGDeF1rcpEyD2dipN1DYMwER+vg8OsEvRktC6G64+1L+VgZV1
 6kEgCjP7Z68x7HabDXRrZ100jg==
X-Google-Smtp-Source: ACHHUZ5+t9nRUwpOJCcnGV46wvX95Rs5MyD4JyYJXJO1uJq7lQbVKVCGfmycsDaOthezRHqF0Tm6Og==
X-Received: by 2002:a7b:c456:0:b0:3fa:7b1b:4adc with SMTP id
 l22-20020a7bc456000000b003fa7b1b4adcmr8174172wmi.39.1687878853059; 
 Tue, 27 Jun 2023 08:14:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a7bc398000000b003fb9ebb6b88sm2749606wmj.39.2023.06.27.08.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 08:14:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39A1E1FFBB;
 Tue, 27 Jun 2023 16:14:12 +0100 (BST)
References: <20230621203627.1808446-1-iii@linux.ibm.com>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH v4 0/8] gdbstub: Add support for info proc mappings
Date: Tue, 27 Jun 2023 16:14:01 +0100
In-reply-to: <20230621203627.1808446-1-iii@linux.ibm.com>
Message-ID: <87h6qtym2j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


Ilya Leoshkevich <iii@linux.ibm.com> writes:

> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01311.html
> v3 -> v4: Fix the 32-bit build (Alex).
>           Enable the test on all architectures and ignore certain
>           expected failures (Alex). I tried this with the latest
>           gdb-multiarch and it works. The only skip is on x86_64,
>           as expected.
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06837.html
> v2 -> v3: Use openat() instead of safe_openat() (new patch: 2/8).
>           Add /proc/self/smaps emulation (new patch: 3/8).
>           With these 2 changes, the minor issues previously mentioned in
>           the patch 6/8 are gone.
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02614.html
> v1 -> v2: Reword the 5/6 commit message (Dominik).
>           Add R-bs.
>           Patches that need review:
>           4/6 gdbstub: Add support for info proc mappings
>           6/6 tests/tcg: Add a test for info proc mappings
>
> Hi,
>
> this series partially implements the Host I/O feature of the GDB Remote
> Serial Protocol in order to make generate-core-file work with qemu-user.
> It borrows heavily from the abandoned patch by Dominik [1], hence 4/6
> carries the respective Co-developed-by: tag. I also peeked at
> gdbserver/hostio.cc quite a few times.

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

