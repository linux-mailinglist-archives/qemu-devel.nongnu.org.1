Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B87F5799A3E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 19:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf1eH-0003fa-O5; Sat, 09 Sep 2023 13:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1eF-0003fS-P6
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:21:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1e5-0002O5-8A
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:21:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c0db66af1bso21845725ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694280079; x=1694884879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bERfRL/zth1+9E1XTRjKuIFPL2MyHBjIDym1nbsYRb8=;
 b=s2MACd1ljZDRe6JYV25x75/6zHr2vRjRgNu5cfn4YL5N4ckdRgfZlPm8a16Z05XOp5
 /k0ID5ggZlxSIjuFMyzKLm/uOseHTW6VIFPI3k1tBJn2bBz9OJPnLAzPdQRf714b7lsH
 B2ShT/FX3QL/TYkCdzEhl341b5t5GNzE8BzTv2dSGdrSTrquWCPmMI5mArYah+v+hhXq
 SCcd73ZRYeRhaGjesCaTn38Odi94kWxeC1i8whlCZnXXRnAr2jnmNwTwZfhkO19Wv/Le
 +/s+CEUb6cAGcVf1FdQ8gXMPxAeN7l/V3ED4TrOnRvEMnA1YTEkPsDgrlTn/8IPWYTkt
 bzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694280079; x=1694884879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bERfRL/zth1+9E1XTRjKuIFPL2MyHBjIDym1nbsYRb8=;
 b=cGM9Rb/HG9ZDuXwCnrB1PAcj3W+bgnpD57MpHrKe9wn2o8bEM42/KONX5+nuKzmrX6
 5FZTjBzJYX0wOOQDZqphEFjYToMIPIyZYvTh7re7vrOAF3Ywfv/Xdau3bIWP1vXWNzhV
 HUaIQYJrJ7VH4yQmcZaeS1owLEEucFDzwiHFWm9s9EvxoIvn3c/Pgbqyz9WGUc6RyveV
 X8PVrqlL0UTmITeixwkEpw+6VWuvlEuGsiVBNiprc70sH4uVKls2K5K3hJCjFDR6eFT5
 pyzTmgziBAtuTtO3ipt2k5GODXqVs9twukWii5V8CFGxHABqw601sYQiDmLnoR6X2UWV
 UoJA==
X-Gm-Message-State: AOJu0YweiIaPfN0H5ucCQfZD07tajrwddOz8b9TKsG7HWBflMw17sxB3
 qp8eZ90d8axtFoMiYPMVAFmdVQ==
X-Google-Smtp-Source: AGHT+IH9soqfTxz28L/yKo3rcKb++U+6IsaKN25Q4Yof4Y25lNWJHlzq6vHN7D5qd4fTEfSckxbtSg==
X-Received: by 2002:a17:902:e805:b0:1c0:ee68:fc84 with SMTP id
 u5-20020a170902e80500b001c0ee68fc84mr7091073plg.26.1694280079575; 
 Sat, 09 Sep 2023 10:21:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d50500b001b8b1f6619asm703726plg.75.2023.09.09.10.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 10:21:19 -0700 (PDT)
Message-ID: <4ca972b7-f65c-ca9d-c0e7-885260a9b11a@linaro.org>
Date: Sat, 9 Sep 2023 10:21:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] contrib/plugins: remove -soname argument
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230907101811.469236-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907101811.469236-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/7/23 03:18, Paolo Bonzini wrote:
> -soname is not needed for runtime-loaded modules.  For example, Meson says:
> 
>              if not isinstance(target, build.SharedModule) or target.force_soname:
>                  # Add -Wl,-soname arguments on Linux, -install_name on OS X
>                  commands += linker.get_soname_args(
>                      self.environment, target.prefix, target.name, target.suffix,
>                      target.soversion, target.darwin_versions)
> 
> (force_soname is set is shared modules are linked into a build target, which is not
> the case here.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   contrib/plugins/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

