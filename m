Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1474A710A17
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28DF-0007l9-UO; Thu, 25 May 2023 06:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DD-0007kZ-Ur
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DC-0000p4-HA
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685010528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j2jv4/+2CoMsv25DiSvUjw5y6y7kU6Eke+pCEaI9A+w=;
 b=YS0Gmxp88ubom54jXZw24MJDHQR0jNSGWnxR0rZN0V220Qs0pkKcARJ8Jm6Hml7tovE3bO
 mB0RF0ohP0lHK7APzz5wMCgxRTVwc8dJPbTh5qPKxP5k69AHBA11fFWFDzQZOXToIG710k
 SYmbxSf9/yPupVuoZ/kWEvxxydFD0OQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-BB1URgfRM1WfYD9BGsH1nA-1; Thu, 25 May 2023 06:28:47 -0400
X-MC-Unique: BB1URgfRM1WfYD9BGsH1nA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9715654aba1so52652766b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685010526; x=1687602526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j2jv4/+2CoMsv25DiSvUjw5y6y7kU6Eke+pCEaI9A+w=;
 b=S1hnTRK87vzN2P+9kuMoWSKdY+XErhSFHeC80nwzGRh6CmB2TJAu5t+y/2s0iJosv+
 B9KdH6MR19X0i2tIZ3L9FrH81kPWkNxLsrWHyOr7mQBjmpqYHefBhSKEEM3mID7PUQV1
 QwTNKBxj+kGExTjoFFMkHaKGzW7czWeNvvhTdmdm3cL2ESPc8fxgrpREbCgqlJ7l59WG
 qMuYpVc4zu4F14vTVoLuPuDqBK8qrmMa5b6A9tsEwOpvWpfMiJBIhUCK0tm/KI+CiMRJ
 jL97do+G8e2xg6Cz7hHLBH30Ahtv0WHLZ1kjwAWhHPEoKCHfC/D547cyl1pfL2dsHtJ1
 rCGg==
X-Gm-Message-State: AC+VfDzr6A53xZyy/z6xiavvIPkHaYIxmMkApGB780fFRdrh3vMS6cyB
 deYs4FhMJVPybmTexe1K78RqD17XV5pP8nrTXzjgqIhacjAAGod/Gj/2cFS0BnuSL0FPldH2xBJ
 pKoRiKrdt6fBJ3IJlZNeAwSQEqYuNEKwR7vxQoS0wEsuNIDlDHOBGhzQe+ZKzda5drPIkOkHE1U
 k=
X-Received: by 2002:a17:907:7d86:b0:96f:8afc:b310 with SMTP id
 oz6-20020a1709077d8600b0096f8afcb310mr1023399ejc.3.1685010526121; 
 Thu, 25 May 2023 03:28:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fH4WuyLnHZW+qHr5CCPKd6Dz1YQmfkupJC/Et5Em4suBlU3O/9Daj7GLxyjXemmQq5embNg==
X-Received: by 2002:a17:907:7d86:b0:96f:8afc:b310 with SMTP id
 oz6-20020a1709077d8600b0096f8afcb310mr1023382ejc.3.1685010525737; 
 Thu, 25 May 2023 03:28:45 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 gr4-20020a170906e2c400b009660449b9a3sm659253ejb.25.2023.05.25.03.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 03:28:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 0/3] makefile fixes/cleanups
Date: Thu, 25 May 2023 12:28:41 +0200
Message-Id: <20230525102844.209240-1-pbonzini@redhat.com>
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

A few fixes for things that have gotten inconsistent or redundant
over many changes to Makefile.

Paolo

Paolo Bonzini (3):
  tests/docker: simplify HOST_ARCH definition
  tests/vm: fix and simplify HOST_ARCH definition
  Makefile: remove $(TESTS_PYTHON)

 tests/Makefile.include        | 8 +++-----
 tests/docker/Makefile.include | 2 +-
 tests/vm/Makefile.include     | 7 +++----
 3 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.40.1


