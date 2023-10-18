Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D587CD9B7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:53:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4A9-0004AY-RH; Wed, 18 Oct 2023 06:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt4A5-00047U-EJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt4A3-0007Co-1w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697626342;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=z2aTU6V2HyPqAWas4KxHiq2PKkcisCH5M9P/7yN7Rsc=;
 b=OSM0uI7MLCdas8M7Em2puM/wHvUMufI0ohj7eE/ZN5XV1WoJ03UwPtwkYw+eJdsqNsR80p
 hkbhCBAi3OJZaL5R+NeRMZ2Bosyp7dvSHR/l0FweulHY6eHp8BHPUNrp8it5TuKGwbsxvO
 BbpGEs+NFiIiJUHICFThxa7cDXebdKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-zT5PTf5AOT6-Bo6d0PMk_Q-1; Wed, 18 Oct 2023 06:52:18 -0400
X-MC-Unique: zT5PTf5AOT6-Bo6d0PMk_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D98DF8E4145;
 Wed, 18 Oct 2023 10:52:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BC562166B26;
 Wed, 18 Oct 2023 10:52:15 +0000 (UTC)
Date: Wed, 18 Oct 2023 11:52:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 libvir-list@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v7 0/4] Migration deprecated parts
Message-ID: <ZS+43SAy3xEMF4fh@redhat.com>
References: <20231018103204.33444-1-quintela@redhat.com>
 <87bkcwxlkd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkcwxlkd.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Oct 18, 2023 at 12:38:10PM +0200, Juan Quintela wrote:
> Juan Quintela <quintela@redhat.com> wrote:
> > Based on: Message-ID: <20231018100651.32674-1-quintela@redhat.com>
> >           [PULL 00/11] Migration 20231018 patches
> >
> > And here we are, at v7:
> > - drop black line at the end of deprecated.rst
> > - change qemu-iotest output due to warnings for deprecation.
> >
> > The only real change is the output of the qemu-iotest.  That is the
> > reason why I maintained the reviewed-by.  But will be happy if anyone
> > of the block people ack the changes.
> 
> I forgot to include the link to the CI of the previous failure.
> 
> https://gitlab.com/juan.quintela/qemu/-/jobs/5314070229
> 
> tput mismatch (see /builds/juan.quintela/qemu/build/tests/qemu-iotests/scratch/raw-file-183/183.out.bad)
> --- /builds/juan.quintela/qemu/tests/qemu-iotests/183.out
> +++ /builds/juan.quintela/qemu/build/tests/qemu-iotests/scratch/raw-file-183/183.out.bad
> @@ -28,6 +28,8 @@
>  { 'execute': 'migrate',
>         'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
> +warning: parameter 'blk is deprecated; use blockdev-mirror with NBD instead
> +warning: block migration is deprecated; use blockdev-mirror with NBD instead
>  {"return": {}}
>  { 'execute': 'query-status' }
>  {"return": {"status": "postmigrate", "singlestep": false, "running":
>  false}}

IIUC, the JSON bits are being written on stdout, and the warnings
are being written on stderr. The interleaving of the data is
potentially going to be non-deterministic in the .out file.
Generally you'd want a filter in the iotests that culls the
warning: lines to avoid this mixing of stdout/err streams.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


