Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B44C7745D5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRif-0005Bp-Gl; Tue, 08 Aug 2023 14:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTRiU-0005Ai-0I
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTRiR-000472-4j
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691520357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dNWdZERB9UQ+bEzWpLDcsnDK9Q6c48Q5a3Qm7+lcjsQ=;
 b=SLkUeGGREtgZ4ysJ4baCUlHdqFCMZSBIseZK/GHjIhkm7QNbhTp36GJ1fYSEE8V6XUhCi2
 bciNz3Tzp5mlovdRSgxWZsV7rpPOu7+v9+Xt/JqjEjdqgTRZiXrVYZLtR2fLoSsokgkauZ
 Q/0LEXUCvdN/ffa2PVUAG/dh5bdbr60=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-ysYUQCfwMKOWn3vSbO4zjQ-1; Tue, 08 Aug 2023 14:45:55 -0400
X-MC-Unique: ysYUQCfwMKOWn3vSbO4zjQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b8405aace3so31043401fa.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691520353; x=1692125153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNWdZERB9UQ+bEzWpLDcsnDK9Q6c48Q5a3Qm7+lcjsQ=;
 b=gDEOlTD7q8KoT4k/nNZKQngaq04oxgRbxWGh4UUtz5KGthMlQfT0LxJNnWApZ5Ozod
 693U4kHXtrOU3NO3egRhUvVs6bsDGQYLhXY+tibru/C4Y4Lz2rq3No+ScbrsFbIVPhmI
 xhx0T0VYZUUlD3nXM22H+rBzSh6GC2701D2JpSi502y62H12r6X4pQYBw43BqElLSUla
 ge0qGuunhxoFTMRbmIFzhyPj8KkNOqsKIUzcOdqEyByD+DwzPzwV6+S/JvCYLPY5DTaV
 dmhVFJhbuhzK7T3nsbjlGl1Ri1cgm9CQlBJM/SKymzLX13V6tCWDFafbpkX6GsJ/u7HC
 noLA==
X-Gm-Message-State: AOJu0YyDv3tupMhMrSnXeZ+RDiJiHZGDhdYN3j7EZ0EB/J3+w/XqN1aV
 GHYgF6iRl6dxrLlLykKR6p5WwFdJMPUWjr+yadUsd8zbDf9IIkujVyC2ZI3VgsSNiMa8auJwbPO
 wQLax/pChhdh+y4we3iEA85fuQubbIm4zni5tZZUojH27VwFxMy6NRBKegSPnWNfHujqdovqfag
 E=
X-Received: by 2002:a2e:98d9:0:b0:2b6:e2aa:8fc2 with SMTP id
 s25-20020a2e98d9000000b002b6e2aa8fc2mr229592ljj.46.1691520353084; 
 Tue, 08 Aug 2023 11:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBlqXCoTNRfw6ABquKqUC+lHtv69iUDsgswQy9/w3kLPUK0Gvwibenw4SH0ULtv5cMKTNzOg==
X-Received: by 2002:a2e:98d9:0:b0:2b6:e2aa:8fc2 with SMTP id
 s25-20020a2e98d9000000b002b6e2aa8fc2mr229581ljj.46.1691520352650; 
 Tue, 08 Aug 2023 11:45:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l26-20020a1c791a000000b003fe4548188bsm14472877wme.48.2023.08.08.11.45.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 11:45:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] fix ppc64le build, fully kill alpha and s390 linux-user
Date: Tue,  8 Aug 2023 20:45:48 +0200
Message-ID: <20230808184551.684522-1-pbonzini@redhat.com>
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

The following changes since commit 9400601a689a128c25fa9c21e932562e0eeb7a26:

  Merge tag 'pull-tcg-20230806-3' of https://gitlab.com/rth7680/qemu into staging (2023-08-06 16:47:48 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 971fac2731e60f2143f35648b14fd2f1b5b2c1af:

  configure: unify case statements for CPU canonicalization (2023-08-08 20:44:11 +0200)

----------------------------------------------------------------
* cleanup architecture canonicalization once and for all

----------------------------------------------------------------
Paolo Bonzini (3):
      configure: fix detection for x32 linux-user
      linux-user: cleanup unused linux-user/include/host directories
      configure: unify case statements for CPU canonicalization

 configure                                   | 173 ++++++++++++++++------------
 linux-user/include/host/alpha/host-signal.h |  55 ---------
 linux-user/include/host/s390/host-signal.h  | 138 ----------------------
 linux-user/include/host/s390x/host-signal.h | 139 +++++++++++++++++++++-
 linux-user/include/host/x32/host-signal.h   |   1 -
 5 files changed, 240 insertions(+), 266 deletions(-)
 delete mode 100644 linux-user/include/host/alpha/host-signal.h
 delete mode 100644 linux-user/include/host/s390/host-signal.h
 delete mode 100644 linux-user/include/host/x32/host-signal.h
-- 
2.41.0


