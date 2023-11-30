Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E517FF054
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:38:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hFB-0008Rj-Kc; Thu, 30 Nov 2023 08:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r8hF5-0008Pm-03
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:38:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r8hEw-0007Lc-Th
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:38:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4E1521AF3;
 Thu, 30 Nov 2023 13:37:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95AC413AB1;
 Thu, 30 Nov 2023 13:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id omWqITeQaGXJQgAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 30 Nov 2023 13:37:59 +0000
Message-ID: <96479d73-b5b0-68da-4ce9-65bbadb0bc56@suse.de>
Date: Thu, 30 Nov 2023 14:37:55 +0100
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
 <3d8bbcc9-89fb-5631-b109-24a9d08da1f5@suse.de>
 <73ca9d6c-62d4-412a-b847-f2c421887e96@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <73ca9d6c-62d4-412a-b847-f2c421887e96@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out1.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of cfontana@suse.de)
 smtp.mailfrom=cfontana@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.98 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(4.60)[~all:c];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.19)[0.911];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 6.98
X-Rspamd-Queue-Id: E4E1521AF3
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.177,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/30/23 14:31, Philippe Mathieu-Daudé wrote:
> Hi Claudio,
> 
> On 30/11/23 13:48, Claudio Fontana wrote:
>> Hi Philippe,
>>
>> took a quick look with
>>
>> grep -R can_do_io
>>
>> and this seems to be in include/hw/core/cpu.h as well as cpu-common.c,
>>
>> maybe there is more meat to address to fully solve this?
>>
>> Before we had stuff for reset in cpu-common.c under a
>> if (tcg_enabled()) {
>> }
>>
>> but now we have cpu_exec_reset_hold(),
>> should the implementation for tcg of cpu_exec_reset_hold() do that (and potentially other tcg-specific non-arch-specific cpu variables we might need)?
> 
> Later we eventually get there:
> 
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 9b038b1af5..e2c5cf97dc 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -89,6 +89,9 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
> 
>       cpu->accel->icount_extra = 0;
>       cpu->accel->mem_io_pc = 0;
> +
> +    qatomic_set(&cpu->neg.icount_decr.u32, 0);
> +    cpu->neg.can_do_io = true;
>   }
> 
> My branch is huge, I'm trying to split it, maybe I shouldn't have
> sent this single non-TCG patch out of it. I'll Cc you.

Thanks and congrats for the rework effort there!

Ciao,

Claudio

> 
>> If can_do_io is TCG-specific, maybe the whole field existence / visibility can be conditioned on TCG actually being at least compiled-in?
>> This might help find problems of the field being used in the wrong context, by virtue of getting an error when compiling with --disable-tcg for example.
>>
>> Ciao,
>>
>> Claudio
> 


