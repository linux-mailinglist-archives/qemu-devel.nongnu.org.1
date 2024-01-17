Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A356D830134
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:23:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1CO-0000fr-67; Wed, 17 Jan 2024 03:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ1CM-0000fZ-K7
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ1CL-0006ED-5K
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705479776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4aSEx0fvNwllNY6iFgw2sCLA+IXOhxEvm1hxlo78E0Q=;
 b=WSnSXmp+fqe9iDWKFMqn3wYm6KK6pSxEsZujeSBsrJOA0qhtXKHZsOnrs7M3LXSwmGGsC0
 pBdD6oRUTrovwxHZfBDRS4lOfqIttC8dXPaODhk5nLBTkTrKXTXR2wXGdoAIeDXIDbbuvn
 E+lHAKpOew89zKrvs//DczmItzVvLBs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-fxsnE0LfPxeulzVkTw06GQ-1; Wed,
 17 Jan 2024 03:22:53 -0500
X-MC-Unique: fxsnE0LfPxeulzVkTw06GQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C64842837800;
 Wed, 17 Jan 2024 08:22:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3FFE1C066AB;
 Wed, 17 Jan 2024 08:22:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D596321E680D; Wed, 17 Jan 2024 09:22:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 14/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
In-Reply-To: <20240112222945.3033854-15-jsnow@redhat.com> (John Snow's message
 of "Fri, 12 Jan 2024 17:29:40 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-15-jsnow@redhat.com>
Date: Wed, 17 Jan 2024 09:22:49 +0100
Message-ID: <87h6jcnzc6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

I explored another solution, and posted it in reply to v2.  If we decide
not to like it better, I guess we'll go with this one.


