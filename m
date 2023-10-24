Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C77D577B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJxe-0004an-U7; Tue, 24 Oct 2023 12:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJxZ-0004Ye-OA
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJxW-0005gC-LF
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698163725;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ic84osD5aEUc8NB6vuTu56y+tSX2CP5viTwq/ogUtco=;
 b=DKdypcUThzAziMKW6s2PqR0CvW0rJZkKD9QUP17fdIgHCErMMByb9bwbflEJJZka6tMqFY
 A6FfQyNN+Ib4/E6hlAMQoXLMMmi62l8Z+saqjFAuqgIY/scYuLKj+gRGqhuWtW8VWDDLPG
 GKQfnR+I0VBeSisyRASLCuu93J6uaO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-qlryp22MNfGj-PijlkxhHw-1; Tue, 24 Oct 2023 12:08:43 -0400
X-MC-Unique: qlryp22MNfGj-PijlkxhHw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084001846eso32650525e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698163722; x=1698768522;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ic84osD5aEUc8NB6vuTu56y+tSX2CP5viTwq/ogUtco=;
 b=DeLQPk47JA4Lcg6leYIz4AQTuRi2udc2Y0hrHT0lbQIvauwCvPX883wgQSQnU7eY7N
 YlWn7osNfTUXSgRZ01gWDwAUYKoLehnygR5xfV3Uew2itXBrmhltOXtjdSN3u/7uftdg
 YgILrmoC4G9DRThuF9VBf1jhJWhPmXjbVBzduFYxSRVDEDbRH5+5D5bZck4G7jsxgkCg
 0JblulMBqz6NbMy7iaP2lhfSInnhHf9AQ9k1mHHbbpOmSqyVfupOoRt4o1gCVov6l8Ki
 eobsea+MXM60iCzu4YyA6C6y92HdW0oUAr1zPaJLeHqWRQ2g4ZnUt/Zhm5Aa8JnrzKSM
 9qeg==
X-Gm-Message-State: AOJu0YwdG5fCNEE5aIO3UNfJdEdcMkYd+snUYd/k56oX+fioCmIw8/3l
 E+tbuLZu5RjKTGeQz8QTyD3gAMAwwgWCpLsoQHbJ6hc0jx+O9zO+qUKPjD5/QBCwk/gES1KByAd
 UTdBTCZ85DhTwKuY=
X-Received: by 2002:a05:600c:2943:b0:407:8b61:da70 with SMTP id
 n3-20020a05600c294300b004078b61da70mr9426353wmd.9.1698163722052; 
 Tue, 24 Oct 2023 09:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzss20DpEPCPajFWJkEfNSIXMyFx+aOXp6fohmX8pYQMZ7GQzEiU6XMtQiZld/YmLEI+SIow==
X-Received: by 2002:a05:600c:2943:b0:407:8b61:da70 with SMTP id
 n3-20020a05600c294300b004078b61da70mr9426338wmd.9.1698163721695; 
 Tue, 24 Oct 2023 09:08:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b004090ca6d785sm2239785wmb.2.2023.10.24.09.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:08:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v3 1/1] migration: vmstate_register() check that
 instance_id is valid
In-Reply-To: <ZTfjd3AFVFaMiAqm@x1n> (Peter Xu's message of "Tue, 24 Oct 2023
 11:32:07 -0400")
References: <20231024150336.89632-1-quintela@redhat.com>
 <20231024150336.89632-2-quintela@redhat.com> <ZTfjd3AFVFaMiAqm@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 18:08:40 +0200
Message-ID: <87cyx4knp3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Oct 24, 2023 at 05:03:36PM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/vmstate.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 9821918631..c48cd8bb68 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -28,6 +28,7 @@
>>  #define QEMU_VMSTATE_H
>>  
>>  #include "hw/vmstate-if.h"
>> +#include "qemu/error-report.h"
>>  
>>  typedef struct VMStateInfo VMStateInfo;
>>  typedef struct VMStateField VMStateField;
>> @@ -1226,6 +1227,11 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
>>                                     const VMStateDescription *vmsd,
>>                                     void *opaque)
>>  {
>> +    if (instance_id == VMSTATE_INSTANCE_ID_ANY) {
>> +        error_report("vmstate_register: Invalid device: %s instance_id: %d",
>> +                     vmsd->name, instance_id);
>> +        return -1;
>> +    }
>>      return vmstate_register_with_alias_id(obj, instance_id, vmsd,
>>                                            opaque, -1, 0, NULL);
>>  }
>
> Juan, could you remind me what's the benefit of failing it like that?


> IIUC you want to suggest using vmstate_register_any(), but I think it's all
> fine to do vmstate_register(VMSTATE_INSTANCE_ID_ANY)?  You didn't have a
> commit message, so I am guessing..

This is v3.  v1 and v2 had much more messages, so I thought this was not
necessary.

We had lots of places that had vmstate_register(..., 0, ...) where it
should have s/0/VMSTATE_INSTANCE_ID_ANY/

The idea here is that we use vmstate_register_any(...) when we don't
care about the number and we know there is only to be one device.

On my tree, I started with the test:

    if (instance_id < 0) {
        error_report("vmstate_register: Invalid device: %s instance_id: %d",
                     vmsd->name, instance_id);
        return -1;
    }

But then ppc abuses this interface and passes an uint32_t where it
should be an int, so I have to check only for that specific value.

> Even if that is wanted, the current error message can be confusing to a
> developer adding a new vmstate_register(VMSTATE_INSTANCE_ID_ANY) call.
> Maybe directly suggest vmstate_register_any() in the error message?  But
> again, I don't see a benefit, vmstate_register(VMSTATE_INSTANCE_ID_ANY)
> should still work if without this patch?  Where did I miss?

You are right, using the other interface.

Initial version on this series, I split vmstate_register() into:
- vmstate_register_any()
- vmstate_register_id()  /* the difference with vmstate_register() was
                            just this test */

After auditing all the callers, I decided that using
vmstate_register_id() didn't brough we a lot, so I just dropped that
patches but left the test.

Forcing to use vmstate_register_any() makes easier to grep for the
places that try to use the vmstate_register(), but perhaps that is not
enough convenient.

Later, Juan.


