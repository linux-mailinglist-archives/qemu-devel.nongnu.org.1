Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB967081B6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd1z-0000Mk-9M; Thu, 18 May 2023 08:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzd1w-0000JN-9y
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzd1u-00072U-Qu
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684414010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8jahpUAW2l7jGm8SiE5gBkr3Qdxp2IrIaUIMnvLTGig=;
 b=HHZ7ZlLo0jyaxXPOIJo63yxgWCNeZ2b3RIXuUkLRjkQi7MLU+fwrhfNmx1r6irnOizhf4n
 KTz7H06IkOree4uaVPIVZG8nldZIz/3ylalEKSSOiEKiT0kjzl3LQT7JdcQMWhEd6mVOlT
 TI/dJW/pHW76E+is3xamPSIV5b7iFSo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-3-UJLvkANIuI4xKurDIwUg-1; Thu, 18 May 2023 08:46:49 -0400
X-MC-Unique: 3-UJLvkANIuI4xKurDIwUg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9662fbb79b3so219860866b.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414007; x=1687006007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jahpUAW2l7jGm8SiE5gBkr3Qdxp2IrIaUIMnvLTGig=;
 b=VvnRkiizjwBfBdAMEvnGPPE8WD1Ml6rCJVxJd4ecJ1LnpeMdVPUN+25THv3I3jG5e7
 +b+fiyudLEwFbUOnVF0kFDtHhx6s9B58Ts1Z9nwrK7xwz5FiacdET1gn3Ve7CFuUPgiw
 ceJALXFVnlQRs7ol8qfeD6r9ZFG+HqvtpNTucBNKl3QDhh6ReI/l+ub78biuk5ABgTyj
 thvWFLAuN1KD0SIsAERtKm4JNByP6Q0SOH5t7GBVC2AWvbLxXhmEkzfNPuY21AfukMPI
 0ElWtXjPmG4Sg1+zauuNXvVjyyUSVcMrozHbQ2Vcn6THTWfvAQN7QJ8FFbYZDePSz8tA
 x+Tw==
X-Gm-Message-State: AC+VfDy3vil7FB5j/F2fLvhZZGWXB8nKF6IMQylGrFuzvQ7gtVV26/pm
 dUOQyOugPGAmEnanFr3oLm8Jb6z1gTvhg1S5+goxyVJynYYV29eICrGQIJ/dMrw3hMJBNrvA7qm
 5DeHbjYV0n+b95oCnji66Cvhps0aTKCFe7eIfuouUounz+Pg+3BmE9u37kgv3ey6GCreHog0E2u
 I=
X-Received: by 2002:a17:907:8694:b0:96a:1c2a:5a38 with SMTP id
 qa20-20020a170907869400b0096a1c2a5a38mr29004475ejc.11.1684414007448; 
 Thu, 18 May 2023 05:46:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CAk4mOVgfizu4pD6RshIs8a+aaDd5S4BHXu2jKHuV0Ci6QrdXcPRYU0G9pmxN76eguaTA2Q==
X-Received: by 2002:a17:907:8694:b0:96a:1c2a:5a38 with SMTP id
 qa20-20020a170907869400b0096a1c2a5a38mr29004447ejc.11.1684414007024; 
 Thu, 18 May 2023 05:46:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 jt4-20020a170906ca0400b0094ee99eeb01sm935220ejb.150.2023.05.18.05.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:46:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 0/2] meson: use subprojects for bundled projects
Date: Thu, 18 May 2023 14:46:43 +0200
Message-Id: <20230518124645.1011316-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU bundles a copy of dtc and keycodemapdb.  They both support meson,
so run their build system via subproject() instead of hardcoding their
contents.

Paolo

Paolo Bonzini (2):
  meson: use subproject for internal libfdt
  meson: use subproject for keycodemapdb

 .gitmodules                      |  8 +++---
 configure                        |  6 ++---
 meson.build                      | 44 +++++++++++---------------------
 scripts/archive-source.sh        |  2 +-
 dtc => subprojects/dtc           |  0
 {ui => subprojects}/keycodemapdb |  0
 ui/meson.build                   |  6 +++--
 7 files changed, 27 insertions(+), 39 deletions(-)
 rename dtc => subprojects/dtc (100%)
 rename {ui => subprojects}/keycodemapdb (100%)

-- 
2.40.1


