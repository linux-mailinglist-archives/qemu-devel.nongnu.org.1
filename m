Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BCB1BB97
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Aug 2025 23:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujOoA-0006lz-At; Tue, 05 Aug 2025 17:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujOnt-0006bi-Ds
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 17:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujOnq-0001qL-J8
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 17:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754427751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WJP5QkDu9edgsrDQhpFr0HgqFFVrrD1jglcJtgwUw+0=;
 b=C5r/1RdeB0WUAcLftxQe2/Srtfkw4yAVXSKe9dfAUQvclTLxyFqOwyfBaFAu5vRozAqG1Y
 +k91rimz6FF4xaFiQQ3g5HBQhSvAbu/b36MxXI/lLC4C/biSCexcKW+0HZ0awoBf7I3BT+
 EjlN0CEHZFRzvfFxr5dnz/Z2bEgGf2g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-bW7D-AWdNM-M6vd6bDHctA-1; Tue,
 05 Aug 2025 17:02:28 -0400
X-MC-Unique: bW7D-AWdNM-M6vd6bDHctA-1
X-Mimecast-MFC-AGG-ID: bW7D-AWdNM-M6vd6bDHctA_1754427747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C953D1955F44; Tue,  5 Aug 2025 21:02:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 865E01955E88; Tue,  5 Aug 2025 21:02:24 +0000 (UTC)
Date: Tue, 5 Aug 2025 22:02:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 0/2] tracetool: remove no_check_foo() and if(true){..}
 blocks
Message-ID: <aJJxXFbmveFgb4Wk@redhat.com>
References: <20250804112039.16377-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804112039.16377-1-tanishdesai37@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 04, 2025 at 11:20:37AM +0000, Tanish Desai wrote:
> This patch series eliminates unnecessary
> if (true) { no_check_foo(...) } blocks and
> integrates the no_check_foo(...) logic directly
> into trace_foo(...). This results in cleaner,
> more maintainable code generation.
> 
> A new backend attribute, TRACE_EVENT_GET_STATE,
> is introduced. When enabled, it automatically
> generates conditional block :
> if (trace_event_get_state(...)) { ... }. The
> generate() function emits code within this
> conditional structure for that backend.
> 
> Previously, without TRACE_EVENT_GET_STATE,
> each backend was required to manually implement
> out("if (trace_event_get_state(...)) {") in its
> generate() function, leading to code duplication.

FWIW, I rebased your patches on top of this series
just posted, which is how I found the two bugs
pointed out against the patches

  https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00942.html


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


