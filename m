Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E7A2A2BD
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 08:56:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwk9-0003B9-CU; Thu, 06 Feb 2025 02:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfwk6-0003Af-UF; Thu, 06 Feb 2025 02:56:11 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfwk4-0000Sg-01; Thu, 06 Feb 2025 02:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738828568; x=1770364568;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qr9w+Z7k6Uz/SkChv6ryMT1ch8KbMNaWD2zzJjVf/Qk=;
 b=Oea/gf22kZxl+GSIC4R0DyBOnXwogCI8+2bM0qk2gnTviRxKWCBDkV/X
 D3aXgixWMWrLATdCtErWYpciPVUD5M+zRi+IYPaZKdjGOcfHnDaLOYonO
 7lTSdM9XzF6LodvK+Lqj3v1paK0LEY0B8zzys/RMVKzrZXtEHH1mj0du3
 OJkOydtqSWYqVeQEv3U/lf6VEwyx7ahX4TFSpKebOSQ+eYv9qsvk0KrFo
 CrOhQLFV3LaJTmn4BOUGxqFiSYMt57qcVJ852yc5eOeCxF9EmT5BwnKsx
 ePUc1Q6o/N9eQ4E82OX5gIYoejB6QuJbZqnzle8tv9aMH+V6z7U6kceEy w==;
X-CSE-ConnectionGUID: jSN8UDBZR0SvnyaJOyUrLg==
X-CSE-MsgGUID: hY2NT5xrSEaruJkpGqX+3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39552765"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; d="scan'208";a="39552765"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 23:56:05 -0800
X-CSE-ConnectionGUID: 2Ir4AIh4TAu3Vg3LM7R21Q==
X-CSE-MsgGUID: twHPmje5RP+qLit1ox84wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="116095116"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 05 Feb 2025 23:56:04 -0800
Date: Thu, 6 Feb 2025 16:15:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 05/10] rust: qdev: add clock creation
Message-ID: <Z6RvpOffNiWUAbu/@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

>          // SAFETY:
>          //
> -        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
> -        // we can overwrite the undefined value without side effects. This is
> +        // self.clock is not initialized at this point; but since `NonNull<_>` is

s/NonNull<_>/Owned<_>/

> +        // not Drop, we can overwrite the undefined value without side effects. This is
>          // safe since all PL011State instances are created by QOM code which
>          // calls this function to initialize the fields; therefore no code is
>          // able to access an invalid self.clock value.
> -        unsafe {
> -            let dev: &mut DeviceState = self.upcast_mut();
> -            self.clock = NonNull::new(qdev_init_clock_in(
> -                dev,
> -                CLK_NAME.as_ptr(),
> -                None, /* pl011_clock_update */
> -                addr_of_mut!(*self).cast::<c_void>(),
> -                ClockEvent::ClockUpdate.0,
> -            ))
> -            .unwrap();
> -        }
> +        self.clock = self.init_clock_in("clk", &Self::clock_update, ClockEvent::ClockUpdate);
> +    }
> +

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


