Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A04EFABD01B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 09:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHH86-0007zY-Fu; Tue, 20 May 2025 03:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHH82-0007z5-Mb
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHH80-0001Hl-Mu
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747725066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z55vX8bASXN2Yrv/x7z0lzsPH8dfoLgsfXACYZZuEKg=;
 b=BlZ9zkA0JsjwvBwHUePGvqzZJzKRIUyWspuoTN6grgdfDLbMEtSUdAxSGYzbfMDTSGYvAb
 6AkiQTckPxlRo48+6wWxE7tRLrRyj/wsZKM1g9rR76GIZOGXmOYPgXVxhdFY1G9A6FZK8S
 t49ScN8VLpIGmzzmogXgd1UpPQW4+vo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-FsXCJcrSMUqnkbpDo0NXXw-1; Tue,
 20 May 2025 03:11:02 -0400
X-MC-Unique: FsXCJcrSMUqnkbpDo0NXXw-1
X-Mimecast-MFC-AGG-ID: FsXCJcrSMUqnkbpDo0NXXw_1747725061
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02781180045C; Tue, 20 May 2025 07:11:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D648C18004A7; Tue, 20 May 2025 07:10:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49EAF21E66C3; Tue, 20 May 2025 09:10:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  philmd@linaro.org,
 christian.boenig@lauterbach.com,  John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 04/20] qapi: Introduce MCD schema
In-Reply-To: <87msbnfjj0.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 08 May 2025 13:07:15 +0200")
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-5-mario.fleischmann@lauterbach.com>
 <87msbnfjj0.fsf@pond.sub.org>
Date: Tue, 20 May 2025 09:10:57 +0200
Message-ID: <87sekzdaf2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>
>> The MCD implementation follows a remote procedure call approach:
>> Each function from mcd_api.h will correspond to one command in mcd.json.
>>
>> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>> ---
>>  MAINTAINERS          |  1 +
>>  docs/interop/mcd.rst | 13 +++++++++++++
>>  mcd/meson.build      | 27 +++++++++++++++++++++++++++
>>  qapi/mcd.json        |  6 ++++++
>>  4 files changed, 47 insertions(+)
>>  create mode 100644 qapi/mcd.json
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 327d3c5..7c085dc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3125,6 +3125,7 @@ M: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>>  S: Maintained
>>  F: mcd/*
>>  F: docs/interop/mcd.rst
>> +F: qapi/mcd.json
>>  
>>  Memory API
>>  M: Paolo Bonzini <pbonzini@redhat.com>
>> diff --git a/docs/interop/mcd.rst b/docs/interop/mcd.rst
>> index 2b21303..13e81df 100644
>> --- a/docs/interop/mcd.rst
>> +++ b/docs/interop/mcd.rst
>> @@ -44,6 +44,19 @@ To configure the build for MCD support:
>>  
>>    ./configure --enable-mcd
>>  
>> +Debugging via QAPI
>> +------------------
>> +
>> +Since the MCD API does not define a communication protocol, a QAPI schema
>> +has been added to implement a remote procedure call mechanism.
>> +Each function within the API corresponds to one QAPI command, ensuring a
>> +one-to-one mapping between the API's functions and the QAPI commands.
>> +
>> +QAPI Reference
>> +--------------
>> +
>> +.. qapi-doc:: qapi/mcd.json
>
> You also need
>
>       :transmogrify:
>
> because we haven't completed the transition to John Snow's new doc
> generator ("transmogrifier"), and
>
>       :namespace: MCD
>
> for a properly separate namespace (see docs/devel/qapi-domain.rst).
>
> I'd expect this to generate its own index, but it doesn't.  John, can
> you have a look?

John has since reminded me of the need to add it to docs/conf.py.
Together, this generates docs/manual/qapi-mcd-index.html.  You need to
link to it manually.  Sketch appended for you convenience.

>> +
>>  API Reference
>>  -------------
>>  
>> diff --git a/mcd/meson.build b/mcd/meson.build
>> index 3e4e67a..d62a625 100644
>> --- a/mcd/meson.build
>> +++ b/mcd/meson.build
>> @@ -1,5 +1,32 @@
>> +mcd_qapi_outputs = [
>> +  'mcd-qapi-commands.c',
>> +  'mcd-qapi-commands.h',
>> +  'mcd-qapi-emit-events.c',
>> +  'mcd-qapi-emit-events.h',
>> +  'mcd-qapi-events.c',
>> +  'mcd-qapi-events.h',
>> +  'mcd-qapi-features.c',
>> +  'mcd-qapi-features.h',
>> +  'mcd-qapi-init-commands.c',
>> +  'mcd-qapi-init-commands.h',
>> +  'mcd-qapi-introspect.c',
>> +  'mcd-qapi-introspect.h',
>> +  'mcd-qapi-types.c',
>> +  'mcd-qapi-types.h',
>> +  'mcd-qapi-visit.c',
>> +  'mcd-qapi-visit.h',
>> +]
>> +
>> +mcd_qapi_files = custom_target('MCD QAPI files',
>> +                               output: mcd_qapi_outputs,
>> +                               input: '../qapi/mcd.json',
>> +                               command: [ qapi_gen, '-p', 'mcd-', '-o', 'mcd',
>> +                                          '--suppress-tracing','@INPUT0@'],
>> +                               depend_files: qapi_gen_depends)
>> +
>>  mcd_ss = ss.source_set()
>>  
>> +mcd_ss.add(mcd_qapi_files.to_list())
>>  mcd_ss.add(files(
>>    'mcd_server.c'))
>>  
>> diff --git a/qapi/mcd.json b/qapi/mcd.json
>> new file mode 100644
>> index 0000000..701fd03
>> --- /dev/null
>> +++ b/qapi/mcd.json
>
> Let's use mcd/qapi-schema.json, similar to the other independent QAPI
> schemas, such as qga/qapi-schema.json.
>
>> @@ -0,0 +1,6 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=python
>> +
>> +##
>> +# = Multi-Core Debug (MCD) API
>> +##

diff --git a/docs/conf.py b/docs/conf.py
index f892a6e1da..9b57fb2ee6 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -201,6 +201,7 @@
 # Due to a limitation in Sphinx, we need to know which indices to
 # generate in advance. Adding a namespace here allows that generation.
 qapi_namespaces = {
+    "MCD",
     "QGA",
     "QMP",
     "QSD",
diff --git a/docs/interop/mcd.rst b/docs/interop/mcd.rst
index 860fa8d20f..eb02839e19 100644
--- a/docs/interop/mcd.rst
+++ b/docs/interop/mcd.rst
@@ -58,6 +58,8 @@ QAPI Reference
 --------------
 
 .. qapi-doc:: qapi/mcd.json
+   :transmogrify:
+   :namespace: MCD
 
 API Reference
 -------------
diff --git a/qapi/mcd.json b/qapi/mcd.json
index b90cdfab03..4f0d36c8f1 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -3,6 +3,8 @@
 
 ##
 # = Multi-Core Debug (MCD) API
+#
+# For locating a particular item, please see the `qapi-mcd-index`.
 ##
 
 


