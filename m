Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5578D088
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mm-0000dx-Ih; Tue, 29 Aug 2023 19:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb73q-0001n0-4F
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:19:46 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb73n-00078n-QX
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:19:45 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a88ef953adso3452479b6e.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693347582; x=1693952382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JeutPF4K+N6+V+4LZAW+kM/OmTz4ZYd7DoiMDPd+/rE=;
 b=RGSVB7PuhOizQ/cAX/7uaTbM21wm3ujq0qtuCGRfGu336Gldsg0ImiXCLrh7Uir2GV
 y2elLU7Wrw49APK7GZIF2qGq3PSGzerCPZjz6whQU0uAUyDeeMR1slapFqErV7APRCL2
 pVN4fOBP4yJ1sHeMXO99N8oGZ+Oa939DZh6COvaurMcya2RZDTxeCDJQSUF4BuCsL1av
 08sLs72n9xunhEw1BhQce9XlR/sKVX8Njy5xg6vi18G5gVYJqNhBqVFlyMZ2OfytDDij
 G9OksxC6iRjpHpIhl+m8sI+bGuNjhgDMMcDosOQfuTPA20zfpLqqOKjrMB4S9VVr7TSS
 /6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693347582; x=1693952382;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JeutPF4K+N6+V+4LZAW+kM/OmTz4ZYd7DoiMDPd+/rE=;
 b=eX9i0q70t7U5nM8TBNt3kBukkJ6C+6uADLz0FA1UpnZ0tIIPNzgs9MAZCI+U2tc58k
 078RXzxgca7uWXAror/md8aut2D0xtFWNEPfaWuvu6RbOV1aKNlvGPf+JZypvCQvd6hh
 PZaBoWtpYL3XvIM00POJP7K+q7Ew52R8t81QhTDPmIOMDiovtf9kQ237uWWn8qmbrAjB
 iqLjtmAHr3l6/G8mdu+Y/5b+d6WTuYXIwMaKU6zEtRPHpwBpnlX/YeIO3smAd1JY8vnp
 yNs8vx+xSqStUpZk38XF1+8BPScLtfStX487H6uxbm7ysFe/hhb1ClALwAHF9ZKVyp1n
 OIaQ==
X-Gm-Message-State: AOJu0YzLqa6M19OPM+5sCUXVUPzN3tupSiwNRUSKgTHFUsgad6y76eC7
 7H2kItC2qsxPyIqXn2owKtjlCQ==
X-Google-Smtp-Source: AGHT+IEYldL2UgQnMTVW/BzA7MH2xAFafj0GKVO0Qnjf7sTcXoIXb0dky4xLBHtNGG1tJbXCkP4e2w==
X-Received: by 2002:a05:6358:528d:b0:130:e0a9:a7b4 with SMTP id
 g13-20020a056358528d00b00130e0a9a7b4mr291972rwa.13.1693347582539; 
 Tue, 29 Aug 2023 15:19:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a636407000000b0056c5454105csm9449643pgb.93.2023.08.29.15.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 15:19:41 -0700 (PDT)
Message-ID: <934aaa45-c6b3-3ed8-b1db-5b56c3142291@linaro.org>
Date: Tue, 29 Aug 2023 15:19:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/12] tests/tcg: remove quoting for info output
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
 <20230829161528.2707696-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829161528.2707696-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 09:15, Alex Bennée wrote:
> This avoids ugly multi-line wrapping for the test on non V=1 builds.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/tcg/aarch64/Makefile.target                  | 2 +-
>   tests/tcg/multiarch/system/Makefile.softmmu-target | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

