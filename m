Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99C7CD68B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:31:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uV-0000Q3-Or; Wed, 18 Oct 2023 04:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uR-0000IN-GC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uP-0003Ye-6i
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1nCveODekda2WIdboayc39x+is6XRL9Eo63iDkXcJQ=;
 b=EkfZr4FynidpWhiP2lBlG9U2t0/isU0X5cfQmiAyAXtgQ1KAemkPfFmejmweoU6/VktsYv
 7aAxEQnDJcuNOGf2K1eLLO9LPB06tBlqOVyfSCxsdsSTXSsZCMqSiV5B1qYrPlJgq8YyrC
 krecnFXTIHl1HApYOziET7MhBPP7G8s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-WSqx0jIBOEGQL8V2VAquLQ-1; Wed, 18 Oct 2023 04:28:01 -0400
X-MC-Unique: WSqx0jIBOEGQL8V2VAquLQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae0601d689so435222966b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617680; x=1698222480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1nCveODekda2WIdboayc39x+is6XRL9Eo63iDkXcJQ=;
 b=muEyU9iLtoJJLuBVPL5Gy0qdX4WmVQyn99Egy1v7Ms3liBuTg1d9w2szr7bbcGaP6j
 0aJK0EXgMBYCB5sdwOnlrzm6p7ucYyfpFt3Hqb0IsfYlJIDVeglPjSDssrWGV6AMfWaP
 jSA2/3R3Ac+bzGSA8jtfvj9EIu/hACiQO0bfEj5RaQCdOwEkmeSPTgXArmUdEWRp5a3w
 CEjHaKxX2txzEv3jReQCsmG0hG4WOoipNNPPFlPVwBeFo1BMuzaLv76KGqKpyKpq7kUd
 AdW2A8n2BKhjr1VxnELE8tWobZLf6H5G6Ai5CHvg9ksoigMZZPZWIZ7FBjWcBroi+Ld5
 yskw==
X-Gm-Message-State: AOJu0YxW9gBOZtq79d/oT84ExNwjTMOFAVw0NZxraajP8fWs4g01N76c
 suB7NNM/OLls3Zk3GeBAemp+40Pa9b7BakOX6DDVVtCxzNzfeSM1ht5VFowaEBvRcCRKJAAD8pY
 H4ISVWuyeRGe9Si/HhOYSY8nxziAIVFzFlERUaQTQvulNKZAH/jAUzS/RZbFiKoGK4Ao5PyKFFL
 Q=
X-Received: by 2002:a17:907:72c8:b0:9bf:39f3:f11a with SMTP id
 du8-20020a17090772c800b009bf39f3f11amr3581438ejc.74.1697617680137; 
 Wed, 18 Oct 2023 01:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6USEPHLAObRHWxstTfSO/go5mdv+Uio4A4QyZXaCVsV56qxJKEKd4flkllEo/W2RUKb8AMQ==
X-Received: by 2002:a17:907:72c8:b0:9bf:39f3:f11a with SMTP id
 du8-20020a17090772c800b009bf39f3f11amr3581417ejc.74.1697617679800; 
 Wed, 18 Oct 2023 01:27:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ay20-20020a170906d29400b009b2c9476726sm1183470ejb.21.2023.10.18.01.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:27:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yonggang Luo <luoyonggang@gmail.com>
Subject: [PULL 03/32] Revert "configure: Add workaround for ccache and clang"
Date: Wed, 18 Oct 2023 10:27:23 +0200
Message-ID: <20231018082752.322306-4-pbonzini@redhat.com>
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

From: Yonggang Luo <luoyonggang@gmail.com>

This reverts commit fd0e60530f10078f488fa3e9591cc7db5732989c.

According to https://peter.eisentraut.org/blog/2014/12/01/ccache-and-clang-part-3
it's already fixed in new version of ccache

According to https://ccache.dev/manual/4.8.html#config_run_second_cpp
CCACHE_CPP2 are default to true for new version ccache

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-ID: <20231009165113.498-1-luoyonggang@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/configure b/configure
index 96d0dd5ffc9..d6103a0141f 100755
--- a/configure
+++ b/configure
@@ -1166,34 +1166,6 @@ EOF
   fi
 fi
 
-########################################
-# check if ccache is interfering with
-# semantic analysis of macros
-
-unset CCACHE_CPP2
-ccache_cpp2=no
-cat > $TMPC << EOF
-static const int Z = 1;
-#define fn() ({ Z; })
-#define TAUT(X) ((X) == Z)
-#define PAREN(X, Y) (X == Y)
-#define ID(X) (X)
-int main(void)
-{
-    int x = 0, y = 0;
-    x = ID(x);
-    x = fn();
-    fn();
-    if (PAREN(x, y)) return 0;
-    if (TAUT(Z)) return 0;
-    return 0;
-}
-EOF
-
-if ! compile_object "-Werror"; then
-    ccache_cpp2=yes
-fi
-
 ##########################################
 # functions to probe cross compilers
 
@@ -1726,10 +1698,6 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-if test "$ccache_cpp2" = "yes"; then
-  echo "export CCACHE_CPP2=y" >> $config_host_mak
-fi
-
 # contrib/plugins configuration
 echo "# Automatically generated by configure - do not modify" > contrib/plugins/$config_host_mak
 echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
-- 
2.41.0


