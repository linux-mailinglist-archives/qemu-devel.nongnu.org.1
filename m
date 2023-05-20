Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5570AAA0
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:08:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Rum-0007H6-Of; Sat, 20 May 2023 15:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Ruk-0007Gv-RT
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Ruj-00008p-BE
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+uAVWJIlaKEAvLadAmkjz7dYWA6Y4OgVYfAWCmHVUA=;
 b=fN+f5Ap5WVGuuj7mv0htUctSbtEGpy2nnFycSILriJSzc6eI2uS4pnxGUc1+joYqPxlWbk
 Ud5taJZu724QJR3nEZLO/u7wPhrQuT6kV5MyuO0Zwssi23VQ0+jMfYj4sutz1X84fos9bN
 QONJyq9DzZaft/3FBGLS067MEDaNz4k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-KWfA_EiqPsiLPATEWhsq-A-1; Sat, 20 May 2023 15:06:46 -0400
X-MC-Unique: KWfA_EiqPsiLPATEWhsq-A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f6e83685eso197667566b.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609605; x=1687201605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+uAVWJIlaKEAvLadAmkjz7dYWA6Y4OgVYfAWCmHVUA=;
 b=VV7ZKyn8mcSirALsAEmNSYHBuR+i1ESfcfxnZ0HhGjLSQ4ILOaNLWLhV2OtaBISbY0
 s/L+Mfb8JybZU5p+G5wjdLUhe92rFiFgTx2iGF4EBDitiiPz4GX396JFFpRESXwuF0YU
 CWuxlZFkguFFiF31Qv/y+XUrO55rlyLuu8cGboRaP+zJIzcz08KqHXCDA/+2jv4kJCGB
 euKS6PQ0P+6bvebRP0Kw9U4sP4WXMF0h/AEcFkN1ToNN0nH5afDVttfpiN35n9BxzHBu
 z3jG41nLeQRqb11/I7khZWOsDAZfZirDNVZgMbTsks6dJDMcccs9o0Jm1gvtG8uWWZZJ
 x/7g==
X-Gm-Message-State: AC+VfDxqWx7tJ3hJI3sRkDumcCBaXQcvuwSjApby6qH72Zq0fYXybn0A
 sLRAKQ43bDIeFVmK2bbfdZ2tNNYqaxXT2JEeDvliZMYwamqZWxkbdDDstTWffWNwaqWzH7ZYZzc
 w3ARrqatvIO054j4D0SVqS6kEjlsSYHoctRPxwi9lcuNgSW+JxX9oPc/BNA2LbsANINSS9+AO1x
 E=
X-Received: by 2002:a17:907:628f:b0:961:b0:3dfd with SMTP id
 nd15-20020a170907628f00b0096100b03dfdmr5829503ejc.7.1684609605177; 
 Sat, 20 May 2023 12:06:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ggwsgVXn7Gn+GEtxrIxG+oIBcKzUqsORxSksPhqs3O4pTq4j/QR1ZO5JTrXflOq5QQ0u+Yg==
X-Received: by 2002:a17:907:628f:b0:961:b0:3dfd with SMTP id
 nd15-20020a170907628f00b0096100b03dfdmr5829494ejc.7.1684609604928; 
 Sat, 20 May 2023 12:06:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 d18-20020aa7d5d2000000b0050bc9ffed66sm1054453eds.53.2023.05.20.12.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 7/7] scripts: make sure scripts are invoked via $(PYTHON)
Date: Sat, 20 May 2023 21:06:32 +0200
Message-Id: <20230520190632.7491-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
References: <20230520190632.7491-1-pbonzini@redhat.com>
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

Some scripts are invoked via the first "python3" binary in the PATH,
because they are executable and their shebang line is "#! /usr/bin/env
python3".  To enforce usage of $(PYTHON), make them nonexecutable.
Scripts invoked via meson need nothing else, and meson-buildoptions.py
is already using $(PYTHON).  For probe-gdb-support.py however the
invocation in the configure script has to be adjusted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 2 +-
 scripts/meson-buildoptions.py | 0
 scripts/modinfo-collect.py    | 0
 scripts/modinfo-generate.py   | 0
 scripts/probe-gdb-support.py  | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 mode change 100755 => 100644 scripts/meson-buildoptions.py
 mode change 100755 => 100644 scripts/modinfo-collect.py
 mode change 100755 => 100644 scripts/modinfo-generate.py
 mode change 100755 => 100644 scripts/probe-gdb-support.py

diff --git a/configure b/configure
index f7cd376e525f..1bdc7fd69b7b 100755
--- a/configure
+++ b/configure
@@ -1767,7 +1767,7 @@ if test -n "$gdb_bin"; then
     gdb_version=$($gdb_bin --version | head -n 1)
     if version_ge ${gdb_version##* } 9.1; then
         echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
-        gdb_arches=$("$source_path/scripts/probe-gdb-support.py" $gdb_bin)
+        gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
     else
         gdb_bin=""
     fi
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
old mode 100755
new mode 100644
diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
old mode 100755
new mode 100644
diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
old mode 100755
new mode 100644
diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
old mode 100755
new mode 100644
-- 
2.40.1


