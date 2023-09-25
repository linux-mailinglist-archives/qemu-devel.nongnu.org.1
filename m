Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 200457AD121
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 09:10:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkfjD-0002to-AO; Mon, 25 Sep 2023 03:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkfjA-0002tS-Tx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkfj4-0007Zz-3m
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695625789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SaRZv92IBH30tPJZAS+2MM68WgtlATZ2PZjG7RaSyR0=;
 b=FO+aas9Exzuht2YWQ3GC+QhIbLqxTwQh/nvFr+varRKDiKrEAiQCDdYr6Rj7kgJkTYkEQg
 hT+OZKielEI2TfrKqzrAzlOVZ6zhOO+q1Tw+dG9fBEFwb1ph4P+qnBrPZSRDvjE6ERgrKE
 h8B9sEX/2fCkanuBuk84y0fQ/NHSOm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-J9e3ImwGP8aDK4y3VPPDPg-1; Mon, 25 Sep 2023 03:09:45 -0400
X-MC-Unique: J9e3ImwGP8aDK4y3VPPDPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F6FA29A9D3C;
 Mon, 25 Sep 2023 07:09:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23CB32156A27;
 Mon, 25 Sep 2023 07:09:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1518621E6900; Mon, 25 Sep 2023 09:09:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "quintela@redhat.com" <quintela@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,  "leobras@redhat.com"
 <leobras@redhat.com>
Subject: Re: [PATCH 26/52] migration/rdma: Replace int error_state by bool
 errored
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-27-armbru@redhat.com>
 <168b551c-0c91-fcd4-1520-6c8c483a0538@fujitsu.com>
Date: Mon, 25 Sep 2023 09:09:44 +0200
In-Reply-To: <168b551c-0c91-fcd4-1520-6c8c483a0538@fujitsu.com> (Zhijian Li's
 message of "Mon, 25 Sep 2023 06:17:29 +0000")
Message-ID: <878r8uenk7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:41, Markus Armbruster wrote:
>> All we do with the value of RDMAContext member @error_state is test
>> whether it's zero.  Change to bool and rename to @errored.
>> 
>
> make sense!
>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
>
> Can we move this patch ahead "[PATCH 23/52] migration/rdma: Clean up qemu_rdma_wait_comp_channel()'s error value",
> so that [23/52] [24/52] [25/52] will be more easy to review.

I think I could squash PATCH 23 into "[PATCH 25/52] migration/rdma: Dumb
down remaining int error values to -1".  Would that work for you?


