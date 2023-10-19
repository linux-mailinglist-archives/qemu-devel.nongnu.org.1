Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ECD7D0185
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXkw-0005m4-8e; Thu, 19 Oct 2023 14:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtXks-0005gD-Ev
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtXkq-0006oY-R5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697740100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Og7nUMbc3kOXcd+zZZfzVVzfH0skjvIbvK8n/J1928k=;
 b=SGh81UGA2c+LAFKiudvJcdyGNsb5GteGORrg6WksjYcszCW0RLeevtbrV5zFi1F7vDbDNS
 B/ILoe+zd3VA2Wa5ZlPi7H7Pz/5+Q5X7XOapQfcvYSU6M6KvP77HsufV06lbj0gNZtYeb+
 l9Nxk7L1dwhlni+EmM3F9R4tM7eJeds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-7UcMty89PO6oPtuRvuKsIw-1; Thu, 19 Oct 2023 14:28:08 -0400
X-MC-Unique: 7UcMty89PO6oPtuRvuKsIw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408374a3d6bso15985205e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740087; x=1698344887;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Og7nUMbc3kOXcd+zZZfzVVzfH0skjvIbvK8n/J1928k=;
 b=ZCY3gB8dbm0qAoo5L9R1Xrny15qGdoenHVpWdAtG2Etl0g5NH1RgXQylcI7lsXQ86K
 KQQMzi0qOujmQm0GO5CJ+hqMSJ/rvjbt2OUfzLwyDzWH7c6N1c+8srJfE5GO5GKhl/pn
 Teaw6ySssnqtMnzeqwqSXNH91/uryHu+fTPJNlztdcIigNYO1XYUN11b/NfnwneYFST3
 Uw+ZcmRujbr3M/LasA+DDEoKLHyOG/aB/w3ctUIHSSP1ITnsxyTZDs2Y3hf0/0NAyfWi
 dBSTb/e6Gs5w/hGn3pHYRQoZen5UbJ91D15b+fYVmQ/j82IWdUmC1xpcm2aR+kVNDSfF
 17Wg==
X-Gm-Message-State: AOJu0YyrUFY3qTkidkQNFg0mADZH6PpbthEceXpaUu+9AFhSRAp0nsVF
 pDytAlRq8cAIvUnpw0Aa9KfUjCWO+DzaPwbbHQRtE0qgqGS5MZFTa3Tl+7WowPbYIvVRSIvf0ks
 3O4iGQZLta6DGGl4=
X-Received: by 2002:a05:600c:4e91:b0:408:4551:fade with SMTP id
 f17-20020a05600c4e9100b004084551fademr2145476wmq.38.1697740087736; 
 Thu, 19 Oct 2023 11:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4oIk+qzvMGh4i/LZYrWTlndqawKf2uYi+o2u9XANrQHgjBkeS1Du8VEg9xiViVsJyaiHJ2Q==
X-Received: by 2002:a05:600c:4e91:b0:408:4551:fade with SMTP id
 f17-20020a05600c4e9100b004084551fademr2145463wmq.38.1697740087313; 
 Thu, 19 Oct 2023 11:28:07 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v18-20020a05600c15d200b004063d8b43e7sm5000319wmf.48.2023.10.19.11.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:28:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <ZTFPUUdJ5Y8/szaA@x1n> (Peter Xu's message of "Thu, 19 Oct 2023
 11:46:25 -0400")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <ZTE+lmbvtYNDU80q@x1n>
 <871qdq4pzh.fsf@secure.mitica> <ZTFPUUdJ5Y8/szaA@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 20:28:05 +0200
Message-ID: <87h6mm31sa.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Oct 19, 2023 at 05:00:02PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > Fabiano,
>> >
>> > Sorry to look at this series late; I messed up my inbox after I reworked my
>> > arrangement methodology of emails. ;)
>> >
>> > On Thu, Oct 19, 2023 at 11:06:06AM +0200, Juan Quintela wrote:
>> >> Fabiano Rosas <farosas@suse.de> wrote:
>> >> > The channels_ready semaphore is a global variable not linked to any
>> >> > single multifd channel. Waiting on it only means that "some" channel
>> >> > has become ready to send data. Since we need to address the channels
>> >> > by index (multifd_send_state->params[i]), that information adds
>> >> > nothing of value.

>> And that is what we do here.
>> We didn't had this last line (not needed for making sure the channels
>> are ready here).
>> 
>> But needed to make sure that we are maintaining channels_ready exact.
>
> I didn't expect it to be exact, I think that's the major part of confusion.
> For example, I see this comment:
>
> static void *multifd_send_thread(void *opaque)
>        ...
>         } else {
>             qemu_mutex_unlock(&p->mutex);
>             /* sometimes there are spurious wakeups */
>         }

I put that there during development, and let it there just to be safe.
Years later I put an assert() there and did lots of migrations, never
hit it.

> So do we have spurious wakeup anywhere for either p->sem or channels_ready?
> They are related, because if we got spurious p->sem wakeups, then we'll
> boost channels_ready one more time too there.

I think that we can change that for g_assert_not_reached()

> I think two ways to go here:
>
>   - If we want to make them all exact: we'd figure out where are spurious
>     wake ups and we fix all of them.  Or,

This one.

>   - IMHO we can also make them not exact.  It means they can allow
>     spurious, and code can actually also work like that.  One example is
>     e.g. what happens if we get spurious wakeup in multifd_send_pages() for
>     channels_ready?  We simply do some cpu loops as long as we double check
>     with each channel again, we can even do better that if looping over N
>     channels and see all busy, "goto retry" and wait on the sem again.
>
> What do you think?

Make sure that it is exact O:-)

Later, Juan.


