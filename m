Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFF17B7AEE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXQ-0001Js-HP; Wed, 04 Oct 2023 04:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVn-00085a-10
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVk-0002Ke-VH
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDsZnUicENX14uBrPv90iIre5SOYaN6w5F3yw6zce+M=;
 b=TW81ew+9lGLmjbSqFe11I6tSKShom5o16PMHjKO+Vch8tRMx0koJu1x2HMIeNqJUiTC+6w
 016OQCVvT6lLY47NPsfs0QUWP9lqCd6WxT8YTvj1hp54Zsjumsf2Hfnh2Fes60PiFnEUHg
 majol7csb4TaGvGB2apjNV/yofGFKzc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-9KQue738OqC5wBWN8cR_Mg-1; Wed, 04 Oct 2023 04:45:38 -0400
X-MC-Unique: 9KQue738OqC5wBWN8cR_Mg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c296e650easo16155861fa.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409136; x=1697013936;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDsZnUicENX14uBrPv90iIre5SOYaN6w5F3yw6zce+M=;
 b=DG16oeK5QXJJeJ9TayezlXf+sp8viQhARP9IBJsCsd6wKoz2/3t2bkVncXyz+e5U+O
 X6b7jaiBv7ZVYwTy2AuKg9twudzGJ/Mvjfho3UsukVvd68vWKcO+tZQlVl8EqxsC3z8p
 oSNBpH7abYjBFcfbHF2LmJ1S/D2iA6gwxrgkDApeO4BE0eGhCWcX0mb/qD7PnGzLtYO8
 Dr71zsNOMPJfzZxOCrUlFUYqbFyWu9+0OyOsEISPi2XaRMjJCfamV+NX3ee6bkG3VBWd
 cojIfGwXaEM/+UVIHj3GFdmuxHot3w9U4vqr1lPIZCP/IzCA+WVYHVsNVAlw+XxlxQOf
 x5NQ==
X-Gm-Message-State: AOJu0YxHK93vtVqCfYqBCTbQKvJexbede+TQTykxBLG0UhnvYEd9GTZZ
 qROELJRjCw2emCQOQOvUQypqj9NXab85dgU2tbU/0NoXERuz7Lt+e5RSEIXQe4DDJCD0r/xCGay
 IaI/ZKivcehDxTNVAhfgS4GIIkubhEMpdANpheXr6jyl6yI/LAS20kChxTgTO9OgGSxsw
X-Received: by 2002:a2e:984f:0:b0:2b1:a89a:5f2b with SMTP id
 e15-20020a2e984f000000b002b1a89a5f2bmr1436299ljj.2.1696409136436; 
 Wed, 04 Oct 2023 01:45:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP2XAVukOxLG+vA8gGPibYly/JN+mNUDP5FPXALoZEWnukVoECTvQeF6JSxu+I9AC8pZ2+0g==
X-Received: by 2002:a2e:984f:0:b0:2b1:a89a:5f2b with SMTP id
 e15-20020a2e984f000000b002b1a89a5f2bmr1436275ljj.2.1696409136055; 
 Wed, 04 Oct 2023 01:45:36 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 t24-20020a7bc3d8000000b004042dbb8925sm935753wmj.38.2023.10.04.01.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:35 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Yanhui Ma <yama@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: [PULL 44/63] vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
Message-ID: <0e62d383b6fe85f7ab14e7767fd451c9b274e93d.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

Not zeroing it causes a SIGSEGV if the live migration is cancelled, at
net device restart.

This is caused because CVQ tries to reuse the iova_tree that is present
in the first vhost_vdpa device at the end of vhost_vdpa_net_cvq_start.
As a consequence, it tries to access an iova_tree that has been already
free.

Fixes: 00ef422e9fbf ("vdpa net: move iova tree creation from init to start")
Reported-by: Yanhui Ma <yama@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230913123408.2819185-1-eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 94635fcbee..fe519d908d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -405,6 +405,8 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
     dev = s->vhost_vdpa.dev;
     if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
         g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_delete);
+    } else {
+        s->vhost_vdpa.iova_tree = NULL;
     }
 }
 
-- 
MST


