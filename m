Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D917A2484
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:19:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCSl-0008Sj-EI; Fri, 15 Sep 2023 13:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhCSk-0008SP-8M
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:18:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhCSi-0003SU-Ra
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:18:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c39a4f14bcso21831055ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694798315; x=1695403115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aLHAKYos0z6jWorzwGa/hbYJq/9F4x2XB6oO1RrsPW8=;
 b=QCCvA1uVQ1TXqzyPjD7Y5oVx3+Ps8r6VGD0BOhobIEZy/yjhnLi6AhxwkpFHbTBXzV
 xQTLnCt3OtmBPuAR4OxUYCbhj1vw42c0lCFkagQuhO/S0h5jsiGSrvkX0rQ196u3/rF6
 Y6xdn6FxMMS3TnB7MWKcxR93yHHoDlsbL5u2oYxF+KuLCrBhZ9bXSM8Iv9U1N6rJfV2j
 2nhvptyuPRMm3VMnW11BzBH6/5NtlxzjBRdJdSMkF3DDsGG0cDGCcQ1FqxHXCpZAch6y
 R478RpJnkhUCpwGznk1wABI2U/Z1IHku8SESU9KBj1a63331crLDBc4R+cnIG5TroPEd
 lkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694798315; x=1695403115;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aLHAKYos0z6jWorzwGa/hbYJq/9F4x2XB6oO1RrsPW8=;
 b=XrEqpz0LgLSGAlGVIXiWughj9zRNrTW3q5r9gI/XH+Yr/5xH8sfflIBkBYxFwTkzUh
 6+kzEzjzULkgUqfyAPTJi/u0cLud3piy4ryuAjC8Gijhp0Brwta8oQBGMTP/PQ6e4yAK
 u9L+I5yazyQ+rjCe5Xe4ylOcQrznYGsxcciEMm6hBqTclj6+aIFXaYt+p46AcR2kT7ao
 1xpbRgMln4NhcQ5QGmBg5MNat4aI9nld5oIT9vbMPI92yfl/wU0hOsSvK7LIG0iPp2sF
 curuARJg75VyI2+U/zCTosa3C7tUS3BfFHFKa8Vl/Rv4CwO7/spfgfmo6ea8e7yReQf6
 20bA==
X-Gm-Message-State: AOJu0YzKrlzjorz8BBiZZS8HEvFtitJ74GqpOPBK+MyyJmNGAVnxStOr
 DkZoREinhXaem+V+98aBH1A1zsn80oARV4ILI/0=
X-Google-Smtp-Source: AGHT+IGDWoDlw01/iYldLPKh3kdZXJdLthNweWpcSjE0YiR+zwFuJUSj9Oz244d7TeZ2bXNn+sEnwA==
X-Received: by 2002:a17:902:7202:b0:1c0:7e86:4f6 with SMTP id
 ba2-20020a170902720200b001c07e8604f6mr2247897plb.14.1694798314934; 
 Fri, 15 Sep 2023 10:18:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902c18500b001b8062c1db3sm3767974pld.82.2023.09.15.10.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 10:18:34 -0700 (PDT)
Message-ID: <80be26fc-b37a-fd09-4f2f-de1fa8d5aef5@linaro.org>
Date: Fri, 15 Sep 2023 10:18:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] accel/tcg: Alternate fix for #1866
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230915163254.123338-1-richard.henderson@linaro.org>
 <bc786411-2802-4e77-54de-a406f2b0c909@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bc786411-2802-4e77-54de-a406f2b0c909@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 9/15/23 09:55, Philippe Mathieu-Daudé wrote:
> On 15/9/23 18:32, Richard Henderson wrote:
>> Supercedes: 20230914174436.1597356-1-richard.henderson@linaro.org
>> ("[PATCH 0/6] accel/tcg: Always require can_do_io (#1866)")
> 
> Patches 1-4 (5?) are cleanups although, isn't it?

Yes, 1-4 are good cleanups, and 5 is probably a bug fix
(though I don't see the hang without patch 6), despite
the fact that the hang is *with* icount (replay tests).


r~

