Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074972022D
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53zn-0007zg-EX; Fri, 02 Jun 2023 08:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53zl-0007xs-RY
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53zk-0008OO-0L
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685709302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGd7sru5dY0ItROVP4IOk9yVus0xA/Z+YN3v5nBi3UA=;
 b=M90BqFm1Iu7cPmnetwcIUquGfob16dROfAYRw8yEld93IwQR701jd9MFIbPZj0zHp5Qx4t
 GTEaPjTKOZ3vE7VllnSLuoqup54bQt1Ca3j71p6TaPfHMjHHldNczc+/U46TGcz0RgYLCp
 I3gIVB4PvL1RWAJrDzo8TjwakH9fwV4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-SxC2ScONMXaRD0Qbs7nvug-1; Fri, 02 Jun 2023 08:35:00 -0400
X-MC-Unique: SxC2ScONMXaRD0Qbs7nvug-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so1043967f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685709299; x=1688301299;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGd7sru5dY0ItROVP4IOk9yVus0xA/Z+YN3v5nBi3UA=;
 b=MN3aj/UbWuWxc7BU/yiCkgv8nZvRe4TQ5n9iWu/oNGmM4VgcPnSQNrrRSKAbaUiSHl
 8b2S1WTnz3qBFzmDCJGLuj4pVd5PrCUf5tFh/YF5HSz7m4IqjRAm7UZkk4+K4jphstgo
 JLXLH+37BIeqEA7KhvglS0bpXZZRqyUlbBP3Jv2kUIAsQzz8fWrkQWAJRDBvm4iMnlet
 9G7Eq1iHNi1AUQCERpTPtjVWyvWtzGwSyjJ025+vC7m30pVKykgGZ1+DCBYoflHBKf5+
 S95y1eLsTciL+gQSRBJ5OUPO55Qm8V4Xp9vAyPyNkoOcLOuLlEiqj/r8F7ebbKJNEMyT
 Ekyw==
X-Gm-Message-State: AC+VfDwHbQQMq/3vx4Onb5BHm6e/qBKVe4RWog5xENZvy02AJI/R4c5M
 SG+ug6T/gFRBwlPZjjWAO4wMQmM7JkhUnf6/6rU9ClschlvNIVBfeJVswrGp6A5T+zF9qBoWa9S
 0IRgSHleVrKDvSV8=
X-Received: by 2002:a5d:69c7:0:b0:30a:e141:d1e2 with SMTP id
 s7-20020a5d69c7000000b0030ae141d1e2mr3972027wrw.7.1685709299669; 
 Fri, 02 Jun 2023 05:34:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SgSh3eSMbOZE2TzuDmNxmdC4OZiOpLUjBQUYqyByjQm77xcFbvHdojD4ac0GzaPhGxgnhnA==
X-Received: by 2002:a5d:69c7:0:b0:30a:e141:d1e2 with SMTP id
 s7-20020a5d69c7000000b0030ae141d1e2mr3972013wrw.7.1685709299279; 
 Fri, 02 Jun 2023 05:34:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a05600010cc00b003077a19cf75sm1571957wrx.60.2023.06.02.05.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 05:34:58 -0700 (PDT)
Message-ID: <4f524884-034a-785d-a1e8-0ebc10f2232f@redhat.com>
Date: Fri, 2 Jun 2023 14:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] linux-user: Emulate /proc/cpuinfo on s390x
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>
References: <20230601162541.689621-1-iii@linux.ibm.com>
 <20230601162541.689621-5-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601162541.689621-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01.06.23 18:25, Ilya Leoshkevich wrote:
> Some s390x userspace programs are confused when seeing a foreign
> /proc/cpuinfo [1]. Add the emulation for s390x; follow the respective
> kernel code structure where possible.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=2211472
> 

Would be nice to have an example output here.

> Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/syscall.c | 106 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3e6ed51ce62..d142e09dc70 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8339,6 +8339,109 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
>   }
>   #endif
>   

[...]

> +
> +static void show_cpuinfo(CPUArchState *cpu_env, int fd, unsigned long n)
> +{
> +    if (n == 0) {
> +        show_cpu_summary(cpu_env, fd);
> +    }
> +    dprintf(fd, "\ncpu number      : %ld\n", n);
> +    show_cpu_ids(cpu_env, fd, n);
> +}

Considering the n==0 special case, it might be cleaner to just place 
that code directly into open_cpuinfo and get rid of show_cpuinfo().

> +
> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> +{
> +    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +    int i;
> +
> +    for (i = 0; i < num_cpus; i++) {
> +        show_cpuinfo(cpu_env, fd, i);
> +    }
> +    return 0;
> +}
> +#endif
> +
>   #if defined(TARGET_M68K)
>   static int open_hardware(CPUArchState *cpu_env, int fd)
>   {
> @@ -8364,7 +8467,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
>   #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
>           { "/proc/net/route", open_net_route, is_proc },
>   #endif
> -#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || defined(TARGET_RISCV)
> +#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
> +    defined(TARGET_RISCV) || defined(TARGET_S390X)
>           { "/proc/cpuinfo", open_cpuinfo, is_proc },
>   #endif
>   #if defined(TARGET_M68K)

In general, looks very good to me, thanks! With the fixup:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


