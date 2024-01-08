Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B936A8277E9
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:48:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMueV-0003ve-Vz; Mon, 08 Jan 2024 13:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMueJ-0003sZ-M7
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMue6-0007NX-11
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704739604;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ib26ceCbH4P6uUHES8CSZTS7xbcoVfex4X3cYuQ+GxE=;
 b=jDnP6k2bKew3KApGVfoAQqrMq+f/yLXpAB5yvq9C6jgxyOyC3Tjv1Rwn0TLqHDOrvHUuqs
 8c5G/rbyU0YXot31Xemty672Ux9EyUiJEqwTP466FTHDyO0jkhAYkp5IItqCLnrIjl0tIj
 ABDHV7+kI9VnA1DUr9C+rBwC8YE+F+E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-9Egfy45dMXaD1wF4GtXF_A-1; Mon,
 08 Jan 2024 13:46:42 -0500
X-MC-Unique: 9Egfy45dMXaD1wF4GtXF_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81D0B3C28643;
 Mon,  8 Jan 2024 18:46:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 983AB3C2E;
 Mon,  8 Jan 2024 18:46:41 +0000 (UTC)
Date: Mon, 8 Jan 2024 18:46:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/29] include: move include/qapi/qmp/ to include/qobject/
Message-ID: <ZZxDDmv1YsqlMMCT@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
 <20240108182405.1135436-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108182405.1135436-2-berrange@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jan 08, 2024 at 06:23:37PM +0000, Daniel P. Berrangé wrote:
> The general expectation is that header files should follow the same
> file/path naming scheme as the corresponding source file. There are
> various historical exceptions to this practice in QEMU, with one of
> the most notable being the include/qapi/qmp/ directory. Most of the
> headers there correspond to source files in qobject/.
> 
> This patch corrects that inconsistency by creating include/qobject/.
> The only outlier is include/qapi/qmp/dispatch.h which gets renamed
> to include/qapi/qmp-registry.h.
> 
> To allow the code to continue to build, symlinks are temporarily
> added in $QEMU/qapi/qmp/ to point to the new location. They will
> be removed in a later commit.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  MAINTAINERS                                     | 5 +----
>  include/qapi/{qmp/dispatch.h => qmp-registry.h} | 0
>  include/{qapi/qmp => qobject}/json-parser.h     | 0
>  include/{qapi/qmp => qobject}/json-writer.h     | 0
>  include/{qapi/qmp => qobject}/qbool.h           | 0
>  include/{qapi/qmp => qobject}/qdict.h           | 0
>  include/{qapi/qmp => qobject}/qerror.h          | 0

Of course just after sending this I decided that moving qerror.h
to qobject/ is probably not optimal. It only contains a set of
(deprecated) error message strings. Perhaps it could just move
from qapi/qmp/qerror.h to just qapi/qerror.h ? Other suggestions ?

>  include/{qapi/qmp => qobject}/qjson.h           | 0
>  include/{qapi/qmp => qobject}/qlist.h           | 0
>  include/{qapi/qmp => qobject}/qlit.h            | 0
>  include/{qapi/qmp => qobject}/qnull.h           | 0
>  include/{qapi/qmp => qobject}/qnum.h            | 0
>  include/{qapi/qmp => qobject}/qobject.h         | 0
>  include/{qapi/qmp => qobject}/qstring.h         | 0

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


