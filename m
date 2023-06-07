Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFEC726506
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vNo-0005q1-IW; Wed, 07 Jun 2023 11:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vNm-0005pZ-Jr
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vNk-00039o-UM
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686152849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e7OL2BG2gwpSBuONRByrL5gsLUUpPzlTqboRLrbPwHo=;
 b=OOcFHiYyqVC3/TSjRMTcRap71QjYYr+o6I17EKUovHW4t7zXhoON4/v1FA1uQgEmwnIp1R
 Ev0keGo/OjobZsNY2iWuGYpeljrX3DKv83AL7/mUhbPoEJEaoiORJUCKt1pnRRUZHKbmq+
 gI9vfglnk0oU5z3Vl6eW4O2FVnBqrUo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-v5bFY--hNzWtzokhzjm-Cw-1; Wed, 07 Jun 2023 11:47:27 -0400
X-MC-Unique: v5bFY--hNzWtzokhzjm-Cw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-506b21104faso1081530a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152846; x=1688744846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e7OL2BG2gwpSBuONRByrL5gsLUUpPzlTqboRLrbPwHo=;
 b=I511whIAqUtB/1d99BMhmP18uX99yxA+CeoyglrHg4ymf3hpVVYRg3V4iZxfAdh6fg
 sGOZtud85RbAH7QKdB3JuVpgo8znsHmV/wim5eG2/7j9jeXqEn4qwBuqWdIJezV2H8L8
 73wAnbRCcSmACN2hz8RXPg39KHvdj7TopPvOj0X+OdRcgdVkdydYuDTF6SFl2VH3Oa1w
 xW7Pp9B8s7DSjPerE60F+qzUdDlBQHJtllo+65RXwQ012wJO4HwHSKTehhKM05udleUQ
 wnbF4WKAG7gGw7jVZicXs15Y24dxVt0wiinA+Amafrp/RetKkJCY2Di92vyBmZB8ssVK
 tyVw==
X-Gm-Message-State: AC+VfDzhhmfuwMIe47VDrIspYnqsmyg8F+KXnwfzVOEfBpYZnXIV6oqV
 o46cggXfhNAxUBEuFjyY0K4Ho4iM+0mX/KhcGZ2dLLav+mf/nFqj5fWMuvthhbQNod2FRUDaLPX
 7zlKPWXjatmeCshphI0iWXOfgwZiDkLP0Z4WdVIJRaGcTqurqA+apgcdjUd3lVSzwfROKVlA8W7
 8=
X-Received: by 2002:a17:907:1ca1:b0:971:1717:207b with SMTP id
 nb33-20020a1709071ca100b009711717207bmr6866228ejc.35.1686152846174; 
 Wed, 07 Jun 2023 08:47:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JnNAxHDfJao0zNMql6hZzlcrcrMv/dWW04foiy+saVIyc6vgqnwhlU0fsgkDNm5Scz/fWEA==
X-Received: by 2002:a17:907:1ca1:b0:971:1717:207b with SMTP id
 nb33-20020a1709071ca100b009711717207bmr6866212ejc.35.1686152845805; 
 Wed, 07 Jun 2023 08:47:25 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a170906970f00b00965b5540ad7sm7216869ejx.17.2023.06.07.08.47.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:47:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] SNAFU build system fixes for 2023-06-07
Date: Wed,  7 Jun 2023 17:47:21 +0200
Message-Id: <20230607154724.253659-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:

  Merge tag 'pull-target-arm-20230606' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-06-06 12:11:34 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 45904b56d5321be5f6e2c9e12bd143fb3b871ca8:

  tests: fp: remove unused submodules (2023-06-07 11:05:09 +0200)

----------------------------------------------------------------
Build system snafus.

----------------------------------------------------------------
Michal Privoznik (1):
      configure: check for $download value properly

Paolo Bonzini (2):
      meson: fix "static build" entry in summary
      tests: fp: remove unused submodules

 configure                     | 2 +-
 meson.build                   | 2 +-
 tests/fp/berkeley-softfloat-3 | 1 -
 tests/fp/berkeley-testfloat-3 | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)
 delete mode 160000 tests/fp/berkeley-softfloat-3
 delete mode 160000 tests/fp/berkeley-testfloat-3
-- 
2.40.1


