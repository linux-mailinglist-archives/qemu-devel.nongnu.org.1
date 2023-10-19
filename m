Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB07CF012
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 08:28:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtMVE-0008R8-Pj; Thu, 19 Oct 2023 02:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtMV9-0008Pc-11
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtMV4-00005z-DT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697696837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76tVPgaGbG3IOE03a5SQs52Dd7dlwB3sKqsypgM3u6o=;
 b=ScfBorru6+f1MMQqVuWmFJ+dnuOUMhmU07MuqePIEeV7NZ7brQyYNizX0hR6ag9FCDwfXg
 f6MFIMjKtuKMa1bLWAeRfzBomIexmM6yEbToey3i7azD77BXz8q90SY7ZOPjtOhuVCxPt3
 /zw2IyrdASqry6P9NoyIH4FS0hCmpHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-QD4cz6mNNxeYlPtnbBs_NQ-1; Thu, 19 Oct 2023 02:27:00 -0400
X-MC-Unique: QD4cz6mNNxeYlPtnbBs_NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A939185A795
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:27:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7C691C060AE
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:26:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD5BF21E6A1F; Thu, 19 Oct 2023 08:26:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 10/10] qapi: scripts: add a generator for qapi's
 examples
References: <20230919201857.675913-1-victortoso@redhat.com>
 <20230919201857.675913-11-victortoso@redhat.com>
 <87o7hv7ply.fsf@pond.sub.org>
 <gfsdkqobnul2i6mgfwe2w3pwtvjf3db34ntpo3oo253eh6gyqe@5gc25wboaocl>
Date: Thu, 19 Oct 2023 08:26:58 +0200
In-Reply-To: <gfsdkqobnul2i6mgfwe2w3pwtvjf3db34ntpo3oo253eh6gyqe@5gc25wboaocl>
 (Victor Toso's message of "Wed, 18 Oct 2023 21:35:41 +0200")
Message-ID: <87r0lrktzh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Victor Toso <victortoso@redhat.com> writes:

> Hi Markus,
>
> Sorry the delay on reply here.
>
> On Thu, Sep 21, 2023 at 01:06:01PM +0200, Markus Armbruster wrote:
>> Victor Toso <victortoso@redhat.com> writes:
>> 
>> > This generator has two goals:
>> >  1. Mechanical validation of QAPI examples
>> >  2. Generate the examples in a JSON format to be consumed for extra
>> >     validation.
>> >
>> > The generator iterates over every Example section, parsing both server
>> > and client messages. The generator prints any inconsistency found, for
>> > example:
>> >
>> >  |  Error: Extra data: line 1 column 39 (char 38)
>> >  |  Location: cancel-vcpu-dirty-limit at qapi/migration.json:2017
>> >  |  Data: {"execute": "cancel-vcpu-dirty-limit"},
>> >  |      "arguments": { "cpu-index": 1 } }
>> 
>> What language does it parse?
>
> It parsers the Example section. Fetches client and server JSON
> messages. Validate them.
>
>> Can you give a grammar?
>
> Not sure if needed? I just fetch the json from the example
> section and validate it.

The C++ parser just fetches the code from the text file and compiles it
:)

There are way too many parsers out there that show signs of "I'm not
parsing / I don't to nail down the language" delusions.

Let's start with an informal description of the language.

An example is a sequence of QMP input, QMP output, and explanatory text.

QMP input / output is a sequence of lines where the first one starts
with "<- " / "-> ", and the remaining ones start with " ".

Lines that are not QMP input / output are explanatory text.

>> Should the parser be integrated into the doc parser, i.e. class QAPIDoc?
>
> Yes, that would be better. I'll try that in the next iteration.
>
>> > The generator will output other JSON file with all the examples in the
>> 
>> Another JSON file, or other JSON files?
>
> JSON files. QEMU'S QAPI qapi/migration.json will generate a
> migration.json with the format mentioned bellow.
>> 
>> > QAPI module that they came from. This can be used to validate the
>> > introspection between QAPI/QMP to language bindings, for example:
>> >
>> >  | { "examples": [
>> >  |   {
>> >  |     "id": "ksuxwzfayw",
>> >  |     "client": [
>> >  |     {
>> >  |       "sequence-order": 1
>> 
>> Missing comma
>> 
>> >  |       "message-type": "command",
>> >  |       "message":
>> >  |       { "arguments":
>> >  |         { "device": "scratch", "size": 1073741824 },
>> >  |         "execute": "block_resize"
>> >  |       },
>> >  |    } ],
>> >  |    "server": [
>> >  |    {
>> >  |      "sequence-order": 2
>> 
>> Another one.
>> 
>> >  |      "message-type": "return",
>> >  |      "message": { "return": {} },
>> 
>> Extra comma.
>> 
>> >  |    } ]
>> >  |    }
>> >  |  ] }
>> 
>> Indentation is kind of weird.
>
> The missing comma was likely my fault on copy & paste.  The
> indentation should be what json.dumps() provides, but I think I
> changed somehow in the git log too.
>  
>> The JSON's Valid structure and semantics are not documented.
>> We've developed a way specify that, you might've heard of it,
>> it's called "QAPI schema" ;-P
>> 
>> Kidding aside, we've done this before.  E.g. docs/interop/firmware.json
>> specifies firmware descriptors.  We have some in pc-bios/descriptors/.
>
> Oh, that's neat. You meant to use QAPI schema as a way to
> document output from examples.py?

Exactly!

>> > Note that the order matters, as read by the Example section and
>> > translated into "sequence-order". A language binding project can then
>> > consume this files to Marshal and Unmarshal, comparing if the results
>> > are what is to be expected.
>> >
>> > RFC discussion:
>> >     https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04641.html
>> >
>> > Signed-off-by: Victor Toso <victortoso@redhat.com>
>> > ---
>> >  scripts/qapi/dumpexamples.py | 208 +++++++++++++++++++++++++++++++++++
>> >  scripts/qapi/main.py         |   3 +-
>> >  2 files changed, 210 insertions(+), 1 deletion(-)
>> >  create mode 100644 scripts/qapi/dumpexamples.py
>> >
>> > diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
>> > new file mode 100644
>> > index 0000000000..55d9f13ab7
>> > --- /dev/null
>> > +++ b/scripts/qapi/dumpexamples.py
>> 
>> Let's name this examples.py.  It already does a bit more than
>> dump (namely validate), and any future code dealing with
>> examples will likely go into this file.
>
> Ack.
>
>> > @@ -0,0 +1,208 @@
>> > +"""
>> > +Dump examples for Developers
>> > +"""
>> > +# Copyright (c) 2023 Red Hat Inc.
>> > +#
>> > +# Authors:
>> > +#  Victor Toso <victortoso@redhat.com>
>> > +#
>> > +# This work is licensed under the terms of the GNU GPL, version 2.
>> 
>> We should've insisted on v2+ for the QAPI generator back when we had a
>> chance.  *Sigh*
>
> :)
>  
>> > +# See the COPYING file in the top-level directory.
>> > +
>> > +# Just for type hint on self
>> > +from __future__ import annotations
>> > +
>> > +import os
>> > +import json
>> > +import random
>> > +import string
>> > +
>> > +from typing import Dict, List, Optional
>> > +
>> > +from .schema import (
>> > +    QAPISchema,
>> > +    QAPISchemaType,
>> > +    QAPISchemaVisitor,
>> > +    QAPISchemaEnumMember,
>> > +    QAPISchemaFeature,
>> > +    QAPISchemaIfCond,
>> > +    QAPISchemaObjectType,
>> > +    QAPISchemaObjectTypeMember,
>> > +    QAPISchemaVariants,
>> 
>> pylint warns
>> 
>>     scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaEnumMember imported from schema (unused-import)
>>     scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaObjectTypeMember imported from schema (unused-import)
>>     scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaVariants imported from schema (unused-import)
>
> Yes, now I learned a few tricks around python linters and
> formatting. Next iteration will be better.
>  
>> > +)
>> > +from .source import QAPISourceInfo
>> > +
>> > +
>> > +def gen_examples(schema: QAPISchema,
>> > +                 output_dir: str,
>> > +                 prefix: str) -> None:
>> > +    vis = QAPISchemaGenExamplesVisitor(prefix)
>> > +    schema.visit(vis)
>> > +    vis.write(output_dir)
>> 
>> The other backends have this at the end of the file.  Either order
>> works, but consistency is nice.
>
> Ok.
>  
>> > +
>> > +
>> > +def get_id(random, size: int) -> str:
>> 
>> pylint warns
>> 
>>     scripts/qapi/dumpexamples.py:44:11: W0621: Redefining name
>>     'random' from outer scope (line 17) (redefined-outer-name)
>> 
>> > +    letters = string.ascii_lowercase
>> > +    return ''.join(random.choice(letters) for i in range(size))
>> > +
>> > +
>> > +def next_object(text, start, end, context) -> (Dict, bool):
>> > +    # Start of json object
>> > +    start = text.find("{", start)
>> > +    end = text.rfind("}", start, end+1)
>> 
>> Single quotes, please, for consistency with quote use elsewhere.
>> 
>> Rules of thumb:
>> 
>> * Double quotes for english text (e.g. error messages), so we don't have
>>   to escape apostrophes.
>> 
>> * Double quotes when they reduce the escaping
>> 
>> * Else single quotes
>> 
>> More elsewhere, not flagged.
>> 
>> > +
>> > +    # try catch, pretty print issues
>> 
>> Is this comment useful?
>
> I'll remove.
>  
>> > +    try:
>> > +        ret = json.loads(text[start:end+1])
>> > +    except Exception as e:
>> 
>> pylint warns
>> 
>>     scripts/qapi/dumpexamples.py:57:11: W0703: Catching too general exception Exception (broad-except)
>> 
>> Catch JSONDecodeError?
>
> Ack.
>
>> > +        print("Error: {}\nLocation: {}\nData: {}\n".format(
>> > +              str(e), context, text[start:end+1]))
>> 
>> Errors need to go to stderr.
>> 
>> Have you considered using QAPIError to report these errors?
>
> Did not cross my mind, no. I'll take a look.
>  
>> > +        return {}, True
>> > +    else:
>> > +        return ret, False
>> > +
>> > +
>> > +def parse_text_to_dicts(text: str, context: str) -> (List[Dict], bool):
>> 
>> Before I review the parser, I'd like to know the (intended) language
>> being parsed.
>
> Ok, I'll add documentation about it in the next iteration.
>  
>> > +    examples, clients, servers = [], [], []
>> > +    failed = False
>> > +
>> > +    count = 1
>> > +    c, s = text.find("->"), text.find("<-")
>> > +    while c != -1 or s != -1:
>> > +        if c == -1 or (s != -1 and s < c):
>> > +            start, target = s, servers
>> > +        else:
>> > +            start, target = c, clients
>> > +
>> > +        # Find the client and server, if any
>> > +        if c != -1:
>> > +            c = text.find("->", start + 1)
>> > +        if s != -1:
>> > +            s = text.find("<-", start + 1)
>> > +
>> > +        # Find the limit of current's object.
>> > +        # We first look for the next message, either client or server. If none
>> > +        # is avaible, we set the end of the text as limit.
>> > +        if c == -1 and s != -1:
>> > +            end = s
>> > +        elif c != -1 and s == -1:
>> > +            end = c
>> > +        elif c != -1 and s != -1:
>> > +            end = (c < s) and c or s
>> 
>> pylint advises
>> 
>>     scripts/qapi/dumpexamples.py:91:12: R1706: Consider using ternary (c if c < s else s) (consider-using-ternary)
>> 
>> > +        else:
>> > +            end = len(text) - 1
>> > +
>> > +        message, error = next_object(text, start, end, context)
>> > +        if error:
>> > +            failed = True
>> > +
>> > +        if len(message) > 0:
>> > +            message_type = "return"
>> > +            if "execute" in message:
>> > +                message_type = "command"
>> > +            elif "event" in message:
>> > +                message_type = "event"
>> > +
>> > +            target.append({
>> > +                "sequence-order": count,
>> > +                "message-type": message_type,
>> > +                "message": message
>> > +            })
>> > +            count += 1
>> > +
>> > +    examples.append({"client": clients, "server": servers})
>> > +    return examples, failed
>> > +
>> > +
>> > +def parse_examples_of(self: QAPISchemaGenExamplesVisitor,
>> 
>> Uh, shouldn't this be a method of QAPISchemaGenExamplesVisitor?
>
> Indeed.
>  
>> > +                      name: str):
>> > +
>> > +    assert(name in self.schema._entity_dict)
>> 
>> Makes both pycodestyle and pylint unhappy.  Better:
>> 
>>        assert name in self.schema._entity_dict
>> 
>> pylint warns
>> 
>>     scripts/qapi/dumpexamples.py:120:19: W0212: Access to a protected member _entity_dict of a client class (protected-access)
>> 
>> here and two more times below.
>
> Thanks, I'll have all of those fixed.
>  
>> > +    obj = self.schema._entity_dict[name]
>> > +
>> > +    if not obj.info.pragma.doc_required:
>> > +        return
>> > +
>> > +    assert((obj.doc is not None))
>> 
>> Better:
>> 
>>        assert obj.doc is not None
>> 
>> > +    module_name = obj._module.name
>> > +
>> > +    # We initialize random with the name so that we get consistent example
>> > +    # ids over different generations. The ids of a given example might
>> > +    # change when adding/removing examples, but that's acceptable as the
>> > +    # goal is just to grep $id to find what example failed at a given test
>> > +    # with minimum chorn over regenerating.
>> 
>> churn from?
>
> There is one id per example section. The idea of having an id is
> that, if a test failed, we can easily find what test failed.
>
> The comment tries to clarify that the goal is the id to be kept
> intact (hence, we seed from its name), reducing the churn over
> regenerating the output.

I'm not sure "over" is the correct preposition here.

[...]

>> I think before I dig deeper, we should discuss my findings so far.
>
> Yes, I think I agreed with mostly of your suggestions. I'm
> learning how to write proper python, so sorry that we saw many
> basic lint failures here.

No problem at all!  Such things only become a problem when people refuse
/ are unable to learn ;)

>> Here's my .pylintrc, in case you want to run pylint yourself:
>> 
>> disable=
>>     consider-using-f-string,
>>     fixme,
>>     invalid-name,
>>     missing-docstring,
>>     too-few-public-methods,
>>     too-many-arguments,
>>     too-many-branches,
>>     too-many-instance-attributes,
>>     too-many-lines,
>>     too-many-locals,
>>     too-many-statements,
>>     unused-argument,
>>     unused-wildcard-import,
>
> Thanks again for the review, I really appreciate it.

You're welcome!


