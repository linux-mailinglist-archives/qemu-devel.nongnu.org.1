Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E220F81AD6B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9g3-0004Yv-CU; Wed, 20 Dec 2023 22:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9g1-0004FH-3n
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:49 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fz-00011j-D5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:48 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-781120575f5so21001885a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129086; x=1703733886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbecgr9JC3ST7n8wppu7ltseAYSc7D1Ylz9MnsTxWiQ=;
 b=bvHV5j7BC+mrmyS2c6j0UKhJCubrKX5nDHrSjD5cVnF9ERna3YfnnWa6rxDj63FfUj
 GH8tUmnxcj2gDaNWaHbxIr9lafEh+P/eLdt6RzmHv5r4eVFwZt1tJNFzTInGPSOnGt3U
 WRB2joZVgxqB6gp1HWcRi3VMmbDyl0XUxSXWgb5AOxcnnmdd2O9RpssNs3MEZKWMTsAi
 G5jw8DfzGXm8GfuBunjT35idQf2CdP3xZVckyemLXsqgvKrCuQ4p54EOdcc+5/9GMZCS
 9Efyu+01s3k3G6ZenHdTVxjM3tMWe8pbKNzsFRq4Hub3C2lh1v0GF1AE1U2qff+R3B4r
 F8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129086; x=1703733886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbecgr9JC3ST7n8wppu7ltseAYSc7D1Ylz9MnsTxWiQ=;
 b=nD2BAHglx2Hyg0Yg7bB5VoT9/vWBMuzbUMgbIDCFS2pu29XHdVFJWgCE9EMMjMRthX
 TkZTLlgoABj5CAM9Fkmwl0cD6JlmdRaalPJ1PH6sckVyLpt3kr5E1ah/xD/m7mXpFecp
 3Efzf9NQl8ZWECR8plvPilS5no3btqjtjTATb4nrFugYc4Qi+Xuf0YHnzK3er89Z9s79
 XNsFjnGC8cIiTgkG0KK2jUdtYnIljuC27/UpJD9peNuovetP5KYpG68h8ETtWwJhVg83
 9G+VyiLSsFvZ42fTDIBmntzMHLZkGni4bph7YAOa0cKAOcmcEHMdDndMyVcHxG63+NlT
 D9qg==
X-Gm-Message-State: AOJu0YypajTPBVdOvYTkh4GeoLuDk3F2ssi3DBX7V5YPD/kcdomhnOYw
 jk+/h5G2lpQaWWd7w/6GWTSvHTCEQoGj3ir+gJ8853Pm
X-Google-Smtp-Source: AGHT+IElfl0NSsG/WOK/9pWkTxhThlYYRVlkSIuf/PD/w7wKhIg5b9+x3UXacnlFqNT3bcmnz5tdXg==
X-Received: by 2002:a05:6214:20e3:b0:67f:4926:60c0 with SMTP id
 3-20020a05621420e300b0067f492660c0mr7429056qvk.1.1703129086550; 
 Wed, 20 Dec 2023 19:24:46 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 69/71] util/fifo8: Constify VMState
Date: Thu, 21 Dec 2023 14:16:50 +1100
Message-Id: <20231221031652.119827-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/fifo8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index d4d1c135e0..de8fd0f1c5 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -109,7 +109,7 @@ const VMStateDescription vmstate_fifo8 = {
     .name = "Fifo8",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VBUFFER_UINT32(data, Fifo8, 1, NULL, capacity),
         VMSTATE_UINT32(head, Fifo8),
         VMSTATE_UINT32(num, Fifo8),
-- 
2.34.1


