Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865167651B8
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 12:56:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOyR1-0005wl-NI; Thu, 27 Jul 2023 06:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOyQy-0005vz-GA
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOyQw-0001Gd-RR
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690454485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BgVEgkjy0v24sA29rrQPBpaIveXcGiH1BPynrvViBF0=;
 b=H4r8WNshbtfXgZ+impoLc/eO/8PEIO+R8xN52oJv6zIg14I/pHSZKlFwQ5hZpxScsha/RT
 hqiFKeIWJwE9rypWIy9wpxkUmWd1skBRBbA6Hx/QfKnQqUlQsWS6WM0IF6Tyx0Y1hiGm03
 yMQyjp9+Pu4nZkaktHAhNIcwTRUx/i8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-WpodngWyNbKhEN4i_AZbWA-1; Thu, 27 Jul 2023 06:41:24 -0400
X-MC-Unique: WpodngWyNbKhEN4i_AZbWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CCB5104458D;
 Thu, 27 Jul 2023 10:41:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6759C2C7D3;
 Thu, 27 Jul 2023 10:41:21 +0000 (UTC)
Date: Thu, 27 Jul 2023 11:41:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/6] python/machine: use socketpair() for console
 connections
Message-ID: <ZMJJzkTaZaQ0z0Rj@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-5-jsnow@redhat.com>
 <B867C4E8-24FC-4C4E-9FE8-2353CC21320C@redhat.com>
 <CAFn=p-bdA5cVMmsUkE0os0CVT6XMXzWk2M3UcKb0DFQmi130Mg@mail.gmail.com>
 <4EE2965D-F72B-4002-99BF-732F5F9734C6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4EE2965D-F72B-4002-99BF-732F5F9734C6@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jul 27, 2023 at 11:22:35AM +0530, Ani Sinha wrote:
> 
> 
> > On 26-Jul-2023, at 10:51 PM, John Snow <jsnow@redhat.com> wrote:
> > 
> > 
> > 
> > On Wed, Jul 26, 2023, 6:50 AM Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > 
> > > On 25-Jul-2023, at 11:33 PM, John Snow <jsnow@redhat.com> wrote:
> > > 
> > > Create a socketpair for the console output. This should help eliminate
> > > race conditions around console text early in the boot process that might
> > > otherwise have been dropped on the floor before being able to connect to
> > > QEMU under "server,nowait".
> > > 
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > 
> > Thanks for doing this. I recall we spoke about this late last year in the context of fixing my bios-bits avocado test and adding a console output there.
> > 
> > Yep! I think you need a few more changes to do what you wanted. IIRC, you also want to be able to drain the console log while waiting for the vm to terminate of its own accord, which I don't support yet.
> > 
> > (If you use console socket's self draining mode, it should be possible to forego the early termination of the console socket and allow this behavior. Maybe I can work that in now...)
> 
> yeah we want to collect all the console logs while the VM is running until it self terminates. Maybe you can add a flag for this behavior to not early terminate the socket. I think we need to add mathods to keep reading the socket and write to a file until the socket is closed. Maybe QemuMachine needs to be enhanced.


There's no special code required for that - any -chardev backend can
have logfile=/some/path added to it.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


