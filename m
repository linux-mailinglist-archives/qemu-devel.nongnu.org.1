Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCE81F24B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:07:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIc33-0004Ah-GW; Wed, 27 Dec 2023 17:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIc2t-0004AD-PP
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:06:36 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIc2r-00034m-Ii
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:06:34 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d4414ec9c7so7667855ad.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703714792; x=1704319592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=50QMk78dUVGW/REqyuG3vJ9DuzRgURXeSt5CRv2U6Zc=;
 b=bQFbHkBmB60M0kp6Oy/MqyZXder2jYSjJwC6Qe8wzbLeNFeU/EHBPVo8CxJS2kn89N
 yr8PQVFIXoAeI3NuatCKYkV7M0o+yOuFTKbRRGrN4m+KEiAa6x2G8GOIU10RzuYUXBLT
 yijfaprLSVgckjAl7sW5Ocb8sO4wIF5MDFkynkLF5w5z1+BqpzD4lsxew+xDgwzVkjPL
 CJJBOGWVH2D+1DVzlw9E5bgIWhJ+aBMRc3i5B+PFUdIxhUZ/C8zDrSj6SuwuB83+eURI
 /ouQYvT4ttm3wMKuXrscnlaauOzAAoYyyR9yqQAV94SIYGRdsa/W2+ZNpPczdcdE3Vct
 kz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703714792; x=1704319592;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50QMk78dUVGW/REqyuG3vJ9DuzRgURXeSt5CRv2U6Zc=;
 b=uPepFMCp6D33mTzwiM9plz3dTMn52C3ikGOFX+Qlh5LBuwHWI/VfDhtSPIhkPjllMz
 vDlYSr0cRrQ0/okbxlAr12BWrWbjXcjRR1NmexM+keSjmWkjksnj3yMO/Wxc4UQz3stE
 UjYklISdLo0N53Awc+S2Qiei8xv6XcUF6jSop6QFUoEQqd2O+vt0YK/O+/tkc4/lu7nx
 R90990xOHRvJaVQlW5tgKP1TiEnSxJz7OT0RX0M9/dNGn4ZOQT8nNGWC4dVnBKqjgClI
 abZfW1X01FUWixaVzPSlh/wUy9mdiAZhlST/l8iDtA2iBOamhVAvdbxiicuVDd6B+Lk+
 Ij8g==
X-Gm-Message-State: AOJu0YyJYMU3Wdf76TpWI8yzwyE6iKGitNlMgAISC999qh1JvWUOQGbu
 bXkf7Evgj5XRHOJXMr6aaWiSdHzE7+bFOJGg2TcotHF4s9gIiQ==
X-Google-Smtp-Source: AGHT+IFDdDpN3IDx8oNb/UQYpDCtIQFw6Ogk0NtWg6G1SaP2yhkIpJy4pl0TdJ+cNGhfk3LixgV6Pw==
X-Received: by 2002:a17:902:da88:b0:1d4:39cf:c94e with SMTP id
 j8-20020a170902da8800b001d439cfc94emr2987189plx.49.1703714791960; 
 Wed, 27 Dec 2023 14:06:31 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a17090274c300b001cf6453b237sm12509479plt.236.2023.12.27.14.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:06:31 -0800 (PST)
Message-ID: <333ce9b4-8e00-4800-ad93-f65f1e4f10c5@linaro.org>
Date: Thu, 28 Dec 2023 09:06:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/35] target/arm: Enable trapping of ERET for FEAT_NV
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
> When FEAT_NV is turned on via the HCR_EL2.NV bit, ERET instructions
> are trapped, with the same syndrome information as for the existing
> FEAT_FGT fine-grained trap (in the pseudocode this is handled in
> AArch64.CheckForEretTrap()).
> 
> Rename the DisasContext and tbflag bits to reflect that they are
> no longer exclusively for FGT traps, and set the tbflag bit when
> FEAT_NV is enabled as well as when the FGT is enabled.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h               |  2 +-
>   target/arm/tcg/translate.h     |  4 ++--
>   target/arm/tcg/hflags.c        | 11 ++++++++++-
>   target/arm/tcg/translate-a64.c |  6 +++---
>   4 files changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

