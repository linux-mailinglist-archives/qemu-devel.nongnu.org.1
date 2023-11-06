Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEF7E2C86
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:59:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04o8-0002wM-L9; Mon, 06 Nov 2023 13:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04o7-0002vR-2w
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:43 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nw-0002Q0-Uq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so36096885e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297111; x=1699901911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NC0qFh5CwQ8fmbB+yUbn7BEtT8InvNkyBwuc9hPWAc=;
 b=Ic53S2UA2lVSgT0S/EBu0PMjuBFWfeGGZpCKWoH4snQ8LVpUzxKJ5fmu0bVcjlm+iu
 JkbuwXLoUXaboOCiHjkP8dND4vGQvlQGuMxc6PwLFsD62iT3CCZm6iazl5h8CMGN6NRQ
 ci/i16AJ0h8DN/33E2CXGBGN8q2YJ1pe5gyHO4WMHavlLpfMWDTLxmaOMK/CNOfBCBaA
 Uh5avbSSlV9vyUp6R93R5MEHmyPhE65XFjyuYUPbRajdjeXV0VRYuWp/og7yDI+1GoFy
 inT8nT16fEfqHDWHeU7LxASgA4ylvifAYTbkv/d1cUEo+MXCRG0lv1h7uZKJUvoGk7kP
 QLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297111; x=1699901911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NC0qFh5CwQ8fmbB+yUbn7BEtT8InvNkyBwuc9hPWAc=;
 b=Dua1BBiVl1FeCPrUCSwJY/7Tqn+cBtqmGQgn7ydfYeVZg5KJseTsqI7Lx2aS9ITQk7
 epQ3ig/NUCIb6HV7ouaHFKVV4vR5uw3sbBKgVJl07SmCo40KUKMUx/QmRC/iaaLiNnbr
 ZswQ6L+C7wtuva2MRpI7j8yeIQZexRSck2QLYK/K+URh3cYSjrLItm2NIYfJdkh1KRqx
 lMyo4mlwBFnj1Pah+huxWFmYsEVxTmyI6+oIGFTUzf+uGO6hTYTjfXodQ29UeoALs5Dk
 VRA3Lf9ex3/D89JDzmk++OaKMWlLfoNxnXhZfzxu/ISNstm5tGtFXWsoFZ82rwr9Mm6e
 KsaQ==
X-Gm-Message-State: AOJu0Yxzqan9IOMULnlXF+LhHmgNxR8GdqYBiEyzLzSr3mmZNR0gCLcf
 uncdWfoauBGCGqyirkFjFwBfTA==
X-Google-Smtp-Source: AGHT+IHQ8vJL/0GcEdRfC0fcWSYV69yDbbqNJLrZuh1SbIM76rPheW9wrwolcUMSvlj3iddAC/EGTA==
X-Received: by 2002:a5d:5443:0:b0:32d:857c:d546 with SMTP id
 w3-20020a5d5443000000b0032d857cd546mr20701776wrv.64.1699297111632; 
 Mon, 06 Nov 2023 10:58:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z8-20020adfe548000000b003143c9beeaesm327095wrm.44.2023.11.06.10.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D32A76575F;
 Mon,  6 Nov 2023 18:51:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH 15/22] plugins: disable lockstep plugin on windows
Date: Mon,  6 Nov 2023 18:51:05 +0000
Message-Id: <20231106185112.2755262-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Greg Manning <gmanning@rapitasystems.com>

The lockstep plugin uses unix sockets and would require a different
communication mechanism to work on Windows.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231102172053.17692-4-gmanning@rapitasystems.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-29-alex.bennee@linaro.org>
---
 contrib/plugins/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 751fa38619..1783750cf6 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -17,7 +17,13 @@ NAMES += execlog
 NAMES += hotblocks
 NAMES += hotpages
 NAMES += howvec
+
+# The lockstep example communicates using unix sockets,
+# and can't be easily made to work on windows.
+ifneq ($(CONFIG_WIN32),y)
 NAMES += lockstep
+endif
+
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
-- 
2.39.2


