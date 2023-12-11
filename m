Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F5080C426
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:15:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMO-0001PO-EZ; Mon, 11 Dec 2023 04:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMN-0001PD-Bt
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcML-0004LG-Pn
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so18124295e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286032; x=1702890832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SlvRTKcz2q66zKaZfqY8RiFDl94/8+g2tpwbIBdd48=;
 b=HPAC0cu2q9h0FMmvkf4rkNTUAFwymWZYKXHQcOwUdNXzPeJXP4ytJ/kYYE4a8nmaI4
 C8gZDQ5Grutdlf8Vo9cTTJqlGK9NuAvWYA8lDYCsOM1IoAZ9Ix4YwFic7Paez7LJjTLq
 x3Co7YSwXprnJyGknYYKhfbaVL329lOExWOBaI3toPLTEeLxCNhLaXGqf8POSx4k0SM/
 Nt2dQBLszVcrr6PbDIhfEPYBYb730n/nC6c2LA91OQCdDGWxtHhlxQBvQmCQ+QLBH9MG
 nlgcgEW3LhAHhITnfLN+MsDiqsUM2k8OTv5rbhrHKkT8A7VCeAwinJ9juFDlInboiwjV
 knbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286032; x=1702890832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SlvRTKcz2q66zKaZfqY8RiFDl94/8+g2tpwbIBdd48=;
 b=OXldov/kceWd2eKn5Whl+fiUlqJ/XrF7Sj3VmoKEcPfCRvVhjtWz82zsyCb6rBuB/W
 bjLj2AwuiqHv3O/8GD3o5SLQh7ZZDNYDGYfyN5SDBFfV1vAzDRZDvFuKIw4En7GldVeX
 EFxM+rnwnaPLE1HXaKca+VtkAahwDqJlXcyNaqYEgHd/mrhQWPnmEqPpd+oX+AvylO20
 r+15d2Ip0QK8fQyXkFzKUsdBjeMPt/FLRFCTqSQwhidLArWwmrJQFDRSzK5ZTamsBJEZ
 7GbpatRs57BrMLnfbsjqz2ewtzoJIsnQrajqAcXgNozS6l7cNgVNihDS/QIKeX+eBCYN
 2Afw==
X-Gm-Message-State: AOJu0YxSGb0RRQYA6Mg7GNlwhqlZbHLY/bM04egBV2IZ0by4zEpOz8Bt
 NyQ3SvaqbGrz10SEdJFv3FYlXA==
X-Google-Smtp-Source: AGHT+IHtGxkIvxMhTuOEj749kM3DxoJiTdyQ6gynXu6N37VoILEElghHDhIK/VjXx5qcdjhbOX2J7Q==
X-Received: by 2002:a7b:ce98:0:b0:40c:271a:e7f4 with SMTP id
 q24-20020a7bce98000000b0040c271ae7f4mr2072440wmj.140.1702286032481; 
 Mon, 11 Dec 2023 01:13:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x15-20020a5d54cf000000b0033339da02f9sm8062721wrv.110.2023.12.11.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81A3A5FBE3;
 Mon, 11 Dec 2023 09:13:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 05/16] scripts/replay_dump: track total number of
 instructions
Date: Mon, 11 Dec 2023 09:13:34 +0000
Message-Id: <20231211091346.14616-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This will help in tracking where we are in the stream when debugging.

Message-Id: <20231205204106.95531-5-alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/replay-dump.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 6f300e4c54..d668193e79 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -157,10 +157,13 @@ def decode_async(eid, name, dumpfile):
 
     return call_decode(async_decode_table, async_event_kind, dumpfile)
 
+total_insns = 0
 
 def decode_instruction(eid, name, dumpfile):
+    global total_insns
     ins_diff = read_dword(dumpfile)
-    print_event(eid, name, "0x%x" % (ins_diff))
+    total_insns += ins_diff
+    print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
     return True
 
 def decode_char_write(eid, name, dumpfile):
-- 
2.39.2


