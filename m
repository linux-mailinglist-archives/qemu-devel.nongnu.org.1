Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2920F7D0214
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:51:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtY6u-0007r3-2Z; Thu, 19 Oct 2023 14:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtY6q-0007mv-Sb
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtY6p-0008B5-At
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697741462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5vEaCopLSIRKJR9XHZSObv6fp79XMSTcyXJH49UqJFA=;
 b=NrslMEF413CpgbdOQfH/UyptC25SdNmdy92EcDNRe62vur7ORDCk9KhW794dGPtS75BcLl
 1hA/BXsXNjDmuSIs6/IMBakYuK5fbQMHZrYVkpa9A8N3Eiwptc3rkAHCQHd316cRrPTD6V
 xCorZonToXrKIqyIbK55LGQdiKLUW+c=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Jm08mapcMLqe54K1AigiZw-1; Thu, 19 Oct 2023 14:50:55 -0400
X-MC-Unique: Jm08mapcMLqe54K1AigiZw-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-457d696b0cbso389453137.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697741455; x=1698346255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vEaCopLSIRKJR9XHZSObv6fp79XMSTcyXJH49UqJFA=;
 b=bpMIE69R3BYaGC1cpCjvqeTkL4SZs56qJU4lsOEGHDWghawCiNNLICiqAMXCkiLJkG
 htA5PclR92vtoK+wQVwkwLs+k2gJF21IuaL7uYTU4cccgK99+LU4c1zO93vrzFXBWl4U
 ZyvGROXv7yffd9FespwKz3d4KHHsjiLIaISUUSYksQNOPJb296txdH+xT3IX3zc6BaJz
 zE6sd1MMhSR1seFXK8wL55VxsnNM7ppK6uGN0LIdgwZjUQi7f9eCsJKoPfrz5LI3VS/b
 I6HrESsQOQO9YVIDFKYNp1j3oOfTIJjR0BJz2GLP/+oY3lYjxVhfx5RsnAURRdj/hhz4
 IxrA==
X-Gm-Message-State: AOJu0Yxj1B2GiOE1eo2NBDvvf1F8dU8gxQB0r5USKPj/FqWzl6zQCCUH
 FwkTDtJM+hX8PTR4aJhqWZViX+5tYcvYzySEpfMV43RYmYsAxWNVgAA9ch/pH28pKmSVfySB8wo
 cddaG7hP+I0zU0bM=
X-Received: by 2002:a05:6102:3236:b0:457:eca8:2d with SMTP id
 x22-20020a056102323600b00457eca8002dmr2207704vsf.1.1697741455136; 
 Thu, 19 Oct 2023 11:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsJFNGTvae9cXjaIUSdjz/NH7FCeix4hFx6bf30cHaLD8Nhunga6JatPjZC+ozJh6aUc5ATg==
X-Received: by 2002:a05:6102:3236:b0:457:eca8:2d with SMTP id
 x22-20020a056102323600b00457eca8002dmr2207695vsf.1.1697741454845; 
 Thu, 19 Oct 2023 11:50:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x17-20020ac87a91000000b0041818df8a0dsm21550qtr.36.2023.10.19.11.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:50:54 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:50:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
Message-ID: <ZTF6jWsOZe5+f+8v@x1n>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <ZTE+lmbvtYNDU80q@x1n>
 <871qdq4pzh.fsf@secure.mitica> <ZTFPUUdJ5Y8/szaA@x1n>
 <87h6mm31sa.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6mm31sa.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 19, 2023 at 08:28:05PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Thu, Oct 19, 2023 at 05:00:02PM +0200, Juan Quintela wrote:
> >> Peter Xu <peterx@redhat.com> wrote:
> >> > Fabiano,
> >> >
> >> > Sorry to look at this series late; I messed up my inbox after I reworked my
> >> > arrangement methodology of emails. ;)
> >> >
> >> > On Thu, Oct 19, 2023 at 11:06:06AM +0200, Juan Quintela wrote:
> >> >> Fabiano Rosas <farosas@suse.de> wrote:
> >> >> > The channels_ready semaphore is a global variable not linked to any
> >> >> > single multifd channel. Waiting on it only means that "some" channel
> >> >> > has become ready to send data. Since we need to address the channels
> >> >> > by index (multifd_send_state->params[i]), that information adds
> >> >> > nothing of value.
> 
> >> And that is what we do here.
> >> We didn't had this last line (not needed for making sure the channels
> >> are ready here).
> >> 
> >> But needed to make sure that we are maintaining channels_ready exact.
> >
> > I didn't expect it to be exact, I think that's the major part of confusion.
> > For example, I see this comment:
> >
> > static void *multifd_send_thread(void *opaque)
> >        ...
> >         } else {
> >             qemu_mutex_unlock(&p->mutex);
> >             /* sometimes there are spurious wakeups */
> >         }
> 
> I put that there during development, and let it there just to be safe.
> Years later I put an assert() there and did lots of migrations, never
> hit it.
> 
> > So do we have spurious wakeup anywhere for either p->sem or channels_ready?
> > They are related, because if we got spurious p->sem wakeups, then we'll
> > boost channels_ready one more time too there.
> 
> I think that we can change that for g_assert_not_reached()

Sounds good.  We can also use an error_erport_once(), depending on your
confidence of that. :)  Dropping that comment definitely helps.

I had a quick look, indeed I think it's safe even with assert.  We may want
to put some more comment on when one should kick p->sem; IIUC it can only
be kicked in either (1) pending_job increased, or (2) set exiting=1.  Then
it seems all guaranteed.

Thanks,

-- 
Peter Xu


