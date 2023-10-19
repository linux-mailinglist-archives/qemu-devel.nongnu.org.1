Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9577CFE8F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:46:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVDZ-0002pX-G3; Thu, 19 Oct 2023 11:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVCu-0002aM-GE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:45:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVCs-0004Da-No
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:45:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ca816f868fso34140975ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697730304; x=1698335104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2tyu+uobvgc+v7UEIcS0cjzdqxdnr89I+W4/teIo3Hw=;
 b=AaM0mt9Zr6+DgsMhJyNH2PQRscD1bJoJ7xTu1pxammYp8qoO3Fj4A2Y6+gu/zxuWBr
 cC/v14jRlbG9jKn+970rJlPy6JLxv2MpaE0RhMveufsbNzddo3NOwm1sOs6pGnXaohOL
 qTl8d3CwzfFxKFYXiLxoi/wAAatnu8zm3uQqlsss9RKnGlI4V06OKWyTEAJW+MoF7Wid
 Vopizoxzom32HHuiCn23+K4WBFRWzzijBhfrtRGVVk2YgOSwBxZomZvVZgpydZy72CuA
 HqfK6bUYZtUD6lctj7ivIu5/WU+RLM1sz3mnl5BErFkEuXMBjyXejQQ7YFq9ZpLJI+Wl
 +ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697730304; x=1698335104;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2tyu+uobvgc+v7UEIcS0cjzdqxdnr89I+W4/teIo3Hw=;
 b=XSPAjL2a9QAYx/5YJkY3m1ovCpXmVkKfSrFgSs6RK5gPmerieW4nP5Y+Q08HSNL2yI
 rKKRs2EGrQTJ81t9gG8Gr4z7rr+PzgPpK2cqExAj17O+bAUYIp0HmgDT2AyEmD5pbqrh
 658vdx/tn/1DE5VuUQqO3tpP0Qu2sforrMrCAGBEuQqfvD+fDXfDlgrNGPD+8055fX0c
 7+2o2Z+w//cXKz+4YKBdzgbUVodK2iHQHeslxbTiVPoG7vsSCLvlpGWkkhh6KK+VJxm0
 pOQenawo+QzZiwaTR5BgOSvMvvaHCovD59JciziPlXYqlzNZZ3EmQt6gzy1LUYTgjPSU
 cEEg==
X-Gm-Message-State: AOJu0YxyJO6Gjf5QAjaUEq3smPzbfrtXMH8vU/OUaIJfLPDLnkZlLvQU
 smINYF3NbC2C63na3Xnvwr+oP0HBUFhlK16u+II=
X-Google-Smtp-Source: AGHT+IFOjyyMNeHOtidOJ5G54fGTbl68Ad/jJPAlvOTMm+WMnlC7mJb4D8T+JO03ViEtNhpvBRnVcQ==
X-Received: by 2002:a17:903:11c9:b0:1c9:bca1:d70b with SMTP id
 q9-20020a17090311c900b001c9bca1d70bmr3036172plh.39.1697730303957; 
 Thu, 19 Oct 2023 08:45:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001c62b9a51c0sm2094758plx.103.2023.10.19.08.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 08:45:03 -0700 (PDT)
Message-ID: <01b9162f-37d5-4bd8-b58d-f7f2ec735b88@linaro.org>
Date: Thu, 19 Oct 2023 08:45:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] target/i386: group common checks in the decoding
 phase
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231019104648.389942-1-pbonzini@redhat.com>
 <20231019104648.389942-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231019104648.389942-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/19/23 03:46, Paolo Bonzini wrote:
> In preparation for adding more similar checks, move the VEX.L=0 check
> and several X86_SPECIAL_* checks to a new field, where each bit represent
> a common check on unused bits, or a restriction on the processor mode.
> 
> Likewise, many SVM intercepts can be checked during the decoding phase,
> the main exception being the selective CR0 write, MSR and IOIO intercepts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 79 +++++++++++++++++++++++---------
>   target/i386/tcg/decode-new.h     | 25 +++++++---
>   target/i386/tcg/emit.c.inc       |  8 ----
>   3 files changed, 76 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

