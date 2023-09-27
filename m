Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6747B0B5C
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 19:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlYl2-0000gg-F3; Wed, 27 Sep 2023 13:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanxiongchuan@isrc.iscas.ac.cn>)
 id 1qlYku-0000de-ND
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:55:24 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanxiongchuan@isrc.iscas.ac.cn>)
 id 1qlYko-0002OD-UR
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:55:22 -0400
Received: from localhost.localdomain (unknown [223.72.70.217])
 by APP-03 (Coremail) with SMTP id rQCowACXnWl4bBRlRIKBDw--.5656S2;
 Thu, 28 Sep 2023 01:55:04 +0800 (CST)
From: Xiongchuan Tan <tanxiongchuan@isrc.iscas.ac.cn>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org,
	Xiongchuan Tan <tanxiongchuan@isrc.iscas.ac.cn>
Subject: [PATCH 0/1] linux-user: Add drm ioctls for userland graphics drivers
Date: Thu, 28 Sep 2023 01:52:58 +0800
Message-ID: <20230927175408.495872-1-tanxiongchuan@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXnWl4bBRlRIKBDw--.5656S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryUAw47Cr47Kw1rtF1DKFg_yoWxZrg_Xr
 4kZFy8JrWUAF4UXa4akr13ArWayF4UWr40qF1Utw1UX3y3Aw1kJw10krn8Jr17XrWakrn8
 GrsxJ348ur13XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbw8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
 Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
 1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
 cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
 6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-Originating-IP: [223.72.70.217]
X-CM-SenderInfo: xwdq5xprqjuxxxdqqxxvufhxpvfd2hldfou0/1tbiCQYHAWUUNTFs2QABsI
Received-SPF: none client-ip=159.226.251.81;
 envelope-from=tanxiongchuan@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FORGED_SPF_HELO=1,
 KHOP_HELO_FCRDNS=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This patch adds more Direct Rendering Manager ioctls to support
userland OpenGL and Vulkan drivers, in addition to existing
DRM_IOCTL_VERSION.

More device-specific ioctls are needed though, but they share the same
range from 0x40 to 0x9f. Adding these would break the current
DRM_IOCTL_I915_GETPARAM. I'm unsure about whether a generic
implementation is possible.

Xiongchuan Tan (1):
  linux-user: Add drm ioctls for graphics drivers

 linux-user/ioctls.h        | 26 +++++++++++++++
 linux-user/syscall_defs.h  | 15 ++++++++-
 linux-user/syscall_types.h | 68 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.42.0


