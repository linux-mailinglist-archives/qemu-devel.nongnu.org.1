Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC4712A66
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzi-0004GG-Ey; Fri, 26 May 2023 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zze-0004Ct-Kp
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzb-0002dx-Gx
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CiU+eRJd/yQCRQ14/jOPXi0TXueH4pHw6cXnlSUALw=;
 b=AeaI7eXzFhHyX3mAe+d0WbNTPBf9mGuxkGi+OZipG8rDXZrxz7Hs4k0uSxEP+SHGV9OlK4
 GCzyKY/QkS0kwkUGI55rRX9MjXBLWnGEA+JFedQFjmDOAnDhhySkKtfrzKiiJ60nmBYdQ5
 G5VzzjXP48RHn25JQX9lPDj4SdBots8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-W9RwutdbOT6fwowu3wHfHA-1; Fri, 26 May 2023 12:08:36 -0400
X-MC-Unique: W9RwutdbOT6fwowu3wHfHA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a355c9028so102008366b.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117315; x=1687709315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CiU+eRJd/yQCRQ14/jOPXi0TXueH4pHw6cXnlSUALw=;
 b=EL/ngpPEYYz7xdT2MLEzJZNkBoDp5Fxz7jFxc2FBdBW/AMrET7yP95z8gS2W5LF5VU
 s4VlYx8peFe1puqkp6ozRWz3THtjcLwMnP8gWoKYdmKyWsFY1HgEBIkRhvij6q/NA5cs
 aq0aypqRnYiE/Dnbxq509qkK+pLZ8CV1F3DSImZBSK1JHsZdPlU6odMOyozg2C0ygP9x
 lHC4TRI3/4l4FrjHtHGxyI3nEX4f9EFfPkASWC1k80QbLvj7ZaqNF1li1F4L82X5DYIZ
 vQbKFnbgn86jDsghrZVv3q8tOruSqLgnUq7kuPA4KNE4ZWkaemYCLUhegCJ1XhDpO9UC
 e9Rg==
X-Gm-Message-State: AC+VfDxqVlFSVkIWbrGEepfPBq+k3ECoNbZUesBJTPngUil7anSTmsBR
 d1gPJzDvrPxk2LNW3o4XYhoI8odOAiuDm38uNzlumJF/GntRPRXTtAQr+qTEZCNN9P42TjGMh03
 TsmEKMx0KGyGavOyKp+xmRDK+NOX4m/D+lW3ASqcj2bc1Ny1kpMLf1H2KBa7BL1Ib1Iah/6v2oQ
 I=
X-Received: by 2002:a17:907:1611:b0:957:17c5:8705 with SMTP id
 hb17-20020a170907161100b0095717c58705mr3051253ejc.51.1685117314939; 
 Fri, 26 May 2023 09:08:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GjQuJN5yGJ1tWN+24JPxDKWySNYdtlrXz/79F1TiLATkBBJbh4SrhUgVGAWbuqWuf1srb9A==
X-Received: by 2002:a17:907:1611:b0:957:17c5:8705 with SMTP id
 hb17-20020a170907161100b0095717c58705mr3051222ejc.51.1685117314598; 
 Fri, 26 May 2023 09:08:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a170906249200b0096f503ae4b0sm2312716ejb.26.2023.05.26.09.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Subject: [PULL 05/12] meson: Remove leftover comment
Date: Fri, 26 May 2023 18:08:17 +0200
Message-Id: <20230526160824.655279-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Commit d2e6f9272d ("fuzz: remove fork-fuzzing scaffolding") removed
the linker script and forgot to remove the comment.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20230525212044.30222-2-farosas@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meson.build b/meson.build
index 78890f01550a..ee1b7dac730b 100644
--- a/meson.build
+++ b/meson.build
@@ -404,8 +404,6 @@ if targetos != 'sunos' and not get_option('tsan')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
 endif
 
-# Specify linker-script with add_project_link_arguments so that it is not placed
-# within a linker --start-group/--end-group pair
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
   # virtual-devices.
-- 
2.40.1


