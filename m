Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B674A273
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:49:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHS9o-0001TW-06; Thu, 06 Jul 2023 12:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHS9j-0001Sm-PD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:48:37 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHS9h-0007rL-Gl
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:48:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-98dfb3f9af6so119686866b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688662112; x=1691254112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L0HzlOzklQ/lpmOgOi4D1s7HSzUJnEK/3w6PMa0p1s4=;
 b=UN3+7UKPay+pr0DLdmgL6LUi993pG+X/d4NM4zMHriUNDonJV5nK1jKFJ2gtR/9PRw
 wdCLTKKkpi4UTphrA4h3RuL2xVjxnmuD2Ufq1SpCMSFankKNAL61p7Ir5qzjUI3cMKh1
 hni/rgqY7IuNeNAXxeOplADFPp2KMfWUkF77EHbl7O/Pou613kJb0b2ftG+A6+8vjzWQ
 iTWAiKGqW4m236pBYgqwJ9O2A4IIIMFheKqqD0/TEvyBig4BoVrHpOrD360moZhpS2Gg
 /piGylpmsLkcyO4cAUx5zzDEC/vB3v81Rqv5JhKMSSWFuMC76YuHxwZUTHj9GQcngJgn
 cWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662112; x=1691254112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0HzlOzklQ/lpmOgOi4D1s7HSzUJnEK/3w6PMa0p1s4=;
 b=VdVn2f4gfEieaHUaDLmnw7Qot8xQNN33yg/Y2WGtkFR7JV8haP0uojl1Hy46lccrRc
 cyLiOMiY1XyCp3BzZDZi9tcQ8688NaDj7bJDHt9c+5IVgw9prdVXLYpVpJbSq/lXrMS+
 AUng5yuhN/ufGPprT3Fg7K9lRNHQ29LoCyNKqY3NXbD/ousYT/9ucTbGR9qo53rKWOW9
 CF0D8y8XQytMIM/TziEzcEZBuHkBHVJSBxKFdbDbmGiciBfwAIcq4UMcqGVcZ8dyNEYn
 BREdXW/GCimBnfz1o/QAx7yzISl6qeRA66E+FDIVx+4A5WfuBB0mlr943mSUhTFaLHyT
 CyWA==
X-Gm-Message-State: ABy/qLYmcqCo4HMTWOInTxkoW/KIjojDiyZd6frt5Zs0fUDVH3LBoZI5
 28iaEa4BezHlILjWuX9NEbd49g==
X-Google-Smtp-Source: APBJJlGFA5Scv2IdCEJOT6/wzgq9eq+cIzLfFYb+ZKkFiUHxWxVXE3Sf2HA/33/yZRFFh0rhdLJksg==
X-Received: by 2002:a17:906:1d8:b0:988:7428:2c25 with SMTP id
 24-20020a17090601d800b0098874282c25mr2171836ejj.5.1688662112075; 
 Thu, 06 Jul 2023 09:48:32 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a50ed8d000000b0051e362db186sm283597edr.60.2023.07.06.09.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:48:31 -0700 (PDT)
Message-ID: <9ed32d1a-5a8e-97b3-e38b-ef9f3df92f38@linaro.org>
Date: Thu, 6 Jul 2023 18:48:29 +0200
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
 <d5f8bc76-7cd5-a389-338d-53687ad76cdc@linaro.org>
 <CAPMcbCpwWj3YOnxzofnirvDi1V1oJvds+CDjpb+ib5_SCawvTw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAPMcbCpwWj3YOnxzofnirvDi1V1oJvds+CDjpb+ib5_SCawvTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/7/23 12:58, Konstantin Kostiuk wrote:
> 
> 
> On Thu, Jul 6, 2023 at 1:01 PM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     On 6/7/23 09:54, Konstantin Kostiuk wrote:
>      > Hi Philippe,
>      >
>      > On Wed, Jul 5, 2023 at 11:35 PM Philippe Mathieu-Daudé
>      > <philmd@linaro.org <mailto:philmd@linaro.org>
>     <mailto:philmd@linaro.org <mailto:philmd@linaro.org>>> wrote:
>      >
>      >     Hi Konstantin,
>      >
>      >     On 5/7/23 16:12, Konstantin Kostiuk wrote:
>      >      > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>
>      >     <mailto:kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>>>
>      >      > ---
>      >      >   qga/vss-win32/vss-debug.h | 31
>     +++++++++++++++++++++++++++++++
>      >      >   1 file changed, 31 insertions(+)
>      >      >   create mode 100644 qga/vss-win32/vss-debug.h
>      >
>      >
>      >      > +#define PRINT_DEBUG(fmt, ...) {
>      >                   \
>      >      > +    char user_sting[512] = { 0 };
>      >                   \
>      >      > +    char full_string[640] = { 0 };
>      >                    \
>      >      > +    snprintf(user_sting, 512, fmt, ## __VA_ARGS__);
>      >                   \
>      >      > +    snprintf(full_string, 640, QGA_PROVIDER_NAME"[%lu]: %s
>      >     %s\n",             \
>      >      > +        GetCurrentThreadId(), __func__, user_sting);
>      >                    \
>      >      > +    OutputDebugString(full_string);
>      >                   \
>      >      > +    fprintf(stderr, "%s", full_string);
>      >                   \
>      >      > +}
>      >
>      >     Why not simply use a plain function?
>      >
>      >
>      > I am not sure what you mean.
>      >
>      > If you mean to call OutputDebugString directly, then we need to
>      > concatenate the proper string
>      > for each call.
>      > If you mean convert PRINT_DEBUG to function, then we can't use the
>      > __func__ macro in
>      > PRINT_DEBUG to get the real function name. We can convert
>     PRINT_DEBUG to
>      > function
>      > and a new macro that will call PRINT_DEBUG and pass a proper
>     value of
>      > __fucn__.
>      >
>      > What solution is better there?
> 
>         void qga_debug(const char *funcname, const char *fmt, ...);
> 
>     and g_strdup_vprintf()?
> 
> 
> 
> I agree about the qga_debug function.

Alternatively:

#define qga_debug(fmt, args...) qga_debug_internal(__func__, fmt, args)
void qga_debug_internal(const char *funcname, const char *fmt, ...);

> About g_strdup_vprintf I am not sure. Currently, VSS uses only one 
> function from GLib (g_assertion_message_expr).
> In the past, we had problems with GLib due to mistakes in Windows 
> implementation and we thinking about
> removing GLib from VSS at all. As VSS.DLL is also invoked directly from 
> Windows, we should use standard
> C++ types in public functions. We can use GLib types/functions for the 
> internal part of DLL, but I think it will
> be confusing.

OK, then vfprintf/vsnprintf :)

