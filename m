Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D404F7CFCEC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7L-0006hO-Rp; Thu, 19 Oct 2023 10:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtU7F-0006fY-Hu
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtU7C-0000EA-1Q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7EQ5lRMNvxuEPJB2lJA801QdMaEc/FnxMTJjrxKPung=;
 b=Oq0vlEdZIp6bz8j4LgPNDzuF7D4lt35UWkPNSFjEmaWm7ZBGuBbs0ab8SRcstuO0XBhTLU
 JAwoL39p443kggtNCPI3HUBaqzhMn99CwCEftzXTLwy49m/u9u2d+BOKddOkmg/g1yIPr0
 HavTCC7wSpUP3qMycQxEfkKQQgvu70E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-KQQuItPjPR-rC8kwEk-mAw-1; Thu, 19 Oct 2023 10:35:04 -0400
X-MC-Unique: KQQuItPjPR-rC8kwEk-mAw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d2fdf80beso15310566d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697726104; x=1698330904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EQ5lRMNvxuEPJB2lJA801QdMaEc/FnxMTJjrxKPung=;
 b=IU3gHlwZyHCU1oMqrjV31mK9b5KxEC7/CoWcytVy8hbnRc1rdeRd5M+hDshmLcnKrJ
 bQEN7TBz79GXEfMIi3D66Pe4lVOYWaGKRKiTO3NvrYhf/IXMHKsdzU2NvQCCsAkX/QNH
 O7gvmJL3qkUFPmEV5oyEI9igT+96ddBnhubXrjPQ0EcH/NIAgZyM97pX+/beToshcZcm
 vpuj3B/giO08xkmN9pii+PBnlJGCwBiaY7GgtwhmiI9/SX7BtdVB4dubrXt7EOmRQMGK
 5tdEVsEAtP/GUJEW9JFZYDPULAJsCQfSHh54NX2cZso7wvlKtk3mYateYE3lqy+RYnqp
 kaWA==
X-Gm-Message-State: AOJu0YwvvWyxFdxSezgHWi4qWJQaUL8ni/FdQL1RWMQXlLKaZvR0hpW+
 s2tjGLDzIrxTjel32uPKfocCfiBamhNchyELGz0PUAdrkWTLItIU6YlMXNZsqdFnbQjq9i0UDc6
 +p+hmRx++co0xZT8=
X-Received: by 2002:a05:6214:4001:b0:66d:5d31:999b with SMTP id
 kd1-20020a056214400100b0066d5d31999bmr2463124qvb.3.1697726103886; 
 Thu, 19 Oct 2023 07:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeKgT1PXshEbS2Q0LAQ23eqLDogxjzGd6M3mZcxj4GVNsSwcV9HsyY7eolBgvOAXjRt7tXTQ==
X-Received: by 2002:a05:6214:4001:b0:66d:5d31:999b with SMTP id
 kd1-20020a056214400100b0066d5d31999bmr2463106qvb.3.1697726103633; 
 Thu, 19 Oct 2023 07:35:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 et10-20020a056214176a00b0064906cfe430sm815725qvb.135.2023.10.19.07.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:35:03 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:35:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
Message-ID: <ZTE+lmbvtYNDU80q@x1n>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf676kxt.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano,

Sorry to look at this series late; I messed up my inbox after I reworked my
arrangement methodology of emails. ;)

On Thu, Oct 19, 2023 at 11:06:06AM +0200, Juan Quintela wrote:
> Fabiano Rosas <farosas@suse.de> wrote:
> > The channels_ready semaphore is a global variable not linked to any
> > single multifd channel. Waiting on it only means that "some" channel
> > has become ready to send data. Since we need to address the channels
> > by index (multifd_send_state->params[i]), that information adds
> > nothing of value.
> 
> NAK.
> 
> I disagree here O:-)
> 
> the reason why that channel exist is for multifd_send_pages()
> 
> And simplifying the function what it does is:
> 
> sem_wait(channels_ready);
> 
> for_each_channel()
>    look if it is empty()
> 
> But with the semaphore, we guarantee that when we go to the loop, there
> is a channel ready, so we know we donat busy wait searching for a
> channel that is free.
> 
> Notice that I fully agree that the sem is not needed for locking.
> Locking is done with the mutex.  It is just used to make sure that we
> don't busy loop on that loop.
> 
> And we use a sem, because it is the easiest way to know how many
> channels are ready (even when we only care if there is one when we
> arrive to that code).
> 
> We lost count of that counter, and we fixed that here:
> 
> commit d2026ee117147893f8d80f060cede6d872ecbd7f
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Wed Apr 26 12:20:36 2023 +0200
> 
>     multifd: Fix the number of channels ready
> 
>     We don't wait in the sem when we are doing a sync_main.  Make it
> 
> And we were addressing the problem that some users where finding that we
> were busy waiting on that loop.

Juan,

I can understand why send_pages needs that sem, but not when sync main.
IOW, why multifd_send_sync_main() needs:

        qemu_sem_wait(&multifd_send_state->channels_ready);

If it has:

        qemu_sem_wait(&p->sem_sync);

How does a busy loop happen?

Thanks,

-- 
Peter Xu


