Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3081F380
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:54:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIefV-0001IJ-8B; Wed, 27 Dec 2023 19:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIefT-0001CB-2H
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:54:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIefR-0000xy-CZ
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:54:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d4751dcb56so6712375ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703724872; x=1704329672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B8XmnUfdJKj+TB2L07DLXAvKXwYIBoX9DFJDEEqoAv0=;
 b=goGOnTaLSrhCM6wB6XSypSIWO5aJCpRi0oXCxIu2iIPxrVIa+YLHcKHj/m/c8ZpxK1
 sLK8MswRDhco7wjj+pYrprR9HnTvTQzbwMHpM3TPJCzEHHZBvv0oOK25pj6K2YSoKI+l
 GlOO1er/sU0qg6cubyl1V/RdrXNkK3ORkyBI+jIiuEYqnrAggSh3XeZomSqXESW1Bn1G
 Fr4MlGcq7Ab+Iwb2LzU6LmUNQ5xp8HUHm4NxBOyLAHcoA9etd9sUcdRbOYyx6iBPuEs4
 aaW4yUDOAJLMsmWTFtqNPdyR00LCuoKAGVXaGurcFbO627qh63C0JQ5J9Kdao3oKH76Y
 a78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703724872; x=1704329672;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8XmnUfdJKj+TB2L07DLXAvKXwYIBoX9DFJDEEqoAv0=;
 b=f5RR/3/5ziXk7bmY2gVa7ETZ4TX1xvZLOkNukBmpYDrGa2OuzNlWHlafQ479lGDzKC
 M4TAOTr5vCdndavCRldAHKf83ZqqmEeSF662wYZalFzPmi9JZM3Wsf6Rt2I75rd+brqJ
 Ez+FyNhByQH4gC2yeilWp8ci4cbfAaX7GP4sTKgbW7VMU354i04PLvs6oQfsy0X23ZhN
 ZkrKXBckNqaNfztQGR3S8q1KH6ww3AWREoDtzWcMZ9mrtONdabeauswrmv2CqSF9EK6/
 17//ENRa0C0t4Hp+/4tK9UxMyCx6ZSYYlThF2UTKPRZA+LB1nhdziYaH+frSB3pSUixN
 hhbA==
X-Gm-Message-State: AOJu0YxrMcxOWBZ4QD0EmZ159lNSoBQDi6mDdFTvPR8MvrusBt9OIljM
 RTs0Zf9BKhLr1fslD4WZl30CvCCW4ddScA==
X-Google-Smtp-Source: AGHT+IGWTgIR+KB34wnSlB6qV5BsSet7r5nuUQCEv3TBegfjZLsoFtv39jYxHutW0XP4DtF0Sn5HEg==
X-Received: by 2002:a17:902:c3c1:b0:1d4:1999:d9ac with SMTP id
 j1-20020a170902c3c100b001d41999d9acmr4001203plj.94.1703724872128; 
 Wed, 27 Dec 2023 16:54:32 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a170902969200b001d4872d9429sm1145847plp.156.2023.12.27.16.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:54:31 -0800 (PST)
Message-ID: <801c1e43-f2e6-415b-82c3-64c90d318c35@linaro.org>
Date: Thu, 28 Dec 2023 11:54:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/35] target/arm: Enhance CPU_LOG_INT to show SPSR on
 AArch64 exception-entry
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-35-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-35-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/18/23 22:33, Peter Maydell wrote:
> We already print various lines of information when we take an
> exception, including the ELR and (if relevant) the FAR. Now
> that FEAT_NV means that we might report something other than
> the old PSTATE to the guest as the SPSR, it's worth logging
> this as well.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

