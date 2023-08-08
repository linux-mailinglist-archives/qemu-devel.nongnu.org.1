Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D46773918
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 10:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTIBf-0004J4-TS; Tue, 08 Aug 2023 04:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBd-0004Il-Op; Tue, 08 Aug 2023 04:35:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBc-0004Pj-8J; Tue, 08 Aug 2023 04:35:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686bc261111so3794522b3a.3; 
 Tue, 08 Aug 2023 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691483726; x=1692088526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeZsdW9RrDxftsXWNXn4yVwofdvv4noPLkLlvvyTocE=;
 b=soRr9ww82/69hmP+dJZMS7t0KqzKE2DwxBBkVVnq/Req+FCygD/fHatrAd366vLdD7
 tfmjVpc/iBfzKcDi1577tHxjFt+i6k9yR6+oPbzHbO+ov64uuFXM+UKYCZpbip03cU4O
 2CU5/yoc4lyKUwpIfqvzdplQKJkn9FVCgRKRMetMnBlUGL8sO9KpMWcxZHATV8DsuqxN
 CnCSwRVdQy0lnyYZGnIViZ1CEa+BHnlMVFnBlWPfxhCZxWGdKZCSkWbfbyo821xHfUeK
 1THQ+84RkdFm9VYd5LeKti0lEkEgtWjNSa1xg9OSdo50lgBr/Es8CWoGFHczdTS1a8W9
 zUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691483726; x=1692088526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GeZsdW9RrDxftsXWNXn4yVwofdvv4noPLkLlvvyTocE=;
 b=llG9rf2Emuh5MaXxL75PI3qq+z2x5K0q6yidXqr6yFg7wZCBCb9UxBsW4P9q9d5jY6
 sWfii0erDcUJsAUKhW8Cjgvvc4ST/sqzJYnpm52+tDFL6enoPAPbEL9FeBAUH220XtM5
 HXqScJ/dVaF4PlIPa55GAp0iIA1jj1fENcstPWxZqKJm/OfaXXTaRy2vuwggqEqdQrmE
 cHJykef9fkVnpSsU9I9riHrVn5TcEOZFgNcZxzBmFFszUSAVpdxejdazvN3eZl0uWe1M
 Twff9nCo/JuxxPwh5kzbNBeqRXkbxtLycqN+Bf/PnhOfjOyYLqVC3rEm8HrKCaRsChRU
 td/w==
X-Gm-Message-State: AOJu0YwNHspg0GfjKpC3uLvhut5otDoTvzvA5oEu52+7cOyB3Y0wvCDT
 BMVceNiBIhnxVnCS5RN6HIw=
X-Google-Smtp-Source: AGHT+IGZUiR6B0qYtV0ubeGAIfZBTh+bmgtviXJ6WtEY7NTg8J5ufMW/icwQRGIhvVBXobWCWcouDg==
X-Received: by 2002:a05:6a21:7785:b0:132:d029:e2d7 with SMTP id
 bd5-20020a056a21778500b00132d029e2d7mr10683014pzc.55.1691483726506; 
 Tue, 08 Aug 2023 01:35:26 -0700 (PDT)
Received: from voyager.lan ([45.124.203.19]) by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001b8062c1db3sm8368112plf.82.2023.08.08.01.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 01:35:25 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 3/3] HACK: pnv/lpc: Set up XSCOM dt for P9
Date: Tue,  8 Aug 2023 18:04:45 +0930
Message-Id: <20230808083445.4613-4-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808083445.4613-1-joel@jms.id.au>
References: <20230808083445.4613-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

To test qemu's model of the xscom interface, apply this patch to qemu
and the following change to skiboot:

  --- a/hw/lpc.c
  +++ b/hw/lpc.c
  @@ -1266,7 +1266,7 @@ static void lpc_init_chip_p9(struct dt_node *opb_node)
          lpc = zalloc(sizeof(struct lpcm));
          assert(lpc);
          lpc->chip_id = gcid;
  -       lpc->mbase = (void *)addr;
  +       lpc->xbase = dt_get_address(lpc_node, 0, NULL);
          lpc->fw_idsel = 0xff;
          lpc->fw_rdsz = 0xff;
          lpc->node = lpc_node;

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv_lpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 6c6a3134087f..62ab688407a3 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -218,6 +218,11 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset, uint64_t lpcm_addr,
     offset = fdt_add_subnode(fdt, lpcm_offset, name);
     _FDT(offset);
     g_free(name);
+    uint32_t lpc_pcba = PNV9_XSCOM_LPC_BASE;
+    reg[0] = cpu_to_be32(lpc_pcba);
+    reg[1] = cpu_to_be32(PNV_XSCOM_LPC_SIZE);
+
+    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
     _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
     _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
     _FDT((fdt_setprop(fdt, offset, "compatible", lpc_compat,
-- 
2.40.1


