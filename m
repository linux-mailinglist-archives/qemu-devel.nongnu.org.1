Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1C769AFB
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQV0p-00036G-Ij; Mon, 31 Jul 2023 11:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qQV0o-0002zW-1n
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qQV0m-0007xY-BJ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690818042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=vegjQskteuAAz05lOT7+ufzOhsZ6HubdAsmLAzkG8NQ=;
 b=FQbv497u7fn2FkdJ38Mh4RT8jJfURSWjc+aAEskVBIUlGyAut9AuzGmJ4L0+g+j8m31JfD
 IKpqdupONwIGkaKk5/s7s5qX+39XY8AU3codGYzBD0/82XVDbCGCss4WmL9giLOkO1fp/l
 6OnXjoquw1Qdqf3JlAJcmnMVfScx1u0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-fs1rsnLpNNmXkmkV7T2S4Q-1; Mon, 31 Jul 2023 11:40:39 -0400
X-MC-Unique: fs1rsnLpNNmXkmkV7T2S4Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E6238564EF
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 15:40:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04F7F401DA9;
 Mon, 31 Jul 2023 15:40:38 +0000 (UTC)
Date: Mon, 31 Jul 2023 11:40:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Kalenyuk <akalenyu@redhat.com>, Adam Litke <alitke@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: qemu-img cache modes with Linux cgroup v1
Message-ID: <20230731154036.GA1258836@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IFbJU2RvVR3inYOP"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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


--IFbJU2RvVR3inYOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
qemu-img -t writeback -T writeback is not designed to run with the Linux
cgroup v1 memory controller because dirtying too much page cache leads
to process termination instead of usual non-cgroup and cgroup v2
throttling behavior:
https://bugzilla.redhat.com/show_bug.cgi?id=2196072

I wanted to share my thoughts on this issue.

cache=none bypasses the host page cache and will not hit the cgroup
memory limit. It's an easy solution to avoid exceeding the cgroup v1
memory limit.

However, not all Linux file systems support O_DIRECT and qemu-img's I/O
pattern may perform worse under cache=none than cache=writeback.

1. Which file systems support O_DIRECT in Linux 6.5?

I searched the Linux source code for file systems that implement
.direct_IO or set FMODE_CAN_ODIRECT. This is not exhaustive and may not
be 100% accurate.

The big name file systems (ext4, XFS, btrfs, nfs, smb, ceph) support
O_DIRECT. The most obvious omission is tmpfs.

If your users are running file systems that support O_DIRECT, then
qemu-img -t none -T none is an easy solution to the cgroup v1 memory
limit issue.

Supported:
9p
affs
btrfs
ceph
erofs
exfat
ext2
ext4
f2fs
fat
fuse
gfs2
hfs
hfsplus
jfs
minix
nfs
nilfs2
ntfs3
ocfs2
orangefs
overlayfs
reiserfs
smb
udf
xfs
zonefs

Unsupported:
adfs
befs
bfs
cramfs
ecryptfs
efs
freevxfs
hpfs
hugetlbfs
isofs
jffs2
ntfs
omfs
qnx4
qnx6
ramfs
romfs
squashfs
sysv
tmpfs
ubifs
ufs
vboxsf

2. Is qemu-img performance with O_DIRECT acceptable?

The I/O pattern matters more with O_DIRECT because every I/O request is
sent to the storage device. This means buffer sizes matter more (more
small I/Os have higher overhead than fewer large I/Os). Concurrency can
also help saturate the storage device.

If you switch to O_DIRECT and encounter performance problems then
qemu-img can be optimized to send I/O patterns with less overhead. This
requires performance analysis.

3. Using buffered I/O because O_DIRECT is not universally supported?

If you can't use O_DIRECT, then qemu-img could be extended to manage its
dirty page cache set carefully. This consists of picking a budget and
writing back to disk when the budget is exhausted. Richard Jones has
shared links covering posix_fadvise(2) and sync_file_range(2):
https://lkml.iu.edu/hypermail/linux/kernel/1005.2/01845.html
https://lkml.iu.edu/hypermail/linux/kernel/1005.2/01953.html

We can discuss qemu-img code changes and performance analysis more if
you decide to take that direction.

Hope this helps!

Stefan

--IFbJU2RvVR3inYOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTH1fQACgkQnKSrs4Gr
c8iz1Af/cXwimTTNPAIfIU8q92eABF6de5YCgpnRBcxTWwbb820eslLP4a2Z3gnO
23Oz0bJq7O3Uu2v1DgKhZAbKFOnD+fvgKPCoa6i4PY9skvT+UhEcDhNQRdcOC+O0
iLGky4wq1hFMi1RQo0YOutvgeHr3S1ISopfNVEQo5rDjaEVOiex70ajVOycUe4BJ
T7QdC7LuWQz8z4r+Xtt8/bp4tf/15uKdsSosVsG/SfXyl0vu0SBTj2g/6vO6Jbvf
2byozDynjrwSkcH2K/GKafrY3hZzBJXfTcaq/L748n0d7mgJm1OlV+c1vT+TM0fW
q+DPLuF6L+UjoAPhra1X8kNsYbWSmA==
=ABKD
-----END PGP SIGNATURE-----

--IFbJU2RvVR3inYOP--


