Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3857B9F942E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Dec 2024 15:22:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOdsi-0002Vd-Ce; Fri, 20 Dec 2024 09:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOdsT-0002VM-Kw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOdsO-0002gc-8v
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734704470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBpimWTzkpOiqWwBS1U2mm0DB7QhU68XAWS0jWITI7I=;
 b=AXRK3tzSlLqUY8ZoSGjTTiDqPtgAnRbDUw95O8gfs6radiZSMQBWrvkqDho9WoDn0rZ3+x
 EEPUYnh8IozJniOnkM3yXZPQHhvkZC4EbM9Nu3HLhd4XqUsW7rUNNS2O3mttobYC6P258y
 5SPJPCuC7BBmp2F4OAOuQSyNLQFyAdQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-sh86uJhxOnqF2y9Oo9JvvQ-1; Fri,
 20 Dec 2024 09:21:07 -0500
X-MC-Unique: sh86uJhxOnqF2y9Oo9JvvQ-1
X-Mimecast-MFC-AGG-ID: sh86uJhxOnqF2y9Oo9JvvQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C05961956059; Fri, 20 Dec 2024 14:21:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C0C21956053; Fri, 20 Dec 2024 14:21:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 282AC21E6740; Fri, 20 Dec 2024 15:21:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 16/23] docs/qapidoc: add visit_feature() method
In-Reply-To: <20241213021827.2956769-17-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:19 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-17-jsnow@redhat.com>
Date: Fri, 20 Dec 2024 15:21:02 +0100
Message-ID: <87cyhm306p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

> The format_type() method is adjusted here to return None for features,
> because Features don't have documented types. This makes
> generate_field() safe to use for features.

I'm confused: the patch doesn't touch format_type().

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 7efe2d656c0..02f434c09ab 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -187,6 +187,15 @@ def visit_paragraph(self, section: QAPIDoc.Section) -> None:
>          self.add_lines(section.text, section.info)
>          self.ensure_blank_line()
>  
> +    def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
> +        # FIXME - ifcond for features is not handled at all yet!
> +        # Proposal: decorate the right-hand column with some graphical
> +        # element to indicate conditional availability?
> +        assert section.text  # Guaranteed by parser.py
> +        assert section.member
> +
> +        self.generate_field("feat", section.member, section.text, section.info)
> +
>      def visit_errors(self, section: QAPIDoc.Section) -> None:
>          # FIXME: the formatting for errors may be inconsistent and may
>          # or may not require different newline placement to ensure


