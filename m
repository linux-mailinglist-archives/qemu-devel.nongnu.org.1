Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 499017113B4
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FjD-0006sj-Q0; Thu, 25 May 2023 14:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2Fj1-0006sH-MO
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2Fiz-0002X2-Qi
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685039408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MpC4P43HJGfyt3jUOilL3+PuFA3yzzQ8ABWXheZoCxg=;
 b=WuskJdxGf6QxAlPXGWSYSYDQxUPxi8WHZuHxdiJxo5h4GBLShgNK+C3vzUckLPvEbq37r7
 oOJYzZroZ/HUg6dD/OS0vRtAuyrYadROe30vpBoP9F7pHETYj2AUZ5gozM7cVFPfbo93y3
 fA3xiWJIfh09V/sImB9/AXe4nxGGOps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-eaj_YzhKPHKPDgJDRSv8hQ-1; Thu, 25 May 2023 14:30:05 -0400
X-MC-Unique: eaj_YzhKPHKPDgJDRSv8hQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C5FD858F1C;
 Thu, 25 May 2023 18:30:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE1CB492B0E;
 Thu, 25 May 2023 18:30:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D149521E692E; Thu, 25 May 2023 20:30:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jonathon Jongsma <jjongsma@redhat.com>,  qemu-devel@nongnu.org,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  sgarzare@redhat.com
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd
 passing for virtio-blk
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
 <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
 <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
 <20230517143023.GA65838@fedora>
Date: Thu, 25 May 2023 20:30:03 +0200
In-Reply-To: <20230517143023.GA65838@fedora> (Stefan Hajnoczi's message of
 "Wed, 17 May 2023 10:30:23 -0400")
Message-ID: <87edn4i7ro.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, May 17, 2023 at 09:19:26AM +0200, Stefano Garzarella wrote:
>> CCing Markus for some advice.
>> 
>> On Tue, May 16, 2023 at 11:04:21AM -0500, Jonathon Jongsma wrote:

[...]

>> > I need some way to determine that the particular qemu binary can accept
>> > a /dev/fdset/ path for vdpa block devices. libvirt uses a variety of
>> > methods to determine capabilities for a given qemu binary, including
>> > querying the qmp schema, commands, object types, specific device/object
>> > properties, etc. For example, right now I can determine (via querying
>> > the qmp schema) whether virtio-blk-vhost-vdpa is a valid type for the
>> > blockdev-add command by querying the qmp schema. I need something more
>> > than that but I'm not sure how to do it without introducing a separate
>> > 'fd' parameter. Any ideas?
>> 
>> The only thing I can think of is to make a mix between v2 and v3. I mean add
>> both the new `fd` parameter, and support qemu_open() on `path`.
>> 
>> That way libvirt (or other users) can check that fd passing is supported and
>> use `fd` or fdset with `path`.
>> 
>> Obviously I would have liked to implement only one of the two methods, but
>> if this helps, maybe it makes sense to support both.
>> 
>> What do you think?
>
> Markus: Is a preferred way to make this new path handling behavior
> introspectable? I vaguely remember a way for QMP clients to query
> strings that describe QMP behavior that's not otherwise
> introspectable...

Let me try to answer this without first reading the entire thread.

QMP introspection lets you find out things like whether a command is
there, or whether an an argument is there, and what its type is.
Suffices most of the time.

However, behavior can certainly change while the introspection data
remains the same.  When a management application needs to know about the
change, we better expose the change in introspection somehow.

The "obvious" way to do that would be some arbitrary change that *is*
visible in introspection.  Meh.

The modern way is to add a suitable "feature".
docs/devel/qapi-code-gen.rst:

    Features
    --------

    Syntax::

        FEATURES = [ FEATURE, ... ]
        FEATURE = STRING
                | { 'name': STRING, '*if': COND }

    Sometimes, the behaviour of QEMU changes compatibly, but without a
    change in the QMP syntax (usually by allowing values or operations
    that previously resulted in an error).  QMP clients may still need to
    know whether the extension is available.

    For this purpose, a list of features can be specified for definitions,
    enumeration values, and struct members.  Each feature list member can
    either be ``{ 'name': STRING, '*if': COND }``, or STRING, which is
    shorthand for ``{ 'name': STRING }``.

    The optional 'if' member specifies a conditional.  See `Configuring
    the schema`_ below for more on this.

    Example::

     { 'struct': 'TestType',
       'data': { 'number': 'int' },
       'features': [ 'allow-negative-numbers' ] }

    The feature strings are exposed to clients in introspection, as
    explained in section `Client JSON Protocol introspection`_.

    Intended use is to have each feature string signal that this build of
    QEMU shows a certain behaviour.

For a real example, see commit c6bdc312f30 (qapi: Add
'@allow-write-only-overlay' feature for 'blockdev-snapshot').

Does this answer your question?


