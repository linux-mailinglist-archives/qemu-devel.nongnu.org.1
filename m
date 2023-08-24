Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DEA7868FC
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:55:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ5BA-0007Mm-Jz; Thu, 24 Aug 2023 03:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ5B9-0007MS-AZ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:54:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ5B7-0007Pa-5a
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:54:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so3856703f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692863691; x=1693468491;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvpMiF3JzMmnAqkZbMiSjG2h+Vm5dWjViEZ04nK06aE=;
 b=WmQiso55Q3pZOCFjleLfrMpncgUqjRDM9U32AH9xc6g6XljfrBAlOebCr8okNCYtQD
 XZMkEyprmOQAcjH3iBf8zJ4QOzvCNcwo9KaHgRRnTbZRZ5F65bcVBCfNjga1bRn/l4vb
 q4I8pexmqBOR2nyLQfYeiWpPwMInzQP6mLADyJ0QXhn4IAxmKPTui7z1MZ05mo/sdymy
 3QPcsc4gmVga0ggauP486GIiMcyuR/HSj1jX1s3XrSNqaNm4yOCUZ1GRXm28fpOI0XmF
 J/j0iOKRYJLwIwIJ/LmnEE6rZ2f7PbSSreRvYcTA2tkRnIqMVzHAIxLUYz2AFGH7MpEx
 bl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692863691; x=1693468491;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nvpMiF3JzMmnAqkZbMiSjG2h+Vm5dWjViEZ04nK06aE=;
 b=Q+5YEevU0yet3pwsQEl+6A/O2YRUB5o+9aE+2S0FTtQGzxFcwsdndPdfdyLNDO2QLb
 bj8vtTFsBycpLwwVGO9ypTnwt7gCCrfFinvcF3NJ1Cfqv0YMG3GHqgk+LqUkmo2GyrnM
 wAq61TQOs+/shsZiinQKZDDIoX7IK4rWJzvqjoDn5vR0zvH4dqdu6/7W+3z3TpC7O6Y/
 poBEzocOKueWv+DKXZaLkGA9Z+XtBDSYqkzOYVCrjqxsg04kebyjw1igIKmNPPY0GHZH
 v3yDNc8c+anmVqA1EFaF0yppDOo/sMRgr9XH3snxa27BWiFpdd0AIvCHadBFv1BrtXKP
 yC9Q==
X-Gm-Message-State: AOJu0YycEPZArvXTvrsxtrJWzBpJbpv3cZtXUsEP6YNlFaFeRGS8qo02
 5ReErg275IHMyZmX2wI9nR74B6MseywGRKMucbA=
X-Google-Smtp-Source: AGHT+IHKyp5xYuDGCaYlKe+R0XVKQsRTt6iJAi4WahLkQRWqp7UK35nAd0EsMeDn0qvojjyrzpJ4Jg==
X-Received: by 2002:a5d:560a:0:b0:317:58e4:e941 with SMTP id
 l10-20020a5d560a000000b0031758e4e941mr11072793wrv.33.1692863691198; 
 Thu, 24 Aug 2023 00:54:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a5d5146000000b00315af025098sm21499901wrt.46.2023.08.24.00.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 00:54:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75BC71FFBB;
 Thu, 24 Aug 2023 08:54:50 +0100 (BST)
References: <20230222110104.3996971-1-alex.bennee@linaro.org>
 <CAFEAcA8YSsByEUkVK7gWM51eoLR4JZV3P_GDakc3NaLAw=QwSA@mail.gmail.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [RFC PATCH] target/arm: properly document FEAT_CRC32
Date: Thu, 24 Aug 2023 08:54:38 +0100
In-reply-to: <CAFEAcA8YSsByEUkVK7gWM51eoLR4JZV3P_GDakc3NaLAw=QwSA@mail.gmail.com>
Message-ID: <87a5ugho39.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 22 Feb 2023 at 11:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This is a mandatory feature for Armv8.1 architectures but we don't
>> state the feature clearly in our emulation list. While checking verify
>> our cortex-a76 model matches up with the current TRM by breaking out
>> the long form isar into a more modern readable FIELD_DP code.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  docs/system/arm/emulation.rst |  1 +
>>  target/arm/cpu64.c            | 29 ++++++++++++++++++++++++++---
>>  target/arm/cpu_tcg.c          |  2 +-
>>  3 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.r=
st
>> index 2062d71261..2c4fde5eef 100644
>> --- a/docs/system/arm/emulation.rst
>> +++ b/docs/system/arm/emulation.rst
>> @@ -14,6 +14,7 @@ the following architecture extensions:
>>  - FEAT_BBM at level 2 (Translation table break-before-make levels)
>>  - FEAT_BF16 (AArch64 BFloat16 instructions)
>>  - FEAT_BTI (Branch Target Identification)
>> +- FEAT_CRC32 (CRC32 instruction)
>>  - FEAT_CSV2 (Cache speculation variant 2)
>>  - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
>>  - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
>
> Would you mind resubmitting a version of this patch that just
> fixes this documentation error and doesn't also do the other
> stuff that caused this patch to not get through code review?

Sent 20230824075406.1515566-1-alex.bennee@linaro.org

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

