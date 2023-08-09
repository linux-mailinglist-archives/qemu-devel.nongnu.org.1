Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F6775670
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfVm-0004XB-J3; Wed, 09 Aug 2023 05:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVe-0004WP-Bg
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVc-0003Zp-Te
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtnigPwYrkw+syJ1RKRV7rrWaWAhs4dM1w6xC1P/woc=;
 b=Q+0qYjsZEQNUvJ54hgpwQZxBLkzuM/Vhxu8jN6paQI2+dQSBBOCiCTOJfzJw4RU1+zV/y8
 UYZFJT7dPyloGE9dsSy26anJD/1c2F6YVo4A6lGQuYn+9/HiS83Tx92aHeBSXOjdYllQMe
 w+b9k+Cegnzlpyb0aV/AHHp/e9uPKIA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-cRfYQSidPaqcBRtV6o4Q6w-1; Wed, 09 Aug 2023 05:29:38 -0400
X-MC-Unique: cRfYQSidPaqcBRtV6o4Q6w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe175fc1f8so43248145e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573377; x=1692178177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtnigPwYrkw+syJ1RKRV7rrWaWAhs4dM1w6xC1P/woc=;
 b=jZ1b3imBPQX9Iv7o2oq9RE2Jgb5zix2+mVwR+uST+73QLSt2Udnr4e+f6ZlLorrAte
 1w5Am7XD5R4X6L15bXKENeoLjiurMp1wTDKvdJGRooqi9SfGWsXJG1Pdx1lCG+SDERLe
 s8kVLIgK1cc1u1VrWXrZ4zc/rdMWnvUC7lUpz4PUW0euL7UUGD3NtugxwfATaXY+zJrc
 kjD1rWQRXbtyYb54MQi1T1xwQ1dTpIT3onERIoCZtHgi52ZWNZ28GLycnKtblRWkZuET
 l/dHs5n5ILaI2zRFqN1DfmF398Nzkg3QAYLtrmIvVZ5WJf6ItpCgxupOg8dosJbp6sFD
 QUOg==
X-Gm-Message-State: AOJu0YyBYvU4JF5g9yop5gCYthuSj8f+LxYDrZBFCPoGuMt3aIxLmqqW
 hwEVb8w241BuBRZq9nbGxh2mnPCyIwZpub6q/9uc2w6Zzyguc/RDD0xMRvht/tQzu39wkiwdbIK
 5488SoWnpIeszyGCokG/Hgpn0WSPQxour8EJjNPOf8GwrPQsTnkq6B30H8CtXWLXAcX1PbCWAYI
 I=
X-Received: by 2002:a7b:cc8e:0:b0:3f9:b748:ff37 with SMTP id
 p14-20020a7bcc8e000000b003f9b748ff37mr1739302wma.20.1691573376879; 
 Wed, 09 Aug 2023 02:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhNtBgfZ3w0ljlykiy5NfX3NqJAMLhm56PLpgFD6AGLcwQ8m87IoQ9jix8ncUEBEgdb7ssgQ==
X-Received: by 2002:a7b:cc8e:0:b0:3f9:b748:ff37 with SMTP id
 p14-20020a7bcc8e000000b003f9b748ff37mr1739289wma.20.1691573376437; 
 Wed, 09 Aug 2023 02:29:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a05600c211200b003fbb0c01d4bsm1396935wml.16.2023.08.09.02.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 1/9] python: mkvenv: tweak the matching of --diagnose to
 depspecs
Date: Wed,  9 Aug 2023 11:29:25 +0200
Message-ID: <20230809092933.761524-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
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


