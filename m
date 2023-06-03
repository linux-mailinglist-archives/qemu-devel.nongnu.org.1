Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE22720DBA
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 06:11:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Ibe-0003dJ-GM; Sat, 03 Jun 2023 00:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IbZ-0003cv-IM
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:11:06 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IbX-0002iy-Sh
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:11:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-653bed78635so617696b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 21:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685765462; x=1688357462;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IH3pov5/omdsDcval266c4lMDuTZfPL8GEkLttNPQgU=;
 b=hKpxIlLeLWZOU3odPrWGGK1f3xBbQurDQq1v12X2JofNSVudpDjmN+BjAt4LIOiQBQ
 qbpfna44sQoGOJpHaC6zv7rebdpOYX4PYqP+De7PcpEK4en2VleSOx934j2cyDOzTddu
 R/BAL5vEybBprMsMdGsWUvSyb5GTvPrNUyIVePydJ2b3qwoe/9JJ+WOwOv20D+Gw93e0
 qVEwGOZ612YbNiAjawAc3pjuVy+iwuu21vtIX1OArXpsF867uqkNx/+fbK+M0RQJyueH
 QiNx4z2wXrjpyTETYMa2As8wl51TrALWt99ygytWlxulHPnBJYPPjyIDLohP5+NA4mQ1
 wPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685765462; x=1688357462;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IH3pov5/omdsDcval266c4lMDuTZfPL8GEkLttNPQgU=;
 b=CEQ4ceeMNoddU2g9CYWg0FvYYjAoNDQhkwq+9fSY8/FwjmuL1SrnRo53+kQ7AxoTwh
 ZrZmtLjpBVswRA6mK8uURXPEEUEtY/sZ89RpjnBPQ2yrt+9IchnP/sykWhfZ9nhkIL2d
 uBePTHkFH2oNknzFoJTEC/ZJf4ySodsThz9/8C3isn+YGzuLL5L7hA0OWyK+stnV7b3n
 O2rXTeC5iJUdFtwyQfOnbkfodJ+p/iOaMfxh36xK2+/6ar2gei7mwq1CLmf+bXtAeEgg
 Ue+SSfYkv++Ros02Cy+36s7VdvNeGHFazZfeAYzcnEOlaXAUZDOwHBEqpZCp6yE4poMb
 WdaA==
X-Gm-Message-State: AC+VfDw/Slf9OJCeCMxqQHyiY4K/uVW1C9+dAm/YuRw1Nkam6o7y5yR9
 WlUl5Azi+vsKbL3u2GBUYssOtA==
X-Google-Smtp-Source: ACHHUZ4Gy6E+5iIS9ti0psEXH+KuVm8X3k3KuCHIUAMI1k9B61Q+gsREHefXMIA0ZinEHRcpWPGvOw==
X-Received: by 2002:a05:6a20:394e:b0:10b:c843:9522 with SMTP id
 r14-20020a056a20394e00b0010bc8439522mr461011pzg.20.1685765462110; 
 Fri, 02 Jun 2023 21:11:02 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a62e20f000000b00643aa9436c9sm735574pfi.172.2023.06.02.21.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 21:11:01 -0700 (PDT)
Message-ID: <0a5ecfb1-a412-71dc-bc73-a688561b3794@linaro.org>
Date: Fri, 2 Jun 2023 21:10:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 24/48] tcg: Split helper-proto.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-25-richard.henderson@linaro.org>
 <b1f6be3c-a275-8e3a-63e5-a9a7d804749a@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b1f6be3c-a275-8e3a-63e5-a9a7d804749a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 14:14, Philippe Mathieu-Daudé wrote:
> On 31/5/23 06:03, Richard Henderson wrote:
>> Create helper-proto-common.h without the target specific portion.
>> Use that in tcg-op-common.h.  Include helper-proto.h in target/arm
>> and target/hexagon before helper-info.c.inc; all other targets are
>> already correct in this regard.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/helper-proto-common.h | 17 +++++++
>>   include/exec/helper-proto.h        | 72 ++++--------------------------
>>   include/tcg/tcg-op-common.h        |  2 +-
>>   include/exec/helper-proto.h.inc    | 67 +++++++++++++++++++++++++++
>>   accel/tcg/cputlb.c                 |  3 +-
>>   accel/tcg/plugin-gen.c             |  2 +-
>>   accel/tcg/tcg-runtime-gvec.c       |  2 +-
>>   accel/tcg/tcg-runtime.c            |  2 +-
>>   target/arm/tcg/translate.c         |  1 +
>>   target/hexagon/translate.c         |  1 +
>>   10 files changed, 99 insertions(+), 70 deletions(-)
>>   create mode 100644 include/exec/helper-proto-common.h
>>   create mode 100644 include/exec/helper-proto.h.inc
> 
> 
>> diff --git a/include/exec/helper-proto.h.inc b/include/exec/helper-proto.h.inc
>> new file mode 100644
>> index 0000000000..f6f0cfcacd
>> --- /dev/null
>> +++ b/include/exec/helper-proto.h.inc
...

> Should we guard this header for multiple inclusions?

No, *.h.inc again.


r~

