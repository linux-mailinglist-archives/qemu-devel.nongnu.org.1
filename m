Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E678A7B25E5
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwab-0002eJ-R3; Thu, 28 Sep 2023 15:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwaX-0002dQ-Ll
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:22:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwaQ-000255-Dd
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:22:12 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-690ba63891dso10453867b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695928923; x=1696533723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKSlZdVOGX+ZMVR36wyq/I2cB7S0oxMqPMwajXWY1zs=;
 b=faVchqrsAkF2zSXHfaumcer40r4lRjvOMEPX5hZMwhflOD/60MzM7OH7a6FCh4dYQi
 tX+oJjsuDhsXvTH6P+5BRptv95JOEzQ19PMyfaS9IYgxEBvUWWZ/ai+hkDSCoIKLVMlx
 sifTrlqCnB0KzrfEyYoSiGKR1i1Yx+uYNV5feGpeC4b2cxFt0xTNHH8yNDhIvcnnhUjY
 NFcFZRrY4IaHy0N92bOsL2Vw6L0pH40HQ2T74XqWuiVsI/P/fqJtzT+xiLwqIOdZCht9
 i/NdN3UCiJtmvRD0RGFHEoQOinK51Ijrr+dHHtpGASwqg3X47O/OJI5JR0+NIdxGrkCr
 AdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695928923; x=1696533723;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKSlZdVOGX+ZMVR36wyq/I2cB7S0oxMqPMwajXWY1zs=;
 b=mubGG96UpB3/zOTC8s3Gjz00To16E3mTQjTiq6WRa7pM1phXolkVB421TSCV34Z8p6
 ERtY9k+Vv4uA4VMMmx9QeGmPrlHKlbTTcvrm+FD62H0RlV93bjB6s066bs0ykVXK3ufq
 /NhuULPugPciQ5el6itZwvzuutI+hXCv8KtyFq3dEJPdqKh4qSTNhfCuwoTWUHQ4e3SQ
 Jvw1cYrMPutQ/EhUXuoxvLVaBsb/5XMW7veNlvnRwNmYE8x/pKrCmeVkmHyW/sg6NqLk
 cPv1IKXHIcgdhxNZd1mB1F6NFBqY0oQ9DNnpoGXCZ7gLSE0E+wU0FqXd3M+DLwMdEHkH
 wHzQ==
X-Gm-Message-State: AOJu0Yx6lGQwlDhKk6H4DHs/EV3wzasLdUAj3QU1HYafM1p18VMQHrCa
 1qCFFh53YH6QKSPjCpbsMJahag==
X-Google-Smtp-Source: AGHT+IGRQ2H62FELxQ61hgKUf/ihpXLrUaspbp+8yKkBHS49+Wlu6efdFLGRiztM/6vAgLcmIgGueg==
X-Received: by 2002:a05:6a20:6a09:b0:14c:910d:972d with SMTP id
 p9-20020a056a206a0900b0014c910d972dmr2404908pzk.12.1695928923430; 
 Thu, 28 Sep 2023 12:22:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa792c9000000b0069353ac3d38sm1196408pfa.69.2023.09.28.12.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 12:22:02 -0700 (PDT)
Message-ID: <a14e853a-fb10-dd49-44da-2d50ea590088@linaro.org>
Date: Thu, 28 Sep 2023 12:22:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/arm: Implement FEAT_HPMN0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230921185445.3339214-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230921185445.3339214-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 9/21/23 14:54, Peter Maydell wrote:
> FEAT_HPMN0 is a small feature which defines that it is valid for
> MDCR_EL2.HPMN to be set to 0, meaning "no PMU event counters provided
> to an EL1 guest" (previously this setting was reserved). QEMU's
> implementation almost gets HPMN == 0 right, but we need to fix
> one check in pmevcntr_is_64_bit(). That is enough for us to
> advertise the feature in the 'max' CPU.
> 
> (We don't need to make the behaviour conditional on feature
> presence, because the FEAT_HPMN0 behaviour is within the range
> of permitted UNPREDICTABLE behaviour for a non-FEAT_HPMN0
> implementation.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/helper.c           | 2 +-
>   target/arm/tcg/cpu32.c        | 4 ++++
>   target/arm/tcg/cpu64.c        | 1 +
>   4 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

