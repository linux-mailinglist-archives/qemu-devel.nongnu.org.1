Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E6A88E28A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Mar 2024 14:29:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTKt-0001jP-Br; Wed, 27 Mar 2024 09:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTKp-0001fV-Tu
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:28:56 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTKn-0005ri-Vp
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711546134; x=1743082134;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8b8c6P2+VCs+jk+qXB65SNmYsNp70KEmrOlascpa9Es=;
 b=jjfHEpVjeHGK3XGl3DoMDuV7FZ/ruQFNtF0UVS7bTp0aXHxVS5PzH8x5
 4yyU2X0n1FSRzB/vrOKvmxaOFbXph+rgaFdYhNU11pzjbhtm8YplvEm0J
 kBcaAs1+qWTs2uPnt99a8vyzICk7q22NKLqzKR3lTGZfnoNywl/2AxqpP
 bocxJmJeG7/zJ4oxA6fnGeGLZHjRbD+5EgXg5RmNCpW7t06mjMKG9KVa5
 Ch+zbrBBPveAlrNS8B5MtK8zXZiYzdH4+TBTWvSoqGKtjYlZj6kjX1YVK
 SuWRg0tF/Iw5J5v2M0IfSxIbVlKVkwoQwpnnCUXdIjtazFef9asZZdu9G w==;
X-CSE-ConnectionGUID: RoHcYiL7RIKs15XDSPRC4A==
X-CSE-MsgGUID: STETCM5qQpKeQKthrTXSYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6833502"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6833502"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 06:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="20949774"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 06:28:49 -0700
Date: Wed, 27 Mar 2024 21:42:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.1 v2 07/21] hw/i386/pc: Remove deprecated
 pc-i440fx-2.1 machine
Message-ID: <ZgQiVBg1psUdm8Fl@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-8-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 27, 2024 at 10:51:09AM +0100, Philippe Mathieu-Daud� wrote:
> Date: Wed, 27 Mar 2024 10:51:09 +0100
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 07/21] hw/i386/pc: Remove deprecated
>  pc-i440fx-2.1 machine
> X-Mailer: git-send-email 2.41.0
> 
> The pc-i440fx-2.1 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240305134221.30924-7-philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       |  2 +-
>  docs/about/removed-features.rst |  2 +-
>  include/hw/i386/pc.h            |  3 ---
>  hw/i386/pc.c                    |  7 -------
>  hw/i386/pc_piix.c               | 23 -----------------------
>  5 files changed, 2 insertions(+), 35 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


