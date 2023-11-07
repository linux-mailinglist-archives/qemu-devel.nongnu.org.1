Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB27E41D2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0N-0004XL-DK; Tue, 07 Nov 2023 09:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N02-0004GK-JK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzy-0007cI-FG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso3998582f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367049; x=1699971849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inR3fZjIbwH8cw/Ap/zt+XwgU9sqvQ2DjUVl5bVn3nE=;
 b=h8JTu56SfIoWBc2xWr+rcbe4BCGApdVdzIqYS+FPIa10FPEG71vIyD4SsnNiB8Em8p
 bq2SD3y8Qp2BSVSpt/NboYqZMCkuBYlVC/f7UQSIfyKpIMHRy4hIx9cwu8zUGhlaHWjW
 l7UFXnIKlUxVBYNQIMlwk4XwusJAWJRyFpLaNy/nkiQ40rXibpwnQjWwfNbdSSfCOTK3
 zCr9ysDXorp1olRmS4wY1//Nf8Mu6vDyzF+vFZNFoYyTzd8GqvBeAMhGAiOrWQUb1PLK
 hXvv17TflfF6Q71o/dQUWAuI60LzBp1pk3UNR1bRIM6n5Dt/qBRcUp8EmkpQdbvRBNoI
 toPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367049; x=1699971849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inR3fZjIbwH8cw/Ap/zt+XwgU9sqvQ2DjUVl5bVn3nE=;
 b=lXglW0ZVItxgP0ok1J3oJQDIaNPiI4R1JgM01haea3eEFZd220IYR/uY04XLgY9yNw
 Ai8vG4IqN4oavH5f6eNElGR5P7PFWOtU3wF3/TY4htE7WYv1MVWptkfvEeFhUmgabzfV
 K3kCL64T2jBs5MzQl7MqRGHEvoXv7rLnIR/YaOTjEkElFCeFa1Icvayxe7c2Ooquopov
 q5pMP4kYhWfmukppa/RLSxVBMJH9D4JpZ/hfEtTzwH8vvrSml08cOp+RD1bkWcsX25Cr
 JwH2FzLfJ6HSCl3Wt56rxcFJQgWDMkYrgQ4a4Yl0f1y4Lwoy2nmXkMo8637F1qRazyo5
 LZYA==
X-Gm-Message-State: AOJu0Yw83VATNfO5SmyamodQVIe0+IXHElCGd+y01kCJ64ZArAt6qfdj
 0ynwVwpGyRQEYN6SX9nBgGeP8Q==
X-Google-Smtp-Source: AGHT+IG0GJTZRn2wYBMVmFqsn1htLrq7URsc2ls7pODxQi5cT1uYew1awqEl8MchkNvIOnJezBzdFw==
X-Received: by 2002:a5d:5848:0:b0:32f:8a45:937b with SMTP id
 i8-20020a5d5848000000b0032f8a45937bmr24258291wrf.8.1699367049100; 
 Tue, 07 Nov 2023 06:24:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m23-20020a056000025700b0032d886039easm2483973wrz.14.2023.11.07.06.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:24:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE6EE65763;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Manning <gmanning@rapitasystems.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 15/23] plugins: disable lockstep plugin on windows
Date: Tue,  7 Nov 2023 14:23:46 +0000
Message-Id: <20231107142354.3151266-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Greg Manning <gmanning@rapitasystems.com>

The lockstep plugin uses unix sockets and would require a different
communication mechanism to work on Windows.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231102172053.17692-4-gmanning@rapitasystems.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-16-alex.bennee@linaro.org>

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 751fa38619..1783750cf6 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -17,7 +17,13 @@ NAMES += execlog
 NAMES += hotblocks
 NAMES += hotpages
 NAMES += howvec
+
+# The lockstep example communicates using unix sockets,
+# and can't be easily made to work on windows.
+ifneq ($(CONFIG_WIN32),y)
 NAMES += lockstep
+endif
+
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
-- 
2.39.2


