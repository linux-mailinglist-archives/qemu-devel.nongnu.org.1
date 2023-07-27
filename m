Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A376482C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 09:13:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOv4d-0000qu-Ra; Thu, 27 Jul 2023 03:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOv4b-0000qX-H9
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:06:09 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOv4Z-0002rI-Pu
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690441561; x=1691046361; i=deller@gmx.de;
 bh=hl62McBTED48m6t1DVIVlnhWzOJirHrEQMPoQQHQT2M=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=KU7jC6sXIvw0oV1TnrvJL8QFrBbYYycZ8E33iuN2UxY5Qrjum8a8IulylQ1b/0ufedLtdiL
 YgodXbLameQ7bnowf/N5n8GMyrB2IslKMMZWfInuXt00dGETXrsyhhVl97bfg75bOX+MMzASj
 Ydmkn30g5a8VVCdRY6sfOvmVFTYJcfPBNuLZj7QwOUZI9zIopMb7jpgPNCxnS3v7D+FUKG4Ly
 0UHxEOEEUouJqcYcd6WJ+98DGMCz77/mzA92UxMk9idkLr92jgGW+CTzzD9YyCGhojWSS6M+X
 zoPKmCilx7N//yuNFjE56ZajAV35sB/Cst+aIAtNlpLBVbbxXwzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1qHsaB3Kby-00TAhP; Thu, 27
 Jul 2023 09:06:01 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 0/3] linux-user: Fix static armhf binaries and optmize
 memory layout
Date: Thu, 27 Jul 2023 09:05:58 +0200
Message-ID: <20230727070601.31383-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u4uBSXko2G61ImRWRmvm3nOas0tPTReZGawED/vG8pU84NZVDAT
 wwiznX4UEXCFo/P7u2+XMvN84E85BhvLn1wDuAAOD+sJxv6G1M2CT6fD4xckcL6eawjcZkb
 2JLENYwuI2kBA2PJ5wQ3m4sZ+QUJRvhhrUxSumC/YlwEclkg6w0+t8WZrZ5XI1WMoHJdnx+
 0iMTiNJZh2rTaq7O/mKtw==
UI-OutboundReport: notjunk:1;M01:P0:bYiKX9Ty9Qo=;PF5Qsz+Q9OlmfDZJFaiWH25kZoE
 VtYm5LChdt4itnd57//TayjwX9Xxs4IVgTkG8yxZQncAhgThHRcw/lsdj4oTrk090gwb0oxRn
 QAyNoi8PuqgfwsW6TYQg5iRHmfMqp25KJM/EuJSvrqNLhMJN9/31I+bWO0RGBMb+F1WHcsuPc
 riGnZch5tOh6+qxNK5Sb2CZmxeRIMqkONQNS0Nzgc+cXq+Fk3Yb/+cyWMFU9jIjtwzbOpbcmn
 op8PQF9ant4BLWt2+D9cV1nAHUYvXobKIwPmmIaonmhh6heQNL2OTbTxRpI/Kfre0srNlWTTu
 cTkeMD5Ymj+IVBTFOoZObdE5igEZuiZ/pzfNADTLtNUnheFHtWOXuEMpoO7Wbv3nCWXRgFfjN
 ob7TQQx6LboqDyxGQYeJJTuyxR6e2CvcVCadlFpjAr5kG72vEt2asIEiV3jMSjVsemJjKC5Wg
 /nfodOQU+kFIDYYUAlCVF7jHhMCnY7HrhKZjtRTxYAiatYqy915UG+YVf5eoeVP43E8LodBmd
 kcqka5xq56fMolupN7M9t1BSnkl/4T1q7+wuHVHxrZU6aos4Fd5BRHBU7uBSzeCmmAwSLLOe6
 qDjpmJn2Dy+tPPOHS38fxHlC9mINe3lbYQ9mMQbe+cyDlSHTW91R6VCjPn+swoWPJfz0J5LpM
 cnpeoRjuO45Hd4W02O4Z2GmJeq6So9SS9hhhhT8sEgwstyTAl4MKNlVE8k/XEmngK5Fhy4Akd
 iEEM26U9FKeC48J1ov292wsoq1ztMO/WF+EJcL3/8uvkm4uQ9O/4IMObnPeWNj0yaxH/fizpM
 mCn110XIo4IeFGRx1swrUy5neYM7LA6OwXR5asSHbNVg8I2OAkFisQfZe6gA5YNbJCg2gHRQX
 AsHD5iiPpl6u4rNCDrJyQsSeki/N8L3tx3nw2QJiQMDe9HpUYIjFQxNFmBGHV0ULow1Bt8GG3
 /1jwgQ==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch series:
- fixes qemu-arm to run static armhf binaries
- shows address of heap in /proc/pid/maps output for all architectures
- optimizes address layout of loaded executable
- increases free heap for guest apps

NOTE:
- this patch series is for qemu v8.1.0-rc ONLY.
- do not apply on top of v8.0-stable series, as those use
  a different search algorithm for free mmap memory
  and thus will give improper memory layouts.

It can be pulled from here:
https://github.com/hdeller/qemu-hppa/tree/brk-fixes-2

Changes
v4:
- add note that patch series is for v8.1.0-rc only
- changed TASK_UNMAPPED_BASE for 32- on 64-bit userspace

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


