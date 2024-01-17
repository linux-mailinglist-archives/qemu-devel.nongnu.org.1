Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD2830661
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:59:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5UT-0001k8-Gn; Wed, 17 Jan 2024 07:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ531-0006rL-Rg
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:29:35 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ530-00088o-DZ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:29:35 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3608e206f27so59781665ab.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494573; x=1706099373; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1Ds/TZ1aZRwIr5/pt9S9g91j5GUWkpWfIpKMwQIsS9Q=;
 b=d0eO2doztBho1Ah0gVkS8b4ML01SkKJEw7nhQbYPzdVCGficVQiL92Uu59t1Z8Ia+K
 sDGI7rNo/ptvJXpIsbgqAMDmQS22qmPp6cXlucNYtHBFQSCnQ3q779PYxPfpkoEWvD/g
 VkIHHCMRyUjKAAHBM3npOeG4C0ucSTdAA6QYjmw4Ti/Y/nhz+6q0EppD3+iXOEBs96PZ
 RISxKhmH6VDfW9UrEgEmLl8RdG8c4YFuwXItvZvaptve5yPpilZwHCV/doNTnyiaQmb1
 1EwdVrUumfdtBRoiz/FwTpRUzOWu9J7vKEzNEJhW4+hwPptIsncnEXFpMOw/kRyJe53N
 KVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494573; x=1706099373;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Ds/TZ1aZRwIr5/pt9S9g91j5GUWkpWfIpKMwQIsS9Q=;
 b=B8gTKa0Qko50t7zMWrxZ1ANIa6LDEjeIsBaOXN4qSpShcq636ItVAj5KBUdo4GcaH6
 8OLF7CVF9dbOpouUovxa7it56AfqHLlKiWjtGHCWqANa4omXHorA/Ar4N+mgZOUm7Dsd
 l+001qtPKaJQzwoe7HRKc2k1eVKagIhMlXWFuuoL06LG77+rPSvcgdnEQzOHy1TPc8Fw
 G75WdloFr/bap/JrpPalcNI8/INTtloBYW+AHcAjgtByPWzfAQnF4V/KcFd8tkdJSnnx
 MaFlGbBvZIVYtFUPsOLLuvNrBx0JYXAQEYLahXX3oNH2MddXagFVCIB+jSWJrY2rIaIQ
 ANwg==
X-Gm-Message-State: AOJu0YxptT85tVAmMpM8HSQsxrQRlOfAL4sMnn2OJjE5E3plwC4+QFuh
 lxNeAxtq2kIY7OoOrASNgm9bS/GNIkgd73mvcC3IGgN3BZA=
X-Google-Smtp-Source: AGHT+IFHkdBe+dMQN8/E5N+taEOYN5933BoSxGK1uizkmdiySwiqgYGLwsPCSitKXna6JHjETQTOUvNfp4UniKlsQDg=
X-Received: by 2002:a92:c746:0:b0:361:980a:df32 with SMTP id
 y6-20020a92c746000000b00361980adf32mr520108ilp.78.1705494573117; Wed, 17 Jan
 2024 04:29:33 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 13:29:28 +0100
Message-ID: <CAHP40mmMHhEYWoLvBDNxtFFw8BZg3HGQzYdyAsSitFne+LTRkA@mail.gmail.com>
Subject: [PATCH 1/4] Include new arbitrary limits if not already defined
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jan 2024 07:57:54 -0500
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

qemu uses the PATH_MAX and IOV_MAX constants extensively
in the code. Define these constants to sensible values ourselves
if the system doesn't define them already.

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9a405bed89..9fb6ac5c64 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
 #define TIME_MAX TYPE_MAXIMUM(time_t)
 #endif

+#ifndef PATH_MAX
+#define PATH_MAX 1024
+#endif
+
+#ifndef IOV_MAX
+#define IOV_MAX 1024
+#endif
+
 /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
  * the wrong type. Our replacement isn't usable in preprocessor
  * expressions, but it is sufficient for our needs. */
---
 include/qemu/osdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9a405bed89..9fb6ac5c64 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
 #define TIME_MAX TYPE_MAXIMUM(time_t)
 #endif

+#ifndef PATH_MAX
+#define PATH_MAX 1024
+#endif
+
+#ifndef IOV_MAX
+#define IOV_MAX 1024
+#endif
+
 /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
  * the wrong type. Our replacement isn't usable in preprocessor
  * expressions, but it is sufficient for our needs. */
--
2.43.0

