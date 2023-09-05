Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA6792281
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:21:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdV3g-00039u-3y; Tue, 05 Sep 2023 08:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV3N-00038r-Oy
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:21:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV3H-0000kO-W4
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:21:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so22780075e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693916462; x=1694521262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vo1aRaoDGIJk9TkLkiwceh/LZhlV95aaWzCdG9GKBDU=;
 b=prPNVML8jCTNKaua6pm5AYWljWQC+g3Pdt86IC01dGfepHv9SjxJWxR1DGrIlt4DCG
 5R8Ds3OV+gfh4VTdEr5RHHBy5VP8zfJkle551BLWSVhw7MnxAw+z2pIiKqf9iUJBTF7j
 WcOmQgVq6ft8Y0qtHV1X+oL288TgeWdZ3DSQEU4hM3+J5meff9Gizs+9Bt98OXfhsmER
 /HGKdwjneyHSGmQXWFxsAh5OF/2GzOtFnbk0nqPHpVeoaibEG0gtsLurhF2NVnXzQafr
 qR1SYgkjTwFzaSK+peVYFJe3KwlbUtbv9dMhdULgIA5xk14CpqJEk8YqqFdUM11e70Rq
 XCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693916462; x=1694521262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vo1aRaoDGIJk9TkLkiwceh/LZhlV95aaWzCdG9GKBDU=;
 b=KwgeQtlUlt7Y60otKMO5P4vLb86vf2Fko/BB/iNaIuFs2liae1nW7e5AdwIE1TxWJx
 XgBybuv0f7HB/++on0hxgjv0ACAMwHeRnoOzh60mJ4MBPbPq8dug6oYWjWOb6/OSzdf9
 kAvNPbHClrJFLhANYW318AqiK6in85w0Z2qKzyzymVwjFIhe1NQBd8t9oWrhkDbvr6CZ
 8ZP4LyDI88Db8hKfzkA7LKI7Ou4gWD/lCSNpl+gfhjTGCOdQ8oHlSg8DkDeONEC4phBj
 S8VNDgKbCTWQOtJfA44kRAmY+3tC7bIWsBkdCJszbOb8nPfxIvLxwJd8niOgHPtkGa3e
 5/mw==
X-Gm-Message-State: AOJu0Yxbsfq/rj92rl0mgZssFdlYWUzx1kph9j3i1q+Gw7Lvpw9TdXio
 t19wBwkfYhjUAIBpMeU/yczvcl3+ZUq/5xMVcqk=
X-Google-Smtp-Source: AGHT+IGj+FWbnOLg0Wi9eXeWmYpkHUZdidVng2m9pM2hnF3MRQ/aMSTXN0nrcceqHNV4hMS2iFeAfg==
X-Received: by 2002:a5d:4843:0:b0:317:3c89:7f03 with SMTP id
 n3-20020a5d4843000000b003173c897f03mr9032646wrs.5.1693916462037; 
 Tue, 05 Sep 2023 05:21:02 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 c4-20020adfe704000000b0031c5e9c2ed7sm17364203wrm.92.2023.09.05.05.21.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:21:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/3] sysemu/accel: Simplify sysemu/xen.h
Date: Tue,  5 Sep 2023 14:20:56 +0200
Message-ID: <20230905122100.5787-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


