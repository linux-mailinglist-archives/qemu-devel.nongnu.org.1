Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E9B7F4882
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 15:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5nrP-0007X3-6w; Wed, 22 Nov 2023 09:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5nr8-0007Sn-Q1
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 09:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5nr7-0007bn-B1
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 09:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700661928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qsl+ZMn+JoILa0YcbH2ZZvMnB0I40VIvb6F9dYTHkIc=;
 b=VR71KsXOgdjkTwmr1gs7OmSCSnFNZTT5c1SSDdhYwFjR4937Xv3Q5XkimSSLxUSKMS1fVC
 lwWPn17IUq4XENz6iTs6/hWt9gQivn+pNARPCnfXs+R9s0CzQF88sNLk726hGlpLHA7OAf
 pLrE5Bb52KY86oMiHtI9P3YHKY8rsRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-TZavWVGgNSa_7_o_POXXCQ-1; Wed, 22 Nov 2023 09:05:26 -0500
X-MC-Unique: TZavWVGgNSa_7_o_POXXCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA7BD85A58A;
 Wed, 22 Nov 2023 14:05:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA5FEC1596F;
 Wed, 22 Nov 2023 14:05:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D372F21E6A1F; Wed, 22 Nov 2023 15:05:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 13/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-14-jsnow@redhat.com>
Date: Wed, 22 Nov 2023 15:05:23 +0100
In-Reply-To: <20231116014350.653792-14-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:44 -0500")
Message-ID: <87zfz5c28s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> There are two related changes here:
>
> (1) We need to perform type narrowing for resolving the type of
>     tag_member during check(), and
>
> (2) tag_member is a delayed initialization field, but we can hide it
>     behind a property that raises an Exception if it's called too
>     early. This simplifies the typing in quite a few places and avoids
>     needing to assert that the "tag_member is not None" at a dozen
>     callsites, which can be confusing and suggest the wrong thing to a
>     drive-by contributor.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Without looking closely: review of PATCH 10 applies, doesn't it?


