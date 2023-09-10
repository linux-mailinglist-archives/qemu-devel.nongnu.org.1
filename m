Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 197D8799C32
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 02:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf8cU-0007B8-L4; Sat, 09 Sep 2023 20:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8cO-0007Av-Hy
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 20:48:04 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8cL-0003ub-S3
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 20:48:03 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bdcbde9676so2384349a34.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 17:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694306880; x=1694911680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=72k7K+Y/wKpcwO3WtFPpbvDl7hl8o2uJUSx9Tjwczss=;
 b=g5eJWB3E3N2BqVZat5T1wNZqGJfXVyJK/MlC4jTWH5c2iJwLNk5syI8DKmIUp16Aur
 JeBRW6Kr74Uo4FjbilP92tgWN2y8h3ja5jB7u+GD6tjfwf3GxVc/eRgD4a2z08L5rjzJ
 1B0g2m+hAx4DTbxfzb4MBNP/6u+hQJQHt5XHVXT/JOAu+57iHe5ThdQlm8c1YNtp/srj
 1vdRZFPen2BOhTaMUxmZ9tSYSzt8G+oLz+4cRRDhCaH044G5exxlR6klFk8DGKCflDYf
 POLRBMYY0kd66SaIkfA3rq+lni4ZT0k5F2hR5Q9IPhWO+FNKzKPus/C01K96trQ//ZJn
 1dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694306880; x=1694911680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=72k7K+Y/wKpcwO3WtFPpbvDl7hl8o2uJUSx9Tjwczss=;
 b=KX02jz66zRSTi0k/jtaDXoejFYgFWafruOYV1Onliqqg5PKShYx55oDolqCaVd4eS1
 U9qZKxj3CGlZkgZ5iRfDyBkZxp9Exs+8ihbb3JNd2NFLeKJew0Psib29q1ncjKAJ2aJ8
 oeoI4ra+ukwYtrDzOHGNBiirbahSac/nNIF4TJSBjYR5y7w1F5NYxwlnsQMbLAR1G6ml
 1KCIJDZQek4PnrF18FBX0Y7bDMTVT3ClPwWcxlJPxh6eYzN69P3RQ7ru6GZu+y98yRes
 LOMjpNdwGYobuw7YDPc1dEK1KW19M8cRxCztXcGZ/Yylfiqp1WpP6e3vHiSgIJdNn1iS
 6ZZQ==
X-Gm-Message-State: AOJu0YzDCEpMmkD3i1xv6348XNI+d/llbTavXA5OMdBrUzQBrIExI0EE
 KqofTJoGb+/kXpeWWTprKxu/zoQIc8xVFEyYNQA=
X-Google-Smtp-Source: AGHT+IHk7cHxUecY0y7jnBqjUlBYUvwaJq04sXtmOfI/mnBjA+EJ+67jwBPSP3fqU+0dB70Y+P0URA==
X-Received: by 2002:a05:6358:1101:b0:133:291:f9ac with SMTP id
 f1-20020a056358110100b001330291f9acmr5030981rwi.25.1694306880021; 
 Sat, 09 Sep 2023 17:48:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d50500b001b8b1f6619asm988188plg.75.2023.09.09.17.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 17:47:59 -0700 (PDT)
Message-ID: <79e4b9bc-2fdf-364c-8048-5b39de51b4dc@linaro.org>
Date: Sat, 9 Sep 2023 17:47:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 04/57] target/loongarch: Use gen_helper_gvec_4
 for 4OP vector instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
>   target/loongarch/helper.h                   |  2 +-
>   target/loongarch/vec_helper.c               | 11 +++++------
>   target/loongarch/insn_trans/trans_vec.c.inc | 22 ++++++++++++---------
>   3 files changed, 19 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

