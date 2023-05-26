Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF31712B34
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahi-0002za-UM; Fri, 26 May 2023 12:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahc-0002w7-EE
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2aha-0002G5-RI
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3095557dd99so931003f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120045; x=1687712045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NY+/D6uwmW9rrz2yvSXdT57IZ1FuZiPWd8jiwfrxi4Q=;
 b=K1vw9RCgs4z+aELg0bmShVXdsWfCWvjhZyTpKZh7/WXV3MdEXNTTJrMhvvl7Lcqn15
 XwiHd7kk/RQf9p1Ldvjap6eVETNuGBIsPG25KT4aROms8uzlx7w0RfQT8+qyk+jI46C5
 LmJRHgBTE0pD6OVCx1wPm80cD3OB/Eko3HgLtmcmVeSkr4vy8O35fCoDX7vxD4DqF/vV
 4a4nYb5ssMtHYCS74WsSMX4KmAdtbI8CrGTS/27bUPByHam4ROzjRf8T6332H9zOXeLd
 OxSrJm2Sjl7yaUOBXUcSSAZTK8/2rUkHztWVm9eZp0NK7m8OtbxRXGT4Y6zKgTX3ScAb
 NKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120045; x=1687712045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NY+/D6uwmW9rrz2yvSXdT57IZ1FuZiPWd8jiwfrxi4Q=;
 b=Xro9KO0fDnvV1tLLIpG1zWTtjExQJqARYhOH5EzpDnU8HrgtwYYrIKc4Aqr9uJaPwN
 qz3tOb4ym7I4fo/TIvvHA3NA12P5Ykney0kQSHuw3hiSAxxZdwwSv1gdz9AeD4YveMxd
 52qYyRytW0/G9BiZpUDbheaQ0CW6/WhlFls+wKvq1evEL8bJEjt7GVMom5cCNxMNJKSW
 LE+jafj/UYwgZYCkwTbGGZWEsKwrUkbBMNMSG35kwfHh9m4pDIzZ8uawLoU/F28/HEpe
 z3cW8c5PA5ykU+zaWpW2GlMPw4uS//Hk6P4S3Gr8e2oRrBMhdmixlJlPiUjEL/hYseWw
 onFw==
X-Gm-Message-State: AC+VfDy8SO9ETl7Il1jOLf3R5cS3C+yBAQNs+y1k0Pj8FgdYI7Vul/86
 B9R8PWL3B/PW1y0hoNo59Bcgyg==
X-Google-Smtp-Source: ACHHUZ6A6z62k1x8OgUEAReHH4Czd6iAthNlBji8V+Gk/77DZ8Nj4X0vkznGFVEUZX+yhcNja628aA==
X-Received: by 2002:adf:e644:0:b0:309:3a83:cf43 with SMTP id
 b4-20020adfe644000000b003093a83cf43mr1898839wrn.27.1685120045507; 
 Fri, 26 May 2023 09:54:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a5d69d1000000b00304adbeeabbsm5692586wrw.99.2023.05.26.09.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 852B41FFBE;
 Fri, 26 May 2023 17:54:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 05/11] docs/deprecated: move QMP events bellow QMP command
 section
Date: Fri, 26 May 2023 17:53:55 +0100
Message-Id: <20230526165401.574474-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Also rename the section to make the fact this is part of the
management protocol even clearer.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/deprecated.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e934e0a13a..7c45a64363 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -218,6 +218,15 @@ instruction per translated block" mode (which can be set on the
 command line or via the HMP, but not via QMP). The information remains
 available via the HMP 'info jit' command.
 
+QEMU Machine Protocol (QMP) events
+----------------------------------
+
+``MEM_UNPLUG_ERROR`` (since 6.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use the more generic event ``DEVICE_UNPLUG_GUEST_ERROR`` instead.
+
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
@@ -251,15 +260,6 @@ it. Since all recent x86 hardware from the past >10 years is capable of the
 64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
 
 
-QEMU API (QAPI) events
-----------------------
-
-``MEM_UNPLUG_ERROR`` (since 6.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Use the more generic event ``DEVICE_UNPLUG_GUEST_ERROR`` instead.
-
-
 System emulator machines
 ------------------------
 
-- 
2.39.2


