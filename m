Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C942B7F3687
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:53:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5VrP-0002XU-9X; Tue, 21 Nov 2023 13:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5VrJ-0002Uy-LR
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:52:30 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5VrF-0007m6-HY
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:52:28 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1f94b07b6b3so1141783fac.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700592743; x=1701197543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+G+BY9ETnlElcUd6mgXcxGpvhtWSeNwcm0URAYlHaU=;
 b=xW2toLJDVMSjo0AlQmCa11dwGGAf8UA2Q7vkczg/Liy/pqnFnyJyLtzQ0SxcOZ5nKW
 8J1f6IBcIBLzJ3Azi8BRGjEJtHRwMAmdheXmQpK6WV3biLxMUyrxUCnJg87xsOE/lyLV
 5Z2aIYvUBsUrNASfS87SfmYk/cMlPZtlD+51hiDEXVLJQH96RwOpZwKgUjQOIIwdnJoJ
 47FUNdXp/fv7uD1yy1sRQXc4wBdyZiKa360TMaOHFBW58stxx9A97TQCdDFtiyrmLCV0
 axk40hZ8vIqsX0Jt0S/pw5dFJxphWDitcY+icelH+eYOMWa1sPeHMFZ7iPQjH9om5hzd
 9A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700592743; x=1701197543;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+G+BY9ETnlElcUd6mgXcxGpvhtWSeNwcm0URAYlHaU=;
 b=WAHqrj4Qu1FBENdimLzm9cQz+kf6wxFyarsqJzW4FRvX/6yhYcjfisZgN+aRLa9888
 dPGmxnTlKWW7Odg58HUCCczjnlOHAb1g7msuOyn2YJRXansV3gKMaSEPTFyyY6K3gG6s
 6lKEEWBu6q6f9jmOOSXMzMzMoollP62r7bxb+mS/85x4/j3/AtDgNHHoozNWn3NwnPqp
 cNl58+jdI0rm5RJ9kNDmrQbjPtcw7wNvj4xsnlM+vxvx/2LukMQWauQw5SuEOBQgJUw+
 HGXc3MBAjvHQRqtwReer60V/jqtJQfKwx/U+QZSWz0nofnU8LCibU3w0uQKXxauhQssn
 TBhQ==
X-Gm-Message-State: AOJu0Yw97jOXmYOjCfW0kRMFF5A+hGp0qUGzZcTB8NU4U3shSTzC9/1V
 ayHV415CXyZYEM3AzTBMhGfTsA==
X-Google-Smtp-Source: AGHT+IFDZH+n4uKkpzj3ajSDZI3oggc1CRWT4+Xjymm9zwNbg0b7NpcGzg4RTZho5A2wAvHv7FWTkg==
X-Received: by 2002:a05:6870:3910:b0:1f5:c751:e7b1 with SMTP id
 b16-20020a056870391000b001f5c751e7b1mr178980oap.45.1700592742799; 
 Tue, 21 Nov 2023 10:52:22 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a056870a3c500b001f94a466974sm689197oak.41.2023.11.21.10.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 10:52:22 -0800 (PST)
Message-ID: <60d64320-8fd2-4cf3-acb6-ed758c1ff465@linaro.org>
Date: Tue, 21 Nov 2023 12:52:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/25] memory: Simplify
 memory_region_init_rom_nomigrate() calls
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-5-philmd@linaro.org>
 <958391d5-b1b5-43bf-b3d1-a6071e77b5cd@linaro.org>
In-Reply-To: <958391d5-b1b5-43bf-b3d1-a6071e77b5cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 12:50, Richard Henderson wrote:
> On 11/20/23 15:32, Philippe Mathieu-Daudé wrote:
>> Mechanical change using the following coccinelle script:
>>
>> @@
>> expression mr, owner, arg3, arg4, errp;
>> @@
>> -   memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp);
>>      if (
>> -       errp
>> +       !memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp)
> 
> This coccinelle script doesn't quite match...
> 
>> @@ -3628,11 +3628,8 @@ void memory_region_init_rom(MemoryRegion *mr,
>>                               Error **errp)
>>   {
>>       DeviceState *owner_dev;
>> -    Error *err = NULL;
>> -    memory_region_init_rom_nomigrate(mr, owner, name, size, &err);
> 
> ... this?

I'm sorry, it does.  "expression errp" can match "err".
It's the manual local variable removal that threw me off.


r~


