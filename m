Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A6870E1D6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uxe-0006kD-Aq; Tue, 23 May 2023 12:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uxb-0006jo-Rs
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:34:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1UxV-0000oi-1S
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:34:07 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-309d3e8777cso2775819f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859639; x=1687451639;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K1u6I1/sQx7557C7WCXpFepF78LZKxLIEBvpkPS2tYI=;
 b=LJlOD3SHyn4rPX0EcRtMZ6KT6PvWW5Ph3wfEu7gRzlT+il+Nq68Le+el1vZgTVIrQw
 n/ToOHZf6HwCiYNaS+l9DWZPddEfycHTJCdoZdJ7eKhsCuqJNdK/naqMGksWXjktvOlm
 yp1OBdy/Ll76II6K2ftN7nCGS87OQJYTL8RCXyqLNCjHIixaEOsj2nID2kWqHaK8EwUh
 da8gujTieU3qOAcUgBD+f+RD+Ka3jMOX0DDPBjyxiPyJ2/EeBfW7R4oF+ksjXUcwokMd
 T9Y/m16+BHbhwoKr4zkSMHaaiulYD2qUASoEvwF+eGFLjKZqWNmqVb1440UluxsMRTgq
 7fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859639; x=1687451639;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K1u6I1/sQx7557C7WCXpFepF78LZKxLIEBvpkPS2tYI=;
 b=ISVUfgqH89KJKDItovtNXv6V1fT21eX3/+l7DMyH+tTuiEW1c02C0TnwGKlru+PGnn
 bV6iTX+dQf6kKXXojqF+rjWtpE36OXBPAq5lF2JcneHhkB4B3v3d2QYKnooqYI4kzz0z
 iq8+VNCbEYGl1Kd6/olkhc2qPQtHzJPUFpt5Nt0wUQNkgbolwhnzWvd9tNJneWfLHkUj
 AuBp8IouiFFIuIOI06oaPY8c/ITTSVWqQrql4ZDQBiP9u1nfXS1wRdm3r2Pz3jiTdrDl
 XKalVBlMfD8Vy7BhxFKLFjKk8mnXZeeaejY92Zlbcy7Gxcbb03kycuoJ7cPORfnLQp+T
 1Ypw==
X-Gm-Message-State: AC+VfDyuRLwzLYdB3wOd5SmBAFiv+mwrbDAPJNyrzGMZyMivov/DAmcZ
 /kF7QlMFOwkMzl4zyXuytS3ehA==
X-Google-Smtp-Source: ACHHUZ5aZ1tfBscngxK3ZiLEznrcUOQQGo9W4mtagS5x2SyCspZveO0SyVgXVygfN19auftnVXLgBQ==
X-Received: by 2002:adf:fec9:0:b0:30a:129d:2e87 with SMTP id
 q9-20020adffec9000000b0030a129d2e87mr7913832wrs.6.1684859638957; 
 Tue, 23 May 2023 09:33:58 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 k1-20020adfd841000000b002f28de9f73bsm11521031wrl.55.2023.05.23.09.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:33:58 -0700 (PDT)
Message-ID: <26557179-d8dc-2277-1fbd-b24b253da351@linaro.org>
Date: Tue, 23 May 2023 18:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/52] tcg: Split out tcg/oversized-guest.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 15:52, Richard Henderson wrote:
> Move a use of TARGET_LONG_BITS out of tcg/tcg.h.
> Include the new file only where required.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h       |  3 +--
>   include/tcg/oversized-guest.h | 23 +++++++++++++++++++++++
>   include/tcg/tcg.h             |  9 ---------
>   accel/tcg/cputlb.c            |  1 +
>   accel/tcg/tcg-all.c           |  1 +
>   target/arm/ptw.c              |  1 +
>   target/riscv/cpu_helper.c     |  1 +
>   7 files changed, 28 insertions(+), 11 deletions(-)
>   create mode 100644 include/tcg/oversized-guest.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


