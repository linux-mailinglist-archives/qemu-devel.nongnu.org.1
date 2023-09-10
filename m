Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E567E799C37
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:02:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf8pU-0005pw-DG; Sat, 09 Sep 2023 21:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8pR-0005pZ-Li
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:01:33 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8pP-000672-G7
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:01:33 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b9e478e122so2332778a34.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694307689; x=1694912489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oa/bRZbahsUIKB+CLANqaIRDLzFDMx9G82hNjrqsLXU=;
 b=JLWN6AOOaGa6tLqsFNa6BOdZo6T9UJWRKlzZKoSfDp6RmBTZFBAW3kQhczLiHPXK3R
 1T++XypdFhUJXk4ubSWjaVqlBW/2txXMOI6O2Su46wG0PcDJhpARzpaPlNUFu60VHAOx
 7ORcw207sztWKEg6F4CKZ5FTyH18uOqLuiTXUmffRQrlr3QzXjFTH+QKyGVHAJFz+Jtx
 r5n3VzzCemyklGm1fyXCLdHPrjyYJOtiFwwm/L6JFqMXycTUt+Qvx2nx6QIOIDJSTwcW
 UYXIwWyjoMrZp8th5aQnO4yojUfWT5xLkdw/7OTTEtiLo21I9/RXCPmmYcC8VKeIZVrL
 +UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694307689; x=1694912489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oa/bRZbahsUIKB+CLANqaIRDLzFDMx9G82hNjrqsLXU=;
 b=KREHccupM6Hkxj6oXsKeQcGhsO+fwLdUWOz0+2YUMgWjOF3/kfCAfgESvXuiMK8s89
 kCOJdng2Uo8giiRJaN8Aeevaz+kdH6EaonVm8gzStH6wzCSnIJj0yzLWhRx3Q4+/kVOP
 ANRrj9UP1KhFPsiKVCXFkoCNCWj6SjC5nhJDWmmIiyNbptlxzt6lh8oiR22OqUxFORBd
 wOZPpbPbjdFDkuaXlT/MfUbr7EH5HYNaTw+XYwXUXlEr5tY1CryA2vsD10t9OE28n0/d
 aBhcMHvOtBcwQzYUvyk/RTCv/L+pDdRYX48HytVmAPe5JBffMfoBS5H2Re0rmPyex307
 MNrw==
X-Gm-Message-State: AOJu0YwCUQxxXfZ2lFTLMZOtLvBr92OzJuBzzspt6zSUFgKpX4ud/Fk6
 E0G2D2sx4ulckhGEUNV/Y3x/Gw==
X-Google-Smtp-Source: AGHT+IE3woE007PhQ4B+D3v18rzqRj3J7Yz/Trv9jW7go3xMe6EB8XfLAbvmRVMponxhKrsRbceHUA==
X-Received: by 2002:a05:6830:1c5:b0:6b8:807b:b50 with SMTP id
 r5-20020a05683001c500b006b8807b0b50mr7005719ota.22.1694307689103; 
 Sat, 09 Sep 2023 18:01:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 i15-20020aa787cf000000b006875be41637sm3341476pfo.145.2023.09.09.18.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 18:01:28 -0700 (PDT)
Message-ID: <8510e419-cbc6-9dca-ac97-86b6bc62483e@linaro.org>
Date: Sat, 9 Sep 2023 18:01:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 08/57] target/loongarch: Use gen_helper_gvec_2
 for 2OP vector instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-9-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-9-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                   |  58 ++++-----
>   target/loongarch/vec_helper.c               | 124 ++++++++++----------
>   target/loongarch/insn_trans/trans_vec.c.inc |  16 ++-
>   3 files changed, 101 insertions(+), 97 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

