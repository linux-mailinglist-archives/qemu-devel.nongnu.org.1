Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645382F0EE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:00:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkue-0001uH-36; Tue, 16 Jan 2024 09:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPkub-0001tk-Q2
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:59:33 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPkuY-0003M9-CG
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:59:33 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5592d1bc4fbso2652705a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417167; x=1706021967; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YrJ+VmxwgbKzw3XkqeIfss4FMWzAgprqMmIV3Uk7Gi0=;
 b=RfMLt3ksHbojJEIlbqBcNmrnu/xOWOTai3skG+Q9BJh3C8bU3Mwez14iYZdcMW7ZvZ
 gYv7VOKc+CybZmw282bQkV/cP+PYFLT4KL9+nhfMfE1qSlE5KgZzqS8syu23aTj0ECE+
 VzNQUqIOpeIiWb9LXqecGIprAxUL+qAx417ylLJr8bSCWxk9Mq9I1mM2rlxjnDg+BNgI
 KOu48jz6C9sA8O/IMk6bgkQeQTx1jqydJtVdvFvG1xAKrnh84XbesTcwlG4r+BvmA+dV
 dYDEc3eV7QY1e3DUtrBvYx42DRnSxbrQ3lqN2mf+s+85Fkr4/OMsbaWsJSqhNbv/Wp0G
 t/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417167; x=1706021967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrJ+VmxwgbKzw3XkqeIfss4FMWzAgprqMmIV3Uk7Gi0=;
 b=RPBWtKBQCqU7S6jp3skEF2eEccEaOZl7EGewK++QsVNFqDXYO9BTkF78STI++NQR/x
 jR+KLsJFTu9YTw4FXY6xLCKjKwCKRxXWxg5TrstSp8iufTjgpYoB0EEkooCyCu5Iwmln
 roaURRZ1sbQV8l2jXjWTLAR09C6hKgUWJGZWXyHq+mSXXyrOA4aMNJUFP2mWnx8OHI8X
 2lEc6H/ZzC9gqflaWKKdTjRBH9WHYsYYZd5hO2RusHep7TwT4pTCOGFN5lGIYG+Ol9qE
 Fu7koYm4S0jDjjgB5LyCcpw08b6b89HSiWaGdmk4Ti0tCRZ4pffOOqVVAOvTD4e1ykHp
 ICBw==
X-Gm-Message-State: AOJu0YzSFc/7jjGPwtbGEC7OEnSZm5xMed8Llb4+bQyNUmKWxOKsskHZ
 IdPIwSq6jwbrH4zs6hIuXa3/DsrhzZt0agUa5IL6xw/kUYAe7Q==
X-Google-Smtp-Source: AGHT+IGchrFNwkpMqLNTwcopLnsonP3/w/OkWQ9Clo/9uepTu/0PwaIRm+Lybzv2D/y1b+sTbpUVbnGcFlbyC+bYsBs=
X-Received: by 2002:a05:6402:31eb:b0:559:bdd3:80df with SMTP id
 dy11-20020a05640231eb00b00559bdd380dfmr278031edb.45.1705417167403; Tue, 16
 Jan 2024 06:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-28-peter.maydell@linaro.org>
 <20240116130940.00002523@Huawei.com>
 <CAFEAcA-94-TeFw4AmTsuQaJROADaet8aWDEBXbt9H_gc1Fs6pg@mail.gmail.com>
 <20240116145051.000004f7@Huawei.com>
In-Reply-To: <20240116145051.000004f7@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 14:59:15 +0000
Message-ID: <CAFEAcA8=CK00w_Yk-X=+6cm2X5BWSiTw7_y6uQN8qyFHF4-iFg@mail.gmail.com>
Subject: Re: [PATCH 27/35] target/arm: Report VNCR_EL2 based faults correctly
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 16 Jan 2024 at 14:50, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 16 Jan 2024 13:20:33 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Bisecting to this patch is a bit weird because at this point
> > in the series emulation of FEAT_NV2 should be disabled and
> > the code being added should never be used. You could put
> > an assert(0) into the code in translate-a64.c before the
> > call to syn_data_abort_vncr() and in arm_deliver_fault()
> > assert(!is_vncr) to confirm that we're not somehow getting
> > into this code for some non-FEAT_NV2 situation, I guess.
>
> Not that, but surprisingly is_vncr == true.
> in arm_deliver_fault()
>
> Frigging that to be false gets me up and running. I'll see
> if I can figure out why it is set.

I don't know if this is the cause, but looking again at the
line that sets is_vncr I see at least one obvious bug:

    bool is_vncr = (mmu_idx != MMU_INST_FETCH) &&
        (env->exception.syndrome & ARM_EL_VNCR);

is testing the wrong variable -- the first part
of the condition should be "access_type != MMU_INST_FETCH".

If you fix that does the failure go away ?

Yay for C and its very sloppy typing :-/

-- PMM

