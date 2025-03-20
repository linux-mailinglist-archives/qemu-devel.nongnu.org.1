Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C36B8A6A2C5
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Mar 2025 10:38:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCLy-0008Al-68; Thu, 20 Mar 2025 05:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tvCLn-00085v-8F
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:38:08 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tvCLl-0000AQ-Ng
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:38:06 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1tvCLk-001hNp-4T;
 Thu, 20 Mar 2025 09:38:04 +0000
Date: Thu, 20 Mar 2025 09:38:04 +0000
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [PATCH for-10.1 29/32] vfio: Rename VFIOContainer related services
Message-ID: <Z9vh/E5ux1hoGDvs@movementarian.org>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-30-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318095415.670319-30-clg@redhat.com>
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

On Tue, Mar 18, 2025 at 10:54:12AM +0100, C�dric Le Goater wrote:

> Rename these routines :
> 
>   vfio_put_group -> vfio_group_put
>   vfio_get_group -> vfio_group_get
>   vfio_kvm_device_del_group -> vfio_group_del_kvm_device
>   vfio_kvm_device_add_group -> vfio_group_add_kvm_device
>   vfio_get_device -> vfio_device_get
>   vfio_put_base_device -> vfio_device_put
>   vfio_device_groupid -> vfio_device_get_groupid
>   vfio_connect_container -> vfio_container_connect
>   vfio_disconnect_container -> vfio_container_disconnect
> 
> to better reflect the namespace they belong to.
> 
> Signed-off-by: C�dric Le Goater <clg@redhat.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

