Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EEE7218BA
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 18:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5r3i-0005xU-0o; Sun, 04 Jun 2023 12:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5r3d-0005wy-EK
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:58:21 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5r3b-0006sJ-TC
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:58:21 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-39810ce3e13so3535007b6e.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685897898; x=1688489898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rrjS2Y1sK0Pc65lNFe2D8urFAhV3VwVM3DH1L5gFJL8=;
 b=bE+oPkU7Z6sZt8Or4UPvqL3QKXzpmMtCbSQ0HDU27F2vg66xxXWP8y8OoCEwUlySVU
 IAIKhqnRoWofnWHPgaZ2vUdFsJ7NAvJtgbF2g36YAyQSBB/FQCB0KYPHaE9cKAv0o1OZ
 HNF672frvTzGRVji8IOoYrTSzdXoOpE4HnDZyDQakkS4SCsOuJ7lwJrmtxjWivthh4Dg
 DUvpNZroiywF/mBt8kvhYpbAg8mKyg0YwDyStZ2ienq1JMehXyt27yy7deomZmE1FMKa
 wcmBC3dAlCStE30yvJzZiwXeN/1IZS3aKKH+YHf44H3HI2MP/S+j3Z+JYdJoUOVL+Ejt
 uBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685897898; x=1688489898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rrjS2Y1sK0Pc65lNFe2D8urFAhV3VwVM3DH1L5gFJL8=;
 b=SHtQV5ZV7+ZNbfyHeDmpVFemDBfPZAOQa7+GVrgXhpsOu3TMJUZYWMLvHFDSk6fMBy
 ygqzcTLz0gqstNm4uBTkq9P+0M7uKGDh0XQK5oW0D29OL88R8ycnEAegn9sbpEfgqFNp
 TjuKniRNe0VBzsUt7JUeJpSkpLVQ9P7ilnCBAcQF1puP/xdK8wtACFnPZr6JVkR/ewAp
 P6TSh0rbhqLxjeo+XUOObNA2NxethNVgHI0qjtluckkDj9QeyXBzckcLZlkZG3iIpIvV
 LgCFGuYeNNu6k7Qo1R54mAAzgjomNxlYfIBujXtLDt3Ptd+zDp57Ynp25/jsD3fWg01q
 cCvQ==
X-Gm-Message-State: AC+VfDwTplefO3pm4AUBG8HID4DJbLe4fYXC8wb726X9bmPG3ll4rIy+
 Hvr9IhiEFUAQZeIpwudgUsr2PA==
X-Google-Smtp-Source: ACHHUZ40kCgq9oV7R19AFdFPah9HsM2wP3/6S4YYo5U9KriQwnReX1tZLahhGOxiqVyQYYUKi3rHTw==
X-Received: by 2002:a05:6808:b3c:b0:39a:acfe:4659 with SMTP id
 t28-20020a0568080b3c00b0039aacfe4659mr1399842oij.17.1685897898180; 
 Sun, 04 Jun 2023 09:58:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7d0c:4d62:710d:ff28?
 ([2602:ae:1598:4c01:7d0c:4d62:710d:ff28])
 by smtp.gmail.com with ESMTPSA id
 jk19-20020a170903331300b001b0aec3ed59sm4867465plb.256.2023.06.04.09.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 09:58:17 -0700 (PDT)
Message-ID: <8f706ba2-7993-bf96-9be2-a37ecb4ca8d7@linaro.org>
Date: Sun, 4 Jun 2023 09:58:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-2-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230604102858.148584-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

> @@ -3584,6 +3588,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
>       gen_set_access_type(ctx, ACCESS_RES);
>       gen_addr_reg_index(ctx, t0);
>       tcg_gen_mov_tl(cpu_reserve, t0);
> +    tcg_gen_movi_tl(cpu_reserve_size, memop_size(memop));

Not that it really matters, this produces a byte value...

> @@ -3873,6 +3879,7 @@ static void gen_lqarx(DisasContext *ctx)
>       EA = tcg_temp_new();
>       gen_addr_reg_index(ctx, EA);
>       tcg_gen_mov_tl(cpu_reserve, EA);
> +    tcg_gen_movi_tl(cpu_reserve_size, 128);

... so perhaps ideally this would be 16.

Perhaps name it reserve_length to exactly match the manual.
Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

