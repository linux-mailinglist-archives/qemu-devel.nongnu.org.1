Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50F7BB625
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinN-0008Mo-LN; Fri, 06 Oct 2023 07:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinJ-0008Hd-Ly
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinF-0000Ky-4t
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5mg0EVXMpSp3/p2XABRST0eaTQHLCF3XcJ+1IJpFP4=;
 b=KYU8wwiRDBuUQq1oU9JPGkJEkcC3Gw+F9v68EsNGIuclzfP/Zj1DLGcsX6g/kuq+VWR8iF
 +z6kjMqBz/D11baV5dG1WiZvPE8i7gOV8MYGc4Eovr2SkP7Hy03RRzliVoY5/w5pSlSCGz
 3dW3SUxZhGiFgAxNUpo/kUhYMRWHR48=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-oPFZUS_2M_KjrvzL_ku0zA-1; Fri, 06 Oct 2023 07:14:50 -0400
X-MC-Unique: oPFZUS_2M_KjrvzL_ku0zA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so168883766b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590889; x=1697195689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5mg0EVXMpSp3/p2XABRST0eaTQHLCF3XcJ+1IJpFP4=;
 b=Loz9cwDvt9yn1aaLA4lQs5b9MQlPhnw+LAYuPsSpvEOHp2m+9FORlGrT1rOAeNC/8S
 RPCV4gOlvt+Ns3cKzr/VctWBa8y4NA818z82Qfce3E1xWxomIGjfrQAbJOkgt62RSYYe
 0QL+n06VPtkZCocTyskJiFbrpsiqTDEJ2RIbuCJuCzgImwQVlUfaoPTdGbBg03p4ja2d
 OdTWrD2M1HdgFIpYxN9LvjsRxSZ6Ymja2H6FY6/h+4Me27B4mn0Y3CqpJYYpGFjd/DP9
 0vUZaI3RZgSBALk+RjrMtsYhR3igAAOW9c7N13mNXQRrZ5dQgWFw5vHg41Am8OgUKJG4
 wWdQ==
X-Gm-Message-State: AOJu0Yy/aK0qyTFsePouPTMy+XnD/imYXs7hksM7xmAcA+yynHpNy1iU
 Q1dev2MDLOqH1OCWkl6GPiH4f4t4VIH1LLnYMQqOf+Q1vZePu3znK0tbiT+ggXzBiWFI2UxE8eh
 XMqIfsj8ptaJIcM08iTOEkDz4loJyuxDZdUBgfDVgnXjU8ZF+DjHh46i7sTGQ6sX/aVy6r9vh4a
 M=
X-Received: by 2002:a17:906:2257:b0:9a1:680e:8c54 with SMTP id
 23-20020a170906225700b009a1680e8c54mr7519323ejr.71.1696590888823; 
 Fri, 06 Oct 2023 04:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvB6h9ao8uWkW0YUfzqlmpViSGBg5sdp1bdNbvndAOzeX6tUnGhk7xxqfSeRW14TytVyIH6g==
X-Received: by 2002:a17:906:2257:b0:9a1:680e:8c54 with SMTP id
 23-20020a170906225700b009a1680e8c54mr7519302ejr.71.1696590888456; 
 Fri, 06 Oct 2023 04:14:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 gh18-20020a170906e09200b009786c8249d6sm2741247ejb.175.2023.10.06.04.14.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] cutils: squelch compiler warnings with custom paths
Date: Fri,  6 Oct 2023 13:14:05 +0200
Message-ID: <20231006111412.13130-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Setting --bindir= to an absolute path that is shorter than the
prefix causes GCC to complain about array accesses out of bounds.
The code however is safe, so disable the warning and explain why
we are doing so.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/cutils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/cutils.c b/util/cutils.c
index 25373198adc..3856e304c52 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1012,8 +1012,17 @@ int qemu_pstrcmp0(const char **str1, const char **str2)
 static inline bool starts_with_prefix(const char *dir)
 {
     size_t prefix_len = strlen(CONFIG_PREFIX);
+    /*
+     * dir[prefix_len] is only accessed if the length of dir is
+     * >= prefix_len, so no out of bounds access is possible.
+     */
+#pragma GCC diagnostic push
+#if !defined(__clang__) || __has_warning("-Warray-bounds=")
+#pragma GCC diagnostic ignored "-Warray-bounds="
+#endif
     return !memcmp(dir, CONFIG_PREFIX, prefix_len) &&
         (!dir[prefix_len] || G_IS_DIR_SEPARATOR(dir[prefix_len]));
+#pragma GCC diagnostic pop
 }
 
 /* Return the next path component in dir, and store its length in *p_len.  */
-- 
2.41.0


