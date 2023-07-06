Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F247A7498EE
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLnn-00060c-3W; Thu, 06 Jul 2023 06:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLnd-0005zs-Qc
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:01:26 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLnb-0007nJ-Lt
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:01:21 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51d8fa4dbf9so729496a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688637678; x=1691229678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PmJ9kX2DTGHZqmjdarmdLuh8fHTUVodEfNtmyBD+GRI=;
 b=YBBDg4r9wKCSLz6DHHeATx22MTLh0yTrPFjR/OnqbC4AHIhd30MM3obuH5ne5WZhzW
 tYwcHn0d04FkrdZNozke9S0T3GLWg/dx9LhEz1dkXdXmRTLRpyF3wEyiLNJwo+njJIW/
 oFOWKX+4YN4zu0FA6+25aGXXLa9iMCHCsqKwb/V6tIijTtaiL8A4ZmcjUvQUUSc1tmbH
 osruRaV4HmKWA5h9y/qLVxyWgQTxSoVa2rmjl27UQLtvfMjwInkJfIRI3+j90gNBuvBn
 VYlk8ZSvPDk7vcMkgiju6OFOBg9rH+1S+aO+ifsCF8HvekQ2YT1tT3oofofX3+0hc2U3
 0I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688637678; x=1691229678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmJ9kX2DTGHZqmjdarmdLuh8fHTUVodEfNtmyBD+GRI=;
 b=KWUkOGclrf6AujVnZrR4ReThubUzMWvqSE8GSxuxM5EWmZrBXw1SXtH5UK+MgwwqeR
 M1dAmX6HOfpd+Plcz2Ho01rOt1C1VbhZ4sMaiYksXzV2ORxWJp+y0HPOCrSkI7IuPmSw
 QG4laiUMf9AFQ9Q0lQMtceapDyM6eo4RW3M2icgHzGj+rEtAy4qfBq9g1y7UDoohEfLe
 46fchHgdmQQdTDfWC2hczq+tLTDY4IneyxikWAbczDurAef77ZF9Lz89VE0Rs6zPPFaq
 Q9RIpiaccT+sikSLfhwNUl5AaSLh1ol/dKXi8dslPseNnKFT1RqBviJ8qDBLtS4qDjl0
 6GOg==
X-Gm-Message-State: ABy/qLYPT7piPgvKg9r78CEKfWCzIVEQUuEKcqTXt40m4u0YJPJccR4g
 CkJQ2TOm/86aNYdE3B0FPFY6og==
X-Google-Smtp-Source: APBJJlGXctsnA2MJ2ukRe2Sr5WWMHL1egbTg+W4Ejpz+0MeFn27vipCINSE8Kjom8PNhF1bun63FBA==
X-Received: by 2002:a17:906:164b:b0:98e:2b01:ab97 with SMTP id
 n11-20020a170906164b00b0098e2b01ab97mr983415ejd.68.1688637678019; 
 Thu, 06 Jul 2023 03:01:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 br17-20020a170906d15100b009930c61dc0esm600796ejb.92.2023.07.06.03.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 03:01:17 -0700 (PDT)
Message-ID: <d5f8bc76-7cd5-a389-338d-53687ad76cdc@linaro.org>
Date: Thu, 6 Jul 2023 12:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>
References: <20230705141205.525776-1-kkostiuk@redhat.com>
 <20230705141205.525776-2-kkostiuk@redhat.com>
 <413a30a2-c050-7587-8c0e-a6d89c8b7ab3@linaro.org>
 <CAPMcbCp2Rx4jz3S9R8VbaeRZrkakn4HE7e-GZtubv5b29Km1OA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAPMcbCp2Rx4jz3S9R8VbaeRZrkakn4HE7e-GZtubv5b29Km1OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 6/7/23 09:54, Konstantin Kostiuk wrote:
> Hi Philippe,
> 
> On Wed, Jul 5, 2023 at 11:35 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     Hi Konstantin,
> 
>     On 5/7/23 16:12, Konstantin Kostiuk wrote:
>      > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>>
>      > ---
>      >   qga/vss-win32/vss-debug.h | 31 +++++++++++++++++++++++++++++++
>      >   1 file changed, 31 insertions(+)
>      >   create mode 100644 qga/vss-win32/vss-debug.h
> 
> 
>      > +#define PRINT_DEBUG(fmt, ...) {                                 
>                   \
>      > +    char user_sting[512] = { 0 };                               
>                   \
>      > +    char full_string[640] = { 0 };                             
>                    \
>      > +    snprintf(user_sting, 512, fmt, ## __VA_ARGS__);             
>                   \
>      > +    snprintf(full_string, 640, QGA_PROVIDER_NAME"[%lu]: %s
>     %s\n",             \
>      > +        GetCurrentThreadId(), __func__, user_sting);           
>                    \
>      > +    OutputDebugString(full_string);                             
>                   \
>      > +    fprintf(stderr, "%s", full_string);                         
>                   \
>      > +}
> 
>     Why not simply use a plain function?
> 
> 
> I am not sure what you mean.
> 
> If you mean to call OutputDebugString directly, then we need to 
> concatenate the proper string
> for each call.
> If you mean convert PRINT_DEBUG to function, then we can't use the 
> __func__ macro in
> PRINT_DEBUG to get the real function name. We can convert PRINT_DEBUG to 
> function
> and a new macro that will call PRINT_DEBUG and pass a proper value of 
> __fucn__.
> 
> What solution is better there?

   void qga_debug(const char *funcname, const char *fmt, ...);

and g_strdup_vprintf()?

