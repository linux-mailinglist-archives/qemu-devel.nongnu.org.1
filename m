Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA77B685A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:54:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndy8-0000Wg-DW; Tue, 03 Oct 2023 07:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qndy6-0000W2-FT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:53:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qndy4-0007lS-R1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:53:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso7491995e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696334015; x=1696938815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EeVvwXrfxYvI/4qSiiegLJHCdhD76KziI3t7RkZApWI=;
 b=Aduh2A5msSlsNU9aVoUPDY+2sq2B8FJ1E7OW5gR7nuDgC124yQCoQRAn84x2ZNdJcC
 9S6Xc2yTnIPsG939ZMKlFGi2GDMwX/apvUIc/D7rQ2R5LN/v8vf7bU4HnfxxNGAgBn2s
 0FBdCPc+5D3qu+0IjT3Y05iiSpQi9yU2od5Gx/EfBvuyMy1vbNfiLJTxhUrVb27udjZi
 iBTm60N6xLYRtxxYOmOLKdZlBxgQziwD5UanpgHN7FCdSLHiKIYogpr9xBAr61YAMZ3d
 I9zGMZS/kqLJmimZYQx2hXltplrCUako3Xyf0sOLplwSZrB7TSORw/hmId/cm2Z4VpUS
 AQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696334015; x=1696938815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EeVvwXrfxYvI/4qSiiegLJHCdhD76KziI3t7RkZApWI=;
 b=kZPexA7GN0zQ9wc+n889crNlELXMIKqwb69nywTvwLlfFWrmUKhFcNuJM4tYNZzU2m
 r1xlQhQSuOD+YMvXFl553Ur17+PiTsvRJs1U04M9QWZPZoxRDymB7UXC7/NZ+lsk5kE/
 qN7wvSz+qcKGm7lQ2EYbTOqzsODzKRXZctasWK9G9UugpFNjDhXFVIkGBNMLmsyeDCsW
 Yq88Flj3JpD0mJQEgoarfnIilAw4ZHvwKu/QMK9CprVxcFGNQgBm+zM1Gi7AWQ45TPCf
 oCgHQw968H+S7P4qgSUnjCvHyXVUw38yuTwDaLHs2b5HcOxR9nYPlrH4bW8IbpdR24ag
 NBwg==
X-Gm-Message-State: AOJu0YwYAUyyJLwOb00HF4gXWtU4incqtevr4NnpVmBEPieo8gJOvyTI
 k5uYxq0gSfdg0RwzJ49fgCbRiw==
X-Google-Smtp-Source: AGHT+IHQp40VaVMij32qBMMaFPOFigpSBci+CbJReOUzjzhZAGvDIUXN8oZEXGjheWDzcsvDzv9/oQ==
X-Received: by 2002:a7b:cd0a:0:b0:403:787:e878 with SMTP id
 f10-20020a7bcd0a000000b004030787e878mr12642960wmj.21.1696334015078; 
 Tue, 03 Oct 2023 04:53:35 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 z6-20020a1c4c06000000b003fe2a40d287sm1126369wmf.1.2023.10.03.04.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 04:53:34 -0700 (PDT)
Message-ID: <f20c039c-64cd-8530-ef49-bfaa853adc4a@linaro.org>
Date: Tue, 3 Oct 2023 13:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] target/riscv/kvm: improve 'init_multiext_cfg' error
 msg
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Markus Armbruster <armbru@redhat.com>
References: <20231003113259.771539-1-dbarboza@ventanamicro.com>
 <20231003113259.771539-2-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003113259.771539-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

Hi Daniel,

On 3/10/23 13:32, Daniel Henrique Barboza wrote:
> Our error message is returning the value of 'ret', which will be always
> -1 in case of error, and will not be that useful:
> 
> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error -1
> 
> Improve the error message by outputting 'errno' instead of 'ret'. Use
> strerrorname_np() to output the error name instead of the error code.
> This will give us what we need to know right away:
> 
> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error code: ENOENT
> 
> Use "error_setg(&error_fatal, ..." since it'll both print the error and
> do an exit(EXIT_FAILURE) in one single call, allowing us to remove
> error_report() and exit().
> 
> Finally, given that we're going to exit(1) in this condition instead of
> attempting to recover, remove the 'kvm_riscv_destroy_scratch_vcpu()'
> call.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/kvm/kvm-cpu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c6615cb807..847cb2876a 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -791,10 +791,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>                   multi_ext_cfg->supported = false;
>                   val = false;
>               } else {
> -                error_report("Unable to read ISA_EXT KVM register %s, "
> -                             "error %d", multi_ext_cfg->name, ret);
> -                kvm_riscv_destroy_scratch_vcpu(kvmcpu);
> -                exit(EXIT_FAILURE);
> +                error_setg(&error_fatal, "Unable to read ISA_EXT "

See the documentation added in include/qapi/error.h by commit
10303f04b9 ("error: Improve documentation some more"):

   * Please don't error_setg(&error_fatal, ...), use error_report() and
   * exit(), because that's more obvious.

> +                           "KVM register %s, error code: %s",
> +                           multi_ext_cfg->name, strerrorname_np(errno));
>               }
>           } else {
>               multi_ext_cfg->supported = true;


