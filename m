Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8497778D67D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:23:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbM6H-0005ed-BK; Wed, 30 Aug 2023 10:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbM6F-0005eF-Cs
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:23:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbM6C-0001kZ-V9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:23:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c8a710545so3767868f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693405391; x=1694010191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b1leb0wNNwRUuqwuD6a+TAb+IlxEUDu7bs+ZWBfVdz8=;
 b=BpNo36uf4YukYWCufVDhEnycUCCiJJaYX/ZXtF5BCF+Ukj77lCFiKMQpbwU3DZ+ewd
 Nw8oi3pPAB3ZFDIzvaBg5J9CQIylaFCrWN3flQKny5SIQIA1ANASUmRuz61uK7SNraDi
 87WlkTnVlSVTaNONaNx+92/FpF0JWAdtRfCJwU3VqBi4v6n8Y9C3zoELYnGLmVFp6dUF
 nyNHxkZkHRKL8HSL+9p22e9YrKhGfCbJp1OVHeOYbfV50v/rCI3d6DW9HoVzDaha9JPn
 Bu3C+lYMCVAsF/gmNBwb3jp9VCwhp7BbJKPKVKiLSsbGd9wEkiQPa2eWZf4wCVHLUZPk
 wChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405391; x=1694010191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b1leb0wNNwRUuqwuD6a+TAb+IlxEUDu7bs+ZWBfVdz8=;
 b=R+4PqUg087ECq+Q2phKJt3BcbqusyTmhL01s4oFi5/xsArnlcQxv5AKpGoWgi03qPo
 415yUAZRW+24HC7I4V4P+wrNHZ2KC8qbtsxnat/RXyEDYMve7MmROjXHvqgqhfXqcuSa
 tBf2bfxUEd9/5+yUcWSyC1+Umn9UlVHyxRIg0TErDzo37b7n+B9ZMc2llWc98B7SL1nE
 oZkFBZXNozcB1OO0PgCzcAaaor2YM3m7Ehbl22nMRsTLPm1mGHuMe9JeIkZ6dtxtEsrw
 ocwO4D6VswGBRWY8BBjW1GreiQHDSBbpEj6czbSwnZwBkQ2ApdlpEC4e66PzbdBNabbi
 ae5g==
X-Gm-Message-State: AOJu0Yzc/xNJoGz1oKAfQENqioqOyQEZEKyj2PWQDN0r0KUkWeWMrqAk
 6Ea50HhGndAErjksGiswWNUnPQ==
X-Google-Smtp-Source: AGHT+IE9HtbzIqFb9tN2f+EB6QaM5rSRaCy5kdfMr/Fo+yq+s4lKqTyx+xQhEL4AwWUwBggK/Pb/+g==
X-Received: by 2002:adf:e550:0:b0:31d:74f8:fae with SMTP id
 z16-20020adfe550000000b0031d74f80faemr1498371wrm.71.1693405391357; 
 Wed, 30 Aug 2023 07:23:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a50fb8a000000b00523653295f9sm6736745edq.94.2023.08.30.07.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:23:11 -0700 (PDT)
Message-ID: <223eba47-53b0-e33a-625c-6cc64dab9e80@linaro.org>
Date: Wed, 30 Aug 2023 16:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20230830133503.711138-1-dbarboza@ventanamicro.com>
 <20230830133503.711138-2-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830133503.711138-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/8/23 15:35, Daniel Henrique Barboza wrote:
> A build with --enable-debug and without KVM will fail as follows:
> 
> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
> ./qemu/build/../hw/riscv/virt.c:1465: undefined reference to `kvm_riscv_aia_create'
> 
> This happens because the code block with "if virt_use_kvm_aia(s)" isn't
> being ignored by the debug build, resulting in an undefined reference to
> a KVM only function.
> 
> Add a 'kvm_enabled()' conditional together with virt_use_kvm_aia() will
> make the compiler crop the kvm_riscv_aia_create() call entirely from a
> non-KVM build. Note that adding the 'kvm_enabled()' conditional inside
> virt_use_kvm_aia() won't fix the build because this function would need
> to be inlined multiple times to make the compiler zero out the entire
> block.
> 
> While we're at it, use kvm_enabled() in all instances where
> virt_use_kvm_aia() is checked to allow the compiler to elide these other
> kvm-only instances as well.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: dbdb99948e ("target/riscv: select KVM AIA in riscv virt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Yay!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


