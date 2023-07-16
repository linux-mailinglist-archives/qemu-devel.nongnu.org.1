Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61432754FDD
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 18:50:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL4vi-000554-NU; Sun, 16 Jul 2023 12:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL4vg-00054f-Dz
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 12:49:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL4ve-0005zr-Kc
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 12:49:04 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2189345f8f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689526140; x=1692118140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1MPpyemGwgzB+nKFLOUKSC42RU8xp9x47zLLVYF6Rq8=;
 b=plRMrJLAudz8Qok9gonA9RK8yUPREGjDYugC0reB7dwM5sDQy1y8z+NHUO01AyVadV
 RC60dtBKxsS2RgCmvqiLjbz0BOdTKYMWiUz6sv2BZlYERj/dRqcbEqKxrQI6cF1gBWIQ
 5Azf6kNu2hn6gOhVANYen8Lx5XLC6ofyIEzqm+AQ94gQQFAxsuVrquDv9LyabWV1yg54
 +wYVo2Eq+2WMHO2347V0aE/U/zd+0iWKIVXb0mS9vXmkYxycWvqmiR17tEdQQYcbOK0d
 nmPBG3dE5hhYIQE1epsaVjSgNCJ6PwRkeqg7KYkKm3rYGsenn06Lc+wlynfqpFAa85sB
 ivcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689526140; x=1692118140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1MPpyemGwgzB+nKFLOUKSC42RU8xp9x47zLLVYF6Rq8=;
 b=CqgVgL4sJ5HpAMo6ijdb50pdqR0R5vJOPtzpSnob1WRRDD4vFTd8zTtIot6Tc+S+Rm
 Wcu0gP52J0ksL0Q2Xw+1Bddt8+OZ4I/TXiAmHvqAhpv1c0mcF/sVtlgAuXPgZxnA61bq
 csTz5Qe2GdSUAGF/6Y5HEjj/09DQbb9tIorlBNJwi8O3R7r4Eqr3m/im5za8k2DKDWKZ
 RG9CgEwmxWv9WTD9ux2drcMBlSHufKPuY8BgBdFcF6hkOF/A87+owO646Z0bTdSgpyPW
 1FH6kDAjNe/wv1pZvO+///6lVfb4yMxQSnn9SuyY84/qc+owdxn86Dx4KcM/93WoIcnO
 8WJw==
X-Gm-Message-State: ABy/qLZLwmxIdhsEUaOsKrpIGUVbtXz9MdDUlUbTu69vRsm8Tn8wCKwO
 adNJvf4Q3qzCVmY/UOWicp8GEA==
X-Google-Smtp-Source: APBJJlFsycrSq/D+cegEwVIMKDtCJcfV9/hRcIkKl4SgsMFXyR2D4+wyXnI6usSyjdwqAEJjxA72KA==
X-Received: by 2002:a05:6000:181:b0:314:2c77:681b with SMTP id
 p1-20020a056000018100b003142c77681bmr6538066wrx.30.1689526140261; 
 Sun, 16 Jul 2023 09:49:00 -0700 (PDT)
Received: from [192.168.1.205] ([51.219.12.49])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a5d5349000000b003143b7449ffsm16820767wrv.25.2023.07.16.09.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jul 2023 09:48:59 -0700 (PDT)
Message-ID: <9c37c504-fd47-ae96-42cc-cf082d984cee@linaro.org>
Date: Sun, 16 Jul 2023 17:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v1 0/1] Merge tpm 2023/07/14 v1
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230714154101.184057-1-stefanb@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154101.184057-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/14/23 16:40, Stefan Berger wrote:
> Hello!
> 
>    This PR removes the 'ppi' boolean property from the tpm tis sysbus
> device. It could never be activated since it was leading to a segfault
> immediatley.
> 
>      Stefan
> 
> The following changes since commit 3dd9e54703e6ae4f9ab3767f5cecc99edf066668:
> 
>    Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-12 20:46:10 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2023-07-14-1
> 
> for you to fetch changes up to 4c46fe2ed492f35f411632c8b5a8442f322bc3f0:
> 
>    hw/tpm: TIS on sysbus: Remove unsupport ppi command line option (2023-07-14 11:31:54 -0400)
> 
> 
> Stefan Berger (1):
>    hw/tpm: TIS on sysbus: Remove unsupport ppi command line option
> 
>   hw/tpm/tpm_tis_sysbus.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


