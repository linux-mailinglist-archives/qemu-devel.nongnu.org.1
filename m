Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FFD7862C6
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 23:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYvoB-00084k-NR; Wed, 23 Aug 2023 17:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYvo9-00084c-DK
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 17:54:33 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYvo7-0005Oz-QH
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 17:54:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so7855274a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692827670; x=1693432470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Er9KnW95FBCtMJXzoPK0iMklSmP+yTVDMMSe+HTc/eQ=;
 b=LKtWMY+4OGHSWMZ4Yi9z5IWSm4AV0lhB9EEWA5smNRF3mLtszQTufL+BBS0CxyQNRk
 GaqZh5U47DB6x3elnMx7QXEYYVGxa80k44/Zp0iJOQeNbned+yq4REgnYplNRA8lY5hG
 fJzbcyYyYbl9vjNt0hJRF4r/0cfJEuzJsupkhTE3QDTHoPa27Xgj1tlX5HNTOuS7pK49
 pQkIgeUHxMVr2HFNc4af2fFeqVyOi0qIzU3a2r2y2pW1oui2U09lc1W1ok/zmcY9eb9l
 0RxZVrgxSf8egmYDlKsIQ4knnojh9us+0GdkYaFf9ZWLt4xvPja7kXfGnLTxhaphPJ8v
 3Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692827670; x=1693432470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Er9KnW95FBCtMJXzoPK0iMklSmP+yTVDMMSe+HTc/eQ=;
 b=H2n5FSPtIcFcTmu4IjaHbPCR8A/nWW5A8as+iF/U11svF5Ee7kbC3a42w/k44dFttq
 kE1MTZUW0EZxU6EFJSWhSuez9A9k/8/1CFlF4pbViZdtoPs2eArMN7/9voRO/hQ4eM78
 JtfiTQYNgSKFkLPGbS1BdL+GXjurw5cUcynOU16Isd678oWzSrbbFBqbgJoSRJqD0AVK
 abB5a928LYbKir3jsGGuLUFWYqgx+I+aV9Sw7Kp725OzlZCe0tznXNiOdyzp9Fd6W8h1
 3mXJrcCITGcmpExwML0y0j8TGuv7YjOw9YDD4ooeHR7pucpII/fGw2H5sUC+lI6xIS8s
 Ej1A==
X-Gm-Message-State: AOJu0YwUzWr+naQzIglFGLEP14KdgUNUL2Mq6AyuQsPZgx8Fx5xyu8pD
 dC55quY5Xj3dsr4blFJQwDoNpg==
X-Google-Smtp-Source: AGHT+IFWfAtFFQ+h1OQvCNSv2N1XpemjcvxOlllaPm94Q13pvxgCccnDgUROirO/0hD2V2Yq27n1Yw==
X-Received: by 2002:a05:6402:2051:b0:523:cbc0:8d2d with SMTP id
 bc17-20020a056402205100b00523cbc08d2dmr9914501edb.18.1692827669641; 
 Wed, 23 Aug 2023 14:54:29 -0700 (PDT)
Received: from [192.168.69.115] (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 t11-20020a056402020b00b005236b47116asm9818437edv.70.2023.08.23.14.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 14:54:29 -0700 (PDT)
Message-ID: <b9c01aca-ccb1-0128-7c23-ba75c03b82e2@linaro.org>
Date: Wed, 23 Aug 2023 23:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/8] tcg: Document *swap* helper implementations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230823145542.79633-1-philmd@linaro.org>
 <8e791b52-b30e-fe8a-8195-617a05d31d21@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8e791b52-b30e-fe8a-8195-617a05d31d21@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 20:46, Richard Henderson wrote:
> On 8/23/23 07:55, Philippe Mathieu-Daudé wrote:
>> Philippe Mathieu-Daudé (8):
>>    tcg/tcg-op: Document bswap16_i32() byte pattern
>>    tcg/tcg-op: Document bswap16_i64() byte pattern
>>    tcg/tcg-op: Document bswap32_i32() byte pattern
>>    tcg/tcg-op: Document bswap32_i64() byte pattern
>>    tcg/tcg-op: Document bswap64_i64() byte pattern
>>    tcg/tcg-op: Document hswap_i32/64() byte pattern
>>    tcg/tcg-op: Document wswap_i64() byte pattern
>>    target/cris: Fix a typo in gen_swapr()
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> and queued to tcg-next with a few tweaks.

Thanks!


