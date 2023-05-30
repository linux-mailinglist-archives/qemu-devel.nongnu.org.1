Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2DB7162D4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zrx-000195-OS; Tue, 30 May 2023 09:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3zrr-000188-Jy
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:58:33 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3zrq-0002xH-3D
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:58:31 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5346d150972so3990107a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455108; x=1688047108;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c6gxx3XYEw1R0UESSFgF/8EhaZtTdOhlN1lo4gAPxoU=;
 b=eg2hJhBl8n+rbpf7O6JXNsgsFGRmSHDb2NJPJR9npgSLDfUx0JdC577UjKFoRftLki
 VmW6o4f9z3QTjKgsnvwZJHP9VNcZ6gwwDbx3A7J0zUmO4z5LZPFLsZ/UcX0sQtUVMyCR
 zxlxfUfHPN5nyLCLSpHvaV9cgwa6Ul+c5aoltCiXJDHjak+Wg+MW9il9sBnIG7YfxbyZ
 YpgLlWsSlbOLb2S6KiQmH7638w7QsIM4eLi4zwTI2jvyHjKm/5dp49fVWIQTbDNAtVUa
 L0JvMVVdMg8zTVPNxjg+8ciMhyAQa9eN7u5R9g4IK1TreBsRleDm5Ln8SmeWXX2XWgID
 wQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455108; x=1688047108;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6gxx3XYEw1R0UESSFgF/8EhaZtTdOhlN1lo4gAPxoU=;
 b=b4B6fflDWcdD6clhFmLf8thy6fS+DoZhmb90xuwAoMl5NWlyqpkv0NPGx4uLew3Vp2
 33EGWCIB0iN6TE4qFwjzJACNBrBQpo/xEmurM6BodG7Pr/jTHT7DZO0PgnSGqheDpCdA
 lspbtejDs6/AWmJZDVuT4OkpxJOigSSED8jegAi3kHiTEIBjKZ1RoVu53RjIGpRghx4z
 7K/X2nx8pEeI9FhZtN/SvzrTlNvj585S+tgtLpFO9aMsISv1GfJ1R0u1GXR8cfeNtbA3
 8Q9DKS+CFk4/KKCyErjHY6doBfzRUWQQ5xxtf/OuUb8cH42ETzlftkPf0gAzWpYgki4h
 2M2g==
X-Gm-Message-State: AC+VfDy8jHzXtXNv+sHOOsJr3tRerPyDnOwe2Iim2oK1rJPw2QLm4pbL
 ckF4WgT4ws0ThU4Qnw4PmLgH3g==
X-Google-Smtp-Source: ACHHUZ6WZgEh0c27yvE/yjFmeN2F/hwzRnCGGLIEUQfDbhYefplySw+cHcf6LXutKb722jSHXVP4TQ==
X-Received: by 2002:a17:902:d48d:b0:1ae:87d8:a0c3 with SMTP id
 c13-20020a170902d48d00b001ae87d8a0c3mr2618891plg.10.1685455108178; 
 Tue, 30 May 2023 06:58:28 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 p24-20020a170903249800b001b016313b1dsm8172430plw.86.2023.05.30.06.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:58:27 -0700 (PDT)
Message-ID: <5192c74b-38fb-7f2e-7b27-58d210c1b087@linaro.org>
Date: Tue, 30 May 2023 06:58:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-3-richard.henderson@linaro.org>
 <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/23 06:44, Peter Maydell wrote:
> On Fri, 26 May 2023 at 01:24, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> PAGE_WRITE is current writability, as modified by TB protection;
>> PAGE_WRITE_ORG is the original page writability.
>>
>> Fixes: cdfac37be0d ("accel/tcg: Honor atomicity of loads")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/ldst_atomicity.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
>> index 0f6b3f8ab6..57163f5ca2 100644
>> --- a/accel/tcg/ldst_atomicity.c.inc
>> +++ b/accel/tcg/ldst_atomicity.c.inc
>> @@ -191,7 +191,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
>>        * another process, because the fallback start_exclusive solution
>>        * provides no protection across processes.
>>        */
>> -    if (!page_check_range(h2g(p), 16, PAGE_WRITE)) {
>> +    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
>>           return *p;
>>       }
>>   #endif
>> --
>> 2.34.1
> 
> load_atomic8_or_exit() has a similar condition, so
> we should change either both or neither.
> 
> So, if I understand this correctly, !PAGE_WRITE_ORG is a
> stricter test than !PAGE_WRITE, so we're saying "don't
> do a simple non-atomic load if the page was only read-only
> because we've translated code out of it". Why is it
> not OK to do the non-atomic load in that case? I guess
> because we don't have the mmap lock, so some other thread
> might nip in and do an access that causes us to invalidate
> the TBs and move the page back to writeable?

This is about falling through to the cmpxchg below: if !PAGE_WRITE_ORG, then the page is 
really not writable, we will SIGSEGV, and handle_sigsegv_accerr_write will kill the process.


r~


