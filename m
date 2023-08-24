Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F0F78787E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 21:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFxf-0001CT-8k; Thu, 24 Aug 2023 15:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZFxe-0001CK-0m
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 15:25:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZFxb-0000Ju-PF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 15:25:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf3a2f44ffso2283245ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692905138; x=1693509938;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fye8EqIMWPg5ovXPoyXqQDsFKdMe82l/qM2OOouaiSY=;
 b=vI51nm/pGcszmFhJ2ARTZQJd0RtnV92/c+ePcdiPkh5wCJl9fE1sWWdSUjZvNgtfG9
 Ml4m349CcHn4Hel6Qk8K2+495DQByftIsuh754nIkWzYqAyc5k+irFZttGaCjgQw8Tm+
 P4MpK0BxTef3Hun5DFYKZN96YD4zg3lfx7iR86zlj2E930kma6vjElmWu/yVdne7x85a
 lTSF7teLb+20OsiK6tOCc4LGYbwlSBTUCjUDhKcZKy2sMsshAp39V40T5/F4NWynxWHi
 Q+LiFrRBq2owo/wN9wNlMwtsFzk6SBKs7d7zNgFP2EpFidUfQ9WmkWm2mBTEX2y8x5jg
 43yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905138; x=1693509938;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fye8EqIMWPg5ovXPoyXqQDsFKdMe82l/qM2OOouaiSY=;
 b=NuM6BOhB8+ASQ5BCeWIM5yhN0+vb7V5ZzePACfuA6PhHlIY8aACE/CpYbSjuYW+VvR
 EVecRCIk3Oqyj5hMDWdwd/xdp2/caqogtbINHlLNfufUvJuXqnRFX/zqF0vzLLy/9u/u
 cBDDZtS9ddWTWKmNtwQBG70v47CORKbq/bNAL7HJn8f/yaGXaDqLxl1sSMx5aou5mtxk
 VAAai1aptIxgNxQqnW2UMVeGmHg63fCeD3yfOZx1z7NBJnz+3WimLkcMjQ15/GEJg+jq
 zYXwpVIE2+Di+LK1ZYl/uDyBrCu5sSmJDHGhiwPIipQmQU2P3/+LPrQee5g3tHm4Glam
 BcfQ==
X-Gm-Message-State: AOJu0Yxq/yE93SEAKcm80ZwfeKcV36F31M8ctCQtH6f3DiYz9a1U2ec4
 RFrtvKsn3XbMI5zoNqRpzK68ow==
X-Google-Smtp-Source: AGHT+IEjlgqSnYg8raSr+K0np5E6dHKAg3rcSqdtiYHevyfX8eY59evx6/zFPJlJ24PGZdRRO3Vk7g==
X-Received: by 2002:a17:902:f54f:b0:1bc:7c69:925a with SMTP id
 h15-20020a170902f54f00b001bc7c69925amr19667816plf.33.1692905138245; 
 Thu, 24 Aug 2023 12:25:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:5418:3064:bd46:c048?
 ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 jh15-20020a170903328f00b001bb7a736b4csm25164plb.77.2023.08.24.12.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 12:25:37 -0700 (PDT)
Message-ID: <38e847ca-03e2-6afe-dd3d-1e877f55794d@linaro.org>
Date: Thu, 24 Aug 2023 12:25:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/12] gdbstub: refactor get_feature_xml
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230824163910.1737079-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 8/24/23 09:39, Alex Bennée wrote:
> Try to bring up the code to more modern standards by:
> 
>    - use dynamic GString built xml over a fixed buffer
>    - use autofree to save on explicit g_free() calls
>    - don't hand hack strstr to find the delimiter
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - avoid needless g_strndup for copy of annex
> ---
>   gdbstub/internals.h |  2 +-
>   gdbstub/gdbstub.c   | 63 +++++++++++++++++++++------------------------
>   2 files changed, 31 insertions(+), 34 deletions(-)
> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index f2b46cce41..4876ebd74f 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -33,7 +33,7 @@ typedef struct GDBProcess {
>       uint32_t pid;
>       bool attached;
>   
> -    char target_xml[1024];
> +    char *target_xml;
>   } GDBProcess;
>   
>   enum RSState {
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 8e9bc17e07..31a2451f27 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -354,54 +354,51 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
>   static const char *get_feature_xml(const char *p, const char **newp,
>                                      GDBProcess *process)
>   {
> -    size_t len;
>       int i;
>       const char *name;
>       CPUState *cpu = gdb_get_first_cpu_in_process(process);
>       CPUClass *cc = CPU_GET_CLASS(cpu);
>   
> -    len = 0;
> -    while (p[len] && p[len] != ':')
> -        len++;
> -    *newp = p + len;
> +    /* ‘qXfer:features:read:annex:offset,length' */

This is misleading, because "...:read:" has already been consumed.

> +    char *term = g_strstr_len(p, -1, ":");

This is strchr(p, ':').

> +    g_autofree char *annex = g_strndup(p, len);
> +    /* leave newp at offset,length for the rest of the params */
> +    *newp = term + 1;
>   
> -    name = NULL;
> -    if (strncmp(p, "target.xml", len) == 0) {
> -        char *buf = process->target_xml;
> -        const size_t buf_sz = sizeof(process->target_xml);
>   
> -        /* Generate the XML description for this CPU.  */
> -        if (!buf[0]) {
> +    name = NULL;
> +    if (g_strcmp0(annex, "target.xml") == 0) {

Why the change to g_strcmp0?  There's no null pointer to be handled.
If you keep the strncmp, you don't have to allocate memory early.

>       if (cc->gdb_get_dynamic_xml) {
> -        char *xmlname = g_strndup(p, len);
> -        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
> -
> -        g_free(xmlname);
> +        const char *xml = cc->gdb_get_dynamic_xml(cpu, annex);

You can leave the g_strndup (and autofree) to here.



r~

