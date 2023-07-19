Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7977595AB
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6UR-0002JM-BI; Wed, 19 Jul 2023 08:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qM6UO-0002Ir-OW
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:41:08 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qM6UK-0002dW-1j
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:41:08 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51e526e0fe4so10288036a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689770462; x=1690375262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kgINxQ44Lkn5q5s4dVRIDFjUaWTWUQSoNszyGKlnNOM=;
 b=e9c76F6xNkBjwE4+ahllYh1/QBIvWAbjBwE/qeHmWl50hW85qd5ltn2GluSJSJWrJ5
 R0Xdip6KxXWsz9s/k5QJEdS8vEquxyxyGL8uXm1vA5Jrt4jH//3ZCdyCYblTKa/4cuGN
 ALWjQqE41HRnsoD19ABPXdPY482AVc+ir243jRfSnCih16+tHJCEQYpupA2r1/f8Y5uP
 AqMGui19m05cVzNdJ6/gFPdbgCyhaazPgeA0d2z0p6vKB8ok/GASB8U+cROJfmhbPNFh
 OUfcSvHl4MeXdUPO2nmxyq3XJx0UcZDQdzSHUoSjzuNgiWOQGq+pQueAgnZRf/YiqSaw
 hwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689770462; x=1690375262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgINxQ44Lkn5q5s4dVRIDFjUaWTWUQSoNszyGKlnNOM=;
 b=UMdkO6P9GzYahcPe9ZZ2HKTU8/IlJOnTjW97q/dYrEppYFJBe2tRu/zdttH8ueJanU
 8UTD8BcHN5gRWnREXVjRWgIS0r9ujeQ0XdsSeJCdD80Gs9giAWtyF8wf2YcB/VWDTuk9
 +bJccmgN+Sk2mUzZHOTa6HT9fBINYQFOJ4qfnJKv7aS4yIPbarFriQiEUIzqQoR0xYuS
 xCcYn3ktPhh/9IPhWfas/WTPcl3F7akXRLI3P429uIW9ySIcCvssyhxQjVG1CPMer4a2
 Kyue0BRpC0C4xY+u4GbMSEPbMr65SBiKl6qzn2gPV/zDdM/gLqwVKxu29dX58VUPuPGe
 oC/w==
X-Gm-Message-State: ABy/qLZVcfJIHJHTA4zHvpp7exjE1kd3HDuE2t4qHrriAuWeLGyOGzIT
 DavNpsrvNMqrzo3K4fcVKMGI0u8qA58FJhRxhlJUbA==
X-Google-Smtp-Source: APBJJlFT3//33FeSjHI0JQ0yyQMIT2oiwnZSLkZNhwzEzfWG94hjVCX41mWapyQCFFTjI2h1pf8HMvoTtDJTVVJJ+a0=
X-Received: by 2002:aa7:d791:0:b0:51e:24fd:d34d with SMTP id
 s17-20020aa7d791000000b0051e24fdd34dmr2425311edq.20.1689770461690; Wed, 19
 Jul 2023 05:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230718093040.172145-1-thuth@redhat.com>
In-Reply-To: <20230718093040.172145-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2023 13:40:50 +0100
Message-ID: <CAFEAcA_AkKFnTCHEe+3Ah6sLrOdcuLOS+WtYV8RkQhA6z=T-yg@mail.gmail.com>
Subject: Re: [PULL 0/8] s390x, qtest and misc patches for QEMU 8.1 rc1
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 18 Jul 2023 at 10:31, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2023-07-18
>
> for you to fetch changes up to a5754847e0fc2bc08a414dd381803009e8bca390:
>
>   tests/avocado: Disable the test_sbsaref_edk2_firmware by default (2023-07-18 11:22:51 +0200)
>
> ----------------------------------------------------------------
> * Fix s390x KVM guests when compiling with --without-default-devices
> * Fix /proc/cpuinfo features list in s390x linux-user emulation
> * Generate FreeBSD VM package list via lcitool
> * Disable the flaky test_sbsaref_edk2_firmware avocado test by default
>



Applied to target-arm.next, thanks.

-- PMM

