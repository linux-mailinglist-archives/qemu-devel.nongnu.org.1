Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC927B2996
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1QD-0004Bl-Jt; Thu, 28 Sep 2023 20:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qm1Q9-00049g-Qd
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:31:54 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qm1Q5-0003xz-MM
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:31:52 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7a52a27fe03so5793825241.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1695947508; x=1696552308;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FuPR5kZkLWLdfpl5zpkmUO1pvjoqAOl77j/x5C+XIT4=;
 b=Y7fVC2T3PvepbzbufLauz0wcDzTrQvEn332FfYxKaQ7gj8421TKU+71I1luki91BJm
 nQ36eLvyAZ8LetLglwBRyJc539SPRSDXLpUybWPmqKVpbbV99Cb3YS8Ea9AdWjD0NtkU
 X0q9/PXA9mUbdwTIGLebsA1FB0lK0Wt2miAZ6cdXw8UZ4dwSAhoB6WYsr7asMdu2wXGF
 2uYIl8hGbnhYfC2CeC+LFzE27bPDHuvywJyQBg+Xhg++rSDNWos+DHvhFBha5hvcmWbO
 iBxdkrOjJneQeXQUVH5QGism4AiObhtjN9ErSzdMFYL1n1htSfGSN+9BEUd89coFwi3F
 CnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695947508; x=1696552308;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FuPR5kZkLWLdfpl5zpkmUO1pvjoqAOl77j/x5C+XIT4=;
 b=pLtJxEZbGnXix77QoIxXNtQS4gthzZKtm7sMKHeUFdlcvAegv6GAL4/7VX7HY283/y
 nZcTmFJ83E565LrLjv5foFbbwKqOf1nyFl/uLPAjClDyUaRw9uxNsoEGfpmv7lBhPlio
 cEUlPO/rLooGxNYz2/HwWFxdsYbL9T2cxZ7Q8Gd6RNgiyEqCYgo0LuMDVsBisGrEiUGr
 OSwNZYIH9tp8mVekt2qgFiVy7q67y9Qsj7dJ6p6QkTIPHAV8GfpURepg4YS3Vu5NtO8A
 7GqZvPMeYznK/jpeVPYbsNN/fuInmmps2t0pX+vvc3TOXAh2q6XCSWvxCoC7AWIAFFss
 0Bng==
X-Gm-Message-State: AOJu0YxjtUy0o1KRTlAa9NlKx/hYF1LGCGmUHK3UD31I6fFbutWg2cb3
 PJUZQTuO4x2e9VbtO5QgvndgFkkhTY/3/o+iyPXFrQ==
X-Google-Smtp-Source: AGHT+IEvoEPjlUcH5pSxNQlPhy4zIs6pxUv6umnhaEmXatfWQ/Q82ZW6jpOJr7Pldhp6rk6HgEtN2kxdek32cZsC/xQ=
X-Received: by 2002:a67:e3d1:0:b0:451:40b:2210 with SMTP id
 k17-20020a67e3d1000000b00451040b2210mr2650798vsm.3.1695947508076; Thu, 28 Sep
 2023 17:31:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2a92:0:b0:7aa:d493:bd29 with HTTP; Thu, 28 Sep 2023
 17:31:47 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <a617709e-4567-a10e-26e0-e4ffb2308573@linaro.org>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-9-nbowler@draconx.ca>
 <a617709e-4567-a10e-26e0-e4ffb2308573@linaro.org>
From: Nick Bowler <nbowler@draconx.ca>
Date: Thu, 28 Sep 2023 20:31:47 -0400
Message-ID: <CADyTPEwNzYmLa3H0kdxjBE0Vig0j+oVUXtAhvJP=KO0Jgzmkww@mail.gmail.com>
Subject: Re: [PATCH 8/8] target/sparc: Fix VIS subtraction instructions.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2607:f8b0:4864:20::92e;
 envelope-from=nbowler@draconx.ca; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023-09-28, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 9/24/23 01:03, Nick Bowler wrote:
>> All of the VIS subtraction instructions are documented to subtract the
>> second input operand from the first.  This is also consistent with how
>> the instructions actually work on a real UltraSparc II.
>>
>> But the emulator is implementing the subtraction in the wrong order,
>> subtracting the first input from the second, so the results are wrong
>> in all nontrivial cases.
>>
>> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
>> ---
>>   target/sparc/vis_helper.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> While this patch works, better to use
>
> void tcg_gen_vec_add16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
> void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
>
> void tcg_gen_vec_sub16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
> void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
>
> from "tcg/tcg-op-gvec.h" and remove the sparc helpers.

OK, I will try to respin this one using these.

Thanks,
  Nick

