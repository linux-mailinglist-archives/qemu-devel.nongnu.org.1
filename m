Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2166A5BC01
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 10:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvoi-0005jg-9M; Tue, 11 Mar 2025 05:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trvoZ-0005j3-C2
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trvoW-0006AY-9P
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741684933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQ9UImSxo73U9qkm3wWb1JjkQhqaIEg+vigXeaQ7y9U=;
 b=QTVNdlQpx/otPS+d9z8h5WiQCHwcJfI28I7kQaZrmsu5pKk0DnzqUI6L8vYsMyisdQZSrb
 D+t08fr6x04cHUDPu4ewYNqgZd3ZGsgqunMx0FJCjDRUtEEwkYzJmS0rkDnAUp5RSIeDif
 eH0YGac654a0ZWPThIR4e9AZM/q/WJE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-LRYaKCqjPE6xQodz2xDS3A-1; Tue,
 11 Mar 2025 05:22:08 -0400
X-MC-Unique: LRYaKCqjPE6xQodz2xDS3A-1
X-Mimecast-MFC-AGG-ID: LRYaKCqjPE6xQodz2xDS3A_1741684927
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A27161801A12; Tue, 11 Mar 2025 09:22:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D88A1801756; Tue, 11 Mar 2025 09:22:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71EE421E66C4; Tue, 11 Mar 2025 10:22:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 58/63] docs/qapidoc: generate entries for
 undocumented members
In-Reply-To: <20250311034303.75779-59-jsnow@redhat.com> (John Snow's message
 of "Mon, 10 Mar 2025 23:42:56 -0400")
References: <20250311034303.75779-1-jsnow@redhat.com>
 <20250311034303.75779-59-jsnow@redhat.com>
Date: Tue, 11 Mar 2025 10:22:03 +0100
Message-ID: <87o6y753d0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> Presently, we never have any empty text entries for members. The next
> patch will explicitly generate such sections, so enable support for it
> in advance.
>
> The parser will generate placeholder sections to indicate undocumented
> members, but it's the qapidoc generator that's responsible for deciding
> what to do with that stub section.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 7c5a08958d5..604ab109a19 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -233,11 +233,12 @@ def visit_member(self, section: QAPIDoc.ArgSection) -> None:
>          # TODO: features for members (documented at entity-level,
>          # but sometimes defined per-member. Should we add such
>          # information to member descriptions when we can?)
> -        assert section.text and section.member
> +        assert section.member
>          self.generate_field(
>              self.member_field_type,
>              section.member,
> -            section.text,
> +            # TODO drop fallbacks when undocumented members are outlawed
> +            section.text if section.text else "Not Documented.",

I'm changing this to "Not documented" to obey English capitalization
rules.

>              section.info,
>          )


