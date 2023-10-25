Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188967D78A5
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnQT-0004WG-Ns; Wed, 25 Oct 2023 19:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnQR-0004RS-Fn
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:36:35 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnQO-0007Xg-2l
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:36:34 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27d17f5457fso1137917a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698276990; x=1698881790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sEpH5pFxZ5yY8ied4DMMBDxRNtHRTGN9U5n45M+Gh0Y=;
 b=cXl1VGF70l7/KN7zELczZlEKFmeQuB+savU8BWdhXumOGQ/wSJ1eI/j0Sc+Bkdkpev
 ltY9m8lGcWezvne0FHpO0hGUN0dOZoqUwO/gouUPdTN6mYy4bEZGgKTJH48sw2EUGCTx
 PLzfP8/nr0PXcNqQ3gNOljWyc+nTbIRuDSg8f3mMYJbTllf6B5uzDh7mJpzbWbuMkQ5v
 4wrFXTjgydLy9eaS+uo9jQpMAK90xKEKctZpEd/NolFkL5K85UjoDgBHknvYmDUeM9a/
 xnuxDlzBCTJQEi71RaSs/yGWT8JN5bCXQGtVukdEWLxKvAhb74aO4mws8utcPDyshq9Q
 h62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276990; x=1698881790;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sEpH5pFxZ5yY8ied4DMMBDxRNtHRTGN9U5n45M+Gh0Y=;
 b=Y1n7sqV9beFS30LBZTrpefF5oDydMs132z9CsK06LA2z6r2eHoHoSUbRpF5noxjqG4
 ADr3HO+PgAJl7dr6DZmDuizx8X4juraSJQQJnJt7KotvsY9iyvUMcJVWLyQ5OGR/LtQf
 8GzfzMPs112Lkb8LWColQRmC/CWZYEXHBsOiEhBYycf8D+4H44AtfXIMaUzGCnsVcoyY
 2As3TgChNMzboVHjfqigZSjHe8+j8Z9cxGxmxdrYOIBnTQ6Kjk4AGCv7BkT7k68BoPI/
 a/t0V2GgP9V/yjJRpFyd8SRqSZz94YBEoK//mcVlzoleBsdcuFimCZjjVj28WeGh/xiG
 YWfA==
X-Gm-Message-State: AOJu0YxfSGokCQgVrWbVQM02uVofvqalFUJFU581rIMjbcdJIqMnEOOO
 6dmfjgnoRNEoQ+/K5Qh6yY4/Ew==
X-Google-Smtp-Source: AGHT+IHoe/MXYM2MbWOEC3hj8rxj1j8kU+VKhJ+OLy2ZtAv8Alvgt4/XvCnHDz4mOYGYBZWtydVTqg==
X-Received: by 2002:a17:90b:374c:b0:276:6be8:8bfe with SMTP id
 ne12-20020a17090b374c00b002766be88bfemr1297423pjb.23.1698276989770; 
 Wed, 25 Oct 2023 16:36:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a17090a6b8500b00277371fd346sm475304pjj.30.2023.10.25.16.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 16:36:29 -0700 (PDT)
Message-ID: <ea65874c-53aa-41eb-bda5-77c741368eb2@linaro.org>
Date: Wed, 25 Oct 2023 16:36:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/arm: Move ID_AA64PFR* tests together
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
 <20231024163510.2972081-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024163510.2972081-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 10/24/23 09:35, Peter Maydell wrote:
> Move all the ID_AA64PFR* feature test functions together.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h | 86 +++++++++++++++++++--------------------
>   1 file changed, 43 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

