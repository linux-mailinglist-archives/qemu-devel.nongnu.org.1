Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C852482F12A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:15:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7G-0006co-TZ; Tue, 16 Jan 2024 10:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7D-0006bZ-TM
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl79-0005pK-Pr
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:35 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e87d07c07so42245e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417950; x=1706022750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SScbRSdHLdETXW89TnfIltt7SofqN6SCYQfgIoU2I1c=;
 b=fkFL6fgYGoqdpj1M3XCbWMUOj/dewlaH7TMK8xUh8We8BX3JJKb28NpLdAVh0zeodf
 jfHu4fHBSGE/OUPzxN4QALS1RHLGk2PYy5qsnTBuj5vA1c395JzYG5lq3dVSx5fvVb47
 5qDQa5Lh37jyOCPlZozadpRf2UnSGCWRPLpcLwQq8LtyZys40EtiaAtgmEhbuhUzD0du
 DJsYKxEHxqU0duHmg/aHaPRP2+IZvhqecaNPUm3z7EXvBplq+chb4Zu1ey6XYqcty8l3
 CGTWZdg4to5B1iQGV3UxgZf5zKFgxGEtWvgZWoJaxgTNAQ43DsFd5e997JuW8251R6qu
 FxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417950; x=1706022750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SScbRSdHLdETXW89TnfIltt7SofqN6SCYQfgIoU2I1c=;
 b=hqS4y5U3DLmmeHDpjSbYZDkeoHOm7Fnxxjm7zwlg5TRi9hdrWnVHvsxucKZW3T1C3j
 m4FJnjhX19aaeVJwM3cuB1ircDHtvc2Su4Kz2p2C7M0BkZvp9PhXYNnn6RutBHP2C/wF
 W9k4MvLYFBrNyMxVBTfOeCpeiY79Sp4FSX2xypWVSTJw+RHADbuKNmKti5zJT6V+6qV8
 7XODIgtDWwAKkdjxlM+MDTh5T2qLwGbDPeucWN/IzM9NrLaLDzh0ntjg352uanQfBSzG
 DF3yEE7wRysIDhxie283tttworKi7887tdp24ZBkebHut4FXMJBuGLTe7P0C/BtSelgc
 wJXA==
X-Gm-Message-State: AOJu0Yyqo52NE4tBqAoONHP0usJD6jl03XiCSp5VibDqzT6BJpm2rqgP
 nGSQjxQIjUNmfQ87e6NdCAZDHcBZD4Q5QDA9X1+KM10s5+k=
X-Google-Smtp-Source: AGHT+IFaDhAAh5ifHE4nFN9hpXUEZBg5fk3dU9x0fVGqYmGZghTkmZW4Fyfo7AZzPrt+SdiLys0JjA==
X-Received: by 2002:a05:600c:154c:b0:40e:6279:9690 with SMTP id
 f12-20020a05600c154c00b0040e62799690mr4092640wmg.119.1705417950539; 
 Tue, 16 Jan 2024 07:12:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/21] docs/system/arm/virt.rst: Improve 'highmem' option docs
Date: Tue, 16 Jan 2024 15:12:10 +0000
Message-Id: <20240116151228.2430754-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Improve the 'highmem' option docs to note that by default we assume
that a 32-bit kernel on an LPAE-capable CPU has LPAE enabled, and
what the consequences are.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20240109170834.1387457-1-peter.maydell@linaro.org
---
 docs/system/arm/virt.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 7c4c80180c6..c245c52b7ac 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -96,7 +96,13 @@ mte
 highmem
   Set ``on``/``off`` to enable/disable placing devices and RAM in physical
   address space above 32 bits. The default is ``on`` for machine types
-  later than ``virt-2.12``.
+  later than ``virt-2.12`` when the CPU supports an address space
+  bigger than 32 bits (i.e. 64-bit CPUs, and 32-bit CPUs with the
+  Large Physical Address Extension (LPAE) feature). If you want to
+  boot a 32-bit kernel which does not have ``CONFIG_LPAE`` enabled on
+  a CPU type which implements LPAE, you will need to manually set
+  this to ``off``; otherwise some devices, such as the PCI controller,
+  will not be accessible.
 
 compact-highmem
   Set ``on``/``off`` to enable/disable the compact layout for high memory regions.
-- 
2.34.1


