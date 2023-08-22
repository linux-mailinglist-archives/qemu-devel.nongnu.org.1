Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70E783BB2
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:25:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYMgv-00079W-1F; Tue, 22 Aug 2023 04:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYMgr-00079M-IR
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYMgm-0003Vm-V2
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692692675;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=G+UhjRSc4uGDnZt8D24zxuBh56uHAwZ4HjsOGQ/jcLg=;
 b=LBA7ZM/AtcErOxmS2xTOjfkiPXmnnOpczhCtg8s8mqJ1RY2UUBzPfEhEU721lVcosuB2UO
 I1NzGMxO1hHhoy4yIyIQ1m5rnDdidIsMwelGHv8+t69Oo/ViCNQUU2KWtHEGJ8g/U9aXGM
 rU+GdgTUXbnJ6MXH7D7XDZKG1KJYbqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-kqubxfVbPCa-bIBqxx9-4Q-1; Tue, 22 Aug 2023 04:24:32 -0400
X-MC-Unique: kqubxfVbPCa-bIBqxx9-4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5539101A528;
 Tue, 22 Aug 2023 08:24:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A0C640C6F4C;
 Tue, 22 Aug 2023 08:24:23 +0000 (UTC)
Date: Tue, 22 Aug 2023 09:24:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 41/58] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Message-ID: <ZORws2GWRwIGAaJE@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-42-xiaoyao.li@intel.com>
 <87wmxn6029.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmxn6029.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Tue, Aug 22, 2023 at 08:52:30AM +0200, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > For GetQuote, delegate a request to Quote Generation Service.  Add property
> > of address of quote generation server and On request, connect to the
> > server, read request buffer from shared guest memory, send the request
> > buffer to the server and store the response into shared guest memory and
> > notify TD guest by interrupt.
> >
> > "quote-generation-service" is a property to specify Quote Generation
> > Service(QGS) in qemu socket address format.  The examples of the supported
> > format are "vsock:2:1234", "unix:/run/qgs", "localhost:1234".
> >
> > command line example:
> >   qemu-system-x86_64 \
> >     -object 'tdx-guest,id=tdx0,quote-generation-service=localhost:1234' \
> >     -machine confidential-guest-support=tdx0
> >
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >  qapi/qom.json         |   5 +-
> >  target/i386/kvm/tdx.c | 380 ++++++++++++++++++++++++++++++++++++++++++
> >  target/i386/kvm/tdx.h |   7 +
> >  3 files changed, 391 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 87c1d440f331..37139949d761 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -879,13 +879,16 @@
> >  #
> >  # @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (default: 0)
> >  #
> > +# @quote-generation-service: socket address for Quote Generation Service(QGS)
> > +#
> >  # Since: 8.2
> >  ##
> >  { 'struct': 'TdxGuestProperties',
> >    'data': { '*sept-ve-disable': 'bool',
> >              '*mrconfigid': 'str',
> >              '*mrowner': 'str',
> > -            '*mrownerconfig': 'str' } }
> > +            '*mrownerconfig': 'str',
> > +            '*quote-generation-service': 'str' } }
> 
> Why not type SocketAddress?

Yes, the code uses SocketAddress internally when it eventually
calls qio_channel_socket_connect_async(), so we should directly
use SocketAddress in the QAPI from the start.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


