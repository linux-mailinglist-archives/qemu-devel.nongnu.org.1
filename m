Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4F7EACC6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:15:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2pUd-0002vA-3d; Tue, 14 Nov 2023 04:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2pUL-0002ub-G0
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2pUJ-0003SD-IN
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699953218;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BEw2ONtzCzxXuZ9nyWXR+1NtGRkW0MJlBUlWkgKSMyE=;
 b=epAbWxE1DWIkek2tXg5D/msbgdjon1O395LejGGqHYJYm3UoHe69hE8GGIurjX+wos5zs/
 zIdSnYEjATnIx7swBxdaJ6nMzm/WEXUav9v3u2m4pBcsKlZ5mHct5/MCakyZcJDiDFTt7K
 8dLdr85lCMOGmF/FC3SfOJBQPhtuKUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-5Ei6dA2QODq8UwnMBNm5lw-1; Tue, 14 Nov 2023 04:13:34 -0500
X-MC-Unique: 5Ei6dA2QODq8UwnMBNm5lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E929485A58A;
 Tue, 14 Nov 2023 09:13:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD470C1596F;
 Tue, 14 Nov 2023 09:13:32 +0000 (UTC)
Date: Tue, 14 Nov 2023 09:13:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: Configuring migration (was: [PATCH v3 3/4] migration/qapi:
 Replace @MigrateSetParameters with @MigrationParameters)
Message-ID: <ZVM5xmsaE41WJYgb@redhat.com>
References: <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica> <87msvw6xm2.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msvw6xm2.fsf_-_@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 02, 2023 at 03:25:25PM +0100, Markus Armbruster wrote:
> Now let's try to apply this to migration.
>
> As long as we can have just one migration, we need just one QAPI object
> to configure it.
> 
> We could create the object with -object / object_add.  For convenience,
> we'd probably want to create one with default configuration
> automatically on demand.
> 
> We could use qom-set to change configuration.  If we're not comfortable
> with using qom-set for production, we could do something like
> blockdev-reopen instead.

Do we even need to do this via a QAPI object ?

Why are we not just making the obvious design change of passing everything
with the 'migrate' / 'migrate-incoming' commands that kick it off:

ie:

{ 'command': 'migrate',
  'data': {'uri': 'str',
           '*channels': [ 'MigrationChannel' ],
	   '*capabilities': [ 'MigrateCapability' ],
	   '*parameters': [ 'MigrateParameters' ],
           '*detach': 'bool', '*resume': 'bool' } }

     (deprecated bits trimmed for clarity)

and the counterpart:

{ 'command': 'migrate-incoming',
             'data': {'*uri': 'str',
                      '*channels': [ 'MigrationChannel' ],
                      '*capabilities': [ 'MigrateCapability' ],
                      '*parameters': [ 'MigrateParameters' ] } }

such that the design is just like 99% of other commands which take
all their parameters directly. We already have 'migrate-set-parameters'
remaining for the runtime tunables, and can deprecate the usage of this
when migration is not already running, and similarly deprecate
migrate-set-capabilities.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


