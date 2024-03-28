Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CC0874E97
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Mar 2024 13:07:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCVs-0004Ki-N3; Thu, 07 Mar 2024 07:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVm-0004Ja-48
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:10 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVj-0005ZS-9Y
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:09 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709813143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh8LY9SFh1cJe50bavbUhMkEhXra+MC2tsZynx59ktA=;
 b=b8Wi3Oxhh0f34+rdmMReU2aBRwfY1VCZPryKd4U5lcwmkimn6+1OsEm7QfOocI2akalOx6
 ty7R3OF8oE1HBdNusrDOZQkPauJ52Biu4/B2sIrlEUzbiN6cOgnG2rbcTVoh8Cwjo10B6e
 fY7WjOwxWgCBA/ZmtrxSOR9HkbC/7MVfah0/8aDdN/1He3LS1V2MqIZwedzMP42x90TxF4
 e+bvrYz+ugp9/L1UJNjcXSuD3pvImJqRstXzEe4/G2atP4axz8R4ddxmrFTmr10X9jvxfe
 XGMOL5BSlLrg3HDTOTzjPw6uVD3sVH23or0YRjX313PmKvLneOkjYeFtbJoeqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709813143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh8LY9SFh1cJe50bavbUhMkEhXra+MC2tsZynx59ktA=;
 b=GjyJPy3Uo7ZB4ZhjFKgKnfAKYyUESxbsYLYyhxHSnEAbVye0kxlp/fODRdi7NFSgL/EYMo
 qeQ6dAbQAEOm6hDQ==
Date: Thu, 07 Mar 2024 13:05:38 +0100
Subject: [PATCH v2 5/5] docs: add test for firmware.json QAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-qapi-firmware-json-v2-5-3b29eabb9b9a@linutronix.de>
References: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
In-Reply-To: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709813140; l=892;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZTPnmxO3GaQAbwRnHrwYEOYFCggyLqxrMW5WVuKlvxY=;
 b=BUx+0FNhYCGRpkmfHyuCi+aUVziyYHtR5ZGec117+23Y6HdCARemjTyjUvJ3+S/FoUq47sUMO
 vSDWPDvpdSVD1KdFfxDh1TyPw2EnY1CNpu7vPWSe5wdAkmVYXr7P7He
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To make sure that the QAPI description stays valid add a testcase.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index 9040f860ae1a..bcca45a342a3 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -99,3 +99,8 @@ if build_docs
   alias_target('html', sphinxdocs)
   alias_target('man', sphinxmans)
 endif
+
+test('QAPI firmware.json regression tests', python,
+     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qapi',
+            meson.current_source_dir() / 'interop/firmware.json'],
+     env: test_env, suite: ['qapi-schema', 'qapi-interop'])

-- 
2.44.0


