Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DDAAC4FAB
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 15:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuIA-0005DM-Qy; Tue, 27 May 2025 09:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJuI8-0005CW-8R
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJuI3-0000PE-5G
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748352258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcRUvE5dE5l86QNoxs1vk/UDaK64uVuRT2WZtrGXbEg=;
 b=DSMnNeQ4drHETCy6Yk3SHek089OfTLz4Rmm0ah5sSMRc0YnRlvqjibQEFCkmjkJ6t/2UwD
 TcglwzVqwP9jQT3PIPdsVKKKnRpeFvy2qwTR7litTZxGzN4TFV/UP/Fu2ePcfi/N6dXua5
 ypqXvtK5ohPCHERI+63uJUnwp6EJ8GQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-lHCUnTwFOqWg8vlnbH3UsA-1; Tue,
 27 May 2025 09:24:14 -0400
X-MC-Unique: lHCUnTwFOqWg8vlnbH3UsA-1
X-Mimecast-MFC-AGG-ID: lHCUnTwFOqWg8vlnbH3UsA_1748352253
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B69731800DA2; Tue, 27 May 2025 13:24:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82D0C180049D; Tue, 27 May 2025 13:24:10 +0000 (UTC)
Date: Tue, 27 May 2025 08:24:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 3/3] iotests: Filter out ZFS in several tests
Message-ID: <fujft74dr27b2swzgxpo5a6fim7h6phyjvpta7s2p3nqqyl5eq@tkh4vmdgowcw>
References: <20250523163041.2548675-5-eblake@redhat.com>
 <20250523163041.2548675-8-eblake@redhat.com>
 <6eff882f-0a71-456d-b3ff-16d82ec9b8ff@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eff882f-0a71-456d-b3ff-16d82ec9b8ff@proxmox.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 26, 2025 at 11:42:24AM +0200, Fiona Ebner wrote:
> Am 23.05.25 um 18:27 schrieb Eric Blake:
> > Fiona reported that ZFS makes sparse file testing awkward, since:
> > - it has asynchronous allocation (not even 'fsync $file' makes du see
> >   the desired size; it takes the slower 'fsync -f $file' which is not
> >   appropriate for the tests)
> > - for tests of fully allocated files, ZFS with compression enabled
> >   still reports smaller disk usage
> > 
> > Add a new _require_sparse_file that quickly probes whether an attempt
> 
> It's called _require_disk_usage in the implementation.

I'll fix it (obviously, my efforts to rebase to a better name missed
this one.)

> 
> > to create a sparse 5M file shows as less than 1M usage, while the same
> > file with -o preallocation=full shows as more than 4M usage without
> > sync, which should filter out ZFS behavior.  Then use it in various
> > affected tests.
> > 
> > This does not add the new filter on all tests that Fiona is seeing ZFS
> > failures on, but only those where I could quickly spot that there is
> > at least one place where the test depends on the output of 'du -b' or
> > 'stat -c %b'.
> > 
> > Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Series is now queued in my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


