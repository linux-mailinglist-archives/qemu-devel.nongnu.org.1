Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6279525EB
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Aug 2024 00:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMgc-0002Dw-KS; Wed, 14 Aug 2024 18:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMga-000262-9q
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgY-0007Lm-3w
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so10990515ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723675298; x=1724280098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkpyTpSOlqu0+QkwYEsdEX4Fr7KToSSmbcU9XazMmXA=;
 b=yKEHhFeh69YRsOJybIuyUxNOpaf8Ayut5UhrHfLeKsjOs/1dGWpetcAAu9rLXVal87
 IgdD1gmipl8M8a5RCl4YivDIGGZIO4Dx4R0FR7NTSsvHZ6G0mwwvnVYdfDqqEnymuvSO
 qhB24x0/ytx0os8EzAtoTM7CT9EtJ+h4S3c9CU95qRux3Tt7nHuS49DCINrzPrfL8MNa
 DB2IAofyr91KTRfHSMwkblAtV6JVllw5R3VuJ3i8WeNx0DfVnjEJfwE4w2L1DYgRkoUm
 OSzY+kNvTM0uB5KWQzX8qjvNqpJgrWTHngEWTtfQBTzNcMB0eQMHShTp9HfhIwQLOa6V
 UIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723675298; x=1724280098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkpyTpSOlqu0+QkwYEsdEX4Fr7KToSSmbcU9XazMmXA=;
 b=VWK37P7ff1QelitRD2YixDXlncN5siypw0qlHEd3SQ3caOYGThKzi18rgQm24X2cn+
 MJxoR4KIHrDsNjydCDiMd0UV6KB+GJ4/L/QeMc75wZ8wVqxE3u9yHRK5An/ebWbmDiZD
 dZ8uyWQT4tHwi/78ak/2J5cIHgh5D1+wOrkdrdr5XnlVKCjswEbdbUhgvSoVjC/M4+zO
 IANsxC4eIgbTfbSg4HZz0nOZmk2CAUSr0nAqrCp2vBxClMOmXy1nOB4XWhSgdNcQ7Cap
 3oLuYm0M+pv1dYrh3KPYTy7oX4hgM+/uBg7jd3Y7QWyuKGkYdMEHP+6PFiO0h1Xws/LH
 Jgmw==
X-Gm-Message-State: AOJu0YwQVC1zCLEfHCLUZE7mstvGE8DOSeEDfv1PIvXLUBrGKrg34Bx1
 dHWwVjpQiT1B2faklNQ/AOaKPBrTaqWRpzeQ0GIPacGaK679jWycbR12SgaQS1oN6r3rCRBympe
 NrCk=
X-Google-Smtp-Source: AGHT+IGkesrW/K1rSLk7UrsKDf2/qUa/M6f0mBcupHt3koifZY7D+XvsN9EVSwi1JJN5HwVBtak53g==
X-Received: by 2002:a17:903:41ca:b0:1fd:a412:5df2 with SMTP id
 d9443c01a7336-201ee515b17mr15782565ad.29.1723675298210; 
 Wed, 14 Aug 2024 15:41:38 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03b2874sm1225595ad.308.2024.08.14.15.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 15:41:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/4] target/i386: fix build warning (gcc-12
 -fsanitize=thread)
Date: Wed, 14 Aug 2024 15:41:30 -0700
Message-Id: <20240814224132.897098-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Found on debian stable.

../target/i386/kvm/kvm.c: In function ‘kvm_handle_rdmsr’:
../target/i386/kvm/kvm.c:5345:1: error: control reaches end of non-void function [-Werror=return-type]
 5345 | }
      | ^
../target/i386/kvm/kvm.c: In function ‘kvm_handle_wrmsr’:
../target/i386/kvm/kvm.c:5364:1: error: control reaches end of non-void function [-Werror=return-type]
 5364 | }

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 31f149c9902..ddec27edd5b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5770,7 +5770,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
@@ -5789,7 +5789,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static bool has_sgx_provisioning;
-- 
2.39.2


