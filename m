Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CAF98A101
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Sep 2024 13:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEo9-0004xq-TL; Mon, 30 Sep 2024 07:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svEo7-0004wh-N3
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svEo3-00060B-El
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727696589;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xHh4dwWXRf+Pn922j98k8YCPneKfx0gxYcxu9Z/ECrk=;
 b=hvaxjUEIby6fQ2Rq0FxqZIwY0mFVAX6CrBVc56FuKk4PMNCqwNw5ZJwZqm3TqPquXtSl/E
 mjfdIo/weHYOA1FQUfO1D8CvmGGWtJg5WhFEObnzURhdLiqvRR8u1777kpOepaXerIGJk6
 IJOoeNMIFoDANsgdWVohGOynk/LUkDA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-siWnj3TLOSiQYjqb6TSKaA-1; Mon,
 30 Sep 2024 07:43:07 -0400
X-MC-Unique: siWnj3TLOSiQYjqb6TSKaA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 065D61944DF3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 11:43:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F4A73003E4D; Mon, 30 Sep 2024 11:43:05 +0000 (UTC)
Date: Mon, 30 Sep 2024 12:43:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: Convert an error_report to tracepoint
Message-ID: <ZvqOxVzk_N24SYa9@redhat.com>
References: <D4JL6KP1Z58Q.1P5U7QZQU7AKP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D4JL6KP1Z58Q.1P5U7QZQU7AKP@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 01:36:21PM +0200, Anthony Harivel wrote:
> Hello, 
> 
> There is an error_report() in target/i386/kvm/vmsr_energy.c that would 
> benefit for being a tracepoint because this is not actually an "error" 
> as per se, but more a notification that could be used for debugging, and 
> it is quite verbose.
> 
> Could someone give me some pointer on how I could manage that so I can 
> send a patch to rectify this ?

Modify the file target/i386/kvm/trace-events   to define your desired
tracepoint(s).

Then #include "trace-event.h"  in your vmsr_energy.c  file

Call your probepoint using  trace_{probe name}(...args...)

See docs/devel/tracing.rst for general info on tracing

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


