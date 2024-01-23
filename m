Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C67388386D2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 06:43:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS9Yl-0003iG-3S; Tue, 23 Jan 2024 00:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9Yj-0003hW-8b
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:42:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9Yh-0007XW-Gv
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:42:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40eb2f392f0so6672295e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 21:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705988569; x=1706593369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ttf/iRoFnInREDH8ZgG2eVL3+i2zeTo5X3wAhxaomzw=;
 b=UBL/xv0nkIO/MLf9FsgCP0TPL/kU+W8YEsCrdu3SoNURhRVKehVhU/f7MNWP0PSQDg
 aZv1ZR2qehdbFpHWinkLfNT6jAe6PizoEXN/dfV4RHqeydWZ2//hR2FHF2uqI2GaOyeA
 P5O1wonj2LoLJ5jLQSxcdpasiur7/2NA0+iKPJGYWnaw+olxI/QFrPTWd+caEGnL/0Rr
 HJj/Cofiqs7CReuCwmnAdZiHxiQUgz7sW7tEpyQzbIEacUORR7gRWeilQNZJbHff3Tx7
 uRQgzZ3NkOAdMFukycqN4ySlgvWT98ZdQi02iqV5xgQyyhLLjIm4Q8NcY2uFiZRWKY8d
 kxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705988569; x=1706593369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ttf/iRoFnInREDH8ZgG2eVL3+i2zeTo5X3wAhxaomzw=;
 b=gcJJ9lBMMjBHSTVZNkub5NNV0iTpzU7UfqMWbc4NBJzapmk8BPSOrc9Zh5fcvKTMYK
 V4iSlkbT6uosJ0yVNwW+36CJMH67TaZWlUhmV2zJdx0gJPllq/Qn3VReKCbKVr13iZGu
 2mxGfsG554vtheLZDHAUInwYlNFtQCYbAWbWp0z17wAFfXadSGnOWwObShK1uDuDzNTL
 SmIE7G74knJaCOBRWI8nn1wIG3s5KQw4EykLc9qC6EUEQNqmzIJFS7PuwhYI94Jl61HU
 t/b5pVVan53Mh7HM5RFlylb6nISIGBRjT15reL3EtweOjeTB7jfgqEnUf9ZLLcAByZgi
 qwWA==
X-Gm-Message-State: AOJu0YxVeWgVFBsgpX6PT4N7DX+5bPyJWXwlIeIW/NyjC5RWVVTxVstf
 Oi1Z6rPL2xhY8fWzZni/dVoUrThoJzA8CFZ9lcig0NScYf7bEiRrCbcS7psK8F8=
X-Google-Smtp-Source: AGHT+IHSEbfW4CUNHhkf4qJaEgXe+zcg+bE/q7swmJK73FIGfn59Xg4j7H0KzlH+9AKmc3j/6n/Bsg==
X-Received: by 2002:a05:600c:4b99:b0:40e:5abe:84d4 with SMTP id
 e25-20020a05600c4b9900b0040e5abe84d4mr189462wmp.68.1705988569498; 
 Mon, 22 Jan 2024 21:42:49 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 m35-20020a05600c3b2300b0040e541ddcb1sm41322468wms.33.2024.01.22.21.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 21:42:49 -0800 (PST)
Message-ID: <144fc09e-fa3c-4a6d-a724-a46e434fc5f8@linaro.org>
Date: Tue, 23 Jan 2024 06:42:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/riscv/virt.c: use g_autofree in
 create_fdt_socket_cpus()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-4-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122221529.86562-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/1/24 23:15, Daniel Henrique Barboza wrote:
> Move all char pointers to the loop. Use g_autofree in all of them to
> avoid the g_free() calls.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


