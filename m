Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D4377A576
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 09:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV5oV-0001Xk-OL; Sun, 13 Aug 2023 03:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wbx@openadk.org>) id 1qV5oI-0001Uu-Ql
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 03:46:55 -0400
Received: from helium.openadk.org ([89.238.66.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wbx@openadk.org>) id 1qV5oG-0004VZ-Bx
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 03:46:50 -0400
Received: by helium.openadk.org (Postfix, from userid 1000)
 id B9A8B352BD61; Sun, 13 Aug 2023 09:46:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
 t=1691912803; bh=qtZJY5BUET2b9T2HRO2zEsHKJcUvoGoGkDfqiukYlk4=;
 h=Date:From:To:Subject:From;
 b=mUpXYktDtZpZJin4vs2NUi9BhB7hwG9XKVeshKR6q0TF7z85Rekp4eBFpGV3fH/Lt
 pEevreCZk5zrHl87J9r9wZpsPcGSXcgUwfiBZBiax6eZEkA4YHxjY+BeuHO5HWiWGm
 ppgs9aPTUv4Nmso3ExweZsy+Z0YHzKFaUMsgCdAV2DjlcqvMwYPNNjq/n+wamihqo3
 CD13QBYPLnUaeFBybkGeHB0+Yye02TsFoMF01T3Lfkzo0qcE3qFrW2OfOMa8EvNhgB
 fnv7bTleW33F08iznRos+jgo7Ah6YJJkedhKRWqyX4bNmh8JKy5DXEemTfD/1NeuCs
 DfoBHdmrQnBhQ==
Date: Sun, 13 Aug 2023 09:46:43 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: qemu-devel@nongnu.org
Subject: qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data:
 Assertion `r->req.aiocb == NULL' failed.
Message-ID: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 5.10.0-21-amd64 x86_64
Received-SPF: pass client-ip=89.238.66.15; envelope-from=wbx@openadk.org;
 helo=helium.openadk.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

I am using Qemu 8.0.3 and getting this error:
qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data: Assertion `r->req.aiocb == NULL' failed.

It happens f.e. when I extract the glibc source code inside Linux.
Linux 6.1.44, glibc 2.38 is used for the Linux system.
I am starting qemu this way:
qemu-system-m68k -nographic -M q800 -kernel /home/wbx/openadk/firmware/qemu-m68k-q800_glibc_68040/qemu-m68k-q800-archive-kernel qemu-m68k.img

What can I do about it? Why this is happening on "heavy" I/O usage?

Thanks for any help
 Waldemar


