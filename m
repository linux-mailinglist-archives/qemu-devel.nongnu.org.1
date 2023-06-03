Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B062721106
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 17:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5TWF-00071U-LI; Sat, 03 Jun 2023 11:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q5TW8-00070f-Op
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 11:50:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q5TW5-0007cN-Ow
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 11:50:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f732d37d7cso4408585e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685807407; x=1688399407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ka6KezNkh0IdDr8GdklycmNSH8VvQQOu1kKR8MbrIgk=;
 b=Uwt3HiF+3HPIWaSH2cQ/KLHo6ZustwTeJCM1Z5IL31/OKpHSOrk2inylvypiGqLlVi
 aVnODMjEO+ImpOl/KuHK0viL0c5pSpUa6h/wvzRV5f6DOBkrSM8LDqMJI5tR03lapvQu
 0EwN4uGPFQwnsZelPU+QowcasTs8obwbDu0gmXxdWPvR0eourJicY8r6w4RTbEGg5qgz
 uc2hvKL+9EHINYZzoBV3LXfzcflj01s7sntDy58t5EP4+HULZ138ZIlpjLIfmkmDMEvv
 poyOm2bWG8KP+NV+U9RmshAu5FZrXKHi1FhAVPvP8Nja4vxrZMEnV/iOyPon2cSgDRQU
 rN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685807407; x=1688399407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ka6KezNkh0IdDr8GdklycmNSH8VvQQOu1kKR8MbrIgk=;
 b=kmAxSOuGP/o2CQOb7GAgdk39dlfrmyXTTHHl6txm7HvgseB/TUm1t2POvvF912e3DU
 cy/f7jPaBzGep3ODD3z8dv4sV+LSpiVI0h41AKy1RE6cj4YPRzNZSwNVit3kekgjISNX
 VFsD/7wD4bR5SawnOmfjN9eN+17l/mBUOZMMkTooHcddtA9HOmU1c+w9Xw/BGFMh6VU1
 lmWJVa6rF2yx5+s0dTfr1XEvZPrjnR/NG2unUMCMRXopNvZr9NIWGtVy37n6tGm1Y0FE
 05dZsNRQpEl3Dx5Obsi8FgJoCYm4clkdqCVzbIJpB4Ppesdel76slOb+kDc9ASghj6z9
 lLDw==
X-Gm-Message-State: AC+VfDzQl2F1benQvt12+aLhRDlCwdN9mMWHdqZzLnYl1HZKnWkGLela
 f7HhjAnuBcuiB7YW4oTcrJpUQg==
X-Google-Smtp-Source: ACHHUZ5ZZxZynHiUkkF44G7o4ojMtZiRO2rbVY9BgfQxCX/xeEg0pak96APhCE3H3v1S1DVAwStm6Q==
X-Received: by 2002:a05:600c:2259:b0:3f6:923:9ec with SMTP id
 a25-20020a05600c225900b003f6092309ecmr4326805wmm.25.1685807406966; 
 Sat, 03 Jun 2023 08:50:06 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bcb90000000b003f6028a4c85sm8935807wmi.16.2023.06.03.08.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 08:50:06 -0700 (PDT)
Date: Sat, 3 Jun 2023 17:50:05 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Robbin Ehn <rehn@rivosinc.com>, qemu-devel@nongnu.org, 
 laurent@vivier.eu, qemu-riscv@nongnu.org
Subject: Re: [RFC v2] linux-user/riscv: Add syscall riscv_hwprobe
Message-ID: <20230603-c4d94ebf5c1a129e5cf3ebb4@orel>
References: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
 <20230602-86a3d8d9fad1fb3464d28702@orel>
 <995af08d-239a-f563-5da1-c2c245639d86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995af08d-239a-f563-5da1-c2c245639d86@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 02, 2023 at 07:58:30PM -0700, Richard Henderson wrote:
> On 6/2/23 07:02, Andrew Jones wrote:
> > > +struct riscv_hwprobe {
> > > +    int64_t  key;
> > > +    uint64_t value;
> > > +};
> > 
> > The above is all uapi so Linux's arch/riscv/include/uapi/asm/hwprobe.h
> > should be picked up on Linux header update. You'll need to modify the
> > script, scripts/update-linux-headers.sh, to do that by adding a new
> > riscv-specific block. Hacking this by importing the header file manually
> > is fine for an RFC, but that should be a separate patch or part of the
> > syscall define hack patch. And hack patches should be clearly tagged as
> > "NOT FOR MERGE".
> 
> 
> Not true.  linux-user/ never looks at linux-headers/.

Ah, thanks. I should have known better than to try and review a linux-user
patch, since I know almost nothing about it! Is uapi like this usually
duplicated, as was done in this patch?

Thanks,
drew

