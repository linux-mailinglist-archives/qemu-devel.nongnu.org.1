Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC0748659
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3Uf-0000WF-7o; Wed, 05 Jul 2023 10:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3UZ-0000Vj-CA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:28:28 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3UX-0007uC-0Z
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:28:27 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so10988908e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688567302; x=1691159302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PDPOmokUF2beJm8ie2U23bitmWIjV59/u3PFgyn9hms=;
 b=EurDq2Skxz8vTmIDbDDA+tM2SeT5Ejmbca/WCEoHELiW0kbVw2WfYDyoeNPcmfAn58
 p/2MMV46jn03Mu27IHlF55nb0TiX+8xfZw0JlnQBljtc6DSnCsGe+6C7f6xJoFlHsxOt
 fnvGAg7IIgV//de93K3FPbFTXdBVVVXoX6lZeaG5WO/yYEXs7K8GBOmpFoaq6srpJU36
 F+bZqmzUu+AXPMSqDuUh6VHWGbYt8FI6779QBjTZnF5qDFHMHpE6zjDbTtt2snmv5dBq
 mzZvvcqVGBpE/Uls8GwN5RVakUMfrcHCSGY688vjgnNFWZBCYdrAKu2mSX20ceyjL9H2
 71Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688567302; x=1691159302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PDPOmokUF2beJm8ie2U23bitmWIjV59/u3PFgyn9hms=;
 b=J7b8UZso49RCTm+OlglwHZxlSkV+sFtjb5BW1CadN2B1kwPr606Roa4Hq5utBqyv8O
 40EGqurqpJqhf2976rtA3cWK2CN+fJLhQKuAkMPpSYCD+WCN3kHjH6kZ+ISQTolG75zU
 cal6nmwEJapQ2KocJje3ntSIKc9AXvgHwC201fdZnWh3x/Xu2+R/tehCZqmTnSxAbEdH
 P4VMJ4GErQJ5wI/Sq5eEYDCuPn/Y4qqoxyEUtt6TI3qdJvPlpfeTExvfs29vhCjnOCoH
 3Evek04SY3gJDJrPhVjRpIWzxuAiQ93j83TY3UAU40u/7hd1cZ5UY+RSCFePHlH+E4Bm
 HPvg==
X-Gm-Message-State: ABy/qLYZ2E6NVkZS9usfX1AvXSmL5gzCfltlpESt25bn8i47T5U1TJVi
 au6NX1BGyd/eLQkbye+oOqULPw==
X-Google-Smtp-Source: APBJJlHADc0w15Z0H+W3AkiHOAh9shvM4XDRnWgSKZK8bp/J0jEOlMp/EPPiBVKrKOko21SLlDn7tg==
X-Received: by 2002:a2e:91ce:0:b0:2b6:9871:21b0 with SMTP id
 u14-20020a2e91ce000000b002b6987121b0mr12033616ljg.36.1688567302557; 
 Wed, 05 Jul 2023 07:28:22 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a2e7e0b000000b002b6ff6e7dccsm330689ljc.26.2023.07.05.07.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 07:28:22 -0700 (PDT)
Message-ID: <2a4fc15a-10fb-8b44-ce98-63e704d10d9a@linaro.org>
Date: Wed, 5 Jul 2023 16:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/37] tests/multiarch: Add test-aes
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@vrull.eu>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 pbonzini@redhat.com, eduardo@habkost.net, alistair.francis@wdc.com,
 danielhb413@gmail.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-3-richard.henderson@linaro.org>
 <CAEg0e7hqkof1N9ymmkopPpEP8P+cnUJ=qr365dxHgUQaRPvvgQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAEg0e7hqkof1N9ymmkopPpEP8P+cnUJ=qr365dxHgUQaRPvvgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/3/23 14:08, Christoph Müllner wrote:
>> +config-cc.mak: Makefile
>> +       $(quiet-@)( \
>> +           $(call cc-option,-mrv64g_zk, CROSS_CC_HAS_ZK) \
> 
> I think this should be "-march=rv64g_zk" instead of "-mrv64g_zk"
> Otherwise this will always fail.

*shrug* FWIW, something built for me...

> 
> But I would drop this gating mechanism and use the idea that you
> proposed for Zfa:

... however, you're right, I should be using .insn here.
Thanks for the translations, I've c-n-p'd them in.


r~

