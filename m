Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F100B7E6D5D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16sm-00080L-Cq; Thu, 09 Nov 2023 10:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r16sj-0007zb-Sw
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:23:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r16sh-0001dp-Rv
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:23:45 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so9201695ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699543422; x=1700148222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xX0pOm2vruiJrlVAX8MbAu8t5DYYdB4AcErZuPkHXbg=;
 b=YZAkEMLbzDUwo+Ccn6HTIH8LtTC7b+rnMscBYJnG5JJ92G0uST87qG1Aw4/KEhx6Pm
 VKAwU6ErmxyxJ2HAh9Ry4K0TgAChbnh7YmTelMKSP/rzCSOFZKQxZdJhT84Z6IrZS2vS
 DnpV3v4i4GuQk76NuW3hJfs279tPBQsjqouIjPc+eZsFmU7pCDLo78t9+3iBdgN6+7LZ
 fiVL+9bqtKNQJF1EGZYuRrcO9Qzf1rOeI6vCYl8nqBgTZD/h8AJrGVWFfRwzLNjCGP47
 p4OJxGGM2RUqDDfcyaD/0qQoLpoZtoduxndEpZ1u0udpvMbBJRjz9ddVlhHwjt1DdpNU
 MlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699543422; x=1700148222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xX0pOm2vruiJrlVAX8MbAu8t5DYYdB4AcErZuPkHXbg=;
 b=oR1lk91VlUxmi6vmfvplQ3qqHkbex2+kajwEa2xzlHVMwvDGyD/8g1yY2wN/F54dvw
 pionfb7WyJV2ru6KEPgBzFMvN29RWZAv9IlKA5ftxYHQLXraGPLoXk/0fzXdWZu6Y3Td
 nUuBGE9cxKAXt4LWyMAUbAhoAyZSY8tl2wqGJYMQ7cv9gOwxVRZP6GvMi+zZ/ZT/MJ61
 4X7/RrGHBd6CliH6lSIy1o/nxOcVoKGqhTYlEdXQfy5Tbg19X4jLufv7hoHbu7y4fbN3
 T2mBvbO2yIsnE2fTOlvip3A0Bt7Tp9rHlYC7UCuIFLfPGttDGhijWKxgU8DFtjJ919Vj
 GifA==
X-Gm-Message-State: AOJu0YwVPujkCRuZIZ8qzUS/B5T75N3hvY850BijvkXyEeJsUE82k1mL
 P1EclfGyq5CXo0HCv0z8HMTTNVdZj9tKWw==
X-Google-Smtp-Source: AGHT+IGVo22q0aBoeBuYdMcFwLALKgWLreRO3mbGA7B8/hTKfU6qrNOAMrtpIP21shbAIgblt+TMVA==
X-Received: by 2002:a17:902:76c4:b0:1c7:495c:87e0 with SMTP id
 j4-20020a17090276c400b001c7495c87e0mr5054099plt.37.1699543422314; 
 Thu, 09 Nov 2023 07:23:42 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:b178:6138:397c:2ce7])
 by smtp.googlemail.com with ESMTPSA id
 y16-20020a17090264d000b001cc311ef152sm3707107pli.286.2023.11.09.07.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 07:23:41 -0800 (PST)
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
Subject: [PATCH v10 5/7] test: bios-tables-test: prepare IVRS change in ACPI
 table
Date: Thu,  9 Nov 2023 22:19:22 +0700
Message-Id: <20231109151924.267515-6-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109151924.267515-1-minhquangbui99@gmail.com>
References: <20231109151924.267515-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x636.google.com
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


