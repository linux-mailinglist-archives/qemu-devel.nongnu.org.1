Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D803D7B7D39
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:33:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzBF-0001uC-5n; Wed, 04 Oct 2023 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzBD-0001tz-69
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzBB-00039J-RO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696415552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWLYyDhgfISxfK4NjvGrGHQNHFnCpIFQOy3ZK8A/wcw=;
 b=MCgEUg6WFjVX8PJtkswJxjNVyVwDLSeGBKof0KTpCAw+0AWJPRBmykA5dD1H6Ukd4/8NJH
 lM313ZP+wWbV8sswpA00ovp1WZWLJQ5u9wliT856yaHrnnMzlY0h8pqrKJ20bnjw6KVghW
 YRujGFh1bybI/Oul0Yokf6FbsWCFSaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-8Tc9aMImPJSPo7Sz787d9A-1; Wed, 04 Oct 2023 06:32:23 -0400
X-MC-Unique: 8Tc9aMImPJSPo7Sz787d9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B253018811A9;
 Wed,  4 Oct 2023 10:32:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C52BC154CD;
 Wed,  4 Oct 2023 10:32:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A23E21E6904; Wed,  4 Oct 2023 12:32:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Fan Ni <fan.ni@samsung.com>,  <linuxarm@huawei.com>
Subject: Re: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
References: <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
Date: Wed, 04 Oct 2023 12:32:21 +0200
In-Reply-To: <20230925152258.5444-1-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Mon, 25 Sep 2023 16:22:58 +0100")
Message-ID: <87il7mk79m.fsf@pond.sub.org>
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

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> Rename the version not burried in the macro to cap_h.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Queued, thanks!


