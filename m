Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB33E7A48AF
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:44:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCew-0006oU-1w; Mon, 18 Sep 2023 07:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qiCet-0006oM-Na
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:43:19 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qiCes-0003uR-4w
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N8IKWBQzhJRHdd49QR5PaT8k9yu/jiGJnK1WkDw/YSI=; b=lXe0VxgtwqJRYuljcWy7KlwxU+
 Qn0jABqkhexEU1TJVQmpz3qNiIpxnX9OOP3WGmpSGG/xjj91TCRwvUDhBNS+0xD4h7E50ruvn1BRc
 arAROX/qyiWDHxHq666pLGzlxRITYFeIToWR7ziaLHhs8Mw7Y+cPEr+d5ft5NL1A+big=;
Date: Mon, 18 Sep 2023 13:42:58 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>, Fabiano Rosas <farosas@suse.de>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/3] accel: Factor tcg_cpu_reset_hold() out of cpu-common.c
Message-ID: <4lkqm7kzbcn7z3cfytxjpxdmtbrj7k7joy7jagosq7eq5qq4td@2io2gdb4zxxs>
References: <20230918104153.24433-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918104153.24433-1-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 18/09/23, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> We want to have exec/ code agnostic to accelerators.
> still we use various call to TCG and KVM. This series
> factor the TCG code from cpu_common_reset_hold() to an
> accel-specific handler within AccelOpsClass.
> 
> Based-on: <20230915190009.68404-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (3):
>   accel/tcg: Declare tcg_flush_jmp_cache() in 'exec/tb-flush.h'
>   accel: Introduce cpu_exec_reset_hold()
>   accel/tcg: Factor tcg_cpu_reset_hold() out
> 
>  include/exec/cpu-common.h  | 3 ---
>  include/exec/tb-flush.h    | 2 ++
>  include/hw/core/cpu.h      | 1 +
>  include/sysemu/accel-ops.h | 1 +
>  accel/stubs/tcg-stub.c     | 4 ----
>  accel/tcg/cputlb.c         | 1 +
>  accel/tcg/tcg-accel-ops.c  | 9 +++++++++
>  accel/tcg/translate-all.c  | 8 --------
>  accel/tcg/user-exec-stub.c | 4 ++++
>  hw/core/cpu-common.c       | 5 +----
>  plugins/core.c             | 1 -
>  softmmu/cpus.c             | 7 +++++++
>  12 files changed, 26 insertions(+), 20 deletions(-)
> 
> -- 
> 2.41.0
> 
Series:
Reviewed-by: Anton Johansson <anjo@rev.ng>

