Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 862597D5929
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKc5-0002LD-NO; Tue, 24 Oct 2023 12:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvKbv-0002F7-1w
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvKbp-0000jH-Us
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698166225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mPC8toYf/YgM5sHd4Z8ZR2IysXFlzOvd1MIeNI1w+sQ=;
 b=A8P9COq89kUBIMuA0xqSAbwEearkDAaliWorkYM7ueT+nm4XOJGuRDRqwLL84jg/vRD/3f
 rd9LabMRJ3NYxH4fcXa2MYdGKgfx6Wn844eOfRCsSnzY/1GJE4DN05H0MK1RtuQUiUfZ3U
 GfxeFGb6AKNPB8h0hLlCyxP+nSRE7sQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-OBbFkm9bM9CzNPIy07qy3A-1; Tue, 24 Oct 2023 12:50:21 -0400
X-MC-Unique: OBbFkm9bM9CzNPIy07qy3A-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6ce2c3355easo381549a34.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166221; x=1698771021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPC8toYf/YgM5sHd4Z8ZR2IysXFlzOvd1MIeNI1w+sQ=;
 b=bzVp9duo9OIYYZWMxDfwOQ25R6zleIvbbuHFGafNwfIg7xuY4UfR4MYZc/ynNL6nr5
 jKUq3bj2S6odhwIkNqOv8dqchzi9DBDYfKYxGzFzgCDbGzYIfGAz1yZhYZMhUCoHSACz
 3m3a5npiGCu7cGtzrtDfZFmK8ZSsW+IIERyLUahUfWKXPmVIal7ClHTLq+pn/jT1b1TY
 1y/Hyqtnxq86gaiXIWumXtGo7Re0VQ07OF+MXNAn8Sc75EZ49U97Rg/hegJNkUQosZOR
 1Cl0ek0B5M384+vkmvuOzwWkTnqkn6qpynyCy97au911kLpDhrlEzwtc51IedTcFRt1t
 eWCA==
X-Gm-Message-State: AOJu0Yx8WxEs1kHi++D5hT7eQOuuQDGLIazwfOwiUDTKriTaDwaBzA68
 MDlJN413pugpRo2G8xuA4chnEwPIa0iGniGORgpvYOiPgsIo0nNuDOH67oi8VDvBIecoTQS4hI8
 Xb0QmncRDrbsHyKY=
X-Received: by 2002:a05:6830:1287:b0:6cd:74d:1f34 with SMTP id
 z7-20020a056830128700b006cd074d1f34mr13863173otp.1.1698166220928; 
 Tue, 24 Oct 2023 09:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGmYbYKCWUKoVm/3P1RAGZN7eZFgM+qCHRZ+GVtTqtg2kKijNfP7h2u5plCgRfONVo2L7VzA==
X-Received: by 2002:a05:6830:1287:b0:6cd:74d:1f34 with SMTP id
 z7-20020a056830128700b006cd074d1f34mr13863157otp.1.1698166220573; 
 Tue, 24 Oct 2023 09:50:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bu7-20020ad455e7000000b0066d1540f9ecsm3776399qvb.77.2023.10.24.09.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:50:20 -0700 (PDT)
Date: Tue, 24 Oct 2023 12:50:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 1/1] migration: vmstate_register() check that
 instance_id is valid
Message-ID: <ZTf1yoZ0GSlRfxSN@x1n>
References: <20231024150336.89632-1-quintela@redhat.com>
 <20231024150336.89632-2-quintela@redhat.com> <ZTfjd3AFVFaMiAqm@x1n>
 <87cyx4knp3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyx4knp3.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 24, 2023 at 06:08:40PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Tue, Oct 24, 2023 at 05:03:36PM +0200, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  include/migration/vmstate.h | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >> index 9821918631..c48cd8bb68 100644
> >> --- a/include/migration/vmstate.h
> >> +++ b/include/migration/vmstate.h
> >> @@ -28,6 +28,7 @@
> >>  #define QEMU_VMSTATE_H
> >>  
> >>  #include "hw/vmstate-if.h"
> >> +#include "qemu/error-report.h"
> >>  
> >>  typedef struct VMStateInfo VMStateInfo;
> >>  typedef struct VMStateField VMStateField;
> >> @@ -1226,6 +1227,11 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
> >>                                     const VMStateDescription *vmsd,
> >>                                     void *opaque)
> >>  {
> >> +    if (instance_id == VMSTATE_INSTANCE_ID_ANY) {
> >> +        error_report("vmstate_register: Invalid device: %s instance_id: %d",
> >> +                     vmsd->name, instance_id);
> >> +        return -1;
> >> +    }
> >>      return vmstate_register_with_alias_id(obj, instance_id, vmsd,
> >>                                            opaque, -1, 0, NULL);
> >>  }
> >
> > Juan, could you remind me what's the benefit of failing it like that?
> 
> 
> > IIUC you want to suggest using vmstate_register_any(), but I think it's all
> > fine to do vmstate_register(VMSTATE_INSTANCE_ID_ANY)?  You didn't have a
> > commit message, so I am guessing..
> 
> This is v3.  v1 and v2 had much more messages, so I thought this was not
> necessary.
> 
> We had lots of places that had vmstate_register(..., 0, ...) where it
> should have s/0/VMSTATE_INSTANCE_ID_ANY/
> 
> The idea here is that we use vmstate_register_any(...) when we don't
> care about the number and we know there is only to be one device.
> 
> On my tree, I started with the test:
> 
>     if (instance_id < 0) {
>         error_report("vmstate_register: Invalid device: %s instance_id: %d",
>                      vmsd->name, instance_id);
>         return -1;
>     }
> 
> But then ppc abuses this interface and passes an uint32_t where it
> should be an int, so I have to check only for that specific value.
> 
> > Even if that is wanted, the current error message can be confusing to a
> > developer adding a new vmstate_register(VMSTATE_INSTANCE_ID_ANY) call.
> > Maybe directly suggest vmstate_register_any() in the error message?  But
> > again, I don't see a benefit, vmstate_register(VMSTATE_INSTANCE_ID_ANY)
> > should still work if without this patch?  Where did I miss?
> 
> You are right, using the other interface.
> 
> Initial version on this series, I split vmstate_register() into:
> - vmstate_register_any()
> - vmstate_register_id()  /* the difference with vmstate_register() was
>                             just this test */
> 
> After auditing all the callers, I decided that using
> vmstate_register_id() didn't brough we a lot, so I just dropped that
> patches but left the test.
> 
> Forcing to use vmstate_register_any() makes easier to grep for the
> places that try to use the vmstate_register(), but perhaps that is not
> enough convenient.

IMHO if we have the dup check in vmstate_register_with_alias_id(),
instance_id isn't a problem anymore; no abuse should happen without failing
that already.

Personally I tend to just drop this one.  If to keep it, maybe change the
error message to suggest the right one, then let it still proceed?  Because
it still works.  The error will only be a hint but help not so much, IMHO.
What do you think?

Thanks,

-- 
Peter Xu


