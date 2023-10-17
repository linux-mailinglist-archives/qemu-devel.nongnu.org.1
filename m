Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 164547CC37D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:45:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjRX-0007br-46; Tue, 17 Oct 2023 08:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjRR-0007ZE-Ld
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:44:57 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjRQ-0008BA-7D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:44:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so9763425a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546692; x=1698151492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iDynNsTl47oEPZltiAbi07WZ0fTDkuChOLRqUfE+Tuc=;
 b=mWhXKU7KK4J9FUsqbY5R4Np50uNPlLMobfdMKEu0k75lEHNavf4KB19SDEslXKYyDK
 d6jG/RoYyEFdMNC3hnh4ewfQp1DgunQ4CY59NrE2KuDmWuDfvIx4QCWMpIqIIKApZkYe
 YJzMe7aTKl+Pon6Wa6KSGqkj+aUsf/0WmUSp4/sd/5eX4pat23TbIHWX1fPQVSrUbg9H
 zfONl7gpcBI2mE66gdhnTjtPpdp718EVrOqVL+ZIFZNMgxowbldFid2eK8LRDj/CNJT9
 NaSt4ifbFYDMiqHi0dyUmb8SxV6G9RYQF5oQ+mba/p0aQ9nc9SieCTt8qBNP2ghFLX2+
 KRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546692; x=1698151492;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iDynNsTl47oEPZltiAbi07WZ0fTDkuChOLRqUfE+Tuc=;
 b=fRtev5T0Oq20bSmFl3/e67jfnfqL05fFCusllovp+/Ri4DWm0w5590fQVc8EX7o3Q3
 5/j7HyGCWdBJ3tQCMzzg56zifS7TAlZoeOHbYaDuUArmgzHdFlmg9uTLkAXAWMnrDycb
 zGACLrzN6X/v4tLAtL9sb6Lb3vdf58uO3PDgc7yt1pGqps3kUUh0QbBa4s1emfU6An4b
 D/syggd+XBfjpK/+A5Nb1yKF/zM41H/i0R0OPe5fUX5EXLl81J8SwBGuyLRtNLYuCAKO
 r7Q+g+Uulrqhh/vGFRtl76K3o376A/d5gHNEuNOHsoOn+nFdVjnlgJPWJIxUropifzUi
 cQgA==
X-Gm-Message-State: AOJu0Yzk7gx8fIAuQXPX/JZ1eeFupbKz96+oEDNqmwtzGSP7QOkdfq+W
 Zf001H7PydN7F5yoPz2nMRdO7nsfZvdb54yFub0hxQ==
X-Google-Smtp-Source: AGHT+IEs7J7mueszJw/sBGYHV+udSc9zBUjC3/GBlP0oBsulfR9gXCpYi0J7CA0NKNGyCw33+KM2aw==
X-Received: by 2002:a05:6402:4315:b0:53d:fbf6:72c with SMTP id
 m21-20020a056402431500b0053dfbf6072cmr1893981edc.1.1697546692773; 
 Tue, 17 Oct 2023 05:44:52 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 16-20020a508e50000000b0053eb9af1e15sm1190483edx.77.2023.10.17.05.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 05:44:52 -0700 (PDT)
Message-ID: <c985a5c2-dbe8-8ea5-e4c6-1df9d530dd68@linaro.org>
Date: Tue, 17 Oct 2023 14:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] hw/input/stellaris_input: Rename to stellaris_gamepad
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017122302.1692902-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/23 14:22, Peter Maydell wrote:
> This source file implements a stellaris gamepad device; rename
> it so that it is a closer match to the device name.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/input/{gamepad.h => stellaris_gamepad.h} | 6 +++---
>   hw/arm/stellaris.c                                  | 2 +-
>   hw/input/{stellaris_input.c => stellaris_gamepad.c} | 2 +-
>   hw/arm/Kconfig                                      | 2 +-
>   hw/input/Kconfig                                    | 2 +-
>   hw/input/meson.build                                | 2 +-
>   6 files changed, 8 insertions(+), 8 deletions(-)
>   rename include/hw/input/{gamepad.h => stellaris_gamepad.h} (77%)
>   rename hw/input/{stellaris_input.c => stellaris_gamepad.c} (98%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


