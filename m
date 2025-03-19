Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 211DBA69585
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 17:54:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwgF-0005Nm-Qw; Wed, 19 Mar 2025 12:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tuwg9-0005HY-Mo
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:54:06 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tuwg8-00055I-7P
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:54:05 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1tuwg4-001Tnr-Ky;
 Wed, 19 Mar 2025 16:54:00 +0000
Date: Wed, 19 Mar 2025 16:54:00 +0000
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [PATCH for-10.1 10/32] vfio: Introduce new files for VFIORegion
 definitions and declarations
Message-ID: <Z9r2qCGy3RLgiEMY@movementarian.org>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-11-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318095415.670319-11-clg@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 18, 2025 at 10:53:53AM +0100, C�dric Le Goater wrote:

> Gather all VFIORegion related declarations and definitions into their
> own files to reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".
> 
> These declarations are made available externally (for "sysbus-fdt.c").
> This is for 'vfio-platform' devices which have been deprecated and
> will be removed in QEMU 10.2.
> 
> Signed-off-by: C�dric Le Goater <clg@redhat.com>

> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3e174c3dcb0b699fd0cee00d104250d8ae97f698
> --- /dev/null
> +++ b/hw/vfio/region.c
> @@ -0,0 +1,395 @@
> +/*
> + * low level and IOMMU backend agnostic helpers used by VFIO devices,
> + * related to regions, interrupts, capabilities

This file comment should just refer to regions now.

regards
john

