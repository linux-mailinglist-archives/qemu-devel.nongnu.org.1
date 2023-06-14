Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FB972F394
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IBe-00034Y-Bi; Wed, 14 Jun 2023 00:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IBc-00033z-9P
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:32:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IBa-00017L-L3
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:32:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f8c5d0b216so1956945e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686717164; x=1689309164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yzejSnTugRMRaHNWGD6Unp0zRAuHslT4snDxbcb0Za8=;
 b=lZdOfcGz7uLxq0gdYhVyQ8Sr3rdPSXK6NFTvYWPxl+k/GLnfbuVVt7FG1PxgRBMqAa
 lR8j1ZkkHyo6VIG5sOcJBWRDXgGmlL7fJv3V6Z7ee6KSKyxIMN2UZG0B/F2q6cqgvgX5
 crTRTtxKZ5BlWIjJQbNPlPGrHO/aF5o3/3Xk0CWjCY61AR4yiYZtHvopWxY8vIjiPenh
 o7O916nCmzWQsTpmLDEBAGAnlDR2l/ETbRxndz0997nHTHihXBTc+ORBkuSz3UU2CklW
 /thSeLc6UQQdUQuIv/RBtT1eKt4A/HIf0HL8G/7jwdybqpOGCUtW87Vve1POsuLbEwoe
 Sx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686717164; x=1689309164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzejSnTugRMRaHNWGD6Unp0zRAuHslT4snDxbcb0Za8=;
 b=ZGxSc4eDuLM2Mul4fikmiUGX0xsDsDC+cwfvvhIkU3zxvOLcqRd/kVRvV4wIoEX8wG
 E/mDYV0GnMyWIeCVDuTJwqAturBmgN8NagYMT432HagtKrQcWOVU228Op3Vre+GFf7Ed
 as41VwE7QUwQKj2cNyzLmdZEmCIs5TKiQwiCIy73X2fxIPtNyk5/PsNzcuwU23HWedPM
 ynNFEEeIpL5+ybB9+tzUHieZJJ/a0Cg3Ue3X0TrvTUhxuPTMRrDTpPDfrtQqb/CzvW3x
 PTJoIiRaS/TfJHoOM6u6jcSTxkFXRmghW11lzyN9QHYA/FL34vrT0M/cHaTkluHaGKw7
 kbFQ==
X-Gm-Message-State: AC+VfDw0x3k0FMIy4PIiOtFChzQOIk7xB53SGRwCp3j9a4+kjIehQJhe
 Lbj4X5vh+pX45mnkpEHhfVbidw==
X-Google-Smtp-Source: ACHHUZ5Gh7d6o4mX5Z5873/DtzTIK5KcOOQiIQesKC4ubfgxvtE4rqun7/uF5QyfrZZJGbPsey4+3g==
X-Received: by 2002:adf:f385:0:b0:30f:cf93:4bb8 with SMTP id
 m5-20020adff385000000b0030fcf934bb8mr2412685wro.57.1686717164001; 
 Tue, 13 Jun 2023 21:32:44 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a5d4a01000000b003062ad45243sm17039054wrq.14.2023.06.13.21.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:32:43 -0700 (PDT)
Message-ID: <341999c5-2cac-7f25-441c-0e5bd9db4ee4@linaro.org>
Date: Wed, 14 Jun 2023 06:32:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Fix handling of AVR interrupts above 33.
Content-Language: en-US
To: Lucas Dietrich <ld.adecy@gmail.com>, philmd@linaro.org
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, qemu-trivial@nongnu.org
References: <20230613193446.4372-1-ld.adecy@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230613193446.4372-1-ld.adecy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/13/23 21:34, Lucas Dietrich wrote:
> This commit addresses a bug in the AVR interrupt handling code.
> The modification involves replacing the usage of the ctz32 function
> with ctz64 to ensure proper handling of interrupts above 33 in the AVR
> target.
> 
> Previously, timers 3, 4, and 5 interrupts were not functioning correctly
> because most of their interrupt vectors are numbered above 33.
> 
> Signed-off-by: Lucas Dietrich <ld.adecy@gmail.com>

The change to target/avr/ looks right, but you shouldn't have all the subproject changes.


r~

> ---
>   capstone                      | 1 +
>   dtc                           | 1 +
>   meson                         | 1 +
>   roms/sgabios                  | 1 +
>   slirp                         | 1 +
>   target/avr/helper.c           | 4 ++--
>   tests/fp/berkeley-softfloat-3 | 1 +
>   tests/fp/berkeley-testfloat-3 | 1 +
>   ui/keycodemapdb               | 1 +
>   9 files changed, 10 insertions(+), 2 deletions(-)
>   create mode 160000 capstone
>   create mode 160000 dtc
>   create mode 160000 meson
>   create mode 160000 roms/sgabios
>   create mode 160000 slirp
>   create mode 160000 tests/fp/berkeley-softfloat-3
>   create mode 160000 tests/fp/berkeley-testfloat-3
>   create mode 160000 ui/keycodemapdb


