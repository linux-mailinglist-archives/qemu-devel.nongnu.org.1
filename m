Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AE8199C0
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 08:41:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFrBq-0002Vb-S6; Wed, 20 Dec 2023 02:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFrBl-0002VB-NV
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 02:40:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFrBR-0002jS-Fy
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 02:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703057998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6gWhBszD3k++MKC+egdUcqtYzodgj1osZ5tVxXteDg=;
 b=iPcUclCnOyIfajZLW7b9KsHwXDrYajWJ0vFcNieDIq+f5lr0XnHSjqK5QA4XY2BuLEZXDk
 nACOSkTA74cf7uehwVOxotHVXhPv9i81lTZOeMr0mF4sDZ3FuGQvpsKLfN2LDOUIF00SRU
 W83ENLflhgcJmGa6rJto9TB2jtNmBus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-s-CCbkqxOJu_h3G2MSR2Lw-1; Wed, 20 Dec 2023 02:39:57 -0500
X-MC-Unique: s-CCbkqxOJu_h3G2MSR2Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2559A88D70C;
 Wed, 20 Dec 2023 07:39:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04C621C060AF;
 Wed, 20 Dec 2023 07:39:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC02521E6920; Wed, 20 Dec 2023 08:39:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,  qemu-devel@nongnu.org,  Michal
 Privoznik <mprivozn@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  qemu-block@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property
 type
In-Reply-To: <ZYHACN3AEV_TW0iZ@redhat.com> (Kevin Wolf's message of "Tue, 19
 Dec 2023 17:08:40 +0100")
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <20230918161604.1400051-2-stefanha@redhat.com>
 <877cnpsll9.fsf@pond.sub.org> <20231219151328.GA219161@fedora>
 <ZYHACN3AEV_TW0iZ@redhat.com>
Date: Wed, 20 Dec 2023 08:39:55 +0100
Message-ID: <8734vxiapg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 19.12.2023 um 16:13 hat Stefan Hajnoczi geschrieben:
>> On Sat, Oct 14, 2023 at 09:35:14AM +0200, Markus Armbruster wrote:
>> > Stefan Hajnoczi <stefanha@redhat.com> writes:
>> > > +##
>> > > +# @IOThreadVirtQueueMappings:
>> > > +#
>> > > +# IOThreadVirtQueueMapping list. This struct is not actually used but the
>> > > +# IOThreadVirtQueueMappingList type it generates is!
>> > 
>> > Two spaces between sentences for consistency, please.
>> > 
>> > Doc comments are QMP reference documentation for users.  Does this
>> > paragraph belong there?
>> 
>> Someone might wonder why a type exists that is never used, so I think
>> including this in the documentation is acceptable.
>
> I seem to remember that we had a similar remark elsewhere, but maybe it
> doesn't exist any more today?

Working up more context...  alright, now I see.

When the QAPI schema defines a type 'T', the QAPI generator generates
code and documentation for it whether it is used in the schema or not.
We occasionally use this to generate types with QAPI goodies for purely
internal use.  In other words, the generator assumes there is a use of T
in C code.

However, the QAPI generator generates code for ['T'] only if there's a
use of ['T'] in the schema.  This is because it's actually needed only
for about one in seven types.  See commit 9f08c8ec738 (qapi: Lazy
creation of array types).

Once in a blue moon, ['T'] is only used in C code.  The QAPI generator
won't generate code for it then, and the C code won't compile.  Then we
have to add a dummy use to the schema to force the array into existence.
Not exactly elegant, but it works.

I can see two blue moons in the schema before this patch.

In qapi/block-core.json:

    ##
    # @DummyBlockCoreForceArrays:
    #
    # Not used by QMP; hack to let us use BlockGraphInfoList internally
    #
    # Since: 8.0
    ##
    { 'struct': 'DummyBlockCoreForceArrays',
      'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }

It's called Dummy<NameOfModule>ForceArrays, it's at the end of the file,
and it collects all the arrays being forced into existence.

In qapi/machine.json:

    ##
    # @DummyForceArrays:
    #
    # Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
    # internally
    #
    # Since: 2.5
    ##
    { 'struct': 'DummyForceArrays',
      'data': { 'unused': ['X86CPUFeatureWordInfo'] } }

Less good: it has a clash-prone name, and it's not at the end of the
file.  It was the first use of this trick, and we still had a single
schema file back then.

I recommend you do yours just like the first one.

>> My comment is mostly intended to stop someone from removing this
>> "unused" type from the schema though. If there is a better way to do
>> that I can do that instead.
>
> Won't the QAPI generator or the compiler stop them soon enough?

The compiler would.


