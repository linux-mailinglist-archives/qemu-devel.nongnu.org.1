Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4FB7FEF7E
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 13:49:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8gSv-0005vc-NL; Thu, 30 Nov 2023 07:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r8gSt-0005us-RF
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 07:48:23 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r8gSs-0005Zj-5C
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 07:48:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10C811FCE6;
 Thu, 30 Nov 2023 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701348500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTuA0vwRJM61+hvnoP8MdxxsojJVxdHRURHd6eKRNXI=;
 b=C/sVKUTSkov48n4XmsDwYxa5K9R2+3uy4IskBU8i++S79PqU/4AbI4gLWA7qvXW8YuWKFQ
 XVAEqmUIsd2sHw6Xj8L1S9fP1iFVe4JDMW6EIi8ZTJFdcnxkhH2VI6ZjFGVUwpMErVs2c1
 m5gLmiRh2v7cnI/gg9kGFajQq1czCXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701348500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTuA0vwRJM61+hvnoP8MdxxsojJVxdHRURHd6eKRNXI=;
 b=e/lvIcPcjWHPbX/O4yoyyVvQtXxhaYi6ps20QsMhuBJbQ8LwDFOm+7MW7PbAOIZl5xMzoY
 cJIQ86PSkMkNj/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A850B1342E;
 Thu, 30 Nov 2023 12:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hyj7JZOEaGWzNQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 30 Nov 2023 12:48:19 +0000
Message-ID: <3d8bbcc9-89fb-5631-b109-24a9d08da1f5@suse.de>
Date: Thu, 30 Nov 2023 13:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] accel: Do not set CPUState::can_do_io in non-TCG accels
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, kvm@vger.kernel.org
References: <20231129205037.16849-1-philmd@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20231129205037.16849-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.177,
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

Hi Philippe,

took a quick look with 

grep -R can_do_io

and this seems to be in include/hw/core/cpu.h as well as cpu-common.c,

maybe there is more meat to address to fully solve this?

Before we had stuff for reset in cpu-common.c under a
if (tcg_enabled()) {
}

but now we have cpu_exec_reset_hold(),
should the implementation for tcg of cpu_exec_reset_hold() do that (and potentially other tcg-specific non-arch-specific cpu variables we might need)?

If can_do_io is TCG-specific, maybe the whole field existence / visibility can be conditioned on TCG actually being at least compiled-in?
This might help find problems of the field being used in the wrong context, by virtue of getting an error when compiling with --disable-tcg for example.

Ciao,

Claudio


On 11/29/23 21:50, Philippe Mathieu-Daudé wrote:
> 'can_do_io' is specific to TCG. Having it set in non-TCG
> code is confusing, so remove it from QTest / HVF / KVM.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/dummy-cpus.c        | 1 -
>  accel/hvf/hvf-accel-ops.c | 1 -
>  accel/kvm/kvm-accel-ops.c | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
> index b75c919ac3..1005ec6f56 100644
> --- a/accel/dummy-cpus.c
> +++ b/accel/dummy-cpus.c
> @@ -27,7 +27,6 @@ static void *dummy_cpu_thread_fn(void *arg)
>      qemu_mutex_lock_iothread();
>      qemu_thread_get_self(cpu->thread);
>      cpu->thread_id = qemu_get_thread_id();
> -    cpu->neg.can_do_io = true;
>      current_cpu = cpu;
>  
>  #ifndef _WIN32
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index abe7adf7ee..2bba54cf70 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -428,7 +428,6 @@ static void *hvf_cpu_thread_fn(void *arg)
>      qemu_thread_get_self(cpu->thread);
>  
>      cpu->thread_id = qemu_get_thread_id();
> -    cpu->neg.can_do_io = true;
>      current_cpu = cpu;
>  
>      hvf_init_vcpu(cpu);
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6195150a0b..f273f415db 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -36,7 +36,6 @@ static void *kvm_vcpu_thread_fn(void *arg)
>      qemu_mutex_lock_iothread();
>      qemu_thread_get_self(cpu->thread);
>      cpu->thread_id = qemu_get_thread_id();
> -    cpu->neg.can_do_io = true;
>      current_cpu = cpu;
>  
>      r = kvm_init_vcpu(cpu, &error_fatal);


