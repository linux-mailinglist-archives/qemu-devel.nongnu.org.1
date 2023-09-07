Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5EF79711A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAxf-0003pi-2U; Thu, 07 Sep 2023 05:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAxa-0003np-E8
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:05:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAxW-0001ko-BO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:05:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so82490166b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694077553; x=1694682353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sNvlFII/zr6hx3iOeBbwbNkYhLmKfkOrejhoci6C4/E=;
 b=vMUmg0P5VbF5o0QiauRtLFuPYESTjtcNTiXF2A1osGMZltGKsbUpUJYa7FkCFji/tm
 zmNzAn10a7kapXRJ4bGWJTNMAEQXjEEKStOpWj2ms1EvNe7yvBQ2U370lhCUvvSJDsux
 B5lvm1XYFpQckPW7++alJsJ4dV1kkQzflvRNWrls8IVvC56pX8uCBEMbfv6V79ygu0ci
 YinwFHDvDRsY4azwRJOCloKNtElBrm/0pCyZLdh925OwK7yP8iqrAYv/lfb60vXLUr7C
 K5xKeBrrXI5XyLcXptf9JcINQH+MNN8FcDZmJAlyrP+3IZBlV7xF2tUdWYgn4yr4Mnn2
 3Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694077553; x=1694682353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sNvlFII/zr6hx3iOeBbwbNkYhLmKfkOrejhoci6C4/E=;
 b=lGQVFiWn2Z0faMYjJmeEle99SBzvaVBviHnqacm4LdNsVJY6JAJDsX8mXE617NPHlh
 MAOV6eZiwAwiKXS18gtWDxm5yS/p+pnSxonQ4CPI3m/fpxHeUt0NTbf5FzPqEPJNkT/e
 5nQ/ur7QAUth3u6mYz51NQWQqCAdu/3+x5yry5SMzPxX8oK2z6GKfGYGgj0d212YUv/Y
 TUdSwuepDu0IZrW7bF86c8QMpiqrKpzZmxVopSq/H6mF/NLmSz4YOH7S0CYr6K/N1a1g
 AV+0uSZWr/Jq6wNyHKGdqD+3+c9ordRZTsIx2KnQVQqXnGoWl5ArMTfV3iB5SmG0oQP/
 UrUA==
X-Gm-Message-State: AOJu0YytFs+Vd6h7VAwg/h+y8+MQI2chvDBF7HgkLQRGLI2zBvjyb9Bd
 a+6W13m9cVpvt5wwjj0lVOPj3A==
X-Google-Smtp-Source: AGHT+IF+WYstU7iBgeW8KYOXqDnRYwhgpgv6W3ndRBw2UMus/zS5k7olX3DVrgP0KKlCplDTaqpTPw==
X-Received: by 2002:a17:906:318c:b0:992:3897:1985 with SMTP id
 12-20020a170906318c00b0099238971985mr4536976ejy.43.1694077552903; 
 Thu, 07 Sep 2023 02:05:52 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 t1-20020a170906268100b00993150e5325sm10210741ejc.60.2023.09.07.02.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 02:05:52 -0700 (PDT)
Message-ID: <6722766b-4bda-38f4-e711-fc9627938d25@linaro.org>
Date: Thu, 7 Sep 2023 11:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 30/32] hw/arm/sbsa-ref: Check CPU type in
 machine_run_board_init()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, imp@bsdimp.com, kevans@freebsd.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org, laurent@vivier.eu,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 mrolnik@gmail.com, edgar.iglesias@gmail.com, bcain@quicinc.com,
 gaosong@loongson.cn, yangxiaojuan@loongson.cn, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, crwulff@gmail.com, marex@denx.de, shorne@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, ysato@users.sourceforge.jp, david@redhat.com,
 thuth@redhat.com, iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com,
 pbonzini@redhat.com, imammedo@redhat.com, shan.gavin@gmail.com
References: <20230907003553.1636896-1-gshan@redhat.com>
 <20230907003553.1636896-31-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907003553.1636896-31-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 02:35, Gavin Shan wrote:
> Set mc->valid_cpu_types so that the user specified CPU type can
> be validated in machine_run_board_init(). We needn't to do it
> by ourselves.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/arm/sbsa-ref.c | 21 +++------------------
>   1 file changed, 3 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


