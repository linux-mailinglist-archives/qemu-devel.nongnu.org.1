Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A337B6B0D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qng3T-0000cq-BR; Tue, 03 Oct 2023 10:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qng3Q-0000Y9-RA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:07:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qng3P-0002Z7-83
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:07:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c723f1c80fso7098215ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696342034; x=1696946834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uuJ82CeChh1vfmOjR/RWawHu89cipvIisWCgKfZJARM=;
 b=laM0Edk58Pbz3JuPHVplBQb9SQSSMxfKD4v2d89J+WGE80S52LosQj7wM2PD0JBT3g
 1Y1kHPhdM8OJbJfJkDrxJIysL4zXvWzm66aPS3S5+uKZjv43zgIXJ/jHq29vgE0F5Dev
 javFbEcJsRcWuYpjmftLMXG1wY0o7POxo+FDO4VeTbZoxy9DE5+mQDL7ANNIWTzUaVnd
 SBpBLjeI+/6+V3zpC8T2YVZYmCUM2W0Tw1Uqewesop3xbU0YwUdq/cNE3EH4cXKe6Mix
 XXJcO3zK4fTDYam5T+miEIacZoYBW2HiXN14K6Na81Wk7G+6St3DW37Q2FiCRQ0W4NSx
 x1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696342034; x=1696946834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuJ82CeChh1vfmOjR/RWawHu89cipvIisWCgKfZJARM=;
 b=r38VdHU7XvbPljZp9D8RAEBBpqfoisRBpjX1zazROHpPc3kMha/8kOdBZX+zynDMVH
 c1lo211eGQD3Bd4LlETMlaKwoxEuDHymnA+ZRntqk8XXOicopsTZP5Zuw7+MP82OhO8j
 vL1bgQxCw5RxteNZ+bIjOReS/ixtf4PvocP7jlxE7BOal4fkPR+T/NKM8upY9myuYNXi
 +C4IfZzwlxPMXDpn4FyI++QW6idvEIk1CQNiEPa/5MxRA5REDlHPim/fl8d0GXMiQPLb
 vuGK0W1+F4KUKnYjUHPWhYNQE10FnGJBei7OGcyX+mpmskU0C2jUPbeZerphFEZC8qWD
 lncQ==
X-Gm-Message-State: AOJu0Yx5DtyagAzKRdnbG+ZmfktEZcMg4dYjoe8Id2WZvxTQicH0VjtR
 mcsKrDMdJYubqMnyW1rYHbRVVQ==
X-Google-Smtp-Source: AGHT+IFqwdBlWDjek+31JWElIAeFC0cab8LSy0b+aMxA1IbMBgOLzB+NwLQpvzxDS9Dq4cDvtNKHag==
X-Received: by 2002:a17:902:a983:b0:1c4:51f3:a184 with SMTP id
 bh3-20020a170902a98300b001c451f3a184mr12099792plb.10.1696342033724; 
 Tue, 03 Oct 2023 07:07:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a170902b78300b001c74718f2f3sm1584889pls.119.2023.10.03.07.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 07:07:13 -0700 (PDT)
Message-ID: <a4fd2a56-0a0b-e10f-c6e3-46328376831e@linaro.org>
Date: Tue, 3 Oct 2023 07:07:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/avocado: Re-enable MIPS Malta tests (GitLab issue
 #1884 fixed)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231003063808.66564-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231003063808.66564-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/2/23 23:38, Philippe Mathieu-Daudé wrote:
> Commit 18a536f1f8 ("accel/tcg: Always require can_do_io") fixed
> the GitLab issue #1884: we can now re-enable those tests.
> 
> This reverts commit f959c3d87ccfa585b105de6964a6261e368cc1da.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/avocado/boot_linux_console.py | 7 -------
>   tests/avocado/machine_mips_malta.py | 6 ------
>   tests/avocado/replay_kernel.py      | 7 -------
>   tests/avocado/tuxrun_baselines.py   | 4 ----
>   4 files changed, 24 deletions(-)

Thanks, I meant to do this myself with that PR, then forgot.
Queued for tcg-next.


r~

