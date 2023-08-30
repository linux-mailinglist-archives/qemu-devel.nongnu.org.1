Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AFB78E25F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTlS-0001sX-22; Wed, 30 Aug 2023 18:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTlP-0001qA-DY
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:34:15 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTlN-00078B-6P
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:34:15 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-271d9823cacso167204a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693434851; x=1694039651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPQTO26EIwPHNsZ5WMfei3zyNWeWPdRfGfwoKNsxUkg=;
 b=m1KEVVTv3utRFEhVcjDlKiAyrpg5VIyFiJ7+2bx88XxXaRD5M6+DxV+RqI1ooDtPXP
 pH/MFagRE6prqcXbdPYobnCWrI1G3XRiboz8DkXJeb1RMk1QMRz/822VlFxjYqpCWeYY
 v+w3da/ymliBP2XsXtWdMrMfLpVkyCezv99tcEI9lajpZ3sjQBSBhBgfsLkB/bodIJB9
 SXn9Fv0DKthV4V22nlEd+XEKZWC2kSDzozh1ds/GV1kvXtZlqD9fcp4Da46gx/kxmTIo
 /UNzfxkeL95x1ejcAt2n2pl5H6SygEqtkKDDQ21utKyMwU9FohXucAOFU2/vG/YcKxwA
 Uz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693434851; x=1694039651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPQTO26EIwPHNsZ5WMfei3zyNWeWPdRfGfwoKNsxUkg=;
 b=HfMlAVj1EnU2VKrTjPLMgCP5lDSEc3dhOffWp0uVLkS5t6NPeH9zs4DcnFjlNeSdI9
 WyYQvG0eK6JxGYeHh/yHMMy0RGpqE+ilDPzIqdl4zEinEW2fmkXoa24BchkFh/hSlEhb
 VKZifMw6AwtFwfytRx0fAU3fLtYKPGuRxDSPOATjOQs1FSl2bXmwPIlD9mkKSP/v4k+N
 6NbbEaXbPSLFqkRomkBt2tBHVstbpNhpMCb4jBwIXNH/FB94kdZgFpYvKAmiBZdoYyEz
 E1fYTzZaSAmlthqJi9zK+gtbqaugiySh/uJDqQz7slGW0m2cIKG5RF1zusJr1m51uSEt
 Lhag==
X-Gm-Message-State: AOJu0Yw9DAdgzBJspcGGURRBFkVD9t4lUCEN8mAtVf0+nRQfYYcv9Cj9
 f9c7w443/TjFPMaI0tjxvqPptQo1RyXbAG4GpUw=
X-Google-Smtp-Source: AGHT+IH6MNcp2KjzvVJTEOAdmIIQmM4hXAjcdvPIRoo5MMLUeqSdzIEENZNKoXu3Y6R0ABsvhUKEnA==
X-Received: by 2002:a17:90a:6945:b0:269:1d16:25fa with SMTP id
 j5-20020a17090a694500b002691d1625famr3507792pjm.12.1693434851636; 
 Wed, 30 Aug 2023 15:34:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a035600b00262e485156esm1836818pjf.57.2023.08.30.15.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:34:10 -0700 (PDT)
Message-ID: <a13ec602-fc2d-ba28-8ccc-5bc952c51598@linaro.org>
Date: Wed, 30 Aug 2023 15:34:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 21/48] target/loongarch: Implement xvexth
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-22-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-22-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVEXTH.{H.B/W.H/D.W/Q.D};
> - XVEXTH.{HU.BU/WU.HU/DU.WU/QU.DU}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  9 +++++
>   target/loongarch/disas.c                     |  9 +++++
>   target/loongarch/vec_helper.c                | 36 +++++++++++++-------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  9 +++++
>   4 files changed, 51 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

