Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9407DEC22
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 06:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyPxQ-0005eH-Oi; Thu, 02 Nov 2023 01:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPxI-0005dh-4d
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:09:21 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPx4-0006DD-Sx
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:09:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6c320a8ac5aso407696b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 22:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698901745; x=1699506545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HSSeau0x6Coyf9Le3tpcKWKpnNQEJJX8p5sONzhaqi0=;
 b=CrQadiQZOs0zvcLsoLTzMaw1smaXgQ4RtGY7P/w7UKQPygKrv60VR4ZJu/IK+dBBon
 ELF0fXq29lrsillYSv/nK4QPN3GRmC6Da4s/+sQibTQBmnuplUaujzQe3IHbaSi6M+3N
 q0ALBbwKxYP6o23vYEl7u3qdHLwt1YguMay+M4tC1VBJVuOf71LYvEal/IbM91RVTpAS
 KO5b5LEH86IVggq9ZpYF6k1Z4AaF6pWYP+mIYMhYSnzve4UsyL6rVnMW+XNSeOt7fcNw
 YRnvc7DJTPXeEGGruBDDL5q5X8sOZURS5K3wQJ+Nj+AgEeX3oRECL3MvcL1+xyPJOVy7
 B3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698901745; x=1699506545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HSSeau0x6Coyf9Le3tpcKWKpnNQEJJX8p5sONzhaqi0=;
 b=QOjuatIckQCg+TCDe3EJFBKeaIACUOUt8k1owL92jyHGXyPJhUei/iCjwK086CwiLG
 Xi/dThcny/Dvy/K5H9t2sOq0s5I1vaV8ZEi159md31M7n/wKeOqcD5bJNXByLjD5ABvo
 MKgRTFWclBDalZZ4uwPIyGt7yTMlvlKZHsPgju4k393aqCdtTlz0+SRolNtMskc+CF3e
 b1YUEXMiR3Pli5/cR9Tx2m23f7nzkDEVHppT35KtWcYfyEKhLPhtDSqjW1UeXZ96Z7Nb
 6R5dRIhG69DyLytLanSNSphmP5mthbnpss++g0eSrjIbU2Gm9SkcZGqLTz2IPs8D/ZMZ
 VY3Q==
X-Gm-Message-State: AOJu0YxI5F9r4xhcXFw2ZdF1TxZJD/8HpFHjwu5iWLgs/LNxiMakkPCa
 iVfrZLk3eXZaET/Qh0I33DAAXw==
X-Google-Smtp-Source: AGHT+IG6EjYwNW/Lf89TQuM5NpncYbJlP8m3NY3TrDDK/XJmkgRN2kxUbNLfqsu2ZPTZSBBbJTLfVQ==
X-Received: by 2002:a05:6a20:428a:b0:16b:cc6c:d728 with SMTP id
 o10-20020a056a20428a00b0016bcc6cd728mr18721044pzj.44.1698901745289; 
 Wed, 01 Nov 2023 22:09:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 iz11-20020a170902ef8b00b001bbfa86ca3bsm2112487plb.78.2023.11.01.22.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 22:09:04 -0700 (PDT)
Message-ID: <324841b8-a1b8-4130-a0e3-4ce0abb35ce7@linaro.org>
Date: Wed, 1 Nov 2023 22:09:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/33] hw/arm/virt: Check CPU type in
 machine_run_board_init()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-30-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-30-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/1/23 17:24, Gavin Shan wrote:
> Set mc->valid_cpu_types so that the user specified CPU type can be
> validated in machine_run_board_init(). We needn't to do the check
> by ourselves.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 21 +++------------------
>   1 file changed, 3 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

