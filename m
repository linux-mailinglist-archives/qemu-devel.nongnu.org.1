Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17449780FB5
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1sD-0005J4-D1; Fri, 18 Aug 2023 11:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1sB-0005IY-FU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1s9-0004wY-9x
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe426b86a8so10415405e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692374328; x=1692979128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0dO/wbtq8s027/zPH3VXaim0ZVbTnHkkKvCPXCOUCRw=;
 b=zvWIIwzazgnt78RszVZDw57OKdZ0HJK5FG144KehN6X/GOOvHW/Rq4RyQo0LB2fMNH
 H9swZVXXclB16x2RH2wZhiAGatvWAnQVXXiGwBBJDGcAYH7BzPg7t61eu+AiF36gwXL1
 PSxWvlPy1oIzWuOtCCEkXc8gHNBQGmIlSebCZk6Pp5QTomT5/XPVj/Fe9AJSFU0sQ/8K
 ArxNl8AJArQMyocO3q6DbKaruhuERJq2a6mrqjaYSekctdN8e68oA73xZSnxr7p6c2q0
 eQ3ALPo3NWvc85IykFHw14cc8Jk3riYEtb77ALF1eLRdtrB03HSN0LU+BwZmGROHLtca
 yl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692374328; x=1692979128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dO/wbtq8s027/zPH3VXaim0ZVbTnHkkKvCPXCOUCRw=;
 b=AM+irQFqv/k1e7DKbIn95V+17Yr2A5CwFrj/J5Sy8w9Xnxu7tSagkz2RFdLYyrvnU6
 I/B3fDL9UhEtdPKwkb/heuo8x1KTQhwXaogQcDK43UT+NWPQJdmAYh6PeUn9KVMC1fFp
 Nv4U4K901o9+Ywgefxz/PANWgP33ywK3E6y/mBpL2qUFt03M5zIXajfWub9LR8rUPFZW
 Qpl3h3xXfE60HQRunhsH1g3TzlMHaEm5NNqsxb9TACZxYxmiXifIbJ5JQV7fLLRS8tfn
 ndVMXGRT2WbPfGxnKwLwTb66uldpi5DiNAu9p4hIabN5+XDEksC6Lp/AeJk7EEx34mBa
 W94g==
X-Gm-Message-State: AOJu0Yw3s/ErFMYbE6OoQjtyV0B0WHaOAxRAAd+NF5f2sG0hneuOWQs1
 Uz17wx5tPy6p1x2u45oT6pbfCexBlC2/jlxfSBs=
X-Google-Smtp-Source: AGHT+IHYw0Ktrwi/7K1HLgRcvYtkg25PLmuniFwuusImxGgMsmMrxF68Xc2GmJJ6NqNZWAz/fQ51dA==
X-Received: by 2002:a7b:cc13:0:b0:3fb:ef86:e2e with SMTP id
 f19-20020a7bcc13000000b003fbef860e2emr2441361wmh.19.1692374327679; 
 Fri, 18 Aug 2023 08:58:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a7bcd95000000b003fbb346279dsm3275702wmj.38.2023.08.18.08.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 08:58:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH 0/2] audio/jackaudio: avoid dynamic stack allocations
Date: Fri, 18 Aug 2023 16:58:44 +0100
Message-Id: <20230818155846.1651287-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

This patchset removes two variable length arrays from the jack audio
backend.  The codebase has very few VLAs, and if we can get rid of
them all we can make the compiler error on new additions.  This is a
defensive measure against security bugs where an on-stack dynamic
allocation isn't correctly size-checked (e.g.  CVE-2021-3527).

The first one is fairly straightforward (although the JACK API's
requirement that (a) you don't pass it an overlong client name and
(b) that maximum length is provided by calling a function, not as a
compile time constant makes it a little less clean than it might be.

The second one avoids the dynamic allocation, but if the audio
subsystem has a compile-time upper bound on the number of
channels then we could use a fixed-size stack array rather than
the awkward "allocate a working buffer at init time" that I
have in this patch. Suggestions for improvements welcome.

Disclaimer: tested only with "make check", which doesn't actually
exercise the audio subsystem.

thanks
-- PMM

Peter Maydell (2):
  audio/jackaudio: Avoid dynamic stack allocation in qjack_client_init
  audio/jackaudio: Avoid dynamic stack allocation in qjack_process()

 audio/jackaudio.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.34.1


