Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 810949E7E88
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Dec 2024 07:18:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJo8j-0001PE-6w; Sat, 07 Dec 2024 01:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJo8f-0001Oj-Ij
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 01:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJo8c-00064j-KT
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 01:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733552277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXd6sRb6hzxCMVHU9f1VtGB+1Mk/DPskD3I2aLsr55s=;
 b=daZEMNjSZPitniNtY2OFnDGbHGGu7I1j2qiuHgHhLLB8BYSX525oGIS+9yKGdev0j4JYfN
 bMwItURbaBDZQD4tTxNgPLxCKRgac5DlkeT5TOk38rnCyrVOf6EG5+kgIvKpo/nuamMN7Z
 6jnPtrNlOY4mvn3IRqhxbAFxVu8KH5k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-0iHDL88oP52LvbRkV2HSgQ-1; Sat,
 07 Dec 2024 01:17:47 -0500
X-MC-Unique: 0iHDL88oP52LvbRkV2HSgQ-1
X-Mimecast-MFC-AGG-ID: 0iHDL88oP52LvbRkV2HSgQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F136419560A5; Sat,  7 Dec 2024 06:17:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82FDE1956095; Sat,  7 Dec 2024 06:17:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39E4D21E66D2; Sat,  7 Dec 2024 07:17:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Shiju Jose <shiju.jose@huawei.com>,  Ani
 Sinha <anisinha@redhat.com>,  Dongjiu Geng <gengdongjiu1@gmail.com>,  Igor
 Mammedov <imammedo@redhat.com>,  linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 31/31] FIXME: acpi/ghes: properly set data record size
In-Reply-To: <104add143d349685cea1b47298b8f5d367a3a15e.1733504943.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Fri, 6 Dec 2024 18:12:53 +0100")
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
 <104add143d349685cea1b47298b8f5d367a3a15e.1733504943.git.mchehab+huawei@kernel.org>
Date: Sat, 07 Dec 2024 07:17:42 +0100
Message-ID: <87o71o2f09.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Another subject line that suggests this isn't fully baked.  Respin to
reduce confusion?


