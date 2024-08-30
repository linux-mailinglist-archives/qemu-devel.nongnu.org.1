Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282FB9654E2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Aug 2024 03:55:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjqqW-00085H-FN; Thu, 29 Aug 2024 21:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjqqV-00084o-Db
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 21:54:39 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjqqT-0001Du-NT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 21:54:39 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39d29ba04f2so5419555ab.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724982876; x=1725587676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LsiPnoZUwtAC9MF6+foD6fQyvbYyfnwyKY00ReEe34k=;
 b=qm6eoGbi1FZGOWhSbV5DhGeN1ZdAmsytBmGPpUm3oVOxdhSBEmSDlY8xuep1+hepLf
 Laf3MIdarCl36dzE0UFf8nkTf0LVjEpYtXQYCAO1Lw2wJFZ9G+ladlP64Cw6QIkpdXm/
 hNrBrJSWtvuOErRdxzrtvEhlR9Nohk7jUSp98Y+d425TFGte20UrneFcZwH2irpAdC3O
 5XzW/g9zy1DVWfDG5h4ScutbUJw78CGeqfP8KwoRpenZJpkaYwOYPyYs+NItkkTLVmUl
 hR4x7ogaz0O1MytZ6g7uqFBcneGeY2Wy8iak5n2lPWLGoxWqH8wWvifVhfshh25T570N
 kqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724982876; x=1725587676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LsiPnoZUwtAC9MF6+foD6fQyvbYyfnwyKY00ReEe34k=;
 b=qXmjpi/1vIfpIQfXU/KFK8xclcD1OGcYNP+hhVHXrUHeZsKsRrNhJ30C8PAeDqpcuI
 u/7Yc0lqj6wrwFZYpd+dPCA/poKSkzEhivPHjD1UIQ2IWCfJOGFyAikLelPdZFAv7nEC
 lXnjNAuGSp/O9/+5qThlr7q78c3mJ/OdHNqthk7lVSk8ZEhrvtCNc0lftGBrdcXamyHQ
 AaNmXWTI3Gk0dZYqOoCy5IRcguBDR0wrlYCc9MCFTSPhSMKGOtsj/8B2ZWHbP5AyWvEG
 6KWjOGyPT3TNtZlraqf8opirCojeUCJjbX0KRdlgmqoDxFvvFXd8YT4l2ragM5qbdEz3
 6kEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/uDJbR9N9lkfC/NQmoLKhuLVIJ8ovBtys1lGIkl9cUJ4HEpG1u+4SfBXE+niAsZp8Lv58TO9zwntI@nongnu.org
X-Gm-Message-State: AOJu0YzfVsWLtquZZOQCQ0FA2hPv0uMwDkplRYWq8FB1nlskzIdf/aNw
 KBDMIurxDdjGwmyzRrqvdTAw34M7cfcgQGpQzbnqWyyzwNR+p1WNplLN0CFNtTI=
X-Google-Smtp-Source: AGHT+IE21Nf/f2UCeJHNF2jdQsPoGZpQx+irPUXC/fWWk0iUOnEydWOnPSHZl+wGsQejuaa/QwEHAQ==
X-Received: by 2002:a92:c243:0:b0:39b:3a63:6dfd with SMTP id
 e9e14a558f8ab-39f377ce50amr59299075ab.1.1724982875980; 
 Thu, 29 Aug 2024 18:54:35 -0700 (PDT)
Received: from ?IPV6:2001:8004:5100:1c02:35b7:18d3:3fc5:9f02?
 ([2001:8004:5100:1c02:35b7:18d3:3fc5:9f02])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e774382sm1892359a12.24.2024.08.29.18.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 18:54:35 -0700 (PDT)
Message-ID: <6cfdb895-d13b-42d6-baad-1ee6022b786c@linaro.org>
Date: Fri, 30 Aug 2024 11:50:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] linux-user: add openat2 support in linux-user
To: Michael Vogt <michael.vogt@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
References: <20240829144413.6942-2-mvogt@redhat.com>
 <20240829144413.6942-4-mvogt@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240829144413.6942-4-mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/30/24 00:44, Michael Vogt wrote:
> +static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
> +                              const char *fname, int flags, mode_t mode,
> +                              bool safe, bool *use_returned_fd)
>   {
>       g_autofree char *proc_name = NULL;
>       const char *pathname;
> @@ -8362,6 +8371,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>   #endif
>           { NULL, NULL, NULL }
>       };
> +    *use_returned_fd = true;
>   
>       /* if this is a file from /proc/ filesystem, expand full name */
>       proc_name = realpath(fname, NULL);
> @@ -8418,12 +8428,87 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>           return fd;
>       }
>   
> +    *use_returned_fd = false;
> +    return -1;
> +}

Why is -1 insufficient for signalling "do not use"?


> +
> +int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
> +                    int flags, mode_t mode, bool safe)
> +{
> +    bool use_returned_fd;
> +    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, flags, mode, safe,
> +                                &use_returned_fd);
> +    if (use_returned_fd)
> +        return fd;

Braces are required.  Use scripts/checkpatch.pl.

> +#ifdef HAVE_OPENAT2_H
> +static int do_guest_openat2(CPUArchState *cpu_env, int dirfd, const char *fname,
> +                            struct open_how *how)
> +{
> +    /*
> +     * Ideally we would pass "how->resolve" flags into this helper too but
> +     * the lookup for files that need faking is based on "realpath()" so
> +     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
> +     * be honored right now.
> +     */
> +    bool use_returned_fd;
> +    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, how->flags, how->mode,
> +                                true, &use_returned_fd);
> +    if (use_returned_fd)
> +        return fd;
> +
> +    return safe_openat2(dirfd, fname, how, sizeof(struct open_how));
> +}

I don't think this needs to be a separate function.
We did that for do_guest_openat for gdbstub.

> +
> +static int do_openat2(CPUArchState *cpu_env, abi_long arg1, abi_long arg2,
> +                      abi_long arg3, abi_long arg4)

You might as well name the arguments properly, and use abi_ptr/abi_ulong where it makes sense.

> +{
> +    struct open_how how = {0};
> +    struct target_open_how *target_how = NULL;
> +    int ret;
> +
> +    char *p = lock_user_string(arg2);
> +    if (!p) {
> +        ret = -TARGET_EFAULT;
> +        goto out;
> +    }
> +    if (!(lock_user_struct(VERIFY_READ, target_how, arg3, 1))) {
> +        ret = -TARGET_EFAULT;
> +        goto out;
> +    }
> +    size_t target_open_how_struct_size = arg4;
> +    if (target_open_how_struct_size < sizeof(struct target_open_how)) {
> +        ret = -TARGET_EINVAL;
> +        goto out;
> +    }

These checks should be in the same order as the kernel:

SYSCALL_DEFINE(openat2)
     usize < HOW_SIZE_VER0 -> EINVAL
     copy_struct_from_user(how) -> E2BIG

all come before examining the path argument.

> +    if (target_open_how_struct_size > sizeof(struct target_open_how)) {
> +        qemu_log_mask(LOG_UNIMP, "Unimplemented openat2 open_how size: %lu\n",
> +                      target_open_how_struct_size);
> +        ret = -TARGET_E2BIG;
> +        goto out;
>       }

 From copy_struct_from_user you're missing

         } else if (usize > ksize) {
                 int ret = check_zeroed_user(src + size, rest);
                 if (ret <= 0)
                         return ret ?: -E2BIG;

It's not just testing the size, it's reading the following bytes and checking for zeros.

It would be worth adding a helper function for this, matching the kernel.  I'm sure there 
are other places in linux-user that should be doing the same thing.


> +    how.flags = target_to_host_bitmask(target_how->flags, fcntl_flags_tbl);
> +    how.mode = tswap64(target_how->mode);
> +    how.resolve = tswap64(target_how->resolve);

With a linux-user copy_struct_from_user, I expect you'd swap in place:

     how.mode = tswap64(how.mode);

etc.


r~

