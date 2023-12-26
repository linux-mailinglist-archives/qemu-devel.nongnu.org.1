Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55F81E849
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 17:10:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI9zJ-0007ZG-Ii; Tue, 26 Dec 2023 11:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9zD-0007YQ-O1
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:08:55 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9z9-0006lM-Pd
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:08:55 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d4a7f0c4dso36230825e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 08:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703606929; x=1704211729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DBWPiGtFuqC2aiKBd4yeGa77y5FiGVS86SZYT8DzTuU=;
 b=Wj26djiGQCCW2X71o2YbdyQfdij1sWExN3/+Se/cxK87doFERTfsw/agbxfQhqo1vn
 J68JM7RYBKWFKRMvRW6OExX0ZbeKSpHV55hy6ytac3ssp/WOn4TPzcGFc2FCUTGIYMmC
 AgbS9pzsIaoqk+XxEqyjoSK7w4a47EfDc7oGpTcGcTU990tkAWhfdQvoIaFCAebO7nOy
 qLes2SJ8+SdWFoOpfq9lFDWWpPyAkKT7rEsSFpalr+JdhqPBY/+JcdP2f0e/PY5b+ojo
 ymA8fF1vquOZ5NXNyNXUT8ir3PQ/YxMySXqk1lKuCm8lhLn/cyoVHbf8TLzK0UAFc0UR
 LAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703606929; x=1704211729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBWPiGtFuqC2aiKBd4yeGa77y5FiGVS86SZYT8DzTuU=;
 b=H7a0pdLUwinuW/KNqM8OwUGEo/C5qtca0tcoXFWVu9MngAALTQ03SiuNPLncAIqdJP
 Gp91rDgKcIpSH4FyxtyhxvRf+jOLyWOtOPmbMPgYofzrG70u1lqNLFbspdZrsCYOcWHq
 82adXfbzWl8xs6DSkW6EPmvSw57ve0/nXxy9iD4NuGc31LDB06znPZTq00dtcpCH6o1R
 hip56v/ELaVNLBTCEoiC/LZux1LQWyMnYiA6bNr+D4QsRaXY8vGPu9hoFpDXElkflxGK
 K9Knrpl5PoI69jDiw3R2IqNf5KDTthkYIeqnW3puYzt1Ko2k18kYE1VhpjMYXs1ZjTZl
 iYRw==
X-Gm-Message-State: AOJu0YwxMWkjoZdyot5s4zMqUtQPUNhTzyn0NCc00shlJyj4QtcBzy6F
 JJT6dayhqz0Ehho+Vhalo3LX9AwgTc5/CA==
X-Google-Smtp-Source: AGHT+IGoArMigrVjcDhP9RXE1kkmWjxKJ7YHv1p9Kg9GN9ayTtwxFXVwOtykB7sTgcGHWlQ9HdMg2Q==
X-Received: by 2002:a05:600c:46c6:b0:40d:542d:55b1 with SMTP id
 q6-20020a05600c46c600b0040d542d55b1mr2408767wmo.159.1703606929442; 
 Tue, 26 Dec 2023 08:08:49 -0800 (PST)
Received: from [192.168.88.175] (97.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.97]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm13252712wmq.16.2023.12.26.08.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 08:08:48 -0800 (PST)
Message-ID: <cfbb3a03-7122-41be-95c1-015ddd60592c@linaro.org>
Date: Tue, 26 Dec 2023 17:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/s390x/ipl: Remove unused 'exec/exec-all.h'
 included header
Content-Language: en-US
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20231212113640.30287-1-philmd@linaro.org>
 <20231212113640.30287-4-philmd@linaro.org>
 <a5560c21-658d-436c-a26f-87066b152d0a@linux.ibm.com>
 <1b0414d48d1798146f9a07ed1e6afdfbdd39b076.camel@linux.ibm.com>
 <e6411bed-dcd4-46fb-80eb-cf8ff89e90d0@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e6411bed-dcd4-46fb-80eb-cf8ff89e90d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/12/23 09:18, Christian Borntraeger wrote:
> Am 12.12.23 um 16:28 schrieb Eric Farman:
>>> So why do you think exec-all.h is unused?
>> I think because that got moved out of exec-all.h a few months ago, via
>>
>> commit 3549118b498873c84b442bc280a5edafbb61e0a4
>> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Date:   Thu Sep 14 20:57:08 2023 +0200
>>
>>      exec: Move cpu_loop_foo() target agnostic functions to 'cpu-
>> common.h'
>>      While these functions are not TCG specific, they are not target
>>      specific. Move them to "exec/cpu-common.h" so their callers don't
>>      have to be tainted as target specific.

Indeed, thanks Eric for justifying this patch.

> Ah right, I was looking at an old QEMU version....

FYI I tried to clarify a bit these header patterns here:
https://lore.kernel.org/qemu-devel/20231226150441.97501-1-philmd@linaro.org/

