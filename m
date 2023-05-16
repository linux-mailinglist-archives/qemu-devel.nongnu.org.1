Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97A704514
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 08:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyo1G-0004Js-4A; Tue, 16 May 2023 02:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyo1A-0004HE-59
 for qemu-devel@nongnu.org; Tue, 16 May 2023 02:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyo18-0001iA-Nw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 02:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684217916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MPHnyC562+FmrVkOFwDRFQKGbetgZ0bPuCnQ3DJq+ko=;
 b=DdgPQf9FCNZ6Wzs2LZhsv27RvlsN6dxzcxAXNkMSdt8LPE7sK0bpJ/lSch7x/J5OillOkJ
 0NFcgkP/7G+nCoMO5I8H2Gsn4sxSQR5jkXsqSAgz3QHUyJBUWB/pkoD0i+1v6IWEEzJxQ8
 d5bHBgJQo41EmyTQnqaaXfBh+3Ovedk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-EqWTiY_XMbqxC-T_t0QtLw-1; Tue, 16 May 2023 02:18:34 -0400
X-MC-Unique: EqWTiY_XMbqxC-T_t0QtLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 684D61C313A8;
 Tue, 16 May 2023 06:18:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E6052026DFD;
 Tue, 16 May 2023 06:18:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C25021E6806; Tue, 16 May 2023 08:18:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/3] docs/interop: Convert qmp-spec.txt to rST
References: <20230515162245.3964307-1-peter.maydell@linaro.org>
 <20230515162245.3964307-2-peter.maydell@linaro.org>
Date: Tue, 16 May 2023 08:18:33 +0200
In-Reply-To: <20230515162245.3964307-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 15 May 2023 17:22:43 +0100")
Message-ID: <87fs7wx0hy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Convert the qmp-spec.txt document to restructuredText.
> Notable points about the conversion:
>  * numbers at the start of section headings are removed, to match
>    the style of the rest of the manual
>  * cross-references to other sections or documents are hyperlinked
>  * various formatting tweaks (notably the examples, which need the
>    -> and <- prefixed so the QMP code-block lexer will accept them)
>  * English prose fixed in a few places
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


