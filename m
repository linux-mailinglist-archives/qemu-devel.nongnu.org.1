Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 042FE7775DE
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 12:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU2x9-00076a-2K; Thu, 10 Aug 2023 06:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU2wy-000741-SL
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:31:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU2wx-00062O-3Q
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:31:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3177f520802so1083793f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691663485; x=1692268285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UVtfqiZ2cMW9MqlBP3N3NaUPwO4lvMWwxV5/f71n0aw=;
 b=IOU4zpDWbNUpyUsrFYC00FU1UDeIZpNSAURxzmqNUlKGsa61L1ODXJ+t6QUIOjP02s
 r1C66Km9YYVwP6x0Nmvju8Mk0hZSUI1So4LOxUqj0iI7Wey46yd4ry+xFKcxDYy8GEl7
 1MFY+NAXFMWmlukDqO5eGk+/wJuVCuPtBnVkAEPw86Np9IkYDtzzKFStfhDCmV8IFB9g
 tKJpi4kDT9EiXQhVBuTiBaOutny5GkNc0LMeG2pK9dmRbP6NuQzGaxLoXshhGlLfNrFB
 JWGncS6i+QfGnNruyoQSChbfOyyLRT2in8j4cfxKbqLYptCpEls4bbkUceTkLUyWIRxz
 4r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691663485; x=1692268285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UVtfqiZ2cMW9MqlBP3N3NaUPwO4lvMWwxV5/f71n0aw=;
 b=hiW2/ZYD2Z3QNDyLmBiwTbg5U5hiKUPxlpKQKfHCPnBeUvRCY3iiApCJ6XF0MWmy5o
 yx99nlaGXaHn/k5Hr45A+QO0OEXfvSTK6E1RIEBph7vJBwk0WJx+lMPDEpgJkzAog0wr
 u7ae4bBP1r26CV6AC0DOtOJrFoQVpW5Qm69wy+RzU20KnkhctHOF+w42YLzd4TyLwLKM
 hlS+qMXONybwKZLQ+4SYd3QJf03vdIi3w5vBVSYzVYhVswodJlO7R7wg7r3saMFT/P33
 rA8mNCueo/ell/pEHEz2B655/SGxsxCVTcmlW/0roxuvqmR29tGvhftih62vKDlKSkS0
 UE7Q==
X-Gm-Message-State: AOJu0YwmQKHAkHKQZNIG0tx0/XrTJydnIMRTZ+8HZJS60M1ieKk6Etl8
 CEHYsxJvgwinVTaOnzUvHWubb7WaknbrLm2cCms=
X-Google-Smtp-Source: AGHT+IGdGpSWhs9AtsDMVM5IvZSjKSCXXIXRnxFDRhcBBVOiT5oaSPFqnT/OAbdjiP/UBpV+GzFGbg==
X-Received: by 2002:a5d:658f:0:b0:313:f38d:555f with SMTP id
 q15-20020a5d658f000000b00313f38d555fmr1169580wru.24.1691663485115; 
 Thu, 10 Aug 2023 03:31:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 y15-20020adff6cf000000b003176f2d9ce5sm1729034wrp.71.2023.08.10.03.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 03:31:24 -0700 (PDT)
Message-ID: <d4fdff5b-96ab-88f7-1e45-725bd5ac8e36@linaro.org>
Date: Thu, 10 Aug 2023 12:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] configure: fix detection for x32 linux-user
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20230807094807.471646-1-pbonzini@redhat.com>
 <20230807094807.471646-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807094807.471646-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 7/8/23 11:48, Paolo Bonzini wrote:
> x32 uses the same signal handling fragments as x86_64, since host_arch
> is set to x86_64 when Meson runs.  Remove the unnecessary forwarder and
> set the host_arch variable properly in configure.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure                                 | 2 ++
>   linux-user/include/host/x32/host-signal.h | 1 -
>   2 files changed, 2 insertions(+), 1 deletion(-)
>   delete mode 100644 linux-user/include/host/x32/host-signal.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



