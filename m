Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4547EA2B2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:19:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bVu-00085j-Uj; Mon, 13 Nov 2023 13:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVr-00080n-Gf
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:19 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVp-0000ZY-AR
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:19 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507cee17b00so6297718e87.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899495; x=1700504295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf1rwmHWhRIdzPASs5If2b7PrmSQYo/bsdIg+fGMWc0=;
 b=AWRfajKqBZeatVfMxmCpqy2Ie1q9evejcNFi727rFYllNB7oOrg4jTUV19KocudYlF
 ei09wXMdbcWKHYK/sWqqjLh7Yo/lk2k7Tp0QL79KyaeLjROxCjA++BvunMPRyZMsUJGs
 w0nDy7+HiGIQFd1js+ulVhMa35LfgvElo+6vvIHK163H8TwHN/0kJSs+k/k1BCZ2k3xK
 tYILwhr2sv5TrVd5zegP0ifunqgWgRwTnExeHrgxErDxE+PpeYtJKTW+hXFu3J4FLsdj
 woTrFuHZMh/OCDVnYMQRxWBrkxvz5rxvmOA+XMT/TLPeXluufbIlDJvabQZOVvR2hjpO
 Cxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899495; x=1700504295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lf1rwmHWhRIdzPASs5If2b7PrmSQYo/bsdIg+fGMWc0=;
 b=v4JnWdU5WIzKfkR8kb9AX9A02XQd8oBCXnuNgmPS/RVchwhbEMEVECJsfOdwwcXfnc
 RNUzmU1MPoI2JsizOCD2L903YgKhP6MNju6BglrfhUFmb8YOxW5MUrMSQqk2kHagzMpS
 3KRjIp55q8GF5LzvjhN3Z2p+QhkDJV0ugE66OEdDitHPZn7952h/r89qviCtqAHOrT1y
 1Fgi/h6JU2tXTj5xAvcJxByE+LZGSTcz6sCI+lfagy8zlw8mXsz0DaBZkxnxCRdPWGHp
 R3SPSi5hqvNKpeJEOyJAKHmkpd+Ytu/KYSIiwK2t1CRYET9Bo0eL19xFX87VeeO8vtFz
 2Qhw==
X-Gm-Message-State: AOJu0YzyVUDGFTjSYeLyXKJ5RZPtIw87Ol2CB9fD+ATixRe9h+Rtvash
 Mct0W9BpYnqCuz1JfNZpUdf1bb12UhwlgKIqSO4=
X-Google-Smtp-Source: AGHT+IETinKtkFCrBIqvOUyeQgI0sY/iJzZp3ZNQGaS6rXBjgAarOzkPkME4UZtkqjbga5AGu5z07g==
X-Received: by 2002:a05:6512:3ca5:b0:509:30d4:ea92 with SMTP id
 h37-20020a0565123ca500b0050930d4ea92mr6304407lfv.52.1699899495310; 
 Mon, 13 Nov 2023 10:18:15 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a17090634cc00b009e6165226absm4375853ejb.108.2023.11.13.10.18.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 10:18:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 5/5] MAINTAINERS: update virtio-fs mailing list address
Date: Mon, 13 Nov 2023 19:17:44 +0100
Message-ID: <20231113181744.49537-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113181744.49537-1-philmd@linaro.org>
References: <20231113181744.49537-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The old virtio-fs mailing list address is no longer in use. Switch to
the new mailing list address.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: German Maglione <gmaglione@redhat.com>
Message-ID: <20231111004920.148348-1-stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73a3ff544..c52df9f76c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2241,7 +2241,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Supported
 F: hw/virtio/vhost-user-fs*
 F: include/hw/virtio/vhost-user-fs.h
-L: virtio-fs@redhat.com
+L: virtio-fs@lists.linux.dev
 
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
-- 
2.41.0


