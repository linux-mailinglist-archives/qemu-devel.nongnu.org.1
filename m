Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA365816C18
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:21:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBgV-0004oH-H6; Mon, 18 Dec 2023 06:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBgR-0004nw-7J
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:21:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBgP-0000u9-Go
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702898471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FWGUcgtyk7kVsXwcvvF6e/jv36Dz7X41j3bTOxY8ADA=;
 b=SZxIwv49S3ugJ7QWx88Sug3pORjznLbOHiG7qnV9A15KgLFlyw9UtKYCZIVrmrZoRtGc5k
 Xf5F4wxV/Z/cIJqF1KPD5IyrX/bP5BJ3X+bF5W+RCIg35Y/ecRz207cbQjvuYaYigZq0OS
 RlQRsSYRz7y7pNluCG+KqvLU7GDpLNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-7YJjaQnvO9ikfNVQAdW17A-1; Mon, 18 Dec 2023 06:21:10 -0500
X-MC-Unique: 7YJjaQnvO9ikfNVQAdW17A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FC318966A3;
 Mon, 18 Dec 2023 11:21:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6CB2166B31;
 Mon, 18 Dec 2023 11:21:09 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:21:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [v2 0/4] Support generic Luks encryption
Message-ID: <ZYArI__TwpzTb0xp@redhat.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701879996.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Dec 07, 2023 at 12:37:41AM +0800, Hyman Huang wrote:
> v2:
> - Simplify the design by reusing the LUKS driver to implement
>   the generic Luks encryption, thank Daniel for the insightful 
>   advice.
> - rebase on master. 
> 

> Hyman Huang (4):
>   crypto: Introduce option and structure for detached LUKS header
>   crypto: Introduce payload offset set function
>   crypto: Support generic LUKS encryption
>   block: Support detached LUKS header creation for blockdev-create
> 
>  block/crypto.c         | 47 ++++++++++++++++++++++++++++++++++++++++--
>  crypto/block.c         |  4 ++++
>  include/crypto/block.h |  1 +
>  qapi/block-core.json   | 11 ++++++++--
>  4 files changed, 59 insertions(+), 4 deletions(-)

Could you add a scenario tests/qemu-iotests/tests/luks-detached-header
to provide coverage of this method feature.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


