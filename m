Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC39E7B6B0A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qng2h-0008Mf-5A; Tue, 03 Oct 2023 10:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qng2f-0008MG-AP
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:06:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qng2d-0002U9-LU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:06:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 377331F893;
 Tue,  3 Oct 2023 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696341986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDqJJ7En9jpnR2yY7FEvE4WtOXHGKqVVku0MzHnFxxY=;
 b=Nmtpy5I7ShAx9L2pFSQVTaTin1lA9WI5FR0aEGyPwfePJcn3o5yMx+5kSeFJGbi7AlCn7m
 PTXtGZH6irdyYzot33+92rjEmq31Yjw28oYtZ0mo9zMhGiRcIX3urkEwmy6n4zNp1WP4Ri
 yNyXHQI8YcQ/6p9eD/PnXfeubfR6Hs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696341986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDqJJ7En9jpnR2yY7FEvE4WtOXHGKqVVku0MzHnFxxY=;
 b=Pi+C9WA3kmRlnhk2VAFAkPsWVlVG5bI7I6Z4kM0T765yVUr/wZS3kPXvmWKPBBkTr3DTpz
 t28iw5MxCMOL+nDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB9AD139F9;
 Tue,  3 Oct 2023 14:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id puMOMOEfHGU+SgAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 03 Oct 2023 14:06:25 +0000
Message-ID: <5a937be2-0e20-6506-7de4-956b4759478f@suse.de>
Date: Tue, 3 Oct 2023 16:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] accel: Restrict tcg_exec_[un]realizefn() to TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang
 <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20231003123026.99229-1-philmd@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

Nice. I build-tested and make checked this as well,

Reviewed-by: Claudio Fontana <cfontana@suse.de>
Tested-by: Claudio Fontana <cfontana@suse.de>

On 10/3/23 14:30, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Use 'target'/'common' in function names (Claudio)
> - Added Claudio R-b tags
> 
> From v1:
> - Add missing accel_cpu_common_unrealize()
> - Add AccelClass::cpu_common_[un]realize handlers
> - Use tcg_exec_[un]realizefn as AccelClass handlers
> 
> Philippe Mathieu-Daudé (7):
>   accel: Rename accel_cpu_realizefn() ->  accel_cpu_realize()
>   accel: Rename AccelCPUClass::cpu_realizefn() -> cpu_target_realize()
>   accel: Rename accel_cpu_realize() -> accel_cpu_common_realize()
>   accel: Introduce accel_cpu_common_unrealize() stub
>   accel: Declare AccelClass::cpu_common_[un]realize() handlers
>   accel/tcg: Have tcg_exec_realizefn() return a boolean
>   accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
> 
>  accel/tcg/internal.h        |  3 +++
>  include/exec/cpu-all.h      |  2 --
>  include/hw/core/accel-cpu.h |  2 +-
>  include/qemu/accel.h        | 12 ++++++++++--
>  accel/accel-common.c        | 27 ++++++++++++++++++++++++---
>  accel/tcg/cpu-exec.c        |  4 +++-
>  accel/tcg/tcg-all.c         |  2 ++
>  cpu.c                       | 13 +++----------
>  target/i386/hvf/hvf-cpu.c   |  2 +-
>  target/i386/kvm/kvm-cpu.c   |  4 ++--
>  target/i386/tcg/tcg-cpu.c   |  2 +-
>  11 files changed, 50 insertions(+), 23 deletions(-)
> 


