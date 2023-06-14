Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA8730AA5
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 00:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Z04-00043o-UG; Wed, 14 Jun 2023 18:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Z03-00043R-Qh
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:59 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Z02-0001LV-2R
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:59 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f62b512fe2so9820663e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686781796; x=1689373796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPRoSPcAAIcfXPxh8LELJDPj5wkGRqtvwliORQSuHGw=;
 b=C6dZ+T+6Cg/4lYDSUweC3WluXpEzWFSSiQna80ADjLBdWiC/7+XyFdhI2WCEm8OCmO
 /CvLzFCYnJcXO+rX1FrjojFoQ2tDKw5ZW7XwW+WZ+y22re54rh4f5xYAkDDu5mKktkPi
 XPLNoH2bisyCgQImeNWXLvkt47V4NjAbrHF5ckbYHXSXlarvjb4sPmlHmKp7XXS3Edu4
 Ac1wdCO5Y17J0CmjQOhQu1mFAmS0JOKnrH9Z/enhlanz583P8fAsM7LK5d3Tl5PSx1IY
 YY7yidIBxc0T+EtEFisgL+DhnaqVQzRefXTWk7A/C4k5yr1N40hB/a66s6HNPqhs3UiT
 tVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686781796; x=1689373796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPRoSPcAAIcfXPxh8LELJDPj5wkGRqtvwliORQSuHGw=;
 b=gBhIJfe+tCEFI+hBjzHeJJRbttRg1kWkoAsaVV6GMorkTdVNUuuTo1fX20ef2iiSOf
 cw1KvMOX1ifNHnDrQsXr/SspO35YrygY122ZdRVS2HhC5IhuWBs1JUVKJSG7mLqle7M5
 iKRW1EvTMLB7DECZXtbUaf2tWzSb9f7fLgfLRd261zJiyP2QXEojESnUpVl3+jWFpwCV
 gvHidhIpUSAmqosD6my+t3oS30QymUMBlpK1DS8RBEwedJ+KRODftKtUejMoCJlTg6Or
 VUQtKN5ujvVyuU8wItdEW5kw3zKRrudlCxa/3ZbFitZuLQNdnvdktyiFSDZK6FT3IATN
 MI6g==
X-Gm-Message-State: AC+VfDw3ewiB2PaeC9qfa8cnBSubsmhsBeRCeSDaoNUY/QLK661IjG9k
 hAunJrwP2ldwBOC7hD1T8L1ND1JeboYUTqjLrno=
X-Google-Smtp-Source: ACHHUZ79+mnFPd2qSDnlqnU7HvBcKbTSADrwvwU8AkqANE29RAkVUnlUWZ2OnxT/u/ROmeiNyBOdaQ==
X-Received: by 2002:a19:8c05:0:b0:4f7:69b9:fa07 with SMTP id
 o5-20020a198c05000000b004f769b9fa07mr1496335lfd.45.1686781796496; 
 Wed, 14 Jun 2023 15:29:56 -0700 (PDT)
Received: from localhost.localdomain ([46.98.110.34])
 by smtp.gmail.com with ESMTPSA id
 x8-20020ac24888000000b004f39837204fsm2279483lfc.85.2023.06.14.15.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 15:29:56 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v3 5/6] qmp: Added new command to retrieve eBPF blob.
Date: Thu, 15 Jun 2023 01:10:25 +0300
Message-Id: <20230614221026.56950-6-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230614221026.56950-1-andrew@daynix.com>
References: <20230614221026.56950-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::135;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Added command "request-ebpf". This command returns
eBPF program encoded base64. The program taken from the
skeleton and essentially is an ELF object that can be
loaded in the future with libbpf.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 qapi/ebpf.json        | 55 +++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 3 files changed, 57 insertions(+)
 create mode 100644 qapi/ebpf.json

diff --git a/qapi/ebpf.json b/qapi/ebpf.json
new file mode 100644
index 00000000000..6f9a1f1a0c9
--- /dev/null
+++ b/qapi/ebpf.json
@@ -0,0 +1,55 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# = Machines
+##
+
+{ 'include': 'common.json' }
+
+##
+# @EbpfObject:
+#
+# Structure that holds eBPF ELF object encoded in base64.
+#
+# Since: 8.1
+#
+##
+{ 'struct': 'EbpfObject',
+  'data': {'object': 'str'} }
+
+##
+# @EbpfProgramID:
+#
+# An enumeration of the eBPF programs. Currently, only RSS is presented.
+# RSS - Receive side scaling, technology that allows steering traffic
+# between queues by calculation hash. Users may set up indirection table
+# and hash/packet types configurations. Used with virtio-net.
+#
+# Since: 8.1
+##
+{ 'enum': 'EbpfProgramID',
+  'data': [ { 'name': 'rss', 'if': 'CONFIG_EBPF' } ] }
+
+##
+# @request-ebpf:
+#
+# Returns eBPF object that can be loaded with libbpf.
+# Management applications (g.e. libvirt) may load it and pass file
+# descriptors to QEMU. Which allows running QEMU without BPF capabilities.
+# It's crucial that eBPF program/map is compatible with QEMU, so it's
+# provided through QMP.
+#
+# Returns: RSS eBPF object encoded in base64.
+#
+# Since: 8.1
+#
+##
+{ 'command': 'request-ebpf',
+  'data': { 'id': 'EbpfProgramID' },
+  'returns': 'EbpfObject',
+  'if': 'CONFIG_EBPF' }
+
diff --git a/qapi/meson.build b/qapi/meson.build
index 9fd480c4d81..12a1cb1f9c2 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -52,6 +52,7 @@ qapi_all_modules = [
   'transaction',
   'virtio',
   'yank',
+  'ebpf',
 ]
 if have_system
   qapi_all_modules += [
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 6594afba312..169cfe8d386 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -79,3 +79,4 @@
 { 'include': 'virtio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'ebpf.json' }
-- 
2.39.1


