Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EBA7F985
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Apr 2025 11:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u25I5-0003YA-EZ; Tue, 08 Apr 2025 05:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u25I2-0003Xb-SS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 05:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u25I1-0008UJ-CT
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 05:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744104640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McLRxJXfvWUXIrYPp5mGUCB4tEJBf2sNW+X208HWOFc=;
 b=CA7RDrmRh2aoS/tZDYFZBlGxbMWpelIFL3d5Si2VX8oH4E//GuOf3hSckFUqA3WCnnmRL9
 pfVhVcgC3O0aM49vjf8livmoq7RkxzVfmswcVoJCMuJy5qEadi5+iZLTbAF9RGMXvGfrTr
 j58NEUNgXvHh9g5xeZbabVkzzFN+TyA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-tQ-J6pJhOW6EWv6GcQO3aA-1; Tue,
 08 Apr 2025 05:30:34 -0400
X-MC-Unique: tQ-J6pJhOW6EWv6GcQO3aA-1
X-Mimecast-MFC-AGG-ID: tQ-J6pJhOW6EWv6GcQO3aA_1744104632
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B27180025B; Tue,  8 Apr 2025 09:30:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3F4C180174E; Tue,  8 Apr 2025 09:30:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 496F321E6757; Tue, 08 Apr 2025 11:30:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  hreitz@redhat.com,
 kwolf@redhat.com,  eblake@redhat.com,  jsnow@redhat.com,
 devel@lists.libvirt.org,  pkrempa@redhat.com,  michael.roth@amd.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v2 2/2] qapi/block-core: derpecate some block-job- APIs
In-Reply-To: <20250404193154.707145-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 4 Apr 2025 22:31:54 +0300")
References: <20250404193154.707145-1-vsementsov@yandex-team.ru>
 <20250404193154.707145-3-vsementsov@yandex-team.ru>
Date: Tue, 08 Apr 2025 11:30:29 +0200
Message-ID: <871pu3m24q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Typo in subject, make it "deprecate".

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> For change, pause, resume, complete, dismiss and finalize actions
> corresponding job- and block-job commands are almost equal. The
> difference is in find_block_job_locked() vs find_job_locked()
> functions. What's different?
>
> 1. find_block_job_locked() do check, is found job a block-job. This OK
>    when moving to more generic API, no needs to document this change.
>
> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>    find_job_locked() reports GenericError. So, lets document this
>    difference in deprecated.txt. Still, for dismiss and finalize errors
>    are not documented at all, so be silent in deprecated.txt as well.
>
> ACKed-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


