Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE57B0C59
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 21:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlZoN-0006El-VQ; Wed, 27 Sep 2023 15:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlZoL-0006EL-Op
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlZoK-0003SV-6f
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695841379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5zJOMWi2zxiO/VxRsKyO1RuBAi5vpiokpwP1rQl9cqo=;
 b=cXCF4sdEbcWos1jC2EbbvmBWE7HZGmgsg6tVzVWe8zKPGr25kPhpBkTiOsdV8FCRi+UfaP
 CE9I+aVUtJN9ni0LhALwvx58rWMm9D0MTID44Kgm045gjd6SkJDRBG3gsk96roxmAkRrY5
 6/bXwzO0Z4VhC1B5+Mn4RGEG9HKgIfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-CVLwwNP3Ohyel18ykolKfw-1; Wed, 27 Sep 2023 15:02:57 -0400
X-MC-Unique: CVLwwNP3Ohyel18ykolKfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF730101B06F
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 19:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 980E62027018
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 19:02:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6E4121E6900; Wed, 27 Sep 2023 21:02:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com
Subject: Re: [PATCH 10/52] migration/rdma: Eliminate error_propagate()
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-11-armbru@redhat.com>
 <ossygji7xnbuwdn5rohjy3jehooi7wqxkgtufc7pchavv42u7q@56czoc62ugyl>
Date: Wed, 27 Sep 2023 21:02:53 +0200
In-Reply-To: <ossygji7xnbuwdn5rohjy3jehooi7wqxkgtufc7pchavv42u7q@56czoc62ugyl>
 (Eric Blake's message of "Wed, 27 Sep 2023 11:20:44 -0500")
Message-ID: <87jzsba17m.fsf@pond.sub.org>
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

> On Mon, Sep 18, 2023 at 04:41:24PM +0200, Markus Armbruster wrote:
>> When all we do with an Error we receive into a local variable is
>> propagating to somewhere else, we can just as well receive it there
>> right away.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  
>>      ret = qemu_rdma_alloc_pd_cq(rdma);
>>      if (ret) {
>> -        ERROR(temp, "rdma migration: error allocating pd and cq! Your mlock()"
>> +        ERROR(errp, "rdma migration: error allocating pd and cq! Your mlock()"
>>                      " limits may be too low. Please check $ ulimit -a # and "
>>                      "search for 'ulimit -l' in the output");
>
> Not this patch's problem, but noticing it while here:
>
> it would help if we had a consistent style on whether to break long
> strings after the space instead of carrying the space to the next
> line, rather than using both styles in the same concatenated string.

Oh yes.  I prefer to break lines before space, because leading space is
more visible than trailing space.

However, I elected to refrain from touching error messages in this
series.  It's long enough as it is.


