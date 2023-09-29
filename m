Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF8F7B2CA6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:51:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7LF-0005Qd-5n; Fri, 29 Sep 2023 02:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Kr-0005NW-H1
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Kp-0002DV-29
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695970246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FTXkvRP866wx8TK8XLKKHFcMQC87tGzFcYt5V2bU37g=;
 b=PbmpOkwCwnwS0/WNsi62xh0VFtuw5lQ8fNUj84Zmpy2zJw34X+FCJb2LIMsD2bRrvqh+vQ
 kFumhb/GtPDLyKb9Cr8QN92pqKx3C3N2UOECqSC2zTLWdPRDw9YILYNlQE5Q+ZCh4/CHnH
 JMCLGqFQ+aS9ZjpdqF9HYXLSbU25lzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-686-ntb9x4sAMR-tZoI7IgZMLw-1; Fri, 29 Sep 2023 02:50:44 -0400
X-MC-Unique: ntb9x4sAMR-tZoI7IgZMLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 239A6800888;
 Fri, 29 Sep 2023 06:50:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D85959A;
 Fri, 29 Sep 2023 06:50:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D67DB21E6904; Fri, 29 Sep 2023 08:50:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  armbru@redhat.com,
 philmd@linaro.org,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH] qemu-nbd: changes towards enabling -Wshadow=local
References: <20230922205019.2755352-2-eblake@redhat.com>
Date: Fri, 29 Sep 2023 08:50:42 +0200
In-Reply-To: <20230922205019.2755352-2-eblake@redhat.com> (Eric Blake's
 message of "Fri, 22 Sep 2023 15:50:20 -0500")
Message-ID: <87ttrdh3r1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> Address all compiler complaints from -Wshadow in qemu-nbd.  Several
> instances of 'int ret' became shadows when commit 4fbec260 added 'ret'
> at a higher scope in main.  More interesting was the 'void *ret'
> capturing the result of a pthread; where we were conceptually doing
> '(void*)(intptr_t)EXIT_FAILURE != NULL' which just feels wrong (even
> though it happens to compile correctly), so it was worth a better
> cleanup.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> I'm happy to let Markus collect this with the growing pile on
> shadow-next, instead of going through my NBD tree.

Queued, thanks!


