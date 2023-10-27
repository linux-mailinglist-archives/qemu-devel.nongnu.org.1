Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5B7D8D60
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 05:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwDPs-00088h-AB; Thu, 26 Oct 2023 23:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwDPq-00088U-G2
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwDPo-0001H1-Mb
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698376897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WL7y9VVmVOjnqu25lKh9wvmO+LjB5ffg876V7DcEi5o=;
 b=Zvr7qi/MBdhijGzck48+ED9RqFP6WdpUZQH9fmJeiDIOFqQZbKOklUHBaWEjH6d2ZgjFY8
 yfgHOflaiDAsBEtHhs5ficmtGdJ32dbTkyUKt4RuN9jrMC87dZQfecbJQ4UAABfkbgRmAX
 uUsApR595wSPKWNPNvS/mArrn9sS/dA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-40a5w2rmNcOSSjA3pmoOZw-1; Thu, 26 Oct 2023 23:21:36 -0400
X-MC-Unique: 40a5w2rmNcOSSjA3pmoOZw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cbe08af374so15084045ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 20:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698376895; x=1698981695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WL7y9VVmVOjnqu25lKh9wvmO+LjB5ffg876V7DcEi5o=;
 b=q7RtsbeXiYS4HYtwO6wdqbebm7dnVTWiGHLwNRvVc6oOxnasbjjT1m4e4yMG2b4MYG
 /u8GZH/b7M8hFx1rrTltvhPHCmvzkurdJiIEg27BNI1XXNNxvGtKMd5PVg8nLP3vLxiX
 U+Bf2But8S7K/vQmO6i+hx5oMC9QgLkOwKdwdwcRYXyyubQsB3/cP2GwVkC7Kwdx3YZf
 bAPP0eoFQ6bzuT30zO9c2Wbt8Q1y72AzaMNITn9DaNX5qhPodoJcKn4RxLDVvvaOx0SV
 Vquqmpnneob9L46q5gVYYvOKls7SIZJZiLU81usZz4rmBI6oGBKgqK4NU+UxOYz78wn0
 avxA==
X-Gm-Message-State: AOJu0YxfT8fa5ctPB/u0Wznb2TsjlU0QUW/drY4a7sjhm1voC7djbQes
 W+8VSYOz6qanpT7DRG+IVoBFkNp0nzgP0mq4LHs6pR3P8UX8/OBSvzDjpkLju8tscKi04NGhkaE
 1jhEL4AEMeyXcQ1o=
X-Received: by 2002:a17:902:da84:b0:1c9:ccbc:4ca1 with SMTP id
 j4-20020a170902da8400b001c9ccbc4ca1mr1472355plx.46.1698376895020; 
 Thu, 26 Oct 2023 20:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8keBr2hfKFbaOPBFmrR0/HQgRtQ9CtZsEdt4xGSFoQ0DA+V9mwOeL2CQFC0MKgnWMwJwCMw==
X-Received: by 2002:a17:902:da84:b0:1c9:ccbc:4ca1 with SMTP id
 j4-20020a170902da8400b001c9ccbc4ca1mr1472339plx.46.1698376894607; 
 Thu, 26 Oct 2023 20:21:34 -0700 (PDT)
Received: from localhost.localdomain ([115.96.30.106])
 by smtp.googlemail.com with ESMTPSA id
 j6-20020a170902da8600b001cc131c65besm418431plx.168.2023.10.26.20.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 20:21:34 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, jsnow@redhat.com, jusual@redhat.com,
 imammedo@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 crosa@redhat.com, philmd@linaro.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 0/2] Some biosbits avocado test fixes
Date: Fri, 27 Oct 2023 08:51:17 +0530
Message-ID: <20231027032120.6012-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

Included are couple of bios bits test fixes.
32-bit SMBIOS entry point is enforced.
Console logging is enabled.

I have tested these changes in the CI pipeline here and the test seems
to pass:

https://gitlab.com/anisinha/qemu/-/jobs/5380627517
Log:

https://cdn.artifacts.gitlab-static.net/8a/b0/8ab0aa629e9c43a80356e27a440985f41da9ad10b120a410d9f070bed092fea6/2023_10_26/5380627517/5862985776/job.log?response-content-type=text%2Fplain%3B%20charset%3Dutf-8&response-content-disposition=inline&Expires=1698376660&KeyName=gprd-artifacts-cdn&Signature=ln7fYsTb8t6ch0Trsa7SHAN01QY=

CC: jsnow@redhat.com
CC: jusual@redhat.com
CC: imammedo@redhat.com
CC: mst@redhat.com
CC: qemu-devel@nongnu.org
CC: crosa@redhat.com
CC: philmd@linaro.org
CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
CC: Beraldo Leal <bleal@redhat.com>
 
Ani Sinha (2):
  acpi/tests/avocado/bits: enforce 32-bit SMBIOS entry point
  acpi/tests/avocado/bits: enable console logging from bits VM

 tests/avocado/acpi-bits.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.42.0


