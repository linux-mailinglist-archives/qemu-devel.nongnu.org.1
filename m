Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52C728744
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 20:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7KRZ-0003MF-KX; Thu, 08 Jun 2023 14:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q7KRE-0003I6-64
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q7KRC-00078o-JR
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686249164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kknRX0vmRx1yYVMQPoDcU43xOwV6yXiaM/2uh25kKrM=;
 b=RT9S2yAL9qpCkvBbDRGeOxS4iOq3IUt1Sa0oIg/015AxGw5+R3+IcD6uDgbHVCOPqbtPJ5
 8zaXx5QWtQu/YM40PW+PYQZIvKE7kUvcenhyktHFRR6OROrzE8SU7Iq00a93W6wFcUk2ZJ
 X3n6S+x2k+04Pap7LxfuMDuzTj+e390=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-IzhJ0WIQO7GRVI6Xq1soMQ-1; Thu, 08 Jun 2023 14:32:42 -0400
X-MC-Unique: IzhJ0WIQO7GRVI6Xq1soMQ-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7748b05ab49so79425039f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 11:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686249161; x=1688841161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kknRX0vmRx1yYVMQPoDcU43xOwV6yXiaM/2uh25kKrM=;
 b=W8ZKzFVXl5kFbrcVx+YNfOYd+8IcbRioQeRmc/2bZqGAeyD0FkzRz83/5YmHLLaHC/
 i85aibtZrBafXhZ7/X0KWKjlODaFY5oS6/WlsFBM8qOWF+mE9HtMzoLIJH2MIBf5MMgh
 t+JgEMTV1fAsdeTu7rzdt/7wBn079xvU6aZjOWaRtnDIQexbKZnsJYJVxMF0Q6ff+eOV
 MrcskI7KdjxFLB3oKOnubOQ6f0uW7cFSRj9PveRo9i/acXUlKH83LckBrVsWQDq9gSY/
 UKbhybeuMA490RavYpB/t4Gwg0z3RjK31S8IKW4eLULovIGIpGQBXjMiqYpJRSzREgzu
 qftQ==
X-Gm-Message-State: AC+VfDztlBHsdzsX+5RRI+9bvv11osBUNzS9BV+8e3QeaJUpeTpS6Olb
 e1bXx3wkdwhnL4T27yykKG2l3/9aIjroOsjosu+9z7herAGOeRasq+Ca3Er8AvxirpsgFQ8HFry
 rQA9gPcboMMCcuPk=
X-Received: by 2002:a92:d0d1:0:b0:33e:8317:4dab with SMTP id
 y17-20020a92d0d1000000b0033e83174dabmr1770088ila.10.1686249161589; 
 Thu, 08 Jun 2023 11:32:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6n5NHHUML2hZp3oumHAFt+11MfsRj+lxTXOfy3mT9TyDIUS4BKoBl+fNqt6hkico9R9nghQg==
X-Received: by 2002:a92:d0d1:0:b0:33e:8317:4dab with SMTP id
 y17-20020a92d0d1000000b0033e83174dabmr1770063ila.10.1686249161261; 
 Thu, 08 Jun 2023 11:32:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 d13-20020a92d78d000000b0033b3348519bsm565738iln.69.2023.06.08.11.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 11:32:40 -0700 (PDT)
Date: Thu, 8 Jun 2023 12:32:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v5 2/9] migration: Implement switchover ack logic
Message-ID: <20230608123238.46e460ab.alex.williamson@redhat.com>
In-Reply-To: <2377a8be-9c60-8455-b735-bed18f0ba238@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-3-avihaih@nvidia.com>
 <20230605160600.7df0993e.alex.williamson@redhat.com>
 <2377a8be-9c60-8455-b735-bed18f0ba238@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 6 Jun 2023 15:12:13 +0300
Avihai Horon <avihaih@nvidia.com> wrote:
> On 06/06/2023 1:06, Alex Williamson wrote:
> > On Tue, 30 May 2023 17:48:14 +0300
> > Avihai Horon <avihaih@nvidia.com> wrote:
> >> @@ -2700,6 +2713,20 @@ static void migration_update_counters(MigrationState *s,
> >>                                 bandwidth, s->threshold_size);
> >>   }
> >>
> >> +static bool migration_can_switchover(MigrationState *s)
> >> +{
> >> +    if (!migrate_switchover_ack()) {
> >> +        return true;
> >> +    }
> >> +
> >> +    /* No reason to wait for switchover ACK if VM is stopped */
> >> +    if (!runstate_is_running()) {
> >> +        return true;
> >> +    }  
> > Is it possible for QEMU to force the migration to continue regardless
> > of receiving an ack from the target and is this the check that would
> > allow that?  
> 
> Yes. If you stop the source VM then migration will not wait for an ACK 
> to do the switchover.
> 
> >
> > It seems that we don't know the downtime allowed for the VM in any of
> > this, nor do we know how much time the target device will require to
> > generate an ack, but we could certainly have conditions where the
> > priority is moving the VM from the source host regardless of the
> > resulting downtime.  
> 
> In such cases you can keep the switchover-ack capability off.

How is that accomplished?

> > Also does the return path requirement preclude offline migration or
> > does the above again take care of that if we pause the VM for an
> > offline migration (ex. save to and restore from file)?  
> 
> I suppose that by offline migration you mean migration where you stop 
> the source VM first and then do migration?

Yes.

> If so, offline migration should work and in that case we don't care 
> about the ACK as downtime is not a concern.
> 
> However, migrating to a file doesn't work with return-path, as you don't 
> have the destination side responding to the source via the return path.
> For this reason, using return-path when migrating to a file doesn't make 
> sense.

So we require return-path for switchover-ack, but switchover-ack is
only required for pre-copy, therefore why do we require return-path for
an offline migration?

If there's a way to turn off switchover-ack capability, is there also a
way to turn off return-path and therefore enable migration to file?
Sorry if I'm simply not familiar with these migration switches.  Thanks,

Alex


