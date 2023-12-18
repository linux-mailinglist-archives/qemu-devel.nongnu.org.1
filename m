Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFB0817089
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:34:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDk7-0007xx-Hp; Mon, 18 Dec 2023 08:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFDk4-0007wP-Dr
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFDk1-0005zJ-Mf
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702906384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdBjhxm20q097ne8uyB6z/9NIeReXtqMEoKIM4W9iN0=;
 b=PdS0Dkuax9JUOGTFd6AWH1i/6Q/nl2W11On/1Q5yjJ9dBZYwE23vUJIpNKza0ceXmj1UR7
 yEwXQUmAASxDnthYkHNyep5/USMRoauSjtAVqD6EgpVzi4GortZQBWNewpvYt3BzRkOOxI
 YJcoqXO3KIfc8TW2X3fQt7P77jWfSyI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-daUFY-3GPUirYYL8j-Q4Bg-1; Mon,
 18 Dec 2023 08:33:01 -0500
X-MC-Unique: daUFY-3GPUirYYL8j-Q4Bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CACF329AC030;
 Mon, 18 Dec 2023 13:33:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C4273C25;
 Mon, 18 Dec 2023 13:32:59 +0000 (UTC)
Date: Mon, 18 Dec 2023 13:32:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, yan@daynix.com
Subject: Re: [PATCH v7 4/5] qmp: Added new command to retrieve eBPF blob.
Message-ID: <ZYBKCUXlfRerzZmi@redhat.com>
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-5-andrew@daynix.com>
 <874jgfu0wj.fsf@pond.sub.org>
 <CAOEp5Oc+6T7yiH2qdO=ZPyDn+d4gO+4KZXmxcRU7DoO3BabPPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOEp5Oc+6T7yiH2qdO=ZPyDn+d4gO+4KZXmxcRU7DoO3BabPPA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 18, 2023 at 03:24:57PM +0200, Yuri Benditovich wrote:
> On Mon, Dec 18, 2023 at 2:54 PM Markus Armbruster <armbru@redhat.com> wrote:
> > > +#
> > > +# Currently, there is a possible eBPF for receive-side scaling (RSS).
> > > +#
> > > +##
> > > +
> > > +##
> > > +# @EbpfObject:
> > > +#
> > > +# An eBPF ELF object.
> > > +#
> > > +# @object: the eBPF object encoded in base64
> > > +#
> > > +# Since: 8.2
> >
> > Won't make 8.2, so bump to 9.0.  More of the same below, not noting it
> > again.
> >
> 
> Will there be 8.3?

No, there is never a N.3.0

QEMU does three releases per year, and the major version
increments for the first release of the year. So the
pattern is always

  N.0.0, N.1.0, N.2.0

where "N" changes each year.  The last digit is reserved
for stable branch releases.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


