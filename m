Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF77E9DA6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:47:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2XHr-00080A-9N; Mon, 13 Nov 2023 08:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2XHa-0007yK-Gf
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2XHY-0007QU-W7
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699883236;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=koG3wFadMnbCIFuBdAvKgcPGRPpjVQVYYyW4+SxH8zI=;
 b=GSACIUe+3QFV9nKnJUf0bNkhB8kHZ7m2pqFffontkUgMC9gXIz4p5CKBzUXJTSoSAMWSct
 aa3HFinrwMZ5yI0FCyqWDiFXmRQjX1mbeQ1AKCK8apDKHQMG6Ab6XrfoZM/lYPw8U3kD0g
 RPz+mC1ScY3Ot3tqEcVt4jSOr0fKTZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-oKA9VAhaPDy7aFHa8oAC2g-1; Mon, 13 Nov 2023 08:47:13 -0500
X-MC-Unique: oKA9VAhaPDy7aFHa8oAC2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D81F93A9A7;
 Mon, 13 Nov 2023 13:47:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4EE51121306;
 Mon, 13 Nov 2023 13:47:10 +0000 (UTC)
Date: Mon, 13 Nov 2023 13:47:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alistair@alistair23.me,
 edgar.iglesias@gmail.com, peter.maydell@linaro.org,
 francisco.iglesias@amd.com, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/2] Replace anti-social QOM type names (again)
Message-ID: <ZVIo3FsmwpfHzsh8@redhat.com>
References: <20231113134344.1195478-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113134344.1195478-1-armbru@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 13, 2023 at 02:43:42PM +0100, Markus Armbruster wrote:
> We got rid of QOM type names containing ',' in 6.0, but some have
> crept back in.  Replace them just like we did in 6.0.

It is practical to add

   assert(strchr(name, ',') == NULL)

to some place in QOM to stop them coming back yet again ?

> 
> Cover letter of 6.0's replacement:
> https://lore.kernel.org/qemu-devel/20210304140229.575481-1-armbru@redhat.com/
> 
> Markus Armbruster (2):
>   docs/system/arm: Fix for rename of type "xlnx.bbram-ctrl"
>   hw: Replace anti-social QOM type names (again)
> 
>  docs/system/arm/xlnx-versal-virt.rst     | 4 ++--
>  include/hw/misc/xlnx-versal-cframe-reg.h | 2 +-
>  include/hw/misc/xlnx-versal-cfu.h        | 6 +++---
>  include/hw/misc/xlnx-versal-crl.h        | 2 +-
>  include/hw/nvram/xlnx-efuse.h            | 2 +-
>  include/hw/nvram/xlnx-versal-efuse.h     | 4 ++--
>  include/hw/nvram/xlnx-zynqmp-efuse.h     | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


