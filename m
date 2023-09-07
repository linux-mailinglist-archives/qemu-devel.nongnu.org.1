Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76406797296
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeh-0006rK-5y; Thu, 07 Sep 2023 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEeI-00056M-Ka
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEeE-0007Z3-V7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKDzeQlctpkUAsMmGfN8p0M9I6HUXPerO0NUMxheatc=;
 b=Z7vMda7RJUZq4cMAP2elgJCQWnNW7rNcAFIzYpxFxvcESHJvUv/4gltuLRIlMxBaCZ3P4i
 s9VW1pU95C7aQzBty2zSnVZqVcvEpMiERw5ycYOPPUyLrfb06JwtS96Z6ZPf7rlvHV73go
 H8dZTmEaN9EcCOIWRsCl5VJ3BMLfC8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-AHSUkkbNPReyjMeTvJJv5w-1; Thu, 07 Sep 2023 09:02:07 -0400
X-MC-Unique: AHSUkkbNPReyjMeTvJJv5w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1dadb5d2so6919535e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091723; x=1694696523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKDzeQlctpkUAsMmGfN8p0M9I6HUXPerO0NUMxheatc=;
 b=NsgbGDFN8yWSFyobeUKEz1eU9PegCW3CN8NBlMcojXk/Tb+iXgmnEnDvpcCN7ma/Qg
 H5N383N8+zhunLdgU47U5d1mVwgvoZskMSNO0GSpmB6efFJD9lwK16/jGBC33IFqkSIl
 4T2nvd2HxVqNTJP93O0XE+FlzqbPKa3NAgq7QaBRsXims41FWcYjIPqumxQ42Lzb7DA/
 yo4VWjNV1vpfPPMmZf56jPfcR0yoTWDHqIRzS8uthza+r9e9+UckibopaRR6ovi/1/ab
 gMQXXh1oZZ0SHIJx/TSWNXlCcj3YeAIpL/2iUQ8TCBEmdfhSYmcKYatVcCC1LmQTktnp
 4hJA==
X-Gm-Message-State: AOJu0YwJWXQbopUSAjzNqJnCMpkY6l8K0W/XtghrG0fRqeGT6P1TIi4p
 aHH7CyfIq5kc4/0sab5Hjcqe8+G28AQbT/qnVoxYNrG+nhlQOJcIknvb/pcI4LZ3Miq6uhNU8+W
 H+eI53tQMfvtzrIV5DEa3LizPhwi0CT4g+KNHsZM9mdjhK0P0QXSewmkFxFP/gJRUv15r9SG86n
 s=
X-Received: by 2002:a7b:c8d6:0:b0:401:4c61:90ac with SMTP id
 f22-20020a7bc8d6000000b004014c6190acmr5058151wml.11.1694091723618; 
 Thu, 07 Sep 2023 06:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExU/oI2neSkm8bqrOHI8OYHRclQ7ocSMwwwxfuwHaaftKMd3OQVTpavSGuSEtvCgHI1wta5w==
X-Received: by 2002:a7b:c8d6:0:b0:401:4c61:90ac with SMTP id
 f22-20020a7bc8d6000000b004014c6190acmr5058128wml.11.1694091723314; 
 Thu, 07 Sep 2023 06:02:03 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a7bce12000000b003fc01189b0dsm2436081wmc.42.2023.09.07.06.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:02:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 51/51] docs/system/replay: do not show removed command line
 option
Date: Thu,  7 Sep 2023 15:00:00 +0200
Message-ID: <20230907130004.500601-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Cc: qemu-trivial@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/replay.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/replay.rst b/docs/system/replay.rst
index 3105327423c..ca7c17c63da 100644
--- a/docs/system/replay.rst
+++ b/docs/system/replay.rst
@@ -181,7 +181,7 @@ Audio data is recorded and replay automatically. The command line for recording
 and replaying must contain identical specifications of audio hardware, e.g.:
 
 .. parsed-literal::
-    -soundhw ac97
+    -audio pa,model=ac97
 
 Serial ports
 ------------
-- 
2.41.0


