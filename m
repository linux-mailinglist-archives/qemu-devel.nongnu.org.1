Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A074F613
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGYH-00050M-4M; Tue, 11 Jul 2023 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1qJGYD-0004zz-Nb
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:49:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1qJGYB-0006aA-Do
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:49:20 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-668711086f4so3813398b3a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689094156; x=1691686156; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=PQzjHIHVdvK+jWYBMkEnUbMg8xpPVhzzrho4nDiNl4U=;
 b=DOH5QcCIm5CsCaMF89MJL6idAUk6+Uh8BGlBLjLq8u8r+0B4/CpjpAzbaQD9Yg8i3E
 3LtN8lEFeU7XiteCnhRwdPOZeArCn+pmrkMmact5ugSH9IRu6XVzFxK8l1xj87qS9cz/
 CuFvsecf7KlC5UlIAbTrdxDahJci3jBrvFPhM/GreuNUn/QGEBuhCsnN6f/Rws56Mv2C
 aEW29fwK+DGtAuwpy0x1UeqC4XrV/bbY1lpfK3hwil2cr4QcGm3uYu9AFrHp06b1GMlA
 m7vJHDWvexLRdcg/+0qTYDO02Cz3IufgVtURi+ETwYmzeWz0cx9g5/H1+lqIYBBhioB+
 vVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689094156; x=1691686156;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQzjHIHVdvK+jWYBMkEnUbMg8xpPVhzzrho4nDiNl4U=;
 b=i2FLL2rEi3MIROW7ArctbA+2XUcvvinGCyYsvqdxpRo2sA6kZDX9S70llz3RybFw1G
 cRbbWv4WYW8X+BiNKUEAlTmEhC8k3xeTpOdNRGInT/GUNErcml5D+HXf86nCv6U8Q0gc
 Dxr4RtDpnyH789hm+hV4ZX2FfgVgF7DG2BDwudSquVjlKHIHkZafvhv0XhzeaznSjigl
 0uecai2TJQu7rbzzOFZ0ahet04WqVpQFAevwhlIpvHZ3LzRIOB8vLpNrKluZ6eIVbBkJ
 GjZmrg8CyMPYm8Mtq3zCICVovlgAEQSBepOd+Ipgi2QLyQhqY6HOLVS13ZZltnDtLsTw
 jXRw==
X-Gm-Message-State: ABy/qLZ7Pyet2pu5P3W+NttX+MYezgQPBAvrBjlGc4bzmJJNDzg3kPSz
 jjd+65hbDHaOyeGW97UyBZdefn7GP3sbwNpw2/g=
X-Google-Smtp-Source: APBJJlG4WCzIzsBZ/Jcab8rBlsokuhADcYN7j/hgdyq6fuju8btutNUWQmEFvy8z0o4vIjmfz83pqA==
X-Received: by 2002:a05:6a00:1da8:b0:682:93ce:4825 with SMTP id
 z40-20020a056a001da800b0068293ce4825mr27682093pfw.3.1689094156426; 
 Tue, 11 Jul 2023 09:49:16 -0700 (PDT)
Received: from localhost ([50.38.6.230]) by smtp.gmail.com with ESMTPSA id
 v13-20020a63b64d000000b0052c3f0ae381sm1676958pgt.78.2023.07.11.09.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 09:49:16 -0700 (PDT)
Date: Tue, 11 Jul 2023 09:49:16 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Jul 2023 09:48:25 PDT (-0700)
Subject: Re: riscv kvm breakage
In-Reply-To: <629afcc2-ffed-c081-9564-7faa6defc1f4@linaro.org>
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 mjt@tls.msk.ru, dbarboza@ventanamicro.com
Message-ID: <mhng-cc1adc21-625f-4def-bd89-8ccf08c98514@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=palmer@dabbelt.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Tue, 11 Jul 2023 09:43:48 PDT (-0700), Richard Henderson wrote:
> Hiya,
>
> This breakage crept in while cross-riscv64-system was otherwise broken in configure:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4633277557#L4165
>
> ../target/riscv/kvm.c:209:38: error: ‘KVM_RISCV_ISA_EXT_ZICBOZ’ undeclared here (not in a
> function); did you mean ‘KVM_RISCV_ISA_EXT_ZICBOM’?
>    209 |     KVM_EXT_CFG("zicboz", ext_icboz, KVM_RISCV_ISA_EXT_ZICBOZ),
>        |                                      ^~~~~~~~~~~~~~~~~~~~~~~~
> ../target/riscv/kvm.c:205:20: note: in definition of macro ‘KVM_EXT_CFG’
>    205 |      .kvm_reg_id = _reg_id}
>        |                    ^~~~~~~
> ../target/riscv/kvm.c:211:33: error: ‘KVM_RISCV_ISA_EXT_ZBB’ undeclared here (not in a
> function); did you mean ‘KVM_RISCV_ISA_EXT_MAX’?
>    211 |     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
>        |                                 ^~~~~~~~~~~~~~~~~~~~~
> ../target/riscv/kvm.c:205:20: note: in definition of macro ‘KVM_EXT_CFG’
>    205 |      .kvm_reg_id = _reg_id}
>        |                    ^~~~~~~
> ../target/riscv/kvm.c:212:37: error: ‘KVM_RISCV_ISA_EXT_SSAIA’ undeclared here (not in a
> function); did you mean ‘KVM_RISCV_ISA_EXT_SSTC’?
>    212 |     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
>        |                                     ^~~~~~~~~~~~~~~~~~~~~~~
> ../target/riscv/kvm.c:205:20: note: in definition of macro ‘KVM_EXT_CFG’
>    205 |      .kvm_reg_id = _reg_id}
>        |                    ^~~~~~~
> In file included from /usr/riscv64-linux-gnu/include/rpc/netdb.h:42,
>                   from /usr/riscv64-linux-gnu/include/netdb.h:32,
>                   from /builds/qemu-project/qemu/include/sysemu/os-posix.h:34,
>                   from /builds/qemu-project/qemu/include/qemu/osdep.h:151,
>                   from ../target/riscv/kvm.c:19:
> ../target/riscv/kvm.c:288:44: error: ‘struct kvm_riscv_config’ has no member named
> ‘zicboz_block_size’; did you mean ‘zicbom_block_size’?
>    288 |     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
>        |                                            ^~~~~~~~~~~~~~~~~
>
> Can someone have a look asap?  Thanks,

+Phillippe and Michael, there's already a discussion on IRC and sounds 
like there's a fix?

>
>
> r~

