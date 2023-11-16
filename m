Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC997EDE73
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:28:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Zb3-0007bn-Dh; Thu, 16 Nov 2023 05:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Zb0-0007ZU-Ua
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 05:27:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Zay-00055g-5O
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 05:27:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso5380315e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 02:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700130454; x=1700735254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OkM4Bw5MFHZEcuHs1O7vsROMPAxusBw9ZR7571XzPsM=;
 b=EE/kQTkzlSpEyjAKUKRifYh5jabTsSmnYWTUTzEpHay9aet3/s8e5StMbtQzvfzwNR
 iMTtOm+I68fcndrr8B/CpZpuxBD7MdRJS2Q7wZ+u5iiwBieQy2wjOtdOvMb2sp3hbcv1
 +swi+p9C7gyNjvd3Up34nvZezfPZY67VxYvwlV3+4LU2Kql9Ds9Rx/9fiHUM27BP6Fod
 vwXvrAVEDJ7N0SsH9gDv/GMLxtwERJFLHW7snyWIFEUTlDgxEw5ly3enY8VAb5cXl7Mv
 EOZGUqiVfxO+mUaBB4tWpN6cujQw/uMLv3OKSG6DvjnaemGF+z9SPBuBJlBcM+GcvEI7
 ynvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700130454; x=1700735254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkM4Bw5MFHZEcuHs1O7vsROMPAxusBw9ZR7571XzPsM=;
 b=xVG722TabewjSpIxPV4OqwfkHef+uSMF1dTaY7yIAJL0a6r8GadJFOF40FEGJvZmmL
 5Jui2V17vilj79QMS0wwgWZ2x6XqcFkY0FBqMWayOAftNVgBbN97yW1LwHL4IRvB4j7m
 X/g7MVnxKVRxuyUPFb3lzZa7zpBiDwbDT6N3d1La8GUzkhWgwPDcEDawklgrFt8bIh0f
 v17R+B9iYeg6wToAHaHbppxk6D0D1xWhxi500EhOEJkXgQxuEgXgynOm1v1uoGLAV4tz
 BApeibteOiHCa5CjCHeMtHxYHAUfnXWs6380yYUz0QHwTXloKil4zv6xERNjqkR49YWK
 NaLA==
X-Gm-Message-State: AOJu0YzQB2rgx3y5U3aBdgbrsLgVwubhvbHFIo4N1D+hwKmYxf6/jOwN
 ugEuKBMZ2OBn6nqHicVeH+zJUA==
X-Google-Smtp-Source: AGHT+IEO1S1neAE6yc+0rR8Pk7bF9Hb7F7yrMtV+ch5Cqy2ogg8CkJePxsOxlpR2cnfOgKBwYa1sbA==
X-Received: by 2002:a05:600c:46c7:b0:409:4e8f:4b27 with SMTP id
 q7-20020a05600c46c700b004094e8f4b27mr12363511wmo.33.1700130454278; 
 Thu, 16 Nov 2023 02:27:34 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c138500b003fee6e170f9sm3001006wmf.45.2023.11.16.02.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 02:27:33 -0800 (PST)
Message-ID: <f64fcf96-045f-4309-aeb5-b2dfa23eb1c4@linaro.org>
Date: Thu, 16 Nov 2023 11:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/31] target/loongarch: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-14-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-14-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/11/23 00:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
> la132-loongarch-cpu
> la464-loongarch-cpu
> max-loongarch-cpu
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
> Available CPUs:
>    la132
>    la464
>    max
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/loongarch/cpu.c | 15 ---------------
>   target/loongarch/cpu.h |  4 ----
>   2 files changed, 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


