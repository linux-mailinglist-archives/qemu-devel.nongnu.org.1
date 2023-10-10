Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C97BF220
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 07:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq57W-0000oI-5r; Tue, 10 Oct 2023 01:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq57R-0000nh-Gw
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:17:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq57L-000538-Nf
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:17:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d3755214dso76778f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 22:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696915034; x=1697519834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=owv+AuILzhhGK8uNL4L6Y1OnngDL0/at4Csfkv5Axc8=;
 b=W1Blh6B0BclgQlZQjPSt9JrVHpCFa8wW/C1KEMoa8uh/RsGN/LHQWAhIJOF2sTmQnl
 dPNWdGmsNSq8c4EyzlTUjFGxXUfXJqM5cmD5VLp3Byo8qJom9B1GknrROxbgjIkI4FbW
 ZseJ1YS60zjRzJkLHhRwHDFtL96m0+Xur+8GCmmFPq9c2pIEfGqKMlKXnYJY5r5ldtBu
 MZRGPn8FkI8ul8ZYoWYpzFZwV2IhGNj23loYx0oUfhz/rc9kPkD1WEohPXIbHY4zWACl
 F9I4bjaGtx3N9Wd2aYarzTYQDRvCftklfapTVc6Y1et5Tp04Bnq5A+gcfGP0urAS3x6V
 n1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696915034; x=1697519834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=owv+AuILzhhGK8uNL4L6Y1OnngDL0/at4Csfkv5Axc8=;
 b=fALKzwvsbH1xK09+BCY+HlSi0VWbfHVek29Xv+YM8F/J6lMSp0t3YtX7URTkoGqUhT
 olkOQhYvovmzpCICM6GCaeY0vef99ATzcdjyZFh8fkOfPxyGF3gnXNPFnH3uj6bBSdkL
 2kWvs6bbRyVTL3nD2xzRWVJoLl3/M1sq2xVlhlbpOEpjvs/rDk5ADsSSDCPUTx01OYiE
 6qGDZXBrMJcrxPrXQRv0Z2q3jpMyobVheneVwlAtamm8l0z1YrZy3JmBmxE56O8Sv+jS
 yBs3KUBwJc8EZnyM2/bAWKuYBYAdfWkxm9vp1LMtm+mnPO1av+gQMytynHzNU0J8QCxG
 /8MQ==
X-Gm-Message-State: AOJu0Yyn3zjhbWLdw5iKx8RU9qgEhC9IHjfyihkSPJneXYPYgXaFGiza
 KwWWJw0yRe0PAq8dRwIad8Z2ABz/z/ylt7JS4p8=
X-Google-Smtp-Source: AGHT+IFjyVWQWb3RaXc1CorZV0XNCn+R5wXNUxEIE80uMXIl3HDIOysoYys65nF51oViXsvAZXDKhA==
X-Received: by 2002:a05:6000:14e:b0:320:a19:7f87 with SMTP id
 r14-20020a056000014e00b003200a197f87mr14771649wrx.18.1696915034055; 
 Mon, 09 Oct 2023 22:17:14 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 a9-20020a5d5709000000b0032320a9b010sm11527748wrv.28.2023.10.09.22.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 22:17:13 -0700 (PDT)
Message-ID: <759ca43d-6769-4455-e8eb-abcda6c85867@linaro.org>
Date: Tue, 10 Oct 2023 07:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/loongarch: remove global loaderparams variable
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>, qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20231009210018.249776-1-thomas@t-8ch.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009210018.249776-1-thomas@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Thomas,

On 9/10/23 23:00, Thomas Weißschuh wrote:
> Passing the struct around explicitly makes the control-flow more
> obvious.
> 
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   hw/loongarch/virt.c | 50 ++++++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 23 deletions(-)


> -static void loongarch_direct_kernel_boot(LoongArchMachineState *lams)
> +static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
> +                                         const struct loaderparams *loaderparams)
>   {
>       MachineState *machine = MACHINE(lams);
>       int64_t kernel_addr = 0;
>       LoongArchCPU *lacpu;
>       int i;
>   
> -    kernel_addr = load_kernel_info();
> +    kernel_addr = load_kernel_info(loaderparams);
>       if (!machine->firmware) {
>           for (i = 0; i < machine->smp.cpus; i++) {
>               lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
> @@ -793,6 +796,7 @@ static void loongarch_init(MachineState *machine)
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       CPUState *cpu;
>       char *ramName = NULL;
> +    struct loaderparams loaderparams;

Please zero-initialize with '= { }', otherwise great!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>       if (!cpu_model) {
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -898,9 +902,9 @@ static void loongarch_init(MachineState *machine)
>       /* load the kernel. */
>       if (loaderparams.kernel_filename) {
>           if (lams->bios_loaded) {
> -            loongarch_firmware_boot(lams);
> +            loongarch_firmware_boot(lams, &loaderparams);
>           } else {
> -            loongarch_direct_kernel_boot(lams);
> +            loongarch_direct_kernel_boot(lams, &loaderparams);
>           }
>       }
>       fdt_add_flash_node(lams);
> 
> base-commit: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d


