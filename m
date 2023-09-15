Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD027A1A76
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh52i-0008Vy-33; Fri, 15 Sep 2023 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh52f-0008V0-BH
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:23:13 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh52d-0004zL-3G
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:23:13 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-502f3a06dc0so787297e87.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694769789; x=1695374589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/oZfTsKvZxSPVr1mEdVq01yA8A/gKQTcmdqxpkx0v0c=;
 b=p2IWFvPNHMItSj+V5+9pd5b/VXox10eiux0hQoQMEUoRKK6mHNYVgTVWFOuZawWwxk
 RNobH6W4MBsRL0lsNyKseNgWLTp8zPOt8fg2G7DBAf9j6paAfoSHNqnnaI25zLtwE1nh
 xzb6+i/9RyFmBRbVKpqisRkTMphniywKX6HyBWGFt8MhyrESXxtjO8D60kAB1pBvkfrQ
 gwluf+CNC8GnY5iUkjSyKZZeT4KwuE7Ufbk55AyrbQIaJ+g8xjS+YUpxVGCrRyfjlCLZ
 ttkTBtmfZ3lW0531ANwZqpumzZ9R3HIgBmjBe3ob42kyBsvEAaih/g/pXBLjUTePZiFP
 V++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694769789; x=1695374589;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/oZfTsKvZxSPVr1mEdVq01yA8A/gKQTcmdqxpkx0v0c=;
 b=P23LMIwulrGgcc0N53sXwConR6X5HNHc8ZacPk2gabHnabmM17uz2BxgWym6dWxSFF
 GryCUJ3AJXGRTzmdP7HdbJf6HrrWuRCpRoBvYw/x5TWHTWT9NhYysVFDDDVTYidgdJxh
 rjtHtN4rP6hmtjm1NwHxFMJSJPBDrCBUaXlDOD+mXrN4/lG+HDhF+Vwr4D/3V7RicJd0
 Vje9MfmK0z+KrmwGvS1669BsEY1cmrkOYo1+eg7nePj7l33sRCEgv2q9S33QocYWi3CL
 4pmVY4D858Wpa6HLiSXFseHSU+wpATmiQPdwjkPW3Rr25vXcEvk6+NGEbuJ46QR3E1OM
 u7qg==
X-Gm-Message-State: AOJu0YxUhVamhT9YP1cK3IEuUdLXuoPBzS0DdqTX+Oli3kxBGU5E6hEV
 3OYwxf6espjJkl/3SsrVghj9PA==
X-Google-Smtp-Source: AGHT+IEo5bNQgfBQ/zNhvyNWjddVpOX55DCKCgg021d9XfuCZlDQkqF4hp7s8GcBsPOPf5yJEwRgiQ==
X-Received: by 2002:a05:6512:329b:b0:500:9d4a:89f8 with SMTP id
 p27-20020a056512329b00b005009d4a89f8mr870204lfe.28.1694769788775; 
 Fri, 15 Sep 2023 02:23:08 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 i21-20020a170906851500b009894b476310sm2155059ejx.163.2023.09.15.02.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:23:08 -0700 (PDT)
Message-ID: <916e88c6-be4e-961e-1c80-c2a92322e396@linaro.org>
Date: Fri, 15 Sep 2023 11:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] accel/tcg: Avoid load of icount_decr if unused
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914174436.1597356-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 14/9/23 19:44, Richard Henderson wrote:
> With CF_NOIRQ and without !CF_USE_ICOUNT, the load isn't used.
> Avoid emitting it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


