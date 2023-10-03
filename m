Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB277B64C0
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbBM-0003jb-Pp; Tue, 03 Oct 2023 04:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnbBK-0003jE-El
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:55:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnbBI-0005fn-HT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:55:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29CDF1F8A4;
 Tue,  3 Oct 2023 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696323303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgMoKJDMA7P7Mr4hrLvpcSMZxVY3kCnXlTr03aMlWF4=;
 b=0OnvUE6ShndjTjhIBaEdUfx0PrYNzW1YY9K7ei7srY4/iBOBRTtgL0T2/Cr1NnGjCoyABL
 MWZaXSfH8G0S6SfedLOFafzwldk7p6t8s3IKlERjfrCWusi9LHAICxVJ1+SPzmBbr54QvI
 amGjeNTYP3ftBoqFM2KosN56Y9NfIbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696323303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgMoKJDMA7P7Mr4hrLvpcSMZxVY3kCnXlTr03aMlWF4=;
 b=drjUcmwK7x6XrG778/bt03UPkQFr0oqy1gESXwcL4OhFV4xJfcf5R55/mvgnNd1eJI4YDY
 w5KizEQyshzVe4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6006139F9;
 Tue,  3 Oct 2023 08:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JKgaKubWG2VRPgAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 03 Oct 2023 08:55:02 +0000
Message-ID: <39bac54e-be9f-f425-81be-62395633ad13@suse.de>
Date: Tue, 3 Oct 2023 10:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/5] accel: Declare AccelClass::[un]realize_cpu() handlers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230915190009.68404-1-philmd@linaro.org>
 <20230915190009.68404-4-philmd@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230915190009.68404-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
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

On 9/15/23 21:00, Philippe Mathieu-Daudé wrote:
> Currently accel_cpu_realize() only performs target-specific
> realization. Introduce the [un]realize_cpu fields in the
> base AccelClass to be able to perform target-agnostic
> [un]realization of vCPUs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Just thinking, for the benefit of the reader trying to understand the code later on,
maybe putting in a "target_" in there somewhere in the function name?
like "realize_cpu_target", vs "realize_cpu_generic" ?

Ciao,

C

> ---
>  include/qemu/accel.h |  2 ++
>  accel/accel-common.c | 21 +++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index 23254c6c9c..7bd9907d2a 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -43,6 +43,8 @@ typedef struct AccelClass {
>      bool (*has_memory)(MachineState *ms, AddressSpace *as,
>                         hwaddr start_addr, hwaddr size);
>  #endif
> +    bool (*realize_cpu)(CPUState *cpu, Error **errp);
> +    void (*unrealize_cpu)(CPUState *cpu);
>  
>      /* gdbstub related hooks */
>      int (*gdbstub_supported_sstep_flags)(void);
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index cc3a45e663..6d427f2b9d 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -122,15 +122,32 @@ void accel_cpu_instance_init(CPUState *cpu)
>  bool accel_cpu_realize(CPUState *cpu, Error **errp)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> +    AccelState *accel = current_accel();
> +    AccelClass *acc = ACCEL_GET_CLASS(accel);
>  
> -    if (cc->accel_cpu && cc->accel_cpu->cpu_realizefn) {
> -        return cc->accel_cpu->cpu_realizefn(cpu, errp);
> +    /* target specific realization */
> +    if (cc->accel_cpu && cc->accel_cpu->cpu_realizefn
> +        && !cc->accel_cpu->cpu_realizefn(cpu, errp)) {
> +        return false;
>      }
> +
> +    /* generic realization */
> +    if (acc->realize_cpu && !acc->realize_cpu(cpu, errp)) {
> +        return false;
> +    }
> +
>      return true;
>  }
>  
>  void accel_cpu_unrealize(CPUState *cpu)
>  {
> +    AccelState *accel = current_accel();
> +    AccelClass *acc = ACCEL_GET_CLASS(accel);
> +
> +    /* generic unrealization */
> +    if (acc->unrealize_cpu) {
> +        acc->unrealize_cpu(cpu);
> +    }
>  }
>  
>  int accel_supported_gdbstub_sstep_flags(void)


