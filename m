Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D27DB7CE94C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDQk-0000U8-Ts; Wed, 18 Oct 2023 16:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtDQi-0000Ti-HY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:46:12 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtDQg-0002Wh-OR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:46:12 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso4857115b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697661968; x=1698266768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3nPn/hdeMlfSVuN9wtUKnE70a3UoWgeaeda+RCRXZH4=;
 b=cjPtNlZDa2hp6KNwNKaOn0bIEhUJ4X3IZ6duXgDsOijqsnRoLBGt8iTxTfve8x4kpN
 JGQcxoWeTr/Y7Xw0cEAebmHHol1CGxOHMi9IimibPAfh1k5iIYqWdrMriHnNRnAE5Maq
 3t+ePi2I0/cgD1xzMQ1B+vjO3K+JGyyehEosgMhzX91IgH8tdJW7WB7hM50Yahv8AdPk
 wGvUdYgbh0XlmdIjZNiphiaWFV6qMoycgk2MKHJ+4lVk6UHkWRsfkz0ASz3UAB8f3MBD
 wQrY1eM8TqIV/ZN9XLZGvX+k38ivJEMrvqUGfea/ZLtSzLikuvfFiZkphz+gDaIgWKwe
 PpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697661968; x=1698266768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3nPn/hdeMlfSVuN9wtUKnE70a3UoWgeaeda+RCRXZH4=;
 b=lZR1r+clCFn4WWksUnCr+UHBfITeAWIT5pm9CdxHs43pnlMNokyTt0tYDrxQNz08i1
 rxEl+l/H0idbTdzKEov59cgEmASg2sCHJyOkvvJZW4iD+cW1AXdf07qwugfTsYHUOZxy
 rYuZ3iBTNOe0b8F3v4jmEH2vWSnHMkKzF/2Z/UZwUaMVDPz/sR/NEbAHqGeZkKVWI2X4
 nJwRaLhGTh3CDU/CN+cd+Vx33m+h8mjOdIpOAXPvdFMkn9aojYhnHuDvdVBdapkPiJhW
 DfhKeot2YvLbS89bbgKxMrqqW8z93HAF5Wv3PsB6mf8CbbzGDzRfY2izHCFN8xhWQJIN
 kZqw==
X-Gm-Message-State: AOJu0Yy2sN+SUgP/aXvTyaC2znkwa47g16m4wsI6Bi5uMMHRCk39uBSf
 Z7VfcqtMnOulcnsmigQxcLQlXSwt34WdZFq0Qic=
X-Google-Smtp-Source: AGHT+IEgpJHTkma6T3KtyiSBRn+Q4CCGJVJlI7W9Abwoxsp4PQutMSXvxjJ41vtdbNIuqqBLF+ZvcQ==
X-Received: by 2002:a05:6a20:9152:b0:173:f8c9:a776 with SMTP id
 x18-20020a056a20915200b00173f8c9a776mr292605pzc.26.1697661968265; 
 Wed, 18 Oct 2023 13:46:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k125-20020a632483000000b005742092c211sm2103096pgk.64.2023.10.18.13.46.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 13:46:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tcg: Improve expansion of deposit with constants
Date: Wed, 18 Oct 2023 13:46:04 -0700
Message-Id: <20231018204606.1545518-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The introduction of tcg_gen_deposit_z_* pre-dates the introduction
of tcg_constant_*.  These days, a reasonably up-to-date translator
should not need to manually choose between the two deposit functions,
but instead rely on any zero register to supply tcg_constant*(0)
as a source operand.

In addition, the hppa front end has some special cases for insertion
of a constant (depiw instruction), as opposed to the current insertion
into a constant.


r~


Richard Henderson (2):
  tcg: Improve expansion of deposit of constant
  tcg: Improve expansion of deposit into a constant

 tcg/tcg-op.c | 323 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 202 insertions(+), 121 deletions(-)

-- 
2.34.1


