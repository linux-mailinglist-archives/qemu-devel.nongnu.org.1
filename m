Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E50167A5112
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI9m-0007KJ-Gc; Mon, 18 Sep 2023 13:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI9k-0007Hv-1u
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:35:32 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI9i-0005p7-Fl
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:35:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20DA021F5A;
 Mon, 18 Sep 2023 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695058529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sxPjFmJB+UDCCt40nH8SUy2gAnwbGYmAmmHGwP52GEw=;
 b=h/IsehoxRPulKnsQjEvurLgWO0qkdU+lgBD/IwfxkL+0971uwORyd7D9bFxkGkz+Y3wgAb
 sqnEt7mwqUOZlO0CO6g33ANplOPyqV0MvIr/UtjCQZZo40fCBehngqV+7vVX3gV9pCv3HM
 LO72YcH1j94kMR0izGbeEjE5VxpUMjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695058529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sxPjFmJB+UDCCt40nH8SUy2gAnwbGYmAmmHGwP52GEw=;
 b=poFYZihtAta5EpNShOA7Xf02OQo2Y6/Ert3YjkyVNkwArh0DoG+gFaUXInn/uvOpt6stGQ
 nFEwicn6q5qQrmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6C591358A;
 Mon, 18 Sep 2023 17:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tgcIHGCKCGVIGwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 17:35:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 12/52] migration/rdma: Drop qemu_rdma_search_ram_block()
 error handling
In-Reply-To: <20230918144206.560120-13-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-13-armbru@redhat.com>
Date: Mon, 18 Sep 2023 14:35:26 -0300
Message-ID: <87a5tjz8o1.fsf@suse.de>
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

Markus Armbruster <armbru@redhat.com> writes:

> qemu_rdma_search_ram_block() can't fail.  Return void, and drop the
> unreachable error handling.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/rdma.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 2b0f9d52d8..98520a42b4 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1234,12 +1234,12 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
>   *
>   * This search cannot fail or the migration will fail.
>   */

This comment can be removed as well.

> -static int qemu_rdma_search_ram_block(RDMAContext *rdma,
> -                                      uintptr_t block_offset,
> -                                      uint64_t offset,
> -                                      uint64_t length,
> -                                      uint64_t *block_index,
> -                                      uint64_t *chunk_index)
> +static void qemu_rdma_search_ram_block(RDMAContext *rdma,
> +                                       uintptr_t block_offset,
> +                                       uint64_t offset,
> +                                       uint64_t length,
> +                                       uint64_t *block_index,
> +                                       uint64_t *chunk_index)
>  {
>      uint64_t current_addr = block_offset + offset;
>      RDMALocalBlock *block = g_hash_table_lookup(rdma->blockmap,
> @@ -1251,8 +1251,6 @@ static int qemu_rdma_search_ram_block(RDMAContext *rdma,
>      *block_index = block->index;
>      *chunk_index = ram_chunk_index(block->local_host_addr,
>                  block->local_host_addr + (current_addr - block->offset));
> -
> -    return 0;
>  }
>  
>  /*
> @@ -2321,12 +2319,8 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
>          rdma->current_length = 0;
>          rdma->current_addr = current_addr;
>  
> -        ret = qemu_rdma_search_ram_block(rdma, block_offset,
> -                                         offset, len, &index, &chunk);
> -        if (ret) {
> -            error_report("ram block search failed");
> -            return ret;
> -        }
> +        qemu_rdma_search_ram_block(rdma, block_offset,
> +                                   offset, len, &index, &chunk);
>          rdma->current_index = index;
>          rdma->current_chunk = chunk;
>      }

