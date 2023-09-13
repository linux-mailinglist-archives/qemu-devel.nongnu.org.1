Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B852A79E88B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPW8-0000VS-Do; Wed, 13 Sep 2023 09:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgPW6-0000Sn-5B
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:02:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgPW1-0006G8-06
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:02:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso73785955e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694610162; x=1695214962; darn=nongnu.org;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QA8QumC1Q6UUp+DMPh/apBvf2M+RjN21PI86HZj4ZkU=;
 b=MJ3I4zuuN5Vpn3j5bfXrQ8yqj3+xuV2jz6r/ygg8qrPPj2DMfuFEFtRlGn1DV5p4/P
 nJumaFuNjDZ/i3HQxk3JESf/vkEU93ALMKlskQsJZDIQakQjLoDYnrksAroQAOj4C5JK
 xCu5zDcN9PcrSRwWEPpEYJdaWx0E8yyuX3d3Ga+JyYDi98/ArIhvTpkSni5Fj4Yw9x/X
 7nIedwP8maL8clFS9M81lmOP1nfaSad7YveHMHzOkTEZnBQHnhPrMqN6yCNrklSVfYQu
 S5zDR0bYZkh8OLh6Bdyn7KliJlhGWt70/FT0MQjVc3r/5mF/MhhADDs+hcG9V4zP1XqU
 oWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694610162; x=1695214962;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QA8QumC1Q6UUp+DMPh/apBvf2M+RjN21PI86HZj4ZkU=;
 b=jmtG+rfd4TM9cqD+m8+40jdd5ft5PIOAPVzju92pT2wnfGyVHvcbCYx1mIIwI/pGED
 XsV8HBiVWUUMBu+3JA9512216W4WO4fRll2scvW8399/o99T6xqf09a8/kW4sc76FHFe
 i0VOiZNG+Mxg0nE2w3opx0M0p4iL8qv4jEHyje59Eb+3LSQEzFkI35tcQBYAH7IgB+ik
 qvDDVcGZCvSl8+E3YP4RRmPyuZR7Mkd0y4oWuEALoXjP6hwm0N8F9bdY1LmpgXw/+FhC
 zaS08kPsEeNciIZHrsDE/D4hmu8yqkvKfaTNBc7qRc4zkOwpVnHg8wumO0Z2wHwXsfJS
 FdAA==
X-Gm-Message-State: AOJu0Yx1qti0BYeIiIc1az7tMF1WuatRW2nvSiVl7T3HhfxjuD3chZg+
 DfiJyNeWvduopgsYuKZoH4fWo3GmRyA=
X-Google-Smtp-Source: AGHT+IFQnrgT3DuxVAwIYkdPcbtxJ8VHsWr+CxhakH3m95QEJvVogNvejJa9jVffKbInuDHQrhgUXA==
X-Received: by 2002:a5d:6748:0:b0:317:7062:32d2 with SMTP id
 l8-20020a5d6748000000b00317706232d2mr2116321wrw.54.1694610161687; 
 Wed, 13 Sep 2023 06:02:41 -0700 (PDT)
Received: from karim ([2c0f:fc89:80a4:a16:ec3b:1041:e2b8:3030])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa7c0c8000000b00525503fac84sm7317599edp.25.2023.09.13.06.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 06:02:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org> , qemu-devel@nongnu.org
Cc: 
Subject: Re: [PATCH v3 21/23] bsd-user: Implement shmctl(2)
In-Reply-To: <20230909193704.1827-22-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-22-kariem.taha2.7@gmail.com>
Date: Wed, 13 Sep 2023 16:01:15 +0300
Message-ID: <877cou8bxg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Karim Taha <kariem.taha2.7@gmail.com> wrote:

This mistakenly has a `Reviewed-by` line, this is from v2 of the series
when I thought the implementation was correct, before you replied to
me on v1 series thread that IPC_SET does not need the VERIFY_WRITE,
I'm writing this so you know why I will remove it in v4.
> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-mem.h            | 39 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index 27d4e7f079..68f34b5d36 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -304,4 +304,43 @@ static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
>      return get_errno(shmget(arg1, arg2, arg3));
>  }
>  
> +/* shmctl(2) */
> +static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
> +        abi_ulong buff)
> +{
> +    struct shmid_ds dsarg;
> +    abi_long ret = -TARGET_EINVAL;
> +
> +    cmd &= 0xff;
> +
> +    switch (cmd) {
> +    case IPC_STAT:
> +        if (target_to_host_shmid_ds(&dsarg, buff)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(shmctl(shmid, cmd, &dsarg));
> +        if (host_to_target_shmid_ds(buff, &dsarg)) {
> +            return -TARGET_EFAULT;
> +        }
> +        break;
> +
> +    case IPC_SET:
> +        if (target_to_host_shmid_ds(&dsarg, buff)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(shmctl(shmid, cmd, &dsarg));
> +        break;
> +
> +    case IPC_RMID:
> +        ret = get_errno(shmctl(shmid, cmd, NULL));
> +        break;
> +
> +    default:
> +        ret = -TARGET_EINVAL;
> +        break;
> +    }
> +
> +    return ret;
> +}
> +
>  #endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
> index 52cca2300f..35f94f51fc 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -555,6 +555,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
>          ret = do_bsd_shmget(arg1, arg2, arg3);
>          break;
>  
> +    case TARGET_FREEBSD_NR_shmctl: /* shmctl(2) */
> +        ret = do_bsd_shmctl(arg1, arg2, arg3);
> +        break;
> +
>          /*
>           * Misc
>           */
> -- 
> 2.42.0

