Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FB82F273
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:35:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmNy-0004Pu-CI; Tue, 16 Jan 2024 11:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmNw-0004PN-BT
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:33:56 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmNt-0004Dv-6e
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:33:54 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-555e07761acso12145860a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705422831; x=1706027631; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YA9WTa1PJHtrlzq0sc7rhJAhXDQbdvD1g9oBexAguQI=;
 b=cehtpb32L4X2Z8C/eG777xMZfbYS7vLYlcXOQVp6kJInfRm4MftNghq8lP0Jj5fPQs
 YXUAyou/n7vsJ+qJZbf4b4EbJ1oFmvtpNmz2o4FoIpKC/tQKxAj52uA/PuSf1pbf4AkE
 EHJFH/Gb0eQEkhWZLtaJbtDk23+GgLelJ1OTNtJknYsB0PTQnncf3Ytb6jEJ+vBebvn8
 rg6Z70xD8II6LTMqZ3rqlpXk3W5RPw77W16iidITwbIRbOISr8Jrlhw0C469Ohdlgndt
 WsrJLRYdQAdY3eMVtcC+amMP3/XBzkSUcxeMWRc2E2HrlWOxWqsG5YN8Z6k3rLNa9v1a
 aqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705422831; x=1706027631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YA9WTa1PJHtrlzq0sc7rhJAhXDQbdvD1g9oBexAguQI=;
 b=iV5mwjPFYB9mcnEV8AJiFhfIYqP2olZGbI+K1/1QwanfCDmNVcAU9UQXBQdigwmM88
 Sejjg0VNtdeCtWKlf6nPoGt2HaIwBlX50KLHXbfjQtSp3vdl4tCuMEw+G+97ksr9qQDR
 FcnREwqnHJ8GvoQpcv0m7T4ENzvvYMrbMo+keTDS7rhnQVt/OZkUsgd59KswpkKrmCsS
 Bxg1DOALqvVnAezLtNehgzgAwgxyqQUrVn2/P+EXoPCaqyfZcRx6hOPaCIm4ldpKZtAW
 PfWNS1tXg6rn0fUF6sajEI/t3Y6I+nOIS2BXcY6dh+nAn+jAYgGKre9VVfVyiWmsj477
 LYPQ==
X-Gm-Message-State: AOJu0YzUxbMCTmnfefzahTWkmZyttnE7QuVpv8nN3IRaiooYekcMRLZs
 xmynCIobuJEVS2WY2XmH6UtYCHHpcTuG17Rv9H2Aa4RIXN06SA==
X-Google-Smtp-Source: AGHT+IElVItkh+33QouJXs8TZLL78ulNkW/4pjRNQcPGbajpZoazMvIEnM2SVubEjtXA2m5oSmxay7piWdq5t9fHCuQ=
X-Received: by 2002:a05:6402:c81:b0:559:49e6:551 with SMTP id
 cm1-20020a0564020c8100b0055949e60551mr1171186edb.24.1705422831287; Tue, 16
 Jan 2024 08:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20240113055729.4480-1-deller@kernel.org>
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 16:33:39 +0000
Message-ID: <CAFEAcA9KD5OYp9gposXHDszB8ZGVDc-M=Yx4q6Uxzrr=+YnTfg@mail.gmail.com>
Subject: Re: [PULL 00/10] Hppa fixes 8.2 patches
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Sat, 13 Jan 2024 at 05:59, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 7425b6277f12e82952cede1f531bfc689bf77fb1:
>
>   Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-12-27 05:15:32 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-8.2-pull-request
>
> for you to fetch changes up to 4bda8224fa89ab28958644c5f1a4117886fe8418:
>
>   target/hppa: Update SeaBIOS-hppa to version 15 (2024-01-13 06:49:18 +0100)
>
> ----------------------------------------------------------------
> target/hppa qemu v8.2 regression fixes
>
> There were some regressions introduced with Qemu v8.2 on the hppa/hppa64
> target, e.g.:
>
> - 32-bit HP-UX crashes on B160L (32-bit) machine
> - NetBSD boot failure due to power button in page zero
> - NetBSD FPU detection failure
> - OpenBSD 7.4 boot failure
>
> This patch series fixes those known regressions and additionally:
>
> - allows usage of the max. 3840MB of memory (instead of 3GB),
> - adds support for the qemu --nodefaults option (to debug other devices)
>
> This patch set will not fix those known (non-regression) bugs:
> - HP-UX and NetBSD still fail to boot on the new 64-bit C3700 machine
> - Linux kernel will still fail to boot on C3700 as long as kernel modules are used.
>
> Changes v2->v3:
> - Added comment about Figures H-10 and H-11 in the parisc2.0 spec
>   in patch which calculate PDC address translation if PSW.W=0
> - Introduce and use hppa_set_ior_and_isr()
> - Use drive_get_max_bus(IF_SCSI), nd_table[] and serial_hd() to check
>   if default devices should be created
> - Added Tested-by and Reviewed-by tags
>
> Changes v1->v2:
> - fix OpenBSD boot with SeaBIOS v15 instead of v14
> - commit message enhancements suggested by BALATON Zoltan
> - use uint64_t for ram_max in patch #1
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

