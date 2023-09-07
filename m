Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD1797279
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdG-0002sT-0o; Thu, 07 Sep 2023 09:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcn-0002kx-Gf
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEck-0007FV-Qb
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UW0LYVBQ86z9c2cV3F6pmV9ZwvsvlDsGKOMCu7v7vrc=;
 b=YvpQZgVTXW1NZgsm0/e4m4Lvw8n9fWfskyIR3v0bQitpcb07bWi5aGui4e+hiGQDYdwFXR
 jYxxAvhMJ6KZuZvegql6sSkicrY+hrSpCUr/ZqJ+80XOdzZqwSQmb1mAOhEtG66gNAlVQL
 srhHXMmrIFF3KnG6Y73nGBmEIRCUWzE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-INjB6wiPNimZNdnkT1x8EA-1; Thu, 07 Sep 2023 09:00:39 -0400
X-MC-Unique: INjB6wiPNimZNdnkT1x8EA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402493d2997so5976725e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091637; x=1694696437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UW0LYVBQ86z9c2cV3F6pmV9ZwvsvlDsGKOMCu7v7vrc=;
 b=X4++IaGkFQECTjSmEpLKhng7uJobyTUamc6gtPLLsXnXZLTvkxl5CbjBhtz6TEXsYE
 EV7ukTUVplLdL63Y+9618kjsEMvuZAqqZZKwFpzV9uAMZNtShOvITJHHcX9oSc5dP5aX
 5KssWWfPbhDHdlIDrD0W6WxEQZEEQTCar0ne+qPbLmTn1n1s982+i0xd19gJ3iEUZ+z0
 hGIM57iydPGbnIsMR0OK3b7TsNIbtgqGBxfdzw0Cm7yLbjRllJxgGDxjkx1vNhAxUB4x
 5EJeSN/WN02xwKnQKh+YjLVQmeImNes4KfT9ya9uA34wO6Jf5vzY2t9Shz5oN4CSu8Vo
 bUFg==
X-Gm-Message-State: AOJu0YyCHrMyjZfbdEQN/pKvNH0xDJetn3k3Zva3uimpMxfoq+Z/q/GW
 Ph1YEeCXNGflw9O8bUpCfxH//6jIp9uzVa4jx6cHWsKtmdgeLrPoFRHWxsYtcqm+614Z2ylOllO
 Okh/ykxrIqv6pDGEnLoKu5IRhv/0Ye5jKAptiLfMwxa+Mp00/Y0q0aj8RaROuOcoMUwyDJSaTS8
 w=
X-Received: by 2002:a1c:721a:0:b0:401:519:c5 with SMTP id
 n26-20020a1c721a000000b00401051900c5mr4652251wmc.41.1694091637595; 
 Thu, 07 Sep 2023 06:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGadIFPf+o/BgY2ZYe5zmx9484TGqJKwELEYrbVEHTqvdOnu0bk/fcIpAlcvWJp/FLlNQ5RqQ==
X-Received: by 2002:a1c:721a:0:b0:401:519:c5 with SMTP id
 n26-20020a1c721a000000b00401051900c5mr4652216wmc.41.1694091637029; 
 Thu, 07 Sep 2023 06:00:37 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a5d4bca000000b003180155493esm23243650wrt.67.2023.09.07.06.00.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/51] contrib/plugins: remove -soname argument
Date: Thu,  7 Sep 2023 14:59:23 +0200
Message-ID: <20230907130004.500601-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

-soname is not needed for runtime-loaded modules.  For example, Meson says:

            if not isinstance(target, build.SharedModule) or target.force_soname:
                # Add -Wl,-soname arguments on Linux, -install_name on OS X
                commands += linker.get_soname_args(
                    self.environment, target.prefix, target.name, target.suffix,
                    target.soversion, target.darwin_versions)

(force_soname is set is shared modules are linked into a build target, which is not
the case here.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index b2b9db9f51a..db1bd04dfa6 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -37,7 +37,7 @@ all: $(SONAMES)
 	$(CC) $(CFLAGS) -c -o $@ $<
 
 lib%.so: %.o
-	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
+	$(CC) -shared -o $@ $^ $(LDLIBS)
 
 clean:
 	rm -f *.o *.so *.d
-- 
2.41.0


