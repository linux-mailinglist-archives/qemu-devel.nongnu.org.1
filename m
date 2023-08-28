Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE1778AC61
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeL-0003Lw-AG; Mon, 28 Aug 2023 06:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeJ-0003LC-2T
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeG-00053v-GS
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtnigPwYrkw+syJ1RKRV7rrWaWAhs4dM1w6xC1P/woc=;
 b=HcnJTOfU8xo05ZhINpzw15aw4Uqjusrd7lqQTK7VDK4NO8VkByAt2bCG+whEwahSrNn7C2
 NF9Yswielsv6EfcTYrsc+1hFO153/878kftcLpDNHPpHwX0wJuO0N1aES2ceRDa6ynS696
 kuZfZgGCsCirSf8ZU13dfJWSDl1kgss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-OtIhhYXbPaSyhxhWBcExjg-1; Mon, 28 Aug 2023 06:39:05 -0400
X-MC-Unique: OtIhhYXbPaSyhxhWBcExjg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31c5c55fd70so1657452f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219143; x=1693823943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtnigPwYrkw+syJ1RKRV7rrWaWAhs4dM1w6xC1P/woc=;
 b=bW0bJp6QVyg1flFx/t7gpvxT0O21unJopGJrNkwpG3fNSLUBjLe6X2wxhsBKB2h8ot
 hREx63xAtgogci610hbWOhpFxCeUOSn6m20GhQnuSN+EBtiCOxCqWBceNy5ayo1v+v14
 YO4ieZakg9ttAFdboWfFhaV9OCVVj9ZXpQkIawjHJrllTG3vJwBMw8MVOypajvQnH+2n
 R961x8nGDHGBP85iMR/nWSe2tPkyi2ljqi24tH5pBDd+avqfxN1EXDFa51nYz80dJ3Br
 bPSRT+KyxAFOEiwpwn8ma3YulypEAFn1xODaZr4cA8POjoEJpFt8QX7PK+LXK6G4kUjh
 wjhQ==
X-Gm-Message-State: AOJu0YywuXCQwPi8ShCVV6w1Z+WT43U0JAV3KwlJpd8/DparJjD/VvYm
 r/g0m+NzoOieK6wtEUmnd8D2Nit8MIDGEts7PqPToybueSqNlv/AKvtYMQQ0Ju/ovyKh2moYJC2
 Xs0Nah84BPxnuSpOdxKq5T7pkJDn/Ehdi8vwWuK+nVdhXBjsXTBxzbIyHTAOrSfINbk8NRjRNa6
 s=
X-Received: by 2002:adf:fd08:0:b0:314:c6b:b9a2 with SMTP id
 e8-20020adffd08000000b003140c6bb9a2mr21006257wrr.13.1693219143688; 
 Mon, 28 Aug 2023 03:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSHm68JBlxOYFFHyNZFd0s66KAF1pNXk+lBNVefNix7ZA6eq+U82VQBAp1A5p+6PHCTBrE/w==
X-Received: by 2002:adf:fd08:0:b0:314:c6b:b9a2 with SMTP id
 e8-20020adffd08000000b003140c6bb9a2mr21006249wrr.13.1693219143471; 
 Mon, 28 Aug 2023 03:39:03 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b003142ea7a661sm10205203wrn.21.2023.08.28.03.39.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/14] python: mkvenv: tweak the matching of --diagnose to
 depspecs
Date: Mon, 28 Aug 2023 12:38:42 +0200
Message-ID: <20230828103856.46031-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move the matching between the "absent" array and dep_specs[0] inside
the loop, preparing for the possibility of having multiple canaries
among the installed packages.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a47f1eaf5d6..399659b22f1 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -806,6 +806,7 @@ def _do_ensure(
     """
     absent = []
     present = []
+    canary = None
     for spec in dep_specs:
         matcher = distlib.version.LegacyMatcher(spec)
         ver = _get_version(matcher.name)
@@ -817,6 +818,8 @@ def _do_ensure(
             or not matcher.match(distlib.version.LegacyVersion(ver))
         ):
             absent.append(spec)
+            if spec == dep_specs[0]:
+                canary = prog
         else:
             logger.info("found %s %s", matcher.name, ver)
             present.append(matcher.name)
@@ -839,7 +842,7 @@ def _do_ensure(
             absent[0],
             online,
             wheels_dir,
-            prog if absent[0] == dep_specs[0] else None,
+            canary,
         )
 
     return None
-- 
2.41.0


