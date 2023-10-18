Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF27CD68F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uu-0001mj-HQ; Wed, 18 Oct 2023 04:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1us-0001j4-1X
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uq-0003fe-H7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29Ov8K/gYI0tJ8cKPsPFpE4e3fFN2LTJq11ro7n66R0=;
 b=CqUgq/LK37As4pn3iXjgs+zzZ4lYyUuqcIubhfpNSQfBzroORBdHfqyyE2wkMFIs+ZY9HM
 5HRtnCvcq2yPVl9g9B3M2SkV1r5Qs6wLq+6t4vYJ2xOAJjLoKGoozC1xASZadhPIlzDHDD
 vIWavqSiIR1OLoCo7TZ2j/RITJlj2JI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-pkG5ozg-OnO6vIb2XYqEOQ-1; Wed, 18 Oct 2023 04:28:25 -0400
X-MC-Unique: pkG5ozg-OnO6vIb2XYqEOQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0a9so433763666b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617704; x=1698222504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29Ov8K/gYI0tJ8cKPsPFpE4e3fFN2LTJq11ro7n66R0=;
 b=d9znB0dtR7xH+q76JPIGgzxfTAYHdM/oXK2vQd2+iT8voazM+kp/aPdWguir5q5WYE
 lGC3qNoU38JwcIbqC5wI0zHCjdB2uqRTezIAVl7Rh8tTBTHmZpTPMMPLl1I5vcnJFfMy
 thxp6nd8KfQMcecmdywxrCgZZu+wRYooOAO4uPGTyl1wplk06HNBUPgeGFx147R98C+p
 ++4+9aH0pZsyNudzWG17QyXioTbdtaE+U6y3WwRDtwlzQVwmrME2gKoy61fQnuXLs9wn
 yHYV1CrLSH25lLVYP0Pmd8Gr3X/YOQYPoSx7VTZlim03iOfYzijD+Fc7dwpTMQGec/5m
 m4hw==
X-Gm-Message-State: AOJu0YzRFSQPtYbr+RkeEBt1TgFhuV9NuOWEwjIkwRzNKVS28WojkdFi
 mw8cXBGZ9+tHqFbhZEiYKSOEAF5hjR05TDtr8cDs95JkYWUnYrbRB+X54UsgcjxRnHpx+1IkmbJ
 +EjEm/eSutSZ6vI0SU1kdUf5YPs4RWWl3pXDCV1e+4qt9Q14At5PZAkKUh04utNRQaPoaz7FVZr
 c=
X-Received: by 2002:a17:907:1ca0:b0:9c1:9b3a:4cd1 with SMTP id
 nb32-20020a1709071ca000b009c19b3a4cd1mr3230070ejc.3.1697617704056; 
 Wed, 18 Oct 2023 01:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4rVpWD5io6uLOuKfdJ1CjruM9Xh3u/6Rt8G5OS+gmAVMW68gWT+1IlQBtwrBVXSvdB0S6cw==
X-Received: by 2002:a17:907:1ca0:b0:9c1:9b3a:4cd1 with SMTP id
 nb32-20020a1709071ca000b009c19b3a4cd1mr3230057ejc.3.1697617703816; 
 Wed, 18 Oct 2023 01:28:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 bo16-20020a170906d05000b00977eec7b7e8sm1195760ejb.68.2023.10.18.01.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 15/32] meson: do not build shaders by default
Date: Wed, 18 Oct 2023 10:27:35 +0200
Message-ID: <20231018082752.322306-16-pbonzini@redhat.com>
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

They are not needed when building user-mode emulators.

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/shader/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/shader/meson.build b/ui/shader/meson.build
index 592bf596b9a..3137e65578e 100644
--- a/ui/shader/meson.build
+++ b/ui/shader/meson.build
@@ -10,5 +10,6 @@ foreach e : shaders
                 output: output,
                 capture: true,
                 input: files('@0@.@1@'.format(e[0], e[1])),
+                build_by_default: false,
                 command: [shaderinclude, '@INPUT0@'])
 endforeach
-- 
2.41.0


