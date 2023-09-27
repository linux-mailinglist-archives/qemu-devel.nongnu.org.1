Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13D7B0C5A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 21:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlZpT-0006ug-VQ; Wed, 27 Sep 2023 15:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlZpR-0006uF-P6
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlZpQ-0004LH-H0
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695841447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEy96wq67B/xaHt8kWvUwhr+MhlYdfSTgdTEnJqppVM=;
 b=ZSyLMvR2SaYXaeVxODJeBiEZF1b5uWQo226WPcmz2k/ZmPQctPmjTGcKFD8g8ToT2ng5lm
 IjrWjlkI/wQRiy/c/QhIItaNLf/zC1ydtp+dcanmIjC/qOqw0CrfF5psBFwY0dMn77vORC
 dgXWJavvVvzuF98uqtJN5CKW2kdc8OY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-SlYbPQ9RO2GnJGDoInmYNQ-1; Wed, 27 Sep 2023 15:04:05 -0400
X-MC-Unique: SlYbPQ9RO2GnJGDoInmYNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A2B43C0DF8B
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 19:04:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30F4E176C7
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 19:04:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA82721E6905; Wed, 27 Sep 2023 21:04:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com
Subject: Re: [PATCH 13/52] migration/rdma: Make qemu_rdma_buffer_mergable()
 return bool
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-14-armbru@redhat.com>
 <lgzyiwzmeu52tl5cwnlaujcnnkk5exgevipk5gau66japybsnq@vo4jmrnigjd7>
Date: Wed, 27 Sep 2023 21:04:03 +0200
In-Reply-To: <lgzyiwzmeu52tl5cwnlaujcnnkk5exgevipk5gau66japybsnq@vo4jmrnigjd7>
 (Eric Blake's message of "Wed, 27 Sep 2023 11:26:05 -0500")
Message-ID: <87fs2za15o.fsf@pond.sub.org>
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

Eric Blake <eblake@redhat.com> writes:

> On Mon, Sep 18, 2023 at 04:41:27PM +0200, Markus Armbruster wrote:
>> qemu_rdma_buffer_mergable() is semantically a predicate.  It returns
>> int 0 or 1.  Return bool instead.
>
> While at it, this would be a perfect time to s/mergable/mergeable/g

Will do, thanks!


