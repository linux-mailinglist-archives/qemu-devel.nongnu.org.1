Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86B75ADD2
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:07:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMSQK-0000pe-9l; Thu, 20 Jul 2023 08:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMSQ9-0000oj-Lf
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:06:14 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMSQ7-0006JK-H8
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:06:13 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fbf1f6c771so1103710e87.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689854769; x=1690459569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+dDEQ1p4PQhlb6pPBixSFCjoLSgaIPSCDKEbYVn0FhE=;
 b=kaWK/dX94oD2MkNSA6MU7FqisWviazMYwkSQxO2+x2MPhz7NaHs3qiB17RQhS2rLvE
 OA289ZNllAdePuGgCfFufZ6V8+S7J/PFvNHXsSk9uuYEjaUXGKafqLDrYE+mHvXpcDAA
 6Yxrj+YZO7wEGFLMkD9jji8GscJf6KC+bBQ3FUefbKwD2gw0tjEBdGejBrL/TRqF0pIl
 lLmCY5BvmDT+4PzyZExEMXN00Xsnd543RTbC2bpNzmJIb9vxpLN6/JBsJhlUxeM2dveL
 PkwD2r8T2lS+NeBAZ/bpPLLMto/sx9ExO72dMjfUeuO6qRvW8KdblexeIdcqkS2Oa0YF
 oyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689854769; x=1690459569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dDEQ1p4PQhlb6pPBixSFCjoLSgaIPSCDKEbYVn0FhE=;
 b=kESqF7Wmp5yTFE1O1F8M8KFC4gOSl9GYczTlS5Ey8Z9FS/hV+yH9BYGTJKFiBI/hy2
 crN2CZU5ZKfk1v4qqTNM8zerb9hkZYs2Y86iTYJSGCf3mrS8sIigcJkdIV1D1U+b3Rlf
 mWxgoFazgE4hoUZZuLoB5GEAYzaW7XUSfCLXkRApcCvJ1TCdTu6MB9pMG7tbZIm3daf2
 RwF8lbu6QnXZz0B4xVuhJlzHDUbfSoKPUPVCWZ1wi1AKqFaiZ9FUDAAfWK6QGWU6bpnp
 +iXN9AJmLP0y3UAf0RDcYp0iL4Lc+6CwCSTYE0jgd/1KzkOZr6m4hrr7pQJATrl260Zm
 cBsA==
X-Gm-Message-State: ABy/qLa8zbv/BhGv1Sc7lvb7Z3hkfY3h1r0258UOUQmYMsqv0ZVGqyho
 BESEu8mO5eNiWPoj9VexPtj+YtaW1aJ4q3CPgMlpuw==
X-Google-Smtp-Source: APBJJlFCEflVMMgEf2QNBQzUclWlDhEDuHmt3TGBZMW9PTlaJGeBVb+kmZom6dCDTBiby38Dh7vLhxr78FQsWiEOiJs=
X-Received: by 2002:a05:6512:523:b0:4f8:7503:203f with SMTP id
 o3-20020a056512052300b004f87503203fmr1898168lfc.48.1689854769259; Thu, 20 Jul
 2023 05:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
In-Reply-To: <20230719153018.1456180-2-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 13:05:58 +0100
Message-ID: <CAFEAcA9sfezZEHVXFT1bTA=1oiEy_ayc0xePJHPKVf87P3E-Mg@mail.gmail.com>
Subject: Re: [PATCH 0/5] target/arm: Fixes for RME
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> With these patches I'm able to boot a Realm guest under
> "-cpu max,x-rme=on". They are based on Peter's series which fixes
> handling of NSTable:
> https://lore.kernel.org/qemu-devel/20230714154648.327466-1-peter.maydell@linaro.org/

Thanks for testing this -- this is a lot closer to
working out of the box than I thought we might be :-)
I'm tempted to try to put these fixes (and my ptw patchset)
into 8.1, but OTOH I suspect work on Realm guests will probably
still want to use a bleeding-edge QEMU for other bugs we're
going to discover over the next few months, so IDK. We'll
see how code review goes on those, I guess.

> Running a Realm guest requires components at EL3 and R-EL2. Some rough
> support for TF-A and RMM is available here:
> https://jpbrucker.net/git/tf-a/log/?h=qemu-rme
> https://jpbrucker.net/git/rmm/log/?h=qemu-rme
> I'll clean this up before sending it out.
>
> I also need to manually disable FEAT_SME in QEMU in order to boot this,

Do you mean you needed to do something more invasive than
'-cpu max,x-rme=on,sme=off' ?

> otherwise the Linux host fails to boot because hyp-stub accesses to SME
> regs are trapped to EL3, which doesn't support RME+SME at the moment.
> The right fix is probably in TF-A but I haven't investigated yet.

thanks
-- PMM

