Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54F82BFF5
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:48:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOGxm-0002mN-0X; Fri, 12 Jan 2024 07:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOGxQ-0002kS-Lk
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:48:21 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOGxO-0002Yg-Cw
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:48:20 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5582796b85bso3650717a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 04:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705063697; x=1705668497; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bCmXNdrMdBKTLQvZim/o3ohe2nSnBNBXMkvrz3sh+sQ=;
 b=ZDIu/P12617uyvhsym+wFX+/R/2Zdso1E0sBcSns97ptOO9WuK171Fhfzs3hAywJ3D
 Kop23hl3IEkklMjda0DhG9lF/4Js+kpgUN/2Yqhz3vKeHeoSrMzPIL2pYYXs+BQ0R7HS
 I9kJ3uaHB+zM8xqGPWbqxQO5CNiVeyrx8pt3fGoFSfIoKOh5aFbo641cBS7pc7EdaedA
 9nMDapNMEQclLFEQxGvIrU5KGJNSllPZckJdWwzsLH8DOtX+baVFD5QJGFM5W/GzjTp4
 RBLKR7Kwcz1DjnCdJG4VFl+k2wffNtm32Fx3tqZ5vjxjCIBRgmEcWdtBiW5fxX6s/sZ3
 k1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705063697; x=1705668497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bCmXNdrMdBKTLQvZim/o3ohe2nSnBNBXMkvrz3sh+sQ=;
 b=Pyfnl3YtnrotQixI6k0VGLYX7UKMxr+8GABCI4sY+LJsnLNGmEz2Wl2zt8i598mShC
 h2GNONQ1YHeMjtp8P/oMld4nlqIZOU4bDrvyBeQBktcFkYI/BC5T1Lr9rLT0N9Nx7gOd
 D36BSZyC9GS4z+omHzEsuynWXXyE7fVBetHFaI+FJBw8pNfO583xpVTvkphE0rC0YNfj
 uzjx9pLGCLgDpCOrBXUyyNp+NR+Anim1uTXoPxRuEOZAboSUMUgY5w6Fiflsnho/uuq/
 jiqDCblXoFMQoq2cP40WwoiVFo8b8hv4E/2El8oKv6B27SSKRkQeyX4iGtg9Qsq0qRiv
 p3aA==
X-Gm-Message-State: AOJu0Yx5HI4NuikTVMyBihAQhslRP7wXsdS9bDzSBMdhV6Ti0GqLzJRG
 fK7AF9s70mWkhRan2FObW6Xsjts3HcXKBKZOPAjvUMTL3xFsMxwqaRgqvU8g
X-Google-Smtp-Source: AGHT+IHtK972jXTV2+chsrcgg4IgtlvxUU+krTbhyGClFhhSsMT0xNX1mnG7eDOCc5kBSvLFMlAgMplJsgJvZ1cuiM0=
X-Received: by 2002:aa7:d7c4:0:b0:558:ad55:a2f6 with SMTP id
 e4-20020aa7d7c4000000b00558ad55a2f6mr604015eds.66.1705063697159; Fri, 12 Jan
 2024 04:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20240111111609.899183-1-gaosong@loongson.cn>
In-Reply-To: <20240111111609.899183-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 12:48:06 +0000
Message-ID: <CAFEAcA-En7ehznKammsPwK4hxq9B9LiPEn6HKLbeguy9-ta-Cg@mail.gmail.com>
Subject: Re: [PULL 00/14] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 11 Jan 2024 at 11:29, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 34eac35f893664eb8545b98142e23d9954722766:
>
>   Merge tag 'pull-riscv-to-apply-20240110' of https://github.com/alistair23/qemu into staging (2024-01-10 11:41:56 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240111
>
> for you to fetch changes up to 428a6ef4396aa910c86e16c1e4409e3927a3698e:
>
>   hw/intc/loongarch_extioi: Add vmstate post_load support (2024-01-11 19:22:47 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240111
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

