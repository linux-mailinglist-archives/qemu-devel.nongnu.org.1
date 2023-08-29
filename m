Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D141078C521
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:24:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayhS-0006VQ-Tw; Tue, 29 Aug 2023 09:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayhQ-0006Ol-BY
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:24:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayhN-00040z-KH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:24:03 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce52ef4so5596378a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693315440; x=1693920240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOKP6BVOjMM6N7KawWSRFGn3umAy8kJ3B3bH2V5qpzU=;
 b=tTOP45CdM5NUO/x2hzhqEzzfDxYIFaoGEGqunLRe8ZQ7s9twxpOqEWRYgTLT//Fedx
 G5Qf1E0ZwJsC+lantV+/YDQxWTAo8B2fuWx5gwDwyB4AOZ7rR72yVeaftIxoEujMxcE5
 yk/wrxareqZYRCCvAjiIlGNVzyfvELs43T8aNDg+rws3ttc8tvHEYvQGxpO20rAqagGB
 2QHEVESsNwI4eZNqo0HmEP7iNDCb/1Hspv2BAelkx2P/AYLAD9fJe5UuM4YX3QQQ1Sqk
 d4biFqokSJBW/SGsjRtUniN+wg8UTCvxKaU8hmMj861RBqEqy1dd9i8R5LSSH/zUpKcK
 SD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315440; x=1693920240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOKP6BVOjMM6N7KawWSRFGn3umAy8kJ3B3bH2V5qpzU=;
 b=izywUahvR16jZ49wXTA67MnVD6NX7FZnmEsGuS+qGhy97bTkqaWtoIGAKNBZru5FTU
 ni/fa1aYkTh8tXgG4g/O3ZS7WodpynbKipeEqttRPj2TV3rcNBdgrPc3h535hzg9yzw3
 HP3/TTVN8jIEY5OVJedlHa2FU5QUiGKIZ6irdzwEhUeOIAc8UHxHKkj+dbMUgVfO8sDM
 8Q7jInUuuPfyNwl9s7pBCfE3eDZnUdgd0Y6977BW7qLlS2RJ8XVI5UXRT4yzCbKDg19A
 uzDMUwiKB9FDF5+ufuUwXxGMr8MR8tKZbUtDYSVvWxh3TUzmnXCkPVjbnfleLNnpIT0C
 yPKQ==
X-Gm-Message-State: AOJu0YwmONrgwSv/s/VlgwQdkfs7gt+T1t6EOLtl/Wxb/aLtmHDJF0Fc
 aehz6Pj+AI20lEPko1vpj9jPFQwSw59o03tvMn4xpA==
X-Google-Smtp-Source: AGHT+IF9Bl1R+Jh43e/A//mGKCqNOK5TMgltniSD6tSfwG1O9UqZbFACNUZVJU4hBz74pWHXRoNa2xlijUKcksv7PjE=
X-Received: by 2002:aa7:c741:0:b0:525:6661:dc90 with SMTP id
 c1-20020aa7c741000000b005256661dc90mr19849027eds.25.1693315439975; Tue, 29
 Aug 2023 06:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230824075406.1515566-1-alex.bennee@linaro.org>
In-Reply-To: <20230824075406.1515566-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:23:49 +0100
Message-ID: <CAFEAcA-n7KVVLEUjYYkPMbLPVn+daXb4iDwe2H3x7KF+BeKt+w@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: properly document FEAT_CRC32
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-stable@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 24 Aug 2023 at 08:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is a mandatory feature for Armv8.1 architectures but we don't
> state the feature clearly in our emulation list. Also include
> FEAT_CRC32 comment in aarch64_max_tcg_initfn for ease of grepping.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> Message-Id: <20230222110104.3996971-1-alex.bennee@linaro.org>
>
> ---
> v2
>   - dropped the breakdown of setting ID registers in other CPU init fns
> ---
>  docs/system/arm/emulation.rst | 1 +
>  target/arm/tcg/cpu64.c        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rs=
t
> index bdafc68819..65d1f39f4b 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -14,6 +14,7 @@ the following architecture extensions:
>  - FEAT_BBM at level 2 (Translation table break-before-make levels)
>  - FEAT_BF16 (AArch64 BFloat16 instructions)
>  - FEAT_BTI (Branch Target Identification)
> +- FEAT_CRC32 (CRC32 instruction)

Applied to target-arm.next, thanks. I pluralized "instructions"
here to match the Arm ARM text.

-- PMM

