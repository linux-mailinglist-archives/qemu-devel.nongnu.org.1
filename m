Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2CA2B390
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 21:46:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8ju-00070t-Ce; Thu, 06 Feb 2025 15:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tg8jq-0006ys-Qk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tg8jn-0003se-RM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738874677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6WnFNB3rMny+OcVu/s4vsp7bajC6TlSs2p4685+RT0=;
 b=Bl9sIjRVJPnzkcM3zJxbBg7PVfJ5PEzwIwzGUY5ANi8Yb0H04GWThbm4REwVGHOLuaRymX
 LUK3DWt/ieukkdNUEJrDd7vFYp0V2owUW99DOri85cihonYLahQFhDxKTTmMq4sRWidYhv
 PqdWd0cSm8kO345RxLjE0JdLykTg+zQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144--1AaMgBgNeCOwB6ivAcDMg-1; Thu,
 06 Feb 2025 15:44:33 -0500
X-MC-Unique: -1AaMgBgNeCOwB6ivAcDMg-1
X-Mimecast-MFC-AGG-ID: -1AaMgBgNeCOwB6ivAcDMg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D86C19560B1; Thu,  6 Feb 2025 20:44:32 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21A931956054; Thu,  6 Feb 2025 20:44:29 +0000 (UTC)
Date: Thu, 6 Feb 2025 21:44:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Remove unused blk_op_is_blocked()
Message-ID: <Z6UfKeso5lackAKq@redhat.com>
References: <20250206165331.379033-1-kwolf@redhat.com>
 <b46b9348-0f28-4714-8b39-13cf2e62a649@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b46b9348-0f28-4714-8b39-13cf2e62a649@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 06.02.2025 um 18:25 hat Philippe Mathieu-Daud� geschrieben:
> On 6/2/25 17:53, Kevin Wolf wrote:
> > Commit fc4e394b28 removed the last caller of blk_op_is_blocked(). Remove
> > the now unused function.
> 
> fatal: ambiguous argument 'fc4e394b28': unknown revision or path not in the
> working tree.
> 
> Is there a patch on the list?

It's in my pending pull request (which I hope to go through - otherwise
I'll have to update the commit ID here). This is the patch:

https://patchew.org/QEMU/20250203182529.269066-1-stefanha@redhat.com/

Kevin


