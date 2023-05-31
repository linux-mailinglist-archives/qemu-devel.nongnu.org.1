Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33A718113
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:09:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LZ5-0003Tf-00; Wed, 31 May 2023 09:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q4LYz-0003Sp-VT
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q4LYr-0001Jl-Mi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685538501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=vuSQkbmc0r+0jBk3EaFQ0xOSSghfs2n8WXIjwIvy8bo=;
 b=TnQyMS9aYHofEGHbb36lNfHZfSjhJZsWQvrIYCABL2gRaESn+AkVwvIo6kPCafFoCTIM46
 gGQ+exUaEnJwvzLbm1ZPm2f6ff5HxRl9K2js0m5jCCHT1rI7BRi5/1kQalsdX08MqOS0IN
 nWd0X/wBdDsjLNk43ndz2SLrcUOiBqI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-qfoY9XKvPOuO5ELtpSi4cQ-1; Wed, 31 May 2023 09:08:19 -0400
X-MC-Unique: qfoY9XKvPOuO5ELtpSi4cQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f4e06b3c6aso3474953e87.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685538497; x=1688130497;
 h=mime-version:user-agent:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuSQkbmc0r+0jBk3EaFQ0xOSSghfs2n8WXIjwIvy8bo=;
 b=AIqQPRUZxkRbaAvgOjs2t/IbZuTSbuhkDWoUk6chBM8L7uATR9BKjsx+l+f2XxAvOV
 taxwsm/zuiccQDSgJdHjsw+jxsOGbXmDHJ8NKP4+kRkxhzFmSWQbgpnwU3P84Ke0NjFH
 PdvaPvf98E78uBKXlHwbISyaDuylcLhCL6yofLLAeFB9MVa9QIghoO9Dz9qv+HL1sRZJ
 ZdgZgeTjoLbajeWg0QPBw1Z/A5iImyb8SMdp+8B6D4emw/CTmmMmVQR5BLtQO8SNmy3k
 FUh0yp0TM27rjxti2ZUcbobvko3TKRkh4yWqz9KoRL23ta9EJ8NNSSqu5O02FXfwfW8b
 gbwg==
X-Gm-Message-State: AC+VfDxwDU410TXyBKcqj3JdHBnQpku4gi+nEoG+rKWUlHBbR4ATcQax
 JXVvCMTsHxVD1+z2bGLxYf0wnOx8/yPrqOwUH2247BowjiHZuDRkNCE+pGO8foxgyhpEr2qDQ1S
 LesEQxaTqraf5jVQ2YgJDgNs=
X-Received: by 2002:a05:6512:11e7:b0:4f3:b4ab:d0ee with SMTP id
 p7-20020a05651211e700b004f3b4abd0eemr2359344lfs.42.1685538497315; 
 Wed, 31 May 2023 06:08:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HtwO/77fwqYa8+9V7Q2/h+TU6u8LCEJdAVRLTfJBrBK/hoXlHHOneLP7FJTbe0qR81W1lOw==
X-Received: by 2002:a05:6512:11e7:b0:4f3:b4ab:d0ee with SMTP id
 p7-20020a05651211e700b004f3b4abd0eemr2359329lfs.42.1685538496786; 
 Wed, 31 May 2023 06:08:16 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c24cd00b003f4dde07956sm24348287wmu.42.2023.05.31.06.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 06:08:16 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] docs: Fix trivial typos in vhost-user.rst
Date: Wed, 31 May 2023 14:48:31 +0200
Message-ID: <87a5xk7io3.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
---
 docs/system/devices/vhost-user.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index 86128114fa..a80e95a48a 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -38,13 +38,13 @@ system memory as defined by the ``-m`` argument.
 Example
 =======
 
-First start you daemon.
+First start your daemon.
 
 .. parsed-literal::
 
   $ virtio-foo --socket-path=/var/run/foo.sock $OTHER_ARGS
 
-The you start your QEMU instance specifying the device, chardev and
+Then you start your QEMU instance specifying the device, chardev and
 memory objects.
 
 .. parsed-literal::
-- 
2.38.5


