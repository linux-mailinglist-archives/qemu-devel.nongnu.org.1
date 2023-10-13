Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56067C8CF4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 20:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrMg9-0004TW-Mi; Fri, 13 Oct 2023 14:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMg7-0004T3-SA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:14:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMg6-00007j-B1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:14:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b598eaf407so525382b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697220865; x=1697825665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fw91ChDt+rOcqpsYAbBMyeyFK8OsZN5cm1R+uomjBGw=;
 b=xIGglxRUyfzMEw+hp8WyVh+Kicjg3zA9Sj1VnRXrx4lLFOvnwiplQaqFxAIZFLmiom
 GEqAosGI/rj2PLe4fuTeQFXb022XspCEHArQXoptVlgmpI3bhAF+bp7CKcQy6YFHM97P
 3tPOdYMZCO0Mqh1gxl6vX7Q3tXl9rMPtBiPzJHcIfd6xFDBjWmtUKcfk8+MVx7rob/lL
 YJLqfjg7O5MKZaQEfinp+KbZBZiChMf7ff0j1D0LrnZvJh6efDItGmgC/6lrS8sIs5Te
 qkD1agT/6HIy/TMmrdhFwwqdo9UGB7hYR7pjijA4dJg1HfwwQS4RaHk0P76JseOYGv0r
 poaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697220865; x=1697825665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fw91ChDt+rOcqpsYAbBMyeyFK8OsZN5cm1R+uomjBGw=;
 b=FUfrDsTy7prQVRjLXeZkk34ki1r5j05kK+MjsjfDeA3v/qmPtJmMKiwQ2vcH+DADok
 LhSffI7I574PtTU3voyV1jsM38VkEzbzzXncso6q7uchFlLvCHe6RzZ9biaZEbXECMql
 7OXVU2jcJkMDZcTEImZKIFfagexU6R4U5unGNhGODU7CusGjOvupGULTNtbN5bq4s1//
 q2s7By/tsZSwSC7v4gh9d1NJSGtwyP1t2em791F6uZtF+dbkHC1N0PkbbuOJ4FsWlCRu
 QTCYoq8XdFHZnDkIEXRFqPCsdMr3Ert0VT8X9/DKll4As0DBWBTqTMTCJYeBmQv2M3mW
 F94A==
X-Gm-Message-State: AOJu0YxuQVFRM9l74HwKVaxHW/ramjC22LbGV37YcpywyazOiqEPHmhb
 Ra1Ub+dBYmQ0Lz2y6LE557SlxQ==
X-Google-Smtp-Source: AGHT+IHMbOsGt3IaMEehF2X0v9zMKUF9GjM1BYuxgVM1cOlWnpCX4IxChicef9+CEJ2B9JW2X5DL3A==
X-Received: by 2002:a05:6a21:191:b0:155:5c28:ea67 with SMTP id
 le17-20020a056a21019100b001555c28ea67mr34781275pzb.38.1697220864813; 
 Fri, 13 Oct 2023 11:14:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a63bf05000000b005894450b404sm3182968pgf.63.2023.10.13.11.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 11:14:24 -0700 (PDT)
Message-ID: <fb26bbac-e573-431e-a4b4-13ca65a24455@linaro.org>
Date: Fri, 13 Oct 2023 11:14:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/10] hw/char/pl011: Add transmit FIFO to PL011State
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
 <20231013141131.1531-10-philmd@linaro.org> <87edhylac2.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87edhylac2.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 10:05, Alex Bennée wrote:
>> @@ -487,7 +505,11 @@ static const VMStateDescription vmstate_pl011 = {
>>       .subsections = (const VMStateDescription * []) {
>>           &vmstate_pl011_clock,
>>           NULL
>> -    }
>> +    },
>> +    .subsections = (const VMStateDescription * []) {
>> +        &vmstate_pl011_xmit_fifo,
>> +        NULL
>> +    },
>>   };
> 
> Doesn't this necessitate the bumping of the migration version data or
> do we not worry about new -> old migrations?

We usually don't care about new->old, however:

If the fifo is empty, migration will still work because of the subsection.
If the fifo is not empty... I think the subsection will be ignored, with the only 
consequence being that some characters will be dropped.


r~

