Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B83E78744E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:34:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCKM-0001dy-6u; Thu, 24 Aug 2023 11:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCK2-0001RJ-B5
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCJx-0003Rk-FL
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so33549555e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692891148; x=1693495948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MJwmp/YT87omTafaKV+iKF01Q0/GZOVi91ih3V6Y9c=;
 b=snhFSuRqMgrk+13ZJHN5POLH8fH1pGmd60/+cLqKATpWWi37mSxz1N9rRa4cIEhCdm
 GFKth4UkfYUz1ELvzCwGR7J8nqNcNOPa0OpqRiKceERQb7suwZIdA/+rcg8htk2Xnj6+
 aqwMY66U1ItNfjxkJu5208iKIMKUk0tpliaOi8fH31lCSJVnCM8E8Y2rj/ROkUUAi01R
 Hu1MK3bcpF/A4zheNUOnYhSKPJkEYsPQM/1wDkDvoitip8H/3UR9mhbs+21Wqt+V51hT
 R/v7na6hE3DOvfnCr1RH1PMlxhFlXwPMUy4H5YPdAawxUCtu6XrRJPc/31fRBlfE+ZVT
 jCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692891148; x=1693495948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MJwmp/YT87omTafaKV+iKF01Q0/GZOVi91ih3V6Y9c=;
 b=gUYr61zI9BK7e32cI+GjIGssSB9C77VYihLMc/KoSKN+krEswtqG7+RZ7F09k5FpPt
 x5g+C+ZIco7BQe5f7tSMebu4oKzVrsQBk3KM0mpijgRpJ1095v6xmQkH1aLozQqkjzBd
 7EXy+Xfn/VnXysg7JnoqRBBV7T89lyZXmUwhg+1SIgFua9p0/H2tTcMVzcZyxB/MpTlG
 jhnjyNodvd4JW9eRpLn1clVVbrYmw+Q5LOm1/v1/Eq7fLsNfnI5Zi53Q6xaYJ8urjf7V
 BGxp1f+5nBonqM71pJxrAztJg6zhVecllFm6+zfo7aDfQImrMa8ehFc8oGh39AZlN0rW
 /fbg==
X-Gm-Message-State: AOJu0YwVxdaXzUGQ7EEEB82u/9jI4eEv4sTxBN9XX88Bdc3Sr6IyDgUd
 aH/MqKs2tvSxt0xpNPaDUqlivZrMww9AvN/G8ZA=
X-Google-Smtp-Source: AGHT+IFNNLkZZHC6rb+AQ/+JZ5irkYYaVhrtUF8eurKftzkzgydvgFyH9H0nUdzvMhB1nuTOtwB/UA==
X-Received: by 2002:adf:e645:0:b0:31a:d90e:42cd with SMTP id
 b5-20020adfe645000000b0031ad90e42cdmr12474790wrn.35.1692891147894; 
 Thu, 24 Aug 2023 08:32:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x4-20020adff0c4000000b003180fdf5589sm22918640wro.6.2023.08.24.08.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:32:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 qemu-ppc@nongnu.org
Subject: [PATCH 4/4] net/tap: Avoid variable-length array
Date: Thu, 24 Aug 2023 16:32:24 +0100
Message-Id: <20230824153224.2517486-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824153224.2517486-1-peter.maydell@linaro.org>
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use a heap allocation instead of a variable length array in
tap_receive_iov().

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 1bf085d4228..34b1e3f0918 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -117,10 +117,11 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
-    struct iovec iov_copy[iovcnt + 1];
+    g_autofree struct iovec *iov_copy = NULL;
     struct virtio_net_hdr_mrg_rxbuf hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
+        iov_copy = g_new(struct iovec, iovcnt + 1);
         iov_copy[0].iov_base = &hdr;
         iov_copy[0].iov_len =  s->host_vnet_hdr_len;
         memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
-- 
2.34.1


