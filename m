Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 492E982B190
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwne-0003aV-Uf; Thu, 11 Jan 2024 10:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNwnY-0003Zs-4g
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:16:49 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNwnV-00034U-PP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:16:47 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55745901085so6923173a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704986202; x=1705591002; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kHN9fLArQ5Bdlh01dLw3W0RYwz3pPva/EzX/o5HF0Bw=;
 b=QHIPaB9jxqvtekIPs/YVzyc9fx4qXY+CokyFi8GmWKZHhmEA1NOWy/0yhcK50xu4PW
 7icKHEyGGb13kjBifBk/h850ov9Y+XjeScsXVSkekUCjvER3NtMPuDrSPCQbkGiFCtmY
 k9L9+IQGWsQ4XGC8NvI+8O1esbsXwThvAIq9408Ysrbpo7Avv5Y0G3Djbyaz9O5OF4S9
 jr8LEON7jAtj0zXX2YBf/pS7a7KZOfpTgeisFiAKyaEuuNH++65ch5IUkk8qTDDOtQna
 kgzXmkTJJANFFMQGQwvOe1Be7+7kVzEwgnGrxuH5/07Y57HpTeyHG7Mk9CQgVBE1kIM6
 wTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704986202; x=1705591002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHN9fLArQ5Bdlh01dLw3W0RYwz3pPva/EzX/o5HF0Bw=;
 b=o/WELvx4/71Wg4/6EpBPQZY5gNsShi5293lgCQy6m6MhdjneVTJjTyvUdax5WSy6+e
 Zq7zHtNGzlsQsWWhdY6z8+u/Nd6oiYV6eSngLGYC8sPVW1O2+XsmZJj6dpAJSry2quCv
 vBPxIsloPU31NhU/ZGkInOaps7GEstjuvzU0E0H2rxtwgab4DJsN+SVbDOC5eUnE79gq
 wS5ANKYhRmGGda68Zme0HbMCHyZYPOTUNKSIHMETaTOYmf+8XVL3jCK3bFaqtzNYPou2
 ZMq0tmAjGC+zDkpWPdN23xl4zeccaBa8ltwpKSUxmDVTY57+uyXyU1Vp4QxtxFm0IgpP
 qJ/w==
X-Gm-Message-State: AOJu0YxFTTczWqHDNNpcWKfwvTsBQlbegvDxCs2biO2ua2/g5dI4oTcH
 2MlwlCD4GRDPe35RAqtZqbr/vz3HSJ+Gso6Ccbjnxaib4wS1DA==
X-Google-Smtp-Source: AGHT+IGMKRRQlWuDfq5x6RAEr3k/fCW4sdSvd4RQSSeiMCJvabN8tUKwFavQf+V2nmQOWfOoVx+LFr5S9o2j5Q6G0nw=
X-Received: by 2002:a05:6402:40c1:b0:557:d5c1:a4ae with SMTP id
 z1-20020a05640240c100b00557d5c1a4aemr747737edb.47.1704986202639; Thu, 11 Jan
 2024 07:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20240110215204.9353-1-richard.henderson@linaro.org>
In-Reply-To: <20240110215204.9353-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2024 15:16:31 +0000
Message-ID: <CAFEAcA-p+fT13+pLVXMpCbOLcrzWXeg=QGwbJfokRA37sp-snw@mail.gmail.com>
Subject: Re: [PULL 0/4] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 10 Jan 2024 at 21:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 34eac35f893664eb8545b98142e23d9954722766:
>
>   Merge tag 'pull-riscv-to-apply-20240110' of https://github.com/alistair23/qemu into staging (2024-01-10 11:41:56 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240111
>
> for you to fetch changes up to 1d513e06d96697f44de4a1b85c6ff627c443e306:
>
>   util: fix build with musl libc on ppc64le (2024-01-11 08:48:16 +1100)
>
> ----------------------------------------------------------------
> tcg/i386: Use more 8-bit immediate forms for add, sub, or, xor
> tcg/ppc: Use new registers for LQ destination
> util: fix build with musl libc on ppc64le
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

