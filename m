Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D377026B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:00:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvKq-0003CU-VE; Fri, 04 Aug 2023 09:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRvKl-0003Bs-LS
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRvKj-0001B2-V1
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691157553;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EKkMbs609wTbj06h/U2HQzLUAJuOP+uCFQk7dVDCliY=;
 b=L6fzUxxzwTvFGSKGVABl6qhqgG/e4rfiZe09rHHo3EKeGFvvDOVW8i9Tf7k9F2og1bgAr5
 776wXiMsUy1vF9clqSKSkwlsNP3cGTll5mGg9AwEJtHXePL8gyG7LR7yTlSQJtWi5uWeCA
 E1MbN//XjT2+QNUichQfRLTO+gTc2es=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-rE_0arwEP2yDnWEsjBa1Rw-1; Fri, 04 Aug 2023 09:59:11 -0400
X-MC-Unique: rE_0arwEP2yDnWEsjBa1Rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47CC9101A528;
 Fri,  4 Aug 2023 13:59:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1696A1121325;
 Fri,  4 Aug 2023 13:59:09 +0000 (UTC)
Date: Fri, 4 Aug 2023 14:59:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Zhiyi Guo <zhguo@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
Message-ID: <ZM0EK3A/rnDPImXz@redhat.com>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzub8016.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Fri, Aug 04, 2023 at 02:28:05PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > We used to have three objects that have always the same list of parameters
> 
> We have!
> 
> > and comments are always duplicated:
> >
> >   - @MigrationParameter
> >   - @MigrationParameters
> >   - @MigrateSetParameters
> >
> > Before we can deduplicate the code, it's fairly straightforward to
> > deduplicate the comments first, so for each time we add a new migration
> > parameter we don't need to copy the same paragraphs three times.
> 
> De-duplicating the code would be nice, but we haven't done so in years,
> which suggests it's hard enough not to be worth the trouble.

The "MigrationParameter" enumeration isn't actually used in
QMP at all.

It is only used in HMP for hmp_migrate_set_parameter and
hmp_info_migrate_parameters. So it is questionable documenting
that enum in the QMP reference docs at all.

1c1
< { 'struct': 'MigrationParameters',
---
> { 'struct': 'MigrateSetParameters',
14,16c14,16
<             '*tls-creds': 'str',
<             '*tls-hostname': 'str',
<             '*tls-authz': 'str',
---
>             '*tls-creds': 'StrOrNull',
>             '*tls-hostname': 'StrOrNull',
>             '*tls-authz': 'StrOrNull',

Is it not valid to use StrOrNull in both cases and thus
delete the duplication here ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


