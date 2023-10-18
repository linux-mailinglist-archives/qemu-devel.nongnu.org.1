Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95D7CDB27
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5D8-0005ot-BQ; Wed, 18 Oct 2023 07:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5D5-0005oU-AI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5D2-0002ID-SR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697630371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U86Q0wbCirWCMmrBtXLEuBQp2RI0tPhVEuTLaBzMBZc=;
 b=QWSbdE4SfyDsPvQhUtG1U7tjdd2K8PONlEi7yuPynxwuPjX8L2Ufbalq0gTyig6Jnfe+2w
 mlmwbuc9P9XmEPe311JYqlZ+d8tb7z+br8Ta7OK46TC7FFRQD38FOs8lAmt87+1gp5NWfV
 jMT34b8ggNkQZqgJH4thtZYcwYZ84sA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-JPRj3o7DPc27jB0UT-3Xug-1; Wed, 18 Oct 2023 07:59:29 -0400
X-MC-Unique: JPRj3o7DPc27jB0UT-3Xug-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53db1fbd6b1so5315783a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697630368; x=1698235168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U86Q0wbCirWCMmrBtXLEuBQp2RI0tPhVEuTLaBzMBZc=;
 b=w1C8BbtCkjYSaufZdTZLM2qRFN7zOHwI9SzucCpaPM8dnfDJHfm3Zkep+kbidFaYZs
 vnwUxiINuUn+FDIkC5Fcy7JSN3paBmKCePtK9AeUXgRLIfAQYc5Rd5OMEeYu8FJgLshH
 XxX19mn1gV93kdH+sQIBTn5YdzaB7FKneEOZONqvd9IYRFCE+h9wMEWiotNuYdad42IP
 fyQ/oEMzAyX9eHDGw91A/khjhc4EhyrvTnxYO0tOrAANJ+fCDilfBgDkG+JxfQ56uxl5
 ZsuOmOoFZK/vdymtFy5kgeC4aZmxWfIh51sJF6gcxqjGf0Z8TPkZxsXuLE+AMg0ThgXC
 zWXw==
X-Gm-Message-State: AOJu0YwoPVWKWniDX1N+A44E4irH6FKE2knneewq98PZHrYXlJWZUVDa
 I9/FhPHFFVfTYpBIT1y3xvFTInPoChe20NEhiWdL2BPTAzg1ENfu5i/PZZEtdYcZ00yC4/FFnzg
 Ayi1cMK1hEhaVmp4=
X-Received: by 2002:a05:6402:4315:b0:53d:fbf6:72c with SMTP id
 m21-20020a056402431500b0053dfbf6072cmr4618795edc.1.1697630368687; 
 Wed, 18 Oct 2023 04:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAD7j/dRrcO3Xi+c2V+hhMejg9ykWDtQFqbF5qgZS+AJppP2CsrpSUlS61KUx9CA4CmB+3KA==
X-Received: by 2002:a05:6402:4315:b0:53d:fbf6:72c with SMTP id
 m21-20020a056402431500b0053dfbf6072cmr4618581edc.1.1697630363320; 
 Wed, 18 Oct 2023 04:59:23 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 cy23-20020a0564021c9700b00522828d438csm2674984edb.7.2023.10.18.04.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:59:22 -0700 (PDT)
Date: Wed, 18 Oct 2023 07:59:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231018075819-mutt-send-email-mst@kernel.org>
References: <20231002203221.17241-1-lersek@redhat.com>
 <72e1adac-fe95-5650-536b-b70faab7b6d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e1adac-fe95-5650-536b-b70faab7b6d6@redhat.com>
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

On Wed, Oct 18, 2023 at 01:26:30PM +0200, Laszlo Ersek wrote:
> Hi Michael,
> 
> still waiting for you to pick this up, please.
> 
> In
> <http://mid.mail-archive.com/20231004122927-mutt-send-email-mst@kernel.org>,
> you wrote:
> 
> > OK. I'll need to do another PR soonish since a bunch of patchsets
> > which I wanted in this PR had issues and I had to drop them.
> > v3 will be there.
> 
> (Alt. link:
> <https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01164.html>.)
> 
> That was on 04 Oct 2023 -- exactly two weeks ago :(

It's been a bit wild here, sorry about the delay.
I think I'm set for now and I'm testing it.

> Stefan, can you perhaps apply this v3 series directly from the list?
> 
> Thanks,
> Laszlo
> 
> On 10/2/23 22:32, Laszlo Ersek wrote:
> > v2:
> > 
> > - http://mid.mail-archive.com/20230830134055.106812-1-lersek@redhat.com
> > - https://patchwork.ozlabs.org/project/qemu-devel/cover/20230830134055.106812-1-lersek@redhat.com/
> > 
> > v3 picks up tags from Phil, Eugenio and Albert, and updates the commit
> > message on patch#7 according to Eugenio's comments.
> > 
> > Retested.
> > 
> > Laszlo Ersek (7):
> >   vhost-user: strip superfluous whitespace
> >   vhost-user: tighten "reply_supported" scope in "set_vring_addr"
> >   vhost-user: factor out "vhost_user_write_sync"
> >   vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
> >   vhost-user: hoist "write_sync", "get_features", "get_u64"
> >   vhost-user: allow "vhost_set_vring" to wait for a reply
> >   vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
> > 
> >  hw/virtio/vhost-user.c | 216 ++++++++++----------
> >  1 file changed, 108 insertions(+), 108 deletions(-)
> > 
> > 
> > base-commit: 36e9aab3c569d4c9ad780473596e18479838d1aa


