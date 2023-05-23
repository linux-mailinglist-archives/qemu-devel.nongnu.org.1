Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8714270DF03
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Sfl-0008Ai-7M; Tue, 23 May 2023 10:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1SfC-0007gm-TB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:07:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Sf9-0006by-5y
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:06:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3094910b150so6343698f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850813; x=1687442813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMOb2R2zYyVfu/V/xZbJP/Xhvnvfny+3vhB84aeFldQ=;
 b=ECcF47FDBM9xG20Jq4IlG6chWA/AC9vBWzr5H3qrTph3MzXZJ9HrAD7H2expcjmB0d
 ggLxODYhQ0GmTsWmd14MnP5LYeEEhMbAL+/wm/taPG8JYBpG+kore7J/roSj6qqbbQ1a
 DtrC+NXRQGpmfpDKDfiUPrUSWG/63o0ynOE1NTGUPbJMxs99EuaUTyREVfseuNt3kRGo
 JGGTdNgwPHcVXfq1aeHAVs4MN+YmtdLkRJKWK9+p1ZV8cuQ23O/N4pLz8j2eIu5WtJV/
 4QdPw1bBzPDRG9Fbmc/zU7T74cjSD804ZQXAD2Cq90LSPKg2GiPwrAvCXAYgBFnbdOeq
 n3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850813; x=1687442813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMOb2R2zYyVfu/V/xZbJP/Xhvnvfny+3vhB84aeFldQ=;
 b=cma4wS/v+ZEYbG2mZOxMWLsuLibypbtBWEN93V58ehbc+mBapO6hVrRYiy0JYWxjwC
 AVmylZ0W9LfhT52iD41NnUhkdsyIbTKm0/xmxpDLALTGvG3yUri3il8cDMdLfHwbOFzJ
 hhDVAY4tvbnjycHkRW9kNu09i200sx2fT6ft09PaOEgZ5GH8yWvDBnC5eD2nrlE3gBcF
 ahVqSu34+eeQRSqqjJcROPCdb5wGwDWQv6ha25ilDoxen2SMNUaYPnD5B6758c16AOFZ
 da6nKf8Keqdg1HiUBeDeR/5iVLq6A+bIcLvDKC/hnMYDL1AYQboOvYt77ruJ/IwU2lLw
 zO1A==
X-Gm-Message-State: AC+VfDzePiwFwrsAjuCLa/sWQZZpuvp1ygi5Wgu3aju8gPou5ZQt3loC
 nnYiIkbqjYs5PvfrriGuHiyNrg==
X-Google-Smtp-Source: ACHHUZ7EMEcEUBwiPC06xpPgy9gWJyEdA+jOEEOrIEKKm1kZcqjzqM7vGxfswr6MZ3zSOJLxVSbv6g==
X-Received: by 2002:adf:f305:0:b0:2f2:7a0e:5cc9 with SMTP id
 i5-20020adff305000000b002f27a0e5cc9mr11911342wro.19.1684850812754; 
 Tue, 23 May 2023 07:06:52 -0700 (PDT)
Received: from [192.168.69.115] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 m2-20020adffe42000000b002feea065cc9sm11161283wrs.111.2023.05.23.07.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 07:06:52 -0700 (PDT)
Message-ID: <b1f5c418-9b1a-4f38-3611-3d355e769b1b@linaro.org>
Date: Tue, 23 May 2023 16:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
Content-Language: en-US
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, jacek.halon@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
 <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
 <ZGx0ylB10aLWchuf@redhat.com>
 <8a9c7803-5c1c-3e68-6506-14eae205d11e@linaro.org>
 <CAA8xKjUN+Ru5h65YoTDg0trSUZg=L6iD5HF2AKNv-3wAt+ZtHg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAA8xKjUN+Ru5h65YoTDg0trSUZg=L6iD5HF2AKNv-3wAt+ZtHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 14:57, Mauro Matteo Cascella wrote:
> On Tue, May 23, 2023 at 10:37 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 23/5/23 10:09, Daniel P. Berrangé wrote:
>>> On Mon, May 22, 2023 at 08:55:02PM +0200, Philippe Mathieu-Daudé wrote:
>>>> On 9/5/23 09:13, Marc-André Lureau wrote:
>>>>> Hi
>>>>>
>>>>> On Mon, May 8, 2023 at 6:21 PM Mauro Matteo Cascella
>>>>> <mcascell@redhat.com <mailto:mcascell@redhat.com>> wrote:
>>>>>
>>>>>       The cursor_alloc function still accepts a signed integer for both
>>>>>       the cursor
>>>>>       width and height. A specially crafted negative width/height could
>>>>>       make datasize
>>>>>       wrap around and cause the next allocation to be 0, potentially
>>>>>       leading to a
>>>>>       heap buffer overflow. Modify QEMUCursor struct and cursor_alloc
>>>>>       prototype to
>>>>>       accept unsigned ints.
>>>>>
>>>>>       Fixes: CVE-2023-1601
>>>>>       Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc
>>>>>       (CVE-2021-4206)")
>>>>>       Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com
>>>>>       <mailto:mcascell@redhat.com>>
>>>>>       Reported-by: Jacek Halon <jacek.halon@gmail.com
>>>>>       <mailto:jacek.halon@gmail.com>>
>>>>>
>>>>>
>>>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
>>>>> <mailto:marcandre.lureau@redhat.com>>
>>>>>
>>>>> It looks like this is not exploitable, QXL code uses u16 types, and
>>>>
>>>> 0xffff * 0xffff * 4 still overflows on 32-bit host, right?
>>>
>>> cursor_alloc() will reject 0xffff:
>>>
>>>       if (width > 512 || height > 512) {
>>>           return NULL;
>>>       }
>>
>> I hadn't looked at the source file (the 'datasize' assignation
>> made me incorrectly think it'd be use before sanitized).
>>
>> Still I wonder why can't we use a simple 'unsigned' type instead
>> of a uint32_t, but I won't insist.
> 
> I can send v2 with s/uint32_t/uint16_t/ if you think it's a relevant change.

Specifying the word size doesn't really add any (security) value IMHO.

I'll stop bikeshedding here.

Regards,

Phil.

