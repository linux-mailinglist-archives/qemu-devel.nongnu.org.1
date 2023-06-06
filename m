Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392977242A6
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6W1v-000603-HW; Tue, 06 Jun 2023 08:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6W0F-0005eQ-CB
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:41:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Vzs-0001M0-Bp
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:41:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f7e7fc9fe6so13908225e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686055244; x=1688647244;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I7nf1CGVlePKVW5sBui2fQlvjUpb6PlECLK1Pk5XDD0=;
 b=E+Z7NdE+giyUB+3YWdByoi0kiSD9XKSMrUbas1v/+isoZvKe+Xk7sNeSEBxWTqFyEz
 yuoCECwdkYy9Vguis4ssxpZyceCg7+i3KXtYiaXFG9Eq7JJ3/4zkwwdLj0yqpdnMVTza
 n6ZEPXZ3Ql4ySGtPE0OZ4QEi4tHmHY9bSVVwYWEDqejCOwgcg6nOpp7fWm35fE40eZbA
 1lmQy30qKheRDiGsbSLGTGYASpuJGMPmbZ+HetMryKQagRdwHAJOHeeJmX06wFM/6dr5
 gQgGg2F1EPT+/ZQKTJs8tTV3QYXzFaITlMMI/MPtB1tGfW5EbY1D0dy2M+cjQ6t/iDlg
 GZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686055244; x=1688647244;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I7nf1CGVlePKVW5sBui2fQlvjUpb6PlECLK1Pk5XDD0=;
 b=MN1UH8daJtqyn/nP37u4gg3CfDBVlj+qdUuNYz3VgpIdSGmzrjw1C8uxf7dZXpaRld
 vBEfJpcM5G94fvzJHg33MpjcxNObDoMTrk3CS245W+5NX+DYU26ZOjQyuLZQkwgwxZU1
 tOHSyRlYxvUfH9pE6wp/mrqneaqkIJhW7PhRSwcftCzLhLuhI4zJHDx6f0nWha0DNzxz
 mCOa3FuSI7V7yuWkueHpmmXpBx+bvk5lvdmxSnXS7EXAzSvkAT40bDiPOawY121pLUle
 P0tYISTiH8Snv5npytB5Yq9grBHYR/wTflbfXQ5qKvsIataLk9zMFVYdcFjcmsrdNnAK
 jp9A==
X-Gm-Message-State: AC+VfDwQBPGhYlgRCh4YaCLI8zBDyLUCYovZB9xzLFfcOonBgXF8uaHd
 IsRMMki+axBFL0SFeFTYtFQBwQ==
X-Google-Smtp-Source: ACHHUZ5rBAE+9gnX6pm4fGw31Vy8wj2iHVla425p1CcZ297VpVQfagvq9pJ8yxXTyQCjcnT+x7FK+A==
X-Received: by 2002:a7b:c8d0:0:b0:3f4:2737:a016 with SMTP id
 f16-20020a7bc8d0000000b003f42737a016mr2067653wml.29.1686055243941; 
 Tue, 06 Jun 2023 05:40:43 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 s6-20020a1cf206000000b003f60a9ccd34sm13910436wmc.37.2023.06.06.05.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 05:40:43 -0700 (PDT)
Message-ID: <a3b460c1-3741-ec26-8885-4e647073dfd8@linaro.org>
Date: Tue, 6 Jun 2023 14:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 10/23] q800: reimplement mac-io region aliasing using
 IO memory region
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-11-mark.cave-ayland@ilande.co.uk>
 <7d321bc5-c54e-3584-efd2-0c9401da8655@linaro.org>
 <24b2dd19-e002-d616-cf07-6a63cc18fcb2@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <24b2dd19-e002-d616-cf07-6a63cc18fcb2@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 08:33, Mark Cave-Ayland wrote:
> On 05/06/2023 13:43, Philippe Mathieu-Daudé wrote:
> 
>> On 4/6/23 15:14, Mark Cave-Ayland wrote:
>>> The current use of aliased memory regions causes us 2 problems: 
>>> firstly the
>>> output of "info qom-tree" is absolutely huge and difficult to read, and
>>> secondly we have already reached the internal limit for memory 
>>> regions as
>>> adding any new memory region into the mac-io region causes QEMU to 
>>> assert
>>> with "phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE'
>>> failed".
>>>
>>> Implement the mac-io region aliasing using a single IO memory region 
>>> that
>>> applies IO_SLICE_MASK representing the maximum size of the aliased 
>>> region and
>>> then forwarding the access to the existing mac-io memory region using 
>>> the
>>> address space API.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>   hw/m68k/q800.c         | 100 +++++++++++++++++++++++++++++++++--------
>>>   include/hw/m68k/q800.h |   1 +
>>>   2 files changed, 82 insertions(+), 19 deletions(-)
>>
>> Out of curiosity, is mac-io an I/O bus, rather than a MMIO device?
> 
> Well for PPC it is currently modelled as a bus, but having worked on the 
> q800 machine which is the forerunner to the integrated PPC CUDA/PMU 
> version my best guess now is that it is an MMIO device with partial 
> address decoding.

Hmm OK... Cc me if you find more doc in future work, I am interested
to understand.

Thanks,

Phil.

