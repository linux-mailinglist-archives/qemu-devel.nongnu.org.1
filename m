Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 097077E41E7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:35:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N9h-0003eT-9d; Tue, 07 Nov 2023 09:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9O-0003Tk-Ai
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:33:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9G-0001R3-J6
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:33:52 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40839807e82so35557055e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367615; x=1699972415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpsihFCzeaecJeI7EXhK/H8QboILEAf1e/mR+Z/Ju44=;
 b=PwEI+2TTw0Fgu0tLRQCx17d+OQRhgI/RYvatK3MiLz6BKbRAY3uyAxkTrHL87uoNCA
 xfFB4r70V2S5RED63IT3IupwndKo8wfFNn2m2mJpEGsSGqQkKCEYwhaZFtYN9KGLSRLr
 Ch7sfK0jZdNUvt8ZXxPiS9WsmzifFz3z/pWwr4ep7sL566tYxlyZeTCypB1wKRBMau/N
 qoOz35EPibFw1zsmEtfpnmHEX9AK8DPcutboEf/O1y0JiQHbrXP7cAjBoHtAvs4nP4aE
 EnWrvgIczwCCVgqxrG90YyAVBKKzyxGVIuUNQB/BJvJ8RicVQvftT6GNaHRPD7yTYtDe
 UsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367615; x=1699972415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpsihFCzeaecJeI7EXhK/H8QboILEAf1e/mR+Z/Ju44=;
 b=J5Dl+RsVtVLYkN+g+/J/t6b3SLJZNpWFh/p8UTquBDTEG1yj/kf1rQg4ri32Q6Mipw
 Q50M1ym0Wb7fTAz0RPWPhew2itck9zDXehkdmP25P6pGBAEgTk/6FR/zJIU5uuAinT6k
 DLR0TcP9hmR0XdFQ6zWEY9NOOgpGbfknbvl4Aa0f05BZ9gYKmeFfTzkbN8+7glTMKfkO
 57gFLNQucuodtVdbrf5878efueF8hkhjZEV4fKfxdrlGZY+lT34KVHj8jV3xXNTLt8op
 xyw/W7SvZb7CsiYXrlgZIhLdLsOigPOQWh8UIhME/0TRhLSyo3HL81ewqA5LCFldvfAk
 SZDQ==
X-Gm-Message-State: AOJu0YyXeJJzw5pta/D9m4u+VoYTZpihb3uYPvQEoMoGUHWneuNENB4h
 2Eqc5CKIG5+t3makBKPpcHn3pr82MjroHSaPYxtlKA==
X-Google-Smtp-Source: AGHT+IGlrm1o8s51yVdJsmODkGn6rbjlXOCveu2BDcuv8cK/sxRod5+yENnSgYHQqWToULIq00M/RA==
X-Received: by 2002:a7b:c5d7:0:b0:408:37aa:774a with SMTP id
 n23-20020a7bc5d7000000b0040837aa774amr3522204wmk.17.1699367614878; 
 Tue, 07 Nov 2023 06:33:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m23-20020a05600c461700b004060f0a0fdbsm15457473wmo.41.2023.11.07.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:33:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A1B56576B;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 21/23] contrib/gitdm: add Daynix to domain-map
Date: Tue,  7 Nov 2023 14:23:52 +0000
Message-Id: <20231107142354.3151266-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Daynix describes itself as a cloud technology company so I assume
employee contributions should count as such.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-21-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 42571fc1c4..bf1dce03fd 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -17,6 +17,7 @@ cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 crudebyte.com   Crudebyte
 chinatelecom.cn China Telecom
+daynix.com      Daynix
 eldorado.org.br Instituto de Pesquisas Eldorado
 fb.com          Facebook
 fujitsu.com     Fujitsu
-- 
2.39.2


