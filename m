Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2181A53D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzVs-00055I-Tf; Wed, 20 Dec 2023 11:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rFzVi-00052H-7A
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:33:31 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rFzVe-0006dr-7d
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703090006; x=1734626006;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sCKGWzuiKAuB607fgbj5++IPYoLBkWQCAgNuWkeqyd8=;
 b=B92FxQ0bmc8pmRyUUCe9MPuAJZpuXvxelwHAUFeG3H6ZQB7vHBMk3CfB
 tvLjBe7hvRgKhBh00E81+jOtKvdoLCphnRDVmcJeUUhF5Tdmu559MAJBR
 lJNLuWrYzkxjdrco3Wt7ofZzqem3Vx6CcUjnJDmMqczWvIcAR7OB1Vyfo
 DKxquZD+uZyBI1V2uAK62eFjKHj+Anqyr14oAfYxGu3PyMq7C5lAc0ZH9
 eQJXvnstY8JJholKuo5Kbp0NjsZk0k/ZIDzM17S8scj1vOniRHTmCFzTh
 NlC/MJ91rOKeMANcQW3V5KVLr6DYQjMKXVAqyo0s4DN4r2a11HDMGKPgB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2667185"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2667185"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 08:33:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="726131820"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; d="scan'208";a="726131820"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 20 Dec 2023 08:33:18 -0800
Date: Thu, 21 Dec 2023 00:46:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
Message-ID: <ZYMaS8v8sIWhteFm@intel.com>
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
 <8734vzsj6k.fsf@pond.sub.org>
 <ff212914-32b5-442e-8f67-4f01a7208a0c@daynix.com>
 <87y1dpgvim.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1dpgvim.fsf@pond.sub.org>
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

Hi Markus,

On Wed, Dec 20, 2023 at 08:53:21AM +0100, Markus Armbruster wrote:
> Date: Wed, 20 Dec 2023 08:53:21 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH v2] qdev: Report an error for machine without
>  HotplugHandler
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
> > On 2023/12/18 23:02, Markus Armbruster wrote:
> >> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> >> 
> >>> On 2023/12/11 15:51, Markus Armbruster wrote:
> >>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> >>>>
> >>>>> The HotplugHandler of the machine will be used when the parent bus does
> >>>>> not exist, but the machine may not have one. Report an error in such a
> >>>>> case instead of aborting.
> >>>>>
> >>>>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
> >>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>
> >>>> Do you have a reproducer for the crash?
> >>>>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>> - Fixed indention.
> >>>>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
> >>>>> ---
> >>>>>    system/qdev-monitor.c | 13 ++++++++++---
> >>>>>    1 file changed, 10 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> >>>>> index a13db763e5..5fe5d49c20 100644
> >>>>> --- a/system/qdev-monitor.c
> >>>>> +++ b/system/qdev-monitor.c
> >>>>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
> >>>>    void qdev_unplug(DeviceState *dev, Error **errp)
> >>>>    {
> >>>>        DeviceClass *dc = DEVICE_GET_CLASS(dev);
> >>>>        HotplugHandler *hotplug_ctrl;
> >>>>        HotplugHandlerClass *hdc;
> >>>>        Error *local_err = NULL;
> >>>>        if (qdev_unplug_blocked(dev, errp)) {
> >>>>            return;
> >>>>        }
> >>>>        if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
> >>>>            error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
> >>>>            return;
> >>>>        }
> >>>>        if (!dc->hotpluggable) {
> >>>>            error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
> >>>>                       object_get_typename(OBJECT(dev)));
> >>>>            return;
> >>>>        }
> >>>>        if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
> >>>>            error_setg(errp, "device_del not allowed while migrating");
> >>>>            return;
> >>>>        }
> >>>>
> >>>>>       qdev_hot_removed = true;
> >>>>>          hotplug_ctrl = qdev_get_hotplug_handler(dev);
> >>>>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
> >>>>> -     * then something is very wrong with it */
> >>>>> -    g_assert(hotplug_ctrl);
> >>>>> +    if (!hotplug_ctrl) {
> >>>>> +        /*
> >>>>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
> >>>>> +         * then something is very wrong with it
> >>>>> +         */
> >>>>> +        assert(!dev->parent_bus);
> >>>>> +
> >>>>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
> >>>>> +        return;
> >>>>> +    }
> >>>>
> >>>> Extended version of my question above: what are the devices where
> >>>> qdev_get_hotplug_handler(dev) returns null here?
> >>>
> >>> Start a VM: qemu-system-aarch64 -M virt -nographic
> >>> Run the following on its HMP: device_del /machine/unattached/device[0]
> >>>
> >>> It tries to unplug cortex-a15-arm-cpu and crashes.
> >>
> >> This device has no parent bus (dev->parent_bus is null), but is marked
> >> hot-pluggable (dc->hotpluggable is true).  Question for somebody
> >> familiar with the hot-plug machinery: is this sane?
> >
> > Setting hotpluggable false for each device without bus_type gives the same effect, but is error-prone.
> 
> Having hotpluggable = true when the device cannot be hot-plugged is
> *wrong*.  You might be able to paper over the wrongness so the code
> works anyway, but nothing good can come out of lying to developers
> trying to understand how the code works.
> 
> Three ideas to avoid the lying:
> 
> 1. default hotpluggable to bus_type != NULL.
> 
> 2. assert(dc->bus_type || !dc->hotpluggable) in a suitable spot.
> 
> 3. Change the meaning of hotpluggable, and rename it to reflect its new
> meaning.  Requires a careful reading of its uses.  I wouldn't go there.
> 

What about 4 (or maybe 3.1) - droping this hotpluggable flag and just use a
helper (like qbus) to check if device is hotpluggable?

This removes the confusion of that flag and also reduces the number of
configuration items for DeviceState that require developer attention.
A simple helper is as follows:

static inline bool qdev_is_hotpluggable(DeviceState *dev)
{
    /*
     * Many Machines don't implement qdev_hotplug_allowed().
     *
     * TODO: Once all of them complete missing qdev_hotplug_allowed(),
     *       use qdev_hotplug_allowed() here.
     */
    bool hotpluggable = !!qdev_get_machine_hotplug_handler(dev);

    if (!hotpluggable && dev->parent_bus) {
        hotpluggable = qbus_is_hotpluggable(dev->parent_bus);
    }

    return hotpluggable;
}

Thanks,
Zhao


