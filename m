Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110B7DBB61
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:06:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxStP-0002x0-0h; Mon, 30 Oct 2023 10:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxStG-0002vZ-AX
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxStC-0003ZH-Gl
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698674709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5PcIDhmb+D2sLvlJknE43LmyteuDysh6SQrsI1dT2c=;
 b=DroT945TpJhqyI5DeWOX4EikWw2niykAfhrnD2612Ryg/W1MWE+B2XUw26sOlUMDoUUK3d
 pXh7iuB2lFfLA9qPWoP2GByD1q36lNc8wkfKwHZYI8mUWsXOJfq8X/r99FJ2lNWpq/NAZ1
 iC/ALKIiAu2652OVKCZSOBlvAdPGPV4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-LQGqv8q4Mpu5MU2QMmAbcQ-1; Mon, 30 Oct 2023 10:05:05 -0400
X-MC-Unique: LQGqv8q4Mpu5MU2QMmAbcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20B7D101B04F;
 Mon, 30 Oct 2023 14:04:44 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B00855027;
 Mon, 30 Oct 2023 14:04:42 +0000 (UTC)
Date: Mon, 30 Oct 2023 09:04:41 -0500
From: Eric Blake <eblake@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 dmitry.fomichev@wdc.com, stefanha@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 1/4] docs/qcow2: add the zoned format feature
Message-ID: <j5lohqj57qcsjjgqv3n3tm5jv7bjnqlaogg3yvi5ieoto537tk@h5nhmixdnh6p>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-2-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030121847.4522-2-faithilikerun@gmail.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 30, 2023 at 08:18:44PM +0800, Sam Li wrote:
> Add the specs for the zoned format feature of the qcow2 driver.
> The qcow2 file can be taken as zoned device and passed through by
> virtio-blk device or NVMe ZNS device to the guest given zoned
> information.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc | 33 ++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
> index 105cb9679c..4647c5fa29 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -172,6 +172,39 @@ This section describes each format and the options that are supported for it.
>      filename`` to check if the NOCOW flag is set or not (Capital 'C' is
>      NOCOW flag).
>  
> +  .. option:: zoned
> +    1 for host-managed zoned device and 0 for a non-zoned device.

Should this be a bool or enum type, instead of requiring the user to
know magic numbers?  Is there a potential to add yet another type in
the future?

> +
> +  .. option:: zone_size
> +
> +    The size of a zone in bytes. The device is divided into zones of this
> +    size with the exception of the last zone, which may be smaller.
> +
> +  .. option:: zone_capacity
> +
> +    The initial capacity value, in bytes, for all zones. The capacity must
> +    be less than or equal to zone size. If the last zone is smaller, then
> +    its capacity is capped.
> +
> +    The zone capacity is per zone and may be different between zones in real
> +    devices. For simplicity, QCow2 sets all zones to the same capacity.

Just making sure I understand: One possible setup would be to describe
a block device with zones of size 1024M but with capacity 1000M (that
is, the zone reserves 24M capacity for other purposes)?

Otherwise, I'm having a hard time seeing when you would ever set a
capacity different from size.

Are there requirements that one (or both) of these values must be
powers of 2?  Or is the requirement merely that they must be a
multiple of 512 bytes (because sub-sector operations are not
permitted)?  Is there any implicit requirement based on qcow2
implementation that a zone size/capacity must be a multiple of cluster
size (other than possibly for the last zone)?

> +
> +  .. option:: zone_nr_conv
> +
> +    The number of conventional zones of the zoned device.
> +
> +  .. option:: max_open_zones
> +
> +    The maximal allowed open zones.
> +
> +  .. option:: max_active_zones
> +
> +    The limit of the zones with implicit open, explicit open or closed state.
> +
> +  .. option:: max_append_sectors
> +
> +    The maximal number of 512-byte sectors in a zone append request.

Why is this value in sectors instead of bytes?  I understand that
drivers may be written with sectors in mind, but any time we mix units
in the public interface, it gets awkward.  I'd lean towards having
bytes here, with a requirement that it be a multiple of 512.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


