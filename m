Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A2A609FD
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Mar 2025 08:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tszM6-0004ys-FB; Fri, 14 Mar 2025 03:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tszM3-0004yX-V6
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tszM1-00051L-UD
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741936871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQegue11vwPEsYUtXcAG6PJjS7pGTvyVW0zOma+AK18=;
 b=fgRPU6xQzT6VAQ8UNf0k+F4R7x7uiiP7JMy2pMKuLqivLnjRsGgveNH0kqGrQ/IEQWpyh/
 Mc7uQnaKwCSwSfJbNr3Fr6d2LfFChb+DvIwaivxn7rWWlIWU2ov9tWc4WxNaD7bB6nMGIH
 KJB5u9/2xYPca/aGs0o1nkRiK/P4eV0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-BV88ljU-PQmoz5htEXMnQA-1; Fri,
 14 Mar 2025 03:21:03 -0400
X-MC-Unique: BV88ljU-PQmoz5htEXMnQA-1
X-Mimecast-MFC-AGG-ID: BV88ljU-PQmoz5htEXMnQA_1741936862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3786F1828A80; Fri, 14 Mar 2025 07:21:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BE6F18001E9; Fri, 14 Mar 2025 07:21:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C48C021E675F; Fri, 14 Mar 2025 08:20:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
In-Reply-To: <20250313044312.189276-8-jsnow@redhat.com> (John Snow's message
 of "Thu, 13 Mar 2025 00:43:08 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
Date: Fri, 14 Mar 2025 08:20:57 +0100
Message-ID: <87h63wulgm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

I found the commit message's description of reference resolution hard to
understand.  I think I understand it well enough now to ACK the design.
Would be nice to work some of your explanations into the commit message,
but we don't have time for that.  So I'm merely fixing your QGA vs. QSD
typo.

We might want to put an improved description into the code.  Not today.

Thanks!


