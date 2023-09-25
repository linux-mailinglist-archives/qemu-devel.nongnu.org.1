Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191027ADABC
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmwu-0006m2-Ij; Mon, 25 Sep 2023 10:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmvL-0004CA-Ui
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmvJ-0000bq-HL
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TZMv/HQ00jR3RN1h8sX0f0Qzu5I9t8mQxx0zk6X9dtk=;
 b=aN7PPeDnij9kQpYGkQbBKFlFHFbpzYD1I7cFRBtY8CJVwU61P97fi876eQTsT02NxbHNft
 /pNaMt6sOfTcy31csxie0MTwtu9LX4JmZqCZPvxngjq/2wqdumDcD+j3Ja+0qp6b1vKR6E
 yxgjG3xonQyjzUlt5GHiJ2W6SjBfw0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Q6KQMx1vNoOFhsAx_nWbRw-1; Mon, 25 Sep 2023 10:50:55 -0400
X-MC-Unique: Q6KQMx1vNoOFhsAx_nWbRw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso5234833f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653453; x=1696258253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZMv/HQ00jR3RN1h8sX0f0Qzu5I9t8mQxx0zk6X9dtk=;
 b=CrjYpu6/VXFfYoJ2AccsHlo+zTjf+nPPZk7PJ+UAo1m18nBW2sxzFi71IpBYDxWWn+
 NRqPfzsyAdTihAArYTn+KHkyaI2iWaCNbAkNOg8FO8NyrhhELFFDN2J7qNRocZmB5eN9
 xkL41klHHgQTp9cSq5+H591iKkE2Smib4ZFDYdV8DC2dSh35CA2YLwRYaLDRGKL2xfpo
 RNFw+8yUx0LlTdvthUHu6wRYpSVLTuchpiJy1K6KaW5nFOPX38Wo8zvw1Rk0vQyfCfwc
 /oq5Y3pRVoH2qIPD+vorix8lADdx3qKCrKSRMo9but88OrN5kJTqoVm5I6RqdtuoBawb
 pP1w==
X-Gm-Message-State: AOJu0YzBZ4hdklxbhBfxeloUAzjzlhNVq1NDcWR9VjN/cXVhrhSBQw+G
 HaLc6xCVJ/cI06nskz6DtvyWKYu+jsN5WqiSnx3t5rpY6Mvwpblq3BRvk97VxidTkai9sCqsZ4r
 dwNYw3A4rqZYUt0r/B/OKJsU+NosWJq4JskFNwLHnEL7Fq2EvHF3wTlUoUzgdyMLJ2IRX4sj6+x
 s=
X-Received: by 2002:adf:e892:0:b0:319:841c:ae7a with SMTP id
 d18-20020adfe892000000b00319841cae7amr6060822wrm.41.1695653452895; 
 Mon, 25 Sep 2023 07:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkhohLIYMFKl3YHFamGthD1xVJrCYVAevpxCi5S8ii6uovv3iBvoOTsXwBxkVAAXhHuizkIw==
X-Received: by 2002:adf:e892:0:b0:319:841c:ae7a with SMTP id
 d18-20020adfe892000000b00319841cae7amr6060802wrm.41.1695653452531; 
 Mon, 25 Sep 2023 07:50:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a056000025000b0032330232802sm1188925wrz.4.2023.09.25.07.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:50:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [PATCH] ui/vnc: fix debug output for invalid audio message
Date: Mon, 25 Sep 2023 16:50:51 +0200
Message-ID: <20230925145051.530834-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

The debug message was cut and pasted from the invalid audio format
case, but the audio message is at bytes 2-3.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 3d13757b72b..acb494d18a0 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2551,7 +2551,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                     vs, vs->ioc, vs->as.fmt, vs->as.nchannels, vs->as.freq);
                 break;
             default:
-                VNC_DEBUG("Invalid audio message %d\n", read_u8(data, 4));
+                VNC_DEBUG("Invalid audio message %d\n", read_u8(data, 2));
                 vnc_client_error(vs);
                 break;
             }
-- 
2.41.0


