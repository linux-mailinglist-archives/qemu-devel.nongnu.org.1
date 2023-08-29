Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2A478D079
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nE-0000ui-0O; Tue, 29 Aug 2023 19:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Az-00021D-6k
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:14:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Aw-0007Ke-VM
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:14:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso29702615ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693336493; x=1693941293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7WCCQn3ZCaI9D/2oRYWBhV3q4I3h9Elv+37zpcSKrY=;
 b=qkyWi7nNcfqp2AGyxNEpDvcdCFks+y9t551krSxPdkwFxMHpFgBpAQZ4wor+oan8Ln
 TiYyST+CGgYDRNqffIZFLOELtKlWWAY+hcSkMTI6cuL9hOrHlaQyu/lPlyxWvjEz+8rJ
 qY8v8itkFGLmuu2nO2ZWbphmWiV6a4+RYKPDWGyUrp6avAtuPMtTTQL+VMOkjmhtX5kA
 AyIdLFljEFIk7VBxJlQO4SSzuSzbTlJ+7U7xAGpL3PFR1DlMJSYU5L8JySe7qA4zk2G5
 G0ds7F/ASDy+e+Z/W5ZpJ3DjFCr5ycgrkky7EOAcWzU0XTMvJYpnyXj7HNIXqy8SKUNE
 gNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336493; x=1693941293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7WCCQn3ZCaI9D/2oRYWBhV3q4I3h9Elv+37zpcSKrY=;
 b=LBipuaPRL8JluUZK+lOqXdHDSnKsAFAre6ymWu63+M3jvAFae7mDz9paunwstu4EyC
 LK0oAQxW+cb/D2w9QReW34JGVWYF+hWPCKT/Z0HM+Qi/UfuX8PGUp/pNW3H7zl4m6qw8
 1lFRCMkLXwHYM0p4eZ1YYOM5NRGwHoBS9oSgP8ZTAyNca1s9V64nJ48HFopHjDoG00Qu
 IPk8fS+5NnKxqmJ52yKhmFLnhn5CIxbB9p1EIhVrUUfU1oHI3HzSQ1iCqIJ3mfbUeThy
 Ordm76l7mwDd5fddCAgu4Y6xcYygrqxxd4BzOo1czLoUBSH0sjxKT99DECDOm+RdFtjV
 V7ow==
X-Gm-Message-State: AOJu0Ywe+ptm9SOZtRHE4yTx7z1fKL/oazWAVSV8o9cN4kFzgH2GzkDc
 ac2lK+AdiH0Cf1SVAvYQMIP5Tw==
X-Google-Smtp-Source: AGHT+IHG2/ZKtN0FifLYUyLo2l+GXnBqAliAqXRFtWgJgIZD4YzdPcptKvc1XWPNDLj7oA4m83r76A==
X-Received: by 2002:a17:90a:bb87:b0:267:f329:947d with SMTP id
 v7-20020a17090abb8700b00267f329947dmr118102pjr.33.1693336493424; 
 Tue, 29 Aug 2023 12:14:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a17090a394400b002684b837d88sm10031484pjf.14.2023.08.29.12.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:14:53 -0700 (PDT)
Message-ID: <035844e7-ab74-f425-925f-1482edf001bf@linaro.org>
Date: Tue, 29 Aug 2023 12:14:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/32] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-5-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-5-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/main.c | 2 +-
>   bsd-user/qemu.h | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 381bb18df8..b94b2d34b6 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -88,7 +88,7 @@ unsigned long reserved_va = MAX_RESERVED_VA;
>   unsigned long reserved_va;
>   #endif
>   
> -static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
> +const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
>   const char *qemu_uname_release;
>   char qemu_proc_pathname[PATH_MAX];  /* full path to exeutable */
>   

Adding interp_prefix is unrelated.

Without that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 6724bb9f0a..23bbdd3e0c 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -113,6 +113,7 @@ typedef struct TaskState {
>   } __attribute__((aligned(16))) TaskState;
>   
>   void stop_all_tasks(void);
> +extern const char *interp_prefix;
>   extern const char *qemu_uname_release;
>   
>   /*
> @@ -251,6 +252,12 @@ abi_long get_errno(abi_long ret);
>   bool is_error(abi_long ret);
>   int host_to_target_errno(int err);
>   
> +/* os-proc.c */
> +abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
> +        abi_ulong guest_envp, int do_fexec);
> +abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
> +        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
> +
>   /* os-sys.c */
>   abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
>           abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp, abi_ulong newlen);


