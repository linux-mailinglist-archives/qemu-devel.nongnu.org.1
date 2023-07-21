Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4C75C231
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMluV-00056l-BS; Fri, 21 Jul 2023 04:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMluU-00056d-1O
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:54:50 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMluR-0002pm-BH
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:54:49 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso2726032e87.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689929686; x=1690534486;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MnoNmPOX0QMD/WQolEVwDPnEhEs3Z+QG4Cf5QGsWXRU=;
 b=gciejw7NTXoZdKuRrLYDF1MlXxytHkNaLfTiy5qU4KPxQTspsy5DuIPUBkc0ClrpV3
 ZWmOhAyBHn0PoNALKnm73Blbm0N+l92YNnwU6Z4YBiGMi457NcuCKNyJFyeGOXxWFreS
 qddgHJxWdpdCTIdvZwGmow6msi4yrq56k8qMG7NLArw5YXoNnwxn0EON4JpZTtZ2MaBU
 aNaRBjsMApiOLmO/01QH8WHp2CbbER2xUzRZ1JsYoVOfK1GY0ZmefER18t2/bzE1mGcF
 I6ujqu41Vm0rtpU7n7Gjl9ShQc3d1ftjITKyLi3VmlSutYZkojkG5EMvGWq95Nvp/z0p
 zJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689929686; x=1690534486;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MnoNmPOX0QMD/WQolEVwDPnEhEs3Z+QG4Cf5QGsWXRU=;
 b=gh8T7093xJr5XiFR7gd4Jkm3ugBWdlSOlBQ+zjOWAbHvliw80MnfCP7rmqIt+s6jDv
 y6Z3ud7sYjrAqZOFe/JYMeQtzY5SQfHSvt6XhEi4qndLq9kPIvSqfGWe0q8n7oHadkii
 KzXQdctZ30uC2mAIR3YAHdjBI2JQN20uHzPY2v7BhSRO2q5svDwGTrzjHBTer5xuTE04
 CT0T9ckCi/0r2dJ5EUofrMgnU/Uj9EDhudmqPAIdpIGpVt3Xfosyw3NoclcOWjOLuxqP
 6kABSdDXTJFIBwVNZ/3myGdHg9IsqQxIH6y13OgrdTwiAlFntdmA6pUGLj/isIwYngE2
 LHbg==
X-Gm-Message-State: ABy/qLaHhJ2dtGYKiUZaImgxUbhR5Uf7SWDtSQ8eE6sBJgG6f8kArhIa
 XMBmZCuzA8qry9bvtFHNVTaJQQ==
X-Google-Smtp-Source: APBJJlEVDr0wAaiEVaAxjbtoXrQnBJXfZlyy9XEjZd6eGCKsPWK/F/+xruhqIM6KPPp69xaakCreWw==
X-Received: by 2002:a05:6512:2036:b0:4f6:d7b:2f19 with SMTP id
 s22-20020a056512203600b004f60d7b2f19mr800254lfs.24.1689929685635; 
 Fri, 21 Jul 2023 01:54:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a1cf30e000000b003fbe561f6a3sm5747019wmq.37.2023.07.21.01.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 01:54:45 -0700 (PDT)
Message-ID: <689f6c32-1009-819b-bfef-ab45df8161f3@linaro.org>
Date: Fri, 21 Jul 2023 10:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH-for-8.1] target/tricore: Rename tricore_feature
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: chenrui333@gmail.com
References: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
 <e30200d0-0c0f-c652-e926-fb305b515abe@linaro.org>
In-Reply-To: <e30200d0-0c0f-c652-e926-fb305b515abe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 21/7/23 09:31, Philippe Mathieu-Daudé wrote:
> On 21/7/23 08:06, Bastian Koppelmann wrote:
>> this name is used by capstone and will lead to a build failure of QEMU,
>> when capstone is enabled. So we rename it to tricore_has_feature(), to
>> match has_feature() in translate.c.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
>> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> ---
>>   target/tricore/cpu.c       | 8 ++++----
>>   target/tricore/cpu.h       | 2 +-
>>   target/tricore/helper.c    | 4 ++--
>>   target/tricore/op_helper.c | 4 ++--
>>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

BTW Bastian if you want I can squeeze this single patch in
my mips-fixes PR I'm planning.

