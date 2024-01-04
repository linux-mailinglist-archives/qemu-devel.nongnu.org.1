Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23B82460E
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:25:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQWa-0003Ms-71; Thu, 04 Jan 2024 11:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rLQWX-0003MJ-UX
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:24:49 -0500
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rLQWU-0005G8-3O
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704385486; x=1735921486;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3aGuzA0KeWNby3+VyQ7Wu96Tjrwi6vYsJHiBBz30bzc=;
 b=fUZMHusYog/i3cog5opmYs7w+v0ttehm2Q0866JL8u2xlN77dqW8fFa2
 Py6QX6M+kBQd/YhkrZv4p5Pa9erWP/ZIPfIvcsY35Zb5Sf7jK4m+z4Ms0
 y1YOHl1e0DskGo3nMqi2TJICFfOQPSXmaCXe6MdboYpJwnlOjRa2tAqo4
 TUZy9Id3kyzXrBDmh9S/i1iefhtRXrZq98veWGGpTWjKdUZt4eyqcaSAT
 VmoQ3oaVMl8TxfnQAhY78ATB05DMik/NogLtxIVY/eVVWgYa4wrHkRzg7
 3DH+idMRzyLNOo/UViglofzdBB+ZCJch8MhaYlOs7NwTVvN067wwzVj0X Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382273004"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; d="scan'208";a="382273004"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2024 08:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; d="scan'208";a="22214805"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 04 Jan 2024 08:24:22 -0800
Date: Fri, 5 Jan 2024 00:37:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qtest: use correct boolean type for failover property
Message-ID: <ZZbeuu8pOtAXw6iR@intel.com>
References: <20240103123005.2400437-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240103123005.2400437-1-berrange@redhat.com>
Received-SPF: pass client-ip=134.134.136.126; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

On Wed, Jan 03, 2024 at 12:30:05PM +0000, Daniel P. Berrangé wrote:
> Date: Wed,  3 Jan 2024 12:30:05 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH] qtest: use correct boolean type for failover property
> 
> QMP device_add does not historically validate the parameter types.
> At some point it will likely change to enforce correct types, to
> match behaviour of -device. The failover property is expected to
> be a boolean in JSON.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qtest/virtio-net-failover.c | 36 +++++++++++++++----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


