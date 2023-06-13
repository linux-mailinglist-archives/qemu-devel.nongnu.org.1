Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6A72E1DB
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90Ut-0005fV-4h; Tue, 13 Jun 2023 05:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Ur-0005f0-6A
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:29 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Uf-0005d8-JG
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:28 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-977c89c47bdso955833766b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649155; x=1689241155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2jo3NykLrkWBJhw7LXeamiV1DdBMNZRbXtGEhY4Rnw=;
 b=XxVex2w7HrwCcsJHDkTat5UBtXx7F53UseaDsE59/7S3Gv7w0rPJQLX3sESivWEGJz
 VJiNx/Ke3kOAaolsPwMkw9AzLMhyPYK/eXx5Ao0xtMxqaa/nspQeNadKJqfELtlQZlEe
 NH+Tv/g6r8UBm0ItJ57QtLBHkb3qJxVmiTh+pFSyG7fPkTYaGXmkXLguv2HDyMLStZ0T
 L7tB9xiDX2wOxnqpmQXcuGINYwRRjOydCC1YywQ7SBVgViaCny3n1+LlXK0LHSrJaaLy
 CUOAtjqdVrGT39jmkp3tzgED1mNyHDHf9btgv0ePr1NW2XTFM5X/el0QyqjyG3x5Qncl
 ddmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649155; x=1689241155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2jo3NykLrkWBJhw7LXeamiV1DdBMNZRbXtGEhY4Rnw=;
 b=f75kgILF6BO0zlMUOGzTPqiK93jOLkhrSsXLdQDUJHln2EQvMzQhk04OmzDWvQHTLh
 ODHlbLIO4Id+/ssB2e/Ca+PTdzWYfpW/7KsdEzdyw6zGpk4O1rm+cR5xtaGQqt+auz4a
 kzimLzWw8asazVecTF2771yriSkjzWzfH1zsiERRJSJ9eB9UQqN3POSLjVoVtwUrbAXq
 HmyVP52jMtOXp5HqP18IYhGV2NMYL9qzmBZWwWMkhEieJB0sJ7n8jrqd5oRfQP/grCT0
 iaLebsDBQ2pz8YGWWyCXZQv6jDpC7aJjtIia3WZLHy3OsNg1quXnUym/P+w8kyW7y0c4
 mwGA==
X-Gm-Message-State: AC+VfDykKeJWFX2lM4oi3z+Lpf96OEyE90Px+DJ6cY3pzUW5g7MXWdUO
 +uVINDWp+6MWAsOisPkEFUlURwXBiFGUhhW5H82cRw==
X-Google-Smtp-Source: ACHHUZ5yH8KZ2YjSZ0PKCqw1GY+nATgl+pXVSr/oWLYtFfcnThhrN2uq6S9pU8GoKEWWpN0Ao88IIQ==
X-Received: by 2002:a17:907:7b91:b0:977:d48f:97ad with SMTP id
 ne17-20020a1709077b9100b00977d48f97admr14304901ejc.75.1686649154952; 
 Tue, 13 Jun 2023 02:39:14 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709062f8f00b009534211cc97sm6358163eji.159.2023.06.13.02.39.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 11/17] hw/ide/ahci: Remove stray backslash
Date: Tue, 13 Jun 2023 11:38:16 +0200
Message-Id: <20230613093822.63750-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

From: Niklas Cassel <niklas.cassel@wdc.com>

This backslash obviously does not belong here, so remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20230601134434.519805-2-nks@flawful.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4e76d6b191..48d550f633 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -690,7 +690,7 @@ static void ahci_reset_port(AHCIState *s, int port)
 
     s->dev[port].port_state = STATE_RUN;
     if (ide_state->drive_kind == IDE_CD) {
-        ahci_set_signature(d, SATA_SIGNATURE_CDROM);\
+        ahci_set_signature(d, SATA_SIGNATURE_CDROM);
         ide_state->status = SEEK_STAT | WRERR_STAT | READY_STAT;
     } else {
         ahci_set_signature(d, SATA_SIGNATURE_DISK);
-- 
2.38.1


