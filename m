Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B15712F30
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2fJu-0006TX-CD; Fri, 26 May 2023 17:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2fJq-0006Su-0i
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:49:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2fJo-0004YT-Dy
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:49:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1afa6afcf4fso11869805ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685137791; x=1687729791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BxdlGNIiG/llrzKs0xr+e1lM3UVjNt/k+Sw8eCfwUEM=;
 b=TeUSMDW1WIH2j88zbxAj8Sr4Tl6QI6hYulyngD1XfL+LfID5gtM9xHg770LZ5I6QcS
 APtW9jn/OOpfD57zXrfhDTPRl+WmE2bN2cwvaDCrjRO+FRqxq3lC7KKU95gzeus4wHp1
 EolxnMLNuwsN0sxJJsYy/RnOXVua83pvcIxBfRVHa5UfMVp5AIJTawfNhFqw/aueBuaf
 6A1wnxt0O8C4nBV8V49Tm1rfz+w+WDvV9LdxJFHiamOAj8r6QNreCPviW8b2E583ogGP
 kqXD2O3+VmFLCnuLai/nebTXnft7oVYWqaRIE1+r2QeSHcbXG2QK2p/pGjubFuT/dyJu
 q4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685137791; x=1687729791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BxdlGNIiG/llrzKs0xr+e1lM3UVjNt/k+Sw8eCfwUEM=;
 b=ETargp7UpQOgjVN8ezBq4pPBasLoL2ZGRaBkW6wtNshmAeE7m2vvnS8QnuaC6nIEIc
 bBUZBsEfBRTqCLUM5OtPhrjFvzyIW7RF39Q+LQisjrFDiVCCwakGBMSFD9czBOEWAWPl
 mo3cmRk74qpim//NzKddL8JLOX8pcJvLD/DzeJa8U82lW6fSQ+S7MTyF+UyeCNQmwYc8
 NjBqKq14GHFIVqcNiWpMWG5VFXguYj+GWwIiDlbYwmFghx3x7IetdqdA4tzNCsWNtxmC
 YFHkWY2kXfsyb5RFoiaphsmi+veQr3yqEeVRXVnYko8GOrh9Aoym0TFWtXAB72mlu8LW
 raOA==
X-Gm-Message-State: AC+VfDw9HN/Y8TJARf90Kroilqhq+fmXRJPAoQqC8FBUCQqEZv4/DbEL
 Fj8PIt3B9LtFaFH6RP6QJaNJZDqFIAp18rWGafA=
X-Google-Smtp-Source: ACHHUZ5bTyME8s8s4uyuEti/0fYHXO8Ws3t+nWy07doL/yG8VNrzwVMSn1LgqUvB7wK3rOlbXHneXg==
X-Received: by 2002:a17:903:442:b0:1ac:5382:6e24 with SMTP id
 iw2-20020a170903044200b001ac53826e24mr3887721plb.10.1685137790824; 
 Fri, 26 May 2023 14:49:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a170902969800b001aafe4f9b8esm3665720plp.180.2023.05.26.14.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 14:49:50 -0700 (PDT)
Message-ID: <036fdefe-7094-770b-5a83-02c8d44f688e@linaro.org>
Date: Fri, 26 May 2023 14:49:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] decodetree: Do not remove output_file from /dev
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230526174005.1801043-1-richard.henderson@linaro.org>
 <CAFEAcA_PWUB-+qRLMzqtwPsegSzs73N5sFryj4GGcBU9b0OWrw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_PWUB-+qRLMzqtwPsegSzs73N5sFryj4GGcBU9b0OWrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 12:52, Peter Maydell wrote:
> On Fri, 26 May 2023 at 18:40, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Nor report any PermissionError on remove.
>>
>> Previously we were testing with "> /dev/null", but that's not easy
>> to do with meson test(), so we want to use '-o /dev/null' instead.
>> That works fine for all of the existing tests, where all errors are
>> diagnosed before opening the output file.  However, PMM's named field
>> patch set diagnoses cycle errors during output.  This is fair, but
>> we need to be more careful with the remove.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   scripts/decodetree.py | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
>> index e4ef0a03cc..a9a0cd0fa3 100644
>> --- a/scripts/decodetree.py
>> +++ b/scripts/decodetree.py
>> @@ -71,7 +71,12 @@ def error_with_file(file, lineno, *args):
>>
>>       if output_file and output_fd:
>>           output_fd.close()
>> -        os.remove(output_file)
>> +        # Do not try to remove e.g. -o /dev/null
>> +        if not output_file.startswith("/dev"):
>> +            try:
>> +                os.remove(output_file)
>> +            except PermissionError:
>> +                pass
> 
> Maybe rather than hardcoding /dev, only try to delete the file
> if it's a normal file, i.e.:
>         if os.path.isfile(output_file):
>             os.remove(output_file)

Good idea.


r~


