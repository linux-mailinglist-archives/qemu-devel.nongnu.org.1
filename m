Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5C8388C7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:22:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSC2x-0002BN-E1; Tue, 23 Jan 2024 03:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rSC2u-0002B1-P9
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:22:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rSC2s-0000Ub-7G
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705998129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=M36Yb2onoTJ/82rN36RtLVVxqYNaSW2ddYYyVrYF8A4=;
 b=KUE8TiBruAWje2oM5fXfYL5aoiwQKAczKeF6sH06Sr9A5CjmNjScnH2mlNBvNhVrALmsCX
 I3jGldyxtEussYFmWLoNLswV3CX1LKJIPwXNAbA8c82lxp8U6L2e/J+5ctuMFx6rdCVEzc
 aIked40m2jz8Pfa3QKe+JbteIwGxjME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-GYwBV3wROPyNbVd2wqR_8Q-1; Tue, 23 Jan 2024 03:22:05 -0500
X-MC-Unique: GYwBV3wROPyNbVd2wqR_8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A12C1066143;
 Tue, 23 Jan 2024 08:22:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C39EB51D5;
 Tue, 23 Jan 2024 08:22:00 +0000 (UTC)
Date: Tue, 23 Jan 2024 08:21:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
Message-ID: <Za93I-50U745B27C@redhat.com>
References: <20240123064219.40514-1-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240123064219.40514-1-het.gala@nutanix.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 23, 2024 at 06:42:19AM +0000, Het Gala wrote:
> 'uri' argument should be optional, as 'uri' and 'channels'
> arguments are mutally exclusive in nature.
> 
> Fixes: 074dbce5fcce (migration: New migrate and
> migrate-incoming argument 'channels')
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  qapi/migration.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index eb2f883513..197d3faa43 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1757,7 +1757,7 @@
>  #
>  ##
>  { 'command': 'migrate',
> -  'data': {'uri': 'str',
> +  'data': {'*uri': 'str',
>             '*channels': [ 'MigrationChannel' ],
>             '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
>             '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },

Hmm, this mistake shows a lack of coverage in migration-test.c for
the 'channels' argument. I thought the original series adding 'channels'
included the tests for this. Either way, this needs to come with test
coverage for use of 'channels', with 'uri' omitted.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


