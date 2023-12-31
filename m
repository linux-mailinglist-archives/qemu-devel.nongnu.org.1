Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BEE820A90
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:51:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrV3-0008O4-U2; Sun, 31 Dec 2023 03:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTQ-0005Yw-IC
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTP-00010g-4v
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFlXgToJJaz5iydfSCuNL6R+tbV5HpAAeCHRhDshYhE=;
 b=ARg7ijaxZ+WuBjsmB8yQ7Ks0bHordp0isgkshRKesbepXrj/WWGaPhIAQ2Xaq2VUUSSlo5
 l1GfOG1T7614BmdkI7HxCwDgE26AwpEZJazhzXKaavq6iKp1L0iUIeSR0KxVPlnaBWKhyw
 bthZ8Ah8mJLUPj2nSRGc/0zZAV/tUsU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-d5n0Bg18MdWPEmX6OpW8gQ-1; Sun, 31 Dec 2023 03:46:59 -0500
X-MC-Unique: d5n0Bg18MdWPEmX6OpW8gQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d8586c709so5439245e9.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012417; x=1704617217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFlXgToJJaz5iydfSCuNL6R+tbV5HpAAeCHRhDshYhE=;
 b=QnFQCYH8kavUEVNhxVtMSrCclm556yTYj+gnTA1qTNzwAmd6aTb23beuV/4fr7HfS0
 FiMSEcEHMaJkprexe4GBjMhafAsgof5dR6tQ4+FnEkQOb2S2juPxfaeDSxEG8yo/pRtV
 PEJNEzYiWhoIbKQEhVbyncOGKR8ustXz7XqFu6MjuIPjdkcpuwgeg8b/FRsae4C7Cw6c
 WD6NYvdGNqJ4jNnzdfZNw+9UtWfcFTn/u/4p1wwFH4zH6ywgA6Ar13KujH0bwq3n6FTV
 /QXc4Nysfov2ri2OUp1BNav8hgRKSp84jzWrcYQja6/0lPItsCMKX/0M+BSqw5+wKV8p
 Uvkg==
X-Gm-Message-State: AOJu0YxYmmgYfFnIsBLQmpyvuyhV1CKzaUGSMlnInqD0YB7q5TRHCWnM
 dwqW9sReL6NNQ8aA5dUOzFQD7ATYLd2zrAvYxvBMb/+uOUQdw28Xqf5mrsMvmkAmpvlD0MkC+XG
 YCS0kKDwGn84rE+lagdRXmDlt3RDE/hoOcL/9gBmShw2lwXp9OIKR1fWqznyyhc2rRCmXq34BdV
 T35KJ0sQo=
X-Received: by 2002:a05:600c:540d:b0:40d:38df:5802 with SMTP id
 he13-20020a05600c540d00b0040d38df5802mr6964973wmb.165.1704012417690; 
 Sun, 31 Dec 2023 00:46:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFopVWNDEJMcCweHcmvxdk3fZr5+UhH4HiGuAChp90wEDz/0ZNShVh/DXIAyvNNCeCrM0dbug==
X-Received: by 2002:a05:600c:540d:b0:40d:38df:5802 with SMTP id
 he13-20020a05600c540d00b0040d38df5802mr6964969wmb.165.1704012417429; 
 Sun, 31 Dec 2023 00:46:57 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm36952793wmq.27.2023.12.31.00.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/46] meson.build: report graphics backends separately
Date: Sun, 31 Dec 2023 09:45:02 +0100
Message-ID: <20231231084502.235366-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

To enable accelerated VirtIO GPUs for the guest we need the rendering
support on the host, which currently it's reported in the configuration
summary under the "dependencies" section. Add a graphics backend section
and report the status of the VirGL and Rutabaga support libraries.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231222114846.2850741-1-alex.bennee@linaro.org>
[Remove from dependencies as suggested by Philippe. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 44bc5bf0c0e..5a2582776ce 100644
--- a/meson.build
+++ b/meson.build
@@ -4302,6 +4302,12 @@ summary_info += {'curses support':    curses}
 summary_info += {'brlapi support':    brlapi}
 summary(summary_info, bool_yn: true, section: 'User interface')
 
+# Graphics backends
+summary_info = {}
+summary_info += {'VirGL support':     virgl}
+summary_info += {'Rutabaga support':  rutabaga}
+summary(summary_info, bool_yn: true, section: 'Graphics backends')
+
 # Audio backends
 summary_info = {}
 if host_os not in ['darwin', 'haiku', 'windows']
@@ -4337,8 +4343,6 @@ summary_info = {}
 summary_info += {'libtasn1':          tasn1}
 summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
-summary_info += {'virgl support':     virgl}
-summary_info += {'rutabaga support':  rutabaga}
 summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
-- 
2.43.0


