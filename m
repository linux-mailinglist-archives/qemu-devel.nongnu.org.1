Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5EC75C3B9
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmnb-0000yX-Tn; Fri, 21 Jul 2023 05:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmnY-0000y7-AE
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:51:44 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmnW-0007cE-J5
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:51:44 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-521dbe5e09bso2103650a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689933101; x=1690537901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mCcIJV0jCghcwTQpOwiGRWcIThtGCcPD5i1NUvp8FI4=;
 b=flI86UKuA/iVXyAyYDX4UoIvX0+q6WbzMSzfnZAdyty8r+ltEo6gdz7yRhQ8+5266P
 P1pjF5jRU/S9Wc1+jwxXbX4Q24UubNSwdQ01Ri56+tNuQRfg3GZmGpriyqZ4+aNjLPpm
 npql+VBmjgDOYA5TszgSdeo4I3F87IHFmPjeoDmb/jaC+nLR8jmTdE4z3IjvTtcHc7xf
 ip15RhtDZwYggJfqwu972vZXYYxy5ZQ2xVMaIsBjVELCHIL2THxY8yE7MoGGaHD5h66s
 ETYZWz8NSDPVc1hE/G+JZCUdP4tAn8ozSSbFfohBfTTLb41kx/7XTQoiGsrXtbUCBVIU
 YP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689933101; x=1690537901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mCcIJV0jCghcwTQpOwiGRWcIThtGCcPD5i1NUvp8FI4=;
 b=Cf+iqYgi//J2p6eveQM9wJXNLo6el6umoWYyW0oD8BGX/3BlFroQq5bGiuv1crSGh9
 bGNZYsQWSk9h7vwsYJLeAtw6HsmbozGqMmlMkwjVFrtDBPM1sK1yXogRVZzMq459GrMb
 e3yd6iDA5Fsy9KgbBhofvVy1eoVM2BMnbfNoU/UPLExmdCS8h0S4w55mQpGJS7FKcgMh
 spnD/ZO/PD17TdJYDTPm070DqFYnzY3pbsT6eL19J9MI6CNBl02FX4txWb/TAXQKH6iJ
 gkCin0/RlFSJNcCKt4l7Q5zLczact2tBWJMNE84T2WT+MQdluM/KVhs9MY59abUDwwMf
 lnQw==
X-Gm-Message-State: ABy/qLYRs4UMUm9aopRUuKV0DYXkoQBw8EJ4Cvu177Y5/oDlhYyzXs7W
 uynjpejxKhirmFr6G+GqqCXjXm18aqnXlH7CMnx1eA==
X-Google-Smtp-Source: APBJJlGTzhDHootOSRj2XdPCmyzc23gdvH5yRq3n0V0/JofNDLIz+0N6HiY9KZuPn4rCxvHkD8uFFqSNpQb27BBSvm4=
X-Received: by 2002:a05:6402:1646:b0:51d:7fa6:62ca with SMTP id
 s6-20020a056402164600b0051d7fa662camr1261075edx.14.1689933100954; Fri, 21 Jul
 2023 02:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230719155235.244478-1-deller@gmx.de>
In-Reply-To: <20230719155235.244478-1-deller@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2023 10:51:30 +0100
Message-ID: <CAFEAcA-Aw7qM-oTXVCfDVBdxgK12Y8_B=V+wdjvwM2g8X__V_w@mail.gmail.com>
Subject: Re: [PULL 0/5] Linux user brk fixes patches
To: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Andreas Schwab <schwab@suse.de>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 19 Jul 2023 at 16:53, Helge Deller <deller@gmx.de> wrote:
>
> The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/linux-user-brk-fixes-pull-request
>
> for you to fetch changes up to 518f32221af759a29500ac172c4c857bef142067:
>
>   linux-user: Fix qemu-arm to run static armhf binaries (2023-07-18 20:42:05 +0200)
>
> ----------------------------------------------------------------
> linux-user: brk() syscall fixes and armhf static binary fix
>
> Commit 86f04735ac ("linux-user: Fix brk() to release pages") introduced
> the possibility for userspace applications to reduce memory footprint by
> calling brk() with a lower address and as such free up memory, the same
> way as the Linux kernel allows on physical machines.
>
> This change introduced some failures for applications with errors like
> - accesing bytes above the brk heap address on the same page,
> - freeing memory below the initial brk address,
> and introduced a behaviour which isn't done by the kernel (e.g. zeroing
> memory above brk).
>
> This patch series fixes those issues and has been tested with existing
> programs (e.g. upx).
>
> Additionally one patch fixes running static armhf executables (e.g. fstype)
> which was broken since qemu-8.0.
>
> Changes in v2:
> - dropped patch to revert d28b3c90cfad ("linux-user: Make sure initial brk(0)
>   is page-aligned")
> - rephrased some commit messages
> - fixed Cc email addresses, added new ones
> - added R-b tags
>
> Helge


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

