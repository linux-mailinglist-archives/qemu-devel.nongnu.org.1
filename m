Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8F7CD6A7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:34:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vu-00032R-VH; Wed, 18 Oct 2023 04:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vD-0002F5-Tl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vC-0003iU-FS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTWaNH6l64cXT7uyRdZIns6tQsnLs5740jLL/+6gUsg=;
 b=Mwl1xyOSMpHkVCM04ASsoLNLSFKgMFZnVgDoAoeaDPbJMu/YQuyqvtGKXcU8CtVQrly638
 H1Az26TFPq1FCvS8g5utFZl5WDehfn5SKdhWWnggYK1g32kpaUvCjYgrZbucLjedos9XD8
 ZPEHE3mejNmRk882+5aKJizkWA41wMQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Yc4Dfm8GMB6kMfn3KAO0vw-1; Wed, 18 Oct 2023 04:28:52 -0400
X-MC-Unique: Yc4Dfm8GMB6kMfn3KAO0vw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53e2acda9d6so4444189a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617730; x=1698222530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTWaNH6l64cXT7uyRdZIns6tQsnLs5740jLL/+6gUsg=;
 b=dORM8swGPmtdmCt/ZR4NIRPsyReiLk+l1WXovcj4meVg50z77aTj7z6s9pHw4mN3jS
 G6BAFTErOO9J5JGrn0ZoToIAQ8CTXQAI79WGKZBTYj5GDPw4YPutU2MvQka5VYK2L641
 oa2VbdfoVGJ9T2YM/niMVolIsIaoIxvPOxcAg48c57DH+fx+rbzQHjxGmAUKA4unsMlj
 5bxFUuQ7l++0kygLWVuxi5bdoOWHovJYdaE70jjXFWGBmeGUod2LYT6I+DHKhFpIWFUL
 5X7ujnPWwt0hClg3VeqBzg7EEOz7MOkmB331CLnXr0C8twxRQ42v2/xKuFKP9Kf22PyH
 Q15g==
X-Gm-Message-State: AOJu0Yy057KY/bUSt/Pw1qHwg0F79GOTKScehkDQ9DQd2tQTlmjR7BDt
 xMx9P1XT3SjZ57sZkRuidqWaVI0Tn1z24Mo2neIe1HzThh1DfaJRdJwng1rDmHr6gz/8c5oFldZ
 hq3L221oodmgYpO3P/zXvBMWvmK6rgW2VgEi9ivdUdUwVF52qBUwcKPZ4HBwBA25qsHtU+hlZZq
 o=
X-Received: by 2002:a05:6402:51d4:b0:53d:eca8:8775 with SMTP id
 r20-20020a05640251d400b0053deca88775mr3721521edd.26.1697617730494; 
 Wed, 18 Oct 2023 01:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhxn+bTkMYbGUa3sJBqoTRRh7qE3Agy7oMBZYYwRtmTLOQI2smdb+ZgN4Sc4XE1rpWCRD++w==
X-Received: by 2002:a05:6402:51d4:b0:53d:eca8:8775 with SMTP id
 r20-20020a05640251d400b0053deca88775mr3721507edd.26.1697617730172; 
 Wed, 18 Oct 2023 01:28:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 cw14-20020a056402228e00b0053e7809615esm2382600edb.80.2023.10.18.01.28.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] meson: add a note on why we use config_host for program
 paths
Date: Wed, 18 Oct 2023 10:27:51 +0200
Message-ID: <20231018082752.322306-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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
index 2bda62a2b1b..0182622aede 100644
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


