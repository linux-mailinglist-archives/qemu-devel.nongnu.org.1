Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516AA71069
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Mar 2025 07:09:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txJwN-0000a3-J6; Wed, 26 Mar 2025 02:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJwL-0000Zs-L7
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJwJ-0001Z5-V4
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742969314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPAIhwWHXMKXz7WKMqvIZZaISgcg24Xxa4FGRl/insA=;
 b=IElwMSGDNAtfG0u415hRtE6XPqk06o8vg5/J8h/1HMD8ObtOr7m4ychWLzZ5esi3MjeVP4
 pPyAehGrJRZ3sgJXy/0rnHQVDb49xH0/mtXMWbzplZRdlk/fZr2HSz3/JLZCWHXqxKSjE+
 NkwKBw4SzuZu0t8mItYmGGQiz9f/a7o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508--mfk0LHaPlGyr2_oPc3vhQ-1; Wed,
 26 Mar 2025 02:08:31 -0400
X-MC-Unique: -mfk0LHaPlGyr2_oPc3vhQ-1
X-Mimecast-MFC-AGG-ID: -mfk0LHaPlGyr2_oPc3vhQ_1742969310
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 804B91800EC5; Wed, 26 Mar 2025 06:08:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F21F419541A5; Wed, 26 Mar 2025 06:08:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C85121E66C7; Wed, 26 Mar 2025 07:08:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/5] python: update missing dependencies from minreqs
In-Reply-To: <20250321222347.299121-4-jsnow@redhat.com> (John Snow's message
 of "Fri, 21 Mar 2025 18:23:45 -0400")
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-4-jsnow@redhat.com>
Date: Wed, 26 Mar 2025 07:08:26 +0100
Message-ID: <87a598fhnp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> A few transitive dependencies were left floating; as a result, pip's
> dependency solver can pull in newer dependencies, which we don't
> want. Pin them down.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

What problem exactly does this fix?  Make target check-minreqs?

> ---
>  python/tests/minreqs.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> index a3f423efd84..19c0f5e4c50 100644
> --- a/python/tests/minreqs.txt
> +++ b/python/tests/minreqs.txt
> @@ -38,10 +38,14 @@ pyflakes==2.5.0
>  
>  # Transitive mypy dependencies
>  mypy-extensions==1.0.0
> +tomli==1.1.0
>  typing-extensions==4.7.1
>  
>  # Transitive pylint dependencies
>  astroid==2.15.4
> +dill==0.2
>  lazy-object-proxy==1.4.0
> +platformdirs==2.2.0
>  toml==0.10.0
> +tomlkit==0.10.1
>  wrapt==1.14.0


