Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4187BC9EF
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 23:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpErm-0004vU-5k; Sat, 07 Oct 2023 17:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpErk-0004uM-QM
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 17:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpErj-0000vV-AG
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 17:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696714178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9VmlhS1qm0PWSEfbbNLTaZ2THw4LfYgk1tJdqY/4CA=;
 b=gh32/sviIM0bX4g5+0vnz4KlP5bWy8J1+rlXP6uNOJxinBVAmCd9CHIXVD76RWzjfgxeE2
 BsRhB6t96iluhHRuO4H7sitVgagD7BjP0NUvkBiD0fsGQSTjl+h3tRpHy/apv2lwr0XY7K
 QmKB2U+C+YF20hRMPQdffqZZq3paBJo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-wMxKyiEgO2q7QLWHi_fTlA-1; Sat, 07 Oct 2023 17:29:36 -0400
X-MC-Unique: wMxKyiEgO2q7QLWHi_fTlA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-50daa85e940so2565898a12.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 14:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696714175; x=1697318975;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o9VmlhS1qm0PWSEfbbNLTaZ2THw4LfYgk1tJdqY/4CA=;
 b=gytC25DjSxFE71lV5lPF+9tSqut4eagDALlVsC5q29ltHlAOPdH/QqQmnveKLwsNbe
 O1jevj1kTLliZMkfj+Pq0vjpsSG1pgrrH1IarjCMtHMva7SToNUw8y3Ab+J7n6us6dN5
 QIDj8L2SI5e5LRFwrgYGCiJLaseA1AX2PMtQSiQ7c4/raNvXTH7O6HP6f9ZwE/0W8mp2
 oibW9f+1rjDqZJtJj+G9xw+F+DcTk0+FJ5fkoy1mG5AvnFucImiCvbE9n1glxY9RaL2Y
 IXK46oP4GeRpOBGAEByJb2MOtVHmMUsK+UtU0ZyyPWS7BQ7c3SulZD2RHkkXJHJZvMkF
 MHRA==
X-Gm-Message-State: AOJu0YxhtdJuwD/xzgClv8IB4Eqi0PC44a5+Z6OCKUAIssiqnIWDgsrF
 K2otMLRpC+gUPaG0TSYDo7xZxlZvnSBE1i/xIfuEtgmdGmmDZbm1FNzVWrqrmvf8ei1u+nEfoRx
 px1PkfFtKV2HMrM4=
X-Received: by 2002:aa7:c695:0:b0:523:4acb:7f41 with SMTP id
 n21-20020aa7c695000000b005234acb7f41mr10439324edq.14.1696714175722; 
 Sat, 07 Oct 2023 14:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpm3frAg7BAVTEdJzN+v/M1d8aPXLP5eN8PIcYmByXu9UjergQkclT/vYTBtV3oEW9IX/dvw==
X-Received: by 2002:aa7:c695:0:b0:523:4acb:7f41 with SMTP id
 n21-20020aa7c695000000b005234acb7f41mr10439314edq.14.1696714175429; 
 Sat, 07 Oct 2023 14:29:35 -0700 (PDT)
Received: from redhat.com ([2.55.10.88]) by smtp.gmail.com with ESMTPSA id
 l25-20020aa7c319000000b0053441519ed5sm4244114edq.88.2023.10.07.14.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 14:29:34 -0700 (PDT)
Date: Sat, 7 Oct 2023 17:29:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: virtio-fs@redhat.com,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v4 2/8] vhost-user.rst: Improve
 [GS]ET_VRING_BASE doc
Message-ID: <20231007172809-mutt-send-email-mst@kernel.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-3-hreitz@redhat.com>
 <20231005173859.GC1342722@fedora>
 <851b7629-2302-5624-eb81-6839e250991e@redhat.com>
 <20231006044753-mutt-send-email-mst@kernel.org>
 <483bedcf-9c55-6977-f82c-5ce611ca5769@redhat.com>
 <3523c3c6-cd0c-947d-cf84-d648ef813f66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3523c3c6-cd0c-947d-cf84-d648ef813f66@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Oct 06, 2023 at 03:58:44PM +0200, Hanna Czenczek wrote:
> On 06.10.23 15:55, Hanna Czenczek wrote:
> > On 06.10.23 10:49, Michael S. Tsirkin wrote:
> > > On Fri, Oct 06, 2023 at 09:53:53AM +0200, Hanna Czenczek wrote:
> > > > On 05.10.23 19:38, Stefan Hajnoczi wrote:
> > > > > On Wed, Oct 04, 2023 at 02:58:58PM +0200, Hanna Czenczek wrote:
> 
> [...]
> 
> > > > >    ``VHOST_USER_GET_VRING_BASE``
> > > > >      :id: 11
> > > > >      :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
> > > > >      :request payload: vring state description
> > > > > -  :reply payload: vring state description
> > > > > +  :reply payload: vring descriptor index/indices
> > > > > +
> > > > > +  Stops the vring and returns the current descriptor index
> > > > > or indices:
> > > > > +
> > > > > +    * For a split virtqueue, returns only the 16-bit next descriptor
> > > > > +      index in the *Available Ring*.  The index in the *Used Ring* is
> > > > > +      controlled by the guest driver and can be read from the vring
> > > > > I find "is controlled by the guest driver" confusing. The
> > > > > device writes
> > > > > the Used Ring index. The driver only reads it. The device is
> > > > > the active
> > > > > party here.
> > > > Er, good point.  That breaks the whole reasoning.  Then I don’t
> > > > understand
> > > > why we do get/set the available ring index and not the used ring
> > > > index.  Do
> > > > you know why?
> > > It's simple. used ring index in memory is controlled by the device and
> > > reflects device state.
> > 
> > Exactly, it’s device state, that’s why I thought the front-end needs to
> > ensure its read and restored around the reset we currently have in
> > vhost_dev_stop()/start().
> > 
> > > device can just read it back to restore.
> > 
> > I find it strange that the device is supposed to read its own state from
> > memory.
> > 
> > > available ring index in memory is controlled by driver and does
> > > not reflect device state.
> > 
> > Why can’t the device read the available index from memory?  That value
> > is put into memory by the driver precisely so the device can read it
> > from there.
> 
> Ah, wait, is the idea that the device may have an internal available index
> counter that reflects what descriptor it has already fetched? I.e. this
> index will lag behind the one in memory, and the difference are new
> descriptors that the device still needs to read? If that internal counter is
> the index that’s get/set here, then yes, that makes a lot of sense.
> 
> Hanna

Exactly. And this gets eventually written out as used index.

-- 
MST


