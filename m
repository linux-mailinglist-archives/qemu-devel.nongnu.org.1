Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6DA567A1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 13:15:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWbu-0006Pt-W9; Fri, 07 Mar 2025 07:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWbG-00065j-7M
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWbC-0006Df-UN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741349682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXASlQ3rlB/XsTKB9aYDpwAmP4Aq4++ILk2Oml0w4q0=;
 b=TIV48imO69lP1SGRG3GjKvKYkTu/2MAexIujpEZHi0Am1unwgVO8Y4EnLozMc7ZGIOPTpv
 ymoqcJ6JlVN2F+/u77AzAhULpuMaoDlql1zzQvPTS7kqiDCn9Hfhcv0+Um5GFJ+WlpyDKr
 XuuqNbp1skA10mVGPL0rRkizMohf7AA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-Co_ugQoYNZy7d4XrYzfadQ-1; Fri,
 07 Mar 2025 07:14:38 -0500
X-MC-Unique: Co_ugQoYNZy7d4XrYzfadQ-1
X-Mimecast-MFC-AGG-ID: Co_ugQoYNZy7d4XrYzfadQ_1741349677
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0BB21801A07; Fri,  7 Mar 2025 12:14:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58644300019E; Fri,  7 Mar 2025 12:14:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CADD021E675E; Fri, 07 Mar 2025 13:14:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 43/57] docs/qapidoc: add visit_errors() method
In-Reply-To: <20250305034610.960147-44-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:52 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-44-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:14:34 +0100
Message-ID: <87frjpjavp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> Notably, this method does not currently address the formatting issues
> present with the "errors" section in QAPIDoc and just vomits the text
> verbatim into the rST doc, with somewhat inconsistent results.
>
> To be addressed in a future revision.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index b96445f0802..14feafe866e 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -139,6 +139,12 @@ def visit_paragraph(self, section: QAPIDoc.Section) -> None:
>          self.add_lines(section.text, section.info)
>          self.ensure_blank_line()
>  
> +    def visit_errors(self, section: QAPIDoc.Section) -> None:
> +        # FIXME: the formatting for errors may be inconsistent and may
> +        # or may not require different newline placement to ensure
> +        # proper rendering as a nested list.

Is the FIXME worth mentioning in the commit message?

> +        self.add_lines(f":error:\n{section.text}", section.info)
> +
>      def preamble(self, ent: QAPISchemaDefinition) -> None:
>          """
>          Generate option lines for qapi entity directives.


