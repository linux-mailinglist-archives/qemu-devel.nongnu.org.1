Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48755A5678A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 13:12:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWXa-0004Oo-07; Fri, 07 Mar 2025 07:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWXB-0004Jg-1q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWX6-00042k-9Y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741349423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YAQ/SBzu+UgBfKAkJQNVmSNi62hOeYC8As6c58xaeQE=;
 b=i61FBA3pAb9w6K/fD1BDHg23wb4GnNuXn7sb+0aarxe4qgbwqCDUNAPvnOIbb5nljdzbJj
 mr0durNNl5g+n1ke20tYVDoqsxnXWSKw+LTjO+kmSotEkIvPuwkJ901LP/zv/A7FPLw27z
 4bN51i5/JVaotBi5vnGFDCuQUQjJeEs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-2yr0J20qPoWmJKDg0VKWqw-1; Fri,
 07 Mar 2025 07:10:22 -0500
X-MC-Unique: 2yr0J20qPoWmJKDg0VKWqw-1
X-Mimecast-MFC-AGG-ID: 2yr0J20qPoWmJKDg0VKWqw_1741349421
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3CBE1955DCC; Fri,  7 Mar 2025 12:10:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 965CA1955DCE; Fri,  7 Mar 2025 12:10:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FB8D21E675F; Fri, 07 Mar 2025 13:10:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 40/57] docs/qapidoc: add visit_freeform() method
In-Reply-To: <20250305034610.960147-41-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:49 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-41-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:10:17 +0100
Message-ID: <8734fpkpna.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 50 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 6de8c900543..cf5dbb0133d 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -29,6 +29,7 @@
>  from contextlib import contextmanager
>  import os
>  from pathlib import Path
> +import re
>  import sys
>  from typing import TYPE_CHECKING
>  
> @@ -55,6 +56,8 @@
>          Sequence,
>      )
>  
> +    from qapi.parser import QAPIDoc
> +
>      from sphinx.application import Sphinx
>      from sphinx.util.typing import ExtensionMetadata
>  
> @@ -130,6 +133,53 @@ def visit_module(self, path: str) -> None:
>          self.add_line_raw(f".. qapi:module:: {name}", path, 1)
>          self.ensure_blank_line()
>  
> +    def visit_freeform(self, doc: QAPIDoc) -> None:
> +        # TODO: Once the old qapidoc transformer is deprecated, freeform
> +        # sections can be updated to pure rST, and this transformed removed.
> +        #
> +        # For now, translate our micro-format into rST. Code adapted
> +        # from Peter Maydell's freeform().
> +
> +        assert len(doc.all_sections) == 1, doc.all_sections
> +        body = doc.all_sections[0]
> +        text = body.text
> +        info = doc.info
> +
> +        if re.match(r"=+ ", text):
> +            # Section/subsection heading (if present, will always be the
> +            # first line of the block)
> +            (heading, _, text) = text.partition("\n")
> +            (leader, _, heading) = heading.partition(" ")



> +            level = len(leader) + 1  # Implicit +1 for heading in .rST stub

What is the ".rST stub"?

> +
> +            # https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
> +            markers = {
> +                1: "#",
> +                2: "*",
> +                3: "=",
> +                4: "-",
> +                5: "^",
> +                6: '"',
> +            }

I'd be tempted to use markers = '#*=-^".  Matter of taste, yours takes
precedence here.

> +            overline = level <= 2
> +            marker = markers[level]
> +
> +            self.ensure_blank_line()
> +            # This credits all 2 or 3 lines to the single source line.
> +            if overline:
> +                self.add_line(marker * len(heading), info)
> +            self.add_line(heading, info)
> +            self.add_line(marker * len(heading), info)
> +            self.ensure_blank_line()
> +
> +            # Eat blank line(s) and advance info
> +            trimmed = text.lstrip("\n")
> +            text = trimmed
> +            info = info.next_line(len(text) - len(trimmed) + 1)
> +
> +        self.add_lines(text, info)
> +        self.ensure_blank_line()
> +
>  
>  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
>      """A QAPI schema visitor which adds Sphinx dependencies each module


