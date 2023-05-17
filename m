Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C042170701F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFo-0003C6-0K; Wed, 17 May 2023 13:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEY-0000JA-8D
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEW-0004NL-NS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZLbxMCZ5/pZsSEQbytFR8Ifx73pTURrqmwPuyeAL9Q=;
 b=QSYeWDhDJtJSQXTWvAcmRf2kcNmVX+xWXyliCsw6YF+K5KonkKAf4ZxPeNFuDV0sufn6r4
 rO4lXrbG8Hd8tIC4yEuOXKJBKm62mg+K9h9b459jpd3X0hi6lPa3jp0uBMYdzr/4ch8Zsv
 Vog+WWNnPjAHZT0wm1hMXQy7fWEqMaI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-TBK0aT3qOTuEqQyaGkPU8g-1; Wed, 17 May 2023 13:46:38 -0400
X-MC-Unique: TBK0aT3qOTuEqQyaGkPU8g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42b36733aso4440135e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345597; x=1686937597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZLbxMCZ5/pZsSEQbytFR8Ifx73pTURrqmwPuyeAL9Q=;
 b=Uv7IB5lXvDtO82r/vfBPoUmOIA/Vz5ZWGr70iPE6nVobX/L20p1azAJcEpGGTHI5ss
 jiszeudv9xr7hUTzl7v1Jw2pq+OjZWvW77zyhtuYU2mnU+xwhnojLuRX3fmaONm1pVH3
 dfl/wlgkArNVC4uy0I1qc0fPRzlz3xYaM49XtzvhmzLgOG57p/6jjIfKYVHj5PBXr1VX
 Tms4/T4uQvcRn5IMxNc/Lb55Z0CRetzMeahO1rMjIS/6U/rG7ObC5oGy8IrIYg5k1tec
 4L1RMjsOxhYpoYsvPKWslSjMDoNZWlgHm8jdBXQnGoDVSEb4tXiMeLHSklaWKitlaxus
 +Q/Q==
X-Gm-Message-State: AC+VfDxM3n5F7OdmMX9pLEhUZN4km5vkWubqTagc3kxG3xwSpeGWS1Wk
 1vBZcxvRUy2gec1v5hGctn+VviqGVxrk6R2Yt3oZBQK1RwzNM1B8CJoHmC63SkmD4vG3ezlds8a
 sVBTudFLUW0CJgtzEy/gHpcyXhgydnIbCf6e0PaK/rRsjqofaD7O0B1aK+2fTKx/kYiLdkoEOU5
 s=
X-Received: by 2002:a05:600c:d2:b0:3f4:28db:f609 with SMTP id
 u18-20020a05600c00d200b003f428dbf609mr23676636wmm.36.1684345596970; 
 Wed, 17 May 2023 10:46:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qwsBZFt0MtydiRx4MfRDbu1I5zSDM8gAHa/XfB0selH0sbILOx3G31FgFAm0xz0+gf8boEQ==
X-Received: by 2002:a05:600c:d2:b0:3f4:28db:f609 with SMTP id
 u18-20020a05600c00d200b003f428dbf609mr23676628wmm.36.1684345596646; 
 Wed, 17 May 2023 10:46:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a5d4a84000000b003068f5cca8csm3386711wrq.94.2023.05.17.10.46.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/68] meson: regenerate meson-buildoptions.sh
Date: Wed, 17 May 2023 19:44:57 +0200
Message-Id: <20230517174520.887405-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index fedb93ada69e..10c4969a013e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -1,8 +1,8 @@
 # This file is generated by meson-buildoptions.py, do not edit!
 meson_options_help() {
-  printf "%s\n" '  --audio-drv-list=CHOICES Set audio driver list [default] (choices: al'
-  printf "%s\n" '                           sa/coreaudio/default/dsound/jack/oss/pa/'
-  printf "%s\n" '                           pipewire/sdl/sndio)'
+  printf "%s\n" '  --audio-drv-list=CHOICES Set audio driver list [default] (choices: alsa/co'
+  printf "%s\n" '                           reaudio/default/dsound/jack/oss/pa/pipewire/sdl/s'
+  printf "%s\n" '                           ndio)'
   printf "%s\n" '  --block-drv-ro-whitelist=VALUE'
   printf "%s\n" '                           set block driver read-only whitelist (by default'
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
-- 
2.40.1


