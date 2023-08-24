Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC56D78744C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCKH-0001RO-CN; Thu, 24 Aug 2023 11:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCK0-0001Qc-OK
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCJw-0003RZ-QN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313e742a787so8649f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692891147; x=1693495947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qYdyuRUyB59fnCJVcILwIEL2Oej6/htVufBepr+AMU=;
 b=qc4NdCC/sBDHPYgc43jZCxJzBrao70Jwgren4yBhVL6TPt3JGppRsWWCga2cmIHmez
 U1SjhYcOyiSGl7bQmiYankLQWr9gaf2WRHXwxaGb5ct4PAhohr9uobA0Ut9mImH28ORw
 9RkMhozzpbfPCUKtXti1MggehiWhW7m0tKoIr6vo/im1fAiBgRL2yAMEyMcTeGv/3xlq
 zsNGrYXfZtEk0uwAg/hn0l1DiYSb0L9i2ibbz4yDcZhq6NihJ+lYBF7hP07VwRip4UUe
 pq8Seh9XW+jiqVDX6TER7im8JB6oWJSM8bpchuJNYTJ2644er6bbTf0IFpLGOEkf8iOQ
 i+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692891147; x=1693495947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qYdyuRUyB59fnCJVcILwIEL2Oej6/htVufBepr+AMU=;
 b=QlOIE3QctCvuSE/kbIcpjUeq8x0RQd1JCgaEY4+z9GKj9rat8T/8fA+pq3ObslYSBp
 HV+tET3EAqyrJh49JihjF/aLj8NYoq7F9DOzdYON8GRw3WPq5Uk/1uD7/bRJZ2nOmOL9
 fQysmF2u+5+KcbTzNUI8v6Fa7T/AbxG0B2GCd9dvWzMySIonRSlf24H5R7FSkPv3cyjM
 iYnLv4dGE8WzS597ysrJoxLWDWFJAyclyRKm86CO24Y2yu+uFowYnGiXMUN48PfzFBR2
 FxSI5m7y4C2Waj0fm/kSGkiSmcgedrf2HrWTqWO8Mpgnw/8APMRVlELkj/1MVrwG4kEz
 vehQ==
X-Gm-Message-State: AOJu0YxRRjcrBTcuk4/uz1cpgM714IjadSeW3swqeKwUnT3Fm7d07Lla
 RDohkwgB0LOYCrv8cc80Esl1n8xL73ERo3T/9y4=
X-Google-Smtp-Source: AGHT+IGH+/CE4q7rDBqHEzPX1rINx+126Bq5Fzb1S79SzR9+PIRLOOtdON148EFOjJFtIjIHE+PeNQ==
X-Received: by 2002:adf:e849:0:b0:317:a499:72c8 with SMTP id
 d9-20020adfe849000000b00317a49972c8mr10562895wrn.1.1692891147305; 
 Thu, 24 Aug 2023 08:32:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x4-20020adff0c4000000b003180fdf5589sm22918640wro.6.2023.08.24.08.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:32:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 qemu-ppc@nongnu.org
Subject: [PATCH 3/4] net/dump: Avoid variable length array
Date: Thu, 24 Aug 2023 16:32:23 +0100
Message-Id: <20230824153224.2517486-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824153224.2517486-1-peter.maydell@linaro.org>
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use a g_autofree heap allocation instead of a variable length
array in dump_receive_iov().

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dump.c b/net/dump.c
index 7d05f16ca7a..16073f24582 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -68,7 +68,7 @@ static ssize_t dump_receive_iov(DumpState *s, const struct iovec *iov, int cnt,
     int64_t ts;
     int caplen;
     size_t size = iov_size(iov, cnt) - offset;
-    struct iovec dumpiov[cnt + 1];
+    g_autofree struct iovec *dumpiov = g_new(struct iovec, cnt + 1);
 
     /* Early return in case of previous error. */
     if (s->fd < 0) {
-- 
2.34.1


