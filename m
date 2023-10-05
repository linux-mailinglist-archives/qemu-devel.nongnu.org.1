Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177477B9A63
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJJ-0000KP-3x; Wed, 04 Oct 2023 23:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIj-0008Cg-LY
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIg-0000bS-6G
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dc0LwezzCtuJZwfRfwd6fEilbxVEAWIE8I0MI4RifxI=;
 b=RGRDH0/7NuMj3h2t7y/Fg1XeOfpwns4jHImmOyFihaEVrCg4FwBGp3s6mgqSg4vKRdFolg
 juXwc4gAf0sVMCz3TXAt0nWMKCAd0yN6F6j+Sg+a4/YWypM4uKltgSMMZEtwaZObJTW5d1
 JtY5nNRQR04uhz9gkI5VKY4qeaZSq7A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-RQOZmJaAOJGUvvnltEFXJQ-1; Wed, 04 Oct 2023 23:45:17 -0400
X-MC-Unique: RQOZmJaAOJGUvvnltEFXJQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-327cd5c7406so388776f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477516; x=1697082316;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dc0LwezzCtuJZwfRfwd6fEilbxVEAWIE8I0MI4RifxI=;
 b=xAax/fmKW8JF+dO2eYBEOPiNHNXyeZUq3PNZrvg/W7DztkTOqKFQeb25+W+3+If2Na
 9J3qIrRcgCjWDFEEL4xjzKw+3QCveKNCF0IDGHinVGq/qqvTIJaUR7pqQB73zpvU3wur
 IZzZ8VlfK41GmSyU3pX/dSU2Zut4KgG+3+JdzJKvcXItFpZDJMGn1AqBlcuAor8tsjmH
 yvh/VbrGY1fHWEsNnEO7WQ5sMMbr/XzJrqrD66RcVnWKgjRsq7jBmLz2BpCaAI5vVdv5
 FDIylB2ApscmUSp0E5r6dNmbJXoDdfbPNTrHjmHGtDV+80ZjMVmL7IbRG8785Wz3+f+A
 F82A==
X-Gm-Message-State: AOJu0YymQqmhylhwJAxqyXlvM3aKJe3HIHnOia8HTlnTGs1YepE3asMr
 azacu8hmlSfc84AjUCHaoSD5SXyvMp+VOn2hDqhBeUmcfdE5RjP7N803UUfjLaKeEDIfX7D89tZ
 xmWwEvSBb4tO293BGQkgkMTdrFcsDX2/duKgfGi1m13wuWocwdZT1RCL6/wq9+1Lggqmi
X-Received: by 2002:adf:f452:0:b0:31f:fed4:d79d with SMTP id
 f18-20020adff452000000b0031ffed4d79dmr3761974wrp.30.1696477515935; 
 Wed, 04 Oct 2023 20:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFbb1tgLhrr+l0+JwNuyAcLbbQE7hIb0UvVNzSO6Ja3+Z9fYhYyF/B+QI2EfG0k5quwYtvmw==
X-Received: by 2002:adf:f452:0:b0:31f:fed4:d79d with SMTP id
 f18-20020adff452000000b0031ffed4d79dmr3761960wrp.30.1696477515642; 
 Wed, 04 Oct 2023 20:45:15 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 j14-20020a5d564e000000b0032320a9b010sm633779wrw.28.2023.10.04.20.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:15 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 41/53] vdpa net: stop probing if cannot set features
Message-ID: <f1085882d028e5a1b227443cd6e96bbb63d66f43.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

Otherwise it continues the CVQ isolation probing.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230915170836.3078172-3-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 650125bb0f..b688877f90 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1364,6 +1364,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
     r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
     if (unlikely(r)) {
         error_setg_errno(errp, errno, "Cannot set features");
+        goto out;
     }
 
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
-- 
MST


