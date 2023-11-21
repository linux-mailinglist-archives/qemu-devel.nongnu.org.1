Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF937F2D0D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:24:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Pmy-0007CW-Rf; Tue, 21 Nov 2023 07:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5Pmx-0007CE-AC
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:23:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5Pmv-0004D1-Km
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700569411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cfDSEZFT1tytQJQGGp5m+VkJfelvWWRpp6bdHPaWMyI=;
 b=IqZ54+7gUFU0LaRV6u44WsLmRWvLMqcfiPupvz0D842wySLrI9GUj87CG96h3NB9blyrlJ
 W1eCMmIPZFV2wNJJWB88u877U2cPYYgzBq0rA+t8NvJwLHiVrRYIpelnXO+Mxp0u32Rvtb
 x5Y4/4HyE+I8/+nAYfklPIrxW2sdKLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-uwTSdOkbMMuGIeIMnmq2Zg-1; Tue, 21 Nov 2023 07:23:27 -0500
X-MC-Unique: uwTSdOkbMMuGIeIMnmq2Zg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EEFE82BA82;
 Tue, 21 Nov 2023 12:23:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D3E1492BFA;
 Tue, 21 Nov 2023 12:23:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63C2321E6A1F; Tue, 21 Nov 2023 13:23:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 02/19] qapi/schema: add pylint suppressions
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-3-jsnow@redhat.com>
Date: Tue, 21 Nov 2023 13:23:26 +0100
In-Reply-To: <20231116014350.653792-3-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:33 -0500")
Message-ID: <87fs0z5m81.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> With this, pylint is happy with the file, so enable it in the
> configuration.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/pylintrc  | 5 -----
>  scripts/qapi/schema.py | 4 ++++
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
> index 90546df5345..aafddd3d8d0 100644
> --- a/scripts/qapi/pylintrc
> +++ b/scripts/qapi/pylintrc
> @@ -1,10 +1,5 @@
>  [MASTER]
>  
> -# Add files or directories matching the regex patterns to the ignore list.
> -# The regex matches against base names, not paths.
> -ignore-patterns=schema.py,
> -
> -
>  [MESSAGES CONTROL]
>  
>  # Disable the message, report, category or checker with the given id(s). You
   # can either give multiple identifiers separated by comma (,) or put this
   # option multiple times (only on the command line, not in the configuration
   # file where it should appear only once). You can also use "--disable=all" to
   # disable everything first and then reenable specific checks. For example, if
   # you want to run only the similarities checker, you can use "--disable=all
   # --enable=similarities". If you want to run only the classes checker, but have
   # no Warning level messages displayed, use "--disable=all --enable=classes
   # --disable=W".
   disable=fixme,
           missing-docstring,
           too-many-arguments,
           too-many-branches,
           too-many-statements,
           too-many-instance-attributes,
           consider-using-f-string,
           useless-option-value,

Unrelated, but here goes anyway: sorting these would be nice.

> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index c79747b2a15..153e703e0ef 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -13,6 +13,7 @@
>  # See the COPYING file in the top-level directory.
>  
>  # TODO catching name collisions in generated code would be nice

Blank line to separate unrelated comments, please.

> +# pylint: disable=too-many-lines
>  
>  from collections import OrderedDict
>  import os
> @@ -82,6 +83,7 @@ def c_name(self):
>          return c_name(self.name)
>  
>      def check(self, schema):
> +        # pylint: disable=unused-argument
>          assert not self._checked
>          seen = {}
>          for f in self.features:
> @@ -116,6 +118,7 @@ def is_implicit(self):
>          return not self.info
>  
>      def visit(self, visitor):
> +        # pylint: disable=unused-argument
>          assert self._checked
>  
>      def describe(self):
> @@ -134,6 +137,7 @@ def visit_module(self, name):
>          pass
>  
>      def visit_needed(self, entity):
> +        # pylint: disable=unused-argument
>          # Default to visiting everything
>          return True

Reviewed-by: Markus Armbruster <armbru@redhat.com>


