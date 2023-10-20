Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C177D0A13
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkN0-0005dq-0L; Fri, 20 Oct 2023 03:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtkMx-0005ad-Ix
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtkMw-0006ws-3C
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697788589;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wI+/I2rbDuqXJRVSr1tfbjIIrdrOpeqihjSh7vVBLwk=;
 b=Gnb0xbkl9tF79KuiSGHu8XnYBIZtxXrLh1dw0kC3255r66/tyQ/iSS9Zky2dQmgRGgiVas
 BdSceVkOAyulaB5Ozw+j2SLwPfZ8vONjAKyc4Nf5SBiLHpwFahb2+ZgTTlSEeMv1ardLeW
 5IPKyu9IHLvHDK0fJHg3ALW0MdZsAg8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-Ona8Ocx_OuaUOmHLF6MCZQ-1; Fri, 20 Oct 2023 03:56:27 -0400
X-MC-Unique: Ona8Ocx_OuaUOmHLF6MCZQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50bebd8dfso4353501fa.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 00:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697788586; x=1698393386;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wI+/I2rbDuqXJRVSr1tfbjIIrdrOpeqihjSh7vVBLwk=;
 b=hrJor+/0b7lwtIAvxw94QjthLpNcomj0dYyH1cJJlSoCWV4BT8/NMn7PY2NJy6MCoO
 HRmTyrJGWOVMO+BLnfiyhXK7ct6Wz/T/1VPn4GPvQtYbwWjJReSAlGznlj9fvDdiQi4J
 5pQG2XN+ydGg3nD7HvV5obvC1xPz9gpdc3bfDq6koisX2Cqlwz8dv7hONqobMGgxzHqa
 aSjvXAsvGbqBSy64cHFzsZJAk7TYF+00Y1fj6ekiryrESSe9S9gtVFGaLq1mrcxULpcN
 /Xb83UQnV8m9fsK/WckEalGEsFbKoSYvMS4N3o89IwReoRSFplSKUjkNypvUZ1VzrdzP
 HdKQ==
X-Gm-Message-State: AOJu0Yy4IzTxBKNSoG64aer1zRp0LRGSVr8F38WbMJvQHoLJZmE34oBo
 4Ta8S4MJ5BtfRULUWnNkom9aSMXl4dD/Zw+k3SA+aeLC+32RR7Z7AYVA7W0OgQAKmKPqd39rfFb
 rqKRTsIQqDklzwqcjOP5jQ18JfA==
X-Received: by 2002:a2e:be8e:0:b0:2c5:1f30:ebfc with SMTP id
 a14-20020a2ebe8e000000b002c51f30ebfcmr966492ljr.38.1697788585985; 
 Fri, 20 Oct 2023 00:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl3wc7+fouzcrFeKtoztFnTnydnx11RPlPB2ed+1yujgsua392FJr5rYuch5PAh7FhXwHChA==
X-Received: by 2002:a2e:be8e:0:b0:2c5:1f30:ebfc with SMTP id
 a14-20020a2ebe8e000000b002c51f30ebfcmr966480ljr.38.1697788585601; 
 Fri, 20 Oct 2023 00:56:25 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y34-20020a05600c342200b004063977eccesm6297376wmp.42.2023.10.20.00.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:56:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <ZTF6jWsOZe5+f+8v@x1n> (Peter Xu's message of "Thu, 19 Oct 2023
 14:50:53 -0400")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <ZTE+lmbvtYNDU80q@x1n>
 <871qdq4pzh.fsf@secure.mitica> <ZTFPUUdJ5Y8/szaA@x1n>
 <87h6mm31sa.fsf@secure.mitica> <ZTF6jWsOZe5+f+8v@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 09:56:24 +0200
Message-ID: <87pm1920d3.fsf@secure.mitica>
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
> On Thu, Oct 19, 2023 at 08:28:05PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Thu, Oct 19, 2023 at 05:00:02PM +0200, Juan Quintela wrote:
>> >> Peter Xu <peterx@redhat.com> wrote:
>> >> > Fabiano,
>> >> >
>> >> > Sorry to look at this series late; I messed up my inbox after I reworked my
>> >> > arrangement methodology of emails. ;)
>> >> >
>> >> > On Thu, Oct 19, 2023 at 11:06:06AM +0200, Juan Quintela wrote:
>> >> >> Fabiano Rosas <farosas@suse.de> wrote:
>> >> >> > The channels_ready semaphore is a global variable not linked to any
>> >> >> > single multifd channel. Waiting on it only means that "some" channel
>> >> >> > has become ready to send data. Since we need to address the channels
>> >> >> > by index (multifd_send_state->params[i]), that information adds
>> >> >> > nothing of value.
>> 
>> >> And that is what we do here.
>> >> We didn't had this last line (not needed for making sure the channels
>> >> are ready here).
>> >> 
>> >> But needed to make sure that we are maintaining channels_ready exact.
>> >
>> > I didn't expect it to be exact, I think that's the major part of confusion.
>> > For example, I see this comment:
>> >
>> > static void *multifd_send_thread(void *opaque)
>> >        ...
>> >         } else {
>> >             qemu_mutex_unlock(&p->mutex);
>> >             /* sometimes there are spurious wakeups */
>> >         }
>> 
>> I put that there during development, and let it there just to be safe.
>> Years later I put an assert() there and did lots of migrations, never
>> hit it.
>> 
>> > So do we have spurious wakeup anywhere for either p->sem or channels_ready?
>> > They are related, because if we got spurious p->sem wakeups, then we'll
>> > boost channels_ready one more time too there.
>> 
>> I think that we can change that for g_assert_not_reached()
>
> Sounds good.  We can also use an error_erport_once(), depending on your
> confidence of that. :)  Dropping that comment definitely helps.
>
> I had a quick look, indeed I think it's safe even with assert.  We may want
> to put some more comment on when one should kick p->sem; IIUC it can only
> be kicked in either (1) pending_job increased, or (2) set exiting=1.  Then
> it seems all guaranteed.

I think we can change the end of the loop from:

            qemu_mutex_unlock(&p->mutex);

            if (flags & MULTIFD_FLAG_SYNC) {
                qemu_sem_post(&p->sem_sync);
            }
        } else {
            qemu_mutex_unlock(&p->mutex);
            /* sometimes there are spurious wakeups */
        }

to:

            if (flags & MULTIFD_FLAG_SYNC) {
                qemu_sem_post(&p->sem_sync);
            }
        }
        qemu_mutex_unlock(&p->mutex);


And call it a day.  But we can leave one assert there.

But I would preffer to do this kind of locking changes at the beggining
of next cycle.

Later, Juan.


