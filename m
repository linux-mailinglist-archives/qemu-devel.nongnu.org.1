Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 493C289D758
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Apr 2024 12:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru99M-0001XH-Rk; Tue, 09 Apr 2024 06:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ru99C-0001V7-36
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ru99A-0003DC-2a
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712660171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9eX1qlYO0D9z00kIEcLvawtMAwU+mTnq7ImBQkpk4c=;
 b=a+LfRtIaHwV987Zzunzww6OPCzSw65TvXJExSzaToNT8bDW7cu/lqGtP8XWhSvVM1vyzKF
 sPVAjwXN6Jx5dSIWI339x4iKXFzlufJDH9dZN903Joaw44i4UIMJwJtpsVIwbuHWV+RETM
 3SFRB01safX5XeY0OHT5yjxWCSsEvpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-sHN-7fEDNqGP34YroyTGig-1; Tue, 09 Apr 2024 06:56:06 -0400
X-MC-Unique: sHN-7fEDNqGP34YroyTGig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A92D10499A2;
 Tue,  9 Apr 2024 10:56:05 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95994920;
 Tue,  9 Apr 2024 10:56:04 +0000 (UTC)
Date: Tue, 9 Apr 2024 12:55:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH-for-9.0? 0/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
Message-ID: <ZhUer8fUjnSeOvLu@redhat.com>
References: <20240408083605.55238-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408083605.55238-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 08.04.2024 um 10:36 hat Philippe Mathieu-Daud� geschrieben:
> Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446
> 
> Philippe Mathieu-Daud� (3):
>   hw/block/nand: Factor nand_load_iolen() method out
>   hw/block/nand: Have blk_load() return boolean indicating success
>   hw/block/nand: Fix out-of-bound access in NAND block buffer

As we're short on time for 9.0:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

But it feels to me like this device could use some more cleanup to make
the code more robust.

Kevin


