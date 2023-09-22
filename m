Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 314317AAE7A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjchA-0001Av-0x; Fri, 22 Sep 2023 05:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjch7-0001Ai-Iu
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjch6-0005UP-5D
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmZZpy52LBsO11orvs80r/zh4DqFnunDVVGIsCYJU0I=;
 b=TqBM3ulPOuB6J+lT1FWpopx17j3jOr/PzhaHm9p+faHmevh4XSaiILSCZZE1Ojl+72J9hA
 FZazXPXQ0K4gjzpHh5Gbx/AKqAlE/uXn0VPbYaMGNy3ZjKMBKKhO2tooQgc1FJjpZZJFPi
 sP6mEFITd79kSGpMzhkPu85ZGikSEMM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-RtrKn93GPwqh1FXVGTOdAw-1; Fri, 22 Sep 2023 05:43:23 -0400
X-MC-Unique: RtrKn93GPwqh1FXVGTOdAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AC13800883;
 Fri, 22 Sep 2023 09:43:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D152E711282;
 Fri, 22 Sep 2023 09:43:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CCC3F21E6900; Fri, 22 Sep 2023 11:43:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 15/52] migration/rdma: Ditch useless numeric error codes
 in error messages
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-16-armbru@redhat.com>
 <f797e410-1be1-75fd-d091-0da8974cc986@fujitsu.com>
Date: Fri, 22 Sep 2023 11:43:21 +0200
In-Reply-To: <f797e410-1be1-75fd-d091-0da8974cc986@fujitsu.com> (Zhijian Li's
 message of "Fri, 22 Sep 2023 08:44:09 +0000")
Message-ID: <875y42lf0m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:41, Markus Armbruster wrote:
>> Several error messages include numeric error codes returned by failed
>> functions:
>> 
>> * ibv_poll_cq() returns an unspecified negative value.  Useless.
>> 
>> * rdma_accept and rmda_get_cm_event() return -1.  Useless.
>
>
> s/rmda_get_cm_event/rdma_get_cm_event

Sharp eyes!  Will fix.

> Otherwise,
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks!


