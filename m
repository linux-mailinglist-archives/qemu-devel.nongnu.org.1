Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6557DCB6A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:08:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxma5-0000f0-H4; Tue, 31 Oct 2023 07:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxma3-0000dD-Qr
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:06:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxma2-0005xn-8D
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:06:43 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-543456dbd7bso3078442a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698750399; x=1699355199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wFJAz4K+qfoI7oxuIztYbc0PlUD3sJ/KSADLnFFqx2Q=;
 b=MryQEKYiSZm+LVv5SrVMuLp9ingYVpoUKK3RBGqFHnucIK5AF0QOgyDPWhZfEpzI94
 rvdNlvIQOOWByYoQhqiz/733M37E6MvskwpPs4gk1cQwVbtDctjrceRDOKhSiCV8tgxT
 gDz/8fKVUNr4VLl10Va/h4adBtEhiyd/ijtmFzPQcnO3zKxRwK0JFmj6XD7pieuDhfTP
 wP8t5vl/ugRSyoWCwDrs+XlhdEubI/IQ6xtNUMf4wXQLWhQhD4NsueAMn2jNTMg6gf80
 v/+eDAv09LHqzUSKHSTDpIEtHhsZrT1EwYNnrv0/lLVIruTJ6M0NvSunSg+gF/Y8rHpP
 9tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698750399; x=1699355199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wFJAz4K+qfoI7oxuIztYbc0PlUD3sJ/KSADLnFFqx2Q=;
 b=hOtp+RbIuKyeiUQWly8VPJZf2RfZzsUXwDDvr0VZ9HvBo0zPYtg/PGlLBb4f2lTQxx
 rreWGKTZk7GF8Ilm9YMvt85ICPlW++VQMD5ypLTJKrMWwxCIv7rnjlCrfUDYVksTjf3R
 jUe5w94L1NvdT1K4XyBmw0yrX43zoDpzoS5eFxi/eycg+rgpbgtmnevupPHUEsU4yGJe
 Did9W/Ysu2P+2aKNhUrpiTCw8yacE+fNXCaNnb9sJ8H3J+4g47UMlA7pOuKphO6OUmN8
 ab6Q6/5wcm3IY2Tywt35ESaauVwk59CvkSugCq/AHD0EIkUgNK7rI4lgKWEeJg9ZTleC
 iokQ==
X-Gm-Message-State: AOJu0YwLZjkARwt4OZhTE7wdqrqHAcQ1BXNwLzYp02Bvu2FjieIvn52k
 4xVJbtSXnKcW9IsiaOxf7DTX+N8xTGLq4sb+DgkqkJJiyJHQHU62
X-Google-Smtp-Source: AGHT+IFIWug3ChCiBalGd/ipi3aEWQiYE/fi3H02wU5Vyv0iC10P0pI0DAQlXJTM+Bgjasq7KxtA9wtGRAq2z9ZKZ5M=
X-Received: by 2002:a50:ab12:0:b0:540:911b:72b1 with SMTP id
 s18-20020a50ab12000000b00540911b72b1mr2064670edc.7.1698750399080; Tue, 31 Oct
 2023 04:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231029210058.38986-1-marielle@novastrider.com>
 <CAFEAcA8ELCiGy3jDKjJhAd9Zn7Sse9ZSoJ6uQ=u4ROvV3rNcyQ@mail.gmail.com>
 <7DBF1391-69C2-4FA7-BB3B-378767DF42D4@novastrider.com>
 <834B7660-49CF-4704-9AE4-EB18B374BCB7@novastrider.com>
In-Reply-To: <834B7660-49CF-4704-9AE4-EB18B374BCB7@novastrider.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 11:06:27 +0000
Message-ID: <CAFEAcA_JsEB1DZCt=v5h-TAdQi_OsfTdyXjnK+xBaZV3U7Z0pA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/elfload: Add missing arm64 hwcap values
To: Marielle Novastrider <marielle@novastrider.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 31 Oct 2023 at 09:23, Marielle Novastrider
<marielle@novastrider.com> wrote:
>
>
>
> > On 31 Oct 2023, at 00:56, Marielle Novastrider <marielle@novastrider.com> wrote:
> >
> >> On 30 Oct 2023, at 09:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >> ...but we don't implement FEAT_MTE3 yet. We would add this feature test
> >> function, and the GET_FEATURE_ID() line, when we do, but we don't
> >> need it until then.
> >
> > Understood.
> >
> > I made this patch as I noticed the discrepancy between cpuid and hwcap output.
> >
> > The following code produces the value of 3 on current master, which would be erroneous if FEAT_MT3 is unimplemented:
> >
> > #include <stdint.h>
> > #include <stdio.h>
> >
> > int main() {
> >    uint64_t aa64pfr1;
> >    __asm__("mrs %0, s3_0_c0_c4_1" : "=r"(aa64pfr1));
> >    std::printf("%lu\n", (aa64pfr1 >> 8) & 0xf);
> >    return 0;
> > }
> >
> > I can submit another patch to correct this.

> I note that commit 86f0d4c7290eb2b21ec3eb44956ec245441275db suggests that FEAT_MTE3 is already implemented.

I'm sorry, you're right -- we have implemented MTE3. I was
confused by the lack of an existing feature test function for
it, but we didn't need the feature test because FEAT_MTE3 only
added behaviour to previously-reserved values of the TCF field,
so we allowed our behaviour on non-FEAT_MTE3 CPUs to be
"happens to behave like FEAT_MTE3".

Your patch as it stands is correct, and I've applied it to
target-arm.next. (There's a trivial conflict as a change has
just landed which moves all the feature test functions to
their own header, but I have fixed that up while applying.)

Thanks for the patch!

-- PMM

