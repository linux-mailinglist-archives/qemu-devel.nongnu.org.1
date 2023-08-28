Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C678B7AB
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahP4-0000oh-DJ; Mon, 28 Aug 2023 14:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP2-0000oG-6p
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:56 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP0-0002Pf-1d
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:55 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1cca7cf6e01so2035697fac.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248952; x=1693853752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RbzE1c8YAHBU6zPK+KJzhJdjayhx7gAcrGoNYi4cQSg=;
 b=m/7BuJ4etn3o0rzWsjOC9HxVVV1s4k5iT0FG2wg7l9ASdH0ih4UtvEHO0PyOpUgyv9
 Hi6ENVZJ7Iuq5NzU9/S6t/TeD1kHj+ZxYFppY493q+lw1VFs+Tx5v5Jvc3KrAwI16hQn
 WdF9H7rtyxzHmxwjbSLvfi6J1F1xgXupTmS6gPi/g/bk8pgeXkM+ckNJIS1QcyiJGL2T
 iSZGRxurOGhO0Z1DazuwTa+Q331yoDTUJ5WQVKeISlthMSxodt1wRaS3T8JJrc2Cx4AR
 PjC9I1jmiXHJPD+1QdJ1+R6JJp3f2bWdCW2vB1zGs/EtOrLQUxLfiye+mc9gofYJt7uV
 17Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248952; x=1693853752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbzE1c8YAHBU6zPK+KJzhJdjayhx7gAcrGoNYi4cQSg=;
 b=ft15GLA1sNHIGszBwMi3u1zKt/ZPc4BuQVjmDvHP3AzGrh0KKePTZum4eE+QSDkb2X
 w9j3vWoawMBQBGMeeHvGYYi/+hZTkh1Ph96Dx4YXpaO3+Q2WCF/L7pcg9a6lwu4Wnb+O
 oTvj+BsX11HA54RKXhI1/cEy6dipWkfOSSil1XhJg6i9CoyC19D8+2ti33YWxUfuEIKi
 tf+Qvj0BnmqXwth8fOiyVz1ob0MHrTAtQt5ypv05uv8olfJq7fCD6mlj53v95WgSILd8
 kosQrwOjqpKOfAtyQoamd4CyUTgkZfpApD5aNZCpLSF6B9g0W65m8EFjwHGv1oouT8U8
 yaAg==
X-Gm-Message-State: AOJu0YynGhf/ntO3ZOFgR8CXfuOI3CKRJtyRfuTb890GUlJSmfmDVONY
 7c3zsU5pBDnr4WFpgUyfD/u6jhBeE8w30Nr9Znw=
X-Google-Smtp-Source: AGHT+IEREGjdlHcq7QEshV12GyZVRXY36GSBTww8DLi8a2e5Pg1+MMEdp0m7SR9BozACBlrreVDRFw==
X-Received: by 2002:a05:6870:14d4:b0:1bf:597b:2343 with SMTP id
 l20-20020a05687014d400b001bf597b2343mr11826971oab.30.1693248952037; 
 Mon, 28 Aug 2023 11:55:52 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 00/10] plugin and tcg cleanups to cputlb.c.
Date: Mon, 28 Aug 2023 11:55:40 -0700
Message-Id: <20230828185550.573653-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Based-on: 20230826232415.80233-1-richard.henderson@linaro.org
("[PATCH 0/3] softmmu: Use async_run_on_cpu in tcg_commit")

Remove the SaveIOTLB hackery, now that the flush won't happen
until the TB.  Clean up the locking, so that we don't try to
take the lock twice.  Clean up the iotlb lookup so that we only
perform it once per page, rather than for each aligned piece.


r~


Richard Henderson (10):
  accel/tcg: Simplify tlb_plugin_lookup
  accel/tcg: Split out io_prepare and io_failed
  accel/tcg: Use CPUTLBEntryFull.phys_addr in io_failed
  plugin: Simplify struct qemu_plugin_hwaddr
  accel/tcg: Merge cpu_transaction_failed into io_failed
  accel/tcg: Replace direct use of io_readx/io_writex in do_{ld,st}_1
  accel/tcg: Merge io_readx into do_ld_mmio_beN
  accel/tcg: Merge io_writex into do_st_mmio_leN
  accel/tcg: Introduce do_ld16_mmio_beN
  accel/tcg: Introduce do_st16_mmio_leN

 include/hw/core/cpu.h        |  13 --
 include/qemu/plugin-memory.h |  11 +-
 include/qemu/typedefs.h      |   1 -
 accel/tcg/cputlb.c           | 426 +++++++++++++++++------------------
 plugins/api.c                |  27 +--
 5 files changed, 212 insertions(+), 266 deletions(-)

-- 
2.34.1


