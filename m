Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023C7A8B85
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1lc-0000mo-7Q; Wed, 20 Sep 2023 14:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj1la-0000mf-RJ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj1lZ-0000VE-BH
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695233856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kr9xJYUwF1FmFYXRjfFyl/NnnvqQ2lW3YXykRgV2hKQ=;
 b=RncyPWfQ6tzWmjA06g3rTGwSY37qmIL4zGZSSJh5td8Vo743zuSoRhO6k6cI6tUFnGIrZy
 OTUBEZugLmVlkdvO3mN16ez/fsBpnAxVICO9lAgX2C/74ClaEEJhw4NHUefMjFh4+01zw1
 u8xMs4A1i3JhzeBWGxHEb5hYa3Q/sc4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-rN1pCwbtPj2oVZa7hZq2pQ-1; Wed, 20 Sep 2023 14:17:33 -0400
X-MC-Unique: rN1pCwbtPj2oVZa7hZq2pQ-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-34fc2428821so488215ab.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233846; x=1695838646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr9xJYUwF1FmFYXRjfFyl/NnnvqQ2lW3YXykRgV2hKQ=;
 b=codi/ppMHj6Ircht6ycQoXQH84w/Z/caQkx1yOnxnI4hGb6wT0ZakdASPOXSvAUq1Y
 IyFQVHLaJ/FDPuejDwdawiOYwnnIxj3X7g7i3tvidZa0XVnItqfW6l/WHwrmpXDgDp2X
 1E9K3fZtf4cQN488H3EBkRfQ4NNw3UkelmUKrU2bb7i5mrJPOEx4RIynfcQo4iITBRv/
 LFka5PUepDIM++O2/tBDrQMCyiPwfa7iwncCG43HbA0cssPk4fcEC8LkV285h1bPPgVa
 Xk+HXX+s8SDnQAI2z3t/yxDOHFHp7sDJ733dFl9WkixQuWMcowny0D9GiNCh0inQlnVV
 Yklg==
X-Gm-Message-State: AOJu0YxujIBtbj7676o9rlPe6klKHS3jiRYd5eyt650IisCUrJo6SBuE
 Am8JV+mnkynA9rlNzFJmhp/bhMPb4DvKuwoWAP/cziq6xhOy1pwuzpzMDBKRPOFxu5JYgr6CPoP
 0YmhCLI/yWZGkEpI=
X-Received: by 2002:a05:6e02:1c07:b0:34f:f077:24d9 with SMTP id
 l7-20020a056e021c0700b0034ff07724d9mr4398443ilh.31.1695233846123; 
 Wed, 20 Sep 2023 11:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECTM92HCYzKgESI2OyY4Z+DL9a9XLx+TEyXVySxEKaTbGEonnJ7heYHSfmovvZxG9PxnG1iw==
X-Received: by 2002:a05:6e02:1c07:b0:34f:f077:24d9 with SMTP id
 l7-20020a056e021c0700b0034ff07724d9mr4398420ilh.31.1695233845903; 
 Wed, 20 Sep 2023 11:17:25 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 u1-20020a02c041000000b00430996b3604sm4321380jam.125.2023.09.20.11.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 11:17:25 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:17:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Daniel
 P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <20230920121724.381716d4.alex.williamson@redhat.com>
In-Reply-To: <20230920174919.GF13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
 <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
 <a0f3fab2-069e-f286-aae8-25d5269e6e0c@redhat.com>
 <20230920174919.GF13733@nvidia.com>
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

On Wed, 20 Sep 2023 14:49:19 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 20, 2023 at 07:37:53PM +0200, Eric Auger wrote:
> 
> > >> qemu will typically not be able to
> > >> self-open /dev/iommufd as it is root-only.  
> > >
> > > I don't understand, we open multiple fds to KVM devices. This is the
> > > same.  
> > Actually qemu opens the /dev/iommu in case no fd is passed along with
> > the iommufd object. This is done in
> > [PATCH v1 16/22] backends/iommufd: Introduce the iommufd object, in
> > 
> > iommufd_backend_connect(). I don't understand either.  
> 
> The char dev node is root only so this automatic behvaior is fine
> but not useful if qmeu is running in a sandbox.
> 
> I'm not sure what "multiple fds to KVM devices" means, I don't know
> anything about kvm devices..

Looking at a local VM, the only kvm related open file is /dev/kvm,
which kvm_init() does directly open.  The other tun/tap/vhost files are
all passed by fd.  We have a bunch of anon_inodes representing eventfds
and vcpu source from /dev/kvm, but the only other direct files are disk
images and the created pid file.
 
> The iommufd design requires one open of the /dev/iommu to be shared
> across all the vfios.

"requires"?  It's certainly of limited value to have multiple iommufd
instances rather than create multiple address spaces within a single
iommufd, but what exactly precludes an iommufd per device if QEMU, or
any other userspace so desired?  Thanks,

Alex


