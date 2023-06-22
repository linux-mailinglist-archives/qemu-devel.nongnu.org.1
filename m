Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D5173A796
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOOd-0006Nh-DY; Thu, 22 Jun 2023 13:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOOU-0006Kq-GS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:46:55 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOOS-0006Cw-M0
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:46:54 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f875b267d9so6549668e87.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687456007; x=1690048007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y9a7YoYe3T0MbLBO0L7+zRiLRSaGbDua3R68SVuQkUE=;
 b=S3aJfe8OPD1b3iOHso9gShg+orahkCpBFmblOyHZjOMtfsC9rAS4LohByD3rLonWoE
 evq7uhrMz4t/6OGegMF1W2itotOgLRl27ovwraKfI7Ysiyht7S5BcZLMoBYnV/Jw16XA
 RHWoykN+6S8jp3lN6clSZc2jOJeleeQJMv3bbDs/LwzKaddO9YOneCTMKO/FPxwioUlb
 UCTyeKcuQuR9Fn98+Z4JJvz/OGRnUXY32TnqjJNcu8bmZyLxuQxi0IUPExbQx/HsQwkh
 b9CDB45a87awo/swZ8Gz2lkB+qFhv0XGbCPFnTcMsnmzlJD5yWcejihYecJKQ3KSmaRA
 VMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687456007; x=1690048007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9a7YoYe3T0MbLBO0L7+zRiLRSaGbDua3R68SVuQkUE=;
 b=hKXGj2t54A0+8j+EKs0VEhuxKkKRRA0De5xFZLS5K3l9n9SQe/kpnbZKGVKPSuONRj
 CCOEaQ6zl6Au31pdzoj6PCrNBMo+kafkKB44BiWs9oLkttq6hXxL9YpMe5Vf+DTRPyf5
 XzCtc/h2gB/hBJ2Xpe3Rc9J3QF/v4A3xT577uVHEcDThqSw8DCHCa7w1bSvCrxQEyR0b
 SeC+TTU3yd8TKqflqTkr9i2a253Kgm75t6J/kVJ5ayxL8NiHb2HNIFxoLnZkJdtzJkXA
 udon/KQS50w0tnKq0fjm17t94BCEZt2BIRYWSLpLR1Me1GThKMUVefh9BQI69JejwhHS
 Yakg==
X-Gm-Message-State: AC+VfDymRBbRe7ZXMznkuIhdzeTp6aOu3I3wktzq4DPM63F9QQHlRbO/
 cICKLchNbHK4eCq1OvDVAkkRLw==
X-Google-Smtp-Source: ACHHUZ5haGO8m6yiOqgmROBAyNlMVacxQPLIXMYcwaQC+7P/x0bXWpeMMk4iIZ27Jh55lZjOPBtZAQ==
X-Received: by 2002:a05:6512:3b12:b0:4f9:5d2a:e0ee with SMTP id
 f18-20020a0565123b1200b004f95d2ae0eemr4589292lfv.16.1687456007327; 
 Thu, 22 Jun 2023 10:46:47 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.47])
 by smtp.gmail.com with ESMTPSA id
 h23-20020ac25977000000b004f874e12e72sm1198114lfp.224.2023.06.22.10.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 10:46:46 -0700 (PDT)
Message-ID: <2c0a97af-be7e-6d83-5176-ef9980c2faf0@linaro.org>
Date: Thu, 22 Jun 2023 19:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/16] accel: Rename HAX 'struct hax_vcpu_state' ->
 AccelCPUState
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
References: <20230622160823.71851-1-philmd@linaro.org>
 <20230622160823.71851-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622160823.71851-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/22/23 18:08, Philippe Mathieu-Daudé wrote:
> |+ struct AccelvCPUState *accel;|
...
> +typedef struct AccelCPUState {
>      hax_fd fd;
>      int vcpu_id;
>      struct hax_tunnel *tunnel;
>      unsigned char *iobuf;
> -};
> +} hax_vcpu_state;


Discussed face to face, but for the record:

Put the typedef in qemu/typedefs.h, so that we can use it immediately in core/cpu.h and 
not need to re-declare it in each accelerator.

Drop hax_vcpu_state typedef and just use AccelCPUState (since you have to change all of 
those lines anyway.  Which will eventually allow

> +++ b/target/i386/whpx/whpx-all.c
> @@ -2258,7 +2258,7 @@ int whpx_init_vcpu(CPUState *cpu)
>  
>      vcpu->interruptable = true;
>      cpu->vcpu_dirty = true;
> -    cpu->accel = (struct hax_vcpu_state *)vcpu;
> +    cpu->accel = (struct AccelCPUState *)vcpu;

this cast to go away.


r~

