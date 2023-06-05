Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0C7229CA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BXZ-0006g3-6p; Mon, 05 Jun 2023 10:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6BXD-0006eb-Ad
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6BXA-0005oA-Dn
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685976610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETmp04bFYwznZqdAcbPfwwx3M/dsR4G79XswLamaSoE=;
 b=ZSWJ+PalF6WD1vhNBAL0jCulusl/0uO4ybDBBidp7anonGw5iZZ+2bglRO2UTX4s9hJnxM
 zlf6rqbOdntrTYlsSQr3AYKl27ruMbD9CArVqpiEBVFDoLmXH6SUARabCgtcmAuO0tEfcF
 gQ/zUu9ynJB+wk9uo0YchWcJYEHr2qA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-5pOeK9t2OkyUOIKKmN4rPg-1; Mon, 05 Jun 2023 10:50:07 -0400
X-MC-Unique: 5pOeK9t2OkyUOIKKmN4rPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4BF8185A795;
 Mon,  5 Jun 2023 14:50:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A76C47AE4;
 Mon,  5 Jun 2023 14:50:04 +0000 (UTC)
Date: Mon, 5 Jun 2023 09:50:02 -0500
From: Eric Blake <eblake@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com, 
 hare@suse.de, stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC 2/4] qcow2: add configurations for zoned format extension
Message-ID: <2zh6udqosmpjgct2fzoamehvpefmdltuqepnsq2myxirdcbamf@vpc5tsd3shy2>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605104108.125270-3-faithilikerun@gmail.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 05, 2023 at 06:41:06PM +0800, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires following arguments: the device size, zoned profile,
> zoned model, zone size, zone capacity, number of conventional
> zones, limits on zone resources (max append sectors, max open
> zones, and max_active_zones).
> 
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
> zone_size=64M -o zone_capacity=64M -o zone_nr_conv=0 -o
> max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
>  -o zoned_profile=zbc
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c                    | 119 +++++++++++++++++++++++++++++++
>  block/qcow2.h                    |  21 ++++++
>  include/block/block-common.h     |   5 ++
>  include/block/block_int-common.h |   8 +++
>  qapi/block-core.json             |  46 ++++++++----
>  5 files changed, 185 insertions(+), 14 deletions(-)
>
...
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7f3948360d..b886dab42b 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x7a6264
>  
>  static int coroutine_fn
>  qcow2_co_preadv_compressed(BlockDriverState *bs,
> @@ -210,6 +211,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>      uint64_t offset;
>      int ret;
>      Qcow2BitmapHeaderExt bitmaps_ext;
> +    Qcow2ZonedHeaderExtension zoned_ext;
>  
>      if (need_update_header != NULL) {
>          *need_update_header = false;
> @@ -431,6 +433,37 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>              break;
>          }
>  
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {

Missing a patch to docs/interop/qcow2.txt that describes the new
header so that other qcow2 implementations can be interoperable with
it.

[unrelated - maybe we should convert that file to .rst someday?]

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


