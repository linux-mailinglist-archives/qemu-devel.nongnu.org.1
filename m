Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0640712A35
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzj-0004H2-1p; Fri, 26 May 2023 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzg-0004Fh-Iz
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzd-0002fh-Vn
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q24lgTZzDX54EUdjECo2U6h6oXNEyLIGSU/uCnCASvs=;
 b=UcEwJ3GlK1LLZn+r1GSAm8aDFJ7YuV4f2wtYrNDSo07+O06ShVNQo2w+NULT+pyRsQj4zP
 nE3s9hR5TGM16lhIX5ESXHKr6kkyjZKvk2Oe6hV1v/2MoEtCvElN/ndNpYJwvVmtElWG1u
 J2sKQ8yZTj9g2nsNqK4iRPaqXAVJGRE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-AnwNs9bcPliJRGdD2Pvk8g-1; Fri, 26 May 2023 12:08:39 -0400
X-MC-Unique: AnwNs9bcPliJRGdD2Pvk8g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-513e916ed47so835673a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117318; x=1687709318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q24lgTZzDX54EUdjECo2U6h6oXNEyLIGSU/uCnCASvs=;
 b=eMV/ChOMMLBeM8IT8EUX6o/XvVZ2s1gMQmUxfMNZK4KiSnNHvyFF4XyFbzNDpw+s0p
 AfENwJoJolHf01hqWWvS6qkLzLmyZ77VsGphCQvRFlWS6/YOAsbKqyQnuk9WIK3C0Ued
 RT/T/8CLQ5x6X627yLrnIs/7PdBKJ3e4U9dMahxKD4rLV1BW/iqimwkjLvb6aERdBcv6
 /2afgeAQ8HbWLwvw7o8Ssay7PRjTtZzwPNecGUgNhpjzEtDbKmY8KFqXjPQeIALnwu5G
 m2+dbjyYBLoC/RsqiSlqtQD7uuBTzTwMBoP+vcu6K45g2AAJdOOWVUd9hLNIog98wf7Y
 /pnQ==
X-Gm-Message-State: AC+VfDwmNstoHcrZRhfi5KOCHna2TMobPXEzvqplxAA6bupHtmn5RM64
 O4BMs8cn0n7pxS6oSzoPDROYmax9KWshffMEVHMxvFuyRUO9GXcOvnIjawcKWC6HFvhJJzdX7i3
 YN1FGbiXJHQGXEUqbxkSi3zSgo6FwekMlEE4hrjyIHXgtRi+hl/oW45dpbRD2oyyEqWBiACv/aA
 k=
X-Received: by 2002:a17:907:3603:b0:961:8570:4589 with SMTP id
 bk3-20020a170907360300b0096185704589mr2382308ejc.30.1685117317798; 
 Fri, 26 May 2023 09:08:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HW0b63GucBO193TiLcH7DecRsJXTWgr9wbvgOFKIWdLRICrh2nYWhSQy+73Pa+HlOvGrFNA==
X-Received: by 2002:a17:907:3603:b0:961:8570:4589 with SMTP id
 bk3-20020a170907360300b0096185704589mr2382287ejc.30.1685117317482; 
 Fri, 26 May 2023 09:08:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a17090636d400b0096fc35ca733sm2276497ejc.41.2023.05.26.09.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 07/12] slirp: update wrap to latest master
Date: Fri, 26 May 2023 18:08:19 +0200
Message-Id: <20230526160824.655279-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
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

It is recommended to use SSIZE_T for ssize_t on win32, but the commit
that is being used for slirp.wrap uses int.  Update to include the fix
as well as the other bugfix commit "ip: Enforce strict aliasing".

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/slirp.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/slirp.wrap b/subprojects/slirp.wrap
index ace4f26102f5..08291a4cf99a 100644
--- a/subprojects/slirp.wrap
+++ b/subprojects/slirp.wrap
@@ -1,6 +1,6 @@
 [wrap-git]
 url = https://gitlab.freedesktop.org/slirp/libslirp
-revision = 15c52d697529eb3e78c5d8aa324d61715bce33b6
+revision = 26be815b86e8d49add8c9a8b320239b9594ff03d
 
 [provide]
 slirp = libslirp_dep
-- 
2.40.1


