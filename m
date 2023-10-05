Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 885547B9B09
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoHaJ-0001UR-Fi; Thu, 05 Oct 2023 02:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoHaH-0001U8-ST
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:11:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoHaD-0007cJ-Ot
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:11:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405417465aaso5486295e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696486296; x=1697091096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m4GPXsJ7+UKwMykAAaZtnrZJ/T8btF/WLUUC540DywE=;
 b=oNBUv6O2Ge9/+a/g4tuS1EsazNJUmxWX5EElMSFW5kLDFMr/nCKPV57OtZEnQCkp4p
 14vLip0CtHFTYC1F7kgk1hG66B8k4uXHCqL/43QSAYW6fTS/bzbHpKuhmR9u0M5dJiUh
 upzySciv9xt3D/JEy6iW3fXr3gs/AxhA7USSNCNNtO9KfRVG6j9W2ALeI60+MhiwFREU
 jv+J7gQ4izdvXlNQX1ky3Z93ck6nUaRUcycIoOTCyAXrEUSKFMOR4s47MOF0PJZylCEy
 CeSbPZUniTUWs+5g6G6aagJze6yHKPlI0GKaovKaRYRskXHOLs3cXTVonJK3wkL7GD8y
 KcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696486296; x=1697091096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4GPXsJ7+UKwMykAAaZtnrZJ/T8btF/WLUUC540DywE=;
 b=aRbBlUd2ckdik/D0PI7z6RiLZPRead9LxFmDJ7l2Xn+gwVoMR8TP6W3FLEoZJHCmDP
 E9lHsC2BoeUuyAHWv6KjL48gvE1lsiPXg9vt+5IIHEEwBYUc7KpPwCpcq4mkOgKkqu7D
 dtQwIyjokXsU0T9i11RYXI0zk/nzPNoU5F7YMaECarkRgoN8L3djKyTGMfAQqevq4aMZ
 cR+1UWpDQarmm17jW/YOqPxW/0dhofqL61Yml6BAp/D7dd5JGnct95KNQaeJPqJ3QfNS
 UMUWHQ5AMSEF6pR+qctktD56Q5AmEv2mw6EwzYj3GlRPtX96qK6yyvXGIHveH8lwkzLw
 widg==
X-Gm-Message-State: AOJu0YzXqyT6DhSnfD2ErkaVR7mslKtCx5GDmQkDVQOzM1aC+6982btd
 rbX3xdzBDEiQW1ac51NcU5rMFA==
X-Google-Smtp-Source: AGHT+IEYpBlsjHtXyQWHLx+QToukbTnxCFHCxuT/c6lWxMfJv1nadQYirQuON6pZv6eUTrQknIiR7A==
X-Received: by 2002:a1c:ed07:0:b0:406:44e5:b915 with SMTP id
 l7-20020a1ced07000000b0040644e5b915mr4158104wmh.8.1696486295967; 
 Wed, 04 Oct 2023 23:11:35 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a7bc3cf000000b00401e32b25adsm745774wmj.4.2023.10.04.23.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:11:35 -0700 (PDT)
Message-ID: <f60f3687-d778-3d8e-41f6-39fbcad8f0f8@linaro.org>
Date: Thu, 5 Oct 2023 08:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 03/10] migration: Refactor error handling in source
 return path
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-4-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004220240.167175-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

Hi Peter,

On 5/10/23 00:02, Peter Xu wrote:
> rp_state.error was a boolean used to show error happened in return path
> thread.  That's not only duplicating error reporting (migrate_set_error),
> but also not good enough in that we only do error_report() and set it to
> true, we never can keep a history of the exact error and show it in
> query-migrate.
> 
> To make this better, a few things done:
> 
>    - Use error_setg() rather than error_report() across the whole lifecycle
>      of return path thread, keeping the error in an Error*.
> 
>    - Use migrate_set_error() to apply that captured error to the global
>      migration object when error occured in this thread.
> 
>    - With above, no need to have mark_source_rp_bad(), remove it, alongside
>      with rp_state.error itself.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/migration.h  |   1 -
>   migration/ram.h        |   5 +-
>   migration/migration.c  | 123 ++++++++++++++++++-----------------------
>   migration/ram.c        |  41 +++++++-------
>   migration/trace-events |   4 +-
>   5 files changed, 79 insertions(+), 95 deletions(-)


> -int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
>   {
>       int ret = -EINVAL;
>       /* from_dst_file is always valid because we're within rp_thread */


> @@ -4193,16 +4194,16 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
>   
>       ret = qemu_file_get_error(file);
>       if (ret || size != local_size) {
> -        error_report("%s: read bitmap failed for ramblock '%s': %d"
> -                     " (size 0x%"PRIx64", got: 0x%"PRIx64")",
> -                     __func__, block->idstr, ret, local_size, size);
> +        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
> +                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
> +                   block->idstr, ret, local_size, size);
>           ret = -EIO;
>           goto out;
>       }
>   
>       if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
> -        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
> -                     __func__, block->idstr, end_mark);
> +        error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
> +                   block->idstr, end_mark);
>           ret = -EINVAL;
>           goto out;
>       }

This function returns -EIO/-EINVAL errors, propagated to its 2 callers
  - migrate_handle_rp_recv_bitmap()
  - migrate_handle_rp_resume_ack()
which are only used in source_return_path_thread() where the return
value is only checked as boolean.

Could we simplify them returning a boolean (which is the pattern with
functions taking an Error** as last parameter)?

Regards,

Phil.

