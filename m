Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBB7A94D8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJpD-0002QR-0L; Thu, 21 Sep 2023 09:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJp8-0002PZ-IU
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJp6-0008A8-Kt
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695303267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VwAmUvZYkbpLBxCXzlVKCs4bJ941R9jetvX+GUQr8z0=;
 b=EGRT68hpGvXZmGx4C0ES7V+mO9/3myDUYXbeTIN3dilRPlvOStLkrNzwjLNzg48xAmsNzz
 U6FM/aAIwEWGNVNB62SuEbBYLOMtn82PagwIgXUcwALgfyqd9uLhD/XVo/IICPlY7D2fJ9
 yXK6VlMSfhTbIlNwEjK0cToL7APcmbU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-MNi-s1nRNDy0ht8DOAnP6w-1; Thu, 21 Sep 2023 07:21:01 -0400
X-MC-Unique: MNi-s1nRNDy0ht8DOAnP6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 696C828237C8
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 11:21:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 482CB2904
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 11:21:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 53DB921E6900; Thu, 21 Sep 2023 13:21:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 00/10] Validate and test qapi examples
References: <20230919201857.675913-1-victortoso@redhat.com>
Date: Thu, 21 Sep 2023 13:21:00 +0200
In-Reply-To: <20230919201857.675913-1-victortoso@redhat.com> (Victor Toso's
 message of "Tue, 19 Sep 2023 22:18:47 +0200")
Message-ID: <87y1gz6acj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Victor Toso <victortoso@redhat.com> writes:

> Hi,
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg02383.html
>
> - Sorry Markus, I kept the two last 'fix example' patches as I don't
>   fully remember how we should go with it.

That's fine.

I see two sane alternatives:

1. Add suitable elision syntax.  Happy to discuss details, but I think
we should discuss my review of PATCH 10 before we complicate matters
further.

2. Decide we don't need elisions.  Delete the ones we have.  I'd like to
see an argument that the ones we have are not helpful enough to justfify
the effort to keep them.

>                                            Not taking them but taking
>   the generator would be bad as we would fail the build.

Understood.

[...]


