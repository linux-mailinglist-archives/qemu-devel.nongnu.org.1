Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E9792289
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdV4b-0003XG-04; Tue, 05 Sep 2023 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV40-0003Kc-Jp
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:21:50 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV3y-0000n7-G7
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:21:48 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bd0bc8b429so40691671fa.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693916504; x=1694521304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vo1aRaoDGIJk9TkLkiwceh/LZhlV95aaWzCdG9GKBDU=;
 b=oHbVlAYfvg15mzg/brfOPiddiEB8dVQU2AFF4StMLykirdeluSnvpq55jxiDUsP4DN
 DyODNI2rJ+BoEDvETxGj6A7C1Y6wcGwLkFK2D1cGnw69JBk/3gyVkgW/gkTYqBadTfDR
 MOnO0qxIsOSQxBHKe5ZORQL2Le9uTt6K/+qIcYIdXdp5Etj96S/rPmF6E7+Bjk/kwFlQ
 YuxiY/vxF1w137EhOW1DNF/h6VzHcfe1o4Z96NjQf3FCWX20oAcpWoFAgfZ3MlfnKuYF
 vwZHaZaOhlVXr4P+r24vrvQMPvJna6OVdy7Zzc7p+vQaJZQjsrHRjcptfmYp/z/c2GNe
 g0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693916504; x=1694521304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vo1aRaoDGIJk9TkLkiwceh/LZhlV95aaWzCdG9GKBDU=;
 b=a2ObDEprjz7g6Roo3wNA7iRyLnomlbSu3R+/5kC1sh8I+iXu+n3Z5LQfQVAbLhRxZv
 HcPfcwxbehZcjJnCIiDYcRNlGwKJPO8mOe3j+c9hbenP/VW600A/ZKPvZQizeKTL4jq0
 2Zc7H/kWzmsH8+ol4/fgZbkTV8uWV7vYFzvpxnQgsx0totzF99FXI0DsNGUQ7CBqJ5iU
 l+JWNuXG4srza24m9xHDv8Akoqq4vHTf/THsuVOgmawAp540U5zvbU/lxDyrivkK/IM8
 TjjrwCK+ZpqrAKige6H5uGDnnuRFIu79m5A/tN+HWhwoWBm0NH9+5jf6JuX+1iv/hA4L
 bQhA==
X-Gm-Message-State: AOJu0Yz59KAMt1nmrimQXGtRVKxCz1d56T8A8xgsWKRTjje+YECeBGhy
 P86k+ajGX6CpcFz/yeoMCnRFLUvkwPwoekqer68=
X-Google-Smtp-Source: AGHT+IGHceR0DxOo08btZrf4dHcOI+V5se4WRpPBquf7QOLcWBYqYSVeTEjv9tLfnWmKk2ZrPPRgjg==
X-Received: by 2002:a2e:9c06:0:b0:2bc:b8f5:aaf1 with SMTP id
 s6-20020a2e9c06000000b002bcb8f5aaf1mr8949290lji.35.1693916504432; 
 Tue, 05 Sep 2023 05:21:44 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 c20-20020a7bc854000000b003feef5b0bb7sm16637862wml.40.2023.09.05.05.21.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:21:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] sysemu/accel: Simplify sysemu/xen.h
Date: Tue,  5 Sep 2023 14:21:39 +0200
Message-ID: <20230905122142.5939-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Trivial cleanups which simplify "sysemu/xen.h".

Philippe Mathieu-Daudé (3):
  sysemu/xen: Remove unuseful CONFIG_USER_ONLY header guard
  sysemu/xen: Remove unreachable xen_ram_alloc() code
  sysemu/xen: Allow elision of xen_hvm_modified_memory()

 include/exec/ram_addr.h |  8 ++++++--
 include/sysemu/xen.h    | 24 +++---------------------
 2 files changed, 9 insertions(+), 23 deletions(-)

-- 
2.41.0


