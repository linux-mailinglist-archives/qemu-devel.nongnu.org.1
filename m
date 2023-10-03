Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B67B64C7
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:57:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbDe-0004dT-O4; Tue, 03 Oct 2023 04:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnbDU-0004Zo-3Z
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnbDR-000630-Cc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33B3F1F893;
 Tue,  3 Oct 2023 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696323436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbIvpO+nBUD9kLhZtb3pxE3oHjEwKfLWaARI6nsRjd8=;
 b=wJTXJwTeQKpoHqtgzBHtpXGK6m4fA+VqIQGQFnOcZIayRmVX+rPmRHEJKoLnHfmn1+cIN2
 p+oo9ADWM/ZT5yWfllpitnKf3FlchlI68NrRfTTuYxjSHA9lngJIB/OS8ZVx4lhyK/sEs4
 YJoL036zbBgLSy1tioILH7sgU9zwrRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696323436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbIvpO+nBUD9kLhZtb3pxE3oHjEwKfLWaARI6nsRjd8=;
 b=8aqAiFV7V3q76p1194dee67oegA+5pKd3wjx/jMSFUXYewEg4osceikWimSYP2Qny0FrVO
 M/pfwkp1WlKNyQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB62A139F9;
 Tue,  3 Oct 2023 08:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +JuAK2vXG2VaPwAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 03 Oct 2023 08:57:15 +0000
Message-ID: <f30edf1b-5fd5-4ea6-8e23-097365c30c7a@suse.de>
Date: Tue, 3 Oct 2023 10:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/5] accel/tcg: Have tcg_exec_realizefn() return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230915190009.68404-1-philmd@linaro.org>
 <20230915190009.68404-5-philmd@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230915190009.68404-5-philmd@linaro.org>
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
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have tcg_exec_realizefn() return
> a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Claudio Fontana <cfontana@suse.de>

> ---
>  include/exec/cpu-all.h | 2 +-
>  accel/tcg/cpu-exec.c   | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index c2c62160c6..1e5c530ee1 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -422,7 +422,7 @@ void dump_exec_info(GString *buf);
>  
>  /* accel/tcg/cpu-exec.c */
>  int cpu_exec(CPUState *cpu);
> -void tcg_exec_realizefn(CPUState *cpu, Error **errp);
> +bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
>  void tcg_exec_unrealizefn(CPUState *cpu);
>  
>  /**
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index e2c494e75e..fa97e9f191 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1088,7 +1088,7 @@ int cpu_exec(CPUState *cpu)
>      return ret;
>  }
>  
> -void tcg_exec_realizefn(CPUState *cpu, Error **errp)
> +bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>  {
>      static bool tcg_target_initialized;
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> @@ -1104,6 +1104,8 @@ void tcg_exec_realizefn(CPUState *cpu, Error **errp)
>      tcg_iommu_init_notifier_list(cpu);
>  #endif /* !CONFIG_USER_ONLY */
>      /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
> +
> +    return true;
>  }
>  
>  /* undo the initializations in reverse order */


