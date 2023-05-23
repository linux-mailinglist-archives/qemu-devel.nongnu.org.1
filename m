Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4670DDE5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:49:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMd-00006r-KX; Tue, 23 May 2023 09:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMa-0008Nm-KW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMY-000136-UL
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:44 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d2b42a8f9so4260967b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849662; x=1687441662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XkUZP/KXpryW+1SxKnXlwtBsZlj1WR79DzIRZIAO0I=;
 b=E71hhLmYQs6l6nC78VZg4/N92auIHK0Kqm0PpL5+4fbtlSrRibzvSdmg0E5ePRgVm3
 AQrEJ49A1mQ5vpU40nmVCKHmLb5UCSVDh0KAO/An7W82O7ZQhJ5jjtp/J8u08ajdDkrT
 i5tN0ohfzPIn5Jsdcjn3MvloNWSr0nXhJHAoOM6IXkuAfhZJKhvb/7MXdHoaUpxzhsQt
 UXdgy8LiOW0iZk9/eEw/wHgQ53A7yWTopOZl3hbJDhJwvIdoR2/Uo/FxQH0QD5eSy3Pb
 8xayY3WriNUN097aM8h0QvNdQ/nU2osbQY3R8+XHtkJJXORap/2NVIHklyo5EPo4aV/s
 ZNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849662; x=1687441662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XkUZP/KXpryW+1SxKnXlwtBsZlj1WR79DzIRZIAO0I=;
 b=blwQoa/W22k+C3pEoNNff6u9LVn9VDdP+rPqmiG+Rqc8Q61emPd/6ciunRoe6CGp3H
 yKNrIEEgTkP4JBTyGFbkqYfqPArRhKetqeazWPNgUI1Je3FL/9BKgi3m5hSV7uaSnsYv
 Uss2zEWJxoAP9WgSVFP6hNV3hxdYdFOiozGIVgqjYWyfZ2/mjsKA9uJWmzDjP51so3E+
 bSOXdIt1dJNWNHE6znqhs0b/cn3CTsDoOLp6X726vmtNB0nVWyt+Yp9KN9sMz5YULAFi
 SpZqKOr5r+RH3z7EvkpUoU0GFYjyQco6bJOJmH0WStL4+6W0jp0cX6+OpOVDP79flROr
 b+ow==
X-Gm-Message-State: AC+VfDwXFMQ7u+4WvoqPv+L8hmtcO2rMAyxZXYlzMKe1Sa6I02F9sxlV
 q+PvZCmHEZldr6s0lfKDl8gdVXTV3KsnTfm0U0g=
X-Google-Smtp-Source: ACHHUZ7m/qX/JDpaFQTsXyjX7ERu/uByWEKLLwVqplch7bGFOmPM/U1sRi2qySP5uRK+mjZVX74H8Q==
X-Received: by 2002:a05:6a00:2e98:b0:64d:3e99:83a5 with SMTP id
 fd24-20020a056a002e9800b0064d3e9983a5mr18368794pfb.26.1684849662209; 
 Tue, 23 May 2023 06:47:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 08/27] migration: Build migration_files once
Date: Tue, 23 May 2023 06:47:14 -0700
Message-Id: <20230523134733.678646-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The items in migration_files are built for libmigration and included
info softmmu_ss from there; no need to also include them directly.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/meson.build b/migration/meson.build
index a8e01e70ae..8ba6e420fe 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -8,7 +8,6 @@ migration_files = files(
   'qemu-file.c',
   'yank_functions.c',
 )
-softmmu_ss.add(migration_files)
 
 softmmu_ss.add(files(
   'block-dirty-bitmap.c',
-- 
2.34.1


