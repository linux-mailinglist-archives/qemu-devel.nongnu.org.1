Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D385E229
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:58:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTt-0007WL-Td; Wed, 21 Feb 2024 10:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcoMj-0004vg-Q8; Wed, 21 Feb 2024 10:18:38 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcnyC-0006w4-Bw; Wed, 21 Feb 2024 09:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708527192; x=1740063192;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UGj5JoIo7Cr9pGUnX7V/P0tJcuLD76ovvoOQLggI0D8=;
 b=it9xlkMuuFBVDvlQyist1CgBj7T6GYrUbkdDil2rbFT/GVkHhGygTnwK
 y6qumUGgvOWZSshevTsrdhEVqT6sHjR4/7GBxZdzU2WQqr8emiY5GYdNk
 TUNaQDgXfzTdwzG809Ql+WEbdZNzXjkBaRgzqtgPr2KtFMB30W3FW15hh
 kGstlUvQ3+83zYR/8Hj1G7u6xHs75wdmc3ilJmUoTkYWR5ZoseLcRoxuC
 gDHXQ0ODM6MaTAaJNHrvlvl605AIXha6hoHGtYzMl5wJgyEMAJzjOXNF7
 KdNtgrscw9SYKfWfUaOv28Kjb//tSsT3t8XQMNdmsB81KrpLBBX5YSDjq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5643881"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5643881"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 06:53:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; d="scan'208";a="28302334"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 21 Feb 2024 06:53:04 -0800
Date: Wed, 21 Feb 2024 23:06:44 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 4/6] hw/misc/xlnx-versal-trng: Fix missing ERRP_GUARD()
 in trng_prop_fault_event_set()
Message-ID: <ZdYRhCWhTGlkM7up@intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <20240221094317.994454-5-zhao1.liu@linux.intel.com>
 <87ttm2ujhm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttm2ujhm.fsf@pond.sub.org>
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 21, 2024 at 12:47:33PM +0100, Markus Armbruster wrote:
> Date: Wed, 21 Feb 2024 12:47:33 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 4/6] hw/misc/xlnx-versal-trng: Fix missing ERRP_GUARD()
>  in trng_prop_fault_event_set()
> 
> Zhao Liu <zhao1.liu@linux.intel.com> writes:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > As the comment in qapi/error, dereferencing @errp requires
> > ERRP_GUARD():
> >
> > * = Why, when and how to use ERRP_GUARD() =
> > *
> > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > * - It must not be dereferenced, because it may be null.
> > * - It should not be passed to error_prepend() or
> > *   error_append_hint(), because that doesn't work with &error_fatal.
> > * ERRP_GUARD() lifts these restrictions.
> > *
> > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > * @errp can then be used without worrying about the argument being
> > * NULL or &error_fatal.
> > *
> > * Using it when it's not needed is safe, but please avoid cluttering
> > * the source with useless code.
> >
> > Currently, since trng_prop_fault_event_set() doesn't get the NULL errp
> > parameter as a "set" method of object property, it doesn't trigger the
> > dereference issue.
> >
> > To follow the requirement of errp, add missing ERRP_GUARD() in
> > trng_prop_fault_event_set().
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Suggested by credit:
> >  Markus: Referred his explanation about ERRP_GUARD().
> > ---
> >  hw/misc/xlnx-versal-trng.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> > index b8111b8b6626..3579348a9d17 100644
> > --- a/hw/misc/xlnx-versal-trng.c
> > +++ b/hw/misc/xlnx-versal-trng.c
> > @@ -33,6 +33,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/guest-random.h"
> >  #include "qemu/timer.h"
> > +#include "qapi/error.h"
> >  #include "qapi/visitor.h"
> >  #include "migration/vmstate.h"
> >  #include "hw/qdev-properties.h"
> > @@ -641,6 +642,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
> >                                        const char *name, void *opaque,
> >                                        Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      Property *prop = opaque;
> >      uint32_t *events = object_field_prop_ptr(obj, prop);
> 
>        visit_type_uint32(v, name, events, errp);
>        if (*errp) {
>            return;
>        }
> 
> Please do this instead:
> 
> diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> index b8111b8b66..6495188dc7 100644
> --- a/hw/misc/xlnx-versal-trng.c
> +++ b/hw/misc/xlnx-versal-trng.c
> @@ -644,8 +644,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
>      Property *prop = opaque;
>      uint32_t *events = object_field_prop_ptr(obj, prop);
>  
> -    visit_type_uint32(v, name, events, errp);
> -    if (*errp) {
> +    if (!visit_type_uint32(v, name, events, errp)) {
>          return;
>      }
>  

Thanks! I didn't think of that. Will do this.

Regards,
Zhao


