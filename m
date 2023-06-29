Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B2B7422E1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnau-0001Td-VE; Thu, 29 Jun 2023 05:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qEnas-0001Sf-Io
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qEnap-0008B8-M0
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688029534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZX9G9AcpXydVvq3/5aYLKt6T4z8hhEIZHoGNJdl8pZM=;
 b=DfDHf9mrxbPFcTVaHe2JBky5e5uLduCDHd2dGTwA0zZxgBwyobNFza0EQhDpVJXiDxEfIU
 xma27Ft3KDiHdKdOkZDTtZs6qX1c+oT8QoRYlhTlkQsYTsITl7TgkahsyGC+wC/6Ni6MZV
 0FxqDM7JUc1cbDkIKorkqySgJ8BSk1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-g7oI5VjENX--_0ltBvNkGQ-1; Thu, 29 Jun 2023 05:05:30 -0400
X-MC-Unique: g7oI5VjENX--_0ltBvNkGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E22661044592;
 Thu, 29 Jun 2023 09:05:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9242166B26;
 Thu, 29 Jun 2023 09:05:27 +0000 (UTC)
Date: Thu, 29 Jun 2023 10:05:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: Re: [PATCH v4 0/6] net/tap: Fix QEMU frozen issue when the maximum
 number of file descriptors is very large
Message-ID: <ZJ1JVX7TldouvTsY@redhat.com>
References: <20230628152726.110295-1-bmeng@tinylab.org>
 <c55642e4-04fc-565d-abe0-f69d6e421852@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c55642e4-04fc-565d-abe0-f69d6e421852@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 29, 2023 at 11:33:29AM +0300, Michael Tokarev wrote:
> 28.06.2023 18:27, Bin Meng wrote:
> > 
> > Current codes using a brute-force traversal of all file descriptors
> > do not scale on a system where the maximum number of file descriptors
> > is set to a very large value (e.g.: in a Docker container of Manjaro
> > distribution it is set to 1073741816). QEMU just looks frozen during
> > start-up.
> 
> So, the same question as before. *Why* do we close all filedescriptors
> to begin with?

The O_CLOSEXEC flag is a terrible concept, as the default behaviour of
file descriptors is to be leaked into all child processes, unless code
takes explicit action to set O_CLOEXEC in every case. Even if they are
diligent about their own code, apps developers can have zero confidence
that every library they use has set O_CLOEXEC. Not just set it after the
FD is open, but set it atomically when the the FD is open, because
threads create race conditions if not atomically set.

Leaking FDs is a security risk, and QEMU is an especially security
critical application. QEMU needs stronger guarantees that O_CLOEXEC
can offer, and mass-close before execve is the only viable option
to achieve this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


