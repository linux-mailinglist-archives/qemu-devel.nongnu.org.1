Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C587A78B56E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 18:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafD7-0001er-07; Mon, 28 Aug 2023 12:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qafD4-0001eN-6h
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:35:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qafD2-0005d8-2B
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:35:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso31877765e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693240522; x=1693845322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zvTVERcFeUqikEzJ/BKgJACrFETwVkhfIkueSedvOPo=;
 b=VKOgQPGyZBY9elCPdMrqfJsiDNOHKQtOjf/kDFNeBX7JB9D7YMIEldpTc/rCG5dCWA
 yv4+awm/5AfQ6L9ITBetosFE0feECkzzb6smGkvseZGQFQWVdjiTP4yPjnZPCZWGFE8k
 WtsInTEqpk1Bwn9Cps3vu9MtJNW9rtQfx8bPSzp7DoDEk0C9rtASVRzLxJXU9+xKY01X
 bCwTjfyK50024EwbNokH7XcvwiCL+K9Z5EmsG15B9UYELx8z5Yw+o10aCvuZqXPqsBxz
 cw5FHAt3jdQnBdgccfkw1dsHH3mQx5VGnkYSxUvoaXRZ0yIKf8hBtXHQQHZUEZCe0oZe
 s6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693240522; x=1693845322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvTVERcFeUqikEzJ/BKgJACrFETwVkhfIkueSedvOPo=;
 b=Pr9RmCbVEimT+SiUrPmltOvHdtk13rj5yhbhuZ/aD00erRGqJWteb90WNqzcAJmmOD
 djtg/p+BNwT8HS1FHm1IBYe+CL2osXi89N6NaKUA8u/BsY7HV0drsIQqCjdUK1pbS5EQ
 fr8TV1bNfslzsuO4eKYwJbVIexAivxF/CWUpjXZh1xPOAn4QCORo1T5E4RkB53XgsmqG
 tLV+vBFj3+/iKylZt7fWi8Q1HW3DIfmqqMhzilQFcpSPBwpKkBN141ODyC/zsdPSpqdL
 Vnw2VV1LO8TjKjwL8qLjl0KZJsRw7whlJ4eKNr3evF8b+0Tvnudjo5sDms+l01AzBleu
 r5eQ==
X-Gm-Message-State: AOJu0Yy6Y0wMg35QiifN38enviiScezN9IKSOFWImCmzt6CrUzFocDRr
 0icmlomiyJiFvllutiJUuSx7Eg==
X-Google-Smtp-Source: AGHT+IEwUGplZcjw3gjiV7dY8L79fV1tJRolVNOdyBYCqhH19Llv8Z33N1IDQ/a+bBBx24OaB1BYfw==
X-Received: by 2002:a05:600c:22c2:b0:401:8225:14ee with SMTP id
 2-20020a05600c22c200b00401822514eemr9172778wmg.41.1693240522152; 
 Mon, 28 Aug 2023 09:35:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 10-20020a05600c234a00b003feeb082a9fsm11323361wmq.3.2023.08.28.09.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 09:35:21 -0700 (PDT)
Message-ID: <c57fdec1-9a6a-6cfe-7983-61ac3e1579bb@linaro.org>
Date: Mon, 28 Aug 2023 18:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 08/20] target/riscv: move 'host' CPU declaration to kvm.c
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-9-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230825130853.511782-9-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 25/8/23 15:08, Daniel Henrique Barboza wrote:
> This CPU only exists if we're compiling with KVM so move it to the kvm
> specific file. While we're at it, change its class_init() to enable the
> user_extensions_flag class property, sparing us from having to execute
> riscv_cpu_add_user_properties() by hand and letting the post_init() hook
> do the work.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.c | 23 -----------------------
>   target/riscv/kvm.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


