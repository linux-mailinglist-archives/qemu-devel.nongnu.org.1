Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D930E805F9A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEG-0007QK-PG; Tue, 05 Dec 2023 15:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcED-0007OW-Hm
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:13 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEB-0002Et-Ua
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:13 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c0a0d068bso27203295e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808870; x=1702413670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ly426yd4H2r3GnJOjRqFYA2jyI3ziXUndZx7DtQI9f8=;
 b=jwLUOVKd8azZJGVlc4Z4x055hX4e0+JfOFbzdynqlF7DfdfIQzIdd7SFPaWoYtU/04
 21NjXWzQhA7s3tXvq6DYlq/XrXTuVGRNhLfhgGdAsyb7KWwq5hUeePzlqBFJud8gvsTE
 o5ShI0cnBQByVy8LhbIbhOEgR4YBE9Fd76QLNgRVlmmc2lwM+mlW34ikQftyEWtuMjBp
 miTklKYX2TspXZw0UJ+hOI9e3piGc/B/FikitwoDYe4T8IQuirCGMVSnYkuXMCncEWSV
 VsDA7uz5F+UA6mRORI4MA3WutOddyfKlqERbGWkrO421HTHtxknZxqwWwt1Qju0YqfMZ
 kPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808870; x=1702413670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ly426yd4H2r3GnJOjRqFYA2jyI3ziXUndZx7DtQI9f8=;
 b=m88Ej6GHR5Moxaa8RjNI6eDewv1jujVaE4jeAinpS5MHP8voroTW8vIDcLWnr2mdks
 Aw6ionX/OLySBPcl7Nk2BnwGtrO7Qd337D+1URNIDN5ATCcirAPPN1DsMV1fmVb2sBpo
 2biHRfb6m+ssCG1h2kyBgLbrNOE4y2CZ8LLvBUKiDt/GfdQfCWKmeYguhYsJy2zqFUpA
 iaq104nzpec+j/Mvknch8A7fSagxEeOtu4HKkEDKqID5tPkeuaujwAbeRyx8wziB44ig
 3A3SnD05Xc7+4JuUbaEJmeB1CLwxH0LF0DUhG0pWrELyf31EkUw/HsAmbUK+qIdYEzLs
 cFWQ==
X-Gm-Message-State: AOJu0Yy9JuCRbJ7DztP781VVSfKQ4CG8wi8XoUFn23Yqzbfudr2/mIKS
 8oARZx4OjueX+mj7TTWknUa1Ag==
X-Google-Smtp-Source: AGHT+IFu8L+rnl5Aam7dFYYPjLH6pFMz9hV2aCyd+qfrCvqecUHlOCfvzgwBfWw1qN/uA6z9EG8oWg==
X-Received: by 2002:a05:600c:1382:b0:40b:5e22:956 with SMTP id
 u2-20020a05600c138200b0040b5e220956mr4563587wmf.69.1701808870402; 
 Tue, 05 Dec 2023 12:41:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l10-20020a05600c1d0a00b00407460234f9sm19791658wms.21.2023.12.05.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D6425FBC2;
 Tue,  5 Dec 2023 20:41:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 05/11] replay: remove host_clock_last
Date: Tue,  5 Dec 2023 20:41:00 +0000
Message-Id: <20231205204106.95531-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Fixes: a02fe2ca70 (replay: Remove host_clock_last)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index b6836354ac..516147ddbc 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -80,8 +80,6 @@ typedef struct ReplayState {
         This counter is global, because requests from different
         block devices should not get overlapping ids. */
     uint64_t block_request_id;
-    /*! Prior value of the host clock */
-    uint64_t host_clock_last;
     /*! Asynchronous event id read from the log */
     uint64_t read_event_id;
 } ReplayState;
-- 
2.39.2


