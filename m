Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9AD7A67A8
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:10:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qicMU-0001y1-QZ; Tue, 19 Sep 2023 11:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qicMI-0001xV-QP
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qicMH-0000uQ-6v
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695136187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XiI0oVoC86MXyPnF06YjpOTR5Sr70SSf6CwkFNC0JJE=;
 b=MmAwQBvuXXFydVkQ9tNdfJfQUaBoRYmMU9ri5/olYtiay0RL5BLtKm4+W765oYm5akhhxb
 C+N64vFGNjYKDTgPy/AB9oVCaZ7GD2PhQ/WtqprUygfXBsdeRBahbijLhJxelHFgwCPBla
 SiBoBlKArOyj80Y19WAXLeCSAvN46uk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-JoIHY2hcNW2qEQehl5fqgw-1; Tue, 19 Sep 2023 11:09:45 -0400
X-MC-Unique: JoIHY2hcNW2qEQehl5fqgw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65825f6d790so2920836d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 08:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136185; x=1695740985;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XiI0oVoC86MXyPnF06YjpOTR5Sr70SSf6CwkFNC0JJE=;
 b=iBSUnR14pWHBnICvibzUzgVIaGmsv/f1ZGDi9OseZbB17ifsXYvyR21EC2N3YtLml9
 8EuaHYPD/xHsR/OdznY0hIsTg3xkjNRV0TmF5Eh4DiDiSyIc7KRawYf98lcUF2wHfzbL
 9Otg6idbd60ynilMhcAymxBgoHFtRT/FUkbSEnMAvhpK8xpaaPLddos9Q5to6Qw381e/
 T7ACI5nHn7zOn1e+AjCnu26BIMONVRLHOgtQTkfRXhOBcig0qXNmlf9hvc5Fwjp52TpV
 rtFJ+K+sSS4WBlT1fkeA2sCV02Mq1XcvPS9gIzaZDyWvN8RN7yi7OrM8JgtBY9lzQgit
 YqUg==
X-Gm-Message-State: AOJu0YzBaSH1VPQ0RMitRVzVxB3JDN21HbtulRkf3jzkxwqM5DevcaFN
 UPociXfwxkaEINH8qw9L+pMJnIC8nS/Qb14KBdvY6tHHkgYiQHCJ8AqeSbpWgJVjm6KggjB5Xpe
 T5LfPuNxUzjmlP/E=
X-Received: by 2002:ad4:5aa2:0:b0:653:576d:1e8 with SMTP id
 u2-20020ad45aa2000000b00653576d01e8mr14798610qvg.1.1695136185386; 
 Tue, 19 Sep 2023 08:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO5y8JuYYyXz1MHnM/kXFuIPQHv6WxpumvytYHqskT275F4xzskq5wyef6ZLEERkCc9lUH8A==
X-Received: by 2002:ad4:5aa2:0:b0:653:576d:1e8 with SMTP id
 u2-20020ad45aa2000000b00653576d01e8mr14798598qvg.1.1695136185008; 
 Tue, 19 Sep 2023 08:09:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v27-20020a05620a123b00b00767cd764ecfsm4036028qkj.33.2023.09.19.08.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:09:44 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:09:37 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: Re: [PATCH v2 0/5] virtio-gpu: add blob migration support
Message-ID: <ZQm5sWdhN8S7s95x@x1n>
References: <20230907130936.767722-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLUM+XRZppN2P6Z_c107HEKOGNE3r_ivfMqcOz2oOO6ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLUM+XRZppN2P6Z_c107HEKOGNE3r_ivfMqcOz2oOO6ag@mail.gmail.com>
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

On Tue, Sep 19, 2023 at 04:51:21PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Sep 7, 2023 at 5:15 PM <marcandre.lureau@redhat.com> wrote:
> >
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > This is a follow-up of the previous patch "[PATCH] virtio-gpu: block migration
> > of VMs with blob=true". Now that migration support is implemented, we can decide
> > to drop the migration blocker patch, or apply and revert it, so that
> > backporting of a quick fix is made easier.
> >
> > Fixes:
> > https://bugzilla.redhat.com/show_bug.cgi?id=2236353
> >
> > Marc-André Lureau (5):
> >   virtio-gpu: block migration of VMs with blob=true
> >   virtio-gpu: factor out restore mapping
> >   virtio-gpu: move scanout restoration to post_load
> >   virtio-gpu: add virtio-gpu/blob vmstate subsection
> >   Revert "virtio-gpu: block migration of VMs with blob=true"
> >
> >  hw/display/virtio-gpu.c | 174 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 146 insertions(+), 28 deletions(-)

For migration:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


