Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DEA7983CC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWbv-000384-8N; Fri, 08 Sep 2023 04:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeWbs-00037v-08
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeWbo-0002R9-6N
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694160775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbsFsggWbDakEUIvr42t2TF5D6ROOaKwZaHAEJi/waI=;
 b=CsFeauUIZTf7l0lGw3SVZZuPvnoI406ZgdjQiftyj9BEBwWE2OyH1o6aNeBicni0J7HeI5
 vUdGiApPD9R59qPyCjJ8lcFX5ZaxcFr962gc3gjo+Okdu8TyJu87N0AlLB5SOWt9FWCx5J
 oGsKoGRhlq3WYWv5WDma4/KEAXI6MEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-owx643pANbyRCu_G52Vz8w-1; Fri, 08 Sep 2023 04:12:54 -0400
X-MC-Unique: owx643pANbyRCu_G52Vz8w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D87D6856DED
 for <qemu-devel@nongnu.org>; Fri,  8 Sep 2023 08:12:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21E69493110;
 Fri,  8 Sep 2023 08:12:53 +0000 (UTC)
Date: Fri, 8 Sep 2023 09:12:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 1/7] qapi: scripts: add a generator for qapi's examples
Message-ID: <ZPrXg36lLYrLQ23Q@redhat.com>
References: <20230905194846.169530-1-victortoso@redhat.com>
 <20230905194846.169530-2-victortoso@redhat.com>
 <ZPhDSD+qn66GmS0i@redhat.com>
 <smjkujz2ogjqma2gfoznpaziiwvnjhdep4na2cyifwr3ipnhcn@3wckktjnad2w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <smjkujz2ogjqma2gfoznpaziiwvnjhdep4na2cyifwr3ipnhcn@3wckktjnad2w>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Thu, Sep 07, 2023 at 08:34:07PM +0200, Victor Toso wrote:
> Hi,
> 
> On Wed, Sep 06, 2023 at 10:15:52AM +0100, Daniel P. Berrangé wrote:
> > On Tue, Sep 05, 2023 at 09:48:40PM +0200, Victor Toso wrote:
> > > This generator has two goals:
> > >  1. Mechanical validation of QAPI examples
> > >  2. Generate the examples in a JSON format to be consumed for extra
> > >     validation.
> > > 
> > > The generator iterates over every Example section, parsing both server
> > > and client messages. The generator prints any inconsistency found, for
> > > example:
> > > 
> > >  |  Error: Extra data: line 1 column 39 (char 38)
> > >  |  Location: cancel-vcpu-dirty-limit at qapi/migration.json:2017
> > >  |  Data: {"execute": "cancel-vcpu-dirty-limit"},
> > >  |      "arguments": { "cpu-index": 1 } }
> > > 
> > > The generator will output other JSON file with all the examples in the
> > > QAPI module that they came from. This can be used to validate the
> > > introspection between QAPI/QMP to language bindings, for example:
> > > 
> > >  | { "examples": [
> > >  |   {
> > >  |     "id": "ksuxwzfayw",
> > >  |     "client": [
> > >  |     {
> > >  |       "sequence-order": 1
> > >  |       "message-type": "command",
> > >  |       "message":
> > >  |       { "arguments":
> > >  |         { "device": "scratch", "size": 1073741824 },
> > >  |         "execute": "block_resize"
> > >  |       },
> > >  |    } ],
> > >  |    "server": [
> > >  |    {
> > >  |      "sequence-order": 2
> > >  |      "message-type": "return",
> > >  |      "message": { "return": {} },
> > >  |    } ]
> > >  |    }
> > >  |  ] }
> > > 
> > > Note that the order matters, as read by the Example section and
> > > translated into "sequence-order". A language binding project can then
> > > consume this files to Marshal and Unmarshal, comparing if the results
> > > are what is to be expected.
> > > 
> > > RFC discussion:
> > >     https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04641.html
> > > 
> > > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > > ---
> > >  scripts/qapi/dumpexamples.py | 194 +++++++++++++++++++++++++++++++++++
> > >  scripts/qapi/main.py         |   2 +
> > >  2 files changed, 196 insertions(+)
> > >  create mode 100644 scripts/qapi/dumpexamples.py
> > > 
> > > diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
> > > new file mode 100644
> > > index 0000000000..c14ed11774
> > > --- /dev/null
> > > +++ b/scripts/qapi/dumpexamples.py
> > > @@ -0,0 +1,194 @@
> > > +"""
> > > +Dump examples for Developers
> > > +"""
> > > +# Copyright (c) 2022 Red Hat Inc.
> > > +#
> > > +# Authors:
> > > +#  Victor Toso <victortoso@redhat.com>
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version 2.
> > > +# See the COPYING file in the top-level directory.
> > > +
> > > +# Just for type hint on self
> > > +from __future__ import annotations
> > > +
> > > +import os
> > > +import json
> > > +import random
> > > +import string
> > > +
> > > +from typing import Dict, List, Optional
> > > +
> > > +from .schema import (
> > > +    QAPISchema,
> > > +    QAPISchemaType,
> > > +    QAPISchemaVisitor,
> > > +    QAPISchemaEnumMember,
> > > +    QAPISchemaFeature,
> > > +    QAPISchemaIfCond,
> > > +    QAPISchemaObjectType,
> > > +    QAPISchemaObjectTypeMember,
> > > +    QAPISchemaVariants,
> > > +)
> > > +from .source import QAPISourceInfo
> > > +
> > > +
> > > +def gen_examples(schema: QAPISchema,
> > > +                 output_dir: str,
> > > +                 prefix: str) -> None:
> > > +    vis = QAPISchemaGenExamplesVisitor(prefix)
> > > +    schema.visit(vis)
> > > +    vis.write(output_dir)
> > > +
> > > +
> > > +def get_id(random, size: int) -> str:
> > > +    letters = string.ascii_lowercase
> > > +    return ''.join(random.choice(letters) for i in range(size))
> > > +
> > > +
> > > +def next_object(text, start, end, context) -> Dict:
> > > +    # Start of json object
> > > +    start = text.find("{", start)
> > > +    end = text.rfind("}", start, end+1)
> > > +
> > > +    # try catch, pretty print issues
> > > +    try:
> > > +        ret = json.loads(text[start:end+1])
> > > +    except Exception as e:
> > > +        print("Error: {}\nLocation: {}\nData: {}\n".format(
> > > +              str(e), context, text[start:end+1]))
> > 
> > This prints an error, but the caller ignores this and carries on
> > as normal.
> > 
> > After applying this series, we still have multiple errors being
> > printed on console
> 
> The first one is a easy to fix error. The other two are more
> related to metadata inserted in valid examples, see:
> 
> > Error: Expecting ',' delimiter: line 12 column 19 (char 336)
> > Location: query-blockstats at ../storage-daemon/qapi/../../qapi/block-core.json:1259
> 
> Indeed.
>  
> > Error: Expecting property name enclosed in double quotes: line 7 column 19 (char 264)
> > Location: query-rocker-of-dpa-flows at ../qapi/rocker.json:256
> 
>     251 #                   "mask": {"in-pport": 4294901760}
>     252 #                  },
>  -> 253 #                  {...more...},
>     254 #    ]}
> 
> > 
> > Error: Expecting value: line 28 column 15 (char 775)
> > Location: query-spice at ../qapi/ui.json:372
> 
>     365 #                "tls": false
>     366 #             },
>  -> 367 #             [ ... more channels follow ... ]
>     368 #          ]
> 
> It would be good to have some sort of annotation for a valid
> example, to express this is a long list and we are not putting
> all of it here.

The second example already has 2 elements in the list, which
i think is sufficient illustration of "many" records.

The first example could just have a 2nd element added to its
returned list too I reckon

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


