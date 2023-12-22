Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7702D81C828
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 11:32:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcoN-00056T-84; Fri, 22 Dec 2023 05:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcoL-00056K-9C
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcoJ-00076g-1e
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703241078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LtSSYAC9hi5orf2iPYDm15PSLc1TjlMP9GRMWY7DEgY=;
 b=YWjtbpMG7mEAkJNt/4ilCdkqE2ijTEUoL6yCZ6HqdDnYygDXJVz+P3LT6/Zn5gRJ8LXSdI
 QXZbetoSVo13znYi72pugYCWa0rDmD67qK8xz3MQoA2iaouXKVp6S1hvzh7Z4ElUrpRoVn
 El5OjV9uKFu1TXTLdcpiWVzxsUR2gtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-edtKAMGDNICdyXoynSV9zg-1; Fri, 22 Dec 2023 05:31:14 -0500
X-MC-Unique: edtKAMGDNICdyXoynSV9zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D84C101AA49;
 Fri, 22 Dec 2023 10:31:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8522F2166B35;
 Fri, 22 Dec 2023 10:31:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7EB1D21E6920; Fri, 22 Dec 2023 11:31:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P . =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Eric Blake
 <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH for-9.0] qapi: Add 'recurse-children' option to qom-list
In-Reply-To: <20231124162443.124654-1-berto@igalia.com> (Alberto Garcia's
 message of "Fri, 24 Nov 2023 17:24:43 +0100")
References: <20231124162443.124654-1-berto@igalia.com>
Date: Fri, 22 Dec 2023 11:31:12 +0100
Message-ID: <878r5mv89b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Alberto Garcia <berto@igalia.com> writes:

> This allows returning a tree of all object properties under a given
> path, in a way similar to scripts/qmp/qom-tree.

Use case?  We already have that script, and also HMP info qom-tree.

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qapi/qom.json      | 10 +++++++++-
>  qom/qom-hmp-cmds.c |  4 ++--
>  qom/qom-qmp-cmds.c | 22 +++++++++++++++++++++-
>  3 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c53ef978ff..dfe3a20725 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -33,6 +33,10 @@
>  #        qdev device type name.  Link properties form the device model
>  #        graph.
>  #
> +# @children: if specified, a list of @ObjectPropertyInfo describing

Suggest "if present".

> +#     the child properties. This requires that this property's @type
> +#     is of the form 'child<subtype>' (since 9.0)

But when will it be present?

In qom-list-properties's return value: never.

In qom-list's return value: if and only if passed recurse-children=true.

Awkward to document.

> +#
>  # @description: if specified, the description of the property.
>  #
>  # @default-value: the default value, if any (since 5.0)
> @@ -42,6 +46,7 @@
>  { 'struct': 'ObjectPropertyInfo',
>    'data': { 'name': 'str',
>              'type': 'str',
> +            '*children' :  [ 'ObjectPropertyInfo' ],
>              '*description': 'str',
>              '*default-value': 'any' } }
>  
> @@ -54,6 +59,9 @@
>  # @path: the path within the object model.  See @qom-get for a
>  #     description of this parameter.
>  #
> +# @recurse-children: if true, include the child properties recursively
> +#     in the return value (default: false) (since 9.0)

Insufficiently clear on the connection to ObjectPropertyInfo member
@children, I'm afraid.

> +#
>  # Returns: a list of @ObjectPropertyInfo that describe the properties
>  #     of the object.
>  #
> @@ -69,7 +77,7 @@
>  #                  { "name": "mon0", "type": "child<chardev-stdio>" } ] }
>  ##
>  { 'command': 'qom-list',
> -  'data': { 'path': 'str' },
> +  'data': { 'path': 'str', '*recurse-children': 'bool' },
>    'returns': [ 'ObjectPropertyInfo' ],
>    'allow-preconfig': true }
>  

[...]


