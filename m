Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A88789B5F
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 06:38:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7XL-0007XB-Ct; Sun, 27 Aug 2023 00:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7XJ-0007WK-Ii
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:38:05 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7XH-0002do-Ej
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:38:05 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a85b9c6ccdso1705369b6e.0
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 21:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693111082; x=1693715882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aIBF65oEG3ckmsaa4kzoX7keVOxMBoWkZef2f34E4GE=;
 b=AjmipIyZjDUg0sQKeCG1KVRCHgVSbKmC6lLriUkxChNaQJiv6LJ4mDtx5cZr2onbep
 Dj0XY/swajqKvZSscESuvdb8+Mef1w89biI2ddR4trlEEm4wrYdvLGljrV6oGsp/fum+
 K0VPqxV2X7gAUtuKMnEWhr89LN7nLOqoqqn6+zs9Hy3Nsy7xdHxvdt0IlHX+4wJrHhmv
 kMTHtloMnFtjVKFqSDJuGmlPauPevNUDYzFi6sqhLk++u17EwYgBLbqwXSbkcnKLun8K
 5lRUpsO1jNl/g+ejy2dX0g9NM45Rk0DIYmGzhOL3d+013oNe3yWQVUOr2F0rNI4ZqhUR
 legg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693111082; x=1693715882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aIBF65oEG3ckmsaa4kzoX7keVOxMBoWkZef2f34E4GE=;
 b=IHniUg3n1RNzdNZc8sVoiBXVNRDF6w4pICoLrtHwO0kNhjHg2Z8IUJWzrtGEF8s+eE
 wTQapqx3RxkePh/oJ0FQEd263DjYWxiEhYmRdYXp/ORzJZVy3OnG4Bnh8ywjCWuIhftd
 NN8LO5Za6+8WhqiRXbN+BIeg4Mq4Bsxza13nMH8k1D/eh9V+v9TNlExsQZElzPUpRjWb
 3HSjxzlT0lQk4FbJ/uMMCCwXo29qQTreMs8cw8ciE4bQ27b1JcwAHMACEe/I/8SGnRA4
 LKHJdzXLakHAWyrVH5arFLQYljsDNN1/7Kbqn6LIxpg3v85hEfy0aQ0gIe3uW037SzTF
 SYZw==
X-Gm-Message-State: AOJu0YzcqeDOLYubfASq0WQ+zllkThXWECucox310ridwxlbqE1KTnas
 rUBP+wRj+byTR/oWEYXk0ZdjpA==
X-Google-Smtp-Source: AGHT+IHlm1uBjLoa3uSBP83i33tj1GETDhenUJVP+N6GuYMYVz8rKK3d/G5MVNjqfJrsjEVsL5YS4Q==
X-Received: by 2002:a05:6808:199f:b0:3a3:7248:252a with SMTP id
 bj31-20020a056808199f00b003a37248252amr9885514oib.0.1693111081755; 
 Sat, 26 Aug 2023 21:38:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a62ee11000000b006889601aba4sm4031605pfi.210.2023.08.26.21.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 21:38:01 -0700 (PDT)
Message-ID: <14bb10a0-b3d6-2aa5-8bbd-6b9e13003f7c@linaro.org>
Date: Sat, 26 Aug 2023 21:37:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/10] target/tricore: Correctly handle FPU RM from PSW
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> when we reconstructed PSW using psw_read(), we were trying to clear the
> cached USB bits out of env->PSW. The mask was wrong and we would clear
> PSW.RM as well.
> 
> when we write the PSW using psw_write() we update the rounding modes in
> env->fp_status for softfloat. The order of bits used by TriCore is not
> the one used by softfloat.
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/helper.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

