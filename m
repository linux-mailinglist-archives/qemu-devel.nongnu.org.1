Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD587901C4
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8T8-0004Vb-Ou; Fri, 01 Sep 2023 14:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Sw-0004Nm-Sh
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:01:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Sg-0004ya-TV
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:01:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso16367315ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693591297; x=1694196097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BzgO76fyfpTCsLSnVWTxL++I0YClUEmh2zX7H1ZNg80=;
 b=Shf2Nvl8cUcBjZ/Uofpy2K6w5M8WfYJuus+Rydzv1K5niT5DzMLr8wLFW/HVEeUWUX
 VH2y6QLUg5Tmy+n5LCE04pV3+yI8QC2ENd9Q5IEPijrJzUPt4KsFBPBq4fnPMG38YrkK
 S8v1aNW4SD6kf7wVRejm4yY0wKlwCtAggyTL7ZmyR23DYHdqduULUoe/H/pf5pWcavDa
 fWyhrxO6PmM1iH9xaXC8sThJojavz1OU9JCwkbK6UGG+m6enuU7VnhvAZjo6Sg7SgeC0
 cM6gtKOHyrQh6LAnKRZrD5FLFjQLHH7VetrJniUL1O1pigRBcaWPSCEyFNeMrilaUHPq
 mrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693591297; x=1694196097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BzgO76fyfpTCsLSnVWTxL++I0YClUEmh2zX7H1ZNg80=;
 b=QIxfx+mlMwr8jOD8+LbMypXhPNsFzNDRs4St4ouaYnHw3AeS4wnhIb8KGMGe3kAra8
 uGZfMKfejg7YDU5DS+8r/83u6DiFb4HdW13vM1WnzlZTCWM9s/YuLEmgUrexJ/7f9VRc
 20RNqdsEjNoi2h3KgDF796p5nszaCTY01K76WmYucgcpbYePqTnaNDFnRwkUuoHul1N+
 XUMlUJfVO+t5/kNt+e3HysA1mwgn+sYgQq3l/xebsqGyQ0o+YGDZgZyZmoW6552rlXCb
 /Quj4qc3+JurtpjIUodpBtdfomwG9hd1HhtrQod/HqoXSYxLrfvZlWNS5c9jXweYpSrL
 lGLw==
X-Gm-Message-State: AOJu0YzggH0d/FTIZXyipbAipfXrzMBgyrsgMSSS+0JIiumuGdwTPmVZ
 vi/KRVVBmaRb5r97dtNidim2WY5MwKWnZlfEkQg=
X-Google-Smtp-Source: AGHT+IHd/JyWQ69EkvUpKzdxrKn242SwdwxNYV1QTyZrgtk3M2k00RpdCN6DFV3NZ4ssZ1ErE29QDw==
X-Received: by 2002:a17:902:7e84:b0:1bf:6cbc:6ead with SMTP id
 z4-20020a1709027e8400b001bf6cbc6eadmr3135886pla.22.1693591297408; 
 Fri, 01 Sep 2023 11:01:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001bdcde49bc3sm3268360plk.119.2023.09.01.11.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 11:01:36 -0700 (PDT)
Message-ID: <392e62e9-cec0-2ca5-ac82-4aaa75d5c5b3@linaro.org>
Date: Fri, 1 Sep 2023 11:01:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/14] tcg/loongarch64: Lower vector shift integer ops
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-13-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-13-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/1/23 02:31, Jiajie Chen wrote:
> Lower the following ops:
> 
> - shli_vec
> - shrv_vec
> - sarv_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 21 +++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   2 files changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

