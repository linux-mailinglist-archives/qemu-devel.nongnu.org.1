Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA37B9A76
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJE-000052-6J; Wed, 04 Oct 2023 23:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIF-0007Sy-6d
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFID-0000Lt-MR
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDsZnUicENX14uBrPv90iIre5SOYaN6w5F3yw6zce+M=;
 b=Hi7uxFL3C3xxb5AN4ScA/rgAZwzWhGjEv9734bSV0MAc67zcFGHL9kr5eKR5Y4WsEzgm1s
 ZXZ1q8HcvuS3Bct/gQc5GAYey1JhFyC4PHSAxJdjk4FuEU3ACORKGApw4X2GoiX78zRv6X
 5qyEWKq/mpw+DG2sgDQyhGyCLJdomqk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-fzDSKiUNNkCHoHvYA0H0XA-1; Wed, 04 Oct 2023 23:44:51 -0400
X-MC-Unique: fzDSKiUNNkCHoHvYA0H0XA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4065ca278b3so3144285e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477490; x=1697082290;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDsZnUicENX14uBrPv90iIre5SOYaN6w5F3yw6zce+M=;
 b=IkKcYSJw4I1LF1vq8BrRAKjBr4duJNG6WA99K0GALzxFlFOMi/9yti2V6xLn74es2d
 WLKN9iVOKlW6dcgoeu/Yep1EUblLHPXD5jPYiQ7R8L9VzHlOsMo0vaMk3CvrPD8E062R
 nZVEaKwAZP4cTdUuB4LA3LWBv0LX9XV/SbfxXrJLmfqcZQBKHWBOUfjLhNFskmbz1GXD
 XLIpGhGY64VMN1QY795n8+nsCT8GDP6KgQunA76/sfN2hTV/9AuG4iTbdO0beC24JTo2
 erL+MCoSFxQdTiZ4Zq6bZBm/DoiRuJ4b8Kv9GqGA5RvxsmtPxmL7trn7qRoXQXi15ZCn
 mG/w==
X-Gm-Message-State: AOJu0Yy2Zl0RGeGnOWQxHmP+ci6zcFqcBHDYEXLq70u54yyMoxTHLYfW
 Ns7PfJ7BfZLViThHqV7tnwP+Tw4QVkMWVfTtFwsXlslzDDiIOcB36QLJOu1Bqftu8gyV77o1BLf
 sgswUky92yFSryrMW6xwY9C7YnX7aDX3sefuhdGGoowfxvZ4eQpponqFHL9ubSb3x4boy
X-Received: by 2002:a05:600c:2116:b0:406:53c0:3c71 with SMTP id
 u22-20020a05600c211600b0040653c03c71mr3692985wml.37.1696477489934; 
 Wed, 04 Oct 2023 20:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfAqKThazVyTEs53Y0AjEpnc4R4ROrkHQNPEjszCYklFUZw4Pup+O6ze2sLsgpn4M9j/UtsQ==
X-Received: by 2002:a05:600c:2116:b0:406:53c0:3c71 with SMTP id
 u22-20020a05600c211600b0040653c03c71mr3692972wml.37.1696477489609; 
 Wed, 04 Oct 2023 20:44:49 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 p15-20020a7bcc8f000000b003fee6e170f9sm528184wma.45.2023.10.04.20.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:49 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Yanhui Ma <yama@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: [PULL v2 34/53] vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
Message-ID: <0a7a164bc37b4ecbf74466e1e5243d72a768ad06.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


