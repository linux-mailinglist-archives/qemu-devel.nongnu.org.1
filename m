Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBC70807E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcCs-0006Kg-6n; Thu, 18 May 2023 07:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzcCq-0006KH-3O
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzcCo-0005Tt-J3
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684410842;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Fs8q+Ve0hXLs+i0YqqQyUF1fGeVTUzv0GmvleBE2/+A=;
 b=Jk3hg8gP4Tq+qmgcjsRBLE+Thk2eoKcNQv6tXuHD6t6RkOJaRHcJcGBTVwDnfv583kk1xM
 JcgyKZ1SkOfL/qzVMgPyBB03IKBMSjnbvtTGD5UtbIpErqsbMWyWeuP8mI34745XxMmx7Q
 c0E/Uqpy0bdXThc1Kvq/MjA/Sz3BI3w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-9CneAKdxMWy_0-8t2VYWQg-1; Thu, 18 May 2023 07:53:58 -0400
X-MC-Unique: 9CneAKdxMWy_0-8t2VYWQg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f426d4944fso7356475e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684410837; x=1687002837;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fs8q+Ve0hXLs+i0YqqQyUF1fGeVTUzv0GmvleBE2/+A=;
 b=Kq3nQk3BosAv9HMj4l5haV8Iiyvb54+Kaki0YCRfC9+/o1S+p8AemQTXLvXac8Aq0g
 VWH2BDRpbe/9kGLth7d7R8bO0vuBbqTHnCjwQao9d4HEA7//VWBmJ+cWF9mVmjy449Yl
 ou88XTW6liRsE8tjsUuIS082q+w7/ifk5gn3Kr5xmBpIispvLYLSMI4R4i0CUkZc124W
 5D8lNWQcuutDi62i72LknpVqf605t0rNMooDo6M0ZU9bFKMXTihuwIL4QyDns3sgHUGB
 E6MXFt0duyHiSUNPZrtZ7FL5wL9tQCW/+5Em+WbxQXSBt4SX4xWqCKj4c8UblhOSJ9B/
 B2Jw==
X-Gm-Message-State: AC+VfDyK1H57MT8cm9OrtY/BMfFaiJ3prtJrTxtp2NtQILkoD9NySPVg
 Vc1SyMr1dCnYIfuCLYMa/P6WuMey+8NK5OLCDOFw6AJFUSjx6yV851CqYjF7S3H7KCqX8mtDodt
 lcdtJF7+EBEkVvpw=
X-Received: by 2002:a1c:4b08:0:b0:3f4:2d22:536a with SMTP id
 y8-20020a1c4b08000000b003f42d22536amr1291107wma.19.1684410837554; 
 Thu, 18 May 2023 04:53:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kNvP7sAG+Qks9yuHqwYLSSL5nMVs6zOawh/AKMu6eSHjiuiqPe4rcuNl0+u+n+SDAsaPB7g==
X-Received: by 2002:a1c:4b08:0:b0:3f4:2d22:536a with SMTP id
 y8-20020a1c4b08000000b003f42d22536amr1291097wma.19.1684410837205; 
 Thu, 18 May 2023 04:53:57 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 y18-20020a1c4b12000000b003f4fffccd73sm1838510wma.9.2023.05.18.04.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:53:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 berrange@redhat.com,  shivam.kumar1@nutanix.com
Subject: Re: [RFC v3 0/2] migration: Update error description whenever
 migration fails
In-Reply-To: <20230518062308.90631-1-tejus.gk@nutanix.com> (Tejus GK's message
 of "Thu, 18 May 2023 06:23:06 +0000")
References: <20230518062308.90631-1-tejus.gk@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:53:55 +0200
Message-ID: <87ednddfe4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Tejus GK <tejus.gk@nutanix.com> wrote:
> Hi everyone,
>
> Thank you everyone for the reviews, this is the	v3 patchset based on the 
> reviews	received on the	previous ones. 

Hi

I did the review-by.
But you have to resend with a proper PATCH subject line to get this in.

I will split the removal of the duplicated yank, because that is
independent of the patch.

And for the rest it is ok.

Thanks, Juan.


>
> Links to the previous patchsets:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00868.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg01943.html
>
> I've broken this patchset into two parts; the first patch contains fixes
> for places in migration.c where	the failure reason is not updated.
> Compared to the	previous patchset, this	fixes a	few errors existing in  
> the last patch and covers a few	more places where the failure reason 
> isn't updated. 
>
> The second patch, covers places	outside	of migration.c,	which eventually 
> lead to	a migration failure, along with	an error_report() call being 
> made, however without an update	for the failure	reason.	I am aware that	
> the changes in vmstate.c breaks	the build due to a unit-test build 
> failing, so I wanted to	know the right way to approach this. 
>
> regards,
> Tejus
>
>
> Tejus GK (2):
>   migration: Update error description whenever migration fails
>   migration: Update error description whenever migration fails
>
>  migration/migration.c | 23 ++++++++++++-----------
>  migration/savevm.c    | 13 ++++++++++---
>  migration/vmstate.c   | 13 ++++++++++---
>  3 files changed, 32 insertions(+), 17 deletions(-)


