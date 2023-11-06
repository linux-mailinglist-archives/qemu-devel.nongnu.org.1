Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C47457E2077
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:54:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzyAs-00011m-W3; Mon, 06 Nov 2023 06:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyAq-0000sm-Bl
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:53:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyAo-0006om-Sw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:53:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso38340905e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271620; x=1699876420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2XBlTMiO0LJRqlq4BVsBpQaDSeYK7grxgD7nTyKylS8=;
 b=cjGGngm3EoU6/a6nwEczso2AbqZ5sW+ATAFH4DW/krjgGk4tfzfeMq9U/OUq/F8R2L
 viTru0fI9Bz6Kt0OJJgWyXxP9oG7zz45z/JGvmQfAnm6CAXHSQkPkmU4+jfG5uhn/bMs
 CrMN/vFmgkrjPna6xHhjel08iSbBHd9+8CR737OjMFpjtCCmoEUz59g+ys+0mbTTBee1
 RNwZDKRWBhBApv/+FszSNPHU0A1koU/YhOS7O93M822HmBo6yscFDcd0/IUjndv/D+rk
 0aXALSeAH6o6KD8pIvRLUwxIcpnXVeT2SKpvroQdRAbGq2WkrK/XIvf3KJPkHv4OCjMd
 qXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271620; x=1699876420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XBlTMiO0LJRqlq4BVsBpQaDSeYK7grxgD7nTyKylS8=;
 b=AGRT0wckdLFpax94rSVxg6d2sjCAMK+vobFIeptulqIKt2uhIAqY9la0Ds8oW3vk9+
 VEf9KiNQuCY4HbNinSX9AfNAFhTtNwz265os2NGvpQPfyWSjuqKwman1W91HPbzb9GWj
 hTNlzDI6iRK4g9/Zop2wuRYyMZJ6+sWUDkHr1RSz/4ER0Zku+P4NLGfdZ0IdidbN6g1q
 ib8hZobI5wzpnLpNLpJFKntmBqx23x1QmFfdlEJR9ckd568ujqtX+WR+h56xEZRnOKIi
 xqnyHR6c2dl4CLVr9mmpT4VoLToHEHbKHLA7ssJTXfpP91QO8kARgvOBPAVzxus1cOi8
 rd+Q==
X-Gm-Message-State: AOJu0Ywmn/4SJcFr3gNUMRndlZjYyf9XNrEbDqvty5EluaWyhGkBLam+
 gF42mbXC07KNOnRFL2diCANoJQ==
X-Google-Smtp-Source: AGHT+IH2fqjoz6BU4XRrk30ujgIdicTwru7EvzUZV2UVSh6JBAps3lWyrmmCU1njZ2+k4ZhoKqAkvA==
X-Received: by 2002:a05:600c:4fcb:b0:405:367d:4656 with SMTP id
 o11-20020a05600c4fcb00b00405367d4656mr24422753wmq.29.1699271620382; 
 Mon, 06 Nov 2023 03:53:40 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 i20-20020a05600c355400b0040839fcb217sm12038131wmq.8.2023.11.06.03.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:53:40 -0800 (PST)
Message-ID: <c188796f-dc17-3102-b3f0-8da6007ac91f@linaro.org>
Date: Mon, 6 Nov 2023 12:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 05/71] target/avr: Constify VMState in machine.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


