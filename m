Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC13AC7102
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 20:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZp-0002eT-RL; Wed, 28 May 2025 14:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKLZZ-0002N0-MK
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKLZW-00074T-Em
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZAQHHYSTahT/ZSYmxAJ4lSFVlOA739QiZJB9QotBUpw=;
 b=OOYIl9WpJ15qJtDeyJeB0tEMx6Haw2rED3Q70feQ0/IOIWzcQYyRGYnVDzXUIaEuQG+4ik
 FXm84XWe3tkN7DO/APS2fsrSIDQjyMNZqJG2hQj1U5sUvnF7/tHtbKHrb3xPJDoZ09MQ6u
 E5uBkZkLX9WTClnQ3q84pq3V9f9hdBk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-Asd_5fNoPgmEr0jzgG_mWA-1; Wed,
 28 May 2025 14:32:10 -0400
X-MC-Unique: Asd_5fNoPgmEr0jzgG_mWA-1
X-Mimecast-MFC-AGG-ID: Asd_5fNoPgmEr0jzgG_mWA_1748457129
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D045B19560A3; Wed, 28 May 2025 18:32:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA7AA1956095; Wed, 28 May 2025 18:32:06 +0000 (UTC)
Date: Wed, 28 May 2025 13:32:04 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, f.ebner@proxmox.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/3] iotests: Improve mirror-sparse on ext4
Message-ID: <zv3gucwyoogzcamqvzskfodvzbbxlg64radbut2sq53avi5qud@w6n4pxekypzc>
References: <20250523163041.2548675-5-eblake@redhat.com>
 <20250523163041.2548675-7-eblake@redhat.com>
 <ibn5a3mq4co2h5rpslkq42hir4ka4dz5fsgcbmuwqnoiwarhmf@5qlu3ssskquc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ibn5a3mq4co2h5rpslkq42hir4ka4dz5fsgcbmuwqnoiwarhmf@5qlu3ssskquc>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Wed, May 28, 2025 at 10:45:35AM -0500, Eric Blake wrote:
> On Fri, May 23, 2025 at 11:27:22AM -0500, Eric Blake wrote:
> > Fiona reported that an ext4 filesystem on top of LVM can sometimes
> > report over-allocation to du (based on the hueristics the filesystem
> > is making while observing the contents being mirrored); even though
> > the contents and actual size matched, about 50% of the time the size
> > reported by disk_usage was too large by 4k, failing the test.  In
> > auditing other iotests, this is a common problem we've had to deal
> > with.
> > 
> > Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> > Fixes: c0ddcb2c ("tests: Add iotest mirror-sparse for recent patches")
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> > Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> > 
> > ---
> > v2: Drop sync for ZFS
> > ---
> >  tests/qemu-iotests/tests/mirror-sparse | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Squashing this in since Markus is reporting failures even with this
> patch applied, and I'm lacking enough context to see what else might
> be interfering:
> 
> diff --git i/tests/qemu-iotests/tests/mirror-sparse w/tests/qemu-iotests/tests/mirror-sparse
> index 39e3196c811..a30e52de41d 100755
> --- i/tests/qemu-iotests/tests/mirror-sparse
> +++ w/tests/qemu-iotests/tests/mirror-sparse
> @@ -105,7 +105,7 @@ if test $result -lt $((3*1024*1024)); then
>  elif test $result -gt $((19*1024*1024)); then
>      actual=full
>  else
> -    actual=unknown
> +    actual="unexpected size ($result)"

I reproduced Markus' situation on XFS (since XFS is easier than ZFS to
install on Fedora) - it turns out that XFS rounds disk usage in terms
of allocation groups which default to a size of 1M; so I need to treat
exactly 3M as sparse, not unknown.  I'm also squashing in:

diff --git i/tests/qemu-iotests/tests/mirror-sparse w/tests/qemu-iotests/tests/mirror-sparse
index a30e52de41d..cfcaa600ab4 100755
--- i/tests/qemu-iotests/tests/mirror-sparse
+++ w/tests/qemu-iotests/tests/mirror-sparse
@@ -100,7 +100,7 @@ $QEMU_IMG compare -U -f $IMGFMT -F raw $TEST_IMG.base $TEST_IMG
 # Some filesystems can fudge allocations for various reasons; rather
 # than expecting precise 2M and 20M images, it is better to allow for slop.
 result=$(disk_usage $TEST_IMG)
-if test $result -lt $((3*1024*1024)); then
+if test $result -lt $((4*1024*1024)); then
     actual=sparse
 elif test $result -gt $((19*1024*1024)); then
     actual=full


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


