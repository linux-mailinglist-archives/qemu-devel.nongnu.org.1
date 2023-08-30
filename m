Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B878D3BB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:49:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFw6-0000yp-NA; Wed, 30 Aug 2023 03:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbFw4-0000xz-P3
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbFw2-0004Dy-1D
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693381696;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OfCyRIQgh7H7wL/M4F+avKR6APj87bZXhcAT8LxgUI=;
 b=HzhL1jbNn1HtqXAjqqX/vNw4Z+kS9765NCJNR1Imafy3JCZa2QwcRTAUNLG5gq7OJWvZ7p
 gvsIgUTw/ZZquTf0iV+iD20eqTY6kdx8ffa3LiN096jy85bnStjOw3bxCnKL+BrwhkNn3J
 uGuxTPJXdxNgttMGYnIOvfteQXn+7pY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-4Z6p0HkgMhuX25KfugmTZQ-1; Wed, 30 Aug 2023 03:48:13 -0400
X-MC-Unique: 4Z6p0HkgMhuX25KfugmTZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5B153C0D858;
 Wed, 30 Aug 2023 07:48:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F01E01121315;
 Wed, 30 Aug 2023 07:48:09 +0000 (UTC)
Date: Wed, 30 Aug 2023 08:48:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com
Subject: Re: [PATCH v2 41/58] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Message-ID: <ZO70NwADsSRSe/WD@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-42-xiaoyao.li@intel.com>
 <87wmxn6029.fsf@pond.sub.org> <ZORws2GWRwIGAaJE@redhat.com>
 <d6fbacab-d7e4-9992-438d-a8cb58e179ae@intel.com>
 <ZO3HjRp1pk5Qd51j@redhat.com>
 <c74e7e2e-a986-240c-6300-0d3fbc22dfc4@intel.com>
 <11130e51-72fe-a07a-767b-f768611cf0d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11130e51-72fe-a07a-767b-f768611cf0d9@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Wed, Aug 30, 2023 at 01:57:59PM +0800, Xiaoyao Li wrote:
> On 8/30/2023 1:18 PM, Chenyi Qiang wrote:
> > 
> > 
> > On 8/29/2023 6:25 PM, Daniel P. Berrangé wrote:
> > > On Tue, Aug 29, 2023 at 01:31:37PM +0800, Chenyi Qiang wrote:
> > > > 
> > > > 
> > > > On 8/22/2023 4:24 PM, Daniel P. Berrangé wrote:
> > > > > On Tue, Aug 22, 2023 at 08:52:30AM +0200, Markus Armbruster wrote:
> > > > > > Xiaoyao Li <xiaoyao.li@intel.com> writes:
> > > > > > 
> > > > > > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > > > > 
> > > > > > > For GetQuote, delegate a request to Quote Generation Service.  Add property
> > > > > > > of address of quote generation server and On request, connect to the
> > > > > > > server, read request buffer from shared guest memory, send the request
> > > > > > > buffer to the server and store the response into shared guest memory and
> > > > > > > notify TD guest by interrupt.
> > > > > > > 
> > > > > > > "quote-generation-service" is a property to specify Quote Generation
> > > > > > > Service(QGS) in qemu socket address format.  The examples of the supported
> > > > > > > format are "vsock:2:1234", "unix:/run/qgs", "localhost:1234".
> > > > > > > 
> > > > > > > command line example:
> > > > > > >    qemu-system-x86_64 \
> > > > > > >      -object 'tdx-guest,id=tdx0,quote-generation-service=localhost:1234' \
> > > > > > >      -machine confidential-guest-support=tdx0
> > > > > > > 
> > > > > > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > > > ---
> > > > > > >   qapi/qom.json         |   5 +-
> > > > > > >   target/i386/kvm/tdx.c | 380 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > >   target/i386/kvm/tdx.h |   7 +
> > > > > > >   3 files changed, 391 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > index 87c1d440f331..37139949d761 100644
> > > > > > > --- a/qapi/qom.json
> > > > > > > +++ b/qapi/qom.json
> > > > > > > @@ -879,13 +879,16 @@
> > > > > > >   #
> > > > > > >   # @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (default: 0)
> > > > > > >   #
> > > > > > > +# @quote-generation-service: socket address for Quote Generation Service(QGS)
> > > > > > > +#
> > > > > > >   # Since: 8.2
> > > > > > >   ##
> > > > > > >   { 'struct': 'TdxGuestProperties',
> > > > > > >     'data': { '*sept-ve-disable': 'bool',
> > > > > > >               '*mrconfigid': 'str',
> > > > > > >               '*mrowner': 'str',
> > > > > > > -            '*mrownerconfig': 'str' } }
> > > > > > > +            '*mrownerconfig': 'str',
> > > > > > > +            '*quote-generation-service': 'str' } }
> > > > > > 
> > > > > > Why not type SocketAddress?
> > > > > 
> > > > > Yes, the code uses SocketAddress internally when it eventually
> > > > > calls qio_channel_socket_connect_async(), so we should directly
> > > > > use SocketAddress in the QAPI from the start.
> > > > 
> > > > Any benefit to directly use SocketAddress?
> > > 
> > > We don't want whatever code consumes the configuration to
> > > do a second level of parsing to convert the 'str' value
> > > into the 'SocketAddress' object it actually needs.
> > > 
> > > QEMU has a long history of having a second round of ad-hoc
> > > parsing of configuration and we've found it to be a serious
> > > maintenence burden. Thus we strive to have everything
> > > represented in QAPI using the desired final type, and avoid
> > > the second round of parsing.
> > 
> > Thanks for your explanation.
> > 
> > > 
> > > > "quote-generation-service" here is optional, it seems not trivial to add
> > > > and parse the SocketAddress type in QEMU command. After I change 'str'
> > > > to 'SocketAddress' and specify the command like "-object
> > > > tdx-guest,type=vsock,cid=2,port=1234...", it will report "invalid
> > > > parameter cid".
> > > 
> > > The -object parameter supports JSON syntax for this reason
> > > 
> > >     -object '{"qom-type":"tdx-guest","quote-generation-service":{"type": "vsock", "cid":"2","port":"1234"}}'
> > > 
> > > libvirt will always use the JSON syntax for -object with a new enough
> > > QEMU.
> > 
> > The JSON syntax works for me. Then, we need to add some doc about using
> > JSON syntax when quote-generation-service is required.
> 
> This limitation doesn't look reasonable to me.
> 
> @Daniel,
> 
> Is it acceptable by QEMU community?

This is the expected approach for object types which have non-scalar
properties.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


