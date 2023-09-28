Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 460FF7B25E2
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwW1-0001Kf-1c; Thu, 28 Sep 2023 15:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlwVm-0001K2-8Y
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlwVk-0000Pz-9V
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695928638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63hQC9tBeXhoMXwWH2yqmY74/jppF2NnClhjYZjMrjM=;
 b=U+hgKY05VCQhBans2a0elCrWizh3vugiTwpcQ5K8cY0hBMWWG+i2drQNcNcRBw2KlH90Fb
 2XZozAOa5YkQYce1ihkfns6gejpZTgmcBttnGrcaGQq2B+i62fc02p9/1VbvGFuNwCSyKf
 CqF0hwwal5e17Q+InGtP0uqxpNC9IVY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-PAAQCp4KODu1kq2p8VM04A-1; Thu, 28 Sep 2023 15:17:16 -0400
X-MC-Unique: PAAQCp4KODu1kq2p8VM04A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2745F3C1CC33;
 Thu, 28 Sep 2023 19:17:16 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95111215670B;
 Thu, 28 Sep 2023 19:17:14 +0000 (UTC)
Date: Thu, 28 Sep 2023 14:17:12 -0500
From: Eric Blake <eblake@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, 
 stefanha@redhat.com, hare@suse.de, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 3/4] qcow2: add zoned emulation capability
Message-ID: <grw7r46o3mkaszignhfexvdquamlau3ycazdiz26lpfs4jiepv@etfjsofexr5x>
References: <20230918095313.5492-1-faithilikerun@gmail.com>
 <20230918095313.5492-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918095313.5492-4-faithilikerun@gmail.com>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 18, 2023 at 05:53:12PM +0800, Sam Li wrote:
> By adding zone operations and zoned metadata, the zoned emulation
> capability enables full emulation support of zoned device using
> a qcow2 file. The zoned device metadata includes zone type,
> zoned device state and write pointer of each zone, which is stored
> to an array of unsigned integers.
> 
> Each zone of a zoned device makes state transitions following
> the zone state machine. The zone state machine mainly describes
> five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
> READ ONLY and OFFLINE states will generally be affected by device
> internal events. The operations on zones cause corresponding state
> changing.
> 
> Zoned devices have a limit on zone resources, which puts constraints on
> write operations into zones.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c          | 709 ++++++++++++++++++++++++++++++++++++++++-
>  block/qcow2.h          |   2 +
>  block/trace-events     |   2 +
>  docs/interop/qcow2.txt |   6 +
>  4 files changed, 717 insertions(+), 2 deletions(-)

You may want to look at scripts/git.orderfile; putting spec changes
(docs/*) first in your output before implementation is generally
beneficial to reviewers.

> +++ b/docs/interop/qcow2.txt
> @@ -367,6 +367,12 @@ The fields of the zoned extension are:
>                      The maximal number of 512-byte sectors of a zone
>                      append request that can be issued to the device.
>  
> +          36 - 43:  zonedmeta_offset
> +                    The offset of zoned metadata structure in the file in bytes.

For the spec to be useful, you also need to add a section describing
the layout of the zoned metadata structure actually is.

> +
> +          44 - 51:  zonedmeta_size
> +                    The size of zoned metadata in bytes.
> +

Can the zoned metadata structure ever occupy more than 4G, or can this
field be sized at 4 bytes instead of 8?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


