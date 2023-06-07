Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07687726500
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vNq-0005qF-64; Wed, 07 Jun 2023 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vNo-0005q7-I9
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vNn-0003AI-20
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686152854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUIa4lbtnNJPw6bP1VNwkUBEbDZLSgAmnuRZc8Rr2ck=;
 b=ACrcUdSx+843S7nKlUkF9U8Kv0NthXyHEcy6iuO70AnkXgPQ2/n8s4TzvX6T4XhK9Zf9gj
 z1BDPZ3uGn41km21oW262b1vkBYRiPSAmpnHCUe60uVXup9Ye9RwWMGMfmz9iG0GpuXRZI
 CyFL7bTPpXB0AppX+R+LT20l2TP7SfI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-b_w2fKRvPNqt3Zup_vX_6g-1; Wed, 07 Jun 2023 11:47:30 -0400
X-MC-Unique: b_w2fKRvPNqt3Zup_vX_6g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-974566553ccso617156466b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152848; x=1688744848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUIa4lbtnNJPw6bP1VNwkUBEbDZLSgAmnuRZc8Rr2ck=;
 b=MFMm2mSX51qRZTh9rZvWoeshrmHJU26Uea+iGS2vCUOwq+YPurBxh29uEzKkBFNOua
 gH1N6KRQWEx1T72CkESeoOp3AYirqguwDxb4p6m06uDbvG9IilRND62xX0AS2beJMXyp
 kZKH+UbphZ1K4EAS+8H9PC5Hiv+5DfypTga3rLj5ObY9piVoIPWQXotv8aLyD1UJvqs0
 nAl7tPxixyMXjyLuTZa6Kyt4iAfuW9Y6HFtUrwqTSDpEI4OPkElgk5DxaxeAtNia8PB0
 i76iT8lo+vRdfQzVjdNevM2P75hYEeZocukPiK8F0hM/BEVloX1uRvv35Yq2XlYFrwQv
 BnTw==
X-Gm-Message-State: AC+VfDw9vxMu/ZeGoDzkE5y/XEZgRsqPdlh/Ih9DUSUYh16hrGkOUtPy
 fpNGETBmUXl/08DbWOMdYl03LoIDE412yqGpiex1OzbqfZVTYH+tzmqQc6lRQQg3N/3eB2k6pld
 fAKOzpnb5LvHLIo+A0ABbvSdDUV+XvflqKxmVRSKizw73vLybAfmjFSHL72WzyXd7LRZW9J+ba4
 c=
X-Received: by 2002:a17:907:3da2:b0:974:5480:171e with SMTP id
 he34-20020a1709073da200b009745480171emr7558450ejc.32.1686152848796; 
 Wed, 07 Jun 2023 08:47:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4r7o4/8WCzn4ADyNsnurYNPpO0HHvy+pq42rtHgPzuvV0uPe5g5RbgjMY3aXQT6sWrNy6PGQ==
X-Received: by 2002:a17:907:3da2:b0:974:5480:171e with SMTP id
 he34-20020a1709073da200b009745480171emr7558430ejc.32.1686152848537; 
 Wed, 07 Jun 2023 08:47:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 ss18-20020a170907039200b0094ee3e4c934sm7022287ejb.221.2023.06.07.08.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:47:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 2/3] configure: check for $download value properly
Date: Wed,  7 Jun 2023 17:47:23 +0200
Message-Id: <20230607154724.253659-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607154724.253659-1-pbonzini@redhat.com>
References: <20230607154724.253659-1-pbonzini@redhat.com>
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

From: Michal Privoznik <mprivozn@redhat.com>

If configure was invoked with --disable-download and git
submodules were not checked out a warning is produced and the
configure script fails. But the $download variable (which
reflects the enable/disable download argument) is checked for in
a weird fashion:

  test -f "$download" = disabled

Drop the '-f' to check for the actual value of the variable.

Fixes: 2019cabfee0 ("meson: subprojects: replace submodules with wrap files", 2023-06-06)
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 8765b88e12f..8a638dd82ae 100755
--- a/configure
+++ b/configure
@@ -767,7 +767,7 @@ if test "$plugins" = "yes" -a "$tcg" = "disabled"; then
 fi
 
 if ! test -f "$source_path/subprojects/keycodemapdb/README" \
-    && test -f "$download" = disabled
+    && test "$download" = disabled
 then
     echo
     echo "ERROR: missing subprojects"
-- 
2.40.1


