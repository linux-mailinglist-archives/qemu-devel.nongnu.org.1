Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CD7C9FA7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH9J-0004Lj-Bi; Mon, 16 Oct 2023 02:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH9A-00047O-HF
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH98-0005WI-If
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oahmSuJ7paVGXQzz0W0nviH8/X3gevqOR6gcPfSk8kQ=;
 b=NjD44VlVm76bZSN6zBislCb6O2iz6HqN3LOfMdy+/Xz6pRpTl2mGnkr1edkl5F2E3lw550
 OwWQ3dtmUvRnQR0X+du4ea1ytsw5V/2oJCMEHNpWtVb5WRUCTOxTHXvDJQ1GT4+cfB8f5U
 PCkTJu9xxEEOV66RHsal7Xin1+UTX4s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-AEGB8yR2OQKnkxIhxFd9Vg-1; Mon, 16 Oct 2023 02:32:07 -0400
X-MC-Unique: AEGB8yR2OQKnkxIhxFd9Vg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so302121266b.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437926; x=1698042726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oahmSuJ7paVGXQzz0W0nviH8/X3gevqOR6gcPfSk8kQ=;
 b=n4oQXG/7rOIDh8IAYtJI2eXWwzBhL/X8X1QFNKTRBijHdTrZr/YSr8wwH6noYU09jj
 TtEkokEwAELK5Pa5KaDCMekeM5T9khomZHWmzv5FSQUBXuZnQjBBArgw/lcY+9i8dnqz
 RbAvlsck0E0GJJHheWOK5Rb3V5Bp1AZRDxAdplpoTciWwEtPegiG3ikByuHq1qkYr2Ii
 OODWr3zYR3dSpNKriWGHBjGZssvP0OrZvtk97oySr3A1q5p1qcFMH4vJLQMQoH19uomT
 d/ammIgy2HF231VKTeTI14kEt1i53rSjKuV1cnzlv8mMZhlotPSkz06C/psMwQqfprFe
 oMNw==
X-Gm-Message-State: AOJu0YzpecnAQhYzNBKdFySMthlyhiYiq8IABsTILYEWL8KbKE4fCqP6
 NwyPi4qVKq1HBP+ZYAX++vkkwSwz9+jVy8KexR4QQd+AS24TsoHrB7ito0ZNbwoHd8lG1Y0KC2A
 b6oygvQQENQdRTo9t6QlkU8lvQt5BsARe1r6oequb1ym4UmgFd21G0JuVtAm5/PSjtRgw2gHVa2
 0=
X-Received: by 2002:a17:907:7d92:b0:9be:b668:5700 with SMTP id
 oz18-20020a1709077d9200b009beb6685700mr4488497ejc.58.1697437925849; 
 Sun, 15 Oct 2023 23:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2mCzb8gcDm4JMdr2Y7sMzd9V61g/BRbVaII5kmFG9DvePvtn48kp5eRezSbd1yTJfk/GwdQ==
X-Received: by 2002:a17:907:7d92:b0:9be:b668:5700 with SMTP id
 oz18-20020a1709077d9200b009beb6685700mr4488490ejc.58.1697437925534; 
 Sun, 15 Oct 2023 23:32:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a170906738f00b009a198078c53sm3392532ejl.214.2023.10.15.23.32.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:32:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/17] meson: add a note on why we use config_host for program
 paths
Date: Mon, 16 Oct 2023 08:31:27 +0200
Message-ID: <20231016063127.161204-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 87bb4e9243a..c80882da6fd 100644
--- a/meson.build
+++ b/meson.build
@@ -4021,6 +4021,11 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 summary_info = {}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
+
+# FIXME: the [binaries] section of machine files, which can be probed
+# with find_program(), would be great for passing gdb and genisoimage
+# paths from configure to Meson.  However, there seems to be no way to
+# hide a program (for example if gdb is too old).
 if config_host.has_key('GDB')
   summary_info += {'gdb':             config_host['GDB']}
 endif
-- 
2.41.0


