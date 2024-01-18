Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6CF8319DC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:02:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQS1B-0006gF-PP; Thu, 18 Jan 2024 08:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQS0r-0006Xw-3k
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 08:00:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQS0p-0003LX-Gn
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 08:00:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so135653945e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705582850; x=1706187650; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mDqZwb3UEO+RXGZ+g4OR8B9MVa8ldm+T6m/dWc0XCXc=;
 b=bc5FXvlVcvvraYybZwplfn85tfC5Cnv6UGp/ooQaMTH18VBKjPvW8zUboMVPoQcumJ
 NpBizpx51gIrEyiWUbaOY1hthmrUVS/bkW5CctXD/ykUZ3Bx5lIWBymxVVJ5WBIV2CZS
 RdOUqaanj+ZFVECpnprLwi2TXgQDxt+HRTwI8Nk2U1fMoXaCejQYJgsiPxW3wNxwhssK
 ZVwF5Q2zC9hz7Pi/4UoX3xu3DNmITQrdsR8vc/a8mA5Ui45pSSMGH9AfQvra6ltc0VoB
 btbMl6C1m5YC/8Fuxe8klHivLQvq1nXpB1DEeXttKbRxBYVQS1kSPaexRBS6IGoYiKop
 IpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705582850; x=1706187650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mDqZwb3UEO+RXGZ+g4OR8B9MVa8ldm+T6m/dWc0XCXc=;
 b=oZ9q7F68r2FF0tP3rYCHho3PSxh5sTlr49zQuXBekWo5EG56T4KbI5au+r4p4pCcXk
 3i9VgPg2LBI5EwcZKaVK+bOrogxcec3Yvtd1Rf+uzukNBtOotuupjezcj9hBhWrAS24r
 /UbjmCDng07EwRWdx0tf2v27w/N6+DUhb5kkOsLFKCKQgHRN5LnlJkkmBlg2NJ3w+c7S
 5uH+2Ps6pNWJNWUpi7bhRR5jZx1acIReuKXmeh2xdVoG4lBWrE783so+yY68wNPU3gSA
 UNC6ZSBlGULvfhsyDnjsmL4P53toTFsNxFJP1eFK/5x7Y/1eAFSgoSM5TDLLF1+t2e1/
 VzVg==
X-Gm-Message-State: AOJu0YyzdrCtpxW2IOQoCVo/bcm1Hxzdk7sA1GXgS0lqPvsdPe4jCuGx
 rdgOrDqP3h4DyCzrbVQ7UUg2KoNZD/+8rTjFLkPJ7zvgKFeXITEMA6wY7MkndhHO0CpmF50PtQd
 rZCHZcMFk2DmvqJs6MQJK7jLi5A0K569RlR1Ryw==
X-Google-Smtp-Source: AGHT+IFNgnMuJY4Ym9aLe71f3v+fX4Ws2k2UP9S45tTTikpmNda7qzola+CCSS3gp44j8BCUwF4/5NbYbeWaQkjsaRM=
X-Received: by 2002:a05:600c:4313:b0:40d:94da:ff40 with SMTP id
 p19-20020a05600c431300b0040d94daff40mr316737wme.195.1705582849724; Thu, 18
 Jan 2024 05:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
 <20240111110505.1563291-9-peter.maydell@linaro.org> <877ck7d56n.fsf@suse.de>
 <CAFEAcA-FW-CZga48B-id=uxmxjF7_rZiO+2jJRsZmT9or+_77g@mail.gmail.com>
 <87wms6er3e.fsf@suse.de>
In-Reply-To: <87wms6er3e.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 13:00:38 +0000
Message-ID: <CAFEAcA_ybiFZVFjqgK8t35UTJ5awT+C9n64fGN3ip11NfWBQSQ@mail.gmail.com>
Subject: Re: [PULL 08/41] target/arm: Set CTR_EL0.{IDC,DIC} for the 'max' CPU
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

On Thu, 18 Jan 2024 at 12:58, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Wed, 17 Jan 2024 at 21:24, Fabiano Rosas <farosas@suse.de> wrote:
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> > The "max" CPU is a moving target, so you shouldn't expect
> > to be able to migrate across QEMU versions using it:
> > it can have different features and thus different ID
> > register values between versions (as well as potentially
> > different actual-register-state if the added feature adds
> > new state).
>
> We're adding a test for migrating across QEMU versions to stop these
> sort of breakages happening. If 'max' is not suitable for that scenario,
> would there be another cpu you recommend to use? Otherwise aarch64 will
> have to remain uncovered for migration across QEMU versions.
>
> There's no clear statement on what kinds of combinations we support for
> migration, but anything that's actually tested is more likely to be
> considered supported.

Any fixed defined CPU is a reasonable choice. I suggest neoverse-n1.

I don't think 'max' is expected to migrate cross-version on
any CPU architecture; this isn't Arm-specific.

thanks
-- PMM

