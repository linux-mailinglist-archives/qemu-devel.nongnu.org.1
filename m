Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F857937FE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdof1-0003Aw-5t; Wed, 06 Sep 2023 05:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdoev-0002sN-DP
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdoer-0005f0-OW
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693991829;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9qNfIRVcItbSBiGj3jJ+YmZH+nhnMXnwJmDw9lqbqe4=;
 b=Q5TPHt/J4NyCz6X5W185Boh9/p3vmjMeO/Y1amewwczsZNfW5xfpBSQk+84FIP/De3rZDG
 1HlVWuPUJnmGqoCSqgPxJWyL3p4HRpU264UUyXk5V0DJ/h8MPlCI0v5GYKxwMHK5IvvBau
 3K5w+Bghc+v1lhWlvFPeHrefZq5QW7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-Lo6klfvfN7Sgd6z12s2YLQ-1; Wed, 06 Sep 2023 05:17:07 -0400
X-MC-Unique: Lo6klfvfN7Sgd6z12s2YLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CDC691BC21
 for <qemu-devel@nongnu.org>; Wed,  6 Sep 2023 09:17:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF3ABC4F801;
 Wed,  6 Sep 2023 09:17:06 +0000 (UTC)
Date: Wed, 6 Sep 2023 10:17:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 0/7] Validate and test qapi examples
Message-ID: <ZPhDkJ+RvPauLfG6@redhat.com>
References: <20230905194846.169530-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230905194846.169530-1-victortoso@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Tue, Sep 05, 2023 at 09:48:39PM +0200, Victor Toso wrote:
> Hi,
> 
> This is a follow up from the RFC sent in the end of 08-2022:
>     https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04525.html
> 
> The generator code was rebased, without conflicts. The commit log was
> improved as per Markus suggestion [0], altough I'm sure it can be
> improved further.
> 
> To clarify, consuming the Examples as data for testing the qapi-go
> work has been very very helpful. I'm positive it can be of use for other
> bindings in the future, besides keeping the examples functional
> 
> Cheers,
> 
> [0] https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04682.html
> 
> Victor Toso (7):
>   qapi: scripts: add a generator for qapi's examples
>   qapi: fix example of get-win32-socket command
>   qapi: fix example of dumpdtb command
>   qapi: fix example of cancel-vcpu-dirty-limit command
>   qapi: fix example of set-vcpu-dirty-limit command
>   qapi: fix example of calc-dirty-rate command
>   qapi: fix example of NETDEV_STREAM_CONNECTED event
> 
>  qapi/machine.json            |   2 +-
>  qapi/migration.json          |   6 +-
>  qapi/misc.json               |   2 +-
>  qapi/net.json                |   6 +-
>  scripts/qapi/dumpexamples.py | 194 +++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py         |   2 +
>  6 files changed, 204 insertions(+), 8 deletions(-)
>  create mode 100644 scripts/qapi/dumpexamples.py

After applying this series, aside from the extra broken examples
mentioned in my patch 1 comments, I also see a test suite failure
during build

FAILED: tests/qapi-builtin-types.c tests/qapi-builtin-types.h tests/qapi-builtin-visit.c tests/qapi-builtin-visit.h tests/test-qapi-commands-sub-sub-module.c tests/test-qapi-commands-sub-sub-module.h tests/test-qapi-commands.c tests/test-qapi-commands.h tests/test-qapi-emit-events.c tests/test-qapi-emit-events.h tests/test-qapi-events-sub-sub-module.c tests/test-qapi-events-sub-sub-module.h tests/test-qapi-events.c tests/test-qapi-events.h tests/test-qapi-init-commands.c tests/test-qapi-init-commands.h tests/test-qapi-introspect.c tests/test-qapi-introspect.h tests/test-qapi-types-sub-sub-module.c tests/test-qapi-types-sub-sub-module.h tests/test-qapi-types.c tests/test-qapi-types.h tests/test-qapi-visit-sub-sub-module.c tests/test-qapi-visit-sub-sub-module.h tests/test-qapi-visit.c tests/test-qapi-visit.h 
/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /home/berrange/src/virt/qemu/scripts/qapi-gen.py -o /home/berrange/src/virt/qemu/build/tests -b -p test- ../tests/qapi-schema/qapi-schema-test.json --suppress-tracing
Traceback (most recent call last):
  File "/home/berrange/src/virt/qemu/scripts/qapi-gen.py", line 19, in <module>
    sys.exit(main.main())
             ^^^^^^^^^^^
  File "/home/berrange/src/virt/qemu/scripts/qapi/main.py", line 96, in main
    generate(args.schema,
  File "/home/berrange/src/virt/qemu/scripts/qapi/main.py", line 58, in generate
    gen_examples(schema, output_dir, prefix)
  File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line 40, in gen_examples
    schema.visit(vis)
  File "/home/berrange/src/virt/qemu/scripts/qapi/schema.py", line 1227, in visit
    mod.visit(visitor)
  File "/home/berrange/src/virt/qemu/scripts/qapi/schema.py", line 209, in visit
    entity.visit(visitor)
  File "/home/berrange/src/virt/qemu/scripts/qapi/schema.py", line 857, in visit
    visitor.visit_command(
  File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line 184, in visit_command
    parse_examples_of(self, name)
  File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line 118, in parse_examples_of
    assert((obj.doc is not None))
            ^^^^^^^^^^^^^^^^^^^
AssertionError
ninja: build stopped: subcommand failed.


not sure if that's related to the examples that still need fixing or not ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


