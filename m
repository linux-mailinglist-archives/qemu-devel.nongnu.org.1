Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C0872905
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Mar 2024 21:59:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbrw-0002lm-CL; Tue, 05 Mar 2024 15:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhbrr-0002ke-Sy
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:58:31 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhbrp-0005gl-OR
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:58:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6115733B0B;
 Tue,  5 Mar 2024 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709672306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GYx8woq3xHUDrW1PoyPYTO0GU3PLo0jxe+rthQZ3OUk=;
 b=mpVG/qIT10/tShOBznq74smVu8X+sbHK5WEiEsTEhhFIEy7Vfj5xUP56OIeHBHEF7/nmDx
 ZzQWbSEzSxa3tWlZPYmgH0hcvUP+Bc7iGYbjzO02hMBef6ggs6rVphvJBsWkYfsOifHYfa
 TqS0pggN1A22uDD7sSknNslXau7yudY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709672306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GYx8woq3xHUDrW1PoyPYTO0GU3PLo0jxe+rthQZ3OUk=;
 b=ZibcUE3fQh33O2FT9a3duKzKSbv85XdSLovBGMzU+HaxN8vCdM2Uut174ad2C+SmJ6uyQt
 AMUr6iyK88lyC5Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709672305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GYx8woq3xHUDrW1PoyPYTO0GU3PLo0jxe+rthQZ3OUk=;
 b=k89S0esr2NKCT38ixSK76WfDXwKvPbrxNc9leuwYK8u6fqPqiLwWvBHp3xC4sAD6aU0iXr
 ZhZUnMkRvu469OpMFVnkIMFRb/LeaecgcakwwbLQLC3egg6wsKB7jPw/c+lghX/3yYKZkz
 AE5Lu74dKugJPPMbgfXG5PeSy75TdZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709672305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GYx8woq3xHUDrW1PoyPYTO0GU3PLo0jxe+rthQZ3OUk=;
 b=f3/hfLh1fdCLEkVuawD9XyniNCDX9PJu0SOckARQZWplAqWuuNE/Idh+0wB9/Nou/rUA/Y
 ni6FWQzz4uND63Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5A4713A5B;
 Tue,  5 Mar 2024 20:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 03TaJnCH52UoRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Mar 2024 20:58:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v4 4/8] migration/multifd: add qpl compression method
In-Reply-To: <20240304140028.1590649-5-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
 <20240304140028.1590649-5-yuan1.liu@intel.com>
Date: Tue, 05 Mar 2024 17:58:22 -0300
Message-ID: <87wmqggzv5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.10
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Yuan Liu <yuan1.liu@intel.com> writes:

> add the Query Processing Library (QPL) compression method
>
> Although both qpl and zlib support deflate compression, qpl will
> only use the In-Memory Analytics Accelerator(IAA) for compression
> and decompression, and IAA is not compatible with the Zlib in
> migration, so qpl is used as a new compression method for migration.
>
> How to enable qpl compression during migration:
> migrate_set_parameter multifd-compression qpl
>
> The qpl only supports one compression level, there is no qpl
> compression level parameter added, users do not need to specify
> the qpl compression level.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  hw/core/qdev-properties-system.c |   2 +-
>  migration/meson.build            |   1 +
>  migration/multifd-qpl.c          | 158 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   1 +
>  qapi/migration.json              |   7 +-
>  5 files changed, 167 insertions(+), 2 deletions(-)
>  create mode 100644 migration/multifd-qpl.c
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 1a396521d5..b4f0e5cbdb 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -658,7 +658,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>  const PropertyInfo qdev_prop_multifd_compression = {
>      .name = "MultiFDCompression",
>      .description = "multifd_compression values, "
> -                   "none/zlib/zstd",
> +                   "none/zlib/zstd/qpl",
>      .enum_table = &MultiFDCompression_lookup,
>      .get = qdev_propinfo_get_enum,
>      .set = qdev_propinfo_set_enum,
> diff --git a/migration/meson.build b/migration/meson.build
> index 92b1cc4297..c155c2d781 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
>    system_ss.add(files('block.c'))
>  endif
>  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
> +system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
>  
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>                  if_true: files('ram.c',
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> new file mode 100644
> index 0000000000..6b94e732ac
> --- /dev/null
> +++ b/migration/multifd-qpl.c
> @@ -0,0 +1,158 @@
> +/*
> + * Multifd qpl compression accelerator implementation
> + *
> + * Copyright (c) 2023 Intel Corporation
> + *
> + * Authors:
> + *  Yuan Liu<yuan1.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/rcu.h"
> +#include "exec/ramblock.h"
> +#include "exec/target_page.h"
> +#include "qapi/error.h"
> +#include "migration.h"
> +#include "trace.h"
> +#include "options.h"
> +#include "multifd.h"
> +#include "qpl/qpl.h"

I don't mind adding a skeleton upfront before adding the implementation,
but adding the headers here hurts the review process. Reviewers will
have to go digging through the next patches to be able to validate each
of these. It's better to include them along with their usage.

What I would do in this patch is maybe just add the new option, the
.json and meson changes and this file with just:

static void multifd_qpl_register(void)
{
    /* noop */
}

Then in the next commit you can implement all the methods in one
go. That way, the docstrings come along with the implementation, which
also facilitates review.

> +
> +struct qpl_data {

typedef struct {} QplData/QPLData, following QEMU's coding style.

> +    qpl_job **job_array;
> +    /* the number of allocated jobs */
> +    uint32_t job_num;
> +    /* the size of data processed by a qpl job */
> +    uint32_t data_size;
> +    /* compressed data buffer */
> +    uint8_t *zbuf;
> +    /* the length of compressed data */
> +    uint32_t *zbuf_hdr;
> +};
> +
> +/**
> + * qpl_send_setup: setup send side
> + *
> + * Setup each channel with QPL compression.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}
> +
> +/**
> + * qpl_send_cleanup: cleanup send side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +}
> +
> +/**
> + * qpl_send_prepare: prepare data to be able to send
> + *
> + * Create a compressed buffer with all the pages that we are going to
> + * send.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}
> +
> +/**
> + * qpl_recv_setup: setup receive side
> + *
> + * Create the compressed channel and buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}
> +
> +/**
> + * qpl_recv_cleanup: setup receive side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void qpl_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    /* Implement in next patch */
> +}
> +
> +/**
> + * qpl_recv_pages: read the data from the channel into actual pages
> + *
> + * Read the compressed buffer, and uncompress it into the actual
> + * pages.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_recv_pages(MultiFDRecvParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}
> +
> +/**
> + * qpl_get_iov_count: get the count of IOVs
> + *
> + * For QPL compression, in addition to requesting the same number of IOVs
> + * as the page, it also requires an additional IOV to store all compressed
> + * data lengths.
> + *
> + * Returns the count of the IOVs
> + *
> + * @page_count: Indicate the maximum count of pages processed by multifd
> + */
> +static uint32_t qpl_get_iov_count(uint32_t page_count)
> +{
> +    return page_count + 1;
> +}
> +
> +static MultiFDMethods multifd_qpl_ops = {
> +    .send_setup = qpl_send_setup,
> +    .send_cleanup = qpl_send_cleanup,
> +    .send_prepare = qpl_send_prepare,
> +    .recv_setup = qpl_recv_setup,
> +    .recv_cleanup = qpl_recv_cleanup,
> +    .recv_pages = qpl_recv_pages,
> +    .get_iov_count = qpl_get_iov_count
> +};
> +
> +static void multifd_qpl_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
> +}
> +
> +migration_init(multifd_qpl_register);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index d82495c508..0e9361df2a 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -33,6 +33,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>  #define MULTIFD_FLAG_NOCOMP (0 << 1)
>  #define MULTIFD_FLAG_ZLIB (1 << 1)
>  #define MULTIFD_FLAG_ZSTD (2 << 1)
> +#define MULTIFD_FLAG_QPL (4 << 1)
>  
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5a565d9b8d..e48e3d7065 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -625,11 +625,16 @@
>  #
>  # @zstd: use zstd compression method.
>  #
> +# @qpl: use qpl compression method. Query Processing Library(qpl) is based on
> +#       the deflate compression algorithm and use the Intel In-Memory Analytics
> +#       Accelerator(IAA) hardware accelerated compression and decompression.

Missing: (since 9.0)

> +#
>  # Since: 5.0
>  ##
>  { 'enum': 'MultiFDCompression',
>    'data': [ 'none', 'zlib',
> -            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> +            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> +            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
>  
>  ##
>  # @MigMode:

