Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734CC83204D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:11:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgx-000735-Fs; Thu, 18 Jan 2024 15:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgw-000710-4T
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgu-00078u-Aq
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e86a9fc4bso295265e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608523; x=1706213323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=haeX5zmggnkllRSh2IyLwuRzJwGjqqUgrN991UiOKFY=;
 b=C2K3LnScv93a5HrgMMmUsmy2vmDCT69aLcUE9xm+SJ055V9ezx5bqfL2T/UoTsTxjT
 NTzoNxN+h1Rq3Cu7NXvUIgKtZt++BmVMqw20k+Bxjdc0wFINE+Il52qzmHNojsMWfx8N
 4hoa79qC28Z7wlf65gqP64DcADkeLSK/t+DiCaZAOzcU56Hj/RgndH/pZXZYNLnRx6cg
 ZeYCj5SP/CLNd9YXMEfK/AncAtMHZaqDo0ko23spqW9uvqcWY60OILx6jo4xmz3ZNt6C
 o0KKuvF3CS/unlgVE+lJECAOUHqWp2yoXKebPvKsXmpIE6FOf0HGjqPV4SGf92iin52/
 cQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608523; x=1706213323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haeX5zmggnkllRSh2IyLwuRzJwGjqqUgrN991UiOKFY=;
 b=JISR5PL42K4QKeB9DT7QmmzzxXat/I3T20gJUszR9BlznSUUE8DdYbDZTy471yLvx7
 PS3VhU8x5Psj+c7k3Yc4kLAtwTOnIQ21bj5pd2M51DFx+8yL6UtKoFGqh3hYikykftCb
 z153GKRLCIOSv7vu+ZtcMO4vRIAXC1OSFMbVEiIV4zYAazlA8GUDenUU5SKIvffWNVSy
 eunBMYZ+a97z2WfSH6S7GemYbUsLhD+qfjn5urvR7/rcDWLz/7MBVNeQiKk2KECV2wHR
 y6eOUIudgdsGxBZ3SqZwo/bM34PKxs+9lhDwaetYCKZH3I9gIMw0nCnp62VLJ6Y/5b7+
 c5dQ==
X-Gm-Message-State: AOJu0YwnOmX294OhdYkhOfJvwP6oxVSkKborPc+rhIkSlNoIyEy/lgGz
 ByfhGtb4wbkRkLfG0VvOaREwasPvsJFEm3ZDoyEmGqIVFNn1qGSA1HTRetIPoNe4ujLJ5/tGWWS
 eXeZ1FXZG
X-Google-Smtp-Source: AGHT+IF1cvUiwdlvGuy/umIofxo4jxXUUakN8g035Hkx43UBNfkpqf5cMEgzAL/KoKKa/HRjhbA+FQ==
X-Received: by 2002:a05:600c:1c9c:b0:40e:7677:c25c with SMTP id
 k28-20020a05600c1c9c00b0040e7677c25cmr795282wms.142.1705608522835; 
 Thu, 18 Jan 2024 12:08:42 -0800 (PST)
Received: from [192.168.124.175] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a7bc346000000b0040d81ca11casm26099868wmj.28.2024.01.18.12.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 12:08:42 -0800 (PST)
Message-ID: <fbb60cf4-78a3-4133-b138-bc37a79ca68c@linaro.org>
Date: Thu, 18 Jan 2024 21:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] arm: Rework target/ headers to build various hw/
 files once
Content-Language: en-US
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
References: <20240118200643.29037-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
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

On 18/1/24 21:06, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> In order to fix a bug noticed [*] by Cédric and Fabiano in my
> "Remove one use of qemu_get_cpu() in A7/A15 MPCore priv" series,
> I ended reusing commits from other branches and it grew quite
> a lot. This is the first "cleanup" part, unrelated on MPCorePriv.
> 
> Please review,
> 
> Phil.
> 

[*] 
https://lore.kernel.org/qemu-devel/501c1bfe-fb26-42ab-a925-9888755c72ad@linaro.org/

> Philippe Mathieu-Daudé (18):
>    hw/arm/exynos4210: Include missing 'exec/tswap.h' header
>    hw/arm/xilinx_zynq: Include missing 'exec/tswap.h' header
>    hw/arm/smmuv3: Include missing 'hw/registerfields.h' header
>    hw/arm/xlnx-versal: Include missing 'cpu.h' header
>    target/arm/cpu-features: Include missing 'hw/registerfields.h' header
>    target/arm/cpregs: Include missing 'hw/registerfields.h' header
>    target/arm/cpregs: Include missing 'kvm-consts.h' header
>    target/arm: Expose arm_cpu_mp_affinity() in 'multiprocessing.h' header
>    target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'
>    hw/cpu/a9mpcore: Build it only once
>    hw/misc/xlnx-versal-crl: Include generic 'cpu-qom.h' instead of
>      'cpu.h'
>    hw/misc/xlnx-versal-crl: Build it only once
>    target/arm: Expose M-profile register bank index definitions
>    hw/arm/armv7m: Make 'hw/intc/armv7m_nvic.h' a target agnostic header
>    target/arm: Move ARM_CPU_IRQ/FIQ definitions to 'cpu-qom.h' header
>    target/arm: Move e2h_access() helper around
>    target/arm: Move GTimer definitions to new 'gtimer.h' header
>    hw/arm: Build various units only once


