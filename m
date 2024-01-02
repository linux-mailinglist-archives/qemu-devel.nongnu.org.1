Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E1D822052
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 18:24:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKiU1-0003uz-Ad; Tue, 02 Jan 2024 12:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKiTb-0003r4-NR
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 12:22:52 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKiTU-0007gS-S6
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 12:22:50 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-556ba709dc7so159735a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704216163; x=1704820963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f1nF8nMcp4N82m6QLePHe9x7ySGHGEMX0TJhO/CieDE=;
 b=Z9Vy7ij5fip//lPv/SmByBJU4drAv91csGwBp+VZ0AUL9gLyBvazPKSyn5EYjVva6F
 4Y729PCHWj9PgLujVBzg/JqQ2aaSiXnHgISb+zCOj2tlVX6Ux4Oo7vuL4Hv5ZpjOxC9G
 aPZ7/byXhwCzvJdC3/glNpkx7jfBhEPr/GaicInW3szqRHfS9AcmHl3e73I5ODFbGWzL
 43LV5f0d2rHAz5VNdDJxwR/bfX6dGzKuBVi59GM8zT39ypf2z/e6V8Eq760qfoKmmoMY
 Ia0A4YMixMcdjgzCakwNafPcI4w2Q3SOiJAsrAsNJQvJ78DAEwXTzbsumAJk5QtIh7A7
 usyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704216163; x=1704820963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f1nF8nMcp4N82m6QLePHe9x7ySGHGEMX0TJhO/CieDE=;
 b=LgIL6AEfSjSQV4EZlBfi1ZGmUq5P/r/GfBMsQbrkxYgPUukqNzQcxJc0wt0DvnQ3SU
 qWHFQ74TZg79HMmQduNotz2Qrvod6kYkjYcVEPyIB8HMK838UQQkjqZXVR/Mpq2+30R1
 nhVovj2r1qKgPmZRvoHMnY/L4gPuhiiEBTpv1vEKcKT0wmgqslOrtHaVDhdnsXx0pHzj
 BI6jbJX5j45N5JreQnEQ80w6hfm8+z1zK/62tlOD0x4MAaBWCz75cIn/W0snt0kH9yfC
 wBiZHfW0p0PLqtBOc3AS3QjTtn/JuCvPeWRZN1+rQ+XW+Q8o4v/M3HW9/m8d5qFw3Crt
 NfFQ==
X-Gm-Message-State: AOJu0Ywq1TOF9xnHUH3EA9/BueyuvSj4WSpF3Z+saWL+Fb2BV7GhNsaA
 4wH0QaiAD0YjGOYgKwUf1K+zb69hvXbqOAj/IARt5ptLAUc=
X-Google-Smtp-Source: AGHT+IERQd64Sqt6950gyPAmTEwH7tkEoCP0TyTscprHHjdGjRXCupEDpIa8tuzxld83pptpm1LIog==
X-Received: by 2002:a50:a693:0:b0:553:861a:4963 with SMTP id
 e19-20020a50a693000000b00553861a4963mr6427106edc.65.1704216162994; 
 Tue, 02 Jan 2024 09:22:42 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 p2-20020a056402044200b005553a8bb61dsm9228178edw.87.2024.01.02.09.22.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 09:22:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>
Subject: [PATCH 0/2] gitlab: Add config for Loongarch64 custom runner
Date: Tue,  2 Jan 2024 18:22:37 +0100
Message-ID: <20240102172239.69452-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Loongson Technology Corporation Limited offered to sponsor QEMU
with a Loongarch64 custom runner.

Philippe Mathieu-Daudé (2):
  gitlab: Introduce Loongarch64 runner
  gitlab: Add Loongarch64 KVM-only build

 docs/devel/ci-jobs.rst.inc                    |  6 +++
 .gitlab-ci.d/custom-runners.yml               |  1 +
 .../openeuler-22.03-loongarch64.yml           | 43 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml

-- 
2.41.0


