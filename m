Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E181BD28
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:24:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMia-0007X9-08; Thu, 21 Dec 2023 12:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiU-0007WI-FJ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiT-0004T3-1F
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cw7+dRbN4+JtYElIwq4s0tub6i06l9lq5JRTHfcReyg=;
 b=X3tE/L58b7hElqBUWk4X3Ba7FF9Z7UaR09fWHFZyhCL9191OWU7G+DLYyeFCIKbujaeNjT
 n4BZvyfXArXo2AJPaGyuo6CaUgvmWiCdLe2ISacl2gwAid1lBrCqlTDvDUstsrfu9j5yet
 e94rCKEr2XIgs44QW31r9+KOlqLrczI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-ANH_Ne4_Mf2BgYMD8cPjxQ-1; Thu, 21 Dec 2023 12:20:10 -0500
X-MC-Unique: ANH_Ne4_Mf2BgYMD8cPjxQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40c495a9c7cso7814335e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179208; x=1703784008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cw7+dRbN4+JtYElIwq4s0tub6i06l9lq5JRTHfcReyg=;
 b=QzugXZdDA1//dld0orfDvVDVkGXn0pZ2B8n4rsGIDmwUvQpUC2mGBP/YBnucUcjQF0
 iJInuaaQWccHhiL0Po3tyOx8hCqASsLKxggQvVxnVw1buwo3foQnJPE+LOISWBFGu17j
 s0V8XHbMK/wyXqGsZ9V7EjxBwGCypwuK/J8d41xyuHaLfUu7OimucZrwMIyNMczNAVQb
 XAfGDT2EosUcMTKd3qv3KphSnnvVJ/gc9DmFm83De48RVD+8Bc6ePZ2UG4/GgGg1jNTv
 MbVCI95ROspiflbr2OZ0rgVIemlxFFPBkO9d/PArC7ltv/hCbu6/mGjttFP+EW/Uq+C0
 akEA==
X-Gm-Message-State: AOJu0YyXtLv79AC87kzvQN3GZoL+C/u0dkZsU8n0KVxIaNMfMRvc9S8S
 SbNcOu0MWyLRsZF9dXzPOggBzaZIMWgaq7zMi2tlvZghHEE0ArrYkJfWUQ0aueYjCGiq/RP34Dh
 9QX6izvYHbo84OvCqvPsUPYAZvqYlMuEw0LidKP+uo8WFn7+smxJcnTNRIuQ54Uyj6akb8yux+W
 2i0hF3epw=
X-Received: by 2002:a05:600c:1c06:b0:40c:2cc5:4541 with SMTP id
 j6-20020a05600c1c0600b0040c2cc54541mr39746wms.39.1703179208341; 
 Thu, 21 Dec 2023 09:20:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXdf2aVsrhHizYJoSs1xE2QKtSHXHp+yZzu9TJtHcL6INqqcpw/mTm4rmYiYStx6+omo/Pdg==
X-Received: by 2002:a05:600c:1c06:b0:40c:2cc5:4541 with SMTP id
 j6-20020a05600c1c0600b0040c2cc54541mr39738wms.39.1703179207940; 
 Thu, 21 Dec 2023 09:20:07 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05600c4e8c00b0040d3db8186fsm3023463wmq.5.2023.12.21.09.20.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/21] Makefile: clean qemu-iotests output
Date: Thu, 21 Dec 2023 18:19:41 +0100
Message-ID: <20231221171958.59350-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 1 +
 configure | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 676a4a54f48..8f369903356 100644
--- a/Makefile
+++ b/Makefile
@@ -202,6 +202,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		-exec rm {} +
 	rm -f TAGS cscope.* *~ */*~
+	@$(MAKE) -Ctests/qemu-iotests clean
 
 VERSION = $(shell cat $(SRC_PATH)/VERSION)
 
diff --git a/configure b/configure
index bdda912f362..6ea8f53310e 100755
--- a/configure
+++ b/configure
@@ -1559,7 +1559,7 @@ LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS pc-bios/vof/Makefile"
 LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/avocado tests/data"
-LINKS="$LINKS tests/qemu-iotests/check"
+LINKS="$LINKS tests/qemu-iotests/check tests/qemu-iotests/Makefile"
 LINKS="$LINKS python"
 LINKS="$LINKS contrib/plugins/Makefile "
 for f in $LINKS ; do
-- 
2.43.0


