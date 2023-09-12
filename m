Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065AA79DC05
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4R-0002NU-6y; Tue, 12 Sep 2023 18:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4P-0002NE-0W
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4M-00016Y-FY
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c3cbfa40d6so16707865ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558477; x=1695163277;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Owf73A2jtbtMsGA7cBmEhb5GKITEmhQO9JJT6nRhMFY=;
 b=G0pzLWFHUZvq64ks1m66rkCTa6kGsDGcGEeo1TeX3MgzEcBK9oDud3Tc/nZ6fcdGnH
 QWskH3m587OG6xyOwOeYRt99uhykfpoV1kHuAPprpnQbho0Du/xoD2q8dST+bNa7Cg31
 fn3Y7L+b2Yfg1daiBJFW2x4iJAKro+TEacgKBMkrVrEr96EO9r3hQgW9OBg9F3xCJgKO
 /NtHBhunp1DfTaH57JCSppYPpim1ycUVWuU1dzyOOBEjYLhawrHX0g0BaqHEeQBMsZPi
 X7NS5b32wbHzxzEReCRIS+/HCXAepVnWxrPTCkI820aq446zvJ/Mz6C5FdQC5NfuzBSm
 Bkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558477; x=1695163277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Owf73A2jtbtMsGA7cBmEhb5GKITEmhQO9JJT6nRhMFY=;
 b=PDFA+knXoh4dkISmD2kkp7lWjbQXiC0dMLNVqJ09CtYdU0x4h9CTNZfbaJaf+5vjFm
 Pf9kpAIGH1aZvELsrtxVfSspHPX2f1EbMIcDHaa3V6XDk+Y0EYebf7x5B9wtmADzWDoI
 C22F1GyKdmDC86afYZkirJdcYSWslOwLDtlaMOwOnJF+qiAJzZVkaIOxHAVAryToXxaY
 J7kjzeRLkYE7SLa0ArGy9Bi5n5FLv0mZNyXWOxqPHVTWht8GmZIxZ5XTFmP1oc8fK7OW
 McSrEoVj1A7zo/0RXLvA6hWV/QVjB6UC8h/258syLduBbUnGnDuwZWYSyBol2VKbCIfS
 d+hw==
X-Gm-Message-State: AOJu0YwOeimFB7HZAuaj5azsA8UHQJsIeX5YZqMrvKAxdBx+ckORywSz
 hdPZAnLxFV2T2cPeQv1zNvWMNg==
X-Google-Smtp-Source: AGHT+IHJ73wcU+UCzygx06xw9NOesJ/j4otpl07+WeORGujBDctqFM89aqZZ1OtlYbzspPyLVKr3wQ==
X-Received: by 2002:a17:902:e5c7:b0:1c3:eaa0:dc5 with SMTP id
 u7-20020a170902e5c700b001c3eaa00dc5mr18043plf.26.1694558477073; 
 Tue, 12 Sep 2023 15:41:17 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 02/12] gdbstub: Fix target.xml response
Date: Wed, 13 Sep 2023 07:40:51 +0900
Message-ID: <20230912224107.29669-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

It was failing to return target.xml after the first request.

Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 349d348c7b..384191bcb0 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -396,8 +396,8 @@ static const char *get_feature_xml(const char *p, const char **newp,
             g_string_append(xml, "</target>");
 
             process->target_xml = g_string_free(xml, false);
-            return process->target_xml;
         }
+        return process->target_xml;
     }
     /* Is it dynamically generated by the target? */
     if (cc->gdb_get_dynamic_xml) {
-- 
2.42.0


