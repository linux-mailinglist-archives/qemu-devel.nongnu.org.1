Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E87BDA1B0F2
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 08:30:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbE87-0000hT-9A; Fri, 24 Jan 2025 02:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tbE86-0000go-67
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tbE84-0003h7-3K
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737703762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wMcCPbVV+kjylhL8odDj7Lw86zB+2YdeKiRYSwTQgbQ=;
 b=bTvQE3wbvPUG+UN74+SyA0PGWuckg+FiBpjLBjH5vHqGDy0CknJVvXSxnOlLGyjeqcgCNg
 kc7biYCjpLAb7bupNLyJwicfZ77kptt86tB79RfGZw3kP6aHowrFplq9QAkxgArAtbQtt/
 Cx2r262E1Ccj7U3zpw0EFtO3WI2WaoQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-1AGkthJcM7COE2kdW8o1FQ-1; Fri,
 24 Jan 2025 02:29:17 -0500
X-MC-Unique: 1AGkthJcM7COE2kdW8o1FQ-1
X-Mimecast-MFC-AGG-ID: 1AGkthJcM7COE2kdW8o1FQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFC33195608A; Fri, 24 Jan 2025 07:29:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F2073003FD3; Fri, 24 Jan 2025 07:29:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CB1921E6A28; Fri, 24 Jan 2025 08:29:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  alex.bennee@linaro.org
Subject: Re: [PATCH v2 0/2] Add me as the maintainer for ivshmem-pci
In-Reply-To: <20250123012212.716499-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 23 Jan 2025 01:22:10 +0000")
References: <20250123012212.716499-1-gustavo.romero@linaro.org>
Date: Fri, 24 Jan 2025 08:29:14 +0100
Message-ID: <87bjvwvfed.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Add me as the maintainer for the ivshmem-pci.c device, the ivshmem
> server, and the ivshmem client tool. Also, adjust remaining parts left
> behind after ivshmem PCI device was renamed from ivshmem.c to
> ivshmem-pci.c, like header files, Kconfig, docs, and build scripts.

Thank you!

Acked-by: Markus Armbruster <armbru@redhat.com>


