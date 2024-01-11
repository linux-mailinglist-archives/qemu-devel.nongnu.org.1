Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DD82B205
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:45:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxEs-00089S-LQ; Thu, 11 Jan 2024 10:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEp-00086J-Lz
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:44:59 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEo-0007oB-4K
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:44:59 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bbc7746812so4944508b6e.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704987896; x=1705592696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xX0pOm2vruiJrlVAX8MbAu8t5DYYdB4AcErZuPkHXbg=;
 b=dno2KCYqQjPS2h6KFWjVP6RRXAoUdLSDZ/cen2pcNSPXYV+mvjTGGXtWpwnpgAWRgi
 s80XDGI8Q31rUhQfDkazQqFuh2zD9Q6VAX1GctRVpR4Tqhxy8+vIbJDXseEL9CmOYKoN
 GUOv+PbaICxpsbCyxA9UUdx/Vj6rdzWX2nLZEtk0qvsSNOkFVNvmGvRk8/VnzfZT+BWs
 p2xYg783wixRM+wkURs6EZqytIczqtFLP/+DiLc02ZPA4OeGNVyYQp6UnCfeycNz3poM
 1Volq/PgUrCP+HX93dtNoNFVLNM0cyuXXtKO0VsVacbteXu5wSwq2GdHO9J3NVxtO3Sq
 ycBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704987896; x=1705592696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xX0pOm2vruiJrlVAX8MbAu8t5DYYdB4AcErZuPkHXbg=;
 b=m4KUhtKY/TtD7qdpiG8siT/ciqgXnFdHDLkGsK+AEpLrvwvCedKJt9IVKWwp+JZEzz
 S+ZGI/T5la8pPYm9wSlWecqksXkUMA6qn0afCANVhK3AMVP5IqONRtzsMW1cI52sctIg
 UbP99HV4cJOfycmB0V1L12pflUyn7odEebM4gdbpIX1q2wa7Vk27b9xHu+kqzITlHZPc
 cMDBqVrg8NsrHuPxNSn75a8DkwvZdpqfF/NNGLcpYEEHefD7efULmahGOWOYU7dxxyMT
 21+0Vw/GuHJLFoRfJiA1dseaOH2lGhJFr86Z012ITeDh4gA4oX+ZN8izaZ9yqWr2+8FS
 jorw==
X-Gm-Message-State: AOJu0YzMl7kGF5sFLDsm+9VrifAmSxesyhKI3wHnVoS9H4+iXZW9D0i9
 xdzyndnNRbocmDYQxjrJNuOl4iuuaWLTQx8Z
X-Google-Smtp-Source: AGHT+IFxvEnFt8YHp6Z0BiCB3Cy9V3m2cEiUKXfmLoZq1qIdmx9qGdfv5VDEtVDml3/xCF+SndJtPg==
X-Received: by 2002:a05:6358:e820:b0:172:dbff:766e with SMTP id
 gi32-20020a056358e82000b00172dbff766emr8874rwb.53.1704987896376; 
 Thu, 11 Jan 2024 07:44:56 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:e868:3e48:c113:4a7f])
 by smtp.googlemail.com with ESMTPSA id
 fb9-20020a056a002d8900b006da550512d8sm1317887pfb.126.2024.01.11.07.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:44:56 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v12 5/7] test: bios-tables-test: prepare IVRS change in ACPI
 table
Date: Thu, 11 Jan 2024 22:44:02 +0700
Message-Id: <20240111154404.5333-6-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111154404.5333-1-minhquangbui99@gmail.com>
References: <20240111154404.5333-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=minhquangbui99@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Following the instructions in bios-tables-test, this lists that IVRS.ivrs
in ACPI table will be changed to add new IVHD type 0x11.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac420db6b7 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/IVRS.ivrs",
-- 
2.25.1


