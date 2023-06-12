Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D182172BCC3
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dut-0005CN-Qz; Mon, 12 Jun 2023 05:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8dts-0004sg-OH
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:31:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8dtr-0000Kz-4z
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:31:48 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30fc1514745so734213f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686562305; x=1689154305;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YSWV1fhRBNt1Q1RqUWNncMsHcf3c3nT+7ztgdVmbNSg=;
 b=OgqGNsNdXicR1GOUPBFAR0LLMPXN1IHw4Fzfi3d2j3D6Pqx/+xe4p1vrsy6/X1dykl
 u5uZMptTqDyFLuqhfXJoZnDTCxVvLZihn2UHMwri30EKsUUwZaxFxzoZ2NbIyMdtKxet
 ftmJLGq1iWQJXO5MSKFzhfRndqhQKWrLPQ16umDtyF0QcTr+LYN+XWRIA5yYZxePX5nc
 h6lk2DkiGPd1OwYFSrhWyf6yy7SjkiQDHRF4KEMpJdU9uVR3pgo8Z/UNeyb/+ovk2/pm
 K4KT4I90DEuqRle0wd5UO51OHvmWzRhoiipNP11REPJ7xkozNHAZtKzcdwYIA1OvNLpu
 uJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686562305; x=1689154305;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YSWV1fhRBNt1Q1RqUWNncMsHcf3c3nT+7ztgdVmbNSg=;
 b=g90FP2DmPwDMVGMeul/Dq9hyUrGFqM49XRXEv4cieiRCQb83Pujjk66t1UC7Bylaop
 47cgFx3kpTJXfWEa84tax9XyP56fmSj8jJeeRzhcE31i9Hu6VKrSdUImJuGduFcsO4vi
 SmSv1bxAnW4UWMaNTFbS9tD+VXGINyl054dvn+Z1it9v+LFMNWkuK3xouomoFkqIF9LB
 gvJ5goQ/QqfwgQE5PgIGjsDbV+du2KbH5eF+ER+czRp9E3tPyWiP2CwA9UZtgYLE8Smw
 9IE4JW2HPtEzQyvwXzgmnSgjj/dSAdV7c7/pmlNdBCekpaHPPqBQH0Pi20VsmLn6n/tS
 frug==
X-Gm-Message-State: AC+VfDw3sWESvSZ3OMf328+ohFBOWYPjiSyFOXA4VHTcc7boj4UmIkVj
 O1HIPVjxU/iT5AzvJsM2EWLTSg==
X-Google-Smtp-Source: ACHHUZ6OMl1by92yzPPsTxwGrc5pV78IB0M3H+UgKlU/PHiObeqhkO5Z4pbJ+y4rTqxLrO6PExcYXg==
X-Received: by 2002:adf:de8c:0:b0:30e:5433:db33 with SMTP id
 w12-20020adfde8c000000b0030e5433db33mr4428462wrl.43.1686562305345; 
 Mon, 12 Jun 2023 02:31:45 -0700 (PDT)
Received: from [192.168.143.175] (17.red-88-29-166.dynamicip.rima-tde.net.
 [88.29.166.17]) by smtp.gmail.com with ESMTPSA id
 k17-20020a5d4291000000b003047ea78b42sm11930558wrq.43.2023.06.12.02.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 02:31:45 -0700 (PDT)
Message-ID: <955711b7-124e-37d1-c37c-f0f4bead255a@linaro.org>
Date: Mon, 12 Jun 2023 11:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 03/23] target/arm: Pass memop to
 gen_mte_check1_mmuidx() in reg_imm9 decode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230611160032.274823-1-peter.maydell@linaro.org>
 <20230611160032.274823-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611160032.274823-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 11/6/23 18:00, Peter Maydell wrote:
> In disas_ldst_reg_imm9() we missed one place where a call to
> a gen_mte_check* function should now be passed the memop we
> have created rather than just being passed the size. Fix this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 0a9091424d ("target/arm: Pass memop to gen_mte_check1*")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


