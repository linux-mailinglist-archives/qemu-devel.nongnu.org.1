Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F63712DE7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 21:51:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2dS8-0004br-Ql; Fri, 26 May 2023 15:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2dS1-0004bX-Ax
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:50:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2dRy-0007uN-RT
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:50:12 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-50bcb229adaso1873584a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685130609; x=1687722609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvtOWHZurDXKB52c+RiPUFbI8HU/3qwo/WkBKGphoIM=;
 b=U+/NrP4RrOqcDkVu7WjACCbMVVZWhcrCVWw+6Lte+GwqkKAKBybRQy6FZwiocsMvIT
 zpQzBFchHxsSUGhDKn0oAPo97z+OMDsPWfVZLU/x6gQgjP7BYAjkovlmm0o9NTPP0e3o
 jGTNyzVfnxk3lT7KRaQ+i0rYsv9L2L4IuAw5kkZzES5KTDaQOuGZsxEaeldnJuyAvhev
 ZIY/1wlFWEuk9c1viY8zF7o/u4A9ypRS3r8mRoB9e7EzDMwCY8cnQ8JHKrPTAA2+8bkW
 pexOsr4KCeGkRb3WG2XJHpwgNGGS/xvnDoyeP489DbNnxxUPqvdqxl4osoHELM0JTFpJ
 Xp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685130609; x=1687722609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvtOWHZurDXKB52c+RiPUFbI8HU/3qwo/WkBKGphoIM=;
 b=XyiPxDu8Kf83JFNzjXtf7FIyeKrJKJZvBpbRB5alSlGKHfueGjb98dpXZY6bJ9U/D1
 UsW4+rSnJyL72bHUtc3LqrlRry3p2zBlq5l3zvLSEPQaGIs4AGwqLXlcvnCM0JuQ4cU6
 TsEypobSQT/rspXIejg6GP7/eLd1QFe2kCjifrGP+SxkbajTD8cKeQGaUxItRXf5T+5N
 1mx5eU/lJpPgBuapS5jIXJWYhfxOnWcLXAmhJROInUYRpZK6zh7NvARIIGC4vssbLysN
 SqaVGWx6gXuNaPm8lyjtWpQoMSFHof1yaTDLNF5JXXJJSimi1HNBLXg2pkozzln1FT10
 5q+w==
X-Gm-Message-State: AC+VfDwmL4TZ50qBlAPf/t3YvhuE1pk5Tt4r9NgcCWdZl/ziSodiDpBV
 jyLWOK3/GNJQ8UTVj4j6uJSS6BZ5y1tSxGu3aevyGCAE2ECj5EAL
X-Google-Smtp-Source: ACHHUZ7bq3FqGiGMf3/FS50sjSRJVgftX+QjTdpwGEe/KDrWQhYxNYDRjMeivIPt3ORbx3w+7jF3ljN05nDrx9Kmfnc=
X-Received: by 2002:a50:e708:0:b0:510:d889:88cd with SMTP id
 a8-20020a50e708000000b00510d88988cdmr2083821edn.1.1685130609451; Fri, 26 May
 2023 12:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-7-peter.maydell@linaro.org>
 <CAFEAcA-5DvFB1JiCwj1Gb7WUST4-OAyJ8nYDQax_msFZuFNhnQ@mail.gmail.com>
 <aed8ee53-9482-8932-d2e8-d3b520de809f@linaro.org>
In-Reply-To: <aed8ee53-9482-8932-d2e8-d3b520de809f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 May 2023 20:49:41 +0100
Message-ID: <CAFEAcA-3kxCQHQFfUCS7YWVXfaFbN1bPTm1qfHzyKtAS1iyJgg@mail.gmail.com>
Subject: Re: [PATCH 6/6] tests/decode: Add tests for various named-field cases
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 26 May 2023 at 18:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/24/23 03:26, Peter Maydell wrote:
> > On Tue, 23 May 2023 at 13:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >> Add some tests for various cases of named-field use, both ones that
> >> should work and ones that should be diagnosed as errors.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >>   tests/decode/err_field1.decode       |  2 +-
> >>   tests/decode/err_field10.decode      |  7 +++++++
> >>   tests/decode/err_field7.decode       |  7 +++++++
> >>   tests/decode/err_field8.decode       |  8 ++++++++
> >>   tests/decode/err_field9.decode       | 14 ++++++++++++++
> >>   tests/decode/succ_named_field.decode | 19 +++++++++++++++++++
> >>   6 files changed, 56 insertions(+), 1 deletion(-)
> >>   create mode 100644 tests/decode/err_field10.decode
> >>   create mode 100644 tests/decode/err_field7.decode
> >>   create mode 100644 tests/decode/err_field8.decode
> >>   create mode 100644 tests/decode/err_field9.decode
> >>   create mode 100644 tests/decode/succ_named_field.decode
> >>
> >> diff --git a/tests/decode/err_field1.decode b/tests/decode/err_field1.decode
> >> index e07a5a73e0e..85c3f326d07 100644
> >> --- a/tests/decode/err_field1.decode
> >> +++ b/tests/decode/err_field1.decode
> >> @@ -2,4 +2,4 @@
> >>   # See the COPYING.LIB file in the top-level directory.
> >>
> >>   # Diagnose invalid field syntax
> >> -%field asdf
> >> +%field 1asdf
> >
> > I just realized that this specific change needs to go before patch 5:
> > it's updating an existing test because "asdf" used to be invalid
> > syntax and now is not. Otherwise bisection will break.
>
> Really?  The test still fails here at patch 5:
>
> /home/rth/qemu/bld/../src/tests/decode/err_field1.decode:5: error: invalid field token "asdf"

Oh, right, because there's no trailing size specification
so it doesn't get recognized as a named field.

thanks
-- PMM

