Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B0AA67D5E
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Mar 2025 20:55:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tud0h-0002Uk-EP; Tue, 18 Mar 2025 15:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tud0e-0002UF-7I
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tud0c-0004wK-GN
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742327632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KnDiFJ9r6AH5xxMgqWyp6tBi9Rdi4Ce9/VtoO9xz0ug=;
 b=ChH01uPVxXxXyqCHv6X9kpuFaZELADBVNaXxUuwIDvj7zLPghYbF8t2L6TBL1UsMUCLMDq
 xKpjRYKwc4KEu6L8pHAc632WyZjBqo26qV3KvcJ5at3r2w7h3FPbJeY4macxlqY+Q/w3YC
 13AO0PfzkYGKS4/CCeETbHnSxX/onzM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-P-oGSuq0O62uLEH6Wqj_MA-1; Tue,
 18 Mar 2025 15:53:49 -0400
X-MC-Unique: P-oGSuq0O62uLEH6Wqj_MA-1
X-Mimecast-MFC-AGG-ID: P-oGSuq0O62uLEH6Wqj_MA_1742327628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D40591956053; Tue, 18 Mar 2025 19:53:46 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.124])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B47EF18001D4; Tue, 18 Mar 2025 19:53:43 +0000 (UTC)
Date: Tue, 18 Mar 2025 20:53:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: hreitz@redhat.com, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] qcow2: fix null pointer dereference in crypto block
Message-ID: <Z9nPRB9Yfjboh03_@redhat.com>
References: <Z9lgdFO48OpQa6Nt@redhat.com>
 <20250318130011.267021-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318130011.267021-1-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

Am 18.03.2025 um 14:00 hat gerben@altlinux.org geschrieben:
> You can reproduce this issue by running ./qemu-img info segv. 
> The segv file used for reproduction can be found here: 
> https://github.com/Gerben100/reproduce_qemu-img_error

Thanks. Your patch makes sure that qemu-img doesn't crash any more, but
we should catch the invalid image already while opening it. I'll send a
different patch.

Kevin


