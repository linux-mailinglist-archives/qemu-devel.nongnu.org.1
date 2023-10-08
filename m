Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B847BCC73
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMZ1-0003Ry-O2; Sun, 08 Oct 2023 01:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYy-0003RO-UO
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:50 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYv-0002ij-U3
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:47 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41808baf6abso22318881cf.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696743764; x=1697348564;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88mTmxvCCzXeF5MvCYjb+uFeI1WySt4qQFaPTNFWwqc=;
 b=PccdtqLdHJm0FXqDKa9IONNJ/9GuXn54yf52Thw8cBgOeEliG3R481CV7y2qekS+Tf
 RXE0L8gkWHVWAxP7NEUCu0UTZELWzm6l47KFggPSkbqhtljCfDSJiD7Ym24fb+eK0P1y
 fS905rPxzfgDlku/8ogaLWQUeAAvORI467BsR/cC6+PkT9QhKd7PilhaDq+rw/hld6jn
 IzYF2hfjSpSrBqRGhpDRWwDkRb82a6E5Ba+0SXkDdcgv47nJSSZNPR5rdHpAitoQSd4d
 X6lOxJfLIm5THE65Lt5N0AN/p4mA/+EBgC3vn1rjXBSy8teGr/j/bAfyLqQ3pD6gcP81
 bvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696743764; x=1697348564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88mTmxvCCzXeF5MvCYjb+uFeI1WySt4qQFaPTNFWwqc=;
 b=EotyNqPJzULxJS0Ni5OIDF82mjocHs4DxeKDk1VxNZ4q5kvpNG5mJmgJJqAFpXRahG
 kHZEto2HPceci6CNcjaLzRnX64LT1nZ/qnPVI1VD24G/zEOdglRMBJM9XxtgwChor2/0
 izh7Vxio5QSMZgDBBgH7VyTzSox7QDFR0PbO0nfu8JB2uSZw1JT4lSNQz+T1cnjn5HW0
 StD4R4d8+PDVEIp0wO0rmP1dk+/2VN3AX6wGzG0BxNaGoM3/0Os8HHQABFS+Y5Rhw5aR
 AWtPZmhD6pnE7XY7RtrzcW0CbsNjLLfMrtNYUuVCfl1lLhTHEAYAn2ZIzwBoYucUkaOA
 U8CQ==
X-Gm-Message-State: AOJu0YxPDA43L3DvaS12dGhJIk7z/RW9iR3KomOesqWadxxvtr9Qa5hT
 UpAZzaOCfiYS7Ylpb7ezqa0Nhg==
X-Google-Smtp-Source: AGHT+IHcgOaPoWYtJRQtrou7yojFw0dwP98UbTm635hLlu5Zj28C10TzZUPrSo+Jbxe3dEy+pENTGw==
X-Received: by 2002:a05:622a:34d:b0:418:16e0:f19e with SMTP id
 r13-20020a05622a034d00b0041816e0f19emr14822805qtw.14.1696743764495; 
 Sat, 07 Oct 2023 22:42:44 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 n7-20020a62e507000000b00693411c6c3csm3961357pff.39.2023.10.07.22.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:42:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [RFC PATCH 4/4] docs/devel/ebpf_rss.rst: Update for kernel RSS
Date: Sun,  8 Oct 2023 14:42:18 +0900
Message-ID: <20231008054222.146228-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008054222.146228-1-akihiko.odaki@daynix.com>
References: <20231008054222.146228-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::829;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

eBPF RSS virtio-net support was written in assumption that there is only
one alternative RSS implementation: 'in-qemu' RSS. It is no longer true,
and we now have yet another implementation; namely the kernel RSS.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/ebpf_rss.rst | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index 4a68682b31..487123006c 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -5,9 +5,21 @@ eBPF RSS virtio-net support
 RSS(Receive Side Scaling) is used to distribute network packets to guest virtqueues
 by calculating packet hash. Usually every queue is processed then by a specific guest CPU core.
 
-For now there are 2 RSS implementations in qemu:
-- 'in-qemu' RSS (functions if qemu receives network packets, i.e. vhost=off)
-- eBPF RSS (can function with also with vhost=on)
+For now there are 3 RSS implementations in qemu:
+1. Kernel RSS
+2. eBPF RSS
+3. 'In-QEMU' RSS
+
+'In-QEMU' RSS is incompatible with vhost since the packets are not routed to
+QEMU. eBPF RSS requires Linux 5.8+. Kernel RSS requires Linux with the following
+patches:
+https://lore.kernel.org/all/20231008052101.144422-1-akihiko.odaki@daynix.com/
+
+eBPF RSS does not support hash reporting. The hash types and indirection
+table size compatible with the kernel RSS may be limited by the kernel.
+
+virtio-net automatically chooses the RSS implementation to use. Kernel RSS is
+the most preferred, and 'in-QEMU' RSS is the least.
 
 eBPF support (CONFIG_EBPF) is enabled by 'configure' script.
 To enable eBPF RSS support use './configure --enable-bpf'.
@@ -47,9 +59,6 @@ eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap co
 
         tap,vhost=on & virtio-net-pci,rss=on,hash=on
 
-If CONFIG_EBPF is not set then only 'in-qemu' RSS is supported.
-Also 'in-qemu' RSS, as a fallback, is used if the eBPF program failed to load or set to TUN.
-
 RSS eBPF program
 ----------------
 
@@ -65,7 +74,6 @@ Prerequisites to recompile the eBPF program (regenerate ebpf/rss.bpf.skeleton.h)
         $ make -f Makefile.ebpf
 
 Current eBPF RSS implementation uses 'bounded loops' with 'backward jump instructions' which present in the last kernels.
-Overall eBPF RSS works on kernels 5.8+.
 
 eBPF RSS implementation
 -----------------------
-- 
2.42.0


