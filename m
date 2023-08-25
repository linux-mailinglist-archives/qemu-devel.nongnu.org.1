Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A807880AB
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:12:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQyf-0004xG-O5; Fri, 25 Aug 2023 03:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZQyd-0004x8-CW
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:11:27 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZQyb-0001qK-8A
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:11:27 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so920751a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692947483; x=1693552283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9P7iocDc17u8dvJUosBQ+/dRFdDawqj2DCg9a2Gc7qg=;
 b=an+PnFJw1fv1CbMiqvzo9oKvbPGwCiM3uUHf9mKHzSrLw0rPHMtyHrhc2MMTK5pYo9
 lVDpeZDVHl24kO4oz6HsUUhuLqHcmPN9NnkK61dJJStIAB8Kc0jOLOk8bxiQEik16jn+
 SEAN0VGyjzaNUozBhFLeYarUoIQGWMubtx5FY99VzD3GaHzXvcPVja7+LP93Cg1qKXfa
 8Fv9r+y+s+kLxJDZMUrpLDX4DSrWAofiCuQ6nTcbBEvmEBVZdvjZgXgy2Xs3UinVMjVi
 PZF/8KJyaNqGfsmwtXcJY7f/no+0kdKxBg38jne3gIqRyA1MsCvXq5bUC8L7qD8totIl
 FZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692947483; x=1693552283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9P7iocDc17u8dvJUosBQ+/dRFdDawqj2DCg9a2Gc7qg=;
 b=MOFnkflA/Q0+vpISyySAXCFcVH1vytoGh8Lqh47+Y0c+Q4F1Noiril3lK5pxZSxNgb
 T4wsS2C+c+wq4HftC6QA89oVl/iiKrF4KszZXm4yBJcDYYhvsb/yNge9UyPmohEtY7kA
 YohKzu31VrMSKLiD+iNU5ED9oLixPTixrSTgf2xNCqE5EZISXoKHlTv8bnKzAexHwX5x
 OLORG9A1sHDh+VA0BeaqVd/zqnndNJr/RdRqf1zaWdVm47Ug4/isJ9was5p1ireaSt0r
 ptmrS7b/pZF5HK5w+VXiNf97TADCchnrt9f1wovq3ZSX+a5gSCXI++D7vbH8lI2rxn59
 uzEQ==
X-Gm-Message-State: AOJu0YznZO5BaPCzNn0YNaoxxpjH5HrLX3AFhLlKkUdCOqYacQGYzQ/7
 zH+XBIJecFFk7xN7w7zOCC3JjA==
X-Google-Smtp-Source: AGHT+IEqx7OqBLtzeQlq9v1+/WcB0LRB0GR4BLwF0dnYjiLgWBZgeWypmhi/VXqIsr7YaQ1x5zt3uw==
X-Received: by 2002:a05:6402:332:b0:523:d8be:e81f with SMTP id
 q18-20020a056402033200b00523d8bee81fmr14347558edw.30.1692947483652; 
 Fri, 25 Aug 2023 00:11:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 o8-20020aa7c508000000b00523d2a1626esm684420edq.6.2023.08.25.00.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:11:23 -0700 (PDT)
Message-ID: <b781a25f-f2da-c0d4-c708-ddff5a600d44@linaro.org>
Date: Fri, 25 Aug 2023 09:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] target/hppa: Add missing PL1 and PL2 priviledge levels
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20230824210434.151971-1-deller@kernel.org>
 <20230824210434.151971-2-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824210434.151971-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 23:04, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The hppa CPU has 4 priviledge levels (0-3).
> Mention the missing PL1 and PL2 levels, although the Linux kernel
> uses only 0 (KERNEL) and 3 (USER). Not sure about HP-UX.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


