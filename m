Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B9D764CE4
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:29:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvTd-0005H3-1t; Thu, 27 Jul 2023 03:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTZ-0005FS-TF
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTY-0003op-Ip
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686ea67195dso506500b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690443115; x=1691047915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8W/2glyFNghlOR8aLoJh4rtbBTz1uiLofQu+GK6+ib0=;
 b=TwyLkq7VkQVku7UEGEJGvOxpiLGKqGNn2Z8k57YpSS6ZkWHfSRznN+VshcyamJEJqB
 zMw97jUDWAXtbrKFdxDdZwZlTw6jMTuKDc69kpYGQ0SwXjls2dSoY2OhR7sH8bIrD4ut
 G0xxv4KpICYR9eGhbLk7VBV+IuNi87eZcDIuQc2fsSeQHyMLWy9i4ZRqjfD2vLbCVkaS
 gH2rgu9ptJReOtFpj98D23kSv1ELspNKBm2SZkYIDSxsUsfqx7DVi5tLI2e5vuNCLyJ3
 6YmLAZvRauKh3Zadas84zdgYM3WKD/wsk1snqp9KY3I0KaeJVZx2HrbjHlfEjSasJF89
 9OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690443115; x=1691047915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W/2glyFNghlOR8aLoJh4rtbBTz1uiLofQu+GK6+ib0=;
 b=dd9kpRXjKS1ok3SjWgDfyRHgaK69NWeVqVX6J+aPY0qb9PRdgBVkeS9htTJpNdFV+X
 PpI2ihw9D07glWLXWUET1APzEFl0sis/MtJW1bASRcBzxB3YnCakX0bzYzEYZWEzbuq4
 xUwVPW+dek2L9x9apCPd92FpasL5MxgxeGo31Y6tlVlKyLBUewDut9sQ04MVlCxIuXT5
 ATBCokeqDnWVB49+hZP1zL9Wj+V2wGMJCrC+59QVFLgltUZwB5xu3j9/rT8g18tnwqbz
 +aySOwjweZiNih4zxNcnbvIoZIPgNiMKgTAJuQ2S+OovKLVdackfPm50aeeUTbODsSn9
 tt4w==
X-Gm-Message-State: ABy/qLbzVbPKEh/KVfbBh1iWtdX1ziE8H0cMzlk6D4jQtv8IqPWMs3F6
 lW2OcfWyJTKwv4g/KhbLenKloAkHNGoeUmES4bs=
X-Google-Smtp-Source: APBJJlGH5IK6xCXrgs0jr2kjrwPluYHvsn81u11F09P420p9JlfCazkD9jzO2BEnsFqFVedHPLVqnQ==
X-Received: by 2002:a05:6a00:1515:b0:668:74e9:8eea with SMTP id
 q21-20020a056a00151500b0066874e98eeamr5088101pfu.33.1690443115301; 
 Thu, 27 Jul 2023 00:31:55 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d9-20020aa78689000000b0064fa2fdfa9esm802002pfo.81.2023.07.27.00.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:31:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 5/6] accel/kvm: Free as when an error occurred
Date: Thu, 27 Jul 2023 16:31:30 +0900
Message-ID: <20230727073134.134102-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727073134.134102-1-akihiko.odaki@daynix.com>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

An error may occur after s->as is allocated, for example while
determining KVM type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 94a62efa3c..4591669d78 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2765,6 +2765,7 @@ err:
     if (s->fd != -1) {
         close(s->fd);
     }
+    g_free(s->as);
     g_free(s->memory_listener.slots);
 
     return ret;
-- 
2.41.0


