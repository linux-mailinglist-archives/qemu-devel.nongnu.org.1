Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A747264FF
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vNq-0005qG-Dd; Wed, 07 Jun 2023 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vNn-0005pn-RT
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vNm-0003A7-9B
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686152853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dLHPEhRLIggHN4ZtOEDI/itCzhG5MgYHqv8hzSwosY=;
 b=aZSPs9p7d18i0LSkWM6X5und28zceBQ1BJfSX7UlQEe7OyfOVIm3t14IIXjxFbw8NodFlG
 rE4SdNj3Nc7d4wTa80Dzx3ZU2GUUxkCMVyXo8Luyl+v4kMC6aexjWCkAT6CyOnKD7fb8le
 fY1TYphcmpBox+oEnMEVNj2s2g5y+TM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-lVBSbDSNOb2n-bfwKj6WrA-1; Wed, 07 Jun 2023 11:47:31 -0400
X-MC-Unique: lVBSbDSNOb2n-bfwKj6WrA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-975942c2a29so450079666b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152850; x=1688744850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dLHPEhRLIggHN4ZtOEDI/itCzhG5MgYHqv8hzSwosY=;
 b=b8ukhmaDTdrD9eioCWMGbCWGxrI0c6Ya0Qx2pZlxVrRbcnj5FkX2ejCxfUtxgpxwkW
 TM5+v1iutTTRkkecYRw25zwL5Z0s0jvEM7OogQqbG/dGWR95qo0cwJnf0K4ag6G/9mQQ
 ChMJqTOVF/rJamCPQgzHP43/8gWZj4Hv1JY370BJueeh9cHOHuNiIwaQ3ITAyOFfxRIL
 rP6mIZB/d2Q5WjFAZulARDMEBVnFiytXzbtjgml9iDKiLamj6KhcOcNlVOh3b+gvRXR4
 2FncjcZAwfX/8vHV+hbWPIve1YE0868/Ag1P3aTwSiClg66TWW7yV4emUjZDsf39iL/f
 uuhA==
X-Gm-Message-State: AC+VfDzSIWfgp4l78tfZYhDo1n5Lbz/jDiexjt+gYVsJI7tmTG7Iq22F
 9YXgc4JFx7UGs09H6Td2WnGNdZ7FFPzoW7ya1KLkuBY3aJ8UCkeTn0gVC2W52HF8KVnnChjGUpu
 5XmLiRNKsbjeafSo2ABwen0V1jWVI0ZbT0M2P11kio15oTqpl6jACF5ProI6SwfrnK5oSciWOHu
 E=
X-Received: by 2002:a17:907:9815:b0:965:6b9e:7ded with SMTP id
 ji21-20020a170907981500b009656b9e7dedmr6120222ejc.42.1686152850252; 
 Wed, 07 Jun 2023 08:47:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eWrhwxYNQtigQgx/criqJ3irehc+33YHBi7LLpvRq5ErlfOXxjTwjHSEJZ2at7tUUk0T2TA==
X-Received: by 2002:a17:907:9815:b0:965:6b9e:7ded with SMTP id
 ji21-20020a170907981500b009656b9e7dedmr6120201ejc.42.1686152849923; 
 Wed, 07 Jun 2023 08:47:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a170906825200b00965ac1510f8sm7053476ejx.185.2023.06.07.08.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:47:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 3/3] tests: fp: remove unused submodules
Date: Wed,  7 Jun 2023 17:47:24 +0200
Message-Id: <20230607154724.253659-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607154724.253659-1-pbonzini@redhat.com>
References: <20230607154724.253659-1-pbonzini@redhat.com>
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

tests/fp/berkeley-softfloat-3 and tests/fp/berkeley-testfloat-3
have been replaced by subprojects, so remove the now-unnecessary
submodules.

Reported-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/fp/berkeley-softfloat-3 | 1 -
 tests/fp/berkeley-testfloat-3 | 1 -
 2 files changed, 2 deletions(-)
 delete mode 160000 tests/fp/berkeley-softfloat-3
 delete mode 160000 tests/fp/berkeley-testfloat-3

diff --git a/tests/fp/berkeley-softfloat-3 b/tests/fp/berkeley-softfloat-3
deleted file mode 160000
index b64af41c327..00000000000
--- a/tests/fp/berkeley-softfloat-3
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit b64af41c3276f97f0e181920400ee056b9c88037
diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
deleted file mode 160000
index 40619cbb3bf..00000000000
--- a/tests/fp/berkeley-testfloat-3
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 40619cbb3bf32872df8c53cc457039229428a263
-- 
2.40.1


