Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335977DB7DD
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:22:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPPG-0002Ei-Gv; Mon, 30 Oct 2023 06:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPP7-0002A3-2L
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:21:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPP5-0005qS-Ca
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:21:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-409299277bbso26166435e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698661309; x=1699266109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DqjCBw5oIRCbZ3SpKur62rvfHPlI7N5bqnyT/L1Kzm0=;
 b=KEXHhRXcKkvpV26gzEjOMtuVxreAcnSN9qKXn/Sdepk6q99R4M/8DNCWM6szZA3Upk
 ME0PNllwmfBJMfOFfzNinP73G3blYDTPI4eXWUUEQnNLLB9NCmxYHc0UqaUpFmL4OD7j
 u840qg4tWjWFPkJG9rDN16g9xSYGdE55wNzfSywOXG5npncABZkgh/b+FoLEbR6nOuth
 YjYBqrwcgEtslnqEplCxJs+p/LtfRRW+mmCMlwRnmOwTIt+sdgpSXbwMiY4hWqpexGAW
 4wt2H5SoefrRsA7tPAwr3nwL0BxHAGytDxJw9v/vY8HngASmXdN0I48F8G+b9hCr+gHg
 0a3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698661309; x=1699266109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DqjCBw5oIRCbZ3SpKur62rvfHPlI7N5bqnyT/L1Kzm0=;
 b=wx9M4AeSQTmrxu8QE4dW/gox6pSKwradt+3t3WfBOdLuvrnLNqFm3p+8mf3gV2YBBz
 bWTQx6XmWMNS/lHcNLCWNr8e7FFen7FvXe6T/3BHB4FEq7UybhKSMc5N8pA0PFmZcJ39
 ydIC4ujz1MILdZLrAEN1nULZq7ey5tyTA6r1NY0YEezniyEMs4cp1q2fOaGivep1mC3l
 mhTAKc9263RFbek6QzOW6CVzauBoKQpGB/l0rfWjMWeU8tZFZwA1Ur3MYKjhdW+xKvXw
 7vc4OVh1ZN4bx8b6eJ4RjxlSPfb9l4+VL69E8NqxnBzQlQQ0tOsiEU+n20nHt8UMfvF2
 ItbQ==
X-Gm-Message-State: AOJu0YxlSCHhe+FCDb6k48ZGUgX7/j9V+MZV9bASXTDNYLGnrOblnH5e
 zTGUip0AQPqHMuxn6FYjnQQiOw==
X-Google-Smtp-Source: AGHT+IHT6qX8kqDP9IahIi2iAhO660uCjqWTiGSF5DKQiXm5yAUI7Qa+Y4MM5LeursWh0mkaEoS0nw==
X-Received: by 2002:a05:600c:4f02:b0:405:3885:490a with SMTP id
 l2-20020a05600c4f0200b004053885490amr8003764wmq.0.1698661309352; 
 Mon, 30 Oct 2023 03:21:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c428300b0040596352951sm12110105wmc.5.2023.10.30.03.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 03:21:49 -0700 (PDT)
Message-ID: <b52771f8-90b3-439c-6676-d1fae88e5719@linaro.org>
Date: Mon, 30 Oct 2023 11:21:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Fully cover target/i386/*
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
References: <20231030085336.2681386-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231030085336.2681386-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

On 30/10/23 09:53, Markus Armbruster wrote:
> Many files in target/i386/ are not covered:
> 
>      target/i386/arch_dump.c
>      target/i386/arch_memory_mapping.c
>      target/i386/cpu-dump.c
>      target/i386/cpu-internal.h
>      target/i386/cpu-param.h
>      target/i386/cpu-qom.h
>      target/i386/cpu-sysemu.c
>      target/i386/cpu.c
>      target/i386/cpu.h
>      target/i386/cpuid_register
>      target/i386/gdbstub.c
>      target/i386/helper.c
>      target/i386/helper.h
>      target/i386/host-cpu.c
>      target/i386/host-cpu.h
>      target/i386/machine.c
>      target/i386/meson.build
>      target/i386/monitor.c
>      target/i386/ops_sse.h
>      target/i386/svm.h
>      target/i386/trace-events
>      target/i386/trace.h
>      target/i386/xsave_helper.c
> 
> Similar files in other target/$t/ are covered by "$t TCG CPUs".  Do
> the same here, taking care not to hijack files that are already
> covered by other sections.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


