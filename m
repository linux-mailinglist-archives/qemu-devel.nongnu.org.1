Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6047032D9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyayY-0001J4-4F; Mon, 15 May 2023 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyayK-0001DV-Qo
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:22:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyayH-0005Mr-E2
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:22:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so64331365e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684167768; x=1686759768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guoQvu7q9W2yxt0cEFeDYnD/GAjXS0PXF9GI5TpOJx4=;
 b=xwMyOBKuCs5Web5eoA6nCFlKh4k6xnODg0C3EFRdb6ZkCPKlW/u4NigSozTWEdjv+p
 7Wt61zYRoyj0w9/1H0U+L2d4+L6zuYn9D6LGCmWvPVcdk0dbe50kmaPF1g/lFNt+NBNs
 zMvK7TQzt8G69vcqxYxcZHqtS1jfNADeT/YVQWjpbanapAokph52DlBvytmnLG70Q3zf
 1Hy+8CVfOrGfkbpZ4BqIKYrjSlxYFUzQuMSzN9cyAn/R3zxDa1GAsxZ9+iyPBh7Qdnnk
 WhrSBasVObWQBQ2uxLk3UArcySlVFL9waSzancpefryMonQ9JkG3wZ8nkAuX5bj93V70
 OjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684167768; x=1686759768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guoQvu7q9W2yxt0cEFeDYnD/GAjXS0PXF9GI5TpOJx4=;
 b=CSTjGF+mVWmEM2tpz8WekcHxXh5ahd7vdivrsfvNxOBW1creWPk9qPXhwlOkSLQ8ir
 luPjOwhlP5WCQFHnoZ2x07NEJYD7d24C+E4eAAxj/T0x0atwhYmYcDx1ZvgedaXDIfpY
 /P/4SAvX0MKSI1lFndHymTiNkrHLbd0htl8atfiUB4gDACHbFFetqJHeoFJ0xlURz30G
 llMxpLX1+xtvKi2t/73vQZizafL79UroCwlGWQHXOA2Lfj7bBrMwm8DKiwmi8cKuyHAE
 Fuq8SoVl1JPAQv6PPVINAagW9bbT2S1VOBrs7+jOn6BkUVTWXRmoQwNEnz6tF7kYdsKB
 4xdA==
X-Gm-Message-State: AC+VfDwwyR0Ghb9Pd8ew61Awg1L7gCr6W/xEkE2S5USuF8qgAP3qPUcQ
 lUoLrGfAJuZMsG5JlX7IaPvZEdurnkLmXNRfsw0=
X-Google-Smtp-Source: ACHHUZ7LTyF4Gyq8szmT5zGQ/nOHIKZ2653C1xMHew7TkgMkuOv349c6OXNBtA48KtyznvieI6Jldg==
X-Received: by 2002:a5d:69cc:0:b0:306:42bb:53be with SMTP id
 s12-20020a5d69cc000000b0030642bb53bemr24099081wrw.10.1684167767915; 
 Mon, 15 May 2023 09:22:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h12-20020adffd4c000000b003063176ef09sm278203wrs.6.2023.05.15.09.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 09:22:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 2/3] docs/interop/qmp-spec: Update error description for
 parsing errors
Date: Mon, 15 May 2023 17:22:44 +0100
Message-Id: <20230515162245.3964307-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515162245.3964307-1-peter.maydell@linaro.org>
References: <20230515162245.3964307-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The description text for a parsing error has changed since the
spec doc was first written; update the example in the docs.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/interop/qmp-spec.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/qmp-spec.rst b/docs/interop/qmp-spec.rst
index bfad570a160..2609b3ff9b2 100644
--- a/docs/interop/qmp-spec.rst
+++ b/docs/interop/qmp-spec.rst
@@ -307,7 +307,7 @@ This section provides some examples of real QMP usage, in all of them
   .. code-block:: QMP
 
     -> { "execute": }
-    <- { "error": { "class": "GenericError", "desc": "Invalid JSON syntax" } }
+    <- { "error": { "class": "GenericError", "desc": "JSON parse error, expecting value" } }
 
 .. admonition:: Example
 
-- 
2.34.1


