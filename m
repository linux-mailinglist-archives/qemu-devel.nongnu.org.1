Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1836A3266A
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Feb 2025 13:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCKI-0002eb-9D; Wed, 12 Feb 2025 07:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCJy-0002c0-JJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCJv-0006UQ-Az
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739365104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUSx50ycLHi94kdxdugsrQhEqUmHwFxJb0xLeHxaAr8=;
 b=IGQDaG+s/kes0EXFpta9hKPpbOVUc91u/uAxd4mh9lO6nHZJOuz7w1lErwiN7dNWqxJTCw
 Q9xCHtRoXgepxzVwlNL/rWsRvI41EKLaLCy9U0GJ85rpb1B6mNqlYFvpbWNdp6i/o3s8bc
 QBQB8pVRgSlt42wuX03XNQ1rwNjCL8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-niXr-UuBPQWY5At2nupukw-1; Wed,
 12 Feb 2025 07:58:23 -0500
X-MC-Unique: niXr-UuBPQWY5At2nupukw-1
X-Mimecast-MFC-AGG-ID: niXr-UuBPQWY5At2nupukw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2558B19560B0; Wed, 12 Feb 2025 12:58:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A289218004A7; Wed, 12 Feb 2025 12:58:18 +0000 (UTC)
Date: Wed, 12 Feb 2025 13:58:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/11] bochs-rs: Add bochs block driver reimplementation
 in Rust
Message-ID: <Z6ya5xoHMFNBAeU5@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-11-kwolf@redhat.com>
 <Z6xmkfyb37YDBz1o@redhat.com> <Z6xsuCCRQWpFntxx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6xsuCCRQWpFntxx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.02.2025 um 10:41 hat Daniel P. Berrang� geschrieben:
> On Wed, Feb 12, 2025 at 09:14:57AM +0000, Daniel P. Berrang� wrote:
> > On Tue, Feb 11, 2025 at 10:43:27PM +0100, Kevin Wolf wrote:
> > > This adds a separate block driver for the bochs image format called
> > > 'bochs-rs' so that for the moment both the C implementation and the Rust
> > > implementation can be present in the same build. The intention is to
> > > remove the C implementation eventually and rename this one into 'bochs'.
> > > This can only happen once Rust can be a hard build dependency for QEMU.
> > > 
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  rust/block/Cargo.toml    |   2 +-
> > >  rust/block/src/bochs.rs  | 296 +++++++++++++++++++++++++++++++++++++++
> > >  rust/block/src/driver.rs |   5 -
> > >  rust/block/src/lib.rs    |   1 +
> > >  4 files changed, 298 insertions(+), 6 deletions(-)
> > >  create mode 100644 rust/block/src/bochs.rs
> > > 
> > > diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
> > > index 70ee02f429..1c06f3a00c 100644
> > > --- a/rust/block/Cargo.toml
> > > +++ b/rust/block/Cargo.toml
> > > @@ -3,7 +3,7 @@ name = "block"
> > >  version = "0.1.0"
> > >  edition = "2021"
> > >  authors = ["Kevin Wolf <kwolf@redhat.com>"]
> > > -license = "GPL-2.0-or-later"
> > > +license = "GPL-2.0-or-later AND MIT"
> > >  readme = "README.md"
> > >  description = "Block backends for QEMU"
> > >  repository = "https://gitlab.com/qemu-project/qemu/"
> > > diff --git a/rust/block/src/bochs.rs b/rust/block/src/bochs.rs
> > > new file mode 100644
> > > index 0000000000..388ac5ef03
> > > --- /dev/null
> > > +++ b/rust/block/src/bochs.rs
> > > @@ -0,0 +1,296 @@
> > > +// SPDX-License-Identifier: MIT
> > 
> > Why MIT instead of our normal GPL-2.0-or-later.
> > 
> > Using Rust conversion to eliminate GPL usage for permissive licenses
> > like MIT is not something I'd like to see us doing.
> 
> My bad. I should have noticed that the original bochs.c was also MIT,
> so I presume you're considering this Rust impl to be a derived work.

Yes, this is essentially a translation of the existing C bochs driver,
which is also why I kept the original copyright notice and the full
license text.

Kevin


