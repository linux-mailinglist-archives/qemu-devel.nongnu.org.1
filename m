Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B45738B9F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0qd-0001oS-HU; Wed, 21 Jun 2023 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qC0qb-0001o0-Ip
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qC0qa-0001x2-03
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687365498;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EV0cielQhWyx/HzbNCQNhSqqVWgt1fzQFVFTm+wxU1s=;
 b=faRIDuJahqquPG7BZ4/buhM/WsASr6UQuygz3BhFUE1CMu53QIUM+tSeEmfkvCnQjIIP+u
 9CDV4OLuPS7ggzTYXBz8VgcnDVKV2gc0PbFLtJtCkVtgEakj9La4n3tB7C2hdWZCuLZebZ
 zLJ7Ef/ETvsuy2DUmesm+xekbsox2Gw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-n6bw3rbeN02sE8ptvlUjZw-1; Wed, 21 Jun 2023 12:38:15 -0400
X-MC-Unique: n6bw3rbeN02sE8ptvlUjZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5F9B3C10151;
 Wed, 21 Jun 2023 16:38:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4334D1131F;
 Wed, 21 Jun 2023 16:38:14 +0000 (UTC)
Date: Wed, 21 Jun 2023 17:38:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 05/37] crypto: Add aesenc_SB_SR_AK
Message-ID: <ZJMndAbLe01orksj@redhat.com>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
 <20230620110758.787479-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620110758.787479-6-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 20, 2023 at 01:07:26PM +0200, Richard Henderson wrote:
> Start adding infrastructure for accelerating guest AES.
> Begin with a SubBytes + ShiftRows + AddRoundKey primitive.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  MAINTAINERS                                  |  1 +
>  host/include/generic/host/crypto/aes-round.h | 16 +++++++
>  include/crypto/aes-round.h                   | 44 +++++++++++++++++++
>  crypto/aes.c                                 | 46 ++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 host/include/generic/host/crypto/aes-round.h
>  create mode 100644 include/crypto/aes-round.h

Acked-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


