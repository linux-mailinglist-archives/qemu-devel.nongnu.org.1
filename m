Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57C7F7490
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:08:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6VtZ-0005NT-2t; Fri, 24 Nov 2023 08:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r6VtO-0005Ma-Fp
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:06:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r6VtM-0002ol-NZ
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700831202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1k96+Bz/Ulc8c/LKVi2bPrkQr96vvTSf4TdAO1Yo9SY=;
 b=G14EXvxdX+BV0X9EOJVFzjP9DbpULuOMA2OAADfG7kd6z7/NO6R9p3rCjtV3cRAtf4nkfF
 Q5qLCFrK5P6ym8EQMT8dmf35GcDGO1sB28m4B0y44VVIlvMTt1Vo/Max22kF2sKXarcqFU
 4es40ZxmRnSPnid32jazeqxxUv2FJHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-JnWUT-D2P2SvlagYE7bKRA-1; Fri,
 24 Nov 2023 08:06:41 -0500
X-MC-Unique: JnWUT-D2P2SvlagYE7bKRA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE74D28AC1DD;
 Fri, 24 Nov 2023 13:06:40 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9CE0492BFA;
 Fri, 24 Nov 2023 13:06:39 +0000 (UTC)
Date: Fri, 24 Nov 2023 14:06:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: hreitz@redhat.com, qemu-block@nongnu.org, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] block/monitor: blk_bs() return value check
Message-ID: <ZWCf3hoaNHaWNECw@redhat.com>
References: <20231124113037.2477645-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124113037.2477645-1-frolov@swemel.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 24.11.2023 um 12:30 hat Dmitry Frolov geschrieben:
> blk_bs() may return NULL, which will be dereferenced without a check in
> bdrv_commit().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

Do you have a reproducer for a crash?

As far as I can see, it will not be dereferenced, because
blk_is_available() returns false and we return an error before
calling bdrv_commit():

    QEMU 8.1.91 monitor - type 'help' for more information
    (qemu) info block
    ide1-cd0: [not inserted]
        Attached to:      /machine/unattached/device[6]
        Removable device: not locked, tray closed

    floppy0: [not inserted]
        Attached to:      /machine/unattached/device[16]
        Removable device: not locked, tray closed

    sd0: [not inserted]
        Removable device: not locked, tray closed
    (qemu) commit ide1-cd0 
    Device 'ide1-cd0' has no medium

Kevin


