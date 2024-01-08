Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271908272B9
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:15:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKK-0004Fq-JC; Mon, 08 Jan 2024 10:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKH-0004Ej-NF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKE-0001ak-NV
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:05 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso25384865e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726840; x=1705331640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwDKE536xixs1EyATvmJWMG8HzyVCBtTOCg149auIRI=;
 b=QiufuyNwMTV1H55JtJ8X1Yzx5GMAFhD5rqZStaV/emhkLY4aDfKvUeAucwn9feANOr
 D1se0IKVOmkvgQhcNl2Ui4zym0Ibszja10d+t7aDLm5K6vMaHCuUuOd5jX4+w1W1aOR8
 NfDXjErm8xkLugGk0QcJbELLxts9VHq9rSH3FkkelSUNXrgPagHURs92/vsWHbghAYSz
 z7yR6xdGrb0LuR8nHIA5Dmx6j4IdDpJ9Dh7yjQpi2kDnEL0NrF2JBN66uGWyz3fSy7Mr
 6fPm2qxVISU7FeRPHIC80mGo/q6kydy9Yp8E9E9C3PHOSguDgc4Ok4/EhMFTn2GRhlNw
 q5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726840; x=1705331640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwDKE536xixs1EyATvmJWMG8HzyVCBtTOCg149auIRI=;
 b=U98agXRzPWyVOCO9WHOEHx+d+TU4iXH9jHrVplQTdsvGVHH8ZCAmQlZKlTe9V5PRXu
 krHaLjt8/c44KQ99jUn8DvOnxGWHa4CtsPqAkseSfy+c4mZrwxqE7J3DVu5sfi1Het5/
 7uY9XT6q4KS/p+4XmvcE1kfJr6RHpSplKCbV6nlk/M5rFGSaTaFVmAE9+W4lERMXJHP+
 6MZC92ggy6AK4yQyrQGWeOKsqF6p9P+Rc+XtDsXzZD+OF5HC//W7prx4nFuUp/Nxk6FJ
 It4Znh145wTr8ro+TmqEWcKLNkDqyhzW1LjS7A0WKConE9Lr+PGpbMq1X2CJfDmEWaEZ
 CKHA==
X-Gm-Message-State: AOJu0YxfJG9pZhLgeMsI32emgV/7IFDlT59fXKkHXmKbWyJ96WAiglG8
 hEdScDYZc8i6Lujl/wIH9BuPeGiaQ0I6RQ==
X-Google-Smtp-Source: AGHT+IGTvAXTigvu/pbvaiL1Ixqk0Azg66OrpQtZHxT9aHQxn3Tar5i6fMauVyiCOR9o6gPH+Pez8w==
X-Received: by 2002:a05:600c:4e0e:b0:40e:4b1c:13db with SMTP id
 b14-20020a05600c4e0e00b0040e4b1c13dbmr134175wmq.18.1704726840013; 
 Mon, 08 Jan 2024 07:14:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j1-20020adfe501000000b0033686e8f02dsm8038809wrm.45.2024.01.08.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 50F065F946;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 05/13] scripts/replay_dump: track total number of instructions
Date: Mon,  8 Jan 2024 15:13:44 +0000
Message-Id: <20240108151352.2199097-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-6-alex.bennee@linaro.org>

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 6f300e4c54e..d668193e793 100755
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


