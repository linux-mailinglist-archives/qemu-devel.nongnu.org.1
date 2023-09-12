Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7FE79DBFE
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4S-0002O0-8h; Tue, 12 Sep 2023 18:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4R-0002No-8D
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4P-00016x-3g
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so10083435ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558479; x=1695163279;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyJI6yjEyvs67kM8yJl2i3nEcJfzU2Pt8aPkvH2f3Jw=;
 b=gpwqSUU6tefYVgKpkjRSZpwtRi+oDi1KN8ln52Qtfy9OYeGbIrTRrd8IlZaKk46Czo
 6hoDWgvvfGuqCkN8EML8hJfj8l071Fp7/RF+YhaAM79pbvFOrDwAHY+dRYRpEIe8k2mP
 V5jFBlRQ8KqTkQbV9oopvNs8Xwvltld+USOkBnD5niaGGEFO7Ze9ya9u7IsOhQjIN1J7
 nLSYggIzg2NdKA7PgGJPvQrHlge5h91A8Zp3NT1iszr2c9YJ9UMMNXf4FxhVHykbUscY
 hOJQHgbEhztILVK2EQ7EJeA0psMCBZzxGHncFRSG3aMtKTwhqB6AdIwun7gjd2MQo0eP
 pvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558479; x=1695163279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyJI6yjEyvs67kM8yJl2i3nEcJfzU2Pt8aPkvH2f3Jw=;
 b=eWokyKOD8HlhwZGzrPBc4nvWi1pESnK31tNuuCR6uNuCe6Y8Crw6PizpVRP39DAh4e
 vRtavTouEj+9K6FGPkr2mCY8IQ/UHDIJKYZZMOARN5YIOgBjm6YizJ1tE5ZGc+klVLCz
 f/+1T5sOb8x1YmIBmLk6k/n29wgT3AlM/A8RlUTaiuCFkqnEen6FZcSLwJZaRQGjX35g
 TfhgNdax7wfSjStaPFlNTR8kSTcQlD7Bm+NXR5hnu4EpsdwPntYnk0WhqeNLtqzG9Sy3
 VHcT2ICS89urYBBdxegbrbw53I4veH7Q5QCk0bJDn5ggXE/qjqqtxKc50rrWswy4vZt2
 6XIw==
X-Gm-Message-State: AOJu0Yy98vtSXWI1osrIGz+Wg9IPg4uHVAeRwl2n4XDly1tV6T7dyMlP
 JU3LDI/+rH5bZRCLEuKXpCvb1Q==
X-Google-Smtp-Source: AGHT+IFNEcxeo3au+c9++zLt4jbnhVVvxaK5FVcbSOUgrXhGWlGd6nA3iwv4A5CNSMVDCAGUQa3gRQ==
X-Received: by 2002:a17:902:d505:b0:1b8:525a:f685 with SMTP id
 b5-20020a170902d50500b001b8525af685mr1083368plg.37.1694558479538; 
 Tue, 12 Sep 2023 15:41:19 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 03/12] plugins: Check if vCPU is realized
Date: Wed, 13 Sep 2023 07:40:52 +0900
Message-ID: <20230912224107.29669-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The created member of CPUState tells if the vCPU thread is started, and
will be always false for the user space emulation that manages threads
independently. Use the realized member of DeviceState, which is valid
for both of the system and user space emulation.

Fixes: 54cb65d858 ("plugin: add core code")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 plugins/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 3c4e26c7ed..fcd33a2bff 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -64,7 +64,7 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
     CPUState *cpu = container_of(k, CPUState, cpu_index);
     run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
 
-    if (cpu->created) {
+    if (DEVICE(cpu)->realized) {
         async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
     } else {
         plugin_cpu_update__async(cpu, mask);
-- 
2.42.0


