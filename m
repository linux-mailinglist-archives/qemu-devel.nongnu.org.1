Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E090F7DBED0
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:24:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVzk-00068p-Jy; Mon, 30 Oct 2023 13:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxVzi-00066c-JS
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:24:06 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxVzh-0005Cb-2O
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:24:06 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d81d09d883dso4011345276.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698686644; x=1699291444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aj/FM2O6s5O4r8LeHaXvFjgJZoX+186ufVYohUqtju0=;
 b=WFpptzVpELUgdjHEiaa93BohkVggF34TF1Xfl60JOg3zDU+ieY+5xJCyL+/YtIa38N
 q3RCn9X3c3vKHmk54fnM+SRlPaRQjTLtyponmVTxbl3HRXwZIG0Jayx3JJ7KzCe2dsCa
 uTpK38h500nxW5K7cW0xF4jbjwo0rYzXRnrzqa/WOB8RKK5nIbzM/OR+jKJ4qGRXlARf
 rA4kH9RfpFtzbbazrQAt134rVIZnlue0rSVbNQXL2KFwWtaphYy98BaHQ3REsfKb0NbT
 6j6xSYxBiy7nsP184YECgjySdW2Oqx/UJTm2qWhVJmhPjysRoEE/rITFjUhB5wlDT6xo
 0h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698686644; x=1699291444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aj/FM2O6s5O4r8LeHaXvFjgJZoX+186ufVYohUqtju0=;
 b=Yhtxf6Phb7Wop9mMZsUgYZPUVIxaCAelmV5dv9kuZti8tqnXEWrlmCCI3B04c6LyL4
 irTFUVx+iqAbJcWfSi9RG3hcGGn8Fq/qXMbk6O6o2Ny7u2WneXJucINaMzzB39QGCtR2
 70FolmbU7AQ51a2JomgPPLil7jCThqyY3S6iO3h3tRhYB/hxRgtLoma1NXf9AXLatBrw
 mXPMYHi5u+ATwxzrbQC2+xWsy04Ekhdhnbk5wa83Pxpvm0yXJPi8ePaNQMxCX9c+65/c
 sWfMXgMdTgithW9GDqunSa7Okc4ANF72++eDC0aVJSdELWwg7D5nTtFy03wCvXtz+IIX
 1KXA==
X-Gm-Message-State: AOJu0YwMzcnlJM9s5S93z/dnGCuIWI1G5d17v1xTAPtt8lK+H/KpvSZo
 qrU+Rwvy//VrcEoFLDO90AiMNw==
X-Google-Smtp-Source: AGHT+IEt6NJw9uKMsm4reRKfv90n1UT81O2iGSbRQfauZDBaiV+vIlduzlt1vwinHiF2qX68C51xeA==
X-Received: by 2002:a25:e68e:0:b0:da0:411a:a393 with SMTP id
 d136-20020a25e68e000000b00da0411aa393mr8553486ybh.25.1698686644142; 
 Mon, 30 Oct 2023 10:24:04 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 m65-20020a253f44000000b00d974c72068fsm4074115yba.4.2023.10.30.10.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 10:24:03 -0700 (PDT)
Message-ID: <6516f641-4d65-4141-a1de-8a4fcf1c32d7@ventanamicro.com>
Date: Mon, 30 Oct 2023 14:24:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] target/riscv: Expose Zvkb extension property
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
 <20231026151828.754279-6-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231026151828.754279-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 10/26/23 12:18, Max Chou wrote:
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5099c786415..992f8e0f7b0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -125,6 +125,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>       ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>       ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>       ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>       ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
>       ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
> @@ -1370,6 +1371,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>       /* Vector cryptography extensions */
>       MULTI_EXT_CFG_BOOL("x-zvbb", ext_zvbb, false),
>       MULTI_EXT_CFG_BOOL("x-zvbc", ext_zvbc, false),
> +    MULTI_EXT_CFG_BOOL("x-zvkb", ext_zvkg, false),
>       MULTI_EXT_CFG_BOOL("x-zvkg", ext_zvkg, false),
>       MULTI_EXT_CFG_BOOL("x-zvkned", ext_zvkned, false),
>       MULTI_EXT_CFG_BOOL("x-zvknha", ext_zvknha, false),

