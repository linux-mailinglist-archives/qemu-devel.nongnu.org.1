Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61837818E0E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 18:27:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFdrS-0008Ow-AJ; Tue, 19 Dec 2023 12:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFdrQ-0008OQ-Gn
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 12:26:28 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFdrO-0000iL-K4
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 12:26:27 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-552ff8d681aso6920844a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703006783; x=1703611583; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GNaJALPMR4T06Fy70/m7M5bP77I6oDiHT8BINT3X6l4=;
 b=gz/iyzNlsugk+rSYaFTms/KYe3pZ7Ayl0ClWeDc/wi8le9qlVYP2vEu7R9qFTwoS0l
 foF3ZvAlY0HShjnC8XpxnXPqqvrYp5ajHN6uoc52Rk+CJaWU3NdU57/MUYz2oCG39dRm
 LIRjhI7Cybms1knRjUHO2nWafoHlgEwY591UFwxR6LIj4y5Um3oagInrQRjS3fXfBuWx
 a3hum+lRoAQy+q3Oj/ePmzw5TMR6RlNZTSeuykcgolLWKF8uw+n/OO3G/H+ipmoCDLPf
 +nyF+0oRF7TBWd7peWAC30iRV4I4T+4z3k4z8jxErxGJLqE/N6XidhWI89xczZA/Q4Be
 XwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703006783; x=1703611583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNaJALPMR4T06Fy70/m7M5bP77I6oDiHT8BINT3X6l4=;
 b=HljJOJhQgvxClUbFReqHJ01xckSc8shL3Hxka07l53wVoKYStPXnYGR5Cwmh7JpCfi
 OcCOT3XJcZd2uYdWVebW/DukOAy7JCC1JamsDo3eGSaOCdPwSu/tut7VL0fWGy4a8kke
 tJ8g+bfMN0MZrXEjuO7T55jM7THL6Qcvl1cOw3uB2dpRgplrt+JyX68aPBRxKJqOFco9
 yGjOIJq49nvTV+TnqdGq3L6NUO0LiuKoaJMsZdMi7JNdTX67lVkUilLGXLLPHiUF5g/m
 mtVIB/a/tYMzzclvSQzpr+dc0/MBhl+NnGl1oJFSEF/pcMfoQa+A0NKB6+65w+Lo1Rmi
 71AQ==
X-Gm-Message-State: AOJu0YwCQvBTZCjYziQbapWWTuqGYtNDz0x8CPGPCgyBDokhN8MYTA2O
 tJjSdC44IRAiw7YvOR9wvyY7D+guU3RUQbl+6lUxcoWEoEzyRATB
X-Google-Smtp-Source: AGHT+IGd+qdqJCkofiTlAmqRPLfRsc2IUd2HvynWCMqrzcuJIsw+gybhx9tzoId7TpAIuDYoSuFLct3rTbgpqDjFooQ=
X-Received: by 2002:a50:d756:0:b0:553:3c89:bc19 with SMTP id
 i22-20020a50d756000000b005533c89bc19mr1664401edj.20.1703006783202; Tue, 19
 Dec 2023 09:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20231214233055.2505387-1-sam@rfc1149.net>
 <20231214233055.2505387-3-sam@rfc1149.net>
In-Reply-To: <20231214233055.2505387-3-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 17:26:11 +0000
Message-ID: <CAFEAcA_f93-Siwmc_5hVrz=A5Rva_d6bWFXYoRcb90AXZXJhmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tcg: Jump after always false condition
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
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

On Thu, 14 Dec 2023 at 23:32, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> `buf_rw` is always `NULL` when jumping to the `fail` label. Move the
> label `down` after the `if (buf_rw) { ... }` statement.
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>  tcg/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/region.c b/tcg/region.c
> index 6d657e8c33..691a726eae 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -596,10 +596,10 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
>
>   fail_rx:
>      error_setg_errno(errp, errno, "failed to map shared memory for execute");
> - fail:
>      if (buf_rw) {
>          munmap(buf_rw, size);
>      }
> + fail:
>      if (fd >= 0) {
>          close(fd);
>      }

It's also the case that fd is always -1 when we jump
to the 'fail' label, so if we're moving it down then
we should move it past that as well.

At this point you might as well make the check after
qemu_memfd_alloc() just be
   if (buf_rw == NULL) {
       return -1;
   }

and drop the 'fail:' label entirely. And then we
know that in this code path buf_rw must be non-NULL
and fd must be >= 0, so the fail_rx: codepath doesn't
need to explicitly test those.

So, well, all of this is definitely removing dead
code, but on the other hand it's also moving away
from the coding-style pattern the function has at
the moment, which is "there is a fail-and-exit
codepath which is robust against wherever you might
choose to jump to it, and so if we need to add new
code to this function then it also can jump to 'fail'
without any further updates to that error-exit path".
Instead we end up with an "every error-exit check
does its own tidyup" idiom. For the sake of not having
a static checker say "this is technically dead code",
is that worth doing, or does it make the code a little
less readable and less amenable to future modification?
I'm not sure...

-- PMM

