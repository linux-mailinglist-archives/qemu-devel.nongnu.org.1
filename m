Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F07C7C76
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9Rn-0001Zt-By; Fri, 13 Oct 2023 00:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9Rc-0001Zb-Ql
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:06:37 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9Ra-0005sb-Dh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:06:36 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d113508bfso1329923a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697169993; x=1697774793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItN8otF1GoTLkZ6h4L8IyaHGEwWG3xZkx/BRa9MDUvM=;
 b=kQGrYZIcAfTiWhmmOcZ/Ww/0K+Fg7Ja6htp1KaXtqiTqAMCkpIv04V4V6jrbyFdJNO
 glAv6KyfIRHLg8VuL5ueWRLayOU4OWskWkJ6fDRrgS+gxG14PP272mOaciwdxtOHDMeW
 Fuz0gNc1RJpdlPiHnOKO/g/Yp8+BjR5Yh4CeBmhBNWEVgz0xQincyqd4NgRN6GDG76s9
 xumpyhKxu2pQrOtPGn1fOJjOnu8szCOpUf19YbCSWgrjND8Diwi9p/u4ilCmXFlVqIV6
 Eiqb3M5yhCQkMhPCqQ4h2q+l+4Q2saVghmtsO5ZfAB9rNbZjcsZ0B6U4Wl4bTkRAAW+q
 Nq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697169993; x=1697774793;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ItN8otF1GoTLkZ6h4L8IyaHGEwWG3xZkx/BRa9MDUvM=;
 b=ZKwwLTTcmN60R5f5EW26QJUxPfQGlaviUUrWLhn3uFcmhQKEyEUFVjykSQRTLTvjCM
 GSn1ERJiwbhNkDfiTVcpY+XCD+z8jPkBOv4hwWfW2p2cChkDahrgJJ9dMaed5MOQVI8b
 KdRzMaW6zSiHEeMtacvWyL2HuWSJzuBGq1nCpCh72X4NATAqk4Tu13fT7J3qw7YeBieA
 s9QhP7CSNYCHDwcho0o/MmARkzizOKirDLpkajhBIB4RRFG2rFGrzHTLvn/LeyWiOtMF
 3JJcnbNnSZXQigpeSfkI2P0KbRO8J0YV9tTp3a6xnf/tJCRoWwjSGyI2qdfB51CugN5O
 nt/Q==
X-Gm-Message-State: AOJu0YyjAHdQU6cGUU5ZeWqKUUdjUogio3Jtzy+/+cQqJLggWFDhziYr
 Zcbl2ncqwtQDoc2NdczFDEPCFA==
X-Google-Smtp-Source: AGHT+IEeoTEqu695K/uPf+nzmOpUoaNrwNY+HNJNsmfWCHzWalkJnUO8JD4Qq1qlojNaL/4pj508PA==
X-Received: by 2002:a17:90b:3a8c:b0:27d:201:121a with SMTP id
 om12-20020a17090b3a8c00b0027d0201121amr6834587pjb.33.1697169992854; 
 Thu, 12 Oct 2023 21:06:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a17090a31c700b002790ded9c6dsm2879200pjf.31.2023.10.12.21.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:06:32 -0700 (PDT)
Message-ID: <b3ecf0b1-95e6-47d6-b26f-017dbfd120f3@linaro.org>
Date: Thu, 12 Oct 2023 21:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/hexagon: Declare QOM definitions in
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu.h" contains the target specific declarations.
> 
> A heterogeneous setup need to access target agnostic declarations
> (at least the QOM ones, to instantiate the objects).
> 
> Our convention is to add such target agnostic QOM declarations in
> the "target/foo/cpu-qom.h" header.
> 
> Extract QOM definitions from "cpu.h" to "cpu-qom.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/cpu-qom.h | 35 +++++++++++++++++++++++++++++++++++
>   target/hexagon/cpu.h     | 23 +----------------------
>   2 files changed, 36 insertions(+), 22 deletions(-)
>   create mode 100644 target/hexagon/cpu-qom.h
> 
> diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
> new file mode 100644
> index 0000000000..cd45850c64
> --- /dev/null
> +++ b/target/hexagon/cpu-qom.h
> @@ -0,0 +1,35 @@
> +/*
> + * QEMU Hexagon CPU QOM header (target agnostic)
> + *
> + * Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_HEXAGON_CPU_QOM_H
> +#define QEMU_HEXAGON_CPU_QOM_H
> +
> +#include "hw/core/cpu.h"
> +#include "qom/object.h"
> +
> +#define TYPE_HEXAGON_CPU "hexagon-cpu"
> +
> +#define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
> +#define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
> +
> +#define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME("v67")
> +#define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME("v68")
> +#define TYPE_HEXAGON_CPU_V69 HEXAGON_CPU_TYPE_NAME("v69")
> +#define TYPE_HEXAGON_CPU_V71 HEXAGON_CPU_TYPE_NAME("v71")
> +#define TYPE_HEXAGON_CPU_V73 HEXAGON_CPU_TYPE_NAME("v73")
> +
> +OBJECT_DECLARE_CPU_TYPE(HexagonCPU, HexagonCPUClass, HEXAGON_CPU)
> +
> +typedef struct HexagonCPUClass {
> +    CPUClass parent_class;
> +
> +    DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
> +} HexagonCPUClass;

I can't imagine the class structure being any more useful generically than the object 
structure.  All we need at this point is the typedef, provided by OBJECT_DECLARE_TYPE.

I know this makes hexagon match others, but I think its the wrong direction of cleanup.


r~

