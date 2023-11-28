Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C387FB68B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:01:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7utd-00046p-KV; Tue, 28 Nov 2023 05:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7utY-00044z-H6
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:00:44 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7utW-00061E-Mj
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:00:44 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a0bdf4eeb46so379023066b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 02:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701165641; x=1701770441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J5C7BkyNHBVQ3crJXHTldRL6NE2T6P7YeYj/ZfPXolc=;
 b=LVH6GOF2IpXV98MEtu9hGW2h3FFE0jLlz2lz6yjr7JZeCV9wuH/6dxpTunqD1dlYE2
 Z90LC4m1t1y34ziMBaWe6SzYqfH4Simz/5YfoeGRz5xFqMvwaxUlaJoYOedxbmNpGflA
 rLvP28WaQhQSYR+VHY+K0YsxV5FwpSWQ4J9r2bep6zZ/l2TXuG3SGxtNvznVfsVyU/vR
 niTZlgA2gLZWQRZ3zynKszqdTfERbHTCWridRZqTh8VUYAzKsUCSdeYllCg/cyNllX8z
 KfGjEfAsm9LtkZLc05CGG+H2wtnzTGPUCA+JEoaVphxkIqSCluy09Wya1BFRPhR6I1PR
 ilcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701165641; x=1701770441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5C7BkyNHBVQ3crJXHTldRL6NE2T6P7YeYj/ZfPXolc=;
 b=m/QQ/4mJgQYmFkKn/TxUzFUfU9ZRxxZEhkwmfAi+8V6auaXVse3LUCupi6ymuEliW6
 vWauxUPzrVWkxVl7q0rDBBNaK0jx0O6hOuNLVzz2m3J4VEdlvzzBCHZg2QQiK0eZlARp
 PCvuarCno22uN7VbEpJgZ9PkZHQ2YlqiTUzq5+eydZ/QB+3DHuQBhaUZ4umh7mtfm4mW
 ZCwFepCdlAAv/u5KZV/VSRiDAdkz5rLPJ7p+vFB3Yo7fbeYbMRIR4Kok1pr1etH5k22t
 9lbLCthuiss5nfuH25un/gEWmmcBWQ/OHnimQXCI9x18MCko7kLpot6Y+C/dbK5iIRMC
 2YJw==
X-Gm-Message-State: AOJu0YzyyyJ1h8fs+Z+uXwYZabuwMmwecRm73YL8b+EzUPx7atPly4b3
 tYySvWSuTRgFVqxKsfUklwUjew==
X-Google-Smtp-Source: AGHT+IH2qd77tp8Oq3Iy+4UKWRp7Wq/eHk0dCVntEXUMKgKkkHxIKSXOlSneBzLY9ssD0ANAn3PpJw==
X-Received: by 2002:a17:907:cc95:b0:a01:2bd3:21d2 with SMTP id
 up21-20020a170907cc9500b00a012bd321d2mr8035862ejc.30.1701165640698; 
 Tue, 28 Nov 2023 02:00:40 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 r22-20020a170906351600b00a0c01560bdfsm3835090eja.139.2023.11.28.02.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 02:00:40 -0800 (PST)
Message-ID: <7b3b5852-6c91-4849-bc52-97b31bcb1dce@linaro.org>
Date: Tue, 28 Nov 2023 11:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/cpu/core: Cleanup unused included header in core.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20231127145611.925817-1-zhao1.liu@linux.intel.com>
 <20231127145611.925817-2-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127145611.925817-2-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 27/11/23 15:56, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Remove unused header (qemu/module.h and sysemu/cpus.h) in core.c,
> and reorder the remaining header files (except qemu/osdep.h) in
> alphabetical order.
> 
> Tested by "./configure" and then "make".
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/cpu/core.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


