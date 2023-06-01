Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D5719EAE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4icj-0008B8-MX; Thu, 01 Jun 2023 09:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4icf-00086S-Qh; Thu, 01 Jun 2023 09:45:50 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4icd-00089l-Rp; Thu, 01 Jun 2023 09:45:49 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f4db9987f8so2710772e87.1; 
 Thu, 01 Jun 2023 06:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627146; x=1688219146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cy91cBRqAqiwy9cOS34w2pZldiLcmYPrCZe3pVyd0X4=;
 b=UTge0G6gMBxeN3HRjzrCo5OyanpXxNF5KutLOrat+PS3KCMfy19i+a4E9drzYHV8Tx
 o8YDeLKhccLFAqwigKOeZDEqDDdqpjpdToA/he0oHSdYT7k6adLH7qK6eyxcatCpx0sy
 Q6UqXAeJZHGpC/P80cy3VD6ZduCx4hMXjAHreFTg/rhmbGMvpqWVk6KTSaMDpRC0swwE
 7/tqQ51yiT0i3PqFujtCSzqk73lln1IEJt1LYVVN1CC9hxlIcvRvAlTJRXtcxWGfX9Yn
 OC5u1ujs906y85EuFoW8EiRi4CjnD5JlYU23Qn6Gf8DNhDPDvLo6ZGrzqaaZ9sdVcAAO
 KlRA==
X-Gm-Message-State: AC+VfDwJcPBucRCDCibcX+Ol9FsLzt66lWywRNacg3nL91W52XRQM4dQ
 AXadsdz07oL0ZegL71kN0vExLvwbwj31B5bw
X-Google-Smtp-Source: ACHHUZ54jJTPW/7vcHJEiiziFFE4xHgUEcSDtHoNaA+07y5AoD6H+ajva6eQPeNsfjTps1Ya0MLBcQ==
X-Received: by 2002:a05:6512:128f:b0:4f3:7889:7603 with SMTP id
 u15-20020a056512128f00b004f378897603mr732954lfs.24.1685627145611; 
 Thu, 01 Jun 2023 06:45:45 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 v25-20020a197419000000b004f019d3eab4sm1098438lfe.23.2023.06.01.06.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:45:45 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 7F8D79AF; Thu,  1 Jun 2023 15:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627144; bh=DZ5fMdq9LwskNjWpW+fDBE+ZAvAUizJvqdAFmYrDvXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QfNwrfKuk034MQfXnNgYBZU72/R/IVJKYF67nHmOVHmFbWuX8V1RbDTMGUg29M9sD
 4PtR2tl0zHFeosuFPij5XtwlCJcMtjU5j3RJJ0oNZDWXypJb1z6mbxK3Nl+4u6+FJA
 0shgnkreuOGADGy02OMLazHuqR8gMipa8Ld39wdU=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 890776B1;
 Thu,  1 Jun 2023 15:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627123; bh=DZ5fMdq9LwskNjWpW+fDBE+ZAvAUizJvqdAFmYrDvXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=glzonshqe6WAvLqfb2JnDxAJsHCzpEtSZ7iEw4P2n1V89DXvpg0QZmCkIzbSYQjrm
 ozc34vwH3ctLrPm4L/sdNEPdAkeLgjmYYyjp6jfGkQ0zMxGuzk7/PPxir7EM2qcKUd
 EcUOEHD0UFn5oDoM+D1Wf5lG1PfO5IPkl1kLgLvg=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 2/8] hw/ide/core: set ERR_STAT in unsupported command
 completion
Date: Thu,  1 Jun 2023 15:44:28 +0200
Message-Id: <20230601134434.519805-3-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
References: <20230601134434.519805-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x12b.google.com
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

Currently, the first time sending an unsupported command
(e.g. READ LOG DMA EXT) will not have ERR_STAT set in the completion.
Sending the unsupported command again, will correctly have ERR_STAT set.

When ide_cmd_permitted() returns false, it calls ide_abort_command().
ide_abort_command() first calls ide_transfer_stop(), which will call
ide_transfer_halt() and ide_cmd_done(), after that ide_abort_command()
sets ERR_STAT in status.

ide_cmd_done() for AHCI will call ahci_write_fis_d2h() which writes the
current status in the FIS, and raises an IRQ. (The status here will not
have ERR_STAT set!).

Thus, we cannot call ide_transfer_stop() before setting ERR_STAT, as
ide_transfer_stop() will result in the FIS being written and an IRQ
being raised.

The reason why it works the second time, is that ERR_STAT will still
be set from the previous command, so when writing the FIS, the
completion will correctly have ERR_STAT set.

Set ERR_STAT before writing the FIS (calling cmd_done), so that we will
raise an error IRQ correctly when receiving an unsupported command.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index de48ff9f86..07971c0218 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -533,9 +533,9 @@ BlockAIOCB *ide_issue_trim(
 
 void ide_abort_command(IDEState *s)
 {
-    ide_transfer_stop(s);
     s->status = READY_STAT | ERR_STAT;
     s->error = ABRT_ERR;
+    ide_transfer_stop(s);
 }
 
 static void ide_set_retry(IDEState *s)
-- 
2.40.1


