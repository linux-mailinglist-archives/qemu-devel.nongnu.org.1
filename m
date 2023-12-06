Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E948077F0
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 19:47:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAwuV-0007SH-17; Wed, 06 Dec 2023 13:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAwuP-0007S7-FI
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 13:46:09 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAwuN-0002iU-Pp
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 13:46:09 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54917ef6c05so140060a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 10:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701888366; x=1702493166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Su2xQQSHHNe8yNEVqPneSo4rca810iZncERHMwaM/js=;
 b=paUmTYANvqNiFcJfzqv8VCewVhAlWKN3mY1fQ6Kr2nqTS1kfXiBDlvHKQVn6Ol50j8
 BwTXXjroCajVOGbDwJW1cBOu6N79dTTAzvwmZ5F5/jkE/DZpCApJOXXR8Hdtdsfcl32i
 7rOSJo82TbvBMcCH8o8YysiXTpxXZaMxMsUyz+6YqohHWrzVLmbloKSWjc1tU/1NLr2K
 WPNDwCbIYOMSPa6EQ59w6Us6TBhh/tP6/CXUyW1T/17FIPz6eR+/gZMRjX3HCBKkd1PP
 q/JJTNPpUh4OI1cP9mkrFizYE4bF9c4aoP+UxAGc5OxDxE5ZcnGJ4IzV+A+NI5WND/n9
 xhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701888366; x=1702493166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Su2xQQSHHNe8yNEVqPneSo4rca810iZncERHMwaM/js=;
 b=NKdj2wZn5vBV2fOYMEiI6zvCp4xotzPOlv1pe1jXl3/NY68kDpxfCKoVJG+13ISzaJ
 GxkjiE7MQdwDPTuNQ7NPwmds9PSPEqOpEulmnjCZucR9vSzl+SNKAP8PoGwbbz2JYci5
 fLbcg2M30xsY0HfyWDuS9uwXqaBPuMf31DTmgXyauZI79XmZUVe85/pmz33qP+aUlr62
 i1/BZ9CYKRaGIdlTBIAkYHm6xM0X7EL1/4EOBtY3o99SC93R4Xl1otYC7vqlOQwvmihS
 cCDDZZn13W3CflONqRWeX/2a1EapcWsfjEm8tyqyTOLPjSd/71p9wSDAXzI+PRakJTq7
 ucZA==
X-Gm-Message-State: AOJu0YyMvQ8qPwJmaZafEOpmP8MyUbITWI1L1p75/4ze+Jb267AVSF9T
 iX98iLYmajvD/N8YIst23cJNmg==
X-Google-Smtp-Source: AGHT+IFy7K2d9l3GjWiiK3a96rskc6TAj/o5xf2mbHbg7oTlo8G139maFiILU6zBXh3/PCokHdoVXQ==
X-Received: by 2002:a17:906:d96d:b0:a1a:8e58:9afa with SMTP id
 rp13-20020a170906d96d00b00a1a8e589afamr606245ejb.173.1701888365705; 
 Wed, 06 Dec 2023 10:46:05 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 um8-20020a170906cf8800b00a1d32353c87sm282771ejb.49.2023.12.06.10.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 10:46:05 -0800 (PST)
Message-ID: <2d6e4dec-bb04-46ea-bfa8-7006d8cc6dda@linaro.org>
Date: Wed, 6 Dec 2023 19:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 02/12] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Hi Steve,

On 6/12/23 18:23, Steve Sistare wrote:
> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
> have been paused, but the cpu clock still runs, and runstate notifiers for
> the transition to stopped have not been called.  This causes problems for
> live migration.  Stale cpu timers_state is saved to the migration stream,
> causing time errors in the guest when it wakes from suspend, and state that
> would have been modified by runstate notifiers is wrong.
> 
> Modify vm_stop to completely stop the vm if the current state is suspended,
> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
> Modify vm_start to restore the suspended state.
> 
> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
> cont commands.  For example:
> 
>      (qemu) info status
>      VM status: paused (suspended)
> 
>      (qemu) stop
>      (qemu) info status
>      VM status: paused
> 
>      (qemu) system_wakeup
>      Error: Unable to wake up: guest is not in suspended state
> 
>      (qemu) cont
>      (qemu) info status
>      VM status: paused (suspended)
> 
>      (qemu) system_wakeup
>      (qemu) info status
>      VM status: running
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>   include/sysemu/runstate.h |  5 +++++
>   qapi/misc.json            | 10 ++++++++--
>   system/cpus.c             | 23 +++++++++++++++--------
>   system/runstate.c         |  3 +++
>   4 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 88a67e2..867e53c 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>       return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>   }
>   
> +static inline bool runstate_is_live(RunState state)
> +{
> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
> +}

Not being familiar with (live) migration, from a generic vCPU PoV
I don't get what "runstate_is_live" means. Can we add a comment
explaining what this helper is for?

Since this is a migration particular case, maybe we can be verbose
in vm_resume() and keep runstate_is_live() -- eventually undocumented
-- in migration/migration.c.

  void vm_resume(RunState state)
  {
      switch (state) {
      case RUN_STATE_RUNNING:
      case RUN_STATE_SUSPENDED:
          vm_start();
          break;
      default:
          runstate_set(state);
      }
  }

Regards,

Phil.

