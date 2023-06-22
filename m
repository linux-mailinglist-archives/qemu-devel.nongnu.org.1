Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA3073A1CF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKDX-0004Hg-Uz; Thu, 22 Jun 2023 09:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qCKDQ-0004Go-J8
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qCKDP-00045J-59
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687439949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXkD3yAHjGZNBt3Vu1QmQMc1Am9hZ5noCySW5BBxUOo=;
 b=JvOv6tyUemG6pfcig+47cjhZkDgoLYk6DFHJdLLnEJFCtx6e778FPnUFY64eMMDDJbxx5Y
 iiGmYtiB2QXYm76WD9P/PRn1ycl6iKu9nLNMk/cL4c4oTplEjgEO9bCiK8o1XPvdf/6wsP
 Xq2rD9kW3l90jCg+SBRrXYtuzTpy01Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-fcPF5Eg4ORiPb6ulz0frVA-1; Thu, 22 Jun 2023 09:19:08 -0400
X-MC-Unique: fcPF5Eg4ORiPb6ulz0frVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD2303813F26
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:19:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C53C00049
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:19:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89D8521E676C; Thu, 22 Jun 2023 15:19:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] migration.json: Don't use space before colon
References: <20230612191604.2219-1-quintela@redhat.com>
Date: Thu, 22 Jun 2023 15:19:06 +0200
In-Reply-To: <20230612191604.2219-1-quintela@redhat.com> (Juan Quintela's
 message of "Mon, 12 Jun 2023 21:16:04 +0200")
Message-ID: <87352jbpo5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> So all the file is consistent.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued.  thanks!


