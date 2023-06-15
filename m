Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE027323CA
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9wdv-0000bA-Ra; Thu, 15 Jun 2023 19:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wdu-0000ad-8C
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:44:42 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wds-0000up-P3
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:44:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CD65D60CA4;
 Thu, 15 Jun 2023 23:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFF2C433C0;
 Thu, 15 Jun 2023 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686872671;
 bh=/zmRF+wnsdjg89X6sIh3fSHJoxnUAbxgft9a4JswYc4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=AaSeU8+3sp2CsNOr4X7gCkFxufhAVqti7FS4tc0cKeIMdGVzMIDsnRbV2UNWx993j
 WjBKl6X6VSm0lCSgswywGQVzxHT/w2frnQVsZcHoijcSYu+Yz4aGev3AZzMAPWKTUX
 lcV+5UjZTivQrBEX1m6LB31uGeHkdo+GySgqYp9ltdeYU5bLVALZYCWILocAXZbUZa
 NMofawILBjSgdXSC1chmTW0nfSuXFiZcE5D+ki4N3L8TZupfRMvgMm77UdNNBtPq0L
 uC5+xEvWF2vvrqPWj+2jpF6w+UAp2r6TsnmPB1p2v7dM9sUWibLE5ZEk11UGr3ixxM
 PcTePK4gP/wpQ==
Date: Thu, 15 Jun 2023 16:44:28 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [QEMU][PATCH v8 11/11] test/qtest: add xepvh to skip list for
 qtest
In-Reply-To: <20230615000340.1135-12-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2306151644220.897208@ubuntu-linux-20-04-desktop>
References: <20230615000340.1135-1-vikram.garhwal@amd.com>
 <20230615000340.1135-12-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 14 Jun 2023, Vikram Garhwal wrote:
> Like existing xen machines, xenpvh also cannot be used for qtest.
> 
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  tests/qtest/libqtest.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 77de16227f..de03ef5f60 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1465,7 +1465,8 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
>      for (i = 0; machines[i].name != NULL; i++) {
>          /* Ignore machines that cannot be used for qtests */
>          if (!strncmp("xenfv", machines[i].name, 5) ||
> -            g_str_equal("xenpv", machines[i].name)) {
> +            g_str_equal("xenpv", machines[i].name) ||
> +            g_str_equal("xenpvh", machines[i].name)) {
>              continue;
>          }
>          if (!skip_old_versioned ||
> -- 
> 2.17.1
> 

