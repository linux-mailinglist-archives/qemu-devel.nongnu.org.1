Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A900C78C040
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau6n-0002gr-CF; Tue, 29 Aug 2023 04:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6c-0002cj-W7
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6W-0008PW-Ek
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BpHGfXoCf1gzK0YzpOGa/JqmANdoCIZ7Kw/+Y+kIAqk=;
 b=NVftN0YrjA/mukwbj/ISu3jOga+J3RNxlaRad3TAh2j7ro5vYz414GEU4RA+W9upYKkg49
 N5MRJ1UUnO4dLYGD6osmk63nb6dBJF/ET2SC/cO4APnBBMP+LZvvNfkWXJnCLzp1lYYqoM
 zmcx1VKa26pjI0YDZylQXEWVXJL251U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-mzbrkux8P8uhiMGbjjGNAQ-1; Tue, 29 Aug 2023 04:29:35 -0400
X-MC-Unique: mzbrkux8P8uhiMGbjjGNAQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c7bfba03dso2702227f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297773; x=1693902573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BpHGfXoCf1gzK0YzpOGa/JqmANdoCIZ7Kw/+Y+kIAqk=;
 b=ericDSvVUdBCx6wUWcvAr+PSp6oGX3RQ4dMUwpnVzHrJERlFp0Nn7QLyNYeP6Kioh0
 Z6wTjWmdjleOxnA7XxDRzFbfgMXi5ihNT1WoLYBgEwQwbJGEu4+tBhLzOVqExPW/OTDA
 TNwpgOG4SlbELKs2Ucpc+/3Lnbz0TO7lqZHMF++KEICeQtCD6M7O1HcDOcLpwJJlvucn
 mqSGIDFP6fDp7DQegHz9FN2wp/892Yja70O4+q4cDCFkxtYAbVTzijVMan88OTVpcvIR
 qtZolreQuHHGVsaX3kIFaGBnCDRHHd+E7D644JM1TjCZ+MvbPFpCLIHcCDnugTQeYggV
 aOJQ==
X-Gm-Message-State: AOJu0YzZtxGGMgFO1a9Rn4h4Qz24pyn8uYF9znU9B6sJ6ClU3bhvIP2x
 lzdBaY83qi66OgUi2Lx7YfM3INKF7Bsf6PZMTkp0o/UQ0ItNN9l8ObMa2u5l9u9QsnNWoYOCN/Y
 XE3ykr5WVp8EnpLLR2ck6phZKXmNgoU2NUKjktilRwC1hNXTpxQXUT1wIqBnzEyicYO/LpkF9PE
 c=
X-Received: by 2002:a05:6000:1f91:b0:31d:74f8:fae with SMTP id
 bw17-20020a0560001f9100b0031d74f80faemr4368769wrb.71.1693297773403; 
 Tue, 29 Aug 2023 01:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvFLLhI5g9Fe9LWnAr/hiTG6gi5gfQPkTF827zV8DwTHdblA0hbnXodNEx0Wg/pBZsscvRPg==
X-Received: by 2002:a05:6000:1f91:b0:31d:74f8:fae with SMTP id
 bw17-20020a0560001f9100b0031d74f80faemr4368758wrb.71.1693297772977; 
 Tue, 29 Aug 2023 01:29:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b003197869bcd7sm13207024wrw.13.2023.08.29.01.29.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] configure cleanups for QEMU 8.2
Date: Tue, 29 Aug 2023 10:29:21 +0200
Message-ID: <20230829082931.67601-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This includes a few more patches cleaning up the configure/meson
separation.  The highlights are fixing --host-cc, removing the
last traces of compiler detection from config-host.mak, and
dropping the useless pc-bios/Makefile.

Paolo Bonzini (10):
  meson: do not unnecessarily use cmake for dependencies
  meson: update unsupported host/CPU messages
  configure: remove HOST_CC
  configure: create native file with contents of $host_cc
  meson: compile bundled device trees
  contrib/plugins: use an independent makefile
  meson: do not use config_host to pick tap implementations
  configure, meson: move simple OS definitions to meson
  configure: remove $linux and $mingw32 variables
  configure: move --enable-debug-tcg to meson

 configure                                 | 65 +++++++++--------------
 contrib/plugins/Makefile                  | 18 +++----
 hw/9pfs/meson.build                       |  4 +-
 meson.build                               | 43 ++++++++-------
 meson_options.txt                         |  2 +
 net/meson.build                           | 18 ++++---
 pc-bios/Makefile                          | 19 -------
 pc-bios/meson.build                       | 25 +++++++--
 scripts/meson-buildoptions.sh             |  3 ++
 tests/migration/meson.build               |  2 +-
 tests/qtest/meson.build                   |  2 +-
 tests/tcg/tricore/Makefile.softmmu-target |  2 +-
 12 files changed, 101 insertions(+), 102 deletions(-)
 delete mode 100644 pc-bios/Makefile

-- 
2.41.0


