Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3877F4C5
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWar1-00080O-Ga; Thu, 17 Aug 2023 07:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaqz-0007zv-5Y
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaqw-0002Mm-Sj
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692270465;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dC58IvckkfBfwaDr4Bpe72SFVFyVkS/THzM1CDWKAZk=;
 b=NMwIeZWHNcCdSvgXt8GVYICM1/ej67AR2dICxlqa+gv1JxH3WiVJPJCUBxX/3djO386hWH
 8N+0e/GSNbHUuRnuEbb8nBwY5GX4+udbGpi/v8e26S0PNfeY/JmkXeoZo3dmvJz8pru3mW
 /44kFVIT8rw0xb3Rgf0rPJA7q0zogWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-uU6f24gKO9O6FstVv6PH9Q-1; Thu, 17 Aug 2023 07:07:43 -0400
X-MC-Unique: uU6f24gKO9O6FstVv6PH9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83594185A791
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 11:07:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DDEE64687;
 Thu, 17 Aug 2023 11:07:43 +0000 (UTC)
Date: Thu, 17 Aug 2023 12:07:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] target/i386: Translate feature_word_info to xml
Message-ID: <ZN3/fUEyC7sSqWy7@redhat.com>
References: <20230811135011.23343-1-twiederh@redhat.com>
 <20230811135011.23343-3-twiederh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811135011.23343-3-twiederh@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Fri, Aug 11, 2023 at 03:50:09PM +0200, Tim Wiederhake wrote:
> This is the data file that will be used to generate the C code.
> All information, including the comments, is preserved.
> 
> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> ---
>  target/i386/feature_word_info.xml | 1607 +++++++++++++++++++++++++++++
>  1 file changed, 1607 insertions(+)
>  create mode 100644 target/i386/feature_word_info.xml
> 
> diff --git a/target/i386/feature_word_info.xml b/target/i386/feature_word_info.xml
> new file mode 100644
> index 0000000000..ff741b9f5a
> --- /dev/null
> +++ b/target/i386/feature_word_info.xml
> @@ -0,0 +1,1607 @@
> +<feature_words>

I think adding data formats based on XML is pretty undesirable
for QEMU. AFAIK, the only place we've used XML is where we
needed to have interoperability with an external tool.

Can we not just do this using JSON instead, which would avoid
the need to write python parsing code as we can directly load
it into a python object.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


