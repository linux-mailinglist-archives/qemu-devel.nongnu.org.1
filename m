Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA4D7EF682
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:46:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41yY-0000RD-1D; Fri, 17 Nov 2023 11:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41yI-0000OY-Is
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:45:39 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41yD-0004xE-Hb
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:45:33 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ce5b7040e4so9657315ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700239523; x=1700844323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qJF8gcGwRUfTWvkCPsKgsURPSWOpt1+QK+9W1fzScFQ=;
 b=vvnO1P2fWcUNTWzNDZqQQWEXMIlOprJCBQOM5lvPkTfWXY8LCc6lN/AcnwUzN6u5L8
 WMwktNCOddvJQdRUKH7aMsc59KSlLVPmpp1nTBJF7szgNzqe4NIHxUomxykGi6++Ec4e
 CF2vnTwnXSLQ61vUSDDTxrdb99bzyGo3XdCGq3y/jFxBSrze1BuAXxXtn9g6ITaD4wr7
 RmAOtr60AyrKfRIrrlloVQ/xaLJqmyC/dyFmAPiBJ/DeVsgDsYyPIcbc3R02yPeD6GA0
 PtddKSwaC+UfO0GvgFdYUG8DLj7KptSjf+n4uOXPlHPk+o0PFXdAXeUbI9ojPL/+KOdU
 CptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700239523; x=1700844323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJF8gcGwRUfTWvkCPsKgsURPSWOpt1+QK+9W1fzScFQ=;
 b=d/J+1kKn65GXZdl9AzP1oJ3xZgW8zr2iSwogUyWbhHomYrUYx/vVrA7Dm7ZJtBwqQr
 exvX/eJPKiILQQKBhrrVIqyrp8z8oscA/xDd+9AMAt0aaRlcQja4vEROzS1aD8cZLagP
 lcIZ13OgYjI5vLgsvtbSjFKvCk96IqeCmwbRs9+9WAujwo8eDSzimm92W7Lvp1qCZIUl
 PVneZ7ukF1UYpSBnV1QQPvsRkXScN+iN4GhrfKKY9Gk0wDSfGi+LI10qUQTHXnokatzV
 vN5fNEcbvnezoFBQt7WNpMEjeT74nX0kPmNyyQ+VLwcwfpLa9cWOmLh90ZnmI12GQtnF
 D8WA==
X-Gm-Message-State: AOJu0YynID4B7/K6ZFm0//xm4euI4EsgnWPIPvVnqgnAS5b3IVQ7H4tq
 3vxZPIMPo0qDBThIq5AxIAvWEQ==
X-Google-Smtp-Source: AGHT+IGvDeScRvpp4/5k3kvna/37UhJOiFrYs7UZWhpidFsZbbUrSE9YwCjD9FNa+HbuGx4ORua9sg==
X-Received: by 2002:a17:902:e802:b0:1ce:5c8e:bd7e with SMTP id
 u2-20020a170902e80200b001ce5c8ebd7emr180509plg.26.1700239523227; 
 Fri, 17 Nov 2023 08:45:23 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a170902868300b001cc436e9806sm1587701plo.81.2023.11.17.08.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 08:45:22 -0800 (PST)
Message-ID: <6e256fa7-69eb-47de-a06b-f99d66318918@linaro.org>
Date: Fri, 17 Nov 2023 08:45:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] disas/hppa: Show hexcode of instruction along with
 disassembly
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20231117105309.149225-1-deller@kernel.org>
 <20231117105309.149225-3-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231117105309.149225-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/17/23 02:53, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> On hppa many instructions can be expressed by different bytecodes.
> To be able to debug qemu translation bugs it's therefore necessary to see the
> currently executed byte codes without the need to lookup the sequence without
> the full executable.
> With this patch the instruction byte code is shown beside the disassembly.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   disas/hppa.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/disas/hppa.c b/disas/hppa.c
> index dcf9a47f34..38fc05acc4 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -1979,6 +1979,9 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
>   	  if (opcode->arch == pa20w)
>   	    continue;
>   #endif
> +	  (*info->fprintf_func) (info->stream, " %02x %02x %02x %02x   ",
> +                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
> +                (insn >>  8) & 0xff, insn & 0xff);
>   	  (*info->fprintf_func) (info->stream, "%s", opcode->name);
>   
>   	  if (!strchr ("cfCY?-+nHNZFIuv{", opcode->args[0]))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

A possible improvement is to push this outside of the search loop and then change

      }
-  (*info->fprintf_func) (info->stream, "#%8x", insn);
+  info->fprintf_func(info->stream, "<unknown>");
    return sizeof (insn);

so the byte decode is shared with the rare case of garbage in the insn stream.


r~

