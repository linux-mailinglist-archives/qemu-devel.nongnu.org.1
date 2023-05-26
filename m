Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD76712831
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YNs-0002LY-Ul; Fri, 26 May 2023 10:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YNk-0002LI-3F
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YNg-00083f-3Z
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685111120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xc4DP/JvzQ499xNwd6vMrZsSWLEBdjn/kZDkL65kpFc=;
 b=X2MVHt/SgVs8lL2G9b3MoyUSF2NUN3cwJ7CjzbR6qrYpKl1xE66PpfPHaoDyB5+AIlbWtY
 fuHNsdQZ574ELbyLfIDkJrLT38Cs7cfj3psMp+Kr5mCGDz840yPhY4PI3HvTfnRFvwG9Dy
 /U/Ouf/1UIIGZ9w1qZkKP4wVyuOHrWI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Oy0eE1KROQC5z4xDU7bkag-1; Fri, 26 May 2023 10:25:19 -0400
X-MC-Unique: Oy0eE1KROQC5z4xDU7bkag-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62609400a3bso9854356d6.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 07:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685111119; x=1687703119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xc4DP/JvzQ499xNwd6vMrZsSWLEBdjn/kZDkL65kpFc=;
 b=aGMLFTuspxYTjaQLHqmPzFfU3B9aA6ouzMlLLBuP+ImuihH4YW8oMyUvMavKTXy3Av
 7DjWCKmjorPs2gqk+ua3IdnPsSmrAzrizJBhBbuVoGT83cJk54UYTW6+nXS9SzExXbvX
 WDCTwfnL9vKd/gTealg2o5B7YOfr7aYZ+qWpUG4Y64QvpLQI1wkAkbe5e4LpPIj8nY2H
 tzul6Wds/5d4ikaBYmuH9o5Pi5lPb8ZtysBh/mVkoXeg9PAbSk/KYmDihEHRrQ5OeFHO
 Ba6Z339wwERn8LpDdUYUPrWVpM5IaDhgFJkueyVM+2ediudl+W0qvjwW+TK/BKL+mhTR
 oUbA==
X-Gm-Message-State: AC+VfDxNAl2HhQvpGEs3Cbd77Si+ZTxk/6Th5re0GymueYOOuuqA9eWT
 B4foKAdHGSuBa3E4HlCkQDQBz6xm64Z7pVcNhNAnA0u9FdJiSqp8gyUaDsfsWF5yyjyV1JWn1rO
 QkbgbjuCs5c9e5ZU=
X-Received: by 2002:ad4:5ce6:0:b0:5e0:7ecb:8ffa with SMTP id
 iv6-20020ad45ce6000000b005e07ecb8ffamr2917678qvb.1.1685111119230; 
 Fri, 26 May 2023 07:25:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6p512T4AznHiBgBDFiKeDgDoC9elB/JABjhvbC8GLfP9r3Yz/Zb1t5byhZCrqlJfa2R/GM2g==
X-Received: by 2002:ad4:5ce6:0:b0:5e0:7ecb:8ffa with SMTP id
 iv6-20020ad45ce6000000b005e07ecb8ffamr2917646qvb.1.1685111118903; 
 Fri, 26 May 2023 07:25:18 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 cw13-20020ad44dcd000000b0061c7431810esm1209089qvb.141.2023.05.26.07.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 07:25:18 -0700 (PDT)
Date: Fri, 26 May 2023 16:25:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Jonathon Jongsma <jjongsma@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd
 passing for virtio-blk
Message-ID: <wa56lazeo4z244ueqzsmxiblacsngva4v4u6xg75nkwvwmp5cm@q54l3ojc2y7c>
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
 <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
 <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
 <20230517143023.GA65838@fedora> <87edn4i7ro.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87edn4i7ro.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 25, 2023 at 08:30:03PM +0200, Markus Armbruster wrote:
>Stefan Hajnoczi <stefanha@redhat.com> writes:
>
>> On Wed, May 17, 2023 at 09:19:26AM +0200, Stefano Garzarella wrote:
>>> CCing Markus for some advice.
>>>
>>> On Tue, May 16, 2023 at 11:04:21AM -0500, Jonathon Jongsma wrote:
>
>[...]
>
>>> > I need some way to determine that the particular qemu binary can accept
>>> > a /dev/fdset/ path for vdpa block devices. libvirt uses a variety of
>>> > methods to determine capabilities for a given qemu binary, including
>>> > querying the qmp schema, commands, object types, specific device/object
>>> > properties, etc. For example, right now I can determine (via querying
>>> > the qmp schema) whether virtio-blk-vhost-vdpa is a valid type for the
>>> > blockdev-add command by querying the qmp schema. I need something more
>>> > than that but I'm not sure how to do it without introducing a separate
>>> > 'fd' parameter. Any ideas?
>>>
>>> The only thing I can think of is to make a mix between v2 and v3. I mean add
>>> both the new `fd` parameter, and support qemu_open() on `path`.
>>>
>>> That way libvirt (or other users) can check that fd passing is supported and
>>> use `fd` or fdset with `path`.
>>>
>>> Obviously I would have liked to implement only one of the two methods, but
>>> if this helps, maybe it makes sense to support both.
>>>
>>> What do you think?
>>
>> Markus: Is a preferred way to make this new path handling behavior
>> introspectable? I vaguely remember a way for QMP clients to query
>> strings that describe QMP behavior that's not otherwise
>> introspectable...
>
>Let me try to answer this without first reading the entire thread.
>
>QMP introspection lets you find out things like whether a command is
>there, or whether an an argument is there, and what its type is.
>Suffices most of the time.
>
>However, behavior can certainly change while the introspection data
>remains the same.  When a management application needs to know about the
>change, we better expose the change in introspection somehow.
>
>The "obvious" way to do that would be some arbitrary change that *is*
>visible in introspection.  Meh.
>
>The modern way is to add a suitable "feature".
>docs/devel/qapi-code-gen.rst:
>
>    Features
>    --------
>
>    Syntax::
>
>        FEATURES = [ FEATURE, ... ]
>        FEATURE = STRING
>                | { 'name': STRING, '*if': COND }
>
>    Sometimes, the behaviour of QEMU changes compatibly, but without a
>    change in the QMP syntax (usually by allowing values or operations
>    that previously resulted in an error).  QMP clients may still need to
>    know whether the extension is available.
>
>    For this purpose, a list of features can be specified for definitions,
>    enumeration values, and struct members.  Each feature list member can
>    either be ``{ 'name': STRING, '*if': COND }``, or STRING, which is
>    shorthand for ``{ 'name': STRING }``.
>
>    The optional 'if' member specifies a conditional.  See `Configuring
>    the schema`_ below for more on this.
>
>    Example::
>
>     { 'struct': 'TestType',
>       'data': { 'number': 'int' },
>       'features': [ 'allow-negative-numbers' ] }
>
>    The feature strings are exposed to clients in introspection, as
>    explained in section `Client JSON Protocol introspection`_.
>
>    Intended use is to have each feature string signal that this build of
>    QEMU shows a certain behaviour.
>
>For a real example, see commit c6bdc312f30 (qapi: Add
>'@allow-write-only-overlay' feature for 'blockdev-snapshot').
>
>Does this answer your question?
>

Yep, this is exactly what we needed. Thank you very much!

I'll send v4 adding `features` to the `path` member, and I'll check the
version library in meson.build to enable the feature only when the
vhost-vdpa driver in libblkio really supports it, so libvirt can be sure
that if the feature is there, the fd passing will work.

Stefano


