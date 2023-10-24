Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7663D7D4801
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 09:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvBWO-0000LR-Nh; Tue, 24 Oct 2023 03:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvBWN-0000Ks-BL
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 03:08:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvBWL-0002Gw-JP
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 03:08:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083f613275so33931895e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 00:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698131288; x=1698736088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XmK+RTj/FRggQksmsLuZAYu+Xr+N+hyD+GxtAcrimlc=;
 b=lyFSb7uI67QCUlV8rpdGWv2r0x1asgUqWtP3uXbaDwEbJifqoD5Mx068YE2e2ealfS
 fSRcr9Cts0RDsNpH6qja/8htl9xi/RlUAIzambzpUlhvH8AReSxoqsn0Qz3/K2DK3RBC
 //rTTz3CGoB3x/lJqBRZe/+JiR0WNLnnWfB7gxjLu8TGeCWMlNjIpOQbZ2Y1R+cW11tj
 vGLdhHh8f+El3HoXc79NgsCLxVDFZ/LHwjTMjAnXOn+lCv3Qu0UBRW9WdFbEaQkQh11U
 UcV1I4CULiarGhyawSrgV95Cqvg0dLKO76oeNpwYSp/44XhbmfK+f8q4YU/3tHHycyPe
 Q5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698131288; x=1698736088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XmK+RTj/FRggQksmsLuZAYu+Xr+N+hyD+GxtAcrimlc=;
 b=c27cSgD750LAi8CgB0mt9JNm4XxgF3TbshnN6JtJNJA3rYdS7S/JHTGs6BY2MwwwB4
 K2JlV5B6wzevZaOegq6vRVwjGmuSRAlOAqf5mCF/SeO+pkUsjkldl2G4LB2qnNXvUfkO
 qV5Xw3s6sL3Yy4mbKRuWSxxEOpXhkpCsF+mHPDchYyJk7C/06sCXHdEvAO7CiuVWg4Nz
 V6757jEK4c29duKudSObzHjKgDbrBGZg4enc5st1858N4DMOom8LPE1IyFWPqMRb1mtj
 npXd0OHmB5PXYbyMhE+xDAqe8+1n/2c+1kX8zAewA+DF/7R+RgD8Ssv9Jeh7HiWJGtYB
 Uyng==
X-Gm-Message-State: AOJu0YwhHTbc/Nq1t6j0j+HxFYUI6hHdnixDHVCPt2VqKjbRPJlqTlp2
 0u4m94+HmSKK22GPaP31t2/PAQ==
X-Google-Smtp-Source: AGHT+IHehJj0bMywxZp6KIn0kQzy5bCCZaVbJruY4WN3CnPAdiyo+0AnvDwSARB7JwTozHkt7S00Dw==
X-Received: by 2002:a05:600c:3583:b0:408:59d4:f3c4 with SMTP id
 p3-20020a05600c358300b0040859d4f3c4mr6681690wmq.10.1698131287756; 
 Tue, 24 Oct 2023 00:08:07 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b004053a6b8c41sm11195398wmq.12.2023.10.24.00.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 00:08:07 -0700 (PDT)
Message-ID: <4b2e68dd-db49-4041-ee5a-ae2b836bd255@linaro.org>
Date: Tue, 24 Oct 2023 09:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 02/10] hw/fsi: Introduce IBM's scratchpad
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-3-ninad@linux.ibm.com>
 <957bc5db-53aa-6946-edf3-3b728a52b660@linaro.org>
 <f2a50afd-3fa1-47d2-960e-0aaaf57c7cd2@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <f2a50afd-3fa1-47d2-960e-0aaaf57c7cd2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 23/10/23 19:08, Ninad Palsule wrote:
> Hello Philippe,
> 
> On 10/23/23 10:00, Philippe Mathieu-Daudé wrote:
>> On 21/10/23 23:17, Ninad Palsule wrote:
>>> This is a part of patchset where scratchpad is introduced.
>>>
>>> The scratchpad provides a set of non-functional registers. The firmware
>>> is free to use them, hardware does not support any special management
>>> support. The scratchpad registers can be read or written from LBUS
>>> slave.
>>>
>>> In this model, The LBUS device is parent for the scratchpad.
>>>
>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>> ---
>>> v2:
>>> - Incorporated Joel's review comments.
>>> v5:
>>> - Incorporated review comments by Cedric.
>>> v6:
>>> - Incorporated review comments by Daniel.
>>> ---
>>>   meson.build                        |  1 +
>>>   hw/fsi/trace.h                     |  1 +
>>>   include/hw/fsi/engine-scratchpad.h | 32 ++++++++++
>>>   include/hw/fsi/fsi.h               | 16 +++++
>>>   hw/fsi/engine-scratchpad.c         | 93 ++++++++++++++++++++++++++++++
>>>   hw/fsi/Kconfig                     |  4 ++
>>>   hw/fsi/meson.build                 |  1 +
>>>   hw/fsi/trace-events                |  2 +
>>>   8 files changed, 150 insertions(+)
>>>   create mode 100644 hw/fsi/trace.h
>>>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>>>   create mode 100644 include/hw/fsi/fsi.h
>>>   create mode 100644 hw/fsi/engine-scratchpad.c
>>>   create mode 100644 hw/fsi/trace-events
>>
>>
>>> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
>>> new file mode 100644
>>> index 0000000000..e65f26f17b
>>> --- /dev/null
>>> +++ b/include/hw/fsi/fsi.h
>>> @@ -0,0 +1,16 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + * Copyright (C) 2023 IBM Corp.
>>> + *
>>> + * IBM Flexible Service Interface
>>> + */
>>> +#ifndef FSI_FSI_H
>>> +#define FSI_FSI_H
>>> +
>>> +/* Bitwise operations at the word level. */
>>> +#define BE_BIT(x)                          BIT(31 - (x))
>>> +#define GENMASK(t, b) \
>>> +    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
>>
>> Please use MAKE_64BIT_MASK() from "qemu/bitops.h".
> 
> The GENMASK and MAKE_64BIT_MASK macros are invoke differently.
> 
> GENMASK is invoked with bit t and bit b (t:b) and it provides the mask and
> 
> MAKE_64BIT_MASK uses shift and length.

Don't we have:

#define GENMASK(t, b) MAKE_64BIT_MASK(t, b - t + 1)

?

> Thanks for the review.
> 
> Regards,
> 
> Ninad
> 
> 
>>> +#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), 
>>> BE_BIT(b))
>>> +
>>> +#endif
>>


