Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B467CD679
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:30:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uZ-0000Xu-Te; Wed, 18 Oct 2023 04:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uY-0000Vm-7a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uV-0003ZZ-Gq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WyiZ7aHaRsiX0EskWGit/toNA+1fG2kq79A9AfD8vZE=;
 b=gftmhQC/H7W+0SGAaPsXioGHxb/N8JnVWIkajjiTZNhCIa7RI8objCA0CrPSjtOGAyVQGf
 2nZkzkB/xgdpSqRMgmBX+C/YPQdbmF7uuz+kCWC6adiFIFp7CxY1cmQ/Iu7+XyMzWRMKVJ
 JZVecQbp7o0vZsSfdReR6vG8YizwDTg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-46BV6FnaMraPK6J4BwsEEg-1; Wed, 18 Oct 2023 04:28:09 -0400
X-MC-Unique: 46BV6FnaMraPK6J4BwsEEg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso4971674a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617687; x=1698222487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WyiZ7aHaRsiX0EskWGit/toNA+1fG2kq79A9AfD8vZE=;
 b=PsQ41U99SGl3WheJUmgdbWebWG3uIax2iEb/XfgiSowOZOqg7QsP3YMJ+YpmNHDN/B
 umPil2t5xEkaosnWVpRS4rW/wbu5Qp8Y+b3qgrhz8IHsuO7Zz6eM6wZiqDCuC7auBcLx
 L/lpc52FYNcdONAIB8OAQ2k2hf1sOFyyZsw6vb9uqwtYgPKUWIBqbvcMYnDLRC5vAHPF
 hXPVm9RvTKUL4vd+t+2Dhi2AQfDEFyZBeg2vTZCyLMMXdUkWIw9n7AJF2nXY45ODKFoM
 njRQW1BIiHW3uhN30W6tJq/EhurcsQoJoVyREAVmS1UTH2ICWTnX97H5HNEfGg0gRtW6
 XJ0A==
X-Gm-Message-State: AOJu0YzX2+03Y9B5oHc40n1YqJbtH4j8FY9xGv5+m04V/UXXg61TGO5M
 iOwR2l8zGrZ7QSfHUyQrj6NSt9LY3cAz6/vy2SDjSNBVVp7Y6E0sGXscNG1OgGepiNlykqzDPSn
 5M2idlXv8WUoaDoG0aQo4UVqIFzGHEays1tA8PgiSp1dNNNxaOS3tngg3Ue7YfOX9+CtW/zjS3p
 I=
X-Received: by 2002:a50:d08f:0:b0:525:6c74:5e58 with SMTP id
 v15-20020a50d08f000000b005256c745e58mr3791422edd.23.1697617687697; 
 Wed, 18 Oct 2023 01:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdQypQfCBsZXbkJQLSio2YNmuYNcIAOXAgZz89bJ4wrmdOtZo4E/Bq9O+R1aTBcM4m9dO8Kw==
X-Received: by 2002:a50:d08f:0:b0:525:6c74:5e58 with SMTP id
 v15-20020a50d08f000000b005256c745e58mr3791414edd.23.1697617687443; 
 Wed, 18 Oct 2023 01:28:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a50f60e000000b0053dff5568acsm2470800edn.58.2023.10.18.01.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/32] scripts: Mark feature_to_c.py as non-executable to fix a
 build issue
Date: Wed, 18 Oct 2023 10:27:27 +0200
Message-ID: <20231018082752.322306-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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

From: Thomas Huth <thuth@redhat.com>

Meson tries to run scripts via the shebang line if they files are
marked as executable. If "python3" is not in the $PATH, or if it
is a version that is too old, then the script execution fails.
We should make sure to run scripts via the python3 interpreter
that is used for Meson itself. For this, the files need to be marked
as non-executable, then meson will use the python3 binary that has
been used to run itself.

Fixes: 956af7daad ("gdbstub: Introduce GDBFeature structure")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231016094917.19044-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/feature_to_c.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 scripts/feature_to_c.py

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
old mode 100755
new mode 100644
-- 
2.41.0


