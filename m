Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94C73DD27
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBV-0002uw-CM; Mon, 26 Jun 2023 07:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBL-0002uA-Mk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBK-0000XO-5O
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxFcgxnhKliDRkn36lhP8Pf5Rcfhb0VjyF7Bnb87z1w=;
 b=aB9/wtxEYpC0heoVY1R2XEyAF/n+6aqOasbxTQ9qvMGAoML9llTpKZFjq/m/tZTU2ViDbt
 3sUj0X9wMo5Ok2tda4vmYlwin8I9cqjjMXQcpePPoYkh/kilFhBTz05UX1AA3R7ptFyW2S
 jyzA+isF2PCa4D/Eqoxpvv0nNELSHnA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-3xXaImKOOkCgPxd3HkVnFA-1; Mon, 26 Jun 2023 07:14:51 -0400
X-MC-Unique: 3xXaImKOOkCgPxd3HkVnFA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fab61bb53bso1007684e87.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778090; x=1690370090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxFcgxnhKliDRkn36lhP8Pf5Rcfhb0VjyF7Bnb87z1w=;
 b=dP+gmuk1Htzs6rv3qoR7h1bbhUV19tL8qKBo4HWr36aS/T1kBaAUwPBU36Za9RHyhl
 8OED9gCkiJx/q+bPF381y6pTI/hYJkJiEBNz5sUxxiflS/TCboGjRgiNC3DH5BoBWDSA
 895w1FkGAI5H9ruM2xsx+c8SEfgJl0KqzCX06YNqJShihLaF+5bfEoMflyosQyIOv7GR
 l15OoRhiWsG9z12Z7bdLGdVqt2CdADUEMzcvTL/x0NjJ9fnDhFm0oPxMyJvLrbLflngf
 g3C2+N9/nZNlnnBSOOGa9nmwpq0qqcrRHd1NYc2RTXiDTnQ9U40XPS9O8Hz/ivnjvBhf
 dJNg==
X-Gm-Message-State: AC+VfDyh8MmcvR3JnBGaMpNftVwU0YeTPgQ61qp5/OQ6slopgTmrL9rS
 Mnelzay8bEyRfT3+v5y73gTGgcN4zuXYjhlnTEBuw4/u7TQ2eFZcOEAx0JUcP0bDZye8obPYJob
 uXtEPk7B4cDddJREXZCwnKReAkvCt2oCiUjJiNTdFNT8NmD/Tn+qia/WMRsSA7sbt5DkIM2Facd
 g=
X-Received: by 2002:a05:6512:3d94:b0:4f9:5d8d:ccb8 with SMTP id
 k20-20020a0565123d9400b004f95d8dccb8mr10374511lfv.17.1687778090029; 
 Mon, 26 Jun 2023 04:14:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LzYlFfQdBmAi16Voz02sz5QODt/SZuW/cj5CToKpRHCUc7VPue8ZsZuxE0KZsz6hmhtVzLg==
X-Received: by 2002:a05:6512:3d94:b0:4f9:5d8d:ccb8 with SMTP id
 k20-20020a0565123d9400b004f95d8dccb8mr10374502lfv.17.1687778089741; 
 Mon, 26 Jun 2023 04:14:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a7bcd8c000000b003fa79af15c7sm10423536wmj.2.2023.06.26.04.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/18] hw/remote/proxy: Remove dubious 'event_notifier-posix.c'
 include
Date: Mon, 26 Jun 2023 13:14:29 +0200
Message-ID: <20230626111445.163573-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

event_notifier-posix.c is registered in meson's util_ss[] source
set, which is built as libqemuutil.a.p library. Both tools and
system emulation binaries are linked with qemuutil, so there is
no point in including this source file.

Introduced in commit bd36adb8df ("multi-process: create IOHUB
object to handle irq").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230606134913.93724-1-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/remote/proxy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 1c7786b52cf..2052d721e5c 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -22,7 +22,6 @@
 #include "qom/object.h"
 #include "qemu/event_notifier.h"
 #include "sysemu/kvm.h"
-#include "util/event_notifier-posix.c"
 
 static void probe_pci_info(PCIDevice *dev, Error **errp);
 static void proxy_device_reset(DeviceState *dev);
-- 
2.41.0


