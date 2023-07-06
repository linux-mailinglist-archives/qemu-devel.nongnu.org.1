Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBDD74A368
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHT4E-0002kL-K9; Thu, 06 Jul 2023 13:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qHT4A-0002jF-Ir
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qHT48-0002e7-BZ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688665609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DzxRNkJ4GtVFs0wt1JseAdbsh2aLjvSMe3hpjEL/604=;
 b=Z1oyodPqBV9d/WOsGmpHn7drSLfEhJMvtzn8XGAd/DJwWgPh8ZJHAM71Dd6EEh60TWNUN7
 t5Qaq90tS6YIdv9ZWgBxwsyqxye8J5vzbmJue8cgViUllJOatxrwU7m2ETbqXGAFKGJGpm
 7HV04N0Hmi5Ecu9ji5EWaK/dPrPHobs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-6QgFRMCbMeyvvDQLDBA6Og-1; Thu, 06 Jul 2023 13:46:43 -0400
X-MC-Unique: 6QgFRMCbMeyvvDQLDBA6Og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2568E104D521;
 Thu,  6 Jul 2023 17:46:43 +0000 (UTC)
Received: from localhost (unknown [10.42.28.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC50540C2063;
 Thu,  6 Jul 2023 17:46:42 +0000 (UTC)
Date: Thu, 6 Jul 2023 18:46:42 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peterz@infradead.org, arnd@arndb.de,
 naresh.kamboju@linaro.org, anders.roxell@linaro.org,
 daniel.diaz@linaro.org, ben.copeland@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
Message-ID: <20230706174642.GP7636@redhat.com>
References: <20230706170537.95959-1-richard.henderson@linaro.org>
 <20230706170537.95959-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706170537.95959-2-richard.henderson@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 06, 2023 at 06:05:36PM +0100, Richard Henderson wrote:
> Share the setjmp cleanup between cpu_exec_step_atomic
> and cpu_exec_setjmp.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

(I'm still testing the other one, but already up to 600 iterations)

Rich.

> ---
>  accel/tcg/cpu-exec.c | 43 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ba1890a373..31aa320513 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -526,6 +526,23 @@ static void cpu_exec_exit(CPUState *cpu)
>      }
>  }
>  
> +static void cpu_exec_longjmp_cleanup(CPUState *cpu)
> +{
> +    /* Non-buggy compilers preserve this; assert the correct value. */
> +    g_assert(cpu == current_cpu);
> +
> +#ifdef CONFIG_USER_ONLY
> +    clear_helper_retaddr();
> +    if (have_mmap_lock()) {
> +        mmap_unlock();
> +    }
> +#endif
> +    if (qemu_mutex_iothread_locked()) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +    assert_no_pages_locked();
> +}
> +
>  void cpu_exec_step_atomic(CPUState *cpu)
>  {
>      CPUArchState *env = cpu->env_ptr;
> @@ -568,16 +585,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
>          cpu_tb_exec(cpu, tb, &tb_exit);
>          cpu_exec_exit(cpu);
>      } else {
> -#ifdef CONFIG_USER_ONLY
> -        clear_helper_retaddr();
> -        if (have_mmap_lock()) {
> -            mmap_unlock();
> -        }
> -#endif
> -        if (qemu_mutex_iothread_locked()) {
> -            qemu_mutex_unlock_iothread();
> -        }
> -        assert_no_pages_locked();
> +        cpu_exec_longjmp_cleanup(cpu);
>      }
>  
>      /*
> @@ -1023,20 +1031,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
>  {
>      /* Prepare setjmp context for exception handling. */
>      if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
> -        /* Non-buggy compilers preserve this; assert the correct value. */
> -        g_assert(cpu == current_cpu);
> -
> -#ifdef CONFIG_USER_ONLY
> -        clear_helper_retaddr();
> -        if (have_mmap_lock()) {
> -            mmap_unlock();
> -        }
> -#endif
> -        if (qemu_mutex_iothread_locked()) {
> -            qemu_mutex_unlock_iothread();
> -        }
> -
> -        assert_no_pages_locked();
> +        cpu_exec_longjmp_cleanup(cpu);
>      }
>  
>      return cpu_exec_loop(cpu, sc);
> -- 
> 2.34.1

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


