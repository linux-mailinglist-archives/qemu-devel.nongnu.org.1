Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42784765203
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOyWo-0006Xo-HW; Thu, 27 Jul 2023 06:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOyWl-0006Xf-Ps
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOyWk-0003j0-5h
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690454845;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gUh1dJfVuP+Tgn4Sa9PFuuQFXkAxBHH/fihyQQ25SAs=;
 b=Cmr9Riwv1xL3U1aSJeVV+1xa1UlX/CMH3vxmlBBkHod0msN1g/559P4dEYx/rWwfEhU4sF
 lTGGPsNvpd1qXFZcUAksAsqZcD3JP3MIpTwOR0dcn4zGFBqAhhGMS4+bt2VHfjmbw8e9bp
 ejzLx2kNdkOjFfsmbDPtVhAvNfeS+gc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-ZBpIjJzaM6iJlYuV1t_Rcg-1; Thu, 27 Jul 2023 06:47:23 -0400
X-MC-Unique: ZBpIjJzaM6iJlYuV1t_Rcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ABB8185A792
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 10:47:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0115CC2C7D3;
 Thu, 27 Jul 2023 10:47:22 +0000 (UTC)
Date: Thu, 27 Jul 2023 11:47:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Implementing "tee" in python asyncio
Message-ID: <ZMJLOJYueAWYA1mN@redhat.com>
References: <CAFn=p-aKWG7r2zRdQ-O6kod_jVOTMELGi_ObbKBAM=9ZgXt7Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFn=p-aKWG7r2zRdQ-O6kod_jVOTMELGi_ObbKBAM=9ZgXt7Ww@mail.gmail.com>
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

On Wed, Jul 26, 2023 at 04:25:34PM -0400, John Snow wrote:
> Hi folks,
> 
> I'm currently wondering how to take a StreamReader as found on
> https://docs.python.org/3/library/asyncio-subprocess.html#asyncio.subprocess.Process
> and to consume the data while optionally re-streaming it to a
> secondary consumer.
> 
> What I'd like to do is create a StreamWatcher class that consumes
> console data while optionally logging to python logging and/or a file;
> but re-buffers the data into an async stream where an additional
> consumer is free to use the "standard asyncio API" to consume console
> data at their leisure in a way that's unsurprising.
> 
> What I'd like this *for* is to be able to do aggressive logging of
> stdout/stderr and console data without denying tests the ability to
> consume the data as they see fit for their testing purposes. I want to
> have my cake and eat it too, and we don't do a good job of managing
> this consistently across the board.
> 
> I am wondering if there's any way around creating a literal socketpair
> and suffering the creation of a full four StreamReader/StreamWriter
> instances (one pair per socket...) and then just hanging on to the
> "unused" reader/writer per each. It seems kind of foolishly excessive.
> It also seems like it might be a pain in the butt if I want
> cross-platform compatibility with windows for the machine appliance.
> 
> Anyone got any bright ideas?

Don't bother with any of the above, just add 'logfile=/path/to/log'
to the -chardev argument.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


