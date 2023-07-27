Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00F765748
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2aN-0001CE-5f; Thu, 27 Jul 2023 11:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP2a8-0001BO-9I
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:07:13 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP2a5-0000Me-J2
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:07:10 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b9540031acso17014031fa.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690470428; x=1691075228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TNqurY0rUHeNdsZsiViYGt28p6dzwriboasUAovzxOw=;
 b=T184Cx35+AxKDV8k/Ri/jkEVjRDQu9aWHHiYvakkP9KdVg6OO3N8S/6woY44HWkFap
 f/28Ux0phI7omqNLVLx3FI7JIauRLxXCIO/XiibiLld/xBTehM1QHjgRxcA0wr3Omfhk
 DV9QeF7erNv9LYV7Qm8D6/Wm944VvhbZuLZp9eSe+5OOXmK4VH5L8TiKEB17b9fE3io6
 UrZhjUcheRoHv2IC/obcicsHdAiLUBXteNf9Z45cfeYaHpmqnOIDqab+GK14YYu0ojFF
 vQcVoryjez/19AcdZfzvjlMScW2Rw1/c+p3Y6cniB3QWewQk24n21TKUSSrhZG+Xb0si
 C8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690470428; x=1691075228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TNqurY0rUHeNdsZsiViYGt28p6dzwriboasUAovzxOw=;
 b=RyCwgUCBVx1W4aTNVAwEG47H0d70JvOd/J7Zqm1Q+pwM0TMsNmOs4OwnLJd+vhYgKW
 piPo1soGMQHQRfA6NOSiTt7NIGxG6FBxxu1TFUUW4EFpzGTRw7sdC065kq0oj6CImoGT
 Ctkmp6bS4tiCVIx5KZzZVFtNNSj20kOrAwcOEr9dKsyMMGzYU1BHMmhvTiy2ns34MRD5
 uoH3A5KcVKX2/67eZycCD9vH2mNHx0K4woKr/4lizLmoi6/9+/xOKZ4YVq3BJekyZTB6
 XhmnDbThDWO3Bp+vz1JDtvL6t4yvW7+XEA6ArM2My5oPheiHJtdUlCSnkf5oyVaLDAeX
 lXZQ==
X-Gm-Message-State: ABy/qLYgEq7LybOGIwelXwDkXRiE1pdkVpDni+TOIF/hYr+iuEsrxsf7
 2n9r3jpY2YBbloaK6GIRTBQ9hdCHHKfwFBalWa4=
X-Google-Smtp-Source: APBJJlHe8LB9bo0rx8whYYGpsa707dxZ8adUPZqQTvmvVm7N1NJ/NFR4ZWmz4XtmAxfxf3nNwNY1zw==
X-Received: by 2002:a2e:88c9:0:b0:2b9:6d6e:df5c with SMTP id
 a9-20020a2e88c9000000b002b96d6edf5cmr1992941ljk.5.1690470427851; 
 Thu, 27 Jul 2023 08:07:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i15-20020adffdcf000000b003145559a691sm2323498wrs.41.2023.07.27.08.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 08:07:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] block/iscsi: Document why we use raw malloc()
Date: Thu, 27 Jul 2023 16:07:05 +0100
Message-Id: <20230727150705.2664464-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

In block/iscsi.c we use a raw malloc() call, which is unusual
given the project standard is to use the glib memory allocation
functions. Document why we do so, to avoid it being converted
to g_malloc() by mistake.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
There aren't many uses of raw malloc() in the codebase
other than third-party library sourcecode. Mostly we have
a comment noting when we're doing it deliberately.
---
 block/iscsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 34f97ab6460..5640c8b5657 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1058,6 +1058,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
         return NULL;
     }
 
+    /* Must use malloc(): this is freed via scsi_free_scsi_task() */
     acb->task = malloc(sizeof(struct scsi_task));
     if (acb->task == NULL) {
         error_report("iSCSI: Failed to allocate task for scsi command. %s",
-- 
2.34.1


