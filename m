Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C47482E4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0dm-0000jY-9Z; Wed, 05 Jul 2023 07:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH0dk-0000jE-H7
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH0dj-00075n-4C
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688556342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iFE/VLWDeD88Y2mZh0/SkWHYUkPtW6ze/pBDwBQhf1c=;
 b=TrSpyboFyeMYmmxxIKxWaKotf7jppyleRbXiDTekQr0DVUmKffVjVw+Vw2JFA+gzNTqAa8
 FbYsR+FHx1PNk1ArTzAbiBZ3qJ/Lvkak6rkqF/0mTZ77u3bs2cV5RF54O81hyXuqRYVp4m
 Z4nEYVyify4UMUUsIutzdV6UYUVmrf8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-o2TjGZv8PbC5EB7yPY8AUA-1; Wed, 05 Jul 2023 07:25:40 -0400
X-MC-Unique: o2TjGZv8PbC5EB7yPY8AUA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6fdbe2efdso7307631fa.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688556339; x=1691148339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iFE/VLWDeD88Y2mZh0/SkWHYUkPtW6ze/pBDwBQhf1c=;
 b=QSOj8dg2HvsPFo2uEvVHVJL+XRNW0PYdkvQS2VqLxIS2tRAnoDC5wdniRJnZKYkyeK
 NFM2WU+fre3h0jr8cJusnARjQ1lU4CplBLRv8XiH1ejh7s5PaGxd+ZbdY2zc784yLtWp
 Nxg25gYZ6rsFRH1gnyceg9uAzvidmXmSEp0QQyyIKTSbjR0uJAY43Gac72d8ee0dI0xi
 0sIeUp7P4X4FDsVEKTKdEbwvm/FnrQwfCEniSw1ZBWAnsdvQ1wGTaEcfafnzDpWUFC9v
 kQ2PtaDgmy1PS65oESNaPeCs8aOvCJ3yEZnRU90dG/vgLpvAnjifsLrJFd0ZEKbRRqBI
 5qlQ==
X-Gm-Message-State: ABy/qLav24im/GwRlKUAH9v1MORIWLpB6bV3wF3lXKBxathn234SqKfD
 HedOpHhuhvfuhHdHtKpJYCEfQ4vrjTBWt7vaWCqMc70OSLcqykEt513crlEj0RBHSLkcKASgzgZ
 6Uel0oAQImaC+eq6yDEgn1BJqFhr1hMLg4+XHeFKjrdk6FViDUHSbg2a52CPtVKRyhJYcY9yLev
 g=
X-Received: by 2002:a2e:b164:0:b0:2b6:d733:b580 with SMTP id
 a4-20020a2eb164000000b002b6d733b580mr8763401ljm.37.1688556338905; 
 Wed, 05 Jul 2023 04:25:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7OVchk+DLtqkqMYGNw+9hSwt5O4E1CprK4bSw31jo8HqgBRPf+gdj/Fsmo0D5CHIInlK/Jw==
X-Received: by 2002:a2e:b164:0:b0:2b6:d733:b580 with SMTP id
 a4-20020a2eb164000000b002b6d733b580mr8763386ljm.37.1688556338504; 
 Wed, 05 Jul 2023 04:25:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 gv18-20020a170906f11200b0098e0a937a6asm13838554ejb.69.2023.07.05.04.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:25:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 0/2] python: first step towards Python 3.12 support
Date: Wed,  5 Jul 2023 13:25:34 +0200
Message-ID: <20230705112536.54025-1-pbonzini@redhat.com>
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

The Python 3.12 situation is a mess, with both flake8 and pylint giving
false positives that do not happen with Python 3.11.  As a first step
towards understanding these issues, drop support for old linter versions
that do not work with it.  This at least makes it possible to install
easily the same versions of the linters on any version of Python, and
put the blame on the interpreter.

Paolo

Paolo Bonzini (2):
  python: work around mypy false positive
  python: bump minimum requirements so they are compatible with 3.12

 python/qemu/qmp/qmp_tui.py | 3 ++-
 python/setup.cfg           | 2 +-
 python/tests/minreqs.txt   | 9 ++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.41.0


