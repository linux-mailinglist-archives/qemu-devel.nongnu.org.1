Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806F7D65E8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 10:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZfo-0004lf-K3; Wed, 25 Oct 2023 04:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZfd-0004k8-L0
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 04:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZfc-0003hj-0x
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698224119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LuLDI/oQZrY0VmDs+FlfukB1baC4zTk8x88TvKUyg24=;
 b=MkE7oLkvk+fRUpaGyo5oUOs/hA38r3xn1y33ogzJ3YbcYkLHFhp9JD4b9Zn+62WG2msw9v
 0SiUcy9cI5RAqHZExIk9UEu+dnwrNH1TLNbGQBTBDDgfs2xCN7XH/OiypXqBK9vieUy/+l
 XinBqI0Rpt0WA5OTq5K0lvv9cNNBfVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-CTQGN08yOT68ab7-HaD_IA-1; Wed, 25 Oct 2023 04:55:02 -0400
X-MC-Unique: CTQGN08yOT68ab7-HaD_IA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408534c3ec7so29460355e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 01:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698224101; x=1698828901;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuLDI/oQZrY0VmDs+FlfukB1baC4zTk8x88TvKUyg24=;
 b=TYV7QrN2E26OXvhWT+Lc3HSI65k3zk1+TkvoVkTMkAzIclNm5bbd9r7dO9Qv5fo4J5
 F/7FUuqkCz5XfxL/L4kOY5XG/22rmak4ICzY+97OwLHdQY3nj5NAN/1rJ0lfDYmUEY4+
 GyKFuhN6QuECYxZmZnuRMUb7v9ZWx8i/KL1D3l0QUpNhUO7wW7pdNSmaHbD5cDpm4yFs
 nGciMFfFSLdsRkN8DvISQMV51Uj12cKXpTm/5LPo7slNQRtXvWcPLE8nMOgAkIOcNKgk
 RdRVHasrJzKqrkR2z4gr4vgxDz7KIH1cyJEq6Lu8b1YLVlLznNJ6bam16qHWZEIECmJy
 SmWQ==
X-Gm-Message-State: AOJu0YzVq+WTCMTDn5QpknrOZUCqk79tUKTKW9Eur+p950Yl61MSDgp2
 1M1cTLcTgID4fjMnuOTJxUpEQqI7JGlhfjZdCBGCrQmcmHQrFtZL7en921fG3ZHBxtzIoDpg6fR
 CRh1qS//dMx2yAseLWcUvdL0=
X-Received: by 2002:a05:600c:4f91:b0:408:49cd:ebf7 with SMTP id
 n17-20020a05600c4f9100b0040849cdebf7mr11306901wmq.22.1698224100855; 
 Wed, 25 Oct 2023 01:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEDKsbAPdQY1/rK3r9QEkZ9xghTzVgX9L2UWkIqKSi9942/LPt7rA8qT8MnKrawEWPrqijIw==
X-Received: by 2002:a05:600c:4f91:b0:408:49cd:ebf7 with SMTP id
 n17-20020a05600c4f9100b0040849cdebf7mr11306895wmq.22.1698224100451; 
 Wed, 25 Oct 2023 01:55:00 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c158900b0040776008abdsm13925950wmf.40.2023.10.25.01.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 01:55:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v3 1/1] migration: vmstate_register() check that
 instance_id is valid
In-Reply-To: <ZTf1yoZ0GSlRfxSN@x1n> (Peter Xu's message of "Tue, 24 Oct 2023
 12:50:18 -0400")
References: <20231024150336.89632-1-quintela@redhat.com>
 <20231024150336.89632-2-quintela@redhat.com> <ZTfjd3AFVFaMiAqm@x1n>
 <87cyx4knp3.fsf@secure.mitica> <ZTf1yoZ0GSlRfxSN@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 25 Oct 2023 10:54:59 +0200
Message-ID: <87h6mff5ek.fsf@secure.mitica>
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

>> > IIUC you want to suggest using vmstate_register_any(), but I think it's all
>> > fine to do vmstate_register(VMSTATE_INSTANCE_ID_ANY)?  You didn't have a
>> > commit message, so I am guessing..
>> 
>> This is v3.  v1 and v2 had much more messages, so I thought this was not
>> necessary.
>> 
>> We had lots of places that had vmstate_register(..., 0, ...) where it
>> should have s/0/VMSTATE_INSTANCE_ID_ANY/
>> 
>> The idea here is that we use vmstate_register_any(...) when we don't
>> care about the number and we know there is only to be one device.
>> 
>> On my tree, I started with the test:
>> 
>>     if (instance_id < 0) {
>>         error_report("vmstate_register: Invalid device: %s instance_id: %d",
>>                      vmsd->name, instance_id);
>>         return -1;
>>     }
>> 
>> But then ppc abuses this interface and passes an uint32_t where it
>> should be an int, so I have to check only for that specific value.
>> 
>> > Even if that is wanted, the current error message can be confusing to a
>> > developer adding a new vmstate_register(VMSTATE_INSTANCE_ID_ANY) call.
>> > Maybe directly suggest vmstate_register_any() in the error message?  But
>> > again, I don't see a benefit, vmstate_register(VMSTATE_INSTANCE_ID_ANY)
>> > should still work if without this patch?  Where did I miss?
>> 
>> You are right, using the other interface.
>> 
>> Initial version on this series, I split vmstate_register() into:
>> - vmstate_register_any()
>> - vmstate_register_id()  /* the difference with vmstate_register() was
>>                             just this test */
>> 
>> After auditing all the callers, I decided that using
>> vmstate_register_id() didn't brough we a lot, so I just dropped that
>> patches but left the test.
>> 
>> Forcing to use vmstate_register_any() makes easier to grep for the
>> places that try to use the vmstate_register(), but perhaps that is not
>> enough convenient.
>
> IMHO if we have the dup check in vmstate_register_with_alias_id(),
> instance_id isn't a problem anymore; no abuse should happen without failing
> that already.
>
> Personally I tend to just drop this one.  If to keep it, maybe change the
> error message to suggest the right one, then let it still proceed?  Because
> it still works.  The error will only be a hint but help not so much, IMHO.
> What do you think?

I would preffer it, but not enough to fight for it, so dropping it.

Thanks, Juan.


