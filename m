Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36C7B20D4
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 17:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlsk5-00057Y-B6; Thu, 28 Sep 2023 11:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlsk0-00056i-Ih
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 11:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlsjy-00033j-3w
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 11:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695914145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51wfQZE1EvL8VXVBefG8NqtvD/WfCOqG0Jr1LWD5i9c=;
 b=XuurZGegdtmszFn6zp/70RcYs4xa326eikBEhUag5BXw1tBA2m/ehjXLSz5CFShMxu46eY
 I85dWt3CYRLe+Nx6bMc7/B8zgTRLUZ4OagKvoFz034x5UNoHMVcp13/Vgycd/qVihmj4aV
 1HrDLVkQiBXCcGOntxrZtPkiMbu0IG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-GmZecJvIOF-6BAnb1F65iA-1; Thu, 28 Sep 2023 11:15:41 -0400
X-MC-Unique: GmZecJvIOF-6BAnb1F65iA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D46D5811E7D;
 Thu, 28 Sep 2023 15:15:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58B7C2156702;
 Thu, 28 Sep 2023 15:15:39 +0000 (UTC)
Date: Thu, 28 Sep 2023 10:15:37 -0500
From: Eric Blake <eblake@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, 
 stefanha@redhat.com, hare@suse.de, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <b52s4hymg6wkxvbfvhft7xgw3ithcxb3y2a477enenpjcuj43n@vyny33zrkt2w>
References: <20230918095313.5492-1-faithilikerun@gmail.com>
 <20230918095313.5492-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918095313.5492-3-faithilikerun@gmail.com>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 18, 2023 at 05:53:11PM +0800, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires settings as: the device size, zone model, zone size,
> zone capacity, number of conventional zones, limits on zone
> resources (max append sectors, max open zones, and max_active_zones).
> 
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
> zone_size=64M -o zone_capacity=64M -o nr_conv_zones=0 -o
> max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
> -o zone_model=1
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c                    | 186 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  28 +++++
>  docs/interop/qcow2.txt           |  36 ++++++
>  include/block/block_int-common.h |  13 +++
>  qapi/block-core.json             |  30 ++++-
>  5 files changed, 291 insertions(+), 2 deletions(-)

Below, I'll focus only on the spec change, not the implementation:

> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b48cd9ce63..521276fc51 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x7a6264

Why not spell it 0x007a6264 with 8 hex digits, like the others?  (I
get why you choose that constant, though - ascii 'zbd')

> +++ b/docs/interop/qcow2.txt
> @@ -331,6 +331,42 @@ The fields of the bitmaps extension are:
>                     Offset into the image file at which the bitmap directory
>                     starts. Must be aligned to a cluster boundary.
>  
> +== Zoned extension ==

Where is the magic number for this extension called out?  That's
missing, and MUST be part of the spec.

Back-compatibility constraints: you should consider what happens in
both of the following cases:

a program that intends to do read-only access to the qcow2 file but
which does not understand this extension header (for example, an older
version of 'qemu-img convert' being used to extract data from a newer
.qcow2 file with this header present - but also the new 'nbdkit
qcow2dec' decoder plugin just released in nbdkit 1.36).  Is it safe to
read the data as-is, by basically ignoring zone informations?  Or will
that ever produce wrong data (for example, if operations on a
particular zone imply that the guest should read all zeroes after the
current zone offset within that zone, regardless of whether non-zero
content was previously stored at those offsets - then not honoring the
existence of the extension header would require you to add and
document an incompatible feature bit so that reader apps fail to open
the file rather than reading wrong data).

a program that intends to edit the qcow2 file but which does not
understand this extension header (again, consider access by an older
version of qemu).  Is it safe to just write data anywhere in the disk,
but where failure to update the zone metadata means that all
subsequent use of the file MUST behave as if it is now a non-zeoned
device?  If so, then it is sufficient to document an autoclear feature
bit: any time a newer qcow2 writer creates a file with a zoned
extension, it also sets the autoclear feature bit; any time an older
qcow2 writer edits a file with the autoclear bit, it clears the bit
(because it has no idea if its edits invalidated the unknown
extension).  Then when the new qcow2 program again accesses the file,
it knows that the zone information is no longer reliable, and can fall
back to forcing the image to behave as flat.

> +
> +The zoned extension is an optional header extension. It contains fields for
> +emulating the zoned stroage model (https://zonedstorage.io/).

Assuming that you'll need to add one or two feature bits (most likely
an autoclear bit, to prevent editing the file without keeping the zone
information up-to-data, and possibly also an incompatible feature bit,
if interpreting the file even without editing it is impossible without
understanding zones), you'll want to mention this header's relation to
those feature bit(s).

> +
> +The fields of the zoned extension are:
> +    Byte        0:  zoned
> +                    Zoned model, 1 for host-managed and 0 for non-zoned devices.

This tells me nothing about what those two models mean.  You'll need
to describe them better for an independent implementation of a qcow2
reader (such as 'nbdkit qcow2dec') to be able to properly read such a
file with either value, even if it doesn't plan on editing it.

If we do add feature bits, what happens when reading a file when the
feature bits are set but this extension header is missing?

> +
> +            1 - 3:  Reserved, must be zero.
> +
> +            4 - 7:  zone_size
> +                    Total number of logical blocks within the zones in bytes.

This is confusing.  It is a number of blocks, or a number of bytes?  I
would prefer bytes (will we ever have to worry about a device that can
have zones larger than 4G - then make this 8 bytes instead of 4, and
see comments below about alignment), but then word it as:

Total size of each zone, in bytes.

Also, should you require that the zone_size be a multiple of the
cluster size and/or a power of 2?  (That is, if I have a qcow2 file
with 2M clusters, does it make sense to permit a zone size of only 1M,
or should zone size always be at least as large as a cluster?)

> +
> +           8 - 11:  zone_capacity
> +                    The number of writable logical blocks within the zones in
> +                    bytes. A zone capacity is always smaller or equal to the
> +                    zone size.

Again, mixing the term blocks and bytes in the same sentence is confusing.

> +
> +          12 - 15:  nr_conv_zones
> +                    The number of conventional zones.
> +
> +          16 - 19:  nr_zones
> +                    The number of zones.

What's the difference between these two numbers?

> +
> +          20 - 23:  max_active_zones
> +                    The limit of the zones that have the implicit open,
> +                    explicit open or closed state.
> +
> +          24 - 27:  max_open_zones
> +                    The maximal allowed open zones.
> +
> +          28 - 35:  max_append_sectors
> +                    The maximal number of 512-byte sectors of a zone
> +                    append request that can be issued to the device.

Is this value in sectors instead of bytes?  I'd prefer bytes, but then
document that the value must be a multiple of 512.  Also, having a
64-bit number not be 64-bit aligned within the extension header is
unwise.  Please rearrange fields so that all 64-bit fields are 8-byte
aligned.

This structure as written has implicit tail padding (all extension
headers must be 8-byte multiples in the end; but the spec already
documents how that is handled).  Is it worth explicitly calling out
tail padding up to an 8-byte boundary?

> +
>  == Full disk encryption header pointer ==
>  
>  The full disk encryption header must be present if, and only if, the
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index 85be256c09..d169d15dd6 100644
> --- a/include/block/block_int-common.h

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


