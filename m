Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD998656D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Sep 2024 19:13:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYj-0000yZ-B9; Wed, 25 Sep 2024 13:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYO-0000K5-CI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYJ-0000bW-By
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so229325e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284306; x=1727889106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDuKUu/6yQVewIifCo34+Vf5uNGO51ibdAtzIBiO5J8=;
 b=AA/Nv/cD5A5XNGyTS9Byh0ZEgbCYPbTcrz8vRn3LDi+wP+jvx0Hcp2lT5MAzMeGROU
 DWEoOFPhe1Z2cnYO+6SRvfeBIKtUn4OkcMd16mrfLrIyVR+elBsUElfoPhcJeCvj869H
 D8CNrQxZo8VFjfk2xQyqEQfQQBvLAjyynspWG0GMO+biKiPIxqjO3ffbFNhD5vRi2Q5l
 vfC2451j6u/Lug0+Cqf0NYHbesRDiT5TOvVRvcUXBqeZ6JRNAoJj53jC7DwhgHPrZvzU
 4JXcYBF61WsO1BGqdD3xTef0q5cnCxcNyZ2b9rHps6HL7a4NW/dbJTEms0e1HYfQwnz9
 rTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284306; x=1727889106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDuKUu/6yQVewIifCo34+Vf5uNGO51ibdAtzIBiO5J8=;
 b=YDu8hDIgfZ4SFBnRvhS7Y86NxWr3QRa5+bwmNzGqoto56p5CGo6tO4pL4nKp0gvUOT
 NGQOGO4vaz68ty1AAa0UZlrA1G0SOGiX6FU8Jf1DzK8QoFgJ7lPyw1PG1CTBEssTEvvX
 c2Qc/F1wtEKP5SqZt1E20WWX7xnCmTpC9CWRRmgUFkX5D6VUK4RwQX8bQCbpASchh8+t
 VSel95tpjJHCAxuNpbtYvsCGH8VWFV6o1UoxflObPioZxxeGCN9/N2Ohc9BbGxSyePa6
 G3i1GUMlSrrN2+urgLlWfoz/M489sxTCUxquaAiep2Rdlrsp44wwGZiE98phBWsjzqcu
 +OSw==
X-Gm-Message-State: AOJu0YwCjImnrvYIcXHW6YTgdlfi/OdVFoeUPYCTZUgj096UrXNAnv4F
 98pXU5LeCpmr5jO3Voqjn3PuXISlV1K7uOFxX166CLSvP1v4bp32/kjvOxUxgkI=
X-Google-Smtp-Source: AGHT+IEA9zk5J4EgLwcu9iKTkG6OebG0V871ScTHwgvkLHU/Z/qAW1uTvFwLsqIXWyXSVXC9pmkYyw==
X-Received: by 2002:a05:600c:a085:b0:42f:310f:de9 with SMTP id
 5b1f17b1804b1-42f310f1005mr13936295e9.15.1727284305716; 
 Wed, 25 Sep 2024 10:11:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969e18f7sm24065735e9.5.2024.09.25.10.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E015C5FA3D;
 Wed, 25 Sep 2024 18:11:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 06/10] target/i386: fix build warning (gcc-12
 -fsanitize=thread)
Date: Wed, 25 Sep 2024 18:11:36 +0100
Message-Id: <20240925171140.1307033-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Found on debian stable.

../target/i386/kvm/kvm.c: In function ‘kvm_handle_rdmsr’:
../target/i386/kvm/kvm.c:5345:1: error: control reaches end of non-void function [-Werror=return-type]
 5345 | }
      | ^
../target/i386/kvm/kvm.c: In function ‘kvm_handle_wrmsr’:
../target/i386/kvm/kvm.c:5364:1: error: control reaches end of non-void function [-Werror=return-type]
 5364 | }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240910174013.1433331-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ada581c5d6..c8056ef83d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5771,7 +5771,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
@@ -5790,7 +5790,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static bool has_sgx_provisioning;
-- 
2.39.5


