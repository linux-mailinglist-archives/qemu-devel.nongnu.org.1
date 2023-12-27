Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5481F29D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:58:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcqn-0003m4-6p; Wed, 27 Dec 2023 17:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcqm-0003lp-8G
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:58:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcqk-0003fl-3D
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:58:08 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3e6c86868so43971985ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703717884; x=1704322684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SSrIliV/5e/px1H71jwkKZEmYXae37rqZsmDzESYHZc=;
 b=gPBl9p5quXnwW4VCzC1nui08Wl1qOp47LC5CNvfPPannjT8EkreptumWxMXn0UxH4F
 7eOwDnGT7qQ6dyjI6B5od/HxbKvRifSZok1g2wsNU10pAa2XFjLwZA+mfAX5STiMCQTO
 MAamySZF6OIWLUyxQnqToqRkrOX2euhE0EGLtF+CHOz81Cg/Vpr/AEUZ4pchU6PDr2rj
 c8C/0+RC4s54Syey6NtczN33McldqqOCWh5ZuJNazsIurpvt0hV8zs2GJL9iDWOqnH1f
 BhGoW1TWTk0yz7aldT1tME0bOx6kZ/HEUZkYOQMaEk9xrUgFK/HzMr1WQ6DNNmeof8rn
 0NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703717884; x=1704322684;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SSrIliV/5e/px1H71jwkKZEmYXae37rqZsmDzESYHZc=;
 b=d3xRGWRwVLmtfjTl3AzA3Fz7hnblOu7tueHtDKdtGpdJGVvDMhKxtEoeErusuSplRN
 dzQSpoOMu+zQ5LUQZCWnbcYl1xMdiFrTiuwr9LOZ1tVW0dDuBpGxDYqPhTe+4U82TD0W
 ek1v+6m/jqFcFIVLyAofm8J+9kevgrIoxRkpPcjgtWJ16E0lblQgnVnS4NA9Ge1XGRSt
 B7iZ0qb0m3DkVgjU3aMgyZueQCxmipP1d/BOBQzi9HjIa0ioingHhBlBcmOt6vaPeAGL
 gvErO+mjTSOP1AR9YBsNm+TkgUkO0UE6jPZCQGQvop8d0GZt02j070BwBs+7fFaXzJwy
 2XYA==
X-Gm-Message-State: AOJu0YzDzy5/OOhr50CNo0nWAEvx6tmu4cFHvTdmZYuVTlCVw++0zPjQ
 DX2OzyggvME913VV7XUTtgA2gJLHS/3BTw==
X-Google-Smtp-Source: AGHT+IEqltuD1FprfpwZK9O2Ay54Gia5ExHX7qX17QTYMkwetXtdBcOgBisVJWWpzORb0+D6r/kwYA==
X-Received: by 2002:a17:902:e745:b0:1d4:1d39:c982 with SMTP id
 p5-20020a170902e74500b001d41d39c982mr11521921plf.33.1703717884545; 
 Wed, 27 Dec 2023 14:58:04 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a170902e88c00b001d06df5c1absm12529753plg.86.2023.12.27.14.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:58:04 -0800 (PST)
Message-ID: <05ef6d75-de08-4892-ab3f-67243a9b0959@linaro.org>
Date: Thu, 28 Dec 2023 09:57:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/35] target/arm: Handle FEAT_NV page table attribute
 changes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> FEAT_NV requires that when HCR_EL2.{NV,NV1} == {1,1} the handling
> of some of the page table attribute bits changes for the EL1&0
> translation regime:
> 
>   * for block and page descriptors:
>    - bit [54] holds PXN, not UXN
>    - bit [53] is RES0, and the effective value of UXN is 0
>    - bit [6], AP[1], is treated as 0
>   * for table descriptors, when hierarchical permissions are enabled:
>    - bit [60] holds PXNTable, not UXNTable
>    - bit [59] is RES0
>    - bit [61], APTable[0] is treated as 0
> 
> Implement these changes to the page table attribute handling.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

