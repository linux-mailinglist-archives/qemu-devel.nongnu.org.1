Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F31AB09487
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 21:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTrx-0001R9-Oc; Thu, 17 Jul 2025 15:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8c-0002tY-Hw
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8Z-0002Ff-P4
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqG2DiLmplhxW74U3B4JYB/l83wKcoDTCpLDYKMWsIY=;
 b=Zy6TvkslWFk62kxvMGvgHAQopcDMeUCPd1TIN/9VRlRgLwADm3MANIHbXm1elQprU84TU0
 CKH9N5hGIJLaoZTcS8FpAZYMeVYlmB+tVATQhPHh2taf/Rtx+RjOu4HLfLzXJJG8rrAPsK
 7zocFbeZJUNkUchO7G1qFos6vLQ+Z10=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-pu9y_Z34Mr-g4Dr5nd8tMg-1; Thu, 17 Jul 2025 12:07:09 -0400
X-MC-Unique: pu9y_Z34Mr-g4Dr5nd8tMg-1
X-Mimecast-MFC-AGG-ID: pu9y_Z34Mr-g4Dr5nd8tMg_1752768428
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso564141f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752768427; x=1753373227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqG2DiLmplhxW74U3B4JYB/l83wKcoDTCpLDYKMWsIY=;
 b=evJqAXvJPBzh1BBobaxSzDIY14fzRqGFmtmXVhOSCuXuHg/zKQAvC9rs+dcFBoZ/HC
 wwDGTtQ/SLCZyG+WzTuII+oHo0rcvnAsLOyjRzIy+/10/tgcVPT19t6Uzg4OtvuaEuA+
 6r649QAoG9pqlP6mm8QdYzlZcpg06dhktO7IuWIbH3O2bBtIy/TzS2yd5FyjuvSVvIrN
 vcLiz3IOWhraYB7tUiwJ4kmVN4ysm1IvSpJM0TFE+tBYLCzLVJ+HECH7Nk9oXS+URfPB
 TpMFhZ2fv0oZnafFYrwwBY8wDgBWEvuYozSwaBVMbIpY44hpGc0vcRxFFadRroMnNSSL
 Q/iA==
X-Gm-Message-State: AOJu0YzcH7qWsSx7GzYTAObtJvG934Yh19bKNz8GW9VMSctnON1V2SPe
 Yn8x8iVRQ578ZksFcR3fL+1gZuOoI5n3GciyaojmNlNpvKU0fAMFkdippawbKCaJ+HA9rg2CAnX
 gD17gDU0aoPfwlFRiYawH5OxG65y868RTuodm39yGkwFVjjesnT+8VilyEfHj6cRsi/KYLd8rbv
 KpGt7gdLPliJkvNDpOAEfGcGg+ILjvhr7teEPxUYX1
X-Gm-Gg: ASbGnctT9WJcvV1jByZg7431bt6+90Pium7/ybmj/V0LsLLKt4B3to5ODt+khx4t/ys
 f3NSVesA/gvxGJOLs+8zD7p9m+6aKsOXZ5W5DfKhv4tVetp1ceMddVV3QBf5gNzAhbNWUvm/prQ
 DON/C41V3WIBOs2TER7tq/zI4haJPdFrPDJn1EvfcTt2SFAVvezyVtt2Kn5RLUManageQ1e/isf
 zBvWuJBEJHieQWuMrsT0DVFozN6DilWR11zS3clRVc4rJPDlhBgVUPC5XJtfQYglWnjX2apXIW4
 nTw7hE/2sIz5Q6wniC7orSvE2+1CLsKMakHMkz0vMaQ=
X-Received: by 2002:a05:600c:3545:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-4562e03e75cmr75700815e9.13.1752768427578; 
 Thu, 17 Jul 2025 09:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6sbt6o/3/zL6vOStW+JrKbl03z7JNjtTxqZLoirepd2ne7ncufP1U79cXNOG4U8vxmm1ntg==
X-Received: by 2002:a05:600c:3545:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-4562e03e75cmr75700245e9.13.1752768426989; 
 Thu, 17 Jul 2025 09:07:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f9be79sm26041165e9.31.2025.07.17.09.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:07:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, roy.hopkins@randomman.co.uk,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/6] meson: re-generate scripts/meson-buildoptions.sh to fix
 IGVM entry
Date: Thu, 17 Jul 2025 18:06:57 +0200
Message-ID: <20250717160700.357384-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717160700.357384-1-pbonzini@redhat.com>
References: <20250717160700.357384-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 84fe49d94a ("meson: Add optional dependency on IGVM library")
was inconsistent with the contents of meson_options.txt and the one
generated in scripts/meson-buildoptions.sh

Let's regenerate the file in this way to keep them consistent and prevent
future changes from including the spurious diff:

    touch meson_options.txt
    make update-buildoptions

Fixes: 84fe49d94a ("meson: Add optional dependency on IGVM library")
Cc: roy.hopkins@randomman.co.uk
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20250717131256.157383-1-sgarzare@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e8504689e80..0ebe6bc52a6 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -130,7 +130,7 @@ meson_options_help() {
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
-  printf "%s\n" '  igvm            IGVM file support'
+  printf "%s\n" '  igvm            Independent Guest Virtual Machine (IGVM) file support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
-- 
2.50.1


