Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0AA780FC2
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 18:03:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1ua-0000Jw-Hd; Fri, 18 Aug 2023 12:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX1uG-00009r-QJ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX1uC-0005TP-Io
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692374456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7ubXIDNkdtocgbBc/XbxAMAN9vwXKjC27NqGnLUzIE=;
 b=agIXZMu+v5YzF7N0PXbcgYQuOWSjO8ddb/xfR3+LZ9RvyYflLBV6gUyf/KFYgMgB0GJGV9
 yQUzYa92NNsWHgAyKBwuufMcMh5mzJTCFPqRotShl1GoYDZBECJRYnGKRIByCJ8MFBLG0E
 UAnHkl8wbiT/syIt+kE2TKTaP9tgNWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-Ve4geKUROCe2bTxozcjBTA-1; Fri, 18 Aug 2023 12:00:52 -0400
X-MC-Unique: Ve4geKUROCe2bTxozcjBTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 261A68022E4;
 Fri, 18 Aug 2023 16:00:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C02140C6F4E;
 Fri, 18 Aug 2023 16:00:51 +0000 (UTC)
Date: Fri, 18 Aug 2023 18:00:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Be more verbose in create fallback
Message-ID: <ZN+Vssz5xiHuRcUn@redhat.com>
References: <20230720140024.46836-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140024.46836-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 20.07.2023 um 16:00 hat Hanna Czenczek geschrieben:
> For image creation code, we have central fallback code for protocols
> that do not support creating new images (like NBD or iscsi).  So for
> them, you can only specify existing paths/exports that are overwritten
> to make clean new images.  In such a case, if the given path cannot be
> opened (assuming a pre-existing image there), we print an error message
> that tries to describe what is going on: That with this protocol, you
> cannot create new images, but only overwrite existing ones; and the
> given path could not be opened as a pre-existing image.
> 
> However, the current message is confusing, because it does not say that
> the protocol in question does not support creating new images, but
> instead that "image creation" is unsupported.  This can be interpreted
> to mean that `qemu-img create` will not work in principle, which is not
> true.  Be more verbose for clarity.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2217204
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Thanks, applied to the block branch.

Kevin


