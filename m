Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE57E1AE8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdv-0002WB-7L; Mon, 06 Nov 2023 02:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd0-0000c6-PS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcf-0001z2-18
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:14 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5b7f3f470a9so2644750a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254127; x=1699858927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/6+wUvz6WQxJre4NGPMzqEP8t8qfLRBNDzheCSvrJw=;
 b=fgRraoEZ9evWIr4MdGOLKpuZsfrXfH2bmPY+W+9+n6vYsGTfSq6CV8BEpLXG/xGrv8
 OegVYtAprkolRRq84hzYhXcyfD38TE1PNZUOrlXnHHI2lCubyUbv1dHobbmV55gqs4WS
 vccf69EF9fs870w8Odoh/X3O7lak+r0Gs4YrBjolpludJTZU/ZCcI3ybTASdoz31r9z0
 ciB3XqOx/iZaaZNQiAVuwKadmOy/C3IEqXHTDoTX3FOahfnAWbB5ng4fsNtBGUqs/590
 1BG+AY8XfCZv/kFiJ4U1EBlL9rPSzyPLKPvSn1xFKa5LNsUTCDFO1eY9LldEf8mF5f5w
 ArLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254127; x=1699858927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/6+wUvz6WQxJre4NGPMzqEP8t8qfLRBNDzheCSvrJw=;
 b=a9V4Z+HbmL587ICsBDnI3cJ8D25vHrizXY/HI46z5aoZTUEPlCnACpR8FE6viT53sT
 A4/kLuSU8EoivLdj/xlk4VacCXKWqFiK72qyWXe2X0i/jiKGfNpSKgjKEyVj9q4yXOYf
 tewwI2/Ypva+k4x8hLyd22DgkYANYkhXfFhP9njzIGn43TfxO3A3G4hQ79xIEeFyBtsO
 S/1bKE/UaPH9/pn1p13QzUf2kdssufINm1Vwe1qM+ABswEYShgRNblAhLTBznrjn3evL
 PYsmRPYSLD5QP7jOio7homCHV+HhQYlWJMXyO3ou9s9BW4DeJ35YkgmGUg+asDLOKSU3
 yg4g==
X-Gm-Message-State: AOJu0Yx4ihUGSYmcCyEMWvHfQk/Gdznj244VUJctG0sR0x46V30RNbip
 oAjQf9plNTREZAq1H/ZdtAkevpNs+TwNmrLIKZQ=
X-Google-Smtp-Source: AGHT+IHdiNj2DQpc5qMH7IsQ1KAr/3A0+X9gUE5Hr49SP28ivheNYlmtSZKE5RHAv3WJtAY8lme7ig==
X-Received: by 2002:a05:6a20:7f8b:b0:180:d45e:729a with SMTP id
 d11-20020a056a207f8b00b00180d45e729amr15823060pzj.29.1699254127498; 
 Sun, 05 Nov 2023 23:02:07 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 43/71] hw/openrisc: Constify VMState
Date: Sun,  5 Nov 2023 22:57:59 -0800
Message-Id: <20231106065827.543129-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/openrisc/cputimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 10163b391b..835986c4db 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -145,7 +145,7 @@ static const VMStateDescription vmstate_or1k_timer = {
     .name = "or1k_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ttcr, OR1KTimerState),
         VMSTATE_UINT64(last_clk, OR1KTimerState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


