Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A4B7617B1
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGac-0006vc-LP; Tue, 25 Jul 2023 07:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOGab-0006vJ-Cp
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:52:29 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOGaZ-0002Kt-Ib
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690285941; x=1690890741; i=deller@gmx.de;
 bh=Gi65YKRFlYvHO0EHdTsYhm8KfuOcE0zIsxodnHEiI7k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=OI8gd5rrZpiHpglBe28YhUtCXSskgV8KeAvevr1+CUeETNenRQDrnxpp2i1xvz6NpoKLZcW
 IaeansnrfLFMIN9NPR9+de0VHt9x/QQfZQAcSsA1m/C0SrHjspSifyZu7J3U7NVmeJP3fqzKy
 OVbtz4T0YMdB/QWcMsZ2wSsxNbI3e6dPMy0V/JTkCYH1tb443JkiTmzLhXaFrOuZl0CoVChpX
 y1XONPKeSfJwgDe0c8mXSxE/liqKkdteQoN54MuJBNIuzNEkoIJVif1gtRvgDBMKw4tyeRJpy
 xWP+Sad4PvR2Cpwg96VlgPj2Vpyg8aZTDUziiIzdb8dFuCus27uQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.136]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1qPfCh3dvf-00Xvmy; Tue, 25
 Jul 2023 13:52:20 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v3 0/3] linux-user: Fix static armhf binaries and optmize
 memory layout
Date: Tue, 25 Jul 2023 13:52:15 +0200
Message-ID: <20230725115218.52738-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jNTohAXgbBYJbI3nDRGnm5FdFv1/YcAg1ybXbHxphfpz4poDld8
 i45322SWMDqzfP9vo9/7fD5ASgVsgNz35K+yx0J3rfa2nrwnQm5CtE8PtZw3WEThubdF3lF
 dSxwEiLzqiufrNQbpsxLRzo+oNY8eJrw2QPxSJGvFuX//okE6Z1CPDh8DqjQ/ZdiJcPUHIL
 ZG0zDHrRHNwsfK266N4zg==
UI-OutboundReport: notjunk:1;M01:P0:a8EaiiXMSQE=;QIwMv8QSRU+7hlZL9aOgaHIodk5
 Ct1BHzihGQet/wmJ3fYNgvNA/uuTgx8JfvCSanj0pDgDoB50qGJfZ7FOEmviG8e45/BnWdCZL
 mCKyQudFedNIcb10d3BuIZRWvbCmao3zR6Kxu83LaVUVVGQDVXPAWzG+0SkhmDy+w90IzOzOB
 deY2ddVJZrKBOkz95wW8dD7OFFwfbi3kT6L1nv17Vp8xFM/rY1t10ecnF+O/ybfYYRmg9IBmy
 oVy3pvWjjcSQR9cyuEIGOHm/UGmhvFU5aDZgZbnvFgLzpDV3RsHmGkbt95UWLL0qgDwILWIE5
 TtplQHEhDWVN023BdBIyAWuWi2nSLZABmgCWllef5AmPX9B309VHuRrPVpL2snf9LfBESISov
 d4ENar2VYqC6bw/al5AXM5DmIvkc53lfXYROY4rdlPc4Wqqed+UFoUNcbwSlZJLpdNP3G+wWW
 r1EhIaBbgTFPZm0sfWxnrj+Ia1BJrXfUlwDFx+Lo5JWu4+Hu2IQkM4epSL4xjRfeTHjXBml3l
 vFLwzQjhyF4JDZlQEV5hESqGpGTKiKY39Oxp7Jl3dw4J5fvNbyzzXwEwxt8NucTM9KGIxvfwI
 +vFFNDZG9EMsIfe1eqAupQ4AcefYn9AkcJqKK/Maqy9c7Hj94gegzlv895uvlRKUVYrRKBav1
 dGe4r2+bdzQU2QpUDtPDW1FxCf1D4M40dTOqGYxBsiu5H+VImQCSbvJuhCfRWziMyAn7zz6vq
 bSJrzPZBIWt1jnnNf2OeWHjy3CeQjpijuV05Zp9dKy22SCSOcLHYRpO54Cil+uSuLoW1xcxdT
 sHfTm2BadQvZKZTMZvD3WJkJgoHFFzT2uL92LSZub/qTZrxaSolS+5bpYTCBvcfFCY17gG/vP
 Yp8x4ILuYO7vDWnuAku/32DjkGcHU+KkToDvHTm1q6qAmbyQxcW6ZJkJdDYPm9PPsh/XPDwWL
 vprWWQ==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series:
- fixes qemu-arm to run static armhf binaries
- shows address of heap in /proc/pid/maps output for all architectures
- optimizes address layout of loaded executable

It can be pulled from here:
https://github.com/hdeller/qemu-hppa/tree/brk-fixes-2

Helge Deller (3):
  linux-user: Show heap address in /proc/pid/maps
  linux-user: Optimize memory layout for static and dynamic executables
  linux-user: Load pie executables at upper memory

 include/exec/cpu_ldst.h |  4 +--
 linux-user/elfload.c    | 59 +++++++++++++----------------------------
 linux-user/loader.h     | 12 +++++++++
 linux-user/main.c       |  1 +
 linux-user/mmap.c       | 14 +---------
 linux-user/qemu.h       |  4 +--
 linux-user/syscall.c    |  8 ++++--
 7 files changed, 43 insertions(+), 59 deletions(-)

=2D-
2.41.0


