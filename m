Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 498D37F097B
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 23:52:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4qdF-0004sd-Rb; Sun, 19 Nov 2023 17:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qdD-0004sQ-CQ
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:51:11 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qdB-0002Bx-JQ
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:51:11 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507973f3b65so5312080e87.3
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 14:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700434267; x=1701039067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E2tt04UpuG6XbqbE1qTCQTpaogMB+9LfwSnlQdSGlHY=;
 b=VqoPUainv4eB7PHm33ASfOi2AtJopmtvf5LkAMxcZ6pjUgRhjj5l8Mrr0ZKxOchqTj
 ZgFkad3hrjEgXmUUha+PHO5aU8lKSbrSdEoqQfWjt/ai2vv7AKg3MVZf5sEuYCuRudqG
 VmSTL2/AyaDPE+JPm7m3/zS9g+omX7rhZ8Meqi4MXn0c1+k+mmN+SkiSbN/FUBnI+5gc
 sev6fqeSny0YW58ytBvsWQwfDuvKk4/LZ/olYU1h0s7p+S8JEZqil7eLCcYNjLcbHwiA
 A0zCRPSZV4XqrAkhdBNifA1D6oLt4UKPpi8sXtSKqKp2rXeRO6XDNhHN4i8/fhxOViWX
 n4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700434267; x=1701039067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E2tt04UpuG6XbqbE1qTCQTpaogMB+9LfwSnlQdSGlHY=;
 b=UCOAZF2tnuGsoo1WmHplQgpbJrNSRI5NL8/iSEgSBkxwXWUfL8VMyrev/vqIzUW8h4
 tqkyaF6E/uur7/58lCfaCFHteIDrJQ4YRXbmCtH+R44gmzFsdL633Bltq1xgDT3ByRNE
 4ZDLcpi81OZC00zlvoSvPztk8ER6+MFQrGiPHGGskS/hdk7OjFnFaOuLMaJA8O9kdCWu
 OCgk7NylUBRYJILYycACr4dVH4FlREA8IchnKPK0G8W0s+UJ2hW+D9Tq7FAARj3IhJb4
 I1Ap6TFcmjrYC3HcgaERkeA29xF1OImC1mCQMC2nd6UG4layRT2oGGLukpRCcfdRQ9rY
 yv/Q==
X-Gm-Message-State: AOJu0YxGDjyhdYIw3TyqijiOwi8rg7YSZEWCo2vaCy29WJkM9ISgmCjY
 iio4YVGWOKTSv83rrvDGW+JmDYtdETMhPDTmwZc=
X-Google-Smtp-Source: AGHT+IHBx7ealZbgOV9F66r/1+IAFYeGEf58zczvEyE1Yb1SHrgOOV7quHbmcLevIz4qiWON/oujnA==
X-Received: by 2002:a05:6512:2112:b0:503:36cb:5438 with SMTP id
 q18-20020a056512211200b0050336cb5438mr3429202lfr.21.1700434265933; 
 Sun, 19 Nov 2023 14:51:05 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.133])
 by smtp.gmail.com with ESMTPSA id
 q3-20020aa7cc03000000b0054847e78203sm2710430edt.29.2023.11.19.14.51.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Nov 2023 14:51:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Kochkov <anton.kochkov@proton.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>, Jason Wang <jasowang@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2 v2 0/2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping FIFOs
Date: Sun, 19 Nov 2023 23:51:00 +0100
Message-ID: <20231119225102.49227-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Fix a pair of fuzzed bugs.

Patch #1 is reviewed, #2 is new.

Tested with the CAN tests from 'make check-qtest-aarch64'.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  hw/net/can/xlnx-zynqmp: Avoid underflow while popping TX FIFOs
  hw/net/can/xlnx-zynqmp: Avoid underflow while popping RX FIFO

 hw/net/can/xlnx-zynqmp-can.c | 66 ++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 11 deletions(-)

-- 
2.41.0


