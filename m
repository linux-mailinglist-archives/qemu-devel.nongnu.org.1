Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B17E76B81D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 16:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqov-0004c7-7T; Tue, 01 Aug 2023 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQqot-0004bs-Df
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQqor-0001jH-KH
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690901872;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=56ag8D23N3D5V0yxKxxXalTgQPrSfiJDhLX6VgqQOGE=;
 b=UdcNf6PtJ8gRp2pg7h/OKRLvBVCSAEelv+g2ZdyU+9zolTPAYYN/g1lveuqOD3vfQk0+Es
 v98LMDFaPxgA/Bnvanh2asVP/vJ+BhF7URI2r9VS/QmldH0bey+SKuSHW+twk2j6+QPhQl
 wl7VaDjzQozPEqvBbF2nFkDDQmomI+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-RoTO5reeNJaZMOmI1rknFQ-1; Tue, 01 Aug 2023 10:57:48 -0400
X-MC-Unique: RoTO5reeNJaZMOmI1rknFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D87FA881B26;
 Tue,  1 Aug 2023 14:57:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CDB540C2063;
 Tue,  1 Aug 2023 14:57:44 +0000 (UTC)
Date: Tue, 1 Aug 2023 15:57:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
Message-ID: <ZMkdZkQipZUIUicN@redhat.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-9-xiaoyao.li@intel.com>
 <87o7js808y.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7js808y.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Mon, Jul 31, 2023 at 07:22:05PM +0200, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 7f92ea43e8e1..e0b2044e3d20 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -605,6 +605,9 @@
> >  # @reserve: if true, reserve swap space (or huge pages) if applicable
> >  #     (default: true) (since 6.1)
> >  #
> > +# @private: if true, use KVM gmem private memory
> > +#           (default: false) (since 8.1)
> > +#
> 
> Please format like
> 
>    # @private: if true, use KVM gmem private memory (default: false)
>    #     (since 8.1)

Also QEMU 8.1.0 is in freeze right now, so there's no chance
of these patches making 8.1.0. IOW, use "since 8.2" as the
next release you might achieve merge for.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


