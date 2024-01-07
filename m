Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5A18264AD
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 16:24:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMUz1-00072M-7x; Sun, 07 Jan 2024 10:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMUyz-000726-I4
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 10:22:37 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMUyy-0005X0-0o
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 10:22:37 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-557ad92cabbso146321a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704640954; x=1705245754; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UIdnjnI8BPcVjdkMDC1cdE6XJzt6wpy67pWVTElYz/o=;
 b=PA+BohD8YUULVbG6FRgGhoG8pw76rVF7G0YiwJc64HmDqfuIcTJ340H0BzdJn7fRiW
 7yf6+lMASfBqoz3OEzO0KWbZl7g9eaw99lrTqEhtuUYuYKMDGK+8rqVOxTt6bHL1AP7b
 GeEUlVayH6enhUyhuP4DYJSTZpSWPRmnf3Av9r0TMLXw9LeIlHtBGixjMJKjxV7VhtTy
 vRDTAB0YUcUUei8sMDjtuWNRj819xXV6vzJT6ErIvrv07SaMN8HBC94r8SRTGip05qX9
 QcOiLQGYNMZ4qVw+2A5Qh21eoqHUi4OIgyKORiP6dv+PhmPFho6Qia/Ui5XEYtKB9Z8R
 zMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704640954; x=1705245754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIdnjnI8BPcVjdkMDC1cdE6XJzt6wpy67pWVTElYz/o=;
 b=V/LPhztCW1f+Ll/hIdhyj/BUIJ17no/0NvR3jpcoM3b3ADqeotVRk403nkb73iya/w
 PklbNGu2XKRJI2xWQyBDuc6eTrxg4EQbyPwbVYJAb684nboHKYr0z8RnYQm4hSQCpAr/
 Gc5rx8DvRVQCrod9fB1SG2D5YcjRJ/By9MSl0ehhc5Cl9ppVKOF4CDrfcykACEWPwofp
 eiWuX25AaGFxWXBY65wqxnCShnGRXbgmNDNbWTr6Zx6yeRQvxgtUtShetehscfOkaKop
 oGjH6Hxxv0EzSZwUWBvd8NyNWQM1vvgjizK95K7+f9BDUHBXsrb3klDI+osBJFOWJV8O
 A/nA==
X-Gm-Message-State: AOJu0Yx6U+SlLmD3pfsZ5EXbgi1k/b2EFWoI/RGOXDvsv5w0FM4zoCMT
 SnuYJ9UeXAKNUdyhN4O/BtiI+1t/l7I2jFA872H3+vfMb0HDRQ==
X-Google-Smtp-Source: AGHT+IHmwq9gYIEyyT74GJJXQLIz9S4sHygYnl7UlZWKdXT//CYH/SBk3voK2eHv5XPI2afv/Kv+/mBs6HhSArfvbPk=
X-Received: by 2002:a50:d6c8:0:b0:556:adb2:90a1 with SMTP id
 l8-20020a50d6c8000000b00556adb290a1mr1008701edj.3.1704640953867; Sun, 07 Jan
 2024 07:22:33 -0800 (PST)
MIME-Version: 1.0
References: <ZZpQZ77s2t81mXIT@p100>
In-Reply-To: <ZZpQZ77s2t81mXIT@p100>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Jan 2024 15:22:00 +0000
Message-ID: <CAFEAcA9K4GVcYNe2YvtDxiXC-HBvAXEZzNMA-z9xkpNY4Qf2EQ@mail.gmail.com>
Subject: Re: [PATCH] tcg/tci: Fix TCI on hppa host and update TCI test matrix
To: Helge Deller <deller@kernel.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sun, 7 Jan 2024 at 07:20, Helge Deller <deller@kernel.org> wrote:
>
> Update the TCI interpreter test matrix for big-endian hosts with
> big- (hppa, hppa64) and little-endian (x86,x96-64) targets.
> I used native ppc64 and hppa hosts for those tests.
>
> Starting TCI on a hppa host crashed immediately, because hppa is
> the only archive left where the stack grows upwards.
> Write-protecting the stack guard page at the top of the stack
> fixes the crash.

We deliberately dropped support for HPPA hosts, under
commit a1eaa6281f8b and commit b1cef6d02f84bd8.
Do we really care enough about trying to run on these
ancient host CPUs to want to bring it back?

My personal rule of thumb is that if a host CPU is supported
only by TCI then we are better off saying it is entirely
unsupported -- in practice the performance will be so
terrible as to not be something anybody will want to use,
especially for older architectures which are slow to
start with.

thanks
-- PMM

