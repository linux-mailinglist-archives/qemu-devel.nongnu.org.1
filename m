Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CED79F4FE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:31:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgYMx-0000mu-N9; Wed, 13 Sep 2023 18:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgYMv-0000mH-G5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:29:57 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgYMu-0002Er-0n
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:29:57 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bf298ef1f5so190067a34.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694644193; x=1695248993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UNiQCcYAvGYiUraFs3oTVIVfioDO0n0A3ZUNU4TWH0Y=;
 b=qdJaH3D7zbve3Rkef8QlmCr2iN5YWAjw2wDiqfqcPrnFHduPCveFe5mDv6GlQVj9jo
 HpTLuFm6MRX1hGLxZjk6AVhhv4YihnuLcl4bhXscQCOO/ykSKEGVFgSvb0mOq+jyOqYn
 F6ddguNT5i+VHYGGNCY/Yk7EG4uFn4lGLU82Q8A63MrPPgliAM3cqJ84MVMSaMo9JJ0v
 Kztg95RpwHRMzdRH+HRykIJCylS47YhE2OhNZ5OAiHjcLjCq+y5/LlT9G145BQpnHcjv
 itiqJV/IIcldDqkv7Dg8BjHs8xAA8rcIb15nXdONad/6znLJTrwdbMdd9YN97NXbcW51
 jAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694644193; x=1695248993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UNiQCcYAvGYiUraFs3oTVIVfioDO0n0A3ZUNU4TWH0Y=;
 b=S0ZTCdD01KIf/np4ON4Qx89LxzJIXW0obZDGLu/E2llaotVt8cjwluFCu/xqYoiUxM
 q4YC3+k5zxe/82n9iGv+2s9v3eMDruFY4c3m/W3LgW+ZjVFGL0Uh8BnPtkXZhHqH6NS2
 GwFOS4oh9VikaXyIP7mIWQonpOxWu4tFQjPUrJghj1oc8RSIbp9F8QQmXtDo8AmYEXmS
 m3GopvhbkHoLzQM14xfzr7tzVnXaV70ia5Cw+cpoTyUuhls76let92uw3LlDv20yijLW
 bJy+ow8AypSM+G6ogWyuOY0JnGDyDHipVdXOcrMMb5nDWryOyup9W4dUugy2/JvolYCW
 +RgQ==
X-Gm-Message-State: AOJu0YzqS/LLtSw89orrhDYiPuMUOSYif8v7uiFb69bE5Ni+iH91pIcV
 O6EOY4zBv64l8gJtf/7DPxWzdg==
X-Google-Smtp-Source: AGHT+IE0FXGFmj0lPO/Bsq3YaGOKU8qAUpxbjJCvp8YfXJUvrkJxTfd+H7pbrFxgJDHUIbPQd6WQ0w==
X-Received: by 2002:a05:6830:1e89:b0:6b8:82ed:ea2e with SMTP id
 n9-20020a0568301e8900b006b882edea2emr4332013otr.4.1694644193515; 
 Wed, 13 Sep 2023 15:29:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 w16-20020aa78590000000b0068fece22469sm68391pfn.4.2023.09.13.15.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 15:29:52 -0700 (PDT)
Message-ID: <a4773f18-f5c5-166a-ae06-5b14c1010964@linaro.org>
Date: Wed, 13 Sep 2023 15:29:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/3] target/ppc: Change CR registers from i32 to tl
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
References: <20230913005814.413113-1-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230913005814.413113-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/12/23 17:58, Nicholas Piggin wrote:
> This is a bit of churn so I might leave it for later in the cycle (or
> defer if we get a lot of other changes) since it's a relatively
> mechanical change. So don't spend time reviewing details, I'm just
> wondering about concept and general approach.
> 
> I'm not sure the history of why these are 32-bit, maybe better code gen
> on 32-bit host emulating 64-bit? If so, that shouldn't be so important
> now that most people use 64-bit systems to develop and test with.

It was probably in order to save space, but I have no specific knowledge.

What does this do to the generated code?  I suspect, without looking, that it doesn't 
change things much at all on e.g. a ppc64 host, and for an x86_64 host merely changes the 
types of some instructions (which, considering the rex64 encoding, might consume a few 
more bytes).


r~

