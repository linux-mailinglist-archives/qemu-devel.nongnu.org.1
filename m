Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160076BFAA
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKL-0003s6-6h; Tue, 01 Aug 2023 17:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKJ-0003rj-GU
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKH-0004nM-E1
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-316feb137a7so6290440f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926884; x=1691531684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+Ia2IW7W0o2NfDvv7wb0werH1oj3pCGRYKiA4thOho=;
 b=mjl49F/dE4gTtMfYJljruuqsJE3gVhRP6+acpgpCEERYeJyuBI5zOHIjdYseaLdmft
 WJuXvtjyNjaJJukwF+TL2Q79rSHb/QGEAo9RweH3AmGpVocyLzqq2Oyy5/tVJp/Rf84s
 vOGm8HMb2XKFHr56z5K7WZ5dzgIvz48bZFyCaVmmOOGhsy4Q+4uWqzSJ4hGvU7yWHrBM
 jbq8bE5k2D1BvGwPqDz2/u17nTBpZOIgYB4F1ElS6QQbLnurV7xD1J8ZqYBH06v5hW9q
 ywMUHxhGc3DoztPwk5oUYIFx0aSpU7XeHiTqIhzFPbDmVA0nOvlM/O1XydU6b4dkRSTC
 focg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926884; x=1691531684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+Ia2IW7W0o2NfDvv7wb0werH1oj3pCGRYKiA4thOho=;
 b=UcrElQt21Stk17E/hqH0AN78MXncvVL9YUDhEht8MOtYWgsI1Hyw5VidtypKBEcg6U
 3S8RXqkJlxg99EBZIy12K6thibDxUMbfPtDo3GWdmca2YaDsMNdYjopMDG3zUAE4gmGn
 KpVVOV1K/d26SxSLHPwjhyT4Z9SJOF7tz3xg+/46hZ62QBelj3jMENlMf5kM7y0Gz8ET
 8vlDaoldKc944frh/rRv3Kic9zOYINdu+fqWRnpzGDtIrguNpqJSNoxg9T4nVLTRdxcP
 ladvHN5VHTD2yQ5A++ns5GXZDH6Wu8l7yjHY/zM2CRitncpgsdNPySFaPuh+N/iZ8a1Z
 HOAg==
X-Gm-Message-State: ABy/qLZhGO1PYedurjPWT+koF5Jps/9EhvjGh7/Q3oMv/FLvX2keDMIl
 nz9zVbSKTdbVJT91ZhM6SuDFn86MZY/16YsWgnU=
X-Google-Smtp-Source: APBJJlHAKX2/RZ5gEOgeTER35FeHxbDWYqJ98uMOfI+x8Ag7mjxuKd4a4l3rUZv6H5RvGaXtoTu1Qg==
X-Received: by 2002:adf:d4cc:0:b0:317:6513:da7c with SMTP id
 w12-20020adfd4cc000000b003176513da7cmr3119817wrk.18.1690926883691; 
 Tue, 01 Aug 2023 14:54:43 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 bf10-20020a0560001cca00b0031432f1528csm17143007wrb.45.2023.08.01.14.54.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:54:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/10] hw/xen: prevent guest from binding loopback event
 channel to itself
Date: Tue,  1 Aug 2023 23:54:14 +0200
Message-Id: <20230801215421.60133-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Fuzzing showed that a guest could bind an interdomain port to itself, by
guessing the next port to be allocated and putting that as the 'remote'
port number. By chance, that works because the newly-allocated port has
type EVTCHNSTAT_unbound. It shouldn't.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20230801175747.145906-4-dwmw2@infradead.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/xen_evtchn.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 0e9c108614..a731738411 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1408,8 +1408,15 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdomain)
         XenEvtchnPort *rp = &s->port_table[interdomain->remote_port];
         XenEvtchnPort *lp = &s->port_table[interdomain->local_port];
 
-        if (rp->type == EVTCHNSTAT_unbound && rp->type_val == 0) {
-            /* It's a match! */
+        /*
+         * The 'remote' port for loopback must be an unbound port allocated for
+         * communication with the local domain (as indicated by rp->type_val
+         * being zero, not PORT_INFO_TYPEVAL_REMOTE_QEMU), and must *not* be
+         * the port that was just allocated for the local end.
+         */
+        if (interdomain->local_port != interdomain->remote_port &&
+            rp->type == EVTCHNSTAT_unbound && rp->type_val == 0) {
+
             rp->type = EVTCHNSTAT_interdomain;
             rp->type_val = interdomain->local_port;
 
-- 
2.38.1


