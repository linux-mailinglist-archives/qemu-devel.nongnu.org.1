Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 755AA73FCEB
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8sC-0002wc-Kw; Tue, 27 Jun 2023 09:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8rz-0002vt-Bp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:36:36 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8ru-0007Dr-KS
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:36:31 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b6a1fe5845so33890281fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687872988; x=1690464988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8fhC9xcnQDDjFbdwaTPtk8/MTt695a6dEAOZPv7zGQo=;
 b=CKr0UdM3OzuXK1JKPU56QzaEVn9KgCTB/Jp543Ck2/b1QcZj8Lx3cNZSPML+jsVHhD
 VvvSOqGnhxGOFByV/n1eMj/ltOo/EsGvdhX92hOym7JIng5yxq+OQhtmXwfmXMQL/wFs
 NKv8/uns102Ns2w6T7pAN42wnIxDF6+qP3/c3NH2kpJTb9RtF19YrtIBCdbqESNm06ca
 ops2kxCOQ/STkmwyQXUd1gEsnQN5JZWkunU1D+wowfcrhCRa0zc4eX7y4waXnfmWSZg5
 DurlEjtfhYuCYdqGsrEoUUFAYPg82N2AvjsqooGt8Fq9tkODD/rT+ygFd4azd0+B8+az
 PR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687872988; x=1690464988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fhC9xcnQDDjFbdwaTPtk8/MTt695a6dEAOZPv7zGQo=;
 b=UVeFcBxIHYObNoLe0sESJR67ylo9sRRtNEJ1ZF2nhOK1B5KWf/2xFa2dp53qYhhayq
 xACgeEsUXcpIvF33nDxcifuPtYuWBxweGOlHIr0spY1HEbRtiG5c9tPY2NXfW91BVJvt
 b5Wh1qPFF+Ly/BPDfdlKrb7Ipl+Eba+5hdbzfzrVj4ITsfHwJYXCe1slTzJkjajDi2VX
 lFuQK79YiuRY4QCoiQP3FuvR8D791bTuKXSFrOhvH+2qjO142p+PdpMuqf+q+B2RIiZ4
 Y2JyfKAxk6qg0gAO1q2eaFHI4qGjr5s8V0t9EE8Ouij+Z/rO+xIJt4XaGTc7UzylTLr+
 fHtg==
X-Gm-Message-State: AC+VfDx72efglrjjA+BdvR3a8ylz1v9T4HVp65s5kOew2lJV79llKHrv
 acy1iY+TMtdnHBbmI3J0vaaRRpHDSW8oC0jRL9GA1w==
X-Google-Smtp-Source: ACHHUZ7lM4hRzvzU56o5t3GXWTXrNXY1mD25KiuafWkWKpACizu2/fIcsr5KRHtDsXDoN1qZIVd62h7DMP1LLh/+xp8=
X-Received: by 2002:a2e:9d19:0:b0:2b5:8153:deb3 with SMTP id
 t25-20020a2e9d19000000b002b58153deb3mr12511414lji.4.1687872987731; Tue, 27
 Jun 2023 06:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
In-Reply-To: <20230622151201.1578522-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 14:36:16 +0100
Message-ID: <CAFEAcA-LNDGcddHiTOuyc7XcaSS4KWMFYu_-532rfjcvF5_c7g@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/arm: Fix SME full tile indexing
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Thu, 22 Jun 2023 at 16:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fix #1620 and add its test case.
> Several cleanups to aid debugging ZA[].  :-)

I'm going to apply patches 1,2 and 4 to target-arm.next.
I've tagged 4 as cc: qemu-stable (but will remove that if
you disagree).

thanks
-- PMM

