Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C794B734C86
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:42:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9WV-0006cP-5E; Mon, 19 Jun 2023 03:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9WR-0006c6-VE
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9WQ-0004LG-H9
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:41:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f8d258f203so23156275e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687160516; x=1689752516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mSDEO3S7v0gqsjqb34kIccXlrtVfeECb8OYUdCmpYAc=;
 b=C+DZhtCqAjYyInswfiCXO6os7itVoRlQtPHPNTuHUsXeUrecgnnKFuAigEtuUjfY2Y
 Us69L8zlaDifbvn2R6d4twJfx1qD2DuHdvimmlLM+rwfV13IGTIYSk32upQhOL9YUDlX
 TQTVsi0uWfcVhQpKpe7O8vCiKJTXJwCyOv5UfaGONA1kU35uSm0ZKD7tXpRzco9WqWFp
 3voegU1DphnvgQe5ZBKIqhlWeAQWmZFbX7wMEVnOGWkmwmuYKLM5sIRsrc/WblJrh/Hg
 G1RqlDbOVyE6YVTrL/0K+mRyaiWY+wlWLN2cFMkhH+dTE7tfgMWlq/v2dVPHfoY0WJ1i
 f4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687160516; x=1689752516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mSDEO3S7v0gqsjqb34kIccXlrtVfeECb8OYUdCmpYAc=;
 b=cUDvRhv+e5r+rPz4oUo6oSOnn6gqMNmRPMTLkZsdtry9rBQG2DgFC+h5p4FZbaUiF8
 Rj28bBr2h5/meoxbavuQrNDFLeWtIWuPn+EfsYzHwVFi5FBcCgIsRKYESsceaxtgqvyk
 HICSJ8H0+iRP5UMAYjENgaGFvWqorfx/FtKI1zisV6MYPDmMosSdCCfV/CgHkblm9ysy
 4cmVMYLfhJh0g4rOrX9GWPE5AtMVtq2V61TxIyM6yh//hNmNqRmRSKrwqJiS0MM1pIDC
 SxoHgW84wwdseP+kEhRlR5ar62dRgHdDSl5jwWzRpmInSnoBwrFEXoB9UvdFFfHdCdOW
 vVRw==
X-Gm-Message-State: AC+VfDzOb5aX1A8yjAhvq+mesBUx/m3434zki6WpG/DBWmpo1tJa54x/
 z1v2MnZ7HI1dQOEHjUse81ofUHya9GMsbNvmQwmUzQ==
X-Google-Smtp-Source: ACHHUZ7OFFSztmt/Tn6nEm987OMGHO8qAv1Qs+aHhKfRshCWC598pSvmv3evhLzMOz/cnCav+Afhbw==
X-Received: by 2002:a05:600c:203:b0:3f7:f24b:b2ed with SMTP id
 3-20020a05600c020300b003f7f24bb2edmr6235870wmi.19.1687160516336; 
 Mon, 19 Jun 2023 00:41:56 -0700 (PDT)
Received: from localhost.localdomain (194.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.194]) by smtp.gmail.com with ESMTPSA id
 c25-20020a05600c0ad900b003f18b942338sm9853169wmr.3.2023.06.19.00.41.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 00:41:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] exec: Header cleanups around memory.h/address-spaces.h
Date: Mon, 19 Jun 2023 09:41:49 +0200
Message-Id: <20230619074153.44268-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Trivial header cleanups extracted from bigger series.
Sending separately since somehow unrelated to its goal.

Philippe Mathieu-Daudé (4):
  hw/net/i82596: Include missing 'exec/address-spaces.h' header
  hw/dma/etraxfs: Include missing 'exec/memory.h' header
  exec/address-spaces.h: Remove unuseful 'exec/memory.h' include
  sysemu/kvm: Re-include "exec/memattrs.h" header

 include/exec/address-spaces.h | 2 --
 include/sysemu/kvm.h          | 1 +
 hw/dma/etraxfs_dma.c          | 1 +
 hw/net/i82596.c               | 1 +
 4 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.38.1


