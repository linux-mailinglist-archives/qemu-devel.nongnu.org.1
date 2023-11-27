Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD07FA8F9
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 19:28:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7gKN-0001VD-N5; Mon, 27 Nov 2023 13:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7gKK-0001Uf-3Z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 13:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7gKI-00035l-KP
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 13:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701109641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GyMqNUo7vWaTG5K0qupdvTn1cWMgTppuJi/t00i1XEw=;
 b=AZrO+/opK1RsKA/Yj+nSRpuqluO/27rSfeoe2HVReqiPxMNxfB+FqBfkqXeptedWDgA4t1
 s+OuW4WQlvjuDFM6qNFVDl3vg41mDIf1+IVIE+mo1ni7/LWDUtImtzvwclwu5mi8ydkuLB
 elwZfXlLQmief2a4CSGmKX7C8qO+PT8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-DoTBle1rP6SgFn82ysBXZw-1; Mon, 27 Nov 2023 13:27:18 -0500
X-MC-Unique: DoTBle1rP6SgFn82ysBXZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC5F6101A53B;
 Mon, 27 Nov 2023 18:27:17 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EC405028;
 Mon, 27 Nov 2023 18:27:15 +0000 (UTC)
Date: Mon, 27 Nov 2023 19:27:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, philmd@linaro.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH for-8.2] ide/via: Fix BAR4 value in legacy mode
Message-ID: <ZWTfglt4uWvslOVW@redhat.com>
References: <20231125140135.AF6A075A4C3@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125140135.AF6A075A4C3@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

Am 25.11.2023 um 15:01 hat BALATON Zoltan geschrieben:
> Return default value in legacy mode for BAR4 when unset. This can't be
> set in reset method because BARs are cleared on reset so we return it
> instead when BARs are read in legacy mode.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This fixes UDMA on amigaone with AmigaOS and I'd like to include for
> 8.2 release.

Thanks, applied to the block branch.

Kevin


