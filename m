Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6477EDC69
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:55:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XDN-0007G5-Bk; Thu, 16 Nov 2023 02:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XDL-0007Fg-F7
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:55:03 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XDJ-0001Vk-R5
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:55:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so377085f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700121300; x=1700726100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xq4/PxYKKGerN15tuKWfbBlxgYYQcz5v17kAaUTTr4U=;
 b=Kgidu7OVKpT+I/nvV2ZwXR1ugp5DWoEJ+4yePJaTiXFojsqv+uRwe4jgklrulmGa+k
 OUYXH+X9iFjl+sPRnF3Y5/wY9Wg2DDWuE/8iom+4id0YpyPP7pfszzKJpPFSeAg4zeFt
 2dbQDJNEQ15qn+cVY55PsbHOWZ2XRflfXmBofuwWq0ooEy72tfb3DSr8Ui9/EXv6tQYn
 EgRjr3+79LzRX3A34qZ8ath92Sf7z5xz6ql97PqU0joXNzteNCUrG7wM/8AtnUcn8Cba
 aqJBFkvaIiV7SOqHth2ROoPGLOzqDLkiB5ImhD4KzoQablJFiBI8RizBdHx10pL3z927
 xXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700121300; x=1700726100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xq4/PxYKKGerN15tuKWfbBlxgYYQcz5v17kAaUTTr4U=;
 b=H9GwH0A1pSw8CNs3V0iTBGStSsmP++x7+3FuY9nMLmUk2CTahRO9d/5RwS771RT1Eu
 sjNIyuRb9RIT/8Zont1w9uYYbLeB42eF0GVIh92VLnga4UDmxMRvpTh3aUwn1Nax6fC7
 HsGoYfmOq1q2e2LeInrzv/vl9LvjQYUZwThMzc6FW7p14vTmjkxrwoVEGy1PIVEAAR/U
 +Kk3NA2whxFapjHYD9VKDGeOHKLJv9VQCeg6zcdGLP3d4TD3TtTUwAlBEe9946IEGWwv
 s2/Ck8lSUJArqi9Od3GN4dTTFDQYDMf6Xw5aVPi1iUAFGfe8A01cj3O53BnCqTTovAvQ
 eIow==
X-Gm-Message-State: AOJu0YyAE+0fLTEiMyOvWu1sPdRF/SaboykrfrbwABaToA0RnUT7NUV9
 60jGnsk/3cQpg7nnIuJ+Bv8i/Q==
X-Google-Smtp-Source: AGHT+IGhMIp2OyXueSUS7HRilCVAf/zEcGZF3g6foVnHhw7X2NSL0U0bcGVs9tHxk0b4CSnbYNQmiQ==
X-Received: by 2002:adf:b312:0:b0:32d:9d3a:d8c0 with SMTP id
 j18-20020adfb312000000b0032d9d3ad8c0mr9170922wrd.60.1700121300532; 
 Wed, 15 Nov 2023 23:55:00 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000024400b0032fb0e2087asm12582889wrz.82.2023.11.15.23.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:55:00 -0800 (PST)
Message-ID: <ad2b735e-9e98-4a1d-a1e2-9a189d703122@linaro.org>
Date: Thu, 16 Nov 2023 08:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/31] target/rx: Use generic cpu_list()
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
 <20231114235628.534334-19-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-19-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/11/23 00:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-rx -cpu ?
> Available CPUs:
>    rx62n-rx-cpu
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-rx -cpu ?
> Available CPUs:
>    rx62n
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/rx/cpu.c | 16 ----------------
>   target/rx/cpu.h |  3 ---
>   2 files changed, 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


