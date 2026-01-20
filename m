Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP2oBffMb2mgMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:44:07 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3B949B68
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:44:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGgu-00089I-IB; Tue, 20 Jan 2026 13:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGgP-0007ra-88
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGgL-0006hJ-45
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:28 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so33102395e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934543; x=1769539343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lZ4calIf/kw/c+hbg+qyJSLSji7C9qv973kqSG9pMSs=;
 b=hqR+IxgFzMHAKJOkeKJ1FiyN8k6ATlJlgpSwHsDwCgt44y/isUhK8Bna3Z4WdOrQSd
 ezbXAeb1Z+CHjufDjV8WWyJiZuDA6ZnjuLeD+GVlDv5yGr2LUjd0TvkKKHULz5gOwu7W
 87ac5itfGv08URVxhDSuR7Lt+/uj8Te6upxuUL1UzZB3YYFWEbiItimDVeVNqNI6soLj
 jpKMTrMRl5SYSSPOHVXkYgGis+qrxOgOlosbk8D0tzJoqBl7dajnPO9MmAW3pHEzslhD
 l6yw3Eg03ZPd9kwz3g98sbWCHWyOnJj3d1Vp3mZ3OrNm9zAh/E5IovOiyBosuQHvn/xF
 sXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934543; x=1769539343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lZ4calIf/kw/c+hbg+qyJSLSji7C9qv973kqSG9pMSs=;
 b=eClN9eCkoWcD8TF5nxAKLz3y5JIoTM8goKfaKJ/8S7fhNDEvgiMRk3rsc9xG+Bm0tI
 6B7j4yaqTSSp5kkzN7+BvGmsN7ETdx9jVSkU/AX+I+SsH4Eq32v2f1i6Mg9FKyHrN8+E
 IizSSfMR7Mx2BV7xTq4halQn4bPBNvnzwSLZBV+8kA+8AEtXFQr9Gs2aAtcdSwg6zlTk
 KCKzTXz3W8HTnK2jj0gOHo/sI9CL1WVry2F7+RoSuvV9vEkNGzeonSWm9nTVZDTOsZAH
 isIzRi+/I6nxybtT9uGXKd1gArjWqp/fp1GfCvrfxpvtYlr1E91Cf8NXZFobSGh6y25h
 pSew==
X-Gm-Message-State: AOJu0YxnvWQ9hzSpJKOQQM242XuSu4pZYnvhUFfy4D9ldnWvHD84XJ9p
 pIt7lx0Fj/db3H8oblWghhXc3O1Blk5Q+7AcG+Vk8S1U479ICyFffoe+j/+m4xBXtkGLFlzndpH
 nFD5NmvU=
X-Gm-Gg: AY/fxX5eLc57tK6+QpUGB+MM9ePn6ZcWkvT95eoKDn8gv1rUdtiQQ7bC4G3rVRhnW76
 NUZ17UOYFxzufAu9PFLV9r7ksbs+8fsFUfc8QvtAhF8T8BAZZL9jG4Vla0QdOicC0nvIvd3npF9
 huOXN8sZWY9yonZ8vrxzP/pSbcaT+7fw9bio7+ofJ1YZgHbBT/oSVwT9yc+dOvb8Pezq4WjpYUX
 qo5OLFNiGUAnN18k5TaeC3zdMfHDvBvBtZrkE+Dfs1BO9oIxh0Wf+Xxm6nycbd4/tGJR9lZNIC1
 aD14wjUqp/XmLFg4Z/4PK7RCkBXesoPMrPMdC7XJStNusiocbn1eHxcRDyflVxGmQ5iEaEFWnUB
 YcsXNCV2TjSGmVhkKy7Tmoju7cAmiuJGaVYNRJejFm1bw/feHBCFg8TOLzWy7LXelhtckoY2H7S
 HxykEJvsqmSIYtGboQsbkQ++zywNmonB07YYYYyhZbywB1hCmXZDZYE7QsEgu0
X-Received: by 2002:a05:600c:190d:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-4803e79bbbamr40511875e9.6.1768934542723; 
 Tue, 20 Jan 2026 10:42:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0475sm310188685e9.10.2026.01.20.10.42.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:42:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] meson: Do not try to build module for empty per-target
 hw/ directory
Date: Tue, 20 Jan 2026 19:39:02 +0100
Message-ID: <20260120183902.73845-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-0.21 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MAILLIST(-0.20)[mailman];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[philmd@linaro.org,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[qemu-devel];
	PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meson.build:url,lists.gnu.org:rdns,lists.gnu.org:helo,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: BF3B949B68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In commit 83d5db95d38 ("meson: Allow system binaries to not
have target-specific units") we allowed targets with empty
target_system_arch[] source set, but missed hw_arch[] could
also be empty when building modules.

Skip such case, otherwise due to commit a1ced487549
("hw/microblaze: Build files once"), building with
--enable-modules triggers:

  ../meson.build:4034:14: ERROR: Key microblaze is not in the dictionary.

Fixes: a1ced487549 ("hw/microblaze: Build files once")
Reported-by: Frederic Bezies <fredbezies@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3272
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260116131817.38009-1-philmd@linaro.org>
---
 meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 3108f01e887..a84f14258b0 100644
--- a/meson.build
+++ b/meson.build
@@ -3957,6 +3957,11 @@ if enable_modules
   foreach target : target_dirs
     if target.endswith('-softmmu')
       config_target = config_target_mak[target]
+      arch = config_target['TARGET_NAME'] == 'sparc64' ? 'sparc64' : config_target['TARGET_BASE_ARCH']
+      if not hw_arch.has_key(arch)
+        continue
+      endif
+
       config_devices_mak = target + '-config-devices.mak'
       modinfo_src = custom_target('modinfo-' + target + '.c',
                                   output: 'modinfo-' + target + '.c',
@@ -3966,8 +3971,6 @@ if enable_modules
 
       modinfo_lib = static_library('modinfo-' + target + '.c', modinfo_src)
       modinfo_dep = declare_dependency(link_with: modinfo_lib)
-
-      arch = config_target['TARGET_NAME'] == 'sparc64' ? 'sparc64' : config_target['TARGET_BASE_ARCH']
       hw_arch[arch].add(modinfo_dep)
     endif
   endforeach
-- 
2.52.0


