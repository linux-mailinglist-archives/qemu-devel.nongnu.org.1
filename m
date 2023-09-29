Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763ED7B3BE3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKvA-0001zr-Sa; Fri, 29 Sep 2023 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKv9-0001ze-At
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:21:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKv6-0005C1-3E
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:21:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c724577e1fso45937725ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022466; x=1696627266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HSAf/lrb5pXALE/sJEkBnIFbu8u5B1sme10YjunFZGU=;
 b=kPkfKOEDDI34A/f9LVqS1DkrZrawNwe+bMSk9lbV9CH/wH+njq+zNwixYRNlcigFuV
 atD1IhFDRkeYWRq8yGfLWd/EBZjnNEOvGhRzjNWQxVWrez1tiicQFW65FLog0TDnOK66
 PmFDVE7STQnjERS3UKyj6+oclKk6LzipKQz4hnBdZtvdksYRBlTKv7MGqh5Xjib5bVen
 XxXyVm/Gffna48UHPKQ8iyq/lvrBR2CkH5Xb1nHeCYtGAlQk+D9BmnW+0iluqxaBxBVn
 a+oNxHS3bYH6wNjsWWyUVLa96tO+YWzwTkTGhaCDZ89FwgHGpY9WQkUcDvYfJPEnsktn
 z7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022466; x=1696627266;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HSAf/lrb5pXALE/sJEkBnIFbu8u5B1sme10YjunFZGU=;
 b=lS1AYWjgizeY1DbTk5pYeTg1VTNG1ui+geYM259Eg3JE3D4WB8gMx9k+grlV1VVkxF
 o4BHrdkVxGnapG6Nf0XkFSYrt+MopjJ49Zhaf8GDS65fgujQq0P6knC8wa/sOdIRza2N
 prBNLaqWDXFBC+9MKImLpY0vhNUs53c1cLqcXxphq/FyXX3cLFBLMAOcFHhUpZiPv6Vh
 BbzBzuYc+rfsOpgKo37/i6ndus5IugV+/VREMJS7RLTopCCtCNSs3zngVnv22gIdWWf8
 GQUSi1UMt+zszhyBLoyOxhxNSTxSb0k/MT5u+N/RjOS6NdqfHKHM4q1jyKdtekI9OVA+
 l1gg==
X-Gm-Message-State: AOJu0YzeDz6o3H1PiDwrY80t5Fq1Y2habsgSNWM6IlHCKpSGEKEij1TO
 zwqvsc6+K0pkRdvqyvr9eGRy1oYvgBvxN+6OuW4=
X-Google-Smtp-Source: AGHT+IG/bM0sPpGK1Hw6St5Av0RMQhDz39/687Ammn+gAC0mPKIp/vzRqz5CGMZNfMJBI/KUFBkbdw==
X-Received: by 2002:a17:902:d508:b0:1c6:1733:fb3f with SMTP id
 b8-20020a170902d50800b001c61733fb3fmr5788283plg.49.1696022466602; 
 Fri, 29 Sep 2023 14:21:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a170902e74d00b001c444106bcasm1754592plf.46.2023.09.29.14.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:21:06 -0700 (PDT)
Message-ID: <44832153-39ee-2545-6b19-0d599cbd6553@linaro.org>
Date: Fri, 29 Sep 2023 14:21:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/22] target/xtensa: Create IRQs *after* accelerator vCPU
 is realized
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Architecture specific hardware doesn't have a particular dependency
> on the accelerator vCPU (created with cpu_exec_realizefn), and can
> be initialized*after*  the vCPU is realized. Doing so allows further
> generic API simplification (in few commits).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/xtensa/cpu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

