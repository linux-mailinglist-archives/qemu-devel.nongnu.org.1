Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC6677CCC5
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 14:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVtGr-00071t-4n; Tue, 15 Aug 2023 08:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVtGj-00071W-D2
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:35:29 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVtGh-0002Zx-6f
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:35:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D1C021892;
 Tue, 15 Aug 2023 12:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692102922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdM//8SzgIjafyfvV2e3Ps+U64sLtu2Hx7JZnRhP51I=;
 b=Z4EWnHVsDrRr2JIfnlSJDuxlZL+LGBvbnRoDqF3AJXj33jSlJHJ4PiMCEAEBXAaCg7MSAD
 fWXnCPkAgaNXXpGOPRkpEjQnn20EBUX6y+59KnpSeO6IND2rCynn5jzc1rUTWv9G+ZSEOw
 OCzk/T5aFb/WMT1BdifEwLmBn0iAZJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692102922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdM//8SzgIjafyfvV2e3Ps+U64sLtu2Hx7JZnRhP51I=;
 b=MN6D+PK90mpwKW+Yfh8l7InaUnuKGruWV0L9329HyYAfVJe8lfA3MO1O+dCleU+12dNN58
 K0RVYPWJXN+GmHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E08C513909;
 Tue, 15 Aug 2023 12:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QRAgKglx22RtGwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 12:35:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Guoyi Tu <tugy@chinatelecom.cn>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return
 if qemu file got error
In-Reply-To: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
Date: Tue, 15 Aug 2023 09:35:19 -0300
Message-ID: <87h6p0mqk8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Guoyi Tu <tugy@chinatelecom.cn> writes:

> When the migration process of a virtual machine using huge pages is 
> cancelled,
> QEMU will continue to complete the processing of the current huge page
> through the qemu file object got an error set. These processing, such as
> compression and encryption, will consume a lot of CPU resources which may
> affact the the performance of the other VMs.
>
> To terminate the migration process more quickly and minimize unnecessary
> resource occupancy, it's neccessary to add logic to check the error status
> of qemu file object in the beginning of ram_save_target_page_legacy 
> function,
> and make sure the function returns immediately if qemu file got an error.
>
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> ---
>   migration/ram.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 9040d66e61..3e2ebf3004 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2133,6 +2133,10 @@ static int ram_save_target_page_legacy(RAMState 
> *rs, PageSearchStatus *pss)
>       ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>       int res;
>
> +    if (qemu_file_get_error(pss->pss_channel)) {
> +        return -1;
> +    }

Where was the error set? Is this from cancelling via QMP? Or something
from within ram_save_target_page_legacy? We should probably make the
check closer to where the error happens. At the very least moving the
check into the loop.

