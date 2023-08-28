Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A10878B625
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafnw-0008Sb-JK; Mon, 28 Aug 2023 13:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafnv-0008SK-2Q
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:13:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafns-0005Xj-PQ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:13:30 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a410316a2so2479096b3a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693242806; x=1693847606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XPgYa/odW0RvmnK/7lFKuzTQ1NTWsKb+PHyJdXKTC3Q=;
 b=T6mL75+aXmRgHg8wWCTQksVVkjV9lDwoCc8pzodyHsmgdzPUJU2jmbIjX6QiMZsYgs
 kKKl9181A5ofsyqg8MSfVMNofYs8S6tzGYfd/L2PR/cj4Fovpf9cMXxvNSUZvaChmhKN
 +cMSvlIKVX3HKY3C/h3luA8n8N+Agh9gIiZFFb0ZJW47E0PKzxZvUYnSDZH2mU9AGQJR
 g4RvcyYJsl4F1iBBDQdvw4Vk2ONsVw5ePsxX15nPw+EvBOlL58FnGC5zgevi+/7OYVin
 xVu6BA6zuRWY/LLULjPHQktdFyWoFNEwSnQmfE/koah1DDwk7EhotTy7Xmg4pIBovRx0
 PuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693242806; x=1693847606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XPgYa/odW0RvmnK/7lFKuzTQ1NTWsKb+PHyJdXKTC3Q=;
 b=Klls3bImLxIxFWzo9IWXwym/M4fXf8raDiOoNvUKcpQSTdiCRatQ2a7mFgyDc//4FS
 LwsjJ9UTaHiTXxcVMr4JHUKiGMin6PfBs5/SoVC7exJuNfgJPHZiwubrMZrFG2hN6OVh
 Ai8Sz9x8fPWMkavjnlsE/IAstXLEGoR9YX1af4wkw/71T0yR+6B3PynanepN+40dZQDY
 7XD/0bnGi6+fKHjMjWrzUOzwm/f97QL5/d7M4/FpegWrsBGH3lb6dryab3Grz+jo+Jly
 GSCX18Jn6HYG+bnCfz+uTP+j8or8pd6p0w33NoLMS+5FykEVDRo4yzRl0rWscoLuI96B
 J3Kg==
X-Gm-Message-State: AOJu0Yz9vBHek6x3zU2z5XEcyXaopO+oxYRP6W01V2zzuvhflLjbx3sP
 VBzKmK5DKm5ShgBlLO4phWQoKA==
X-Google-Smtp-Source: AGHT+IHG7G9c9tfZbOf3MuTmJ2eezhCvBUWbUQ1tlGEL5RsWCH7ECofGF/ATsxdB8n0nFyAA28f/lA==
X-Received: by 2002:a05:6a00:2194:b0:68c:b30:8fcc with SMTP id
 h20-20020a056a00219400b0068c0b308fccmr7308364pfi.20.1693242806581; 
 Mon, 28 Aug 2023 10:13:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z8-20020aa791c8000000b00689f5940061sm7124543pfa.17.2023.08.28.10.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:13:26 -0700 (PDT)
Message-ID: <b2eb25b9-9d9f-f0fa-877c-06c2173897db@linaro.org>
Date: Mon, 28 Aug 2023 10:13:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/11] tcg/loongarch64: Lower add/sub_vec to vadd/vsub
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-5-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-5-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Lower the following ops:
> 
> - add_vec
> - sub_vec
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For further improvement, VADDI and VSUBI have a 5-bit unsigned immediate,
giving you a range of [-0x1f, 0x1f].


r~

