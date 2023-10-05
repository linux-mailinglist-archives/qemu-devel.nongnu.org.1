Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B2B7BAB3B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 22:10:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoUf8-0001NQ-WD; Thu, 05 Oct 2023 16:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoUf6-0001N3-JK
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoUf4-0005Gd-IU
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696536569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3x185efhLUGdS2QMbe5wowNwo4zhDH9DX6UY/zfTlTE=;
 b=Q5mMCSB6/n1nSYDAwcC4jKig5GTbyz3OuIQh9XQzWAAvuBfzL3Y6cff3fnEOoSR9wr1qKl
 SyfZLj3xJbNEmeVx7JfspVtQAQmFpWvBGKJgfcIj5r+b+luSLCaPc9I6HI4jg4faH7xfgq
 wLl4aOr/CE8wBW2MKkX4M23pT+c1yPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-ld_dgH11PiOux5JtDxa07w-1; Thu, 05 Oct 2023 16:09:22 -0400
X-MC-Unique: ld_dgH11PiOux5JtDxa07w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72C7981D7A7;
 Thu,  5 Oct 2023 20:09:22 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4906C15BB8;
 Thu,  5 Oct 2023 20:09:21 +0000 (UTC)
Date: Thu, 5 Oct 2023 15:09:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, 
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v6 10/14] iotests: drop some occasional semicolons
Message-ID: <hhhjydg7pdiz6fe6c4jgdxthbnifk7esuhavaute4gmlsbrahh@nzuvuypyv7fb>
References: <20231005135550.331657-1-vsementsov@yandex-team.ru>
 <20231005135550.331657-11-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005135550.331657-11-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 05, 2023 at 04:55:46PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/qemu-iotests/041 | 2 +-
>  tests/qemu-iotests/196 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Maybe in the subject s/occasional/extra/

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 4d7a829b65..550e4dc391 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1086,7 +1086,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
>      def test_after_a_quorum_snapshot(self):
>          result = self.vm.qmp('blockdev-snapshot-sync', node_name='img1',
>                               snapshot_file=quorum_snapshot_file,
> -                             snapshot_node_name="snap1");
> +                             snapshot_node_name="snap1")
>          self.assert_qmp(result, 'return', {})

I'm a bit surprised the linters don't pick up on this.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


