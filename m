Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A467FDFAF
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:49:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8PbI-0002xB-JS; Wed, 29 Nov 2023 13:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8PbF-0002wz-RO
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:47:53 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8PbD-0007Qc-Ma
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:47:53 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b83fc26e4cso40341b6e.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701283670; x=1701888470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OZ5g0vUne47qsD+LYGFyddDD/h6FL26AIyreJgBFt7I=;
 b=J7mAeImzz633QScmF8OBXcqhNa9IcrpJlwUNu2LaXE6C4FnvFVlAW3DyKkPRhzB4Gh
 5jF4KVfSbF3CAipcYfToqSbYY9sdtsG2eF/6O5yOFrvXwOM2lGoPIU1f8aVpYAmJdBBp
 HCH4tz0rq+ZjjkpXBQV1aCnd8BqZSpWffsHSkF/zwMYK1S23Yw5U92BO+etlIpF5+7LB
 u2KGnTPFH+LJckLKq+6XpzkVTLM0FFGht4xjvQfIzKrgCjowfxCIURTAJ098qVK+I/v5
 2W8dVAtc0YZFAZpmkF2OvgNbBAffJsa6gsGSVks1S4oqLxs6xHZzGuQd5eVEjqLEi86+
 lvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701283670; x=1701888470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZ5g0vUne47qsD+LYGFyddDD/h6FL26AIyreJgBFt7I=;
 b=sFu52Uxymo95HKufo44GImTZTGslYyyRCyyjB+cWXA1ybVnuW50h6O6pfmKoNNJw8K
 XSx/vx8jsHfUHhUZbgGEzItMfqjcC3n7HWNr4aHtjKk+ms5h4jMsVbmF8eg/A57uUCX0
 Uxfu4beyWTRkxD7BiP0rKAAb/OhSsC7vw0SXSLGj+tUuKgfIOrFSTc/PABvBg2yG7RoH
 l+AbP1jByyHyodV8REXSrHkyLGpbGrhHKWDORJ8/kb7K6I4nOQu+3PSrsQ8bjnT0SaVT
 6Rae4Wce7tjS8twcD3m6YhoCDPxTper95QAUZ5f9qC+Cho3RCLC2wlql4WsaM95wDu8V
 TBZw==
X-Gm-Message-State: AOJu0YwpOHSINp4X93t1CFRKhRnQzpCpCJz+VKBD9nT1HqA6lvz/LZ4t
 bW/nFSGXLV/MkCqOtHk3DjDZCA==
X-Google-Smtp-Source: AGHT+IGcCqxIHfUFNGv4bU2ANafCrlKM7cCoBHf9NGJTRGbcyUeJphBBM/qVLsFa4u4AS9Ob0ssShg==
X-Received: by 2002:a05:6808:1188:b0:3ae:5c89:dcc2 with SMTP id
 j8-20020a056808118800b003ae5c89dcc2mr25706457oil.34.1701283670134; 
 Wed, 29 Nov 2023 10:47:50 -0800 (PST)
Received: from [192.168.174.227] (rrcs-71-42-197-3.sw.biz.rr.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 j6-20020aca1706000000b003b84aad737csm2362188oii.8.2023.11.29.10.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:47:49 -0800 (PST)
Message-ID: <93494151-3f1e-4c33-b7b5-d2a78b86ea62@linaro.org>
Date: Wed, 29 Nov 2023 12:47:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/cpu: Remove final vestiges of dynamic state
 tracing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231129182734.15565-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231129182734.15565-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 11/29/23 12:27, Philippe Mathieu-Daudé wrote:
> The dynamic state tracing was removed in commit d0aaf08bb9.
> 
> Fixes: d0aaf08bb9 ("tcg: remove the final vestiges of dstate")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c0c8320413..134ecb907e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -437,9 +437,6 @@ struct qemu_work_item;
>    * @kvm_fd: vCPU file descriptor for KVM.
>    * @work_mutex: Lock to prevent multiple access to @work_list.
>    * @work_list: List of pending asynchronous work.
> - * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
> - *                        to @trace_dstate).
> - * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
>    * @plugin_mask: Plugin event bitmap. Modified only via async work.
>    * @ignore_memory_transaction_failures: Cached copy of the MachineState
>    *    flag of the same name: allows the board to suppress calling of the

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

