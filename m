Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BB7B1EBC
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrFy-0006rS-6P; Thu, 28 Sep 2023 09:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlrFt-0006pG-OS
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlrFr-0004VH-Dy
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908433;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7AagcRK+9l4kVk9OGitYRZJeyfrjzAh5O8VKwvjlCuM=;
 b=UJnHQ2WRYsJGpLB0404cAJ0TGnjYfFFcoCopCTCmdl5m+yn7GDrtvoU657ZZJkKfo+y17a
 aKki4/ARbIuo4OaH/35ffSlA2SSXVw8ZFht9eTUxYAmERxW/dJCLEsBT1hvxU9vr4IYE2P
 lfdl9r3IO1+rgbE6VqtrnphEJHzbOZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-MAJxH893N3KH9cGuN6d2Cg-1; Thu, 28 Sep 2023 09:40:32 -0400
X-MC-Unique: MAJxH893N3KH9cGuN6d2Cg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26AA8101A529
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 13:40:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E6D8140273E;
 Thu, 28 Sep 2023 13:40:30 +0000 (UTC)
Date: Thu, 28 Sep 2023 14:40:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 0/9] qapi-go: add generator for Golang interface
Message-ID: <ZRWCSzrqDojlPOO4@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927112544.85011-1-victortoso@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 01:25:35PM +0200, Victor Toso wrote:
> Hi, long time no see!
> 
> This patch series intent is to introduce a generator that produces a Go
> module for Go applications to interact over QMP with QEMU.

snip
 
> Victor Toso (9):
>   qapi: golang: Generate qapi's enum types in Go
>   qapi: golang: Generate qapi's alternate types in Go
>   qapi: golang: Generate qapi's struct types in Go
>   qapi: golang: structs: Address 'null' members
>   qapi: golang: Generate qapi's union types in Go
>   qapi: golang: Generate qapi's event types in Go
>   qapi: golang: Generate qapi's command types in Go
>   qapi: golang: Add CommandResult type to Go
>   docs: add notes on Golang code generator
> 
>  docs/devel/qapi-golang-code-gen.rst |  341 +++++++++
>  scripts/qapi/golang.py              | 1047 +++++++++++++++++++++++++++
>  scripts/qapi/main.py                |    2 +
>  3 files changed, 1390 insertions(+)
>  create mode 100644 docs/devel/qapi-golang-code-gen.rst
>  create mode 100644 scripts/qapi/golang.py

So the formatting of the code is kinda all over the place eg

func (s *StrOrNull) ToAnyOrAbsent() (any, bool) {
    if s != nil {
        if s.IsNull {
            return nil, false
    } else if s.S != nil {
        return *s.S, false
        }
    }

    return nil, true
}


ought to be

func (s *StrOrNull) ToAnyOrAbsent() (any, bool) {
        if s != nil {
                if s.IsNull {
                        return nil, false
                } else if s.S != nil {
                        return *s.S, false
                }
        }

        return nil, true
}

I'd say we should add a 'make check-go' target, wired into 'make check'
that runs 'go fmt' on the generated code to validate that we generated
correct code. Then fix the generator to actually emit the reqired
format.


Having said that, this brings up the question of how we expect apps to
consume the Go code. Generally an app would expect to just add the
module to their go.mod file, and have the toolchain download it on
the fly during build.

If we assume a go namespace under qemu.org, we'll want one or more
modules. Either we have one module, containing APIs for all of QEMU,
QGA, and QSD, or we have separate go modules for each. I'd probably
tend towards the latter, since it means we can version them separately
which might be useful if we're willing to break API in one of them,
but not the others.

IOW, integrating this directly into qemu.git as a build time output
is not desirable in this conext though, as 'go build' can't consume
that.

IOW, it would push towards

   go-qemu.git
   go-qga.git
   go-qsd.git

and at time of each QEMU release, we would need to invoke the code
generator, and store its output in the respective git modules.

This would also need the generator application to be a standalone
tool, separate from the C QAPI generator.

Finally Go apps would want to do

   import (
       qemu.org/go/qemu
       qemu.org/go/qga
       qemu.org/go/gsd
   )

and would need us to create the "https://qemu.org/go/qemu" page
containing dummy HTML content with 

    <meta name="go-import" content="qemu.org/go/qemu git https://gitlab.com/qemu-project/go-qemu.git@/>

and likewise for the other modules.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


