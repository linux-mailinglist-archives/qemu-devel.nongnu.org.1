Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBBD9FDCF5
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Dec 2024 01:24:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRh55-0005lI-Md; Sat, 28 Dec 2024 19:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tRh52-0005l0-Jo; Sat, 28 Dec 2024 19:22:53 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tRh4y-0006Di-UU; Sat, 28 Dec 2024 19:22:51 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 46D6125400EA;
 Sat, 28 Dec 2024 19:22:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sat, 28 Dec 2024 19:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1735431765; x=1735518165; bh=1Y
 7M52wWuLrMrOLMsL7Y9mSw1SDq968VdmcgQIsEgkQ=; b=tK4o6vBG9fv1J6d5HT
 6FeLchtx4hgRio/7/GoOI0el6JmmazY9Bc+tqfySNDOwXTNWrDHYG0A55OyHG260
 BuBSVlBP6HbGo764H3PJV/iam23HGS/9wGeWFlL1uA0VvjuM5b28iksOpXq+3vD0
 BvntvH4D4CTDcfqmvKqzMkOkFEevL+RM2A+3FxMJMtApZO6ysec5FlK//5uKH+4x
 yVkuIaft2TPKSkgg/x8tuXVhcSzQnkkaCRpR99PDxza65JB/WQaxcZSS4csZjx4u
 oQ8m4UfS6kh9Q/75oNIFTVL2wCAe2pcHJRJVqPyfse0WA7a+sh/IGHlDqRyh/ulV
 mFfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1735431765; x=1735518165; bh=1Y7M52wWuLrMrOLMsL7Y9mSw1SDq
 968VdmcgQIsEgkQ=; b=YlzdzBXGHMlqUhCfsbdvbi6Hysmo6Xwlv9V9wMXvd6zU
 zXsImmZ3bvLQfesDENmrjDHGUuVltwFhUQAofToGvxdEhk8jl6ts0rjzfM/4ptep
 QRhQ0VcjxobDUx5qW5/vrgK+6AaSu6yeM17QjqtazuTWrwDe6+xwhdUDT4KnN9aO
 dm8xhoM8O6FNG9KdjvQhwIeA16HfiQcAkHycI0/5mQn0TEM8FD7u9bD83p0eOTD7
 XlgT+A5OkpAUW4AGsFMYhzd/ccu/dxNgvwtAv1IZSdWhNKxWzLm4GVC6ZkQZLuG4
 78dU6iJASB9qMwpz9yEbG+gnjq2nP6NCzNNd99a5PA==
X-ME-Sender: <xms:VJZwZzuJMcsjfqVH1pRuLO6tDEiX9ZqRPDsYVFvARdtO5I9qBLjWNw>
 <xme:VJZwZ0eMvPllDx3Ya3dOEOyx3c9D-3ffyHqsNeTK_btiryCaGEJe_fq8UwZLPVsBZ
 1LXP97aeMH3Z1e8i9U>
X-ME-Received: <xmr:VJZwZ2zcI5YJAiMyi6pYYG3xBMV_LRAAaBJ3XEvH8Z1SJaunM_JkRFT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvfedgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepffetueegkedtgfejveeuvdfghfegtddv
 gfehudeghfegheetueduheduveejtefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtgho
 mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
 hirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehqvghmuhdq
 shhtrggslhgvsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtoheplhgruhhrvghnthesvhhivhhivghrrdgv
 uhdprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdroh
 hrgh
X-ME-Proxy: <xmx:VJZwZyNOwUXD3or_e6GkBTZSCfRz77piVMPDHrs5Df8y3hH9Co1E5w>
 <xmx:VJZwZz97Cf7OVet5p7bUrs5aX2R1z_aj7ecg-A91_NAk9fiwvqG0vA>
 <xmx:VJZwZyWwvm8B5ns4WG0NatKM_IRjjd-a4O9g0loYbzqfsy_vSUScEg>
 <xmx:VJZwZ0fPK9GkSdUTQMjwfMjl_HfpMLyMKDsR8g3vMy6bFreSOtIXig>
 <xmx:VZZwZ-nVuyJxNHsBF_xJhzPdtXdjH0NRRiLTAC0vy5LwuXWKspK7JVC8>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 19:22:43 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 29 Dec 2024 00:22:33 +0000
Subject: [PATCH] target/m68k: Handle EXCP_SEMIHOSTING for m68k class CPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-m68k-semihosting-v1-1-db131e2b5212@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAEiWcGcC/x3MQQqAIBBA0avErBNqCtGuEi3CJh0iCycikO6et
 HyL/zMIJSaBocqQ6GbhIxa0dQUuzNGT4qUYsMG+RbRq12ZTQjuHQy6OXqHrrTN66ahzULIz0cr
 Pvxyn9/0AqSFz+mIAAAA=
X-Change-ID: 20241229-m68k-semihosting-2c49c86d3e3c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=1ytj1cwzpZ3HdUNNeVM1q2TYT84itjIJ9G6gJZ//CFw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSCaUFaSdvWeXRMyF42L4MzhWfGgluLN56P8flaELTuE
 Mc846LNHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCR3xcZGVZymmz1dEzTNruy
 0krsWe//yOzf2n9jax0KC+sfM+mlyDL8s7Pr2cO/mf/wCf/NWrus9vo9my64LGli8JN9K5VkZi4
 v4QEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

EXCP_SEMIHOSTING can be generated by m68k class CPU with
HALT instruction, but it is never handled properly and cause
guest fall into deadlock.

Handle it as what we've done to coldfire.

Fixes: f161e723fdfd ("target/m68k: Perform the semihosting test during translate")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/m68k/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 15bad5dd46518c6e86b6273d4a2b26b3b6f991de..95b3d5cf052c6ffd515afdffd5465550ae3af455 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -285,6 +285,9 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
             /* Return from an exception.  */
             m68k_rte(env);
             return;
+        case EXCP_SEMIHOSTING:
+            do_m68k_semihosting(env, env->dregs[0]);
+            return;
         }
     }
 

---
base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
change-id: 20241229-m68k-semihosting-2c49c86d3e3c

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


