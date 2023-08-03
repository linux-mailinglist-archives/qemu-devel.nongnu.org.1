Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB0A76DE69
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 04:44:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qROJO-0004Le-Io; Wed, 02 Aug 2023 22:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qROJG-0004J3-Fw
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:43:32 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qROJE-0007fU-UY
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:43:30 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a5abb5e2aeso347560b6e.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 19:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1691030608; x=1691635408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrpIl5UtYIp6iXkXqOMiDIf+kxP/ULcxq/ivSj9Y9sU=;
 b=a0Vhew1vGyPoe/mmUSCcwMUdAKIft51HrAa0YzlNluObIaijr1qMpTS6seT7DwSyZx
 RBdnTy8tsagrUE/1ejWHjNxztDy2XhigSXSv00c50Ka0X/RThg2gr755CjY1N7WThHx6
 orWUBjCwxoRke+CINTRYyEjW3Cm5q3ogHGIs8idOkpleog1wRKjVonndxeYzUbIQashj
 eybZ4Pqfu0FYFpm9FZi+tWHfz71c08woblWvMTiMvi1bEjAs5BGUMRVLAlaXustt3HBK
 /5dZS3tKUaO3LyEcunUX50Ki5MjP9wnuy9RrU13YXfqt6NKkBJnuYLNCW9TDa5R8bspz
 Q91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691030608; x=1691635408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrpIl5UtYIp6iXkXqOMiDIf+kxP/ULcxq/ivSj9Y9sU=;
 b=Y70CG7+d52e5LJGO380+Hd/KbhYF1zA32s/BNZjRIhdXvfgiX1S5XoV2/MG5eCvVV6
 5DvlZjgCqPBzIvDr1vm/MRM6+f0n/Jqu7eQG4xQHikk7povNncOr4BpXR8ru8M/InXFi
 mzQPbQpmxJSWNoNaoue4eOGytK2p1BuPP6nsZ7gxHNzmR/xBfAC+2Avj6guvtNB/+naC
 a03J7ymeo+JWJUps3k6zrb7b1WPezqnSr0G9V5oYLLc5N72OyXjqJcKzT9JBVBdodKes
 9LV7yicDDLshGIB9e/E/ZQsOWtoO9583PGocGEnEb25wrPgycGJV3rviTWTAgB9SfnGN
 hCmg==
X-Gm-Message-State: ABy/qLZ+vlC78NjFbZ8taU8rcCopyMTKWWmZ4VHQzaI5u/GrM+A/qacb
 HrPYg6Szp6VS3BsESC2+18N9WA==
X-Google-Smtp-Source: APBJJlFX/tur/RgdEkTN1w6iCChCPs7EPqNC5tOnw5hR+XBisoUdLrHvQmAWkOha5r0Exv3GPqVOyA==
X-Received: by 2002:a05:6808:4cf:b0:3a7:3ab9:e589 with SMTP id
 a15-20020a05680804cf00b003a73ab9e589mr9677747oie.35.1691030607745; 
 Wed, 02 Aug 2023 19:43:27 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 j22-20020aa78016000000b006862b2a6b0dsm12090578pfi.15.2023.08.02.19.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 19:43:27 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, taoym@zju.edu.cn, kangel@zju.edu.cn,
 nop.leixiao@gmail.com, mcascell@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/2] cryptodev: Handle unexpected request to avoid crash
Date: Thu,  3 Aug 2023 10:43:14 +0800
Message-Id: <20230803024314.29962-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803024314.29962-1-pizhenwei@bytedance.com>
References: <20230803024314.29962-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oi1-x236.google.com
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

Generally guest side should discover which services the device is
able to offer, then do requests on device.

However it's also possible to break this rule in a guest. Handle
unexpected request here to avoid NULL pointer dereference.

Fixes: e7a775fd ('cryptodev: Account statistics')
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Xiao Lei <nop.leixiao@gmail.com>
Cc: Yongkang Jia <kangel@zju.edu.cn>
Reported-by: Yiming Tao <taoym@zju.edu.cn>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 backends/cryptodev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 7d29517843..4d183f7237 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -191,6 +191,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
     if (algtype == QCRYPTODEV_BACKEND_ALG_ASYM) {
         CryptoDevBackendAsymOpInfo *asym_op_info = op_info->u.asym_op_info;
         len = asym_op_info->src_len;
+
+        if (unlikely(!backend->asym_stat)) {
+            error_report("cryptodev: Unexpected asym operation");
+            return -VIRTIO_CRYPTO_NOTSUPP;
+        }
         switch (op_info->op_code) {
         case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
             CryptodevAsymStatIncEncrypt(backend, len);
@@ -210,6 +215,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
     } else if (algtype == QCRYPTODEV_BACKEND_ALG_SYM) {
         CryptoDevBackendSymOpInfo *sym_op_info = op_info->u.sym_op_info;
         len = sym_op_info->src_len;
+
+        if (unlikely(!backend->sym_stat)) {
+            error_report("cryptodev: Unexpected sym operation");
+            return -VIRTIO_CRYPTO_NOTSUPP;
+        }
         switch (op_info->op_code) {
         case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
             CryptodevSymStatIncEncrypt(backend, len);
-- 
2.34.1


