Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8267670701B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGO-0003yg-3o; Wed, 17 May 2023 13:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF9-0002kJ-AO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF7-0004dk-Ey
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JI3T87pJOqojWyuspcbpOcfDTh2nH5bgx4dRWFwMvSc=;
 b=C4r8ENdCYkc9qseI+5SsAWPebsck+aNMt3zggvrGiIjjGGCZkNpreq/tbd6yIsp4nvy3GJ
 cW8p0b0foUsx7qutrHihd17aJMAKHfQ768JXdPuuWUpZF6Jw63ZWgTdRDsVNHaBm1Ij0WO
 //gCQSWJS1pSoDUeCWXGjzzbwB5CciQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-ALBaLvZPNyyRmSgLFZJagw-1; Wed, 17 May 2023 13:47:06 -0400
X-MC-Unique: ALBaLvZPNyyRmSgLFZJagw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3093b0cf714so448892f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345625; x=1686937625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JI3T87pJOqojWyuspcbpOcfDTh2nH5bgx4dRWFwMvSc=;
 b=iU03m9P86gIGppOLVAUhLB4QLUIlAwmiKsJU0cCWdNX8nN7+SmhGPgpw+Pg6fZwMMs
 2WocI71q4O1v4FQZjYY3oSA3UZMxBNmKSDb9oYyjPSbg6J/DYz1ysyO4TJ9vW0z7r8xR
 oEgGgfvzWQcHdMelYb+QtvEmMjz2IkU+Y4MaXDEkevUdZEWusT6sPq0R5Uk3tkrZ1/YA
 2HZSm5TmaXY9XzhAg6vethOy/3FumOENH8BlBTJS7Bol8LiYM49YtnKKouxbgLSRMmMX
 NEtvJ1394VYuvQO7sC4f2KiNuWWwfhby06KASx+i1zBKpz7Bqsco5ECd9rdVr1uMUjn7
 RbQA==
X-Gm-Message-State: AC+VfDzrUOfhVwkluHtmt9vnhhahcwdFjiT59WDvtlm6xjXI4Ckq5g/7
 4yTuQHJ2drLEbGHg3mIhhJ0I507nVIxTearmGyFKjxiPkkU08hoGtGfrdmMORc+x/qB5KAxRT6J
 jcHjA1s9jRSKmk0PTmW6oGIEyFOQwXbUtpiTxmaEuQ5cg7Tw3qW2YsOemleNXH5CeiodEc0q6lj
 Y=
X-Received: by 2002:adf:fa03:0:b0:307:a6bc:3baf with SMTP id
 m3-20020adffa03000000b00307a6bc3bafmr1358519wrr.56.1684345625110; 
 Wed, 17 May 2023 10:47:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BhyD7ejqKYQlz3ZZ/grl+hZasgEmg76S/x5wUhhbqPYilsHIhV1c+Sorg8idHfvpEmXu4fg==
X-Received: by 2002:adf:fa03:0:b0:307:a6bc:3baf with SMTP id
 m3-20020adffa03000000b00307a6bc3bafmr1358510wrr.56.1684345624776; 
 Wed, 17 May 2023 10:47:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a056000100800b00307d20546e6sm3714622wrx.27.2023.05.17.10.47.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 63/68] configure: remove compiler sanity check
Date: Wed, 17 May 2023 19:45:15 +0200
Message-Id: <20230517174520.887405-64-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

The comment is not correct anymore, in that the usability test for
the compiler and linker are done after probing $cpu, and Meson will
redo them anyway.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/configure b/configure
index b2172b7b938e..4a986e6fa89c 100755
--- a/configure
+++ b/configure
@@ -1090,20 +1090,6 @@ if test -z "$ninja"; then
     fi
 fi
 
-# Check that the C compiler works. Doing this here before testing
-# the host CPU ensures that we had a valid CC to autodetect the
-# $cpu var (and we should bail right here if that's not the case).
-# It also allows the help message to be printed without a CC.
-write_c_skeleton;
-if compile_object ; then
-  : C compiler works ok
-else
-    error_exit "\"$cc\" either does not exist or does not work"
-fi
-if ! compile_prog ; then
-    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
-fi
-
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-- 
2.40.1


