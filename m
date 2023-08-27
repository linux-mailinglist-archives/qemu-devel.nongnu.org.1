Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54553789B5D
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 06:25:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7JT-0000Bz-Cb; Sun, 27 Aug 2023 00:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7JR-0000Bm-G4
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:23:45 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7JP-0008Tk-08
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:23:45 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bd0a0a675dso1716602a34.2
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 21:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693110221; x=1693715021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3qTE948DBE6DD6HAwc8cJxMq1oIaomXZgt+CQ30rhwA=;
 b=zR4VGllDBzt4fkLls66sgXkCaEPxUXmYlyevtHnxlmfEcSZhB4zZ/tCxgX67AyxqBr
 XXr87CM5mF+Gs74EgXeXZvnmsB1XeYslQx63j47nFqCyxKqFudmi71J7w7geyFf9nFG7
 NAbdxPJzMEBF7jk2p8aMQkGzHt9Wb2TKhuqjH7kkbV6TTxV71ukP9co1bdf8HMLZi4rp
 hNcR5n1LaZuolmrSlr4TNVGohgRCxjXu20SMueWcz8ae1B6bEqaLcHUNBOVjjS1VFJ2x
 oX9dlHx8aa/ys6RDzHFx4Ts/crzXWExWR5SKAo0RUg0N/jpbdMIxeExdL069k253DZwd
 Q7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693110221; x=1693715021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3qTE948DBE6DD6HAwc8cJxMq1oIaomXZgt+CQ30rhwA=;
 b=JMWrJ3JPWo+vZdufeNXtu4pyK9B7nGOzP3BkKiYqz+VyKpZmP08LCVEpsoPep9OqTQ
 tfYyfqUOFBMjY1qdc/75GyPmxYNwET1Ru3mhIxs4TU7rAAboGVDlETUJdK/8Hpaioj2P
 dV1laiuEU5zXL4i/hqwziipRs7itZw5/7gOh9yDPwhWUfJneaK+zaXVWLHbM4fLbfyGC
 7PhLj07+Tolk23fspO/cSOepa42UJhgJDA3ilgUq5LRO1pAx2Ay4kl30rHQ3TKhBRREL
 uQTy7pXIM+G59zsybxUMS5dpbJl5DEetiNKENzxCU3EPqyfO16Fk5Gb1aomiTdujaryO
 ZrVQ==
X-Gm-Message-State: AOJu0YymDUBNa5y8ly/zTEWAEde93FOirBPxe/cRRP0sQGr4KOSUuI9B
 FFXkP/poxO0WBxUKc3pan8KDoQ==
X-Google-Smtp-Source: AGHT+IH57sbue/UXsyWMPWIwPh0yn1VMs4TJX9KhbWGQZh5m7NTI2MVCjllepgYalKuEMfZY+fjYwg==
X-Received: by 2002:a05:6870:524f:b0:1b7:89b5:7c11 with SMTP id
 o15-20020a056870524f00b001b789b57c11mr8578251oai.9.1693110221208; 
 Sat, 26 Aug 2023 21:23:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a17090ade9400b0026cecddfc58sm6064781pjv.42.2023.08.26.21.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 21:23:40 -0700 (PDT)
Message-ID: <a20c3ad6-f316-c519-8295-ebd44eee8b59@linaro.org>
Date: Sat, 26 Aug 2023 21:23:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/10] tests/tcg/tricore: Bump cpu to tc37x
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-2-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> we don't want to exclude ISA v1.6.2 insns from our tests.
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   tests/tcg/tricore/Makefile.softmmu-target | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

