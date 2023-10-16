Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA377CA9F9
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNqp-0007aQ-CX; Mon, 16 Oct 2023 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNqj-0007Xa-SW
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:41:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNqi-0003AC-Az
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:41:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40535597f01so44521255e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697463694; x=1698068494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3td5XKvj9cu+xRqG166qPeZDcmQvmSyl2FqVOMpkBsw=;
 b=uYH3ljFwfZYnflSAYj8Zf851ETjJ7v347SCbmYof4ogeDdm6PljtO++rhc3YsHbCux
 hQX8EPRZESMWbApn79GprFZMOFN+n4XAgE4rIF/TbIbbarCmCD+JyZEZsFoXMvTCJCgy
 bEL2Sr9W3JKjI4mHlNYm3FCDcfQ4z7ZH+R3l//T70L2cS8L0T17h8wQ4ADAmltVyWMn+
 bpspFvn+h1zOCMYrIn0PKpOocP+5uawFcnVZDsiPSiM5zRtkTEEHAVhidjCXcSNVYPNZ
 2vbI1sdQ/M0FFEF1uTEJ8n5gqWrxybPuybNkNd2qd7CGv7U4peMuP4Tu+zhsgNmul8Ez
 ir3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697463694; x=1698068494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3td5XKvj9cu+xRqG166qPeZDcmQvmSyl2FqVOMpkBsw=;
 b=DX1ag+kTvRcTrT5WMVMn1GoEh9AcrDQT/lJMpr7oz0txjSZG4QnaGqzMoJIw+iGXVG
 ITEXeOB/kTHqfHqKEUxDYRTfaGZBW6ewbv3J9nG8B1JRhlTcdrf8R85aiIJHq3qOXMM8
 nUA0sQmsM8sWjnImRNcXsPYXCyFNDmUfNiFzPugVdQgB37FTejTH4x1GZhtEUkNqCZSF
 1Iku053Ja19zIbeJ9nU1LipzLm5+gFk672E26wtQdBl2EwOcxbBv23EPbR5bzmS+9PC/
 5gVZWa7STWJsdXnkj9NQ7quQ+SvCNTFw671ct8aNZxS/vFUs8Z5QiSH/oehDkZvNVdQd
 w31A==
X-Gm-Message-State: AOJu0Yyn6er2VNyWBcLFwmZMZLT9Z1IuP4zlZBJfIdeg4l0WR371xNF0
 3N3ysoAPaDYS1a1Q9loO5FP53JEtCAwJ4/x6ED8=
X-Google-Smtp-Source: AGHT+IH03Y/0gfhUj5GwgfTjRPzOdNKxfCU4ylDzJWNVQzvdx3xVlFBZIbVT5qiEovlgYA5vQ6Vzuw==
X-Received: by 2002:a05:600c:b59:b0:401:b1c6:97dc with SMTP id
 k25-20020a05600c0b5900b00401b1c697dcmr29554058wmr.23.1697463694388; 
 Mon, 16 Oct 2023 06:41:34 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a05600c19ca00b004068def185asm7260326wmq.28.2023.10.16.06.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 06:41:34 -0700 (PDT)
Message-ID: <9a6e2a9c-2a2d-0ab6-6492-d291e24a78cb@linaro.org>
Date: Mon, 16 Oct 2023 15:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/avocado: avoid invalid escape in Python string
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231016094016.173598-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231016094016.173598-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 16/10/23 11:40, Paolo Bonzini wrote:
> This is an error in Python 3.12; fix it by using a raw string literal.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/avocado/virtio_check_params.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


