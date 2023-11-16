Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67A7EDC61
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:52:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XAc-0002BH-BT; Thu, 16 Nov 2023 02:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XAX-000232-8X
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:52:10 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XAR-0000p3-D0
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:52:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32fdd0774d9so370795f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700121120; x=1700725920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CcGc/F3HmXGhqHi4Jn0NHvvOKQ2BV2fAcF7rQNbl5bw=;
 b=K4SBR5F34GVApzMFdlfIDaClS3hVyw1LhXmdf5U3SYkQbDQfmFWRbwEOCDSwjKhsig
 6zVp6hndJtpWbomvkWqPA4p7b5B1BPkUAZ2347c0k9l2ZqVi2dFfz/T5O2MaIg5+n1p7
 ppSILkUlEg5RlS4akrJ0KREqEVL44X6TUTpKh3G1Eq4FYpTuYxBFC+5HkO5Ggl7NjEub
 iDftdoXhNuwIMP6brqgTf/CmpIDGu+yuh+KMEAOHDG6LF4oBRhraPvKy+B1FyYmzX58L
 m6+O+904zvYVBOVe8tCGqobihhoUNXEGKG6Kdpv0QZI4VlTIMU/2mQyqgwo1qbrxcaQt
 I3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700121120; x=1700725920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CcGc/F3HmXGhqHi4Jn0NHvvOKQ2BV2fAcF7rQNbl5bw=;
 b=Pxr2uWNmhdxY0Qf8tIzXE2RkqEPf55K+oc9wqEJCOyvdvAM58wpZG5Wd+v9gLAbGGK
 E36VvORZTG9SduxiVcqjdnxaPXx8Ihydp8CW3U/nrrdNpKfexmOX3kbz+k9T2otFlyFA
 K9BOboD8AdTHsSRsg3VHhydEcuU8342Trke/4qhtKvBb5hLl01Ss9ZtVEWqAK8755IZP
 V4egr8VZ9+g2Z0AGVqAqcJP+Pfy/FyhyJ2zKKe3uaJsykTg8lryeQI/fhoTcRZXmAk2S
 RV6HR4Aujckn4jspWo/ql+oMDxou71b8s5RrIsZ0ufHBHBlti0XEb9hRhsskj2r3KaQ9
 zAlA==
X-Gm-Message-State: AOJu0YwTBA2Sc+XbOT//vw3TNatFcE+h9wkVeoBULeJSN5yXujE1Hca7
 UwNC68RTaCM0Id7PS7jrvEAbPg==
X-Google-Smtp-Source: AGHT+IGG3VxXKISUW2I6V9ic/oorCLcuMPiMmJKfLhvmdUqc66gv80Mtp1emaq2REuHQoyeBOEgY3g==
X-Received: by 2002:a05:6000:144d:b0:32f:8008:bdbb with SMTP id
 v13-20020a056000144d00b0032f8008bdbbmr12413103wrx.51.1700121120029; 
 Wed, 15 Nov 2023 23:52:00 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000024400b0032fb0e2087asm12582889wrz.82.2023.11.15.23.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:51:59 -0800 (PST)
Message-ID: <0bde6643-6df4-4a6a-88b1-d9501840a47b@linaro.org>
Date: Thu, 16 Nov 2023 08:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/31] target/avr: Use generic cpu_list()
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
 <20231114235628.534334-10-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-10-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
> [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
> avr5-avr-cpu
> avr51-avr-cpu
> avr6-avr-cpu
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
> Available CPUs:
>    avr5
>    avr51
>    avr6
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/avr/cpu.c | 15 ---------------
>   target/avr/cpu.h |  2 --
>   2 files changed, 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


