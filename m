Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E8706FD6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLE9-0007VP-Gc; Wed, 17 May 2023 13:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDr-0007Jo-KN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDq-0004C6-4t
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FayYwThs25Dl8i8SOz3tLnsDO2kYo9i3jD8JBO/RWl4=;
 b=MKVBbcAZXTsx9A0415mivlg2b1JowosxRDmChXLwrnzcVbo6/xXFR9lMR3jixurnk2We8n
 RQ+KL3E3y7BqBdWak8rp/OWeoHzmVIWRhXLp1E02ihqoT0/OZ1dgverCHR+Iukli2W78k+
 c49UfkR/ebK61sltXmJpEzth1kf3ph0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-DN3BRwohNNq-jvmNhXWF1A-1; Wed, 17 May 2023 13:45:56 -0400
X-MC-Unique: DN3BRwohNNq-jvmNhXWF1A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f41ce0a69fso4759415e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345554; x=1686937554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FayYwThs25Dl8i8SOz3tLnsDO2kYo9i3jD8JBO/RWl4=;
 b=CAQZP4HoPJSpzDMIt4EfwVD7AGCNCvZGPkmDb2k8scXh6ftiG+teXdETWyy4dPStOQ
 BvqIB9b/uxRp0L9EA9I/DVJAB9FnD9DE5IOQdT9QPpe+FwPLbcBaC5J+fgFyRpCqY9uJ
 yaOFnLqNLPWvHXzVVPmE/SKIUIjXU8aIJQBJJEBPl3pcZZ1vCaVhqTMaElwIzkJfbDne
 zzA18yBPs72g3tVJWUDmFBnDdkRrVJ+lfM8EOihCfTPx+xBxy6aTbnXHPZ2r+CVUXgzu
 oc7IZLaHvkC5wAkUDeA/i2demJTgnI723GQNwtR7JPMSkYVryhkeSVFUjMptEZkkaqSw
 oMjA==
X-Gm-Message-State: AC+VfDwd0vDc+VhasUL4LAYz3NTwqWRAy+nT3l00eiHwKP4ByPEDviOJ
 Tkl8VCsDkAsJJmyjs1spCtzWUCBL8eUHSM9bHwFHw/zRokiippy0sFZsXdr0sI7huRxS3tg1QGr
 aG8uHIMtt1cJ1Xx3nxxloau3/WznEPvoPTGDosY63SjnPiIzB+qZhao33qQz/fl+ocGn0QI23KH
 0=
X-Received: by 2002:a7b:c5d6:0:b0:3f0:b1c9:25d4 with SMTP id
 n22-20020a7bc5d6000000b003f0b1c925d4mr27646337wmk.21.1684345554710; 
 Wed, 17 May 2023 10:45:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4f23DsU4WYnAYiEiJH/2HrQEGfxsAxP1nFunzxXaBA/7OBUFF95QkowQQgXVMgZ9KsUngIcA==
X-Received: by 2002:a7b:c5d6:0:b0:3f0:b1c9:25d4 with SMTP id
 n22-20020a7bc5d6000000b003f0b1c925d4mr27646324wmk.21.1684345554387; 
 Wed, 17 May 2023 10:45:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a05600c21c700b003f4e3ed98ffsm2903759wmj.35.2023.05.17.10.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 19/68] python: update pylint configuration
Date: Wed, 17 May 2023 19:44:31 +0200
Message-Id: <20230517174520.887405-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: John Snow <jsnow@redhat.com>

Pylint 2.17.x decided that SocketAddrT was a bad name for a Type Alias for some
reason. Sure, fine, whatever.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230511035435.734312-3-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/setup.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/setup.cfg b/python/setup.cfg
index 9e923d97628f..3f36502954e4 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -132,6 +132,7 @@ good-names=i,
            fd,  # fd = os.open(...)
            c,   # for c in string: ...
            T,   # for TypeVars. See pylint#3401
+           SocketAddrT,  # Not sure why this is invalid.
 
 [pylint.similarities]
 # Ignore imports when computing similarities.
-- 
2.40.1


