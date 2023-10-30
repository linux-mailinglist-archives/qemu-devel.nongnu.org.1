Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB67DB705
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:59:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxP2C-0003uK-Ui; Mon, 30 Oct 2023 05:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxP2B-0003u0-PN
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:58:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxP2A-0001gf-66
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:58:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so6760566a12.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698659887; x=1699264687; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kjiqMpBbuo18cY+BKm3RZowLigXwjatDzWQIVgU/F3E=;
 b=dindWcgawCUPE9i/8masgHsNZhi5PhtDDt9vfkfZfHhRDPEERx6l81H1c9owWJaI2v
 /+nwWL8YucnObKcFb6LDOt1Ulzs+xmHJWOac9THZRm3yg8qxvtSUixCtHmHw9UyyrOCZ
 rp06J84T4kYNVIpcW4VNSIF9/zreQLlQaOeTpIwE7U3ZNU1qMnrkFjz/IqIlrG3sY0ye
 F0JCd3e24aSGxR4PZMgRpfgYNg+azMG099dNTLtxsrb59N1xG1EoYkOZs1WOX8cO0A/a
 clvqLz1uM8iWQ4QoyxpVZlDoPX6kqdYvZATzktaYwqHDfoVtNJxbnQ7j3EW5A3RC0dWT
 mD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698659887; x=1699264687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjiqMpBbuo18cY+BKm3RZowLigXwjatDzWQIVgU/F3E=;
 b=DYa7KeFSPofid30hiQbq4kcO+XEipWavPgheeZjEFGjX1O6eGsU7+ueWnVl8+dxvox
 twWL4EYGW8K8rGOYaDBqLc7lMtfbkXsb+utQghEYkU80X0lge39c3AOFREtVFOHxpTgD
 Ox61WJStyJloEUb3y/DRnUNkoom263AdES/6t3YD2PLTFm+UdUnom89mg/0D/yMfSQdc
 zIPtxukZg0w26Fyc8CQ+u8vujLVSSsIMswHph+pcfRRgFupf5yLa7kea+G3mJRvgPAwb
 2qJgloR8arHM/W68p9I/oMH+n2WMsQ9iZ92Mid792e3jQdSgO1htSjb03KOVdthQL8xH
 D1lw==
X-Gm-Message-State: AOJu0YxHZ6qNO0B+d9jblasMz4PKAotK6rAbu4zV2e/WxbqM4DPQVZG9
 EyCo3LAt2hF3NJvAzgVnagxkV8sDDF/eEy8585Yqyg==
X-Google-Smtp-Source: AGHT+IEBywkE572qs667feU8eZolgzZA6hIZR0MLvQyziAE5Z/kH4iLH+eUl6mAuGyMotPT4JtgfBbFjvu6CJlgIaTI=
X-Received: by 2002:a05:6402:70b:b0:53d:f072:7b0a with SMTP id
 w11-20020a056402070b00b0053df0727b0amr6863423edx.39.1698659887328; Mon, 30
 Oct 2023 02:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231017193217.1512868-1-tong.ho@amd.com>
 <20231017193217.1512868-4-tong.ho@amd.com>
 <CAFEAcA_yCEtDkW6R43LGNjWGH323HuSWPFibgaRSZ=+DqfrZ_g@mail.gmail.com>
 <BL0PR12MB48827D764A414B476C261C45E6A1A@BL0PR12MB4882.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB48827D764A414B476C261C45E6A1A@BL0PR12MB4882.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2023 09:57:56 +0000
Message-ID: <CAFEAcA9P2en-D4jam1VXMu_8E-w-OiKDPGvBRZHAb_buNBo5bw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tests/qtest: Introduce tests for AMD/Xilinx Versal
 TRNG device
To: "Ho, Tong" <tong.ho@amd.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair@alistair23.me" <alistair@alistair23.me>, 
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, 
 "frasse.iglesias@gmail.com" <frasse.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 30 Oct 2023 at 06:25, Ho, Tong <tong.ho@amd.com> wrote:
>
> Hi Peter,
>
> This is in regard to your comment on the use of g_usleep() in waiting for
> an event-bit update from the device under test.
>
> The TRNG device model presented in patch #1 does not have any asynchronous behavior.
>
> So, do you mean that, although the qtest process and the qemu-system-* process
> are running as 2 separate processes, qtest infrastructure already has the necessary
> mechanism to ensure that:
>
> 1. After qtest test sets a register that has the correct deterministic behavior to update an event bit,
>
> 2. The same qtest test subsequently issuing a register read will be guaranteed to observe the updated bit?

Yes. With a qtest test, there is no guest CPU inside QEMU. Instead
when the test says "write a register" there's a protocol between
the QEMU-under-test and the test process that says "write this
value to this address". Time within the simulation only advances
if the test specifically asks for it.

So if your device under test has the usual property of "we just
immediately update the state on register write" you're guarenteed
to see things on a subsequent read. If you are attempting a more
exact simulation and do things like "when this register is written
we set up a QEMU timer so that we only report the device ready
after a certain time" then your test needs to manually advance
the simulation clock with clock_step() to the point when the
device would report ready. (Usually we don't care about that
level of simulation accuracy, so clock_step() is used largely
in tests of timer devices.) Either way, this is unrelated to
wall-clock time.

thanks
-- PMM

