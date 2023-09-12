Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0179CA87
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfz2R-0003Ew-Ux; Tue, 12 Sep 2023 04:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfz2K-0003AY-0Q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:46:21 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfz2F-000856-1t
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:46:18 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bcc14ea414so86869021fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694508368; x=1695113168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IaIpdfFdIg0V0NEXUo323NCr6qnLfOd1WKVqiLJu3Q=;
 b=BfTRK91ejRCMIyRAh8Nr6bFeGmUzyvO5ohKCdfvCB8+wIo+lxtEYhEEp+qAerV2KNo
 +RJanciI+ISAgkhfHC0k4ZtOZg/uBh8exxvltLHZT2CAvbWq+6P6WP07pitm7ish6zS6
 a34eZ8sbDSORoyLsq0yIKJVyFe4UdiRUUaaIHdQ8eZZ216dkg+yzAnVCJbPoiy9zwcyB
 3+km+3SplcZoS7SsNwFyG8Alx86r/l/tD42TIwLhaoNIGLWG86DFbv9qtS75jvx1HhEY
 pDYmn4+M69rtghF7taXReDejghFcUM8g4yN9WLtH1iFKHaOj1SgScVv1hsa01Xi3PYuD
 P4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694508368; x=1695113168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IaIpdfFdIg0V0NEXUo323NCr6qnLfOd1WKVqiLJu3Q=;
 b=IFOBjpihNbbz14Oz9RcWRgHXY/osjf1wHk7s09ACz6iPkqKozKG9BDyWtylt192YjO
 E1hMY90IA2jw1a3uNs7UvQdGEA3XuAQ8YozCvMYoGWqZ5QWMAfz4AFqpsVcP6Dx0ZpJF
 zyzjdkOpD7XFTQp9S0C0CRM3TBUeBY9iFhXCMR+02WHyY/ELkcqHX59zDJrnPppt8wgy
 /9dcCpphfrKCiFQqPPoHcMpJnyMjGyy1ltnLm65P7yGfEwZiBSqYCu0Dbg00X0q69naU
 2Y0itCDRPmres+fMqzidqLPNJ4b36qj4BX6Q4kcgVlMtSfZaDkUv2+eiKFHP92OPDIc0
 IhNw==
X-Gm-Message-State: AOJu0YzxPVJSTybvsfc3HGt7RA0vS80UaFRsxDI4LFRTsd7ucOI6JIaa
 6MKHlYp+0uN1g+/f6ilOCW04Ew==
X-Google-Smtp-Source: AGHT+IEGEZRDGuYeVsyidPmqbSiMAzd1YDObrZlbZv1zXhYXrSAGkczS7UHHwgE791ekSv8yHl07hw==
X-Received: by 2002:a19:e057:0:b0:4f8:6d53:a68f with SMTP id
 g23-20020a19e057000000b004f86d53a68fmr8617912lfj.64.1694508368177; 
 Tue, 12 Sep 2023 01:46:08 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 eg27-20020a056402289b00b0052f3e8c84fesm3536127edb.29.2023.09.12.01.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 01:46:07 -0700 (PDT)
Message-ID: <1f64f982-95fc-786d-1217-856a62335eed@linaro.org>
Date: Tue, 12 Sep 2023 10:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v7 14/18] cpu: Call plugin hooks only when ready
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
 <20230912071206.30751-15-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912071206.30751-15-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

Hi Akihiko,

On 12/9/23 09:12, Akihiko Odaki wrote:
> The initialization and exit hooks will not affect the state of vCPU,

What about:

  qemu_plugin_vcpu_init_hook()
    -> plugin_cpu_update__locked()
       -> plugin_cpu_update__async()
          -> bitmap_copy(cpu->plugin_mask, ...)
             tcg_flush_jmp_cache(cpu)
             -> qatomic_set(&cpu->tb_jmp_cache->array[i].tb, ...)

?

> but they may depend on the state of vCPU. Therefore, it's better to
> call plugin hooks after the vCPU state is fully initialized and before
> it gets uninitialized.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   cpu.c                | 11 -----------
>   hw/core/cpu-common.c | 10 ++++++++++
>   2 files changed, 10 insertions(+), 11 deletions(-)


