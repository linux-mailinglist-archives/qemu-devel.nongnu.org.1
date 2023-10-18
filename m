Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF097CD712
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2JF-0001tB-Lk; Wed, 18 Oct 2023 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt2JD-0001sV-Pv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt2JC-0001Uy-Gx
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697619221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OAqS7Uan21YVUCZGxEhspHgkn+WNwtqXQgsFw5olNL0=;
 b=Rm0dtzLy3jB5pctDnrFmEh2qriGCL0CYFg/I/CmLoxXwwWRLdYPoX/6C+H/O6sGKwzZ/Lj
 HlTSfXexMtk+Hkuoq9yE/V0pvgW3nRL+v7arasn0z0V2Ea/0LgCMOFtTJF7XqzMy/CRI7e
 RbkOycKm3f8t7dmG0RWY+J6lE1A6QqI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-qaT4skUeO6SvTNcEndFSzg-1; Wed, 18 Oct 2023 04:53:40 -0400
X-MC-Unique: qaT4skUeO6SvTNcEndFSzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D02E229AB40B;
 Wed, 18 Oct 2023 08:53:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2796CC15BB8;
 Wed, 18 Oct 2023 08:53:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BD3721E6A1F; Wed, 18 Oct 2023 10:53:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Michael Roth
 <michael.roth@amd.com>
Subject: Re: [PATCH v5 3/3] qapi: re-establish linting baseline
References: <20231004230532.3002201-1-jsnow@redhat.com>
 <20231004230532.3002201-4-jsnow@redhat.com>
Date: Wed, 18 Oct 2023 10:53:38 +0200
In-Reply-To: <20231004230532.3002201-4-jsnow@redhat.com> (John Snow's message
 of "Wed, 4 Oct 2023 19:05:32 -0400")
Message-ID: <878r80wbu5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Some very minor housekeeping to make the linters happy once more.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Queued.  Thanks!


