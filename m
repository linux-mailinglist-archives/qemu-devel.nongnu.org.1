Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4212C77100B
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 16:02:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSHqe-0002O4-BZ; Sat, 05 Aug 2023 10:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSHqX-0002H2-Jy
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 10:01:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSHqV-0003HF-WC
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 10:01:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bbf3da0ea9so19872475ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691244090; x=1691848890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/2yj41BRqAnC8myOPazTURbzt6Fg7jxzSFmb1Dn4vEU=;
 b=E3kSz3vpTqdnmB9ZvKaZn+BbZAvH2x9fpPG4N2jKB92sJ/mmBVXVk9EPU46gPVFoFx
 Hs/bbW9ECkdrU6RU+EH1cIVSUJV+uyRoRdEfb9O/INNby7sz+gguxCOxS7WR6U8un2bO
 MCjDiQnO96dw2ThQni5DOmTqGGr9FAn0liOQvw6oUcrulFgqOraNP29b5hUQs8zHhgkj
 tIDVWzf4kJevT7Dl3VIp6GbcJQGResKy9gAZrG5QW2546B8mDrtzFCnx+xy2Lafa805e
 GRtnaSNaFZhpL1aihXG6UNUbF6ZhrXb6z4xy3/ZMtaLmiLjikkiVeVTzpCX97yHx04JT
 Gfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691244090; x=1691848890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/2yj41BRqAnC8myOPazTURbzt6Fg7jxzSFmb1Dn4vEU=;
 b=STaZzIPUhT/2Qc9u+k79pHZ4Tnfurt0BGmJpqGoMoXaFFf+nj62rTWq/wOtREtLcAW
 6yb2rsSSY6abWQC9774Ioy+infl29482WmgGY0zxpu8ZVLIOMyaFSZDv/ag15BUpqSit
 NoqQXgMzDa+ADgmjDw55McqD/iIJFy4jD/cyZDlhKBrVn9qObqobDm0fekqOF0gjAsmh
 1P3ogLJltfKBunb+kOg+818p1uLljHrObQJF/b6FlWU0K4RazooE3C0sjEadNRrmJZ+H
 RqLAUfzqaunm+w7T/tOa67wNQEtq9HjSGfeqlbMhXj14wgXktAfvLaNSXR13YQOk2ACg
 Hvsg==
X-Gm-Message-State: AOJu0Yzrsh0UwZ8u68RAfUjKyXxRdoz72KKYW2vU9rjxS9YQY+FZnvGh
 QGUbvJ3keDQFoZH3PfyFUjMPSQ==
X-Google-Smtp-Source: AGHT+IGLWIzON2nDOxNjq2ZXiNjEifyQzMf2mbryN8oQwBhV3dKH7zrXQh/c1q32VSI6eJxsMy0O7Q==
X-Received: by 2002:a17:902:a412:b0:1b6:9551:e297 with SMTP id
 p18-20020a170902a41200b001b69551e297mr3368365plq.44.1691244090052; 
 Sat, 05 Aug 2023 07:01:30 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9454:a46f:1c22:a7c6?
 ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a170902744800b001b8b1f6619asm3557785plt.75.2023.08.05.07.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 07:01:29 -0700 (PDT)
Message-ID: <b60a5670-17c8-f25d-fd56-e0970fe4017f@linaro.org>
Date: Sat, 5 Aug 2023 07:01:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 for-8.1 00/24] linux-user + tcg patch queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
 <7390dbf4-169f-5d79-da94-ebc0986f1580@tls.msk.ru>
 <5e1aef4b-65a0-e97e-17cc-d2ccd6a66dcc@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5e1aef4b-65a0-e97e-17cc-d2ccd6a66dcc@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 8/5/23 06:51, Michael Tokarev wrote:
> 05.08.2023 16:28, Michael Tokarev wrote:
> ...
>> qemu-8.1 rc, with or without this patch set, does not work in
>> old aarch64 environment at all. F.e. ubuntu xenial or debian
>> jessie, like this:
>>
>> # chroot /tmp/jessie-arm64/
>> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>> Segmentation fault
>>
>> dash works, but bash or ls gives such sigsegv
> ...
>> Is it worth to bisect?
> 
> Since it was kinda trivial to bisect, I just did. And here's the
> result:
> 
> commit 59b6b42cd3446862567637f3a7ab31d69c9bef51
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Tue Jun 6 10:19:39 2023 +0100
> 
>      target/arm: Enable FEAT_LSE2 for -cpu max
> 
> Reverting this patch on top of current master makes old linuxes
> to work again.

What is your host?  That's probably the only relevant thing.


r~


