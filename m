Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA447A0E90
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsOG-0005aj-7x; Thu, 14 Sep 2023 15:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOE-0005aJ-Kh
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:38 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOD-0006jx-5g
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:38 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so233058066b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694721153; x=1695325953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pH/Gd9c3Al2hm3nRlXGcuzsIQc0Vb10/gJIBjNiHVrw=;
 b=BRYLum1RhgUbJ5zzLolUSlihnwZJIDt08z/PTYm2mxHPbMQBA5cmGYjZDr/Ad/DT0J
 JOMT/7IjmEIg2WpVPquKz+pLVTdEyNiGYfuA5V38yZq/m1a6uvdAO6lFfg3/VqYm094o
 qCmesYgdQlVlTDNmQPACquFLA2sWMPnDRz4XL4mFFfxI+tiD++RxA+XkTZcvoQOifxLe
 o8o+TQV6HFKMn42+jcUe3hcSO5w2eZXiBpZr2mX3wkidt6843zvVqE7UAT29E84LieAY
 4G8Vx24qn5e7KwUB7C44q8iOJlZlxrOhHNIu5jvy5DnEFIVZKja/luAxczgDebsfTuHH
 LhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721153; x=1695325953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pH/Gd9c3Al2hm3nRlXGcuzsIQc0Vb10/gJIBjNiHVrw=;
 b=K6ufuV5TQCSIfsgWLD4nLeIJMJMPQqSgBS3qjdwg0kjG8GH4a/ihdz/hJSaQlu+dDG
 j/mE7ZODG6vKD2fFe+yAz6egjsT8mGyjskor6V2jHOL/7jLc3vMRJLhu3ww/p0IaUFH+
 cY594FYtll9k74NDCT/fc+TU8ld3fFdwqvn+UogKGjeCWjCh/5RnvwW+QhbtjmONBTOf
 3GNnhpk9DgSDKiDe/R6XXtdkfL7ds4Wnseve1u3dUJT49UqtHKupn3E8PQ0kB6mkb18L
 xEwTn5OPEoOXK1nzv2uJgFyGZF7DKoDDHi5r5uxkJdDeugP3/FRu2far4FYvG/jt4X8c
 21RQ==
X-Gm-Message-State: AOJu0YyiJ3oWeKnzvTpWU15L4auDNNZenSJZMDuZ2TJZG+AdJIJ4xTqj
 ggxQsdp4t+fnBddFyylQJyWYEy922yai6t2VYSc=
X-Google-Smtp-Source: AGHT+IFMIkpAAfmS2OsHx2VNNlTohRKTz3utvIfbWkLfwXqhdEngpTdAsu4ZYyqA42tlNo4VNguf+Q==
X-Received: by 2002:a17:906:6a19:b0:9a5:83f0:9bc5 with SMTP id
 qw25-20020a1709066a1900b009a583f09bc5mr3773895ejc.18.1694721153357; 
 Thu, 14 Sep 2023 12:52:33 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a170906298800b0099bcb44493fsm1441278eje.147.2023.09.14.12.52.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 12:52:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 0/4] accel/tcg: Stubs cleanups
Date: Thu, 14 Sep 2023 21:52:25 +0200
Message-ID: <20230914195229.78244-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Remove unused stubs,
- Guard with tcg_enabled() and remove more,
- Reduce tlb_set_dirty() scope?

Philippe Mathieu-Daudé (4):
  accel/tcg: Remove tlb_set_dirty() stub
  accel/tcg: Remove unused tcg_flush_jmp_cache() stub
  accel/tcg: Guard tb_flush() with tcg_enabled() and remove the stub
  accel/tcg: Keep tlb_set_dirty() internal

 include/exec/exec-all.h |  1 -
 accel/stubs/tcg-stub.c  | 12 ------------
 accel/tcg/cputlb.c      |  2 +-
 cpu.c                   | 15 +++++++++------
 gdbstub/softmmu.c       |  5 ++++-
 hw/ppc/spapr_hcall.c    |  2 +-
 6 files changed, 15 insertions(+), 22 deletions(-)

-- 
2.41.0


