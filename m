Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D558724C5F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:06:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bz0-0001Ov-1O; Tue, 06 Jun 2023 15:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3RYN_ZAsKCnQSUcWjdWqlfYYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--ackerleytng.bounces.google.com>)
 id 1q6byy-0001OW-KV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:40 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3RYN_ZAsKCnQSUcWjdWqlfYYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--ackerleytng.bounces.google.com>)
 id 1q6byw-000276-U4
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:40 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-25665d2a250so5868042a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078277; x=1688670277;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=l7m/+H3bbKiFYeplsxMS6SzLQH+bOrcqP3X6Nh5dkpY=;
 b=14V+ikDqPeP4Yv1OdmN8nd7QZ5MMjeGKWKaRSYFOZag9l1JWEXWB4ucnpLMnABlXZA
 EKyjA/Hep4b5XPLE3jo+/oAtPajUrqdw+KeK/h9os1d0usuctIgWW9M+esmzYCfBXl4x
 ASFKNceH4Dvr96zHhOZ0uM2fLtsPSrNxdz17wPPKIRFX8xmJyoeEp2adnxvZEKqN8X4Y
 OM4Rksx4vK290PDLeLyuR9aPGnO/Zd4sMVHFMKGC9zk+GBNtZUBayI8BLZ7Yas0LD8pw
 GLTAE9YptousowvGxGw0V5tbYjLuLpB0CEXyROZYUG+NBDy7fuPXlo1tE0nXFLN+WEBW
 wc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078277; x=1688670277;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l7m/+H3bbKiFYeplsxMS6SzLQH+bOrcqP3X6Nh5dkpY=;
 b=ZSe2ujfxBrBowDNGdxPZ7dLBSOxRIJVwJPP3j98ZBQUFMsE9TzK7PLFUpEYQr2GjJZ
 zwG6DBUnHaq25oybxcsOYN+tqlQpmIDHmcpFYGzCRDLg0A+8+V7IK4Sm2U8Af4efjAtI
 Oi6c5uCIu7QzlyVVvllTz2l9IB0tO8PAog89gcKUF57dz45AvLvLtyXcSfepcfOLtJAK
 HPDMgxDt12/utXugGc9Xq+X9nW/BtSQjHpmbu+evN/LqnQI00f2kV1QS/E0h31PEc7+J
 E9khG85i2qc727Gyie922KUMgIe7k3GV2Toe5GTNBsZ7dWLXBWxE5/sk8Na8Mu55DhIM
 pojA==
X-Gm-Message-State: AC+VfDzqAE/iqkv/ogkaBaDjH5Jrg2jy/+QzUabUylQLqhXELJbNptJ1
 g58tGqUbG44rbFsNhjWBA5kYsUSFNibWQE5gQA==
X-Google-Smtp-Source: ACHHUZ400PPpzSqOQyBrlXwnbK9H57gIHhF9scqTSjoAqyx8OcXSiJ7wdR2icZ3OG98VTDSuHd/HQ93iA5Sxt1cqNg==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90b:3003:b0:253:4808:7587 with
 SMTP id hg3-20020a17090b300300b0025348087587mr772798pjb.7.1686078277257; Tue,
 06 Jun 2023 12:04:37 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:58 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <67168b07e8d4a0c714fce5f030671b376d8ca001.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 13/19] KVM: guest_mem: Refactor kvm_gmem fd creation to be
 in layers
From: Ackerley Tng <ackerleytng@google.com>
To: akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
 pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org,
 willy@infradead.org
Cc: brauner@kernel.org, chao.p.peng@linux.intel.com, coltonlewis@google.com, 
 david@redhat.com, dhildenb@redhat.com, dmatlack@google.com, 
 erdemaktas@google.com, hughd@google.com, isaku.yamahata@gmail.com, 
 jarkko@kernel.org, jmattson@google.com, joro@8bytes.org, 
 jthoughton@google.com, jun.nakajima@intel.com, 
 kirill.shutemov@linux.intel.com, liam.merwick@oracle.com, 
 mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com, 
 qperret@google.com, rientjes@google.com, rppt@kernel.org, 
 steven.price@arm.com, tabba@google.com, vannapurve@google.com, vbabka@suse.cz, 
 vipinsh@google.com, vkuznets@redhat.com, wei.w.wang@intel.com, 
 yu.c.zhang@linux.intel.com, kvm@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, 
 x86@kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3RYN_ZAsKCnQSUcWjdWqlfYYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--ackerleytng.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

First create a gmem inode, then create a gmem file using the inode,
then install the file into an fd.

Creating the file in layers separates inode concepts (struct kvm_gmem)
from file concepts and makes cleaning up in stages neater.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_mem.c | 86 +++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 8708139822d3..2f69ef666871 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -375,41 +375,27 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
-			     struct vfsmount *mnt)
+static struct inode *kvm_gmem_create_inode(struct kvm *kvm, loff_t size, u64 flags,
+					   struct vfsmount *mnt)
 {
+	int err;
+	struct inode *inode;
+	struct kvm_gmem *gmem;
 	const char *anon_name = "[kvm-gmem]";
 	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
-	struct kvm_gmem *gmem;
-	struct inode *inode;
-	struct file *file;
-	int fd, err;
-
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
 
 	inode = alloc_anon_inode(mnt->mnt_sb);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		goto err_fd;
-	}
+	if (IS_ERR(inode))
+		return inode;
 
 	err = security_inode_init_security_anon(inode, &qname, NULL);
 	if (err)
 		goto err_inode;
 
-	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_inode;
-	}
-
+	err = -ENOMEM;
 	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
-	if (!gmem) {
-		err = -ENOMEM;
-		goto err_file;
-	}
+	if (!gmem)
+		goto err_inode;
 
 	xa_init(&gmem->bindings);
 
@@ -426,24 +412,41 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
 	mapping_set_large_folios(inode->i_mapping);
 	mapping_set_unevictable(inode->i_mapping);
 
-	file->f_flags |= O_LARGEFILE;
-	file->f_mapping = inode->i_mapping;
-	file->private_data = gmem;
-
-	fd_install(fd, file);
-	return fd;
+	return inode;
 
-err_file:
-	fput(file);
 err_inode:
 	iput(inode);
-err_fd:
-	put_unused_fd(fd);
-	return err;
+	return ERR_PTR(err);
+}
+
+
+static struct file *kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags,
+					 struct vfsmount *mnt)
+{
+	struct file *file;
+	struct inode *inode;
+
+	inode = kvm_gmem_create_inode(kvm, size, flags, mnt);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
+	if (IS_ERR(file)) {
+		iput(inode);
+		return file;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+	file->f_mapping = inode->i_mapping;
+	file->private_data = inode->i_mapping->private_data;
+
+	return file;
 }
 
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *gmem)
 {
+	int fd;
+	struct file *file;
 	loff_t size = gmem->size;
 	u64 flags = gmem->flags;
 
@@ -462,7 +465,18 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *gmem)
 #endif
 	}
 
-	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
+	fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		return fd;
+
+	file = kvm_gmem_create_file(kvm, size, flags, kvm_gmem_mnt);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+
+	fd_install(fd, file);
+	return fd;
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-- 
2.41.0.rc0.172.g3f132b7071-goog


