Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECBE7BE1C4
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqhy-0002KH-6o; Mon, 09 Oct 2023 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpqhw-0002Jf-Dc
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:54:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpqhu-000361-US
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:54:04 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so2647351f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696859641; x=1697464441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93P4wrt8Sqzr65tCG6kDPp9nrZuI4UR3Orj0wdhmH6k=;
 b=xH96V3Trhso90K5vSGbcRhq4dKStxyu8cPv1u4Mn0U02Oj7ddUu+TTIItTAs2ZHVwx
 gIiFPV1n09BA3F5q0UP8M9IlhrX1VnZlzHnZm8uoP4CwnqO0QRBDARvn/hGlpgMQZoRq
 xWRr2MfJ/CzK4I8bQ9xRHpedrT4M52mOOwmlBnIYu7mPxqMyyACm7ttYLf25DZjHYIga
 gZz7mX+zlnl85Gd1kluZwL0G+MYhoh2fMM0qsOGsN2P/Yt9R0XbKfmb5qbdeEVdiLTvC
 +0ZAtfEtwBXTXSgNUlsESGJHGp/3ddnTE3Mpg01dR0ZONZOWj1m5Fyu/B1d8gLFMHpjs
 jXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696859641; x=1697464441;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=93P4wrt8Sqzr65tCG6kDPp9nrZuI4UR3Orj0wdhmH6k=;
 b=jFDqcKrgajMUN5sCaKGRqQQB01czlIyNQRi6SIoUV7O2c+y0KwsQPnHWcIN3O2u9+z
 v90z+6E01FrZ7ACp7mPIpQK7bnSzvjAlO/0No4NaUsR4fTjFq/QPVi5cLLWP91vTvwYF
 zVN+k6or55EETMeoyMOSRthAvZ8OGSn0sdNGFd3QQ85HbV25lEGKZoB8yOWA2NWO3Fcf
 k2XUS0yISYJ3KU+wYeTszbhhYi3eADI684cmrrCP3XlpEq6Cd6xOb99DVlXL+igoJYNF
 nSGbCq1C52S0t+LDNCFos3Ni4aorb/m1mHnN5yzC4iWJ9jhhFdTFohnJoSdUd9HN4Ckk
 9QMg==
X-Gm-Message-State: AOJu0YzjwNHn1bD+t/vgg3B1qAiod+DynbtjIjbDrMMaDdV1C9B5O5fZ
 ZEIux/Yxq4yeJzkNrD0Z1CBluA==
X-Google-Smtp-Source: AGHT+IG7rgudlqiII+aKCtM+PP1BvfVyBY5nwOzZDGpgVOEOdVcMTz9Wfodf08f4gCEyJzw31wn/aw==
X-Received: by 2002:a5d:6a8e:0:b0:323:36f1:c256 with SMTP id
 s14-20020a5d6a8e000000b0032336f1c256mr13466018wru.11.1696859641214; 
 Mon, 09 Oct 2023 06:54:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b003232d122dbfsm9791415wrm.66.2023.10.09.06.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 06:54:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 58B021FFBB;
 Mon,  9 Oct 2023 14:54:00 +0100 (BST)
References: <20230927120050.210187-1-marcin.juszkiewicz@linaro.org>
 <20230927120050.210187-2-marcin.juszkiewicz@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Beraldo Leal
 <bleal@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Peter Maydell
 <peter.maydell@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Cleber Rosa
 <crosa@redhat.com>
Subject: Re: [PATCH v2 1/1] tests/avocado: update firmware to enable OpenBSD
 test on sbsa-ref
Date: Mon, 09 Oct 2023 14:53:37 +0100
In-reply-to: <20230927120050.210187-2-marcin.juszkiewicz@linaro.org>
Message-ID: <87ttqzq4uf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:

> Update prebuilt firmware images:
> - Neoverse V1/N2 cpu support
> - non-secure EL2 virtual timer
> - XHCI controller in DSDT
>
> With those changes we can now run OpenBSD as part of sbsa-ref tests.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Queued to maintainer/october-omnibus, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

