Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B56E832729
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 10:59:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQle6-0005kS-6l; Fri, 19 Jan 2024 04:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQle4-0005ij-97
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:58:40 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQle2-0001t5-IQ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:58:40 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-559cef15db5so3169970a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705658317; x=1706263117; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yovfob8yhwZh4oehVKVqna2Fik2HD91EcQP9oMQtBBA=;
 b=l0r6W9Az/QoCLszxcJJExsaW1zh2oZeDswCXIwswNvOhgHyRCqkuKcq8mY/VHS9zN3
 sZO9BfULMvhYFsNoboGVuEvqa3AXC+UdJ2UWS8Q2aBG/XtG1cDVEdGhrdBgh2sYWnKJ3
 K4eulhxutGjYqx7XKPpONPANfb8VQk+wWsZFIz27oWhCZBkF+8vxu33tX7H32DOmRDZE
 EH66zF8r7R0FmRGhIiEd/Jn81V0/a7OsQDbhnOH2ky8JtffXDgAokkup2mbsHn1K/Kb+
 x8x7DclDMQ48iTkJzk5hMsAHDTTPjciSaVAiuzAu9QNwMusu14QjB//7igv24NPWTalS
 V15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705658317; x=1706263117;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yovfob8yhwZh4oehVKVqna2Fik2HD91EcQP9oMQtBBA=;
 b=M/eL9eV/vJdJxn4rQSTBjRg+/n6EoVKveeaTR6zCkCpmF6PRgycEfapkIFx6Ku0o/P
 THrvBkZxy5DAJ6eRFVvH16OUVMcuDSrz92qzCi5E19ofPhnAnwJwHS8y5/SoqCRElN6R
 hJgbIPvmmCpWuQxWhUGzNT5ZEcUwFOPP7kyg2GtJ+7/a4Uor0SoWQDRAyC+hUwtv4ya+
 YeNOJhei2SAtQ68+Mfu0jzmJ+Mth7uW3Qe9YTR0Zyf4ZqZ9voTnfhE2N/lJK2RAY+cQp
 3K0FSeXWzHKsF+49KPTjjOPjBWnwMXkKsxC6mU7FKEZDttNIj4jK0M3FXEr5ypZSz3YX
 D49g==
X-Gm-Message-State: AOJu0Yysqt+KAs4YAN6UXrd06D7kLxKl0XZCwi3sjhXc3z9CMSo5aMoQ
 tkLMeWbn6vxugYd3lWe2uBJNPWCJHBnbpMcw2kchblxmzTYI3F1qaI2gWRblrQY2O/gvUBHRJRk
 yicOyocvfqBeYS8dOOaQHypoolcO0CWsdM2ZsX541lFr4LbVP
X-Google-Smtp-Source: AGHT+IGrpWbSqVU78/sccTc1GACrkYTY4PvrXR5hEeLtb+R7xc1Nh3dgUhbr7HW+geYePnb4I6SJJfIUyoPXmOo2Tt0=
X-Received: by 2002:aa7:da57:0:b0:559:fd66:d42b with SMTP id
 w23-20020aa7da57000000b00559fd66d42bmr856170eds.7.1705658316912; Fri, 19 Jan
 2024 01:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20240118124512.2704713-1-peter.maydell@linaro.org>
In-Reply-To: <20240118124512.2704713-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 09:58:25 +0000
Message-ID: <CAFEAcA--pBMWh0G09wNjHg5SsUg7Jn1LXq3p9_1Wc35KQ+7NCg@mail.gmail.com>
Subject: Re: [PULL v2 00/12] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 18 Jan 2024 at 12:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: dropped the nuvoton changes as the tests didn't pass
> on big-endian hosts.
>
> -- PMM
>
> The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:
>
>   Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240118
>
> for you to fetch changes up to 410c2a4d75f52f6a2fe978eda5a9b6f854afe5ea:
>
>   load_elf: fix iterator's type for elf file processing (2024-01-18 12:20:33 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * docs/devel/docs: Document .hx file syntax
>  * arm_pamax() no longer needs to do feature propagation
>  * docs/system/arm/virt.rst: Improve 'highmem' option docs
>  * STM32L4x5 Implement SYSCFG and EXTI devices
>  * hw/timer: fix systick trace message
>  * hw/arm/virt: Consolidate valid CPU types
>  * load_elf: fix iterator's type for elf file processing
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

