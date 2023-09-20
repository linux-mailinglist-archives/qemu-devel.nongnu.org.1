Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D55C7A8372
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qixIq-0006ex-Sg; Wed, 20 Sep 2023 09:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qixIp-0006eF-CX
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:31:39 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qixIn-0003ut-OR
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:31:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3D59521C6A;
 Wed, 20 Sep 2023 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695216694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qM5yp/BIa+ep/Rtc4Pd/KTyvnNZl+K1iZu8sJHQ1d4=;
 b=mvdj/Y2T/F+zJr1mCGS0CVtbrhgXnBxazGDm8+cf4MbyT2FBV2AN9Vla/glYWlQsQUmOqs
 sCJtfKltU9hSl3cHTxqpYF/50FRt8anQwaXXuawEecL1ISkOnpqb78Xw+FpDUapeP0+fF1
 EXEN8VvsgD+h3wma4dXcKakupdf2TXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695216694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qM5yp/BIa+ep/Rtc4Pd/KTyvnNZl+K1iZu8sJHQ1d4=;
 b=ZLxSxehpRYdtA8FQuTxPKx9tfzVmV5cTZVZKzWVyeW8VH4Z7SgfNrCYdFj1/MwUQEoQ+sX
 bg5Ls6H3GogxFBAA==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 8CAEE2C142;
 Wed, 20 Sep 2023 13:31:33 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 913AA4A03BF; Wed, 20 Sep 2023 15:31:33 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org,  Alexandre Ghiti <alexghiti@rivosinc.com>,  Bin
 Meng <bmeng@tinylab.org>,  Frank Chang <frank.chang@sifive.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] riscv: Call set_satp_mode_max_supported in
 riscv_host_cpu_init
In-Reply-To: <20230919-853624bc6079021587741eb4@orel> (Andrew Jones's message
 of "Tue, 19 Sep 2023 13:18:31 +0200")
References: <mvm34zavbmb.fsf@suse.de> <20230919-853624bc6079021587741eb4@orel>
X-Yow: Did YOU find a DIGITAL WATCH in YOUR box of VELVEETA?
Date: Wed, 20 Sep 2023 15:31:33 +0200
Message-ID: <mvmttrpt1hm.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=schwab@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sep 19 2023, Andrew Jones wrote:

> This should be fixed by
>
> https://lore.kernel.org/all/20230911064320.939791-37-alistair.francis@wdc.com/

Thanks, I can confirm that it fixes the issue.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

