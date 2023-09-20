Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC87A82FB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwzP-0000aL-JH; Wed, 20 Sep 2023 09:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiwzE-0000YP-9O
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiwzC-0000gV-Qt
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695215482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fUJVVAaxOiqX1LeH5QCX6oXHuLE5GExhw5M9nzrhDac=;
 b=gXM8pujyJZyMASWdy8jMP/VrIwmuGPmWDOYgvKuOfBupIfIVhUEb4EvG8LmFP/EPSop68f
 7Bpb51P4j/6zrLnSjqRJMSWb0XzB7Ltan9b+aO6nf3PF84eqo//obK2+MsME7gvrgrN8Jw
 5JWhBl7Won9XbuhcnKAIjpo08FNKIDI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-DeTEbFhCOredhCO37p4l4g-1; Wed, 20 Sep 2023 09:11:20 -0400
X-MC-Unique: DeTEbFhCOredhCO37p4l4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6A1B1C07839;
 Wed, 20 Sep 2023 13:11:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B47EF10F1BE8;
 Wed, 20 Sep 2023 13:11:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 766D721E6900; Wed, 20 Sep 2023 15:11:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com
Subject: Re: [PATCH 06/52] migration/rdma: Clean up two more harmless signed
 vs. unsigned issues
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-7-armbru@redhat.com> <87r0mvz9ss.fsf@suse.de>
Date: Wed, 20 Sep 2023 15:11:18 +0200
In-Reply-To: <87r0mvz9ss.fsf@suse.de> (Fabiano Rosas's message of "Mon, 18 Sep
 2023 14:10:59 -0300")
Message-ID: <87o7hxf0qx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> qemu_rdma_exchange_get_response() compares int parameter @expecting
>> with uint32_t head->type.  Actual arguments are non-negative
>> enumeration constants, RDMAControlHeader uint32_t member type, or
>> qemu_rdma_exchange_recv() int parameter expecting.  Actual arguments
>> for the latter are non-negative enumeration constants.  Change both
>> parameters to uint32_t.
>>
>> In qio_channel_rdma_readv(), loop control variable @i is ssize_t, and
>> counts from 0 up to @niov, which is size_t.  Change @i to size_t.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
> just a comment...
>
>>  static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
>> -                                int expecting)
>> +                                   uint32_t expecting)
>>  {
>>      RDMAControlHeader ready = {
>>                                  .len = 0,
>> @@ -2851,7 +2851,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>>      RDMAContext *rdma;
>>      RDMAControlHeader head;
>>      int ret = 0;
>> -    ssize_t i;
>> +    size_t i;
>>      size_t done = 0;
>
> It seems the idea was for 'done' to be ssize_t like in
> qio_channel_rdma_writev()

You're right, the two functions are still inconsistent: @done is size_t
here and ssize_t there.

Hmm, there's yet another mess:

        ret = qemu_rdma_fill(rdma, data, want, 0);
        done += ret;
        want -= ret;

qemu_rdma_fill() returns size_t, @done is size_t or ssize_t, @want is
@size_t, but @ret is int.  Unwanted truncation is theoretically
possible.

Separate patch.

Thanks!


