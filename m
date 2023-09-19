Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0C7A5977
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 07:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiTTa-00084Z-FQ; Tue, 19 Sep 2023 01:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiTTN-0007yh-Ia
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiTTJ-0007tu-Hu
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695102027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eCtoW5YmugRAOgCVYwI8LazpWJuSKfz0/Y0RnlW+RR8=;
 b=V1Doi9dAaxllt3rAKj8xczd/KHR8Im3/EspGRI1om5zgWCTkJbfJ87XHOdOh6jmGaRqR9u
 VWy/LivO8PcHn6Ybfktiseo0858hpf9Au4XCW64WQJKAr7t1f4mJ34gX5cwg/5tte8TS/T
 DshwWkdkLntRNa7vfYeeu1v7F/6UIsg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-vA5vnuYKMPGzn5wULdrNyg-1; Tue, 19 Sep 2023 01:40:20 -0400
X-MC-Unique: vA5vnuYKMPGzn5wULdrNyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06EC1185A79B;
 Tue, 19 Sep 2023 05:40:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ECB2140E950;
 Tue, 19 Sep 2023 05:40:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BE0821E6900; Tue, 19 Sep 2023 07:40:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  kwolf@redhat.com,  hreitz@redhat.com,
 vsementsov@yandex-team.ru,  jsnow@redhat.com,  idryomov@gmail.com,
 pl@kamp.de,  sw@weilnetz.de,  sstabellini@kernel.org,
 anthony.perard@citrix.com,  paul@xen.org,  pbonzini@redhat.com,
 marcandre.lureau@redhat.com,  berrange@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  stefanha@redhat.com,  fam@euphon.net,
 quintela@redhat.com,  peterx@redhat.com,  leobras@redhat.com,
 kraxel@redhat.com,  qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org,  alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 1/7] migration/rdma: Fix save_page method to fail on
 polling error
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-2-armbru@redhat.com>
 <npnhurzixjae6schhran3dnicpwozrhkaan5sxcf3gyxviam5y@ofklh25a6wlc>
Date: Tue, 19 Sep 2023 07:40:18 +0200
In-Reply-To: <npnhurzixjae6schhran3dnicpwozrhkaan5sxcf3gyxviam5y@ofklh25a6wlc>
 (Eric Blake's message of "Thu, 31 Aug 2023 08:38:09 -0500")
Message-ID: <87a5ti4t6l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Thu, Aug 31, 2023 at 03:25:40PM +0200, Markus Armbruster wrote:
>> qemu_rdma_save_page() reports polling error with error_report(), then
>> succeeds anyway.  This is because the variable holding the polling
>> status *shadows* the variable the function returns.  The latter
>> remains zero.
>> 
>> Broken since day one, and duplicated more recently.
>> 
>> Fixes: 2da776db4846 (rdma: core logic)
>> Fixes: b390afd8c50b (migration/rdma: Fix out of order wrid)
>
> Alas, the curse of immutable git history preserving typos in commit
> subjects ;)

"wrid" is short for "work request ID", actually.

>             The alternative of rewriting history and breaking SHA
> references is worse.

Rewriting master is a big no-no.

git-note can be used to correct the record, but it has its usability
issues.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  migration/rdma.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


