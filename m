Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A081F341
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 00:56:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIdk8-00075h-H5; Wed, 27 Dec 2023 18:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIdk4-00075O-7d
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:55:16 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIdk2-000747-H0
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:55:15 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28c0d8dd88bso1888734a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703721312; x=1704326112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vIry2953MMeVuYtJmrDWgg1RNwX+P2/WfKs15U/O6QA=;
 b=iHJi3ngEmKD3+WNkoBzNxKB+gcNc16LKi9mLU8T4Y3KanVeQF5X5fiDp3HftTiGrI6
 lA+GA0mCHvv2EzIH68WStu4sNORdHbV0zS7BDdvK9lVop/UY17ZLi+nZkUAbhFmkiNLa
 6/X/n5SznOskckCoAVMAlb8kSHGYwlgmphpQfEj/tpYrHJQdFzWBGlaZBebjTOiRs/bP
 U0vO2AP1gs8t0Yc84cGcn+x0jICt517Ah8bO7rtro3XudrtyfgechZhtsl4ogtHYY60C
 yThUUsKG/AMmf7cNLVrvuJCoF7h189Ufb68419owWQTKYS/SHRnJBdzQUpIDl9CqQfga
 zW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703721312; x=1704326112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIry2953MMeVuYtJmrDWgg1RNwX+P2/WfKs15U/O6QA=;
 b=YcKjlG2AOu+u0QBvkeHSL0kAHwicikcFU02jmwzb+zoNawO73cX+wRpIVHQ+TCFzhK
 tr4rsk//fRJ3IukBJi3xOTTYDIkUJajHW6pZvROUOBLKWQ/3Uurl27NF0uU1f8eg0t+P
 CmRVUhj7GJB11Qibt5rzn/5aiM3WbZ4DiY/2eR5FxA7B2TObbejTZ+JU3165DB8CL6/s
 zI0FNlcY8gHHNrOT/gkp1q63fxrMFxhQsDd15nL+36zyvtKiKv0aUJDnRVGzlvp25HvE
 PlkKhg5bP1MOFl41qYjYSnET04j9v7y2o3ZF3S+wi1EOP88wEik+UcWaBNcSOfgoXEXt
 5xEA==
X-Gm-Message-State: AOJu0Yyl64nJZL2vML/h7GwtaldPQCiOg+9IB1uGId9k0CISGI2RGlB/
 YLAo+hEHSS3OGViL7TgoSQwXattuS6Y2Cg==
X-Google-Smtp-Source: AGHT+IFTJqLG/2OU/5JPkcsCc+kzW770zBF4vDWjanvk6hkQ/QzflVJ6q4DuIbfScwblUHUE3l/sbA==
X-Received: by 2002:a17:90a:1f09:b0:28c:25db:2cd0 with SMTP id
 u9-20020a17090a1f0900b0028c25db2cd0mr1999317pja.53.1703721312393; 
 Wed, 27 Dec 2023 15:55:12 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 oe12-20020a17090b394c00b0028c94e8fecesm1707907pjb.31.2023.12.27.15.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 15:55:11 -0800 (PST)
Message-ID: <88dcdb40-2fa3-449e-a3f7-41d75269a968@linaro.org>
Date: Thu, 28 Dec 2023 10:55:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/35] target/arm: Implement FEAT_NV2 redirection of
 sysregs to RAM
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-27-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/18/23 22:32, Peter Maydell wrote:
> +    if (s->nv && s->nv2 && ri->nv2_redirect_offset) {

Again, s->nv test is redundant.

> +        /*
> +         * Some registers always redirect to memory; some only do so if
> +         * HCR_EL2.NV1 is 0, and some only if NV1 is 1 (these come in
> +         * pairs which share an offset; see the table in R_CSRPQ).
> +         */
> +        if (ri->nv2_redirect_offset & NV2_REDIR_NV1) {
> +            nv2_mem_redirect = s->nv1;
> +        } else if (ri->nv2_redirect_offset & NV2_REDIR_NO_NV1) {
> +            nv2_mem_redirect = !s->nv1;
> +        } else {
> +            nv2_mem_redirect = true;
> +        }

I wondered if it would be clearer with the "both" case having both bits set.  While I see 
that the first defined offset is 0x20, offset 0x00 is still reserved and *could* be used. 
At which point ri->nv2_redirect_offset would need a non-zero value for a zero offset.

Maybe clearer as

     nv2_mem_redirect = (ri->nv2_redirect_offset &
                         (s->nv1 ? NV2_REDIR_NV1_1 : NV2_REDIR_NV1_0));

?

This is more verbose for the (common?) case of redirect regardless of nv1, so maybe not.

> +        if (s->nv2_mem_be) {
> +            mop |= MO_BE;
> +        }

MO_BSWAP is host dependent -- needs

     mop |= (s->nv2_mem_be ? MO_BE : MO_LE);


r~

