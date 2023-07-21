Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FE75C7CC
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 15:28:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMqA1-0006VM-KP; Fri, 21 Jul 2023 09:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMq9u-0006Uu-TS
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 09:27:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMq9q-00071g-Gl
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 09:27:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so1510495f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689946015; x=1690550815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhMMnXPCq5C3E5+GGZ1Y4SAaQ8muPq/De0YmK+r0Koc=;
 b=vLvB6tsouUhwSfzpof3xmbgnGdDtUGznEoc6lAgbr9pIvjUbO892D5M6vOzUmAUgGX
 BAVygbrNwHkMW6Mn4VZadhIuPZBHP26TIhW8tIAKTUhqIWTOE2G5Sxos7J5JbzAlwdpE
 CL5gIQAnGw5RcEwPCUuMJLx3v+QQQ/ASLsr00MGMu23nCYOcbEeJ7k02RMGV5SIlT54K
 IcwHMV0h6X5QFINHyIpLe9Krzv95KmQNmz0AxviH8/sBC30W7oYHhiHOOjDfueD9+JDJ
 W73Ez8HuVHtBt/C7Q3PCyql6JYuxIv1zwNIwgWgLmbPADNfj4Qjr1MEKAr3rc3beSiko
 gXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689946015; x=1690550815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhMMnXPCq5C3E5+GGZ1Y4SAaQ8muPq/De0YmK+r0Koc=;
 b=eru57PFpCmio+4crJNHFoksKM0LEIf9OthS0Z1g0PYvtv8Gs+z+NpOc5IVaPbI3TQm
 XqMG0QACANQ3XNjPfHwQZsNbZNqCCVSVqbWEeINW6VEjfRIyCg/Gxa2qivzf+fgUfxug
 KpMyvD8Rtk5lL8yrLQd+G3JvCUhddsqk2i4Hiig82OoURGgv7HYI/Hu9YLMNB3zcvQ+y
 /QvtomvYGjaFuphAwI989Qta6oSVJfMAI1jS0jXqNX5JQ652k0BycdbFgVpgoBHgHl0G
 Gfon+rO1efnHzEsL18THRhWiJzEjwo76lRB8ofyJ5I88KO8BcMBpWTsGS9RezjNgswQJ
 JFoA==
X-Gm-Message-State: ABy/qLYtVzBtfnWuyLtmntaMHeVXZMEDPhNWfeA2O0mYhvqKCLfurrCp
 kkArs5bNZGYJDSRE+gJexue60w==
X-Google-Smtp-Source: APBJJlEUKaLuBELpHLGdYm045529bUCCh3V4PJPq8sIFMwYPh+q8b4jcDwIcuW2FEeCq17PHH9GoMQ==
X-Received: by 2002:a5d:6783:0:b0:316:f25f:eb4 with SMTP id
 v3-20020a5d6783000000b00316f25f0eb4mr1145235wru.60.1689946015069; 
 Fri, 21 Jul 2023 06:26:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 o8-20020adfeac8000000b003143b7449ffsm4202115wrn.25.2023.07.21.06.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 06:26:54 -0700 (PDT)
Message-ID: <2f6463df-fa50-6214-5b70-707fd84fb187@linaro.org>
Date: Fri, 21 Jul 2023 15:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] hw/char/riscv_htif: Fix printing of console
 characters on big endian hosts
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230721094720.902454-1-thuth@redhat.com>
 <20230721094720.902454-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230721094720.902454-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 21/7/23 11:47, Thomas Huth wrote:
> The character that should be printed is stored in the 64 bit "payload"
> variable. The code currently tries to print it by taking the address
> of the variable and passing this pointer to qemu_chr_fe_write(). However,
> this only works on little endian hosts where the least significant bits
> are stored on the lowest address. To do this in a portable way, we have
> to store the value in an uint8_t variable instead.
> 
> Fixes: 5033606780 ("RISC-V HTIF Console")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/char/riscv_htif.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



