Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043D7AF181
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPg-00025D-68; Tue, 26 Sep 2023 12:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPL-00021N-Db
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPJ-0006cl-5u
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pw+0oEZbC6WiyKIZhtTSFPp2KrFNLWI2U8xktJv2934=;
 b=D3O6vuhF9Bh1cvqGmjQwNniEohO/FeLtIoUIiPFKp+63jDSXL6TEnMRlRxZuipFntyuWiN
 PJfeV5ndbTb97wJhopv9SQcNh9MaPQmiJqza6Y1bS5GeRHRCYol74zxNRNriOHXKuJnolb
 JVq/RlUrPppziRdSbcfOYARy3UgxQoc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-woTnYS1jOQChxGTHSPKWkA-1; Tue, 26 Sep 2023 12:59:31 -0400
X-MC-Unique: woTnYS1jOQChxGTHSPKWkA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so86603375e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747569; x=1696352369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pw+0oEZbC6WiyKIZhtTSFPp2KrFNLWI2U8xktJv2934=;
 b=D2MhtEre3Mfux05+oOqcsq2zql/xmAIyDjhHL/INHnrO9Kyh7uSh2DyUajVvFW/1kZ
 hqKa+a5Ej3qR12qgapZ+pO11Be0dyY6IC7ppolQ2oeuzv2irrH6sZPNenYL9wuzhduWZ
 86+bEmOfc0Kh9jLP9qo5IIWzJJUs9jPn4OYatlGlUMU7THPLPJ45mhJOLvdyPveG4RJu
 axv2Y23eG3Z0FaQw8SItI7C4zYDeha1i1A9kmJK6MEy/kd/DrMy7im630NdTr22ngrVe
 TYWDmmRxe5QXkqDIlFxTHJxwWsK1HuJyH9sN2nHz7gAuA8OVD//8Dk5SaParJmatUJlU
 FmdQ==
X-Gm-Message-State: AOJu0YyHcdIL+jflzufLUVni129zOSbVXByZgvJIBLIyUzT95xOVvl/y
 MY6gavq2crysolZxJqUjtRWM9XHbi1DEokefMQhb31dAt7KueZCRnvBUsCjabxLcuLDOPVJ4kCx
 EH97RymlUliDm3OwX3V5ISSs1fb8httIjQEVuHMaTdl2KqmABTxEZl5E08Gw5hhE5/f0HGlM68N
 w=
X-Received: by 2002:a1c:7904:0:b0:403:8fb9:8d69 with SMTP id
 l4-20020a1c7904000000b004038fb98d69mr10285424wme.25.1695747569464; 
 Tue, 26 Sep 2023 09:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvqC0gtplYptLfFjygmpmzmsGTJYpn/64i3nTY7Ktxp/c+WnC/C8d474yKiW3nnOpD5KTBpw==
X-Received: by 2002:a1c:7904:0:b0:403:8fb9:8d69 with SMTP id
 l4-20020a1c7904000000b004038fb98d69mr10285411wme.25.1695747569114; 
 Tue, 26 Sep 2023 09:59:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c429300b004047ac770d1sm13470450wmc.8.2023.09.26.09.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/19] ui/vnc: fix debug output for invalid audio message
Date: Tue, 26 Sep 2023 18:59:02 +0200
Message-ID: <20230926165915.738719-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 6fd86996a54..1684ab90968 100644
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


