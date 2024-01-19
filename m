Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F48327EE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 11:47:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmOd-0006dR-OJ; Fri, 19 Jan 2024 05:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQmOb-0006d7-9N
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQmOY-0003YL-MB
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705661200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d8/OPPo3D/rntMue2BfxleAM+xFOMvqwfwDIQ69i8qc=;
 b=B0wRwOAlD9bj18bjPzGAK4OopxRRWUJNSfj8+HNAR+pbJImByYQRaNpFFWis30czSJ31oH
 LRYJmD8ehVswJi2uSEhXCphvgEd8TOpg/saj//th8DRn1URJbJiGkAkU/1ErTJox7FXs+f
 /beOh/HRfNguYtLjksoGYyOvWBKluUk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-BQYYrsljMOafplHSopCAJw-1; Fri, 19 Jan 2024 05:46:38 -0500
X-MC-Unique: BQYYrsljMOafplHSopCAJw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso221111b3a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 02:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705661197; x=1706265997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8/OPPo3D/rntMue2BfxleAM+xFOMvqwfwDIQ69i8qc=;
 b=WWhHdE7feZNjNIuv75UqmdGy9COC9Fi+2Fz18oh5z/YM+ZzEBBW/Wb0jpBr2nAm7yb
 K5DdtJ4pBhnomlwqCTSTrrdfzx0H8KRZTtXHCiRiQD9QKZgLjALGMNnjaBSfdi9/aF2e
 r8bo2r0EKrISmGbQscfXVNRT12sseZ/6Q4rTREIYSkolA04FNoYG50T5NYcXNLjRRqdP
 8lSCJUvCo0pRKxhkz3PGZO0+7Bpf4gEAYGIX5D0TXs3kRMb7xJ26HRfon5EPg6AZiZD8
 gR0N8Axx7wkByIa46a8Wus5LZyAC0Z08u7Fpu86Qzw5ecdcpV1OlLs+9srTUzkUmvYJy
 1nQQ==
X-Gm-Message-State: AOJu0YwEHcJh5Nm8f/GJJqSN9APQwOglbnQeqFFC7AHA7ggKr8VpgQQC
 LA1g0FkQqCeqsgkGsYx8Mms8PTBr3SNdiyOnKhxmnuVHxothqk3jT/8b+OI0I49I6ekx+m3Rql/
 72WRt63IbtHkma0yq3TmLAiEfZDmIqL2XecEMrGYejZAx25+tzF+I
X-Received: by 2002:a05:6a21:3418:b0:19a:999c:6653 with SMTP id
 yn24-20020a056a21341800b0019a999c6653mr2332841pzb.2.1705661197632; 
 Fri, 19 Jan 2024 02:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgUzUh8KywoeALML/Chjq7s66Lik34UG0o/H0usUjxQNTm1LB7ZWjE/XLb6LCx22yW2We4eA==
X-Received: by 2002:a05:6a21:3418:b0:19a:999c:6653 with SMTP id
 yn24-20020a056a21341800b0019a999c6653mr2332826pzb.2.1705661197328; 
 Fri, 19 Jan 2024 02:46:37 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902e9cd00b001d403f114d2sm2772417plk.303.2024.01.19.02.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 02:46:37 -0800 (PST)
Date: Fri, 19 Jan 2024 18:46:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of
 devices
Message-ID: <ZapTBEwAZOgX3jMa@x1n>
References: <20240117091559.144730-1-peterx@redhat.com>
 <2cad020f-73b4-48ac-87ab-6ed965fe4cf5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cad020f-73b4-48ac-87ab-6ed965fe4cf5@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 17, 2024 at 11:29:08AM +0100, Eric Auger wrote:
> Hi Peter,

Hi, Eric,

Thanks for the reviews!

> 
> On 1/17/24 10:15, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > There're issue reported that when syetem_reset the VM with an intel iommu
> system_reset
> > device and MT2892 PF(mlx5_core driver), the host kernel throws DMAR error.
> >
> >   https://issues.redhat.com/browse/RHEL-7188
> >
> > Alex quickly spot a possible issue on ordering of device resets.
> >
> > It's verified by our QE team then that it is indeed the root cause of the
> > problem.  Consider when vIOMMU is reset before a VFIO device in a system
> > reset: the device can be doing DMAs even if the vIOMMU is gone; in this
> > specific context it means the shadow mapping can already be completely
> > destroyed.  Host will see these DMAs as malicious and report.
> That's curious we did not get this earlier?

I sincerely don't know.  It could be that we just didn't test much on
system resets. Or, we could have overlooked the host dmesgs; after all the
error messages can be benign from functional pov.

> >
> > To fix it, we'll need to make sure all devices under the vIOMMU device
> > hierachy will be reset before the vIOMMU itself.  There's plenty of trick
> > inside, one can get those by reading the last patch.
> Not sure what you meant here ;-)

I meant "how to make sure all the vIOMMU managed devices will be reset
before the vIOMMU" is tricky on the implementation.  I didn't reference any
of those in the cover letter, because I think I stated mostly in patch 4, I
want to reference that patch for the details.  Since I think it's very
tricky, I left that major comment in the code to persist.

Thanks,

-- 
Peter Xu


