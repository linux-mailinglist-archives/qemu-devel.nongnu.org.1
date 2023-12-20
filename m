Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2EA81A194
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 15:58:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFy05-0004DD-KF; Wed, 20 Dec 2023 09:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rFxzz-0004CA-Cy
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 09:56:40 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rFxzw-0003wD-3f
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 09:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703084196; x=1734620196;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=PKc1ISqFtxu2kS1upPQhC9NPSsW4VFR9ZQIe0KkdXMc=;
 b=LeTZKUjpFIMpVStNZpzGq3aokUs5/7TGktb32xjUpzYiICpPOVHkFOP9
 1UGNZvkILRZNU4Y2H1tSWgcnzq5rrKRGwUsfCp0WnOyeI60uXiCP6d5AI
 rcXlmLR+Wj3el7HV/zBp4wzIT25WfS7nFYk7ZdOlu6oFZi/rymCFyC/3Z
 /OVwc4mCPWfNZpB/AfSazVlQZHWuxOuIx5DO1FJYnUm9OfbBiwWRqrKTb
 GSb80tvp++qCwIZhh8RJOPbk+x4A63tT8e6QfFvMC5yvLgi/uerhkEjND
 XxIXCNvHQI/RqZdk0CHF1iX0h3/md1NV9mGWs8ULsFr9WA5JlJHsuKXxy w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2652997"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2652997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 06:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; d="scan'208";a="24597805"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 20 Dec 2023 06:56:28 -0800
Date: Wed, 20 Dec 2023 23:09:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] vfio/container: Replace basename with g_path_get_basename
Message-ID: <ZYMDmBbIua253Xf8@intel.com>
References: <20231220135302.932039-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220135302.932039-1-clg@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On Wed, Dec 20, 2023 at 02:53:02PM +0100, Cédric Le Goater wrote:
> Date: Wed, 20 Dec 2023 14:53:02 +0100
> From: Cédric Le Goater <clg@redhat.com>
> Subject: [PATCH] vfio/container: Replace basename with g_path_get_basename
> X-Mailer: git-send-email 2.43.0
> 
> g_path_get_basename() is a portable utility function that has the
> advantage of not modifing the string argument. It also fixes a compile
> breakage with the Musl C library reported in [1].
> 
> [1] https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/
> 
> Reported-by: Khem Raj <raj.khem@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Just one additional question, I understand that QEMU should replace all
basename() with g_path_get_basename(), right?

I find hw/s390x/s390-ccw.c also uses basename(). Maybe I can clean it up
to avoid potentially similar issue.

Thanks,
Zhao

>  hw/vfio/container.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 688cf23bab88f85246378bc5a7da3c51ea6b79d9..8d334f52f2438d05f632502e07ffd4dc2ec76cb5 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -869,7 +869,8 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>  
>  static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>  {
> -    char *tmp, group_path[PATH_MAX], *group_name;
> +    char *tmp, group_path[PATH_MAX];
> +    g_autofree char *group_name = NULL;
>      int ret, groupid;
>      ssize_t len;
>  
> @@ -885,7 +886,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>  
>      group_path[len] = 0;
>  
> -    group_name = basename(group_path);
> +    group_name = g_path_get_basename(group_path);
>      if (sscanf(group_name, "%d", &groupid) != 1) {
>          error_setg_errno(errp, errno, "failed to read %s", group_path);
>          return -errno;
> -- 
> 2.43.0
> 
> 

