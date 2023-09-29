Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4747B2CAE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:58:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7Rg-0007re-Dz; Fri, 29 Sep 2023 02:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Rd-0007rL-Vy
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Rb-000435-6Z
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:57:49 -0400
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-URjqlTG5N4-1nHjW7vQDHQ-1; Fri, 29 Sep 2023 02:57:42 -0400
X-MC-Unique: URjqlTG5N4-1nHjW7vQDHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21B3A1C06EC8;
 Fri, 29 Sep 2023 06:57:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9AE42026D4B;
 Fri, 29 Sep 2023 06:57:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FFA121E6904; Fri, 29 Sep 2023 08:57:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>,  qemu-block@nongnu.org,
 qemu-devel@nongnu.org,  Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] hw/nvme: Clean up local variable shadowing in
 nvme_ns_init()
References: <20230925-fix-local-shadowing-v1-1-3a1172132377@samsung.com>
Date: Fri, 29 Sep 2023 08:57:40 +0200
In-Reply-To: <20230925-fix-local-shadowing-v1-1-3a1172132377@samsung.com>
 (Klaus Jensen's message of "Mon, 25 Sep 2023 08:05:05 +0200")
Message-ID: <87lecph3ff.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Klaus Jensen <its@irrelevant.dk> writes:

> From: Klaus Jensen <k.jensen@samsung.com>
>
> Fix local variable shadowing in nvme_ns_init().
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Queued, thanks!


