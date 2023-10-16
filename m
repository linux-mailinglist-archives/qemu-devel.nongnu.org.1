Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921E7CB057
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQpg-00015h-1b; Mon, 16 Oct 2023 12:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQpY-0000ze-0k
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:52:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQpU-00071S-BO
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:52:34 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so8323577a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697475147; x=1698079947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=spq4yYWyRvZELCi5JXYyvg/FkCzTtIN2Qz2QR68ItPE=;
 b=esqTYax02B2jVlVlnBxltslbzoozweR6hrA3tTREUTmlEFwZrCcQxnvmlgTE96cWQz
 i155RbqqgBLAMEjNNtT4SthwS+w+BAj6nUagQJhGS6W1nEldtJFnUNPWE2B07oEj41NB
 csdNjK8RCga+uRlrfeA7Q0Hk0XBohTGizDHWJOfSITZ+gBE5raaNG+YZzft9tBu+Ct7L
 8hqC0AzpiCCmHT6AHX2hmYttpQzkBgiNh8HOjBMsbiPZ7QEzNCZ9M/Gk0TCHK5bHIS8Z
 SeX1+Imwd6eH7gyyCvwEPGNOrpRy31HAGfXF38RF9DGJxJuNOdHwxD0fE+ad4hr1VC78
 T2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697475147; x=1698079947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spq4yYWyRvZELCi5JXYyvg/FkCzTtIN2Qz2QR68ItPE=;
 b=jp4OOsnRMRf3nHYEQNFTDMnQeyJwsPxlgKfhl5yIZIK4169aSdaLkBjElzWG/Xp9XC
 sCX57AvQawXCw1H1dZWF1M+RpEOHdFkt6Pgft48J3LGNtEyEBNFQmU3/yqNUCaBAsIR0
 dNtZ7e9OVScgFr33cOl26XiTOA/J1JkCuwAHx9Gox6nT1ZPytKl/JpObveAgG+EE2qxk
 mHfpIW7RF+BZ+NvqhP3hxNJ8r/bMg39NOaX0Bwxcu1xXDX0ChlZcMDcAA8NkpsquzvXv
 uGPWVcRhhIbkPffH3nmtZzbndGmfFOkgaLgFjzlDIw9XToIygPrEqzYMdmvrWVnJCCP/
 eVVA==
X-Gm-Message-State: AOJu0YwZR6wuBoJeaADC7KigLsXlz1muUw/QtP5T9suW/2U2VtFUBgSo
 ahrJ5jN+kIqdh51ELI5tRTqVNlAl0I0CBtUgUq/tdA==
X-Google-Smtp-Source: AGHT+IHBuiqGHzVcY5CvdnL1uNL/9uzDS6TntTPUSWc1DNeNweCJoHZr30KUXyxJ/NrH1VGdygZIqNTusOhA6OPIP60=
X-Received: by 2002:a05:6402:430c:b0:53e:8972:1d4f with SMTP id
 m12-20020a056402430c00b0053e89721d4fmr6305811edc.5.1697475146791; Mon, 16 Oct
 2023 09:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230928094404.20802-1-michal.orzel@amd.com>
In-Reply-To: <20230928094404.20802-1-michal.orzel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:52:15 +0100
Message-ID: <CAFEAcA8Uy2293pFs8Dr4ujb8bYeV5v62CxFwXstDWzHZfq=byA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
To: Michal Orzel <michal.orzel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefano.stabellini@amd.com, 
 Oleksandr_Tyshchenko@epam.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 28 Sept 2023 at 10:44, Michal Orzel <michal.orzel@amd.com> wrote:
>
> On an attempt to access CNTPCT_EL0 from EL0 using a guest running on top
> of Xen, a trap from EL2 was observed which is something not reproducible
> on HW (also, Xen does not trap accesses to physical counter).
>
> This is because gt_counter_access() checks for an incorrect bit (1
> instead of 0) of CNTHCTL_EL2 if HCR_EL2.E2H is 0 and access is made to
> physical counter. Refer ARM ARM DDI 0487J.a, D19.12.2:
> When HCR_EL2.E2H is 0:
>  - EL1PCTEN, bit [0]: refers to physical counter
>  - EL1PCEN, bit [1]: refers to physical timer registers
>
> Drop entire block "if (hcr & HCR_E2H) {...} else {...}" from EL0 case
> and fall through to EL1 case, given that after fixing checking for the
> correct bit, the handling is the same.
>
> Fixes: 5bc8437136fb ("target/arm: Update timer access for VHE")
> Signed-off-by: Michal Orzel <michal.orzel@amd.com>

Applied to target-arm.next, thanks (sorry for the delay; I've
been on holiday ;-)).

-- PMM

