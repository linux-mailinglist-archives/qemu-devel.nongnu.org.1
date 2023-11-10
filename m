Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 045167E7B5C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:20:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Oc7-0002YK-8q; Fri, 10 Nov 2023 05:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1Oc4-0002XV-Se
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:19:44 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1Oc3-0007Sk-BX
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:19:44 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso2995053a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 02:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699611581; x=1700216381; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UuTVwkNU5aeIlhkYLSuV1jLn77VkG1aW0M33v3Y6yWM=;
 b=A6hpY6MM09VIQvCzWL5BmQ3o0OUGUN6CJ1ppNtnMucYft64pSXdAnEBooEpxIo+8Xi
 23r2goCGvQBtD9Ohnq70NCVnqQ/VJR8EIcqxb+iGrvUarOiDwiR0x/9trLcFTAGxyKb1
 kWMs+v1KeHtrNDEXACBw2LtmyrT14wdujUBLeUkZO5iPAXieNSwmAGm5/EALod8o43rL
 YAR9/J8UoJ9kWT7u8maIw9q25+LF1xO7UYKdmrHOXZQ4WI+jqTAjnEL7x9AQjLKnSTml
 piuwvrLkHOZSy6AmxHidfJak6jNv0iwPeMP1dWyUdCcGzQaOdjw+EXFI2L9dqcyEF6o/
 1O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699611581; x=1700216381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UuTVwkNU5aeIlhkYLSuV1jLn77VkG1aW0M33v3Y6yWM=;
 b=GCW2AI3xe3sgeue5RCaLIhO3MvZ1khSDJnm30RjwrcrKxYOlGSqSY87gz7uDj3yhK2
 wdGIqEV6K8KyMaNJqzMA7VJP1O7BQQq8RdVPyyg61riGl1hwDCHBgAz1+FPD7kBk3RTe
 qT6i0qon3rpUVAVWqCs+ulqk1pXlLs5wjPXA6ne1dByKz05uSEv8JZvJCuN1JXRcssuC
 Ff9HM1b8vzQUMdhlAb2zjGaoQ5OXsfEnkJCmcTQi4utgcqSK56eR5suMma9HtFTfbB9J
 f4oyNGGPIrfi4/0aLDqijGKqYKo9aOT0paeMYGshWLe6TM3r1TKt1idwrgYlI6N7ev2V
 k+1Q==
X-Gm-Message-State: AOJu0Yz4QMKcZSGXrK7YFvv/V1tWQLG5q2Ptw+f+bxTdaw/g8HhvRn3b
 /8p8B4ocAg0P0If0YTQmAwoXC3WMKQMvOjPUIsQbiA==
X-Google-Smtp-Source: AGHT+IEE7tfUQ2jRMvRHYn2WxsiQYkaYjq+7NioZTD1YP5JaXrQrEitq3yElAfGJQlzmAqUPI03aR0AgpH1ZXzEQPlY=
X-Received: by 2002:a05:6402:268e:b0:545:5674:4293 with SMTP id
 w14-20020a056402268e00b0054556744293mr4572736edd.28.1699611581683; Fri, 10
 Nov 2023 02:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20231110090557.3219206-2-jean-philippe@linaro.org>
In-Reply-To: <20231110090557.3219206-2-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Nov 2023 10:19:30 +0000
Message-ID: <CAFEAcA_Jja7MT_cSiEJ2it+wG7LnUXfnuoo1vmoUf1-+KSgtAA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: fix GIC maintenance IRQ registration
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 10 Nov 2023 at 09:07, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic"),
> GIC maintenance IRQ registration fails on arm64:
>
> [    0.979743] kvm [1]: Cannot register interrupt 9
>
> That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
> where the maintenance IRQ is actually referred by its PPI index. Just
> like commit fa68ecb330db ("hw/arm/virt: fix PMU IRQ registration"), use
> INITID_TO_PPI(). A search of "GIC_FDT_IRQ_TYPE_PPI" indicates that there
> shouldn't be more similar issues.
>
> Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Isn't this already fixed by commit fa68ecb330dbd ?

thanks
-- PMM

