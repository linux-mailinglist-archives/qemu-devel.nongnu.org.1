Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D976774BC46
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0ij-0000qR-8S; Sat, 08 Jul 2023 01:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0ig-0000pV-Px
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:58 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0id-00027L-15
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688794970; x=1689399770; i=deller@gmx.de;
 bh=0JKYCpWjsg7lwSgDCWWkVSLShwZYIwP/6v0dfUDcswU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=ZrUs1B9oERUuL/Gy6AVqP8pZ/mlgXzlh8MRTNbmrVGXvS29edENSUioWMWlHulVskI+KfqZ
 yBHSX4AhaQz0AlDVxcacaRGZbFRAJCH+KQRfu66QS8yAw4maG8hd2lErbZ8Bu4mBQ3ph5MM+S
 Mm44poWsAM2gwY6a39rM5tf6BkfEXf2uwB3xaggBKXb9r1abr8+PZ5j/5kPz5Q+03Xzbo83wx
 MHrGsjxaUPeV1iKEOLeybYJFo6a1k6beLmCEEyXLfkrX+89olnAOjPFOMP0cVIlet9z9/BxQV
 qAO/qC/rq7S1WSeID6hb4h2XVtJCrgdM1qvm7KVo4P8FGPDK5XSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1qRFqS36QM-00R1aU; Sat, 08
 Jul 2023 07:42:50 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH v2 0/3] linux-user: Fix fcntl64() and accept4() for 32-bit
 targets
Date: Sat,  8 Jul 2023 07:42:46 +0200
Message-ID: <20230708054249.10245-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e4iraHgflAYgrdB5/31yyyAMnDMl6eoXNAFdrxujIFDW8DhWimA
 GPCovy3X/iYQrFRdkSkEI3SHi5+xYyHxydVbWaYezePIplwMTY1ULKywqPerlX25LXdIxsG
 gRgkwqW0qcd6eEk8DPrz5ISg3YunIQAqjpx4u89beGN4WAx7zvd+9x6OsuZ7MVoUisX3vDA
 XwuTk0HQBnxzwAQd/zy1A==
UI-OutboundReport: notjunk:1;M01:P0:UJzUn3aeTsU=;nne4D/PM6QwrDfmG9bLvhdR9+wV
 LpJiBXYE18PRJph7VWV85mA71LYjFR1BGkiUI1aAb4JGn+Z34+JiwX9jsBJxNTRq3VqlXo+/m
 odyTMbQ2iom+JnPuhh9rGZvJA5JCwehjrnF6bCIcy+4tRY8XzfoS/SPNviwryhFm49cBmYpbT
 TMGn//BKvXNLnij1p1p4qZ/rskyTzYucnHKagdrT7Hk8A03PVPq8AGvw4U8yU8mJdfg//ZBK7
 XCZKqSdDckhp88cvohPWMz5enQxTynEYp29HeqXnARN+aha3mRt2Ltb9NSUPDfANVkxpIDAIp
 +4pZuZmKnuHLuFm5T0CJdjpOFXUC05oM5L357pzJVMCwz34FsvK6VuRPycwcAvuMntwgA1Wfy
 3WlzDkt9RhJYQL15JUcJuH6Ox/2+lJymugPyHbYNidnyTjcByzgUeddaXzVc+B4Mb8ToD7Zny
 i2U09R7wkv7xk6xJwd584aeAMkFQnnFXv4U/rBb5nUDwrjQPPgtBQ6mLo5Nqk5AK5s/X24FXY
 1SEfgkvbvLs/Utz8rDu3Mg2VFaO6vlN8oAxwO7j3pAq/YQBxYZ67yL/d7LXL8uTlgtJzKEYd7
 JOkItFe5LMGSZW0X/t9NU8DO6q/pHjLZ9ixGC/Ag3CCg9xCBhdKSaoPWE0DdOGihjsp7oq/8i
 QOWvze0tG6M0ZxbDs66QOQndZPGSj616MNYCIvh5U3WPxffLsYW20C9EY5BN3kTh5gAOeMlw3
 WVJFxltsY4kmahCx0HCTtWDnBQaBzaRA5sNdkiNH1saUGk84pznaiW1o8zCy6doBzlh2w2eq7
 QfwpMv/GCcjkmwY332emp8b9GI7W5baEiAoVzdi1Sdk54t6M4nCI4bsOZdLHhh/z95LrdJNkY
 SqmuhmGgULWGuDsnG8hc+8GyZdOzrOshuVru8d6qTvmM0eGkLhjOp+9wOmV6fU90A4BgeQ8p0
 M3Veg94ZAQyG5/hBI82tVAudYH4=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

A set of 3 patches:
The first two patches fix fcntl64() and accept4().
the 3rd patch enhances the strace output for pread64/pwrite64().

I dropped my mmap2 patch in favour of Richard's proposal:
https://patchew.org/QEMU/20230630132159.376995-1-richard.henderson@linaro.=
org/20230630132159.376995-12-richard.henderson@linaro.org/

Changes:
v2:
- rephrased commmit logs
- return O_LARGFILE for fcntl() syscall too
- dropped #ifdefs in accept4() patch
- Dropped my mmap2() patch (former patch #3)
- added r-b from Richard to 3rd patch

Helge

Helge Deller (3):
  linux-user: Fix fcntl() and fcntl64() to return O_LARGEFILE for 32-bit
    targets
  linux-user: Fix accept4(SOCK_NONBLOCK) syscall
  linux-user: Improve strace output of pread64() and pwrite64()

 linux-user/strace.c    | 19 +++++++++++++++++++
 linux-user/strace.list |  4 ++--
 linux-user/syscall.c   | 16 +++++++++++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

=2D-
2.41.0


