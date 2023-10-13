Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F97C7C85FC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:44:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHUd-0006Ug-1x; Fri, 13 Oct 2023 08:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHUb-0006UH-3W
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHUZ-0007HT-Aw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697200929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYGKlFKk2qCdI5bNLR4/PeedFlKJXNpjGwbRxMhZf5c=;
 b=VqE8dypIwsgGcZ3uc6n2DEAtyMVpWaH2YxPG05Dyuyyi/3wtcJz8mYzY2qMloXJqYXsZBH
 EWfIG+h/H5LpdoYNaaqmJzqw3sKKK4Y5fmKe8OUzE3JP6CEas/wIo8hmizgUfx0DVM2Y33
 PTTJA3hWOhvJ1KCPttMga32thsiuHxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347--_VMAzSePjmVqTZRX_4oFg-1; Fri, 13 Oct 2023 08:41:55 -0400
X-MC-Unique: -_VMAzSePjmVqTZRX_4oFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 829F1185A79C;
 Fri, 13 Oct 2023 12:41:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 607C71C060DF;
 Fri, 13 Oct 2023 12:41:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7068F21E6A21; Fri, 13 Oct 2023 14:41:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [RFC PATCH 00/78] Strict disable implicit fallthrough
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
Date: Fri, 13 Oct 2023 14:41:54 +0200
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org> (Emmanouil
 Pitsidianakis's message of "Fri, 13 Oct 2023 10:47:04 +0300")
Message-ID: <87o7h2hey5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hello,
>
> This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
> back in 2019.[0]
> We take one step (or two) further by increasing it to 5 which rejects
> fall through comments and requires an attribute statement.
>
> [0]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b
>
> The line differences are not many, but they spread all over different
> subsystems, architectures and devices. An attempt has been made to split
> them in cohesive patches to aid post-RFC review. Part of the RFC is to
> determine whether these patch divisions needs improvement.
>
> Main questions this RFC poses
> =============================
>
> - Is this change desirable and net-positive.

Unwanted fallthrough is an easy mistake to make, and
-Wimplicit-fallthrough=N helps avoid it.  The question is how far up we
need to push N.  Right now we're at N=2.  Has unwanted fallthrough been
a problem?

> - Should the `fallthrough;` pseudo-keyword be defined like in the Linux
>   kernel, or use glib's G_GNUC_FALLTHROUGH, or keep the already existing
>   QEMU_FALLTHROUGH macro.
> - Should fallthrough comments be removed if they do not include extra
>   information.

Valid questions, but they don't need answers until after picking our N.

[...]


