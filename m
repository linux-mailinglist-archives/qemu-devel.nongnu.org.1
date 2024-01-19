Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C6A832D64
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:42:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrvk-00072p-1u; Fri, 19 Jan 2024 11:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrvg-00072Z-Sn
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:41:17 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrvf-0001UM-4f
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:41:16 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so1260594a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682474; x=1706287274; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UdItkHQ4uYlDQQiCor3+uJJG0DTTgr+fKsC8VD/1DxA=;
 b=akgQat9MwhAnN2EFRVtVn4pIgcHNpTaY/vywPxnBEQTr8MjtcO7xJc1P8ZhOP37J/m
 iZrcEyHJo6oUuYzDacU1PBctYceXzejocf14ly69aYgxkmvpupUwPJl0XrAIP2WLqNU0
 ksDcnl1KGxaBmnXqi6ifaKQinZqcqFyH+Vs/Uo7ua12NV3T886DH4vYTYw7N5TZ1Bw2E
 n8ZwzAQqKRhlAxA00L38ipMvALM9yI2MSPznnV8qpmBpx1Lb8cTZTBmgqPkb7U4kSqOl
 6y06guVEX32HmL6An4cbzIc4D6qFXKKv1rlhKudvoHT48As6CaANM7Fnmd2LjakBtleo
 ZDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682474; x=1706287274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UdItkHQ4uYlDQQiCor3+uJJG0DTTgr+fKsC8VD/1DxA=;
 b=dtA9++Oq+6EAM+TSoWMbJtga2/g9cvaNLIFPlzXjIHuvd6RBetfiKY1k8NJp/TRQ8z
 fXweGPNlYyss3z/48B0e5DTwBaa6EPYL+q6mpJSG7ilEzGnyYnNG3IqI/BHLXF36N9L1
 +LMYs2BM4DEXqBkaADdYaKEcfYVGWrrTGzjClzZW+nyJHs/y4Tjxl6+/ddPmlqOJH42N
 EP91wS/hklWo7sJ7f34zUm2JADFk1K9rFR1Dykq2grHBpiHRCPI+dIR96QDUiGvyPKpA
 f5v9iklPMBkxtWp3oSy1pYnX6sXAFWv10tpS5vatdHPPs7Ey/5MizwERAPppxPE8tY0Q
 Z8xQ==
X-Gm-Message-State: AOJu0Yy39ZW//2/LeX8eeh1sS2/R30VLg/+ZMrkAKouquSHJ6xcoCcFR
 37BR4AxMpioEQFCzqOQUnGD+sJlxWC/YBTbqUlYfrs5KyZj98BgrgHKLfKdnSoqC4jzUTBJlDnq
 TuhkdsxEwd/RKoqy4pWhwCXZb7dd7/OxVTxoqyXOSS7vcdUUr
X-Google-Smtp-Source: AGHT+IELRREECzgYKuAQ1aJOemr3Q2LETg68f2TCx85N+OKQqgqRaR62qhQYhdn1yG1hKqcODdInutPbgjtfMcpy8Zg=
X-Received: by 2002:aa7:c446:0:b0:55a:4b69:f816 with SMTP id
 n6-20020aa7c446000000b0055a4b69f816mr20751edr.12.1705682473770; Fri, 19 Jan
 2024 08:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20240118122416.9209-1-pbonzini@redhat.com>
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 16:41:02 +0000
Message-ID: <CAFEAcA8O12JDUegMkOBe1X-so+HypgQbRH3PRjeMnwMqVPx=dw@mail.gmail.com>
Subject: Re: [PULL 00/16] VGA, x86 TCG, misc changes for 2024-01-18
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 18 Jan 2024 at 12:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:
>
>   Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 379652e967b32ac905056bf723b54298b2f79a51:
>
>   tests/tcg: Don't #include <inttypes.h> in aarch64/system/vtimer.c (2024-01-18 10:43:51 +0100)
>
> ----------------------------------------------------------------
> * vga: implement odd/even and byte/word/doubleword modes more accurately
> * vga: implement horizontal pel panning
> * KVM: add class property to configure KVM device node to use
> * fix various bugs in x86 TCG PC-relative translation
> * properly align huge pages on LoongArch
> * cleanup patches
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

