Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CCE8010FA
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977V-0003En-11; Fri, 01 Dec 2023 12:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977N-00030y-BI
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977L-0007ri-GM
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGIaBj+ISBG9/xkybqVhpak3sNOClvnJ+dxMyIbGCKk=;
 b=MGco1GfNyUw2h06yNWJynI/VGTLQ7qlJbIDPcEleTVuZLvknsEAhUoq6Te33CIV7g01ldE
 BX5unDbPKUrZBrLbF3fp8wMIJF2mboLwdVdP3as12VETuJYxioGKB8bU5YkQ2nsn+wb7ww
 yqbalpaQ4ccCOTPBoN0mFa3Y+di6Hvc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-HC2Rue2CM9e1u7otpeWfRw-1; Fri, 01 Dec 2023 12:15:46 -0500
X-MC-Unique: HC2Rue2CM9e1u7otpeWfRw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33331e69698so561921f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450943; x=1702055743;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IGIaBj+ISBG9/xkybqVhpak3sNOClvnJ+dxMyIbGCKk=;
 b=bXG43EapDc1TIAU/nKH3Ubxp9qswIiiNfWHn+Ltf37Es/hGXseNyVcwwMgi69cIeKT
 Qv5dfRKud1yMvMwWR7+TFJOw5AhHWZPQqgZVBkXVlmfBlIFz1UpPNexQ+6Uz/+bgkwez
 OHpfzbJ7j4Jzjfeu4HMrX307hc68ks08hhVOHmbdp22Tdgnp73cedjkXAD+X2NBtC5A9
 Lo0NL3HrT5PL6RybZZc4q7Vk+HdEwDR8n8T14fiWW9Ga8pKHU5mG5wnmipAoGboPGOfD
 ++PhdN9KzuggeF3QT44cApEyBIwbHyDQk3rPjwGVfKm10BXiwtb1DVHk7e+ZaVz22bAI
 xQow==
X-Gm-Message-State: AOJu0Yx/rWMof/sk5GLxLCod3r32kF+1qRtd9gdSc1kfaGSXH2KZJYKI
 +Q5WyUlJUv6VRxKf+z9co7KS+HDe4UEkPxo6kpPzc//6rwz48kZ8XHfr1e/5uaSE5RRhgPCmKaO
 gqjwqSm9hxTScexRLsIsAKHZqRGO44a7oRKjBM18gAFB/HTbmMY4jRJX8fbRhDFCZgve7
X-Received: by 2002:a5d:594c:0:b0:333:2fd2:3be9 with SMTP id
 e12-20020a5d594c000000b003332fd23be9mr731786wri.162.1701450943461; 
 Fri, 01 Dec 2023 09:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUM/4QdN6fRDR9HAwmaGFQ5xvQDKPJ2qyhCSIxdm6e4jOgC+yURD5LldFeSb6Feb673azA1A==
X-Received: by 2002:a5d:594c:0:b0:333:2fd2:3be9 with SMTP id
 e12-20020a5d594c000000b003332fd23be9mr731778wri.162.1701450943202; 
 Fri, 01 Dec 2023 09:15:43 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 m8-20020adff388000000b00332c36b6563sm4648573wro.101.2023.12.01.09.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:42 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Robert Hoo <robert.hoo.linux@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 13/15] msix: unset PCIDevice::msix_vector_poll_notifier in
 rollback
Message-ID: <97f1cd9f0b4b4fc031e88a2a49b333f1b846f0eb.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
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

From: Robert Hoo <robert.hoo.linux@gmail.com>

In the rollback in msix_set_vector_notifiers(), original patch forgot to
undo msix_vector_poll_notifier pointer.

Fixes: bbef882cc193 ("msi: add API to get notified about pending bit poll")
Signed-off-by: Robert Hoo <robert.hoo.linux@gmail.com>
Message-Id: <20231113081349.1307-1-robert.hoo.linux@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/msix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index ab8869d9d0..cd817f4ca8 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -648,6 +648,7 @@ undo:
     }
     dev->msix_vector_use_notifier = NULL;
     dev->msix_vector_release_notifier = NULL;
+    dev->msix_vector_poll_notifier = NULL;
     return ret;
 }
 
-- 
MST


