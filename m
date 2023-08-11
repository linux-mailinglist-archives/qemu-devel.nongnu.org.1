Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F08DF779628
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVzX-0001jx-U1; Fri, 11 Aug 2023 13:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUVzW-0001bh-1F
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:32:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUVzU-0001iD-DB
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:32:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-319559fd67dso1206440f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691775119; x=1692379919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tJ6wze5Ev7qTzP0XKtMqLGV98LSKnRojGydpd0O6zb8=;
 b=Qw6PVzbbUJqRsZXceRfgBHn1DWTotp/SMo7BuzHVYo7/Ysbmk7CpdddiqRfs9dEsOv
 o01PlJu0k71lxCxIB8fmWmGf0mnS7F+ZUmXm846xVm2m8DE3Ny9jVsMAimNWxYxK3DHx
 dYzSlX9sUHGhNu85hVZM/UdzqVNP+J8Q30eKTofFVzHuYLszesyLOsp6iWyqKcJkJdM3
 YsQAsiyLZOVzs4cQr6oxrb6G3T7w5njr+IbLk6lg/0ZRHTGVvr8raE4ctl7hm17PF6PC
 Y/g4BJFelgQUZ6iwWdWSx4WsMQIeLC1IBLsymT29ScZhlEAg1kLaT1nolY33Kaxu0Kbx
 RcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691775119; x=1692379919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tJ6wze5Ev7qTzP0XKtMqLGV98LSKnRojGydpd0O6zb8=;
 b=IDKL3UnxNuVh48jbAg8fPabJlkur9ezYJwH9Iwzgu2kRdmBIOLjeGlmzxjkFtVyYyo
 OotTl4IwIYawze2puw/7lXC5A4qZC3NRgMrdWrcs4ult777GGTeVsPXAm2oyWICNBBIj
 xz23cIj6IVwUkoCnd+WC//Qa+7OkjjOPcdV4bacMrwFY8k66meVwr7q0JxGIVnr+fT3K
 rXEMHfH5Xg5OGA9UZnrdDU1+UB2JKhxlov4w0kzJOKPCyQchwctG77QjFJrNLtq/cUlN
 sRbo/e1/irWTXACF9skld6kvlaxU/inEFMgAv+ybdO+JfhP9e+DsME6kWzDCdYhoSM6C
 TTjw==
X-Gm-Message-State: AOJu0Yx9OmE6ZdfTEKo1kVvXr+Uf7ZVASMFUEGsiD22ks4LnBPPh1E7Y
 /DLO5aF0wA8GJ4Z+LljKtW60C1KHcJsURFVsRyU=
X-Google-Smtp-Source: AGHT+IGLPrmdIXp5cBMFt9sAzZnGPmv4USbL8SyEvFr9D7j/x+QDOFXESEPMtASVD+gJjRuwOGruaw==
X-Received: by 2002:a5d:4451:0:b0:315:a1d5:a3d5 with SMTP id
 x17-20020a5d4451000000b00315a1d5a3d5mr2166331wrr.22.1691775118501; 
 Fri, 11 Aug 2023 10:31:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.219.164])
 by smtp.gmail.com with ESMTPSA id
 v2-20020adfe282000000b00317ab75748bsm5962331wri.49.2023.08.11.10.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 10:31:57 -0700 (PDT)
Message-ID: <62f89b23-720b-2a04-8bbc-ea969a32c435@linaro.org>
Date: Fri, 11 Aug 2023 19:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.1 1/1] hw/riscv/virt.c: change 'aclint' TCG check
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20230811160224.440697-1-dbarboza@ventanamicro.com>
 <20230811160224.440697-2-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230811160224.440697-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 11/8/23 18:02, Daniel Henrique Barboza wrote:
> The 'aclint' property is being conditioned with tcg acceleration in
> virt_machine_class_init(). But acceleration code starts later than the
> class init of the board, meaning that tcg_enabled() will be always be
> false during class_init(), and the option is never being declared even
> when declaring TCG accel:
> 
> $ ./build/qemu-system-riscv64 -M virt,accel=tcg,aclint=on
> qemu-system-riscv64: Property 'virt-machine.aclint' not found
> 
> Fix it by moving the check from class_init() to machine_init(). Tune the
> description to mention that the option is TCG only.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Fixes: c0716c81b ("hw/riscv/virt: Restrict ACLINT to TCG")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1823
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


