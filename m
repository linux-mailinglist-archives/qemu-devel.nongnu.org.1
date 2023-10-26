Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1457D86EC
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 18:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw3VY-0008HW-7B; Thu, 26 Oct 2023 12:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qw3VW-0008HN-5D
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:46:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qw3VU-0006a7-Ge
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:46:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso1799774a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698338811; x=1698943611; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sTnqM7eWjOxzyYr8H8S76p28Q404ADwrG3myRbF0K5M=;
 b=ke0pVvWIA2A3nIEfoXzbsVXbso7lKTI+2u7rrjHk3RUd1B2fzFHJOTacVRSQ75WtR6
 tbR3vwIX/v9crIHmX5LxZiLaOGRbrsVq39F293DQu1uUB3Bw4UoR/Uqwcm2OlG8TO6PY
 Bxqrb+ovLCqgAaVPyyaMQX6qKvDYSd0wwwhYO3MR336mz1Ilh8nPs2Xa8fy7xdQgFJ4g
 Fozq/JuMjg2PVZiUoCCM6MY5JZljZ13xcZzukPPSiVAtvIesVnxfqLSRbFUqi0scuziF
 1HD7Yss2TEYzNmax2lIDIe+nCOJUnDrBeuAdN5Xaphur0fwyO7/2tF7scXxub7XHyslR
 NykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698338811; x=1698943611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sTnqM7eWjOxzyYr8H8S76p28Q404ADwrG3myRbF0K5M=;
 b=d2O7Yz2pQb8s5zfX9p6geLMX/nfHgzXeiUi0nUbCqfGBF6M749OOTFoyB8KpND3BkY
 oidbWNWtKfCgychFW8YyGShoqVe8h7ueulHm9KZzkj6YP0OLS5pYNUwtrn/I3WmrJmAW
 WHW5SJTqwJ0Sy00egKav8dmjsllpnTOLU7RFt/prtZ1RFo9UpINIEu3cSnuxMDvqC6u+
 O1U0qACrV72nT9+356I29yHdPszkgk1LvBFtFV1MiDFDtqjSEix9NZ9CJNbikLDus/zr
 WrKHCguEZrqpH3F42x/pUzHJe7ZnofRjmhSj+XMCEUi4HxWSyOUCKZW5XN19z7Dqr0HS
 DOFw==
X-Gm-Message-State: AOJu0YxRpIFApYviSWjqrUM5HIFZXgTA066zroAc4aA8n2Fl8z5qkS1D
 zYtkIZ9yGCyXXPHaMY1lwFGzlnFmD9UXtopzqhi/LQ==
X-Google-Smtp-Source: AGHT+IHV3O2R8sjCHmetk+Q4K8yP0yz2gk7z5ZaFRN/5XaRCbPm0HmYwrhRJBJRzyh5/GYIqNAnCszIvFQ/LV7P5768=
X-Received: by 2002:a05:6402:3586:b0:53d:d879:34f3 with SMTP id
 y6-20020a056402358600b0053dd87934f3mr322103edc.1.1698338810725; Thu, 26 Oct
 2023 09:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnsOnP-8PY=pZw3n2jPKeMmiFqsQwp-Dai+dADpe+hskO2kQA@mail.gmail.com>
In-Reply-To: <CAHnsOnP-8PY=pZw3n2jPKeMmiFqsQwp-Dai+dADpe+hskO2kQA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2023 17:46:39 +0100
Message-ID: <CAFEAcA83xO3XxuWTK1vdqnH6PKaBpPfNL8A8EyBC1AaGcqhZcg@mail.gmail.com>
Subject: Re: Replace calls to functions named cpu_physical_memory_* with
 address_space_*.
To: Tanmay <tanmaynpatil105@gmail.com>
Cc: qemu-devel@nongnu.org, "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 26 Oct 2023 at 13:48, Tanmay <tanmaynpatil105@gmail.com> wrote:
> I'm really interested in contributing to qemu. I wanted to
> work on the renaming API calls cpu_physical_memory_* to
> address_space_*. I couldn't find any related issues on the
> GItlab tracker. Can I work on this issue?

You're welcome to, but be aware that this is unfortunately
one of the items in the "BiteSizedTasks" list that is
not as simple as the one-line description makes it sound.
(I have a personal project to try to go through that page and
either expand entries into issues in gitlab that describe the
task in more detail, or else delete them if they don't really
seem to be "bite sized". But I haven't got very far with it yet,
so there are still quite a few unhelpful "landmine" tasks on it.
Sorry about that :-(  )

It also is something where the right thing to do is going to
depend on the call-site and what that particular device or piece
of code is trying to do -- it is not a mechanical conversion.
(This is partly why the conversion is not yet complete.)

Most of the devices which use these functions should indeed
use address_space_* functions instead, but the question then
is "what address space should they access?". That usually ought
to be one passed into them by the board code. (commit 112a829f8f0a
is an example of that kind of conversion.) Unfortunately many
of the remaining uses of cpu_physical_memory_* in hw/ are
in very old code which hasn't even been converted to the
kind of new device model coding style that would allow you to
provide an address space by a QOM property that way. So for
those devices this would be just one of a whole pile of
"modernizations" and refactorings that need to be done.

I think what I would suggest is that rather than starting
with this task in general, that you start with what part
of QEMU you're interested in working on in particular (eg
whether you're interested in a particular target architecture
or a particular subsystem like migration, etc), and then
we can probably find some tasks that relate to that specific
interest and help in starting to understand that part of the
code. (QEMU as a whole is too big for anybody to understand
all of it...) If what you want to work on turns out to
involve one of the bits of code which needs this API upgrade,
maybe we can help you work on that; but it might turn out that
the two don't overlap at all, or that there's a better starting
task.

thanks
-- PMM

