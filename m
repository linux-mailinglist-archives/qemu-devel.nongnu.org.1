Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08846B1E43D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 10:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIEa-0001Zs-4A; Fri, 08 Aug 2025 04:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukIET-0001UB-QM
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukIER-0007QP-Dz
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQVkZs0QWHbLwJEcjlMUjp7WzDLKHi+eSrh2p5HlNPA=;
 b=d3IrRV74G+b2LjCZgzMcETnNVspyew11VJj+P2+6Jxo5RKQnFbGFsoXaWvrqsJTTYBhbk8
 BWAaYIeeCLu1stdndgdbwklrIN+VxOtFQxLYabtlecZTxxCKL1bZI+BHdtOcfbxYAZkd8p
 q1WSzHViPrNrgMDjXER4085EO8xAfcc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-kzvRlsj1MwGG_BJGjgA2XQ-1; Fri,
 08 Aug 2025 04:13:39 -0400
X-MC-Unique: kzvRlsj1MwGG_BJGjgA2XQ-1
X-Mimecast-MFC-AGG-ID: kzvRlsj1MwGG_BJGjgA2XQ_1754640818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BBA0195609E; Fri,  8 Aug 2025 08:13:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E622D19560AD; Fri,  8 Aug 2025 08:13:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41A8621E6A27; Fri, 08 Aug 2025 10:13:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] error: Rewrite &error_warn with ERRP_GUARD()
In-Reply-To: <20250803-errp-v1-1-a59a73f63289@rsg.ci.i.u-tokyo.ac.jp> (Akihiko
 Odaki's message of "Sun, 03 Aug 2025 23:52:57 +0900")
References: <20250803-errp-v1-1-a59a73f63289@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 08 Aug 2025 10:13:35 +0200
Message-ID: <87pld6kz80.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> Without rewrite, an warning message may be printed before
> error_prepend(); in such a scenario, error_prepend() will results in
> NULL dereference because error_warn is NULL.
>
> Rewrite &error_warn with ERRP_GUARD() to make sure error_prepend() is
> reflected to printed messages and to avoid NULL dereference.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

You're right.  Needs

  Fixes: 3ffef1a55ca3 (error: add global &error_warn destination)

However, there's still more to fix up, and &error_warn is rarely used.
I just posted patches to delete it instead:

    [PATCH 00/12] Error reporting cleanup, a fix, and &error_warn removal

Thank you!


