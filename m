Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82181C328
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 03:42:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGVTs-0002Xh-I7; Thu, 21 Dec 2023 21:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGVTq-0002XV-Qz
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 21:41:42 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGVTo-0006ce-Sc
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 21:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703212900; x=1734748900;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HBFM0F5xnG+JT93h1ZvtamZHa/CaLvbewkwodFci4os=;
 b=X7I6+CC4XUNEXeHavnbopGq4o9KQcbuQU21wsulDfgCsMDq8FQGLFWBu
 S50d1BZ/ZOBdVQJhEUojE7ht74sV7rBP+zFL4/e3SJ/yCNu1x18rpmRFu
 ERsLk8+bbtu9qHVdii+TumgFtQ1ijM7vsVU+ilw2tgME6ryBNlPd/OK1H
 Wv3oOvwYjxQuuTwAWtMPerKqB8oSIdfs8kJsg5s1gAfCaclbHbEkKJZjs
 S0R/7md0lDVMcY3bHJmYksZwFxJ2kXIFWgC1HQ5zxRto+34oeq8I4Br/F
 yL8Hj8eFb+KmkhaPZk1k/zY+bu8b9i7xQPwns0cietexzYqNgBb9xUZXb g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482246903"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="482246903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 18:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="900298758"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="900298758"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 21 Dec 2023 18:41:33 -0800
Date: Fri, 22 Dec 2023 10:54:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 31/71] hw/i386: Constify VMState
Message-ID: <ZYT6W8q965w3LvUm@intel.com>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
 <20231221031652.119827-32-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221031652.119827-32-richard.henderson@linaro.org>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Dec 21, 2023 at 02:16:12PM +1100, Richard Henderson wrote:
> Date: Thu, 21 Dec 2023 14:16:12 +1100
> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: [PATCH v2 31/71] hw/i386: Constify VMState
> X-Mailer: git-send-email 2.34.1
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  hw/i386/acpi-build.c       | 2 +-
>  hw/i386/intel_iommu.c      | 2 +-
>  hw/i386/kvm/clock.c        | 6 +++---
>  hw/i386/kvm/xen_evtchn.c   | 4 ++--
>  hw/i386/kvm/xen_gnttab.c   | 2 +-
>  hw/i386/kvm/xen_overlay.c  | 2 +-
>  hw/i386/kvm/xen_xenstore.c | 2 +-
>  hw/i386/kvmvapic.c         | 6 +++---
>  hw/i386/port92.c           | 2 +-
>  hw/i386/vmmouse.c          | 2 +-
>  hw/i386/xen/xen_platform.c | 2 +-
>  hw/i386/xen/xen_pvdevice.c | 2 +-
>  12 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 80db183b78..edc979379c 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2770,7 +2770,7 @@ static const VMStateDescription vmstate_acpi_build = {
>      .name = "acpi_build",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT8(patched, AcpiBuildState),
>          VMSTATE_END_OF_LIST()
>      },
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5085a6fee3..ed5677c0ae 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3289,7 +3289,7 @@ static const VMStateDescription vtd_vmstate = {
>      .minimum_version_id = 1,
>      .priority = MIG_PRI_IOMMU,
>      .post_load = vtd_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(root, IntelIOMMUState),
>          VMSTATE_UINT64(intr_root, IntelIOMMUState),
>          VMSTATE_UINT64(iq, IntelIOMMUState),
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index e756b0aa43..40aa9a32c3 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -245,7 +245,7 @@ static const VMStateDescription kvmclock_reliable_get_clock = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = kvmclock_clock_is_reliable_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_BOOL(clock_is_reliable, KVMClockState),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -295,11 +295,11 @@ static const VMStateDescription kvmclock_vmsd = {
>      .minimum_version_id = 1,
>      .pre_load = kvmclock_pre_load,
>      .pre_save = kvmclock_pre_save,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(clock, KVMClockState),
>          VMSTATE_END_OF_LIST()
>      },
> -    .subsections = (const VMStateDescription * []) {
> +    .subsections = (const VMStateDescription * const []) {
>          &kvmclock_reliable_get_clock,
>          NULL
>      }
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 02b8cbf8df..9a5f3caa24 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -240,7 +240,7 @@ static const VMStateDescription xen_evtchn_port_vmstate = {
>      .name = "xen_evtchn_port",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(vcpu, XenEvtchnPort),
>          VMSTATE_UINT16(type, XenEvtchnPort),
>          VMSTATE_UINT16(u.val, XenEvtchnPort),
> @@ -255,7 +255,7 @@ static const VMStateDescription xen_evtchn_vmstate = {
>      .needed = xen_evtchn_is_needed,
>      .pre_load = xen_evtchn_pre_load,
>      .post_load = xen_evtchn_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(callback_param, XenEvtchnState),
>          VMSTATE_UINT32(nr_ports, XenEvtchnState),
>          VMSTATE_STRUCT_VARRAY_UINT32(port_table, XenEvtchnState, nr_ports, 1,
> diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
> index 0a24f53f20..a0cc30f619 100644
> --- a/hw/i386/kvm/xen_gnttab.c
> +++ b/hw/i386/kvm/xen_gnttab.c
> @@ -127,7 +127,7 @@ static const VMStateDescription xen_gnttab_vmstate = {
>      .minimum_version_id = 1,
>      .needed = xen_gnttab_is_needed,
>      .post_load = xen_gnttab_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(nr_frames, XenGnttabState),
>          VMSTATE_VARRAY_UINT32(gnt_frame_gpas, XenGnttabState, nr_frames, 0,
>                                vmstate_info_uint64, uint64_t),
> diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
> index 39fda1b72c..526f7a6077 100644
> --- a/hw/i386/kvm/xen_overlay.c
> +++ b/hw/i386/kvm/xen_overlay.c
> @@ -139,7 +139,7 @@ static const VMStateDescription xen_overlay_vmstate = {
>      .needed = xen_overlay_is_needed,
>      .pre_save = xen_overlay_pre_save,
>      .post_load = xen_overlay_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(shinfo_gpa, XenOverlayState),
>          VMSTATE_BOOL(long_mode, XenOverlayState),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
> index 6e651960b3..c3633f7829 100644
> --- a/hw/i386/kvm/xen_xenstore.c
> +++ b/hw/i386/kvm/xen_xenstore.c
> @@ -243,7 +243,7 @@ static const VMStateDescription xen_xenstore_vmstate = {
>      .needed = xen_xenstore_is_needed,
>      .pre_save = xen_xenstore_pre_save,
>      .post_load = xen_xenstore_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT8_ARRAY(req_data, XenXenstoreState,
>                              sizeof_field(XenXenstoreState, req_data)),
>          VMSTATE_UINT8_ARRAY(rsp_data, XenXenstoreState,
> diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
> index 43f8a8f679..f2b0aff479 100644
> --- a/hw/i386/kvmvapic.c
> +++ b/hw/i386/kvmvapic.c
> @@ -802,7 +802,7 @@ static const VMStateDescription vmstate_handlers = {
>      .name = "kvmvapic-handlers",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(set_tpr, VAPICHandlers),
>          VMSTATE_UINT32(set_tpr_eax, VAPICHandlers),
>          VMSTATE_UINT32_ARRAY(get_tpr, VAPICHandlers, 8),
> @@ -815,7 +815,7 @@ static const VMStateDescription vmstate_guest_rom = {
>      .name = "kvmvapic-guest-rom",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UNUSED(8),     /* signature */
>          VMSTATE_UINT32(vaddr, GuestROMState),
>          VMSTATE_UINT32(fixup_start, GuestROMState),
> @@ -835,7 +835,7 @@ static const VMStateDescription vmstate_vapic = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .post_load = vapic_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT(rom_state, VAPICROMState, 0, vmstate_guest_rom,
>                         GuestROMState),
>          VMSTATE_UINT32(state, VAPICROMState),
> diff --git a/hw/i386/port92.c b/hw/i386/port92.c
> index e1379a4f98..1070bfbf36 100644
> --- a/hw/i386/port92.c
> +++ b/hw/i386/port92.c
> @@ -54,7 +54,7 @@ static const VMStateDescription vmstate_port92_isa = {
>      .name = "port92",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT8(outport, Port92State),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 91320afa2f..a8d014d09a 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -277,7 +277,7 @@ static const VMStateDescription vmstate_vmmouse = {
>      .version_id = 0,
>      .minimum_version_id = 0,
>      .post_load = vmmouse_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_INT32_EQUAL(queue_size, VMMouseState, NULL),
>          VMSTATE_UINT32_ARRAY(queue, VMMouseState, VMMOUSE_QUEUE_SIZE),
>          VMSTATE_UINT16(nb_queue, VMMouseState),
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index ef7d3fc05f..708488af32 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -537,7 +537,7 @@ static const VMStateDescription vmstate_xen_platform = {
>      .version_id = 4,
>      .minimum_version_id = 4,
>      .post_load = xen_platform_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, PCIXenPlatformState),
>          VMSTATE_UINT8(flags, PCIXenPlatformState),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
> index e62e06622b..ed621531d8 100644
> --- a/hw/i386/xen/xen_pvdevice.c
> +++ b/hw/i386/xen/xen_pvdevice.c
> @@ -77,7 +77,7 @@ static const VMStateDescription vmstate_xen_pvdevice = {
>      .name = "xen-pvdevice",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, XenPVDevice),
>          VMSTATE_END_OF_LIST()
>      }
> -- 
> 2.34.1
> 
> 

