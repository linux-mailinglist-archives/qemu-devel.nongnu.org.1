Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF21E763E54
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOiml-0006ny-5t; Wed, 26 Jul 2023 13:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOimj-0006nb-6B
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOimg-0006gY-9X
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690394327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qsJ81P3Yc0tXezbtPfn09Xq4XIQUe+feLg8N9sO2c0M=;
 b=JW7njxNnAAr//d7IHS2lSrPK3nBRjtoFK1nP/6MY6KKOggk1tmW+7X/nH0nE3JMbCUjs0L
 sc218JD/e1iwalf5JepsY6t36xBochNmdDWZ4edK91XdFEhsi87q3OVMlgqd3lQgFXmqZP
 Y36aejE44CxzSgmvgSq2A14DR67sZJc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-JdpMduygNuG5PtoatPXN-w-1; Wed, 26 Jul 2023 13:58:46 -0400
X-MC-Unique: JdpMduygNuG5PtoatPXN-w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4068841fccfso32881cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 10:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690394325; x=1690999125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsJ81P3Yc0tXezbtPfn09Xq4XIQUe+feLg8N9sO2c0M=;
 b=j0zPabSKmb6I5nzp9pqTgxwV93s1C7ugThh8KNxSTjEkHpnjf8iufBNzK1Q3E+pk7r
 4FOYsFRBu+ONIwWpl0XB4QgvCf3Ey1SmwWjr+5p0aD2GICL/UXsmua9H7OKtA2ZL6e3F
 dcRPtKV/+bczXTrim9PesHTYTO7rOYDv6EQZmNU4TwdTW7wsbUZ5VxgQMAknPm1IDeVV
 N6HguyYMhEZ3T4RnOVPrH21tmmNyh2Pry3CjmuaG+ro4vqYzYncFCYuSEXqO1jWM1j3P
 1SwLDhrSokkgQpdhtem8VwRbdidFu2314kqKbl+qXK+FBZ+Gj2L4YweNim4CW5yQS1HS
 siBA==
X-Gm-Message-State: ABy/qLbPFMQ72R7QFVKRHXMdYMZG3t0VuQnlSXOu+Ppx/ZPWANgja9ZO
 tkr1/5AZ3Qn5JEzpay8JQ9RMHTR8be1z1T1wNQ+LdB+YUagpH97gijUgu3c82Hdyn4ABO8gW/81
 7cjgrwpp46OsLAJw=
X-Received: by 2002:ac8:5c10:0:b0:403:aac6:7a1d with SMTP id
 i16-20020ac85c10000000b00403aac67a1dmr3704838qti.3.1690394325582; 
 Wed, 26 Jul 2023 10:58:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGbDVCqiDAc+3er1bQ/Z+YfsrYDgBuaDrgoj8iqteW/XVEa2iZ/RqCvsrxqeKtyNdaALY1+Q==
X-Received: by 2002:ac8:5c10:0:b0:403:aac6:7a1d with SMTP id
 i16-20020ac85c10000000b00403aac67a1dmr3704815qti.3.1690394325219; 
 Wed, 26 Jul 2023 10:58:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p7-20020ac84087000000b004054b435f8csm4281598qtl.65.2023.07.26.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 10:58:44 -0700 (PDT)
Date: Wed, 26 Jul 2023 13:58:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Nikolay Borisov <nborisov@suse.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] migration/ram: Refactor precopy ram loading code
Message-ID: <ZMFe0g7m/DBb5t8g@x1n>
References: <20230725132651.18635-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725132651.18635-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 25, 2023 at 10:26:51AM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Extract the ramblock parsing code into a routine that operates on the
> sequence of headers from the stream and another the parses the
> individual ramblock. This makes ram_load_precopy() easier to
> comprehend.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Still a few comments, not directly relevant to this patch.

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

Starting from here, IIUC we can already fail the whole thing if ret!=0.
IOW, ram_control_load_hook() may not be required for error cases.

Can leave that until later even if it applies.

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
> -- 
> 2.35.3
> 

-- 
Peter Xu


