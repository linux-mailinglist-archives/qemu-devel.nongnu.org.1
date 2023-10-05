Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C037BAB73
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 22:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoUyU-0002Qc-Lx; Thu, 05 Oct 2023 16:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoUyS-0002K0-12
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoUyQ-0002GN-5z
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696537769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/vZEAZiPHcDDJ3RrGHWSHpviuHnEoYU6+V5dqmHsh5U=;
 b=XYKSscuZ5ce2ckN4lDHXp7vmbEqWvK5Y/gFwYMmPw+dxVQogKfMBU3MBNmdR7ac8dgR23c
 E+H231Ej1WzwvAeBS5EkAlk63zff4NhPl/Q/m89EZHM/6ZK/CAbevd9oRaoVUwb65VYe6w
 4+2joSz27uhyb4PSRUY8bhu4nJnSeJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-kzZBP0vcN3S2LsSkRc_SaA-1; Thu, 05 Oct 2023 16:29:25 -0400
X-MC-Unique: kzZBP0vcN3S2LsSkRc_SaA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 860971019CA2;
 Thu,  5 Oct 2023 20:29:25 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96213492B05;
 Thu,  5 Oct 2023 20:29:24 +0000 (UTC)
Date: Thu, 5 Oct 2023 15:29:22 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, 
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v6 14/14] python: use vm.cmd() instead of vm.qmp() where
 appropriate
Message-ID: <iyntga7bgkuel7cvowdvovte2ie7tp3u5dyr4zyicfygdggqdi@uuwpu3gehnos>
References: <20231005135550.331657-1-vsementsov@yandex-team.ru>
 <20231005135550.331657-15-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005135550.331657-15-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 05, 2023 at 04:55:50PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> In many cases we just want an effect of qmp command and want to raise on
> failure. Use vm.cmd() method which does exactly this.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/avocado/vnc.py                          |  16 +-
>  tests/qemu-iotests/030                        | 168 +++---
>  tests/qemu-iotests/040                        | 172 +++----
>  tests/qemu-iotests/041                        | 483 ++++++++----------
>  tests/qemu-iotests/045                        |  15 +-
>  tests/qemu-iotests/055                        |  62 +--
>  tests/qemu-iotests/056                        |  77 ++-
>  tests/qemu-iotests/093                        |  42 +-
>  tests/qemu-iotests/118                        | 225 ++++----
>  tests/qemu-iotests/124                        | 102 ++--
>  tests/qemu-iotests/129                        |  14 +-
>  tests/qemu-iotests/132                        |   5 +-
>  tests/qemu-iotests/139                        |  45 +-
>  tests/qemu-iotests/147                        |  31 +-
>  tests/qemu-iotests/151                        |  57 +--
>  tests/qemu-iotests/152                        |  10 +-
>  tests/qemu-iotests/155                        |  55 +-
>  tests/qemu-iotests/165                        |   8 +-
>  tests/qemu-iotests/196                        |   3 +-
>  tests/qemu-iotests/205                        |   6 +-
>  tests/qemu-iotests/218                        | 105 ++--
>  tests/qemu-iotests/245                        | 245 ++++-----
>  tests/qemu-iotests/264                        |  31 +-
>  tests/qemu-iotests/281                        |  21 +-
>  tests/qemu-iotests/295                        |  15 +-
>  tests/qemu-iotests/296                        |  15 +-
>  tests/qemu-iotests/298                        |  13 +-
>  tests/qemu-iotests/300                        |  54 +-
>  tests/qemu-iotests/iotests.py                 |   9 +-
>  .../tests/export-incoming-iothread            |   6 +-
>  .../qemu-iotests/tests/graph-changes-while-io |   6 +-
>  tests/qemu-iotests/tests/image-fleecing       |   3 +-
>  .../tests/migrate-bitmaps-postcopy-test       |  31 +-
>  tests/qemu-iotests/tests/migrate-bitmaps-test |  47 +-
>  .../qemu-iotests/tests/migrate-during-backup  |  41 +-
>  .../qemu-iotests/tests/migration-permissions  |   9 +-
>  .../tests/mirror-ready-cancel-error           |  74 ++-
>  tests/qemu-iotests/tests/mirror-top-perms     |  16 +-
>  tests/qemu-iotests/tests/nbd-multiconn        |  12 +-
>  tests/qemu-iotests/tests/reopen-file          |   3 +-
>  .../qemu-iotests/tests/stream-error-on-reset  |   6 +-
>  41 files changed, 951 insertions(+), 1407 deletions(-)

Big but mechanical.  It would be worth amending the commit message to
describe how you found all these spots (in case someone backporting
this patch has to redo the work over a different subset of files based
on what has changed since the two trees diverged).

> 
> diff --git a/tests/avocado/vnc.py b/tests/avocado/vnc.py
> index aeeefc70be..862c8996a8 100644
> --- a/tests/avocado/vnc.py
> +++ b/tests/avocado/vnc.py
> @@ -88,9 +88,8 @@ def test_change_password(self):
>          self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password=on')
>          self.vm.launch()
>          self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
> -        set_password_response = self.vm.qmp('change-vnc-password',
> -                                            password='new_password')
> -        self.assertEqual(set_password_response['return'], {})
> +        self.vm.cmd('change-vnc-password',
> +                    password='new_password')

Indeed a nicer idiom, where you are able to use it (whether by
self.assertEqual or by self.assert_qmp).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


