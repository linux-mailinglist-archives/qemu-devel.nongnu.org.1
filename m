Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 101FEA9E0B4
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Apr 2025 10:15:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8x9Q-0007WA-LA; Sun, 27 Apr 2025 04:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8x9O-0007Vu-7o; Sun, 27 Apr 2025 04:14:10 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8x9J-0005hS-Py; Sun, 27 Apr 2025 04:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745741646; x=1777277646;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gEZxHnJp6+sM8XNPAyQmGSNd+CwBLXF+GjSj+W4RD5s=;
 b=KSmi3cHrolaK77Za54tMBXWoCNyhJlHMB7uEwpWLVhUj+DokXKQebTCo
 R0fnDIO/sVRU6K8R4llEq8eyizQMp1WceBFefqNmHpKIeERHmVU43uFBC
 edOmqZpCQAP8HPscDcA3hVxMlTLWOjSb1V06j2PiUrGDCNBtvyJ6o3rOd
 g4FKjv+pImts1xAMkA0WII7IbNp3C48W0aX335AzhVS97DFEQYFMdz85M
 DKoZHd+RUtjMazgz69x3JEd/fEqIIG6MyJThxc8gANaI8m2aJlkmh48NL
 CEwXvMjpI+vEutaQAsf2uCI0SBebeGppDpFaUfYG9SF4WA8KJyUbglCzI g==;
X-CSE-ConnectionGUID: jOFA0kLqRkGOXJfNO9NYKA==
X-CSE-MsgGUID: H0roJzynQMuGFsx40gmH4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47477047"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="47477047"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 01:14:00 -0700
X-CSE-ConnectionGUID: uhNwK2QiShSyWNlGPVJb3w==
X-CSE-MsgGUID: MqnquHVXTAiy5v/sJX/M+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="156484577"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 27 Apr 2025 01:13:56 -0700
Date: Sun, 27 Apr 2025 16:34:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 2/5] i386/kvm: Support basic KVM PMU filter
Message-ID: <aA3sLRzZj2270cSs@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-3-zhao1.liu@intel.com>
 <878qnoha3j.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qnoha3j.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

...

> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index dc694a99a30a..51a7c61ce0b0 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -232,7 +232,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> >      "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
> >      "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
> >      "                thread=single|multi (enable multi-threaded TCG)\n"
> > -    "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
> > +    "                device=path (KVM device path, default /dev/kvm)\n"
> > +    "                pmu-filter=id (configure KVM PMU filter)\n", QEMU_ARCH_ALL)
> 
> As we'll see below, this property is actually available only for i386.
> Other target-specific properties document this like "x86 only".  Please
> do that for this one, too.

Thanks! I'll change QEMU_ARCH_ALL to QEMU_ARCH_I386.

> As far as I can tell, the kvm-pmu-filter object needs to be activated
> with -accel pmu-filter=... to do anything.  Correct?

Yes,

> You can create any number of kvm-pmu-filter objects, but only one of
> them can be active.  Correct?

Yes! I'll try to report error when user repeats to set this object, or
mention this rule in doc.

> >  SRST
> >  ``-accel name[,prop=value[,...]]``
> >      This is used to enable an accelerator. Depending on the target
> > @@ -318,6 +319,10 @@ SRST
> >          option can be used to pass the KVM device to use via a file descriptor
> >          by setting the value to ``/dev/fdset/NN``.
> >  
> > +    ``pmu-filter=id``
> > +        Sets the id of KVM PMU filter object. This option can be used to set
> > +        whitelist or blacklist of PMU events for Guest.
> 
> Well, "this option" can't actually be used to set the lists.  That's to
> be done with -object kvm-pmu-filter.  Perhaps:
> 
>            Activate a KVM PMU filter object.  That object can be used to
>            filter guest access to PMU events.

Thank you! Nice description.

> > +
> >  ERST
> >  
> >  DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> > @@ -6144,6 +6149,46 @@ SRST
> >          ::
> >  
> >              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> > +
> > +    ``-object '{"qom-type":"kvm-pmu-filter","id":id,"action":action,"events":[entry_list]}'``
> 
> Should this be in the previous patch?

Yes, I can amend this to the previous patch.

> > +        Create a kvm-pmu-filter object that configures KVM to filter
> > +        selected PMU events for Guest.
> 
> The object doesn't actually configure KVM.  It merely holds the filter
> configuration.  The configuring is done by the KVM accelerator according
> to configuration in the connected kvm-pmu-filter object.  Perhaps:
> 
>            Create a kvm-pmu-filter object to hold PMU event filter
>            configuration.

Yes, that's a very accurate statement. Will fix.

> > +
> > +        This option must be written in JSON format to support ``events``
> > +        JSON list.
> > +
> > +        The ``action`` parameter sets the action that KVM will take for
> > +        the selected PMU events. It accepts ``allow`` or ``deny``. If
> > +        the action is set to ``allow``, all PMU events except the
> > +        selected ones will be disabled and blocked in the Guest. But if
> > +        the action is set to ``deny``, then only the selected events
> > +        will be denied, while all other events can be accessed normally
> > +        in the Guest.
> 
> I recommend "guest" instead of "Guest".

OK.

> > +
> > +        The ``events`` parameter accepts a list of PMU event entries in
> > +        JSON format. Event entries, based on different encoding formats,
> > +        have the following types:
> > +
> > +        ``{"format":"raw","code":raw_code}``
> > +            Encode the single PMU event with raw format. The ``code``
> > +            parameter accepts raw code of a PMU event. For x86, the raw
> > +            code represents a combination of umask and event select:
> > +
> > +        ::
> > +
> > +            (((select & 0xf00UL) << 24) | \
> > +             ((select) & 0xff) | \
> > +             ((umask) & 0xff) << 8)
> 
> Does it?  Could the code also represent a combination of select, match,
> and mask (masked entry format)?

Yes, I'll drop this formula.

> > +
> > +        An example KVM PMU filter object would look like:
> > +
> > +        .. parsed-literal::
> > +
> > +             # |qemu_system| \\
> > +                 ... \\
> > +                 -accel kvm,pmu-filter=id \\
> > +                 -object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":196}]}' \\
> > +                 ...
> >  ERST
> >  
> >  
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 6c749d4ee812..fa3a696654cb 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -34,6 +34,7 @@
> >  #include "system/system.h"
> >  #include "system/hw_accel.h"
> >  #include "system/kvm_int.h"
> > +#include "system/kvm-pmu.h"
> >  #include "system/runstate.h"
> >  #include "kvm_i386.h"
> >  #include "../confidential-guest.h"
> > @@ -110,6 +111,7 @@ typedef struct {
> >  static void kvm_init_msrs(X86CPU *cpu);
> >  static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
> >                            QEMUWRMSRHandler *wrmsr);
> > +static int kvm_filter_pmu_event(KVMState *s);
> >  
> >  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
> >      KVM_CAP_INFO(SET_TSS_ADDR),
> > @@ -3346,6 +3348,18 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >          }
> >      }
> >  
> > +    /*
> > +     * TODO: Move this chunk to kvm_arch_pre_create_vcpu() and check
> 
> I can't see a function kvm_arch_pre_create_vcpu().

I was referring this patch:
https://lore.kernel.org/qemu-devel/20250425213037.8137-4-dongli.zhang@oracle.com/.

Since it's an unmerged patch, I can drop this comment.

> > +     * whether pmu is enabled there.
> 
> PMU

Sure.

> > +     */
> > +    if (s->pmu_filter) {
> > +        ret = kvm_filter_pmu_event(s);
> > +        if (ret < 0) {
> > +            error_report("Could not set KVM PMU filter");
> 
> When kvm_filter_pmu_event() failed, it already reported an error.
> Reporting it another time can be confusing.

Good catch! Will remove this error_report().

> > +            return ret;
> > +        }
> > +    }
> > +
> >      return 0;
> >  }
> >  
> > @@ -5942,6 +5956,82 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
> >      g_assert_not_reached();
> >  }
> >  
> > +static bool kvm_config_pmu_event(KVMPMUFilter *filter,
> > +                                 struct kvm_pmu_event_filter *kvm_filter)
> > +{
> > +    KvmPmuFilterEventList *events;
> > +    KvmPmuFilterEvent *event;
> > +    uint64_t code;
> > +    int idx = 0;
> > +
> > +    kvm_filter->nevents = filter->nevents;
> > +    events = filter->events;
> > +    while (events) {
> > +        assert(idx < kvm_filter->nevents);
> > +
> > +        event = events->value;
> > +        switch (event->format) {
> > +        case KVM_PMU_EVENT_FORMAT_RAW:
> > +            code = event->u.raw.code;
> > +            break;
> > +        default:
> > +            g_assert_not_reached();
> > +        }
> > +
> > +        kvm_filter->events[idx++] = code;
> > +        events = events->next;
> > +    }
> > +
> > +    return true;
> > +}
> 
> This function cannot fail.  Please return void, and simplify its caller.

Yes, the error handling is unnecessary here.

> > +
> > +static int kvm_install_pmu_event_filter(KVMState *s)
> > +{
> > +    struct kvm_pmu_event_filter *kvm_filter;
> > +    KVMPMUFilter *filter = s->pmu_filter;
> > +    int ret;
> > +
> > +    kvm_filter = g_malloc0(sizeof(struct kvm_pmu_event_filter) +
> > +                           filter->nevents * sizeof(uint64_t));
> 
> Should we use sizeof(filter->events[0])?

No, here I'm trying to constructing the memory accepted in kvm interface
(with the specific layout), which is not the same as the KVMPMUFilter
object.

> > +
> > +    switch (filter->action) {
> > +    case KVM_PMU_FILTER_ACTION_ALLOW:
> > +        kvm_filter->action = KVM_PMU_EVENT_ALLOW;
> > +        break;
> > +    case KVM_PMU_FILTER_ACTION_DENY:
> > +        kvm_filter->action = KVM_PMU_EVENT_DENY;
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +
> > +    if (!kvm_config_pmu_event(filter, kvm_filter)) {
> > +        goto fail;
> > +    }
> > +
> > +    ret = kvm_vm_ioctl(s, KVM_SET_PMU_EVENT_FILTER, kvm_filter);
> > +    if (ret) {
> > +        error_report("KVM_SET_PMU_EVENT_FILTER fails (%s)", strerror(-ret));
> 
> Suggest something like "can't set KVM PMU event filter".

Sure, sounds good!

> > +        goto fail;
> > +    }
> > +
> > +    g_free(kvm_filter);
> > +    return 0;
> > +fail:
> > +    g_free(kvm_filter);
> > +    return -EINVAL;
> > +}
> > +
> > +static int kvm_filter_pmu_event(KVMState *s)
> > +{
> > +    if (!kvm_vm_check_extension(s, KVM_CAP_PMU_EVENT_FILTER)) {
> > +        error_report("KVM PMU filter is not supported by Host.");
> 
> Error message should be a single phrase with no trailing punctuation.
> More of the same below.

OK, I'll clean up them.

> > +        return -1;
> > +    }
> > +
> > +    return kvm_install_pmu_event_filter(s);
> > +}
> > +
> >  static bool has_sgx_provisioning;
> >  
> >  static bool __kvm_enable_sgx_provisioning(KVMState *s)
> > @@ -6537,6 +6627,35 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
> >      s->xen_evtchn_max_pirq = value;
> >  }
> >  
> > +static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
> > +                                      Object *child, Error **errp)
> > +{
> > +    KVMPMUFilter *filter = KVM_PMU_FILTER(child);
> > +    KvmPmuFilterEventList *events = filter->events;
> > +
> > +    if (!filter->nevents) {
> > +        error_setg(errp,
> > +                   "Empty KVM PMU filter.");
> 
> Why is this an error?
> 
> action=allow with an empty would be the obvious way to allow nothing,
> wouldn't it?

allow nothing == deny everything!

Yes, it makes sense :-) Will drop this limitation.

> > +        return;
> > +    }
> > +
> > +    while (events) {
> > +        KvmPmuFilterEvent *event = events->value;
> > +
> > +        switch (event->format) {
> > +        case KVM_PMU_EVENT_FORMAT_RAW:
> > +            break;
> > +        default:
> > +            error_setg(errp,
> > +                       "Unsupported PMU event format %s.",
> > +                       KvmPmuEventFormat_str(events->value->format));
> 
> Unreachable.

OK, it makes sense. Thanks.

> > +            return;
> > +        }
> > +
> > +        events = events->next;
> > +    }
> > +}
> > +
> >  void kvm_arch_accel_class_init(ObjectClass *oc)
> >  {
> >      object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
> > @@ -6576,6 +6695,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
> >                                NULL, NULL);
> >      object_class_property_set_description(oc, "xen-evtchn-max-pirq",
> >                                            "Maximum number of Xen PIRQs");
> > +
> > +    object_class_property_add_link(oc, "pmu-filter",
> > +                                   TYPE_KVM_PMU_FILTER,
> > +                                   offsetof(KVMState, pmu_filter),
> > +                                   kvm_arch_check_pmu_filter,
> > +                                   OBJ_PROP_LINK_STRONG);
> > +    object_class_property_set_description(oc, "pmu-filter",
> > +                                          "Set the KVM PMU filter");
> >  }
> >  
> >  void kvm_set_max_apic_id(uint32_t max_apic_id)
> 
> target/i386/kvm/kvm.c is compiled into the binary only for i386 target
> with CONFIG_KVM.
> 
> The kvm-pmu-filter-object exists for any target with CONFIG_KVM.  But
> it's usable only for i386.

As with Philip's comment, I also need to think about compatibility with
multiple accelerators, and we can continue that discussion in the mail
thread of patch 1. Thanks for your feedback!

> I think the previous patch's commit message should state the role of the
> kvm-pmu-filter-object more clearly: hold KVM PMU filter configuration
> for any target with KVM.  This patch's commit message should then
> explain what the patch does: enable actual use of the
> kvm-pmu-filter-object for i386 only.  Other targets are left for another
> day.

Thank you! I'll update the commit message.

Regards,
Zhao


