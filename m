Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3823820E97
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 22:23:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK3GC-0001I9-PR; Sun, 31 Dec 2023 16:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2up-000780-IY
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:11 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2un-0007N1-NZ
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:11 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78104f6f692so636636585a.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 13:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704056406; x=1704661206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dteAf542Gh+t9jeb7xSrraAPUQpSdtvicUVPJE3U4ww=;
 b=X7TAju1Jq7lOI7+wZ4GiF+xTN9ogYBR9J/IKR8a8rCWC4vqZ0KU2mqnwKnibYWgxxr
 C3mm6fgFJoyMWb+rWAmBq7GZq+hZANYOT8Y1NJjEQc50vWAYiTr1sTMZhrlyEzi8Rv7/
 nT8fsdgTk8fzwXc+H80JOBt4fqTZ6lpjTTH218DUbHDaOD/CmSt4uKyG+ylVTcI/jYwn
 GkbRHViLhhV5wfKJzBe2PMUjjM5K9jZIPMf0YVp4RmXOSD+C83sYDvQTImf6AjaAbYzc
 ki/MFDpn6y9DqdkihV4ZcOQJ8SLzsF18Y8nwD+7ZHu8FthLD+AE47pt8Aq5uhMCFdkHf
 yJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704056406; x=1704661206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dteAf542Gh+t9jeb7xSrraAPUQpSdtvicUVPJE3U4ww=;
 b=uoDA9Jiu0P30d1QxIEMBz1JmvJ36CRYV7TqlJOEH7im6XHMOCcFSnxCXOXIWt6Ehad
 vO1BUPibPDndgDMgE6ZpUPci+SFXMfO4NqNcwx8Wa1vTpa+JQoBWhKsJTeZiUL2iVtMf
 4//qcrx/YlpuvXctkiFcFBDKKxxPnEdTE0oUdocQRJeEtuwPz0XQKKckA04z+rAWnJhp
 UpxM6FvNRePlyTTm9RFr6mVcZ/569/DGR3EIVCSUNB87oDS0Ar1ySNtL9xjIWnsAB1FI
 GtWSYNeU3Ghk5KpVJ3CGWECZIixtXpNlay+jbxWGRBkxVuos4hhBj3qeXmynXNIfRSzO
 hXvA==
X-Gm-Message-State: AOJu0YzIm82Rr4UvKRBI3Z9bIoTsOQJ9y2XKy7c7GG/HliHzKEKcbt2O
 aSiDyx/hMQp9vDDm5CC0426OLSCJZRb2N9YtcU+Tk8sBAA7Pdw==
X-Google-Smtp-Source: AGHT+IHGWslJh0k8SCf0zwZ/4C7W0BYGJh3Xt5tRVqd1rW8AsbaAwS6gNh5sqawHw1WzUOyFC4GwGA==
X-Received: by 2002:a05:620a:4309:b0:781:bd80:af82 with SMTP id
 u9-20020a05620a430900b00781bd80af82mr1545815qko.37.1704056405262; 
 Sun, 31 Dec 2023 13:00:05 -0800 (PST)
Received: from n36-186-108.byted.org. ([147.160.184.90])
 by smtp.gmail.com with ESMTPSA id
 pb21-20020a05620a839500b007811da87cefsm8111750qkn.127.2023.12.31.13.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 13:00:05 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 peterx@redhat.com, quintela@redhat.com, peter.maydell@linaro.org,
 hao.xiang@bytedance.com
Cc: bryan.zhang@bytedance.com
Subject: [PATCH 1/5] meson: Introduce 'qatzip' feature to the build system.
Date: Sun, 31 Dec 2023 20:58:00 +0000
Message-Id: <20231231205804.2366509-2-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Dec 2023 16:22:08 -0500
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

Add a 'qatzip' feature, which is automatically disabled, and which
depends on the QATzip library if enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/meson.build b/meson.build
index 6c77d9687d..99050b1109 100644
--- a/meson.build
+++ b/meson.build
@@ -1041,6 +1041,14 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+
+qatzip = not_found
+if get_option('qatzip').enabled()
+  qatzip = dependency('qatzip', version: '>=1.1.2',
+                      required: get_option('qatzip'),
+                      method: 'pkg-config')
+endif
+
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and targetos == 'linux' and pixman.found()
@@ -2208,6 +2216,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_QATZIP', qatzip.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4379,6 +4388,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'QATzip support':    qatzip}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index c9baeda639..0f3b380f82 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -259,6 +259,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
+option('qatzip', type: 'feature', value: 'disabled',
+       description: 'QATzip compression support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..1afd373606 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -164,6 +164,7 @@ meson_options_help() {
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
   printf "%s\n" '  pvrdma          Enable PVRDMA support'
+  printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
@@ -430,6 +431,8 @@ _meson_option_parse() {
     --prefix=*) quote_sh "-Dprefix=$2" ;;
     --enable-pvrdma) printf "%s" -Dpvrdma=enabled ;;
     --disable-pvrdma) printf "%s" -Dpvrdma=disabled ;;
+    --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
+    --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
     --disable-qcow1) printf "%s" -Dqcow1=disabled ;;
     --enable-qed) printf "%s" -Dqed=enabled ;;
-- 
2.30.2


