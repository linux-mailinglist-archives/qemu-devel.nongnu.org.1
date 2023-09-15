Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD227A1DF4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7XF-0001oT-FY; Fri, 15 Sep 2023 08:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qh7Wx-0001nT-B3
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qh7Wv-0006uT-H3
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694779356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5ddIrqavdfmTLZ3xvfQjaukZtshD8d8bNOIyeMGt5wc=;
 b=TeD03l3CqO3PuGRSzmNJf1UG6OL6Gu2KOxD9ODg0bbCgDa7eLvQqy9IIFFJ1lBmnvyZLNw
 5y6Ew00aJpdZSkYRj3bIjCo9UfZTY9cBYHWHZ2S25xk7qUmXRxrYQg2/L6il9fko0ScLB7
 wR9A7Azb5jJbPoDscYLTN77ug7FTvvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-SB0Iw_DAP16wVXNBSftwUQ-1; Fri, 15 Sep 2023 08:02:35 -0400
X-MC-Unique: SB0Iw_DAP16wVXNBSftwUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B90C6185A797;
 Fri, 15 Sep 2023 12:02:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D716B176C3;
 Fri, 15 Sep 2023 12:02:33 +0000 (UTC)
Date: Fri, 15 Sep 2023 13:02:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Tyler Fanelli <tfanelli@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
Message-ID: <ZQRH125LBK5ktpLY@redhat.com>
References: <20230914175835.382972-1-tfanelli@redhat.com>
 <ZQQplEOUE2GhBL07@redhat.com>
 <CAJSP0QUA--fpGAjj9JJ2BW7VSunw6mb7=8NDmTt7+k71OOAd1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QUA--fpGAjj9JJ2BW7VSunw6mb7=8NDmTt7+k71OOAd1g@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 15, 2023 at 07:33:32AM -0400, Stefan Hajnoczi wrote:
> The library approach worked well for libblkio but the overhead of
> creating a separate shared library and shipping it is significant.
> When QEMU is the only user of some code, then it should definitely be
> part of QEMU. Also, when QEMU needs early access to code that isn't
> widely available yet, then bundling it inside QEMU until packages are
> available also seems reasonable to me (I think we already do that for
> libvfio-user and maybe other libraries).

Yep, avoiding the public shared library significantly cuts down the
maint burden, as you can freely adapt the exposed C  FFI API to
suit QEMU's needs and not worry about ABI compatibility.

> I would prefer it if we minimize Rust wrappers for C APIs and instead
> focus on using Rust to build new subsystems. Writing and maintaing two
> sets of the same API is expensive and I hope we don't get bogged down
> keeping C and Rust APIs in sync. That said, I think there's an
> argument for wrapping core QEMU APIs needed for device emulation (e.g.
> DeviceState, PCIDevice) because of the security benefits of writing
> new device emulation code in Rust.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


