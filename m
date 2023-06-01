Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66096719EB5
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4icf-00085m-PL; Thu, 01 Jun 2023 09:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4icZ-0007uW-Ke; Thu, 01 Jun 2023 09:45:46 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4icX-000896-If; Thu, 01 Jun 2023 09:45:43 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b1a3fa2cd2so7952381fa.1; 
 Thu, 01 Jun 2023 06:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627139; x=1688219139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=laqE+jDbGMxNloibp38IdoI5cMDWlF6ShBRxAGY56M8=;
 b=lt3cIbG8uWdGBKQTvqaB0Dv2XfYipjQai1dLtFujS8ZnzU89UGzGvOMNAat7E///sE
 QAMkgKQEmudYh3L4VvyWjEVK6cMP9ccl8fXqjQ3K6gAUIqOPWorfQvFk1pl1M32Of5w8
 rnquLzoTDsWmHqnBe3fW9RG+Td5Sxp14Tm48gKuUeNJq1J6ieWumcqv1f4IqFDt/BoR6
 3ufXWsgXQ8qLhbFMGgNQua+US2l6fMq5qThfx/+dsCH5nyTnm9eBEIYpazaCjilH/efY
 s3g8RnuQFCPAcgHsfbzv0q8lMXGa8+qbYJ3PvIcwiHCyAoM8Sr6fahzuuXJAb5D9XUJP
 i57w==
X-Gm-Message-State: AC+VfDyv/IX4uXueDqxA+dOO8Zon99jBqi3Kd9idbDhMb1jUw/VkSoei
 H3aVZlF6abU91cQp9bCRwp5lfVeovG9WUmt6
X-Google-Smtp-Source: ACHHUZ6XElCyJNIqClx1J0XDu4W665uCGGOi1Eg5/RHroRKWHtInHuI10UzIreyz2SxD6HE7IwN1nA==
X-Received: by 2002:a2e:9591:0:b0:2af:21d3:a4ca with SMTP id
 w17-20020a2e9591000000b002af21d3a4camr4871263ljh.47.1685627139235; 
 Thu, 01 Jun 2023 06:45:39 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 o11-20020a2e730b000000b002a8c409f1f5sm3772670ljc.110.2023.06.01.06.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:45:39 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 4134F7A7; Thu,  1 Jun 2023 15:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627136; bh=+7Lfn6Z7q7WKc/uSkZhwLaBrCOUaYvjqYUoBgBJpe9g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RbQk2vsVquc08z9v2k8sQg/fhwAApKnkh7D+tOWm74x0sQszgXzrsX1Kq46rOcq09
 l0p6BpJ9EDguJIWwjcgHeyTGZx6Lnaw1rS1yU0Q+fS7bIaKzYPlMDA1j6PJgcZrCCK
 Wh/e59A2fnxVi/IhgePSqfhIppB0CIGf6qJyGEoQ=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 32E4A4C9;
 Thu,  1 Jun 2023 15:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627116; bh=+7Lfn6Z7q7WKc/uSkZhwLaBrCOUaYvjqYUoBgBJpe9g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZeO5/z/Z+ivdiJ1L3CXM94hHJA+1ipMLowSLEnM49McpDUUIqmyffMmzfBwwde7SV
 plRAz/vVBg8PbWNxKqXfXQScTa/QWQUTq8lwZTubEWFcBFlrslLSDWaZbPD2WBtkWT
 pidddvjgvvLSstzW15muHc1jvzkyvs6LOMQx06VQ=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/8] hw/ide/ahci: remove stray backslash
Date: Thu,  1 Jun 2023 15:44:27 +0200
Message-Id: <20230601134434.519805-2-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
References: <20230601134434.519805-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Niklas Cassel <niklas.cassel@wdc.com>

This backslash obviously does not belong here, so remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4e76d6b191..48d550f633 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -690,7 +690,7 @@ static void ahci_reset_port(AHCIState *s, int port)
 
     s->dev[port].port_state = STATE_RUN;
     if (ide_state->drive_kind == IDE_CD) {
-        ahci_set_signature(d, SATA_SIGNATURE_CDROM);\
+        ahci_set_signature(d, SATA_SIGNATURE_CDROM);
         ide_state->status = SEEK_STAT | WRERR_STAT | READY_STAT;
     } else {
         ahci_set_signature(d, SATA_SIGNATURE_DISK);
-- 
2.40.1


