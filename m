Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2267C023A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 19:07:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqGBi-0000qF-Gc; Tue, 10 Oct 2023 13:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqGBh-0000q3-5O
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 13:06:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqGBf-0000Rn-H9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 13:06:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c5db4925f9so326485ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696957586; x=1697562386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0fWy370Z498UJOziQCs2RbPhahoWSvo/WkYMCBSJSGw=;
 b=myPYP7MijImEBiaKLZUNO+/RLXfT8MzbiTek1ELhIs5V5rknfwxZ+gP7FLx34ADIGS
 yjJCTXKhVKmDoDDrCSfgNLzl73CzaTkoEfcKrH614Df/3TnzHiyJ7eZm1i4KqGEtBKwg
 Z9ToJgoXY/fFmUvqQSq4hBFLtHlzsddOpTpWDPt0APINLSoeleOn/mHMvxKX6j7zgcM/
 IjwzQIv9/PGt+jgblsIaIdKYkUYuxmjiqmjevVTDg9EkOyyxKisA4QnS5qM5H+51Xy4B
 LX9jZ2sVnTrH4tueyjMMkJQNPU4IA/IY2K7OnjuKMTpWo3T1zDYSZGpQxzu5a3QMOx8W
 49Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696957586; x=1697562386;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0fWy370Z498UJOziQCs2RbPhahoWSvo/WkYMCBSJSGw=;
 b=Vi8GWTKjI9Un68QTIKvYXsSi9y3y4/GuyChQqtQAhtKEQFPo2GiVVlyQjkxVTrGDtM
 0kKxx6Sqeq3lWedH6w0peqJ38XsCgTGWbbxV9cjT2y+1yT+e47PTodlqG5BjG1pIZqXM
 Z9BxlJXmHhQhn/hU5/qVxlDqYBYU3fi/qhbMy2jHfWipHP1P6zAdNyCoJmXRLDs9BAPf
 jj6a5mrVJujK3qcW2Ux7jw79QHJ65Sgo+BjJrYTpXWDlHhxmCy4m/2kUCm2gO64mvKXX
 x7eO5TgUot2yJ8REjCmRoxxL3OF8hUAbdAYua/3lvm9G205EwSiVvOnRPcJvp0eS6jvb
 ISvw==
X-Gm-Message-State: AOJu0YzoS8NKhsKoIDN8IpGtwbAqlwDhl3qH2hHLXkCRAUWHYA7ZqVfx
 XpvW6Z9wapgUTNQyncc+mJEVggw1NPWqcoFUsBs=
X-Google-Smtp-Source: AGHT+IHD1zmwT+NgrfowsAMEKEulNY2l68HhWcJQH0x9I/klZbt4ZCfVs8iU7VVvXcFP3MbjFg5MaA==
X-Received: by 2002:a17:902:f802:b0:1c7:47f4:7c86 with SMTP id
 ix2-20020a170902f80200b001c747f47c86mr18216104plb.15.1696957585958; 
 Tue, 10 Oct 2023 10:06:25 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c10d00b001bc5dc0cd75sm12002874pli.180.2023.10.10.10.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 10:06:25 -0700 (PDT)
Message-ID: <58ab19d4-3b06-4a9e-87c2-4084d9408ff1@linaro.org>
Date: Tue, 10 Oct 2023 10:06:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target: Use env_archcpu() instead of
 ARCH_CPU(env_cpu(env))
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231009110239.66778-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231009110239.66778-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/9/23 04:02, Philippe Mathieu-Daudé wrote:
> When we have a CPUArchState* pointer we can directly get the
> corresponding ArchCPU* pointer with env_archcpu(). No need to
> use QOM cast which is slower due when building with
> --enable-qom-cast-debug.
> 
> This series replace ARCH_CPU(env_cpu(env)) by env_archcpu(env)
> when possible.
> 
> Philippe Mathieu-Daudé (6):
>    target/ppc: Use env_archcpu() in helper_book3s_msgsndp()
>    target/riscv: Use env_archcpu() in [check_]nanbox()
>    target/s390x: Use env_archcpu() in handle_diag_308()
>    target/xtensa: Use env_archcpu() in update_c[compare|count]()
>    target/i386/hvf: Use x86_cpu in simulate_[rdmsr|wrmsr]()
>    target/i386: Use env_archcpu() in simulate_[rdmsr/wrmsr]()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

