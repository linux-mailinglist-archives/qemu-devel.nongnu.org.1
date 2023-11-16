Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC157EDC66
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:53:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XBh-0004Pp-An; Thu, 16 Nov 2023 02:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XBU-0004FK-GM
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:53:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XBR-0001Am-Pp
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:53:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f613275so3903215e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700121181; x=1700725981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aasKRHUJAB+oOvJtoDhv42xI2OzU1qQ2TYDzah5Jds4=;
 b=Tfm1sl6ROIauHBoGh6/0gsyWMXdTzaRuDK8oeQBsem/DzbDFDLlz1RvDVEhCPTS0x/
 Cu/CbSUtEaPjzJltnT+BYEhJW5yo9VZx4g/GhVm9VVF9NSmrE9JsQF31HYlbCu+VBX95
 UHnCqCYJBAre5wxQjLIxnRW4tq1lOioorLpRvVy0UFoWL3ZV/gF0MJ97cq1OAuNplZRZ
 A1wIGpycn/Lk+inw9nBMKYGFA7YK5+QL/n5nUyHPb0FgdMNrr8IKgSrIHRhNosQbz47I
 cHvSaE74CBEyQoqTEMq0iLl78UoUGl9k8OKMCLSIZNIxxx6HTaGp89C1jaszkWlpsf88
 MWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700121181; x=1700725981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aasKRHUJAB+oOvJtoDhv42xI2OzU1qQ2TYDzah5Jds4=;
 b=CcBoE4wrUXJONDczgo1FhYQefLt8sICvLowXZN3PVY3sb0E5OWjqKJpSEk+i9Q7GAh
 mcx2SXdLVug9b7YJUPRSDgliegdlnyZfvgj+Rk1DTp6wedmJzy1inlt6IP3R6hACv1FO
 X1J1ajjL7Smmhl5+WInMJOHV7nEGdqMNx+rkCWb8hJtok9vn1VQdNR7qbYBjjnZ5AGSX
 LzzPdVuzlxm7aEDhnYywu8rjmtvR5aHgcaTw+dolomAcLIxDuSuFVbEvJM3FwAYZ6P0T
 BeIrp/9h5NC8e6GZepia3eAjAVkvxiWLb0NW0ggq0BLlUU2spWAn75no+uVlb05nbkuE
 iauw==
X-Gm-Message-State: AOJu0YxO2C5HUv8TQnyhzD4hdziK0jTajPUaOXLw3NfzgWhYBWrzvo9o
 HWfob1ZCbsLtTXp6pMU9/xr/iQ==
X-Google-Smtp-Source: AGHT+IGq2CcDTnhqIIks3mmLBJeeeniv54Bu6/3HRji6JJkZQ5A3SgH6GzLpuQ6zB1fZa2PN7/1/nw==
X-Received: by 2002:a5d:45c6:0:b0:32f:7a28:3cf3 with SMTP id
 b6-20020a5d45c6000000b0032f7a283cf3mr1132467wrs.27.1700121180727; 
 Wed, 15 Nov 2023 23:53:00 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000024400b0032fb0e2087asm12582889wrz.82.2023.11.15.23.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:53:00 -0800 (PST)
Message-ID: <c632b3aa-b7db-4d7a-9bc3-7fd5d9575892@linaro.org>
Date: Thu, 16 Nov 2023 08:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/31] target/hppa: Use generic cpu_list()
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
 <20231114235628.534334-13-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-13-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
> No changes in the output from the following command.
> 
> [gshan@gshan q]$ ./build/qemu-system-hppa -cpu ?
> Available CPUs:
>    hppa
>    hppa64
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/hppa/cpu.c | 24 ------------------------
>   target/hppa/cpu.h |  3 ---
>   2 files changed, 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


