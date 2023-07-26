Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B37762B55
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 08:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOXuY-0002we-CK; Wed, 26 Jul 2023 02:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOXuR-0002sH-UF
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOXuG-0006rk-0k
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690352503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HHAdL9THlSGYlY2UjyoV4+/Zg4CE/uA/2SJ0uVfhAnc=;
 b=NC3533J+FuHUsTE27NUh1gtSA6PzV/iTrGUvGJJRRbzU4w0Dj5xU72INGm48PCv+XhZH8J
 nHbJuPQBhgYEXRRhW0/4b8xRmA4BAemZsduUY0CQhAPifJdqnjn8n8T5b4K7wkK0zJYMak
 MffyTMd4YPX+ubD+TW1Bmun2SBPJJhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-UPGoXU9XMUqRot64dOSgZA-1; Wed, 26 Jul 2023 02:21:37 -0400
X-MC-Unique: UPGoXU9XMUqRot64dOSgZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25B36800B35;
 Wed, 26 Jul 2023 06:21:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 059FD40C2063;
 Wed, 26 Jul 2023 06:21:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB04F21E6833; Wed, 26 Jul 2023 08:21:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras Soares Passos
 <lsoaresp@redhat.com>,  Eric Blake <eblake@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  Chensheng Dong <chdong@redhat.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org> <ZL/7XtiEFWEprQhD@x1n>
Date: Wed, 26 Jul 2023 08:21:35 +0200
In-Reply-To: <ZL/7XtiEFWEprQhD@x1n> (Peter Xu's message of "Tue, 25 Jul 2023
 12:42:06 -0400")
Message-ID: <87o7jz8a6o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> Hi, Markus,
>
> On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:

[...]

>> For better or worse, we duplicate full documentation between
>> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
>> would be the first instance where we reference instead.  I'm not opposed
>> to use references, but if we do, I want them used consistently.
>
> We discussed this over the other "switchover" parameter, but that patchset
> just stranded..
>
> Perhaps I just provide a pre-requisite patch to remove all the comments in
> MigrateSetParameters and MigrationParameters, letting them all point to
> MigrationParameter?

Simplifies maintaining the doc commments.  But how does it affect the
documentation generated from it?  Better, neutral, or worse?

> One thing I should have mentioned much earlier is that this patch is for
> 8.2 material.

Understood.

[...]


