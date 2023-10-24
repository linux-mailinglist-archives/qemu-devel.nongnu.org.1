Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E432D7D470F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 07:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAJm-0000Fa-Gb; Tue, 24 Oct 2023 01:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvAJk-0000Ej-RM
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvAJj-0004Wj-D0
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698126662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIEgh4+XrKGTXbD0rYp5n8f8NMRgcTeK3GYAmLXqaeo=;
 b=K2mx7pfJN1o9aQQpru03cYcw1ZwGQ9Xd1zRsDXM/d71VP+38m8aX+WFcm3RCuxUQ0Dj7fC
 wuaMKal0ZyIkPCcWHEZYR33+8XJCkHPIrEsdBITqBIhrTVGFcuFwqefZxy72G53/dSjvKQ
 V7hCFh90oUDFRKvYncZzRr2nuKXJP0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-5LwJd5poPUGndMwzGG1RdA-1; Tue, 24 Oct 2023 01:50:57 -0400
X-MC-Unique: 5LwJd5poPUGndMwzGG1RdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 802A485D521;
 Tue, 24 Oct 2023 05:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA528C0B;
 Tue, 24 Oct 2023 05:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7925E21E6A1F; Tue, 24 Oct 2023 07:50:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Juan
 Quintela <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 10/14] fixup! migration: New migrate and
 migrate-incoming argument 'channels'
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-11-farosas@suse.de>
Date: Tue, 24 Oct 2023 07:50:56 +0200
In-Reply-To: <20231023182053.8711-11-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:49 -0300")
Message-ID: <87y1fstvpb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

Fabiano Rosas <farosas@suse.de> writes:

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/migration.json | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index fa9534a661..2cfdae894a 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1666,6 +1666,14 @@
>  #                                    "port": "1050" } } ] } }
>  # <- { "return": {} }
>  #
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "file",
> +#                                    "filename": "/tmp/migfile",
> +#                                    "offset": "0x1000" } } ] } }
> +# <- { "return": {} }
> +#
>  ##
>  { 'command': 'migrate',
>    'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],

Acked-by: Markus Armbruster <armbru@redhat.com>


