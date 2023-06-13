Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0B72DB78
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 09:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8ylC-0005xG-RY; Tue, 13 Jun 2023 03:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1q8ylB-0005wd-MM
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1q8yl9-00023d-F5
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686642490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWBHMZoTVC3E2yPdTAGzLi0O22UwcGG7zSqJyhE5pmQ=;
 b=P+RVpd/URiiwWDi3GnckfHKpMiErNGEbpgCcZMSlHLf2KnzorVeHlB+DFllbk9sqICRakX
 Km1DuLa4NFzZCVe79gU4spB6y3uQlSVUkYqUduZ38iKa0cNow82teDywUb70JZBvbxzzVy
 a260P45RkSnfpqOBMOkAbN1NtHKnw3E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-ZSWg_RCTNlW5sYIVo9y2Bg-1; Tue, 13 Jun 2023 03:48:05 -0400
X-MC-Unique: ZSWg_RCTNlW5sYIVo9y2Bg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3DDB29AA38A;
 Tue, 13 Jun 2023 07:48:04 +0000 (UTC)
Received: from virval.usersys.redhat.com (unknown [10.43.2.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7501C558;
 Tue, 13 Jun 2023 07:48:04 +0000 (UTC)
Date: Tue, 13 Jun 2023 09:48:03 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC 0/6] Migration deprecated parts
Message-ID: <ZIgfMzM2Ppa8yzPa@orkuz.int.mamuti.net>
References: <20230612193344.3796-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612193344.3796-1-quintela@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 12, 2023 at 21:33:38 +0200, Juan Quintela wrote:
> Hi this series describe the migration parts that have to be deprecated.
> 
> - It is an rfc because I doubt that I did the deprecation process right. Hello Markus O:-)
> 
> - skipped field: It is older than me, I have never know what it stands
>   for.  As far as I know it has always been zero.

Libvirt doesn't use this.

> - inc/blk migrate command options.  They are only used by block
>   migration (that I deprecate on the following patch).  And they are really bad.
>   grep must_remove_block_options.
>
> - block migration.  block jobs, whatever they are called this week are
>   way more flexible.  Current code works, but we broke it here and
>   there, and really nobody has stand up to maintain it.  It is quite
>   contained and can be left there.  Is anyone really using it?

We prefer nbd for storage migration if it is available.

> - old compression method.  It don't work.  See last try from Lukas to
>   make a test that works reliabely.  I failed with the same task years
>   ago.  It is really slow, and if compression is good for you, multifd
>   + zlib is going to perform/compress way more.

We do support these methods, but only enable them if a user explicitly
requests so. In other words, the user will just get an error once these
methods are removed, which is fine.

> - -incoming <uri>
> 
>   if you need to set parameters (multifd cames to mind, and preempt has
>   the same problem), you really needs to use defer.  So what should we do here?
> 
>   This part is not urget, because management apps have a working
>   option that are already using "defer", and the code simplifacation
>   if we remove it is not so big.  So we can leave it until 9.0 or
>   whatever we think fit.

Right, libvirt already uses -incoming defer if supported.

In other words, no objection to removing anything on this list and no
additional work is needed on libvirt side.

Jirka


