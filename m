Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781AD7DBEE9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:30:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxW5R-0001V3-Fw; Mon, 30 Oct 2023 13:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxW5P-0001UC-0E
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:29:59 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxW5L-0006RB-T8
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:29:58 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5af5b532d8fso39160207b3.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698686995; x=1699291795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fcYqIckJwJqzebceNGkRXnnHc7nSGvpFW3k3cu5EXys=;
 b=lZSBOh8gGEcjAo0KcGL1ChEbKuwv4idtKnHpwPwdHQIRjllqr4cQbATdlqtau2ZzWL
 RBS/fWqBiULEUD9gan13sdlUCzBZT5VYo9RoVxU6LpZ4rdy4EZRbEF/cNqDY0xhN0gpk
 0zupDIejqtXKT3CjM+htwNf6mdybj2IPMkcE46YWBf/uPCNvtFjJxJ8aqqiPO51WZJ6s
 fDkjCof7xiucycI47SaaZgxb/bLPczxVZumYOmPl3v1Hg6qugIyOUZk/NLeG7kISu42J
 bVLMliJ24H/EvGOcW6alFo3yAlidcUIz6CryGYK9tOopeImRK1H7AvTJw6tVfXRtwILP
 61EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698686995; x=1699291795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcYqIckJwJqzebceNGkRXnnHc7nSGvpFW3k3cu5EXys=;
 b=ByJDoWqAG/NM40HIw+KGLlHTgH4tDV0MvcV9967R8QUdwqpA2E9MCqLH7ZSXfjigP3
 hdFkxtLFRql48oVf9zuyUQjdX8p9M7YhVaotnwspDOaLlE6glZxO/83ovgi1i1SKt5JY
 MbONCbRdX8eKRzeGTQmA5B6Sf8hlUP+64NmaNjffapCDBw+dCpMfyiWB6AmIzePLUh04
 oXg2jotw8mihxDmefnKZeR39d+KblfIVNAS4ZPoUyp7LhQdKDApTVOm06G4PB9PzRtUs
 CuTC6KT1M69ZPDjyGj7xLJQm2TgXP/4QKchkUuT4jQb+WsgO1QTCRYYLCv26oYOsezEi
 ZUKQ==
X-Gm-Message-State: AOJu0YxIiDvSdPR5Kng0ofKukc0qOthrv4LnP8okGVtur+k06lEBg0QN
 K7hmmj6mq25VPRgjOckIhuVuQw==
X-Google-Smtp-Source: AGHT+IHBQkBD38/CCu3unFIITzEtia9BybAYNbeZ7uy6SCcgkXYwjoILdYMuBTYmcgOIKHq4Jdu1xw==
X-Received: by 2002:a81:c704:0:b0:5a7:b81a:7f5d with SMTP id
 m4-20020a81c704000000b005a7b81a7f5dmr10305561ywi.18.1698686994701; 
 Mon, 30 Oct 2023 10:29:54 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a81be17000000b005b03d703564sm3915791ywn.137.2023.10.30.10.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 10:29:54 -0700 (PDT)
Message-ID: <aacea11b-af69-4c4b-8165-88034988ad66@ventanamicro.com>
Date: Mon, 30 Oct 2023 14:29:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] target/riscv: Expose Zvkn[c|g] extnesion
 properties
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
 <20231026151828.754279-8-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231026151828.754279-8-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112a.google.com
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



On 10/26/23 12:18, Max Chou wrote:
> Expose the properties of NIST Algorithm Suite related extensions (Zvkn,
> Zvknc, Zvkng).
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 992f8e0f7b0..8eae8d3e59c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -127,7 +127,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
>       ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>       ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
> +    ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
> +    ISA_EXT_DATA_ENTRY(zvknc, PRIV_VERSION_1_12_0, ext_zvknc),
>       ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
> +    ISA_EXT_DATA_ENTRY(zvkng, PRIV_VERSION_1_12_0, ext_zvkng),
>       ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
>       ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
>       ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
> @@ -1379,6 +1382,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>       MULTI_EXT_CFG_BOOL("x-zvksed", ext_zvksed, false),
>       MULTI_EXT_CFG_BOOL("x-zvksh", ext_zvksh, false),
>       MULTI_EXT_CFG_BOOL("x-zvkt", ext_zvkt, false),
> +    MULTI_EXT_CFG_BOOL("x-zvkn", ext_zvkn, false),
> +    MULTI_EXT_CFG_BOOL("x-zvknc", ext_zvknc, false),
> +    MULTI_EXT_CFG_BOOL("x-zvkng", ext_zvkng, false),
>   
>       DEFINE_PROP_END_OF_LIST(),
>   };

