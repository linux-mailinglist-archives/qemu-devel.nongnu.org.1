Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838086AD2A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 12:30:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfI8d-0007Nj-R5; Wed, 28 Feb 2024 06:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfI8b-0007NF-Fe
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfI8Z-0001Y7-UA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709119811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kVnO8YXt66aJWVJeRey7Nig2WtBn7GfwwGiTJ7t9jdI=;
 b=N5O8kzCCY3pf+3TdwgJYnSi2eGeSeGTW8C0uSgbvPK+DfsB/2HprzE5RMlxR6Aij79IN0K
 a/dT/YHREMNInHdSABGE5BDJHCdULVj0YO3MpUnyvkDKzFYbE9c5E9F+goDYAdY4n3csZu
 1lXYHSGxwRCJbGLcXo/AAFT+qBMYbgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-OrM7u0cFM6eWKNIEoXEXWQ-1; Wed, 28 Feb 2024 06:30:07 -0500
X-MC-Unique: OrM7u0cFM6eWKNIEoXEXWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FC5B85CBA3;
 Wed, 28 Feb 2024 11:30:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B3E02166AF7;
 Wed, 28 Feb 2024 11:30:06 +0000 (UTC)
Date: Wed, 28 Feb 2024 11:30:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
Message-ID: <Zd8ZOHJxhgrmbIWc@redhat.com>
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 <874je22u83.fsf@pond.sub.org>
 <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
 <875xyiz0ho.fsf@pond.sub.org>
 <CAK9dgmZOEqd=EgBjsiZZoK3R+VQRMqSdUrK_WwKHfP7LiWzQMQ@mail.gmail.com>
 <87v8693x7c.fsf@pond.sub.org> <Zd8IQShNrGeXEnLz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zd8IQShNrGeXEnLz@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 11:17:37AM +0100, Kevin Wolf wrote:
> Until now, @size has been mandatory for creating images with every
> driver. Maybe we should even have put it into BlockdevCreateOptions's
> base, because without a size, you're not really creating an image.

NB, @size isn't mandatory for creating images. It isn't required
when creating qcow2 files with backing stores, as the size is
acquired from the backing file instead.

$ qemu-img create demo.raw 1g
Formatting 'demo.raw', fmt=raw size=1073741824
$ qemu-img create -o backing_file=demo.raw -o backing_fmt=raw -f qcow2 demo.qcow2
Formatting 'demo.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 backing_file=demo.raw backing_fmt=raw lazy_refcounts=off refcount_bits=16


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


