Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31A78406C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQDG-0001WV-Do; Tue, 22 Aug 2023 08:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQDD-0001WG-VN
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:10:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQDA-0005m1-Na
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:10:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 757D41F381;
 Tue, 22 Aug 2023 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692706214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdwdBHsKSruxBBzgF6J8UguUFtB7ED9z6MGaUGiJhQ=;
 b=HCzDcjPVDSzpSYt3IgqlrIgow4F9OA0dRtmBIPH/ymRTIv2iH2Q+b3CYIkL2VleGupKr7C
 y4MKy/YrXmbkQ9iwuyL0cdNoYQ4TgYO9AS9IrHVKIqJfiqiz3X/AYA/AplzmKZEaghMlgl
 33iXV1lKr0/8vOgztcc6pbYzBh/gQMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692706214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdwdBHsKSruxBBzgF6J8UguUFtB7ED9z6MGaUGiJhQ=;
 b=XvW5Y3kZNx6FaQNMsDTdXmcICvJ+Lo++37yRNK3hjpfpFnsYXHFNin1qwZHDIK9ko2ra4y
 Z2lIm1sAy6HRKiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31CCD13919;
 Tue, 22 Aug 2023 12:10:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a6ONCqal5GRmWwAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 22 Aug 2023 12:10:14 +0000
Message-ID: <4dbad617-82ac-0ee7-dd44-3fe742f0a06c@suse.de>
Date: Tue, 22 Aug 2023 14:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] migration/ram: Refactor precopy ram loading code
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Nikolay Borisov <nborisov@suse.com>, Juan Quintela <quintela@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230725132651.18635-1-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230725132651.18635-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

Hello,

this patch is reviewed,

and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
when migrating to disk, can it be merged?

Thanks,

Claudio

On 7/25/23 15:26, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Extract the ramblock parsing code into a routine that operates on the
> sequence of headers from the stream and another the parses the
> individual ramblock. This makes ram_load_precopy() easier to
> comprehend.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> I'm extracting the parts from the fixed-ram migration series [1] that
> could already go in. This patch is one of them.
> 
> 1- https://lore.kernel.org/r/20230330180336.2791-1-farosas@suse.de
> ---
>  migration/ram.c | 141 +++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 62 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 0ada6477e8..685e129b70 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3826,6 +3826,82 @@ void colo_flush_ram_cache(void)
>      trace_colo_flush_ram_cache_end();
>  }
>  
> +static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> +{
> +    int ret = 0;
> +    /* ADVISE is earlier, it shows the source has the postcopy capability on */
> +    bool postcopy_advised = migration_incoming_postcopy_advised();
> +
> +    assert(block);
> +
> +    if (!qemu_ram_is_migratable(block)) {
> +        error_report("block %s should not be migrated !", block->idstr);
> +        return -EINVAL;
> +    }
> +
> +    if (length != block->used_length) {
> +        Error *local_err = NULL;
> +
> +        ret = qemu_ram_resize(block, length, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +    }
> +    /* For postcopy we need to check hugepage sizes match */
> +    if (postcopy_advised && migrate_postcopy_ram() &&
> +        block->page_size != qemu_host_page_size) {
> +        uint64_t remote_page_size = qemu_get_be64(f);
> +        if (remote_page_size != block->page_size) {
> +            error_report("Mismatched RAM page size %s "
> +                         "(local) %zd != %" PRId64, block->idstr,
> +                         block->page_size, remote_page_size);
> +            ret = -EINVAL;
> +        }
> +    }
> +    if (migrate_ignore_shared()) {
> +        hwaddr addr = qemu_get_be64(f);
> +        if (migrate_ram_is_ignored(block) &&
> +            block->mr->addr != addr) {
> +            error_report("Mismatched GPAs for block %s "
> +                         "%" PRId64 "!= %" PRId64, block->idstr,
> +                         (uint64_t)addr, (uint64_t)block->mr->addr);
> +            ret = -EINVAL;
> +        }
> +    }
> +    ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG, block->idstr);
> +
> +    return ret;
> +}
> +
> +static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
> +{
> +    int ret = 0;
> +
> +    /* Synchronize RAM block list */
> +    while (!ret && total_ram_bytes) {
> +        RAMBlock *block;
> +        char id[256];
> +        ram_addr_t length;
> +        int len = qemu_get_byte(f);
> +
> +        qemu_get_buffer(f, (uint8_t *)id, len);
> +        id[len] = 0;
> +        length = qemu_get_be64(f);
> +
> +        block = qemu_ram_block_by_name(id);
> +        if (block) {
> +            ret = parse_ramblock(f, block, length);
> +        } else {
> +            error_report("Unknown ramblock \"%s\", cannot accept "
> +                         "migration", id);
> +            ret = -EINVAL;
> +        }
> +        total_ram_bytes -= length;
> +    }
> +
> +    return ret;
> +}
> +
>  /**
>   * ram_load_precopy: load pages in precopy case
>   *
> @@ -3840,14 +3916,13 @@ static int ram_load_precopy(QEMUFile *f)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      int flags = 0, ret = 0, invalid_flags = 0, len = 0, i = 0;
> -    /* ADVISE is earlier, it shows the source has the postcopy capability on */
> -    bool postcopy_advised = migration_incoming_postcopy_advised();
> +
>      if (!migrate_compress()) {
>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
>      }
>  
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> -        ram_addr_t addr, total_ram_bytes;
> +        ram_addr_t addr;
>          void *host = NULL, *host_bak = NULL;
>          uint8_t ch;
>  
> @@ -3918,65 +3993,7 @@ static int ram_load_precopy(QEMUFile *f)
>  
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
>          case RAM_SAVE_FLAG_MEM_SIZE:
> -            /* Synchronize RAM block list */
> -            total_ram_bytes = addr;
> -            while (!ret && total_ram_bytes) {
> -                RAMBlock *block;
> -                char id[256];
> -                ram_addr_t length;
> -
> -                len = qemu_get_byte(f);
> -                qemu_get_buffer(f, (uint8_t *)id, len);
> -                id[len] = 0;
> -                length = qemu_get_be64(f);
> -
> -                block = qemu_ram_block_by_name(id);
> -                if (block && !qemu_ram_is_migratable(block)) {
> -                    error_report("block %s should not be migrated !", id);
> -                    ret = -EINVAL;
> -                } else if (block) {
> -                    if (length != block->used_length) {
> -                        Error *local_err = NULL;
> -
> -                        ret = qemu_ram_resize(block, length,
> -                                              &local_err);
> -                        if (local_err) {
> -                            error_report_err(local_err);
> -                        }
> -                    }
> -                    /* For postcopy we need to check hugepage sizes match */
> -                    if (postcopy_advised && migrate_postcopy_ram() &&
> -                        block->page_size != qemu_host_page_size) {
> -                        uint64_t remote_page_size = qemu_get_be64(f);
> -                        if (remote_page_size != block->page_size) {
> -                            error_report("Mismatched RAM page size %s "
> -                                         "(local) %zd != %" PRId64,
> -                                         id, block->page_size,
> -                                         remote_page_size);
> -                            ret = -EINVAL;
> -                        }
> -                    }
> -                    if (migrate_ignore_shared()) {
> -                        hwaddr addr = qemu_get_be64(f);
> -                        if (migrate_ram_is_ignored(block) &&
> -                            block->mr->addr != addr) {
> -                            error_report("Mismatched GPAs for block %s "
> -                                         "%" PRId64 "!= %" PRId64,
> -                                         id, (uint64_t)addr,
> -                                         (uint64_t)block->mr->addr);
> -                            ret = -EINVAL;
> -                        }
> -                    }
> -                    ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
> -                                          block->idstr);
> -                } else {
> -                    error_report("Unknown ramblock \"%s\", cannot "
> -                                 "accept migration", id);
> -                    ret = -EINVAL;
> -                }
> -
> -                total_ram_bytes -= length;
> -            }
> +            ret = parse_ramblocks(f, addr);
>              break;
>  
>          case RAM_SAVE_FLAG_ZERO:


