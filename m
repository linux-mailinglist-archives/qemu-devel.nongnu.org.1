Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB979DFE3
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJBp-0003ff-IU; Wed, 13 Sep 2023 02:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJBe-0003do-0x
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:17:18 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJBb-0002ZR-O3
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:17:17 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2bcb50e194dso109503691fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694585833; x=1695190633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpdEawBfwM4tBqlm00fhzZrOIUg979SX4YhDKvSSNlc=;
 b=P3hMUotQibcuT2KNvebCQDpydrqOXni3KIye1+gLiheMZBonNXK31ZcSyNCRqlU5Zm
 9rbHck+N5Hzo5ZCpbcXBi+z9UGbPMHO4XSiX28Vx3sxQrmkniLPtrW3loZMz/T0mO4JC
 pg6504v0My4aMwLJeX1GASj2wNktcvy/rwTAkC0mZ8jaITmSDK9VITLP7vN5K6/U26Y3
 olP6lKwgmj7OBoC6KA3ItvyyoVNTkENX7XMHr0/9cvB7KM3CfSrmJW3pIwMjqSk3gfFD
 iKeWTXuUow58oTo7VyoCKc5KFe9LJMxhK5xuJCkxsURNKhfH62Pp369kYpR0iS2wiB7i
 FiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694585833; x=1695190633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpdEawBfwM4tBqlm00fhzZrOIUg979SX4YhDKvSSNlc=;
 b=B6CFVD65Y46M5Fxq3oyoRZQEtGwMjSd/TEdgIVKaYV6qeBq9Pgrx4Fh5fQk3TiYa6r
 cvLJYrcOFs6OC3+8NTDK7w1hd0HwQjdehx+ehESRRFTro8tC3y66U2aCo737xFANm/uA
 E5tSWvfctPy818KhOtppXGnlsezESQ4rf0r/TancFmbmQ/8QS/vp3oMCh0/RDXgMJQ2O
 RMebZuECEUgeTjZ2R6QKo6fRAxf+xX9aS4ugMNOpa6Om1QQGLcvblrnTHZFzgL6MpEQG
 4Y6HY7ucIF/veBf4QxbPKvRuJZMWccbJytgz5ctcEHAeSQWCaI98y3dCfb0sVQmX5Jc1
 XK0w==
X-Gm-Message-State: AOJu0YwvEnpdgzZBotbOLRN1pOCupV7ycepqa9anffeAM38Nor0ukOWh
 8rmYY+NgtYxx6yFNVSJCnbjx/A==
X-Google-Smtp-Source: AGHT+IF6s2PFNmoNvgOpDEtdIJX6SZrhBk1UqJt7yoVIXy26m3o9yIgkSwr98w7cW2H8dhQCRxPFOw==
X-Received: by 2002:a2e:8843:0:b0:2bc:d7d6:258f with SMTP id
 z3-20020a2e8843000000b002bcd7d6258fmr1581113ljj.35.1694585832758; 
 Tue, 12 Sep 2023 23:17:12 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 f20-20020a170906825400b00992f309cfe8sm7937725ejx.178.2023.09.12.23.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:17:12 -0700 (PDT)
Message-ID: <bf33447c-119f-c4b9-5f80-d4ad6169c708@linaro.org>
Date: Wed, 13 Sep 2023 08:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 03/12] plugins: Check if vCPU is realized
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
 <20230912224107.29669-4-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912224107.29669-4-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 13/9/23 00:40, Akihiko Odaki wrote:
> The created member of CPUState tells if the vCPU thread is started, and
> will be always false for the user space emulation that manages threads
> independently.

Per the docstring:

  /**
   * CPUState:

   * @created: Indicates whether the CPU thread has been
   *           successfully created.

Each CPU DeviceClass's DeviceRealize() handler which calls
qemu_init_vcpu(). Ah, what we miss is:

-- >8 --
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -14,6 +14,7 @@ void cpu_remove_sync(CPUState *cpu)

  void qemu_init_vcpu(CPUState *cpu)
  {
+    cpu->created = true;
  }
---

Missed in commit c7f0f3b1c8 ("qtest: add test framework").

Does that help?

> Use the realized member of DeviceState, which is valid
> for both of the system and user space emulation.
> 
> Fixes: 54cb65d858 ("plugin: add core code")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   plugins/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/core.c b/plugins/core.c
> index 3c4e26c7ed..fcd33a2bff 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -64,7 +64,7 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
>       CPUState *cpu = container_of(k, CPUState, cpu_index);
>       run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
>   
> -    if (cpu->created) {
> +    if (DEVICE(cpu)->realized) {
>           async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>       } else {
>           plugin_cpu_update__async(cpu, mask);


