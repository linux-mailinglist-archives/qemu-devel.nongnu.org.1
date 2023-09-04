Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE6791564
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:58:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6Ku-0005tA-Cm; Mon, 04 Sep 2023 05:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6Kp-0005sh-Md
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6Kl-0006m3-Kz
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693821446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lzk6qxqXuyTCnhITa3+2KXMwXqsSU8X9w2AQVIhzhrU=;
 b=iXbp1XNhTUaw3XOBapTrnIVMu1om5m2SUd8XUMyBzDHG2jlgW++5617PGHTjswQ0UdavbT
 fz7jthQAIS+YBetVApcJO2yACk3YDgyLenmsYpRUsTzeKl4YXUy/VV6axkNtHHcbmTydID
 iM2hAwgp4twQbzrfFded+V+46v2A70U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-JZG9Gv74M2iZMO77kEQBMw-1; Mon, 04 Sep 2023 05:57:24 -0400
X-MC-Unique: JZG9Gv74M2iZMO77kEQBMw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-402ccac9b1eso5588825e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 02:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821443; x=1694426243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lzk6qxqXuyTCnhITa3+2KXMwXqsSU8X9w2AQVIhzhrU=;
 b=JOpJQRff2shgJCzu7cOBeEuh71CQIwHMkXzpVaOdKGQXJdEa8cMXULj/GIG/TaTQcX
 s6jNA7UfpatUDNGRXUeCZZm53cZbRiYiyWe+dcX/GetXh0uT0VKH5brpvURrQbfvyfIM
 Lgwez3/aZLhkUnBLaiUfFi8cQOEBlpoYEhgFU+mi2LLWQ6AyouTMQ8qgcq9EeS2HbkB0
 5eK0ewH+deo8YJrjlejhZLik2zx790XbRFVMImBymJPik37Sq49+W8N9NWtrQgmw/TQy
 7JIj9XQisXnG9FcTOLXL6gbo948UwVdBSy2IiUzr1y2DdefLUDl0TfAcZ6zn2IF6acRy
 LLIQ==
X-Gm-Message-State: AOJu0YyhaoJkffijBGzV4G9j5S1//KDMYR7cn4RZRb/VeiSM7tM5LmLd
 ImwV8L/18Q1a5MG0ZMX+Xqw4aMuJjL8RdkCxf524cW1VEFyb9m7VbjR16uiDfSDLRj4NNBBDdc8
 9CHPuioxaSZPC7sXDCaw0yhpoeCHr/4WLN0ebY7fhev4dIkBtWBzHsEW/AbRn7iOby++IQw8Ytt
 o=
X-Received: by 2002:a05:600c:2058:b0:3fe:d7b9:8251 with SMTP id
 p24-20020a05600c205800b003fed7b98251mr6757144wmg.2.1693821442841; 
 Mon, 04 Sep 2023 02:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMwmQyRaE9nEqfrKoiDj/v61WfLG0z7ouGHYrEmGTKCnpVxf5vAP7ouYgPvAC+tu7jZmAFvw==
X-Received: by 2002:a05:600c:2058:b0:3fe:d7b9:8251 with SMTP id
 p24-20020a05600c205800b003fed7b98251mr6757120wmg.2.1693821442288; 
 Mon, 04 Sep 2023 02:57:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c294500b003fa96fe2bd9sm16627493wmd.22.2023.09.04.02.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 02:57:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, armbru@redhat.com, peter.maydell@linaro.org,
 berrange@redhat.com
Subject: [RFC PATCH 0/3] drop support for Python 3.7 and Debian 10
Date: Mon,  4 Sep 2023 11:57:17 +0200
Message-ID: <20230904095720.154738-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Debian 10 is not anymore a supported distro, since Debian 12 was
released on June 10, 2023, and it is also the last distro that
supports Python 3.7.  

Both Debian 10 and Python 3.7 required a substantial amount of
code in mkvenv.py, and John also mentioned that asyncio had changes
related to cancellation in Python 3.8.  To start the discussion, here
is a first sample of cleanups that are enabled by supporting only Python
3.8 and newer.

Paolo

Paolo Bonzini (3):
  Python: Drop support for Python 3.7
  mkvenv: assume presence of importlib.metadata
  Revert "mkvenv: work around broken pip installations on Debian 10"

 configure                |   8 +-
 python/Makefile          |   8 +-
 python/scripts/mkvenv.py | 272 +++++++--------------------------------
 python/setup.cfg         |  16 +--
 python/tests/minreqs.txt |   2 +-
 scripts/qapi/mypy.ini    |   2 +-
 6 files changed, 59 insertions(+), 249 deletions(-)

-- 
2.41.0


