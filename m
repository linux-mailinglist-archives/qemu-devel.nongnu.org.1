Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD3682441D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLP1X-0005f4-R1; Thu, 04 Jan 2024 09:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLP1W-0005ew-NX
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLP1U-0000Hh-Vc
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704379720;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aeRLJG4Sxvh5NOmY37x5W+FelIDThdPqN4ep7D960no=;
 b=CdH7qyGimq4XyboVMt6EHq/vetYisfAH8G+1gEgXffwXXMQZ/clBnuKfpjiaZnU4oK7Rub
 I24Uu1GGHGPFyruziwwQxRxvUo6TWaVbcqKF1cOKzeusEm0Umwvxx2FQNh0nplmAI/kdov
 2gJKTeyC0TycHDx6o58wjonTvlAq1gw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-4aVNiQ9oNHuErBCs_FN82w-1; Thu, 04 Jan 2024 09:48:39 -0500
X-MC-Unique: 4aVNiQ9oNHuErBCs_FN82w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4C7D85A588;
 Thu,  4 Jan 2024 14:48:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E11BF1C060AF;
 Thu,  4 Jan 2024 14:48:36 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:48:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RESEND v3 05/10] crypto: Mark the payload_offset_sector
 invalid for detached LUKS header
Message-ID: <ZZbFQod-d0Zt95M6@redhat.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
 <02d08ca67a4ec88cee61446d6b330c2945b5588f.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02d08ca67a4ec88cee61446d6b330c2945b5588f.1703482349.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Dec 25, 2023 at 01:45:07PM +0800, Hyman Huang wrote:
> Set the payload_offset_sector to a value that is nearly never reached
> in order to mark it as invalid and indicate that 0 should be the offset
> of the read/write operation on the 'file' protocol blockdev node.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  crypto/block-luks.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index fb01ec38bb..48443ffcae 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -34,6 +34,8 @@
>  
>  #include "qemu/bitmap.h"
>  
> +#define INVALID_SECTOR_OFFSET UINT32_MAX
> +
>  /*
>   * Reference for the LUKS format implemented here is
>   *
> @@ -136,6 +138,13 @@ struct QCryptoBlockLUKS {
>  };
>  
>  
> +static inline uint32_t
> +qcrypto_block_luks_payload_offset(uint32_t sector)
> +{
> +    return sector == INVALID_SECTOR_OFFSET ? 0 :
> +        sector * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
> +}
> +
>  static int qcrypto_block_luks_cipher_name_lookup(const char *name,
>                                                   QCryptoCipherMode mode,
>                                                   uint32_t key_bytes,
> @@ -1255,8 +1264,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>      }
>  
>      block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
> -    block->payload_offset = luks->header.payload_offset_sector *
> -        block->sector_size;
> +    block->payload_offset =
> +        qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
>  
>      return 0;
>  
> @@ -1529,16 +1538,28 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>          slot->stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
>      }
>  
> -    /* The total size of the LUKS headers is the partition header + key
> -     * slot headers, rounded up to the nearest sector, combined with
> -     * the size of each master key material region, also rounded up
> -     * to the nearest sector */
> -    luks->header.payload_offset_sector = header_sectors +
> -            QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
> +    if (block->detached_header) {
> +        /*
> +         * Set the payload_offset_sector to a value that is nearly never
> +         * reached in order to mark it as invalid and indicate that 0 should
> +         * be the offset of the read/write operation on the 'file' protocol
> +         * blockdev node. Here the UINT32_MAX is choosed
> +         */
> +        luks->header.payload_offset_sector = INVALID_SECTOR_OFFSET;

We should be setting payload offset to 0 when using a detached header
to match behaviour of 'cryptsetup' tools.

> +    } else {
> +        /*
> +         * The total size of the LUKS headers is the partition header + key
> +         * slot headers, rounded up to the nearest sector, combined with
> +         * the size of each master key material region, also rounded up
> +         * to the nearest sector
> +         */
> +        luks->header.payload_offset_sector = header_sectors +
> +                QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
> +    }
>  
>      block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
> -    block->payload_offset = luks->header.payload_offset_sector *
> -        block->sector_size;
> +    block->payload_offset =
> +        qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
>  
>      /* Reserve header space to match payload offset */
>      initfunc(block, block->payload_offset, opaque, &local_err);
> -- 
> 2.39.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


