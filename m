Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE36A81F200
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 21:54:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIatW-0003jR-KH; Wed, 27 Dec 2023 15:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIatT-0003i6-CJ
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:52:47 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIatR-0002E7-Vj
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:52:47 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35fd5a13285so26702095ab.3
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 12:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703710365; x=1704315165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OoIBZjgXFIRnUM0UIofOqTDR2cCNRH9A5fZ9FHXCi0c=;
 b=jU33gutfbVf04dSia0YHCBBJrella5gNxQ71Gi3UkoKrK92N9TKiogHfEvfmAn0/Lw
 EleZxymzHWpa0lpErctPl4SipQnEOZWL9E+tbtk7OmjyWGmS/IFycKos7ZggqY90iVKV
 e6tuLW1GH7B6FN6itrXa/slMnGeqx7cfuJjTukfTIBL7iGpV2Zz4GB4lKSCZIGV8aXaU
 VaZvQA7tjapKRp36Sxhe1Dybdsqaivog1htxoYoLHEEJPX1Ki+vmxL0+wgxQLG/uYc+4
 uOP40mbk077WixblYbN/Pqf0iwu1HcW9JjzR9nBQvEPgnnjqH8FCG/mq0crVSxU/OSfm
 r58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703710365; x=1704315165;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OoIBZjgXFIRnUM0UIofOqTDR2cCNRH9A5fZ9FHXCi0c=;
 b=ozo0epkDq9V6fO3oVc4GbUnZArJjfxyV1hDT6veyPX3zCcprRd/un0dLuwMsS7H0Cm
 DF04mmRCo5/4kzOlAyq7jgKK+sx8KS86v5/vpUi43INMrt8/bfjDNUvJETtpBwj5laiV
 yKoCG2G2B4nAtlx/JUfWklpbyUeVsyaP/5EpSmeqsl5LVs6omAebWQYiezxOhG4z91My
 AIuqY7Qo8ZriSdyLTqu5MZdoidATXKTthU2cpKRzmkxAqc7LSrT1+rtTFTfRQuKWhCO3
 4oUJB8KJcfgSlwHbhS5vv/e3WAhrdCcGD69APvHAX/Op0QDHSAfh5NwjQutYzCnsHu00
 NOmQ==
X-Gm-Message-State: AOJu0YykITSxQWvBgqFH5LqcsFFbM2IANVBRQuN9uHHfQLltdfYkLTVt
 547GOQo0avBhiQ0cEMSxXp2Ex5OB/U6trw==
X-Google-Smtp-Source: AGHT+IEmllWzZN3/D7bX2A05CDq3T4Bzi2elVjKt1FE7X8kFkvK0hMTsk2sHLVmgvXyAmIPhdSng3A==
X-Received: by 2002:a05:6e02:1c45:b0:360:3f3:8662 with SMTP id
 d5-20020a056e021c4500b0036003f38662mr7778937ilg.46.1703710364744; 
 Wed, 27 Dec 2023 12:52:44 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a63de04000000b00588e8421fa8sm12002944pgg.84.2023.12.27.12.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 12:52:44 -0800 (PST)
Message-ID: <48886db4-559e-46f6-b9ef-575c7e4cbf14@linaro.org>
Date: Thu, 28 Dec 2023 07:52:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/alpha: Only build sys_helper.c on system
 emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231207105426.49339-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231207105426.49339-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/7/23 21:54, Philippe Mathieu-Daudé wrote:
> Extract helper_load_pcc() to clk_helper.c so we can
> restrict sys_helper.c to system emulation.
> 
> Philippe Mathieu-Daudé (2):
>    target/alpha: Extract clk_helper.c from sys_helper.c
>    target/alpha: Only build sys_helper.c on system emulation

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

