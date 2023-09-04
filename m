Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725D79179F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd958-0007aB-Ph; Mon, 04 Sep 2023 08:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd94i-0007Jk-W0
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:53:10 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd94Z-00085p-B8
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:53:01 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a2a4a5472dso494246666b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831973; x=1694436773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mLLrOInlqhD57AKDsb6eUt0pbNKyEYyMysQZ94xnQK8=;
 b=Nh11GYnH27/eV1W8sMVstjJSIK1chYcFEqkoNehYGhSL8tV3pTREC0UGRIkObLuDXJ
 TYnP2r2u85pcJyGs4K/ig7d4zxuqzd/iLrhxcRw+Dc6rLBLJ7XZYkgv+MDJb9BroB9rj
 weFcEFu86J91byGFULIrvYiEicaoT8QNWP3yZowNkaL1Rrt96cXp55TB356mJFk5pL6m
 T03lBaE53nD5gcCXAFGJ8t9hthnUkf5vLbQkEFd94bu22+E1hD9mMTwcLg0zrNwifWiw
 dlgFXUIOgT2+NAZrkxRVMb7RxaHNMT0IHS/RyAG+umTpbnMZ5S3PYXgHGiCuDHHYo2nb
 aXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831973; x=1694436773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mLLrOInlqhD57AKDsb6eUt0pbNKyEYyMysQZ94xnQK8=;
 b=CE369zF0nuEt68/MkdofXFgkL0PgbOQuGaXo+FFt+t5WdKSe4rwCQ94e+yTiukWiKz
 CC6UVJAgKjqgwlwBVVKjABgIGgcFwc2LIw2hCnKfdVSsBjBaL+H9Fmr7G6wp9K5iJsXP
 bp3fcC2EDrTXBVH1aAxM4y5XctY1anUYofpygiHb3xRvnY0Olqnz5DlVpa6Lp9w1E8O9
 NrmvNMM7Ppj2okXDJlzXZGJHY+xWWy2SvsCj2d0LgmmfDoGqvfhEUEDPyC9dYiK45El8
 Ey2eUshvQrBo8BtnP29zkh3ZSNgFjjvFnbs0K5Nh+tUUHUWs0ntLWExaS5/UEV+e5n1Y
 uLWA==
X-Gm-Message-State: AOJu0YxBYIGURN9TwXf4d4t/lzRwoBHFPvc0wYjCrc16Y/W2yUGuyA6x
 YEF4/zhtUkslAZHwuXGdGCMJKw==
X-Google-Smtp-Source: AGHT+IE2dh17lIZp6pWvNurXWtAA+k1x62E7/ZXi3gGxjt6GLWY+HjsezLL0bXystJdB3rIkUGSVEQ==
X-Received: by 2002:a17:906:30d2:b0:992:2f67:cd34 with SMTP id
 b18-20020a17090630d200b009922f67cd34mr9888804ejb.22.1693831973385; 
 Mon, 04 Sep 2023 05:52:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 a22-20020a17090640d600b0099d0c0bb92bsm6129118ejk.80.2023.09.04.05.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 05:52:52 -0700 (PDT)
Message-ID: <f9e162d3-1a7b-a037-0a61-68c044914098@linaro.org>
Date: Mon, 4 Sep 2023 14:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 01/11] tcg: Clean up local variable shadowing
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230831225607.30829-1-philmd@linaro.org>
 <20230831225607.30829-2-philmd@linaro.org>
 <91f8724b-1f1d-6121-afc8-cc6446bf9359@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <91f8724b-1f1d-6121-afc8-cc6446bf9359@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 1/9/23 02:38, Richard Henderson wrote:
> On 8/31/23 15:55, Philippe Mathieu-Daudé wrote:
>> -                    MemOp op = get_memop(oi);
>> +                    MemOp o = get_memop(oi);
> 
> mop would be a more descriptive replacement.

I went with that first, but then noticed 'MemOpIdx oi' and
renamed as 'o'. Anyway I'll change to 'mop', thanks!

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


