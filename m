Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA874B1B3
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:21:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlNL-0005SU-LQ; Fri, 07 Jul 2023 09:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlNH-0005S9-EN
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:51 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlMz-0001Lk-Nm
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688735969; x=1689340769; i=deller@gmx.de;
 bh=Lqlzot1CUIarj6e7YCDTKYlH3j0+MnjN3neHPttgWIM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=bqsUfNS5Wwlg/Gco4iHcTUKySJnZPwJXzOPde+6VG9CxEAXZpcBU4Wmplt3zvT2Mw5n3doi
 FlfNHO+TpVyQ4E7cXdu90n3jEVkjggzomOlDy4psrIgwGcNhp8lwcabqjqps16wCTJ+1UUMWy
 owtUBRylEkvdn5kW4c+AeyJnMjX/JYPyQHkyMqHFG7rmEvA2raBa31MpoC8Y2B+B0UvUgawzX
 9q8wCAWW5eRdj1/QU2AMqH4/+6HAB7D16C6sGK6kPYx0Hisc+LUe0ykthxA8Azgmagoq79Z05
 HC6Smyq5aSGXONtgWQ5v0MSS/BnP07apkv5e7ND6ztm/H7xUzdqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.153.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1qDNeC44Lg-00DEHw; Fri, 07
 Jul 2023 15:19:29 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/4] linux-user: Fix fcntl64() and accept4() for 32-bit targets
Date: Fri,  7 Jul 2023 15:19:24 +0200
Message-ID: <20230707131928.89500-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l++sAtir71I4Qn8nBto6FIi1EyjnU1gHuFxDbiT+dSYF4E3+c88
 5NsKg5Ku/OqQFGwFW46NjR41Z0Ou1DFXrOt/WOADbU+XD3aFKr0Lr/DRbeYWrRHILg0eIvp
 D3beDEv4XsUlKbgP1a22BU9iyDyJh6hiyc5NYf41jseLoiQPmPvHQdCdij9yH9+VvqL/qzy
 hNhHXERqPKZqrZZ8GwQFw==
UI-OutboundReport: notjunk:1;M01:P0:SgP9nIkoWyQ=;tcdv2UXguy9ThzscCBgNeCwIYnq
 2zQjwFQESgbMzysg7K5ive7lTVEYSEj96b8vk43rblN6G/JFGXqzMBMJS2dpc8ddCGKiEJtNi
 84esG/WJDlhPC7y4uo/FVkS1w7W6nBtFKq8xSBQM4pgvjureOajrM1taqGb3eKqKEKOa1gXsg
 D/ywP1jHgbxuRfrsTHEFFnHwQuPCsuZbUhndUCSLsWzyqWEid0dQ/PMo1whM8QcRJnwI5iN+3
 Mb0Nqh1FsnOyvUZ1ZuQX45+am0q0PJHBRGOzArMB0wnYe+tkF7n16FnWjzO6m5zjz5t+sb8Nj
 A5jno/2GcJFGiklyWF1N5FtTknUoeTLj9lhn1jkH2W/EzSHvStFK8yyv85+H9IPqjqORi1IKb
 tRasj8tX3600XGRsztXxQMYO20McXQ3ouQes2+iuIZrSe8PRi+u2TFOFnPMSZ7jYx3LurzdOc
 EQaU/m+eVOk7GLIrzJ+7+eZGKSLhOMeAreJF5Nztxg/+1Qi27MBVDXftZXkV1i7R3Cb07nVii
 0scJhV4JVZErSqo2OvzOlLFYxnPBNq9Diw+eXZxxOxccK38WtHhxubvqKkOuvzVUnfaxfe5H2
 pzxn1RSPbor7xFXprPj8xtykDpZkof/yIVyZJ2iKYUEscoM6GgrMcfwRY/v5HCCHktOdPVz8w
 Ht8BDyWJL2+BmVMswFtyFRwuRY/kpXQl7TaFrdwoLKbQpabS+5foBB/Jy4pQHtn8PK2Vb2rDP
 XZITjtQScYNhl0zwZZnkqXYc4RHCH8VQqyTKBwf8Z9gX2JM/x/8W+Op6q4yvcHydVVWTPWz8W
 GDtnQWGNGj37cMHhcZOnJb6Z5jWdPyv0Qy93htZobzzYG3nFHaqTHE5+IkBF7UTgdYZaPcs/3
 PHYFrgEIKc6DQVEGqVBaR8xZgsMcFLn1a1WkoZxt5wspY+H/PUW9S4P3iOyMjqy22eM/nndu7
 0RXg7+ZNmGRAiwdKuOZcyFCeRRg=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A set of 4 patches:
The first two patches fix fcntl64() and accept4() for 32-bit targets.

Patch 3 and 4 are resent here with ask to get review.
They improve mmap2() for 32-bit targets and strace of pread64/pwrite64().

Helge

Helge Deller (4):
  linux-user: Fix fcntl64() to return O_LARGEFILE for 32-bit targets
  linux-user: Fix accept4(SOCK_NONBLOCK) syscall
  linux-user: Fix mmap2() syscall on 32-bit targets to allow file
    mapping beyond 4GB
  linux-user: Improve strace output of pread64() and pwrite64()

 linux-user/mmap.c      |  9 +++++----
 linux-user/strace.c    | 19 +++++++++++++++++++
 linux-user/strace.list |  4 ++--
 linux-user/syscall.c   | 24 ++++++++++++++++++++++--
 linux-user/user-mmap.h |  2 +-
 5 files changed, 49 insertions(+), 9 deletions(-)

=2D-
2.41.0


