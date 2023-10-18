Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D277CE1D0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8sC-0007dG-Gg; Wed, 18 Oct 2023 11:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sA-0007LX-1V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8s7-0006P7-MG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7qr9joXptBLcHYoSU39OwUryohZJ26ZcaI8wb1rbBFY=;
 b=ZAW0jda/oOkYfhWgwnLttzORVEYWPvt/kFhW2/csYFYI7fVyJliKk91s86eQXmaIAkwgZR
 Kew/roGuCFDRQPyy7MVu1IffrXpqriJEAIR+tWAJ+6K1+RNA2yWMgA58VrNDQ0QX+IYhNp
 jlWI7NUtPG2kRIQeBja636YAfldL6js=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-M6AAiwabNYaGkapQKMIARg-1; Wed, 18 Oct 2023 11:54:01 -0400
X-MC-Unique: M6AAiwabNYaGkapQKMIARg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso48836025e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644434; x=1698249234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qr9joXptBLcHYoSU39OwUryohZJ26ZcaI8wb1rbBFY=;
 b=NosjSYhZydEi9jflcPtCxV9oS8PypMIN9B3DKCImjjaUPgb8Vspz0KzrHnCQX5Wd8t
 YuoR/VsZUgUUhzmgE2hdaDM8ERwvoFxanOJXCxHAW32f6cCSgkgBfb+a7xBO/iWayJAh
 fa6hcDTeJUZOLnY2Cqt6RX2c/dyr89hvrOWjwFc0XkaVwfqShV5uujoCbS7aV3YoYMHA
 YgkCUehbJO3UwsCp677MvkSghT6jJTEm+GbU86tr0ITx3hEtNs8f1HFYkoGJfmHGj8Mg
 k56PDKXs6ixvkSM6H45LGeyjcgkQ39TAOVhInAYpqM87gsQ3KFlzFXamVjhBsdfctipz
 oK4g==
X-Gm-Message-State: AOJu0YzqBDLl+rtGJrQj+z6VEjx6lHJS3lVOHf1zVHalSAs7wph0q9AY
 vjHZtNswMEd72g9M+H1gVYWkVPX+ikMMXJ41Muixri7daLZQPAfUt0bGuOUGXU2TpcmxXiLdfEE
 wReifjGjnY9HSfzR++iN2375DGWys2s70He7LMJ5ZKEaw9jzbWim0aIXVjBnjPRZ9KwbptEM=
X-Received: by 2002:a05:600c:3590:b0:404:4b6f:d70d with SMTP id
 p16-20020a05600c359000b004044b6fd70dmr4387992wmq.17.1697644434754; 
 Wed, 18 Oct 2023 08:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKnf04l3FPWtfILw0BNHMCNpII4Q6wvb8wREj/6ensB4vC+TbbZNqwz/plyT97EarSDQ6GOQ==
X-Received: by 2002:a05:600c:3590:b0:404:4b6f:d70d with SMTP id
 p16-20020a05600c359000b004044b6fd70dmr4387981wmq.17.1697644434470; 
 Wed, 18 Oct 2023 08:53:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c228100b0040596352951sm1953697wmf.5.2023.10.18.08.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:54 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 09/83] vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
Message-ID: <8fa37f3529265496ffe6546105152b379ae222b8.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

From: Hawkins Jiawei <yin31149@gmail.com>

Enable SVQ with VIRTIO_NET_F_HASH_REPORT feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <a67d4abc2c8c5c7636addc729daa5432fa8193bd.1693297766.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 40d0bcbc0b..66afa34237 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -121,6 +121,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
+    BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
MST


