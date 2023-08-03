Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C832776DCB2
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 02:31:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRMDi-0003fO-Ax; Wed, 02 Aug 2023 20:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1qRMDg-0003fB-J1
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 20:29:36 -0400
Received: from [2a00:dcc0:1ea5:31f2::1] (helo=bonnix2.bonnix.it)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1qRMDe-0007kT-P4
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 20:29:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 54A49B4271
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1691022569;
 bh=k91W+JMiRmGj1ILMJxLQlNKZz4Cu0SPdO5Nhs4wneTU=;
 h=Date:To:Cc:From:Subject;
 b=LJ9GQ5/h+smxusiCS9oHCVLTLhfHWSIKYPPSiC9Ttnmz3WOKvZ+orEKWJAVV6QGGq
 zn9hqkJR54cHjn0c6HpdIX2fv+yej6FXwtkbYYOZURJkSKZ095TTzgtqg6P7tMjA9O
 10wXN9MiKW4A7EfHCE3tCBgdOF0mD/wC6XinAdiM=
Received: from [10.0.0.70] (unknown [82.84.120.101])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 54A49B4271;
 Thu,  3 Aug 2023 02:29:29 +0200 (CEST)
Message-ID: <8cca5c06-4df8-b7d4-4aee-f52f956437f8@bonslack.org>
Date: Thu, 3 Aug 2023 02:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: it, en-US
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
From: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH] Fixed incorrect LLONG alignment for openrisc and cris
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:dcc0:1ea5:31f2::1
 (failed)
Received-SPF: pass client-ip=2a00:dcc0:1ea5:31f2::1;
 envelope-from=qemu@bonslack.org; helo=bonnix2.bonnix.it
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Luca Bonissi <qemu@bonslack.org>
Date: Thu, 3 Aug 2023 02:15:57 +0200
Subject: [PATCH] Fixed incorrect LLONG alignment for openrisc and cris

OpenRISC (or1k) has long long alignment to 4 bytes, but currently not
defined in abitypes.h. This lead to incorrect packing of /epoll_event/
structure and eventually infinite loop while waiting for file
descriptor[s] event[s].

Fixed also CRIS alignments (1 byte for all types).

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
---
  include/exec/user/abitypes.h | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 6191ce9f74..6178453d94 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -15,8 +15,16 @@
  #define ABI_LLONG_ALIGNMENT 2
  #endif

+#ifdef TARGET_CRIS
+#define ABI_SHORT_ALIGNMENT 1
+#define ABI_INT_ALIGNMENT 1
+#define ABI_LONG_ALIGNMENT 1
+#define ABI_LLONG_ALIGNMENT 1
+#endif
+
  #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
      || defined(TARGET_SH4) \
+    || defined(TARGET_OPENRISC) \
      || defined(TARGET_MICROBLAZE) \
      || defined(TARGET_NIOS2)
  #define ABI_LLONG_ALIGNMENT 4
-- 
2.35.8


