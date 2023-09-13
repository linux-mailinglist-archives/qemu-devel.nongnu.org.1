Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4679EA7B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQYf-0006jH-Pt; Wed, 13 Sep 2023 10:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgQYc-0006iz-LY
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:09:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgQYQ-0005bv-5V
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:09:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401b5516104so72706945e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694614156; x=1695218956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+oHYeZ5w/0utonHdtAx668dVBi2xt+ZurD0nzQPPz0=;
 b=eaERk302wHJKA5Dn/oqZq5hYKdS6lknr5CdB0urqjtZwWVVNnBtKrMAmnUgYHZI2JV
 Tc2uRoW2QuGIpHU9PkdfP6tumAufLDeCQg/VLKBuZY7Ze3oRBLffZwhbsoHWKNm6bpgD
 wfetn8oHzprJW/l8P7qmubWmRLKTGYpe7gPceBUx43hwVI+9vR6PMe3O3RjYYhwEmi1H
 OHHFWrynkozHkqTf7mGU8s/EbuuCJ+t1ddLM9/Havl5Uu4F5HwwaFwTrlG1ekwm5+EFQ
 9AUtIxCEq41yHN1ywdeo7VxHf20y/kcRyVVwyFf7CfpbACiseWbLpY4g+POWVtnts5wY
 favw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694614156; x=1695218956;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y+oHYeZ5w/0utonHdtAx668dVBi2xt+ZurD0nzQPPz0=;
 b=BgYJ17Lno1BZRIvkk77+oiak9OwBFfvd3LGRfXoQNXBfV1D7rPnqe2fgm9eU0Iu2Wv
 isbJrE0fr7e6hDOuvTcoXgSUgzX/H+307ae2AZMIGZzD6KTRXZw14XgA4i5RwOvA2Prc
 vqH1BDXFH/3LvZzUkBkdCdB4JSuR7cuaVSe5qdG1fJR/CERoWASHYtKCIRM6pPB7D46q
 kTuM+jiQHhTMT+jpVvLMlf73ihVPIJyHzXrtkYXArOr0YHh/0us54OjF/FM01620enD7
 c41EfvBzXYK2goky88PtzSYKo370U84g103FoW6mq/J7w03wTKQ48dbaw/14xkxSRU0J
 0OJQ==
X-Gm-Message-State: AOJu0YwSJNQtQjXS+MNgVDsO5+T/X1pCQu3mJnUcW4Wv1fw/UB0F0s91
 laImyL2HPRGNQT+x/0BUGK+MXw==
X-Google-Smtp-Source: AGHT+IFcO8wwhMSorbNfIwKNW4sx5xVPNWNXWydIlWzPoxF9V8pVN/Jku2bjStDgckkP5vZ7NKXPwQ==
X-Received: by 2002:a05:600c:b4e:b0:400:f6f2:66b9 with SMTP id
 k14-20020a05600c0b4e00b00400f6f266b9mr2167689wmr.12.1694614156145; 
 Wed, 13 Sep 2023 07:09:16 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y11-20020adfd08b000000b003140fff4f75sm15486054wrh.17.2023.09.13.07.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 07:09:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 207431FFBB;
 Wed, 13 Sep 2023 15:09:15 +0100 (BST)
References: <20230913135339.9128-1-philmd@linaro.org>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Beraldo Leal <bleal@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] tests/avocado: Disable MIPS Malta tests due to GitLab
 issue #1884
Date: Wed, 13 Sep 2023 15:09:06 +0100
In-reply-to: <20230913135339.9128-1-philmd@linaro.org>
Message-ID: <87zg1qrwqc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Commit 0d58c66068 ("softmmu: Use async_run_on_cpu in tcg_commit")
> introduced a regression which is only triggered by the MIPS Malta
> machine. Since those tests are gatting and disturb the CI workflow,
> disable them until https://gitlab.com/qemu-project/qemu/-/issues/1866
> is fixed.

Queued to testing/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

