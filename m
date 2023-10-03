Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A07717B64B1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:52:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnb7a-00025V-Gc; Tue, 03 Oct 2023 04:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnb7Y-00025J-QK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:51:12 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnb7X-0004jc-52
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54B4C1F38C;
 Tue,  3 Oct 2023 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696323068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+e7xFM+HvvIW13K9+Rbko6Whp4xEt979IdWxH8bR46g=;
 b=1wWIT2RnhxDk8FmqK/qcanywIE6w2mnLE4FlmdYRYmRPgdrqnV7TOVMqcQB9r3laDbUGqo
 mQ37j1Q3wYDOOPOWfjCG8gf0xDjg6aZBeD5ucBYLrBi7Qby9BeEFFbAcTTFCn69PNTMRKL
 z5c21t6f9CTogb6mDxGHeyYqgwecoNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696323068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+e7xFM+HvvIW13K9+Rbko6Whp4xEt979IdWxH8bR46g=;
 b=A0hNpdIWf8CJzf7rS+Wt+brmkrDX5u7+WfzR18/xoybPYPH0JQZSsfIhW/zu737ox12s5A
 YmF+TzEotyy/+JAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2A64139F9;
 Tue,  3 Oct 2023 08:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KWGtOfvVG2VwPAAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 03 Oct 2023 08:51:07 +0000
Message-ID: <411e5aa7-5433-9c06-4571-bfcad565abec@suse.de>
Date: Tue, 3 Oct 2023 10:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/5] accel: Rename accel_cpu_realizefn() ->
 accel_cpu_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230915190009.68404-1-philmd@linaro.org>
 <20230915190009.68404-2-philmd@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230915190009.68404-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Reviewed-by: Claudio Fontana <cfontana@suse.de>

On 9/15/23 21:00, Philippe Mathieu-Daudé wrote:
> We use the '*fn' suffix for handlers, this is a public method.
> Drop the suffix.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/qemu/accel.h      | 4 ++--
>  accel/accel-common.c      | 2 +-
>  cpu.c                     | 2 +-
>  target/i386/kvm/kvm-cpu.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index e84db2e3e5..cb64a07b84 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -90,11 +90,11 @@ void accel_setup_post(MachineState *ms);
>  void accel_cpu_instance_init(CPUState *cpu);
>  
>  /**
> - * accel_cpu_realizefn:
> + * accel_cpu_realize:
>   * @cpu: The CPU that needs to call accel-specific cpu realization.
>   * @errp: currently unused.
>   */
> -bool accel_cpu_realizefn(CPUState *cpu, Error **errp);
> +bool accel_cpu_realize(CPUState *cpu, Error **errp);
>  
>  /**
>   * accel_supported_gdbstub_sstep_flags:
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index df72cc989a..b953855e8b 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -119,7 +119,7 @@ void accel_cpu_instance_init(CPUState *cpu)
>      }
>  }
>  
> -bool accel_cpu_realizefn(CPUState *cpu, Error **errp)
> +bool accel_cpu_realize(CPUState *cpu, Error **errp)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);
>  
> diff --git a/cpu.c b/cpu.c
> index 0769b0b153..61c9760e62 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -136,7 +136,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>      /* cache the cpu class for the hotpath */
>      cpu->cc = CPU_GET_CLASS(cpu);
>  
> -    if (!accel_cpu_realizefn(cpu, errp)) {
> +    if (!accel_cpu_realize(cpu, errp)) {
>          return;
>      }
>  
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 7237378a7d..4474689f81 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -35,7 +35,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>       * x86_cpu_realize():
>       *  -> x86_cpu_expand_features()
>       *  -> cpu_exec_realizefn():
> -     *            -> accel_cpu_realizefn()
> +     *            -> accel_cpu_realize()
>       *               kvm_cpu_realizefn() -> host_cpu_realizefn()
>       *  -> check/update ucode_rev, phys_bits, mwait
>       */


