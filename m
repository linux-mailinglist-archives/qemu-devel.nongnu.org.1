Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085E799C0C
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 01:31:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf7Q3-0001fF-17; Sat, 09 Sep 2023 19:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7Py-0001dM-9W
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:31:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7Pu-0008R5-2t
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:31:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso23443475ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694302264; x=1694907064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/yt21vhMu/DJnZjeTWd6kEQk4GssF9C0RgKhht8a+k=;
 b=qCpLoidDoKohRVrkhf9aTltWYZ2GiknllR5J2qGBeidgcj/pN+drYeem6+euEezOkw
 iU+H+9VGL5yf/9YwzKucfC2zGgX+cYX0rGrbZRWYXV/dSm5t3iP0AM+gR2OA9XcAOVOn
 BBevOsHG/j+GCgi1OCp39ZFOxmRYdJVMLsxrZRYP4JAujp4SsKPb+3r3SDux7sTMGa+e
 DWwBzXfPcJSLkGnvXEz20h2pOHRIscR8+3wmO2DDplEJKNiWsOc+l1iNY+huu3G8NOcQ
 G/SZk3aVChpY4AiknEpZ1NYYW+B6QtKf9W+289Ylh1g+QzEpDlBM57sdHZVNzYk5SG2v
 S8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694302264; x=1694907064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/yt21vhMu/DJnZjeTWd6kEQk4GssF9C0RgKhht8a+k=;
 b=RePNiDDDAa56siR1QKL2yvgtWCJOAN+j/hatrX9nJg4nTiMgQUDHwR7JW8TXVOSfhU
 tTcbUHrnAtT1GlOI1MsRtcdwxeibMUWFdBbVHZNh8OuP6z8C7iI4qeXCA/IAeaZllOjs
 bBzFherud3Jh6i9W62fXBFGH4smMs7jEspFBMvQ2DWdD025MvS18Md5chH1zx14eqghi
 PvZybo1HO/uwTWqRCiSfSZEB0UP/ZwntwkH2odPMsl5YuAoOIcmcsvanzwGqjum3HGE4
 3DQVg9lMaEeYvcH0zr0PrH+fUVhqnVGchyQacYjqxbQIJfwd/W1iR1lMLFqxXMatIloR
 6TwQ==
X-Gm-Message-State: AOJu0YwVRnXQZQKX6QeBEimijqIcQNL7gYyvGwd8H7MED7qjgNtyih5g
 cCbfSuRxZUhtAfFFjrR+VzBzXw==
X-Google-Smtp-Source: AGHT+IH20ght8SsJh1rMsaqufBnplJXf1kawXu9G/RcKF75dGqP+GokGAvO9346SyegKYq594HMz4Q==
X-Received: by 2002:a17:903:41cd:b0:1c0:c174:3695 with SMTP id
 u13-20020a17090341cd00b001c0c1743695mr7001607ple.13.1694302264403; 
 Sat, 09 Sep 2023 16:31:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902778c00b001bc6536051bsm3731037pll.184.2023.09.09.16.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 16:31:04 -0700 (PDT)
Message-ID: <fb1249b1-c365-b859-9201-dc6cab2e93fb@linaro.org>
Date: Sat, 9 Sep 2023 16:31:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/13] hw/i386/pc: Include missing 'cpu.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230904124325.79040-1-philmd@linaro.org>
 <20230904124325.79040-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230904124325.79040-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/4/23 05:43, Philippe Mathieu-Daudé wrote:
> Both pc_piix.c and pc_q35.c files use CPU_VERSION_LEGACY
> which is defined in "target/i386/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 1 +
>   hw/i386/pc_q35.c  | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

