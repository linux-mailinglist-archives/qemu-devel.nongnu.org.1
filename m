Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CCB7B9E74
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:07:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOzJ-0004ZE-Pv; Thu, 05 Oct 2023 10:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoOzH-0004XS-DW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoOzF-0005Ek-Oo
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696514757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yknJkCwR0b+emy/Wf/qMM6fTnIcbO/vojHGvb1RvAow=;
 b=GOet5PlGj9lie0wJUiOrPSlMJJBnB01My7PWpXe+5diVpKWMV+YeOIT449FfCCMKBxdmRk
 PaI+3BUBUKxAWtD4JvWWi+j31qU+32S3z1W2qmySzcPYf9+umDCE7F1Pp2mMgLye/e/d0F
 6HAN2quNfs6Ezo16DZcgq5qNvaU3s1w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-k8iY5kUxMlqXBBzfJ7WoJQ-1; Thu, 05 Oct 2023 10:05:51 -0400
X-MC-Unique: k8iY5kUxMlqXBBzfJ7WoJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23EAD2810D4A;
 Thu,  5 Oct 2023 14:05:51 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3778040C2015;
 Thu,  5 Oct 2023 14:05:49 +0000 (UTC)
Date: Thu, 5 Oct 2023 09:05:47 -0500
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, 
 qemu-block@nongnu.org, Beraldo Leal <bleal@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>, 
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 1/9] Python/iotests: Add type hint for nbd module
Message-ID: <cnpmerggwpvnybezttkrnxmt7xpscxxlc4rglmzijpm4f3onzt@thdoszxqyint>
References: <20231004194613.2900323-1-jsnow@redhat.com>
 <20231004194613.2900323-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004194613.2900323-2-jsnow@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Oct 04, 2023 at 03:46:05PM -0400, John Snow wrote:
> The test bails gracefully if this module isn't installed, but linters
> need a little help understanding that. It's enough to just declare the
> type in this case.
> 
> (Fixes pylint complaining about use of an uninitialized variable because
> it isn't wise enough to understand the notrun call is noreturn.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/tests/nbd-multiconn | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Since there's questions about this pull request seeming to be the
first time this patch has appeared on list, I'll go ahead and review
it here on the assumption that a v2 pull request is warranted.

> 
> diff --git a/tests/qemu-iotests/tests/nbd-multiconn b/tests/qemu-iotests/tests/nbd-multiconn
> index 478a1eaba27..7e686a786ea 100755
> --- a/tests/qemu-iotests/tests/nbd-multiconn
> +++ b/tests/qemu-iotests/tests/nbd-multiconn
> @@ -20,6 +20,8 @@
>  
>  import os
>  from contextlib import contextmanager
> +from types import ModuleType
> +
>  import iotests
>  from iotests import qemu_img_create, qemu_io
>  
> @@ -28,7 +30,7 @@ disk = os.path.join(iotests.test_dir, 'disk')
>  size = '4M'
>  nbd_sock = os.path.join(iotests.sock_dir, 'nbd_sock')
>  nbd_uri = 'nbd+unix:///{}?socket=' + nbd_sock
> -
> +nbd: ModuleType

Is it possible to put this closer to the code actually using 'nbd', as
in this region?

| if __name__ == '__main__':
|     try:
|         # Easier to use libnbd than to try and set up parallel
|         # 'qemu-nbd --list' or 'qemu-io' processes, but not all systems
|         # have libnbd installed.
|         import nbd  # type: ignore

but then again, open_nbd() right after your current location utilizes
the variable, so I guess not.  I trust your judgment on silencing the
linters, so whether or not you move it (if moving is even possible),

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


