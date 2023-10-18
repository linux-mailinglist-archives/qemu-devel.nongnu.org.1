Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F87CD674
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:29:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1ub-0000hY-VW; Wed, 18 Oct 2023 04:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uZ-0000Xw-DH
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uX-0003bT-TZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/iLhKRWUy46KALrFTfkLnNSvwmOOrrbKsmD+zgIYcw=;
 b=KyS3aN1qHvbLaFvZdyB497XKc5VdtL70dK+DzwnjqNXAzG4UJggrRHYghO7Xoi9+OIFDnY
 j1fNNfGSUw1M/JT4jU7e/1+OksWFcserhqzLK4bxBi2WPXdMYSrqZK+CwTOH5hvLkF3+YQ
 4TUoHXjizxdD9Ppb1kQKhoyuJkJmEhs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-rNRRpYmhPCKwtm0PMC-Dnw-1; Wed, 18 Oct 2023 04:28:11 -0400
X-MC-Unique: rNRRpYmhPCKwtm0PMC-Dnw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c4485166beso214025266b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617689; x=1698222489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/iLhKRWUy46KALrFTfkLnNSvwmOOrrbKsmD+zgIYcw=;
 b=Eu1ji+YR6qJ1+3/PIqTz7PLPoSUULcoWuOVFYT8KwE4UXVGOucbqITWVOeYf9fDAK8
 nNimWsUuYUgHt7x02ZpibXzAq7dOINVgcWjHYg0eBzBLoo9l+4STvpzKYk4/j0D5zvJA
 EjCUgrua7bHE8Pm9aSnLwC0sotnr5LAUzkFAMtQSbQu8tWYYEuS98qRugPfLrGoVs7HU
 CbNz9X0ZOYLX9bJPHJfCfTWxZrMYyJyR8/U9YX5j/HYino8NqiyhoU6i5kodTnW19laD
 Yeeo5qKIPNkstHdyPabMOGYuv3h290cXQHlUJJZXfhJ0Pgx+0rsQPnIHxXtSuZQIoucx
 S7cw==
X-Gm-Message-State: AOJu0Yxlpe4vHQ0f14ZhIzGmllKZ3LYs444AX0iTeTe4DHzWdlz8zf2R
 wIf+sVvv4MT6W391xqTCWTKrwh319h6GmhoH5Rioc3xX7Xxb7bWdQSR5u5wQxsBAYraDHA+wbJ5
 1v508RUFVXXFWzcPXU1lpQaWQYnotrdxvE6dJqSv2LzWeArYH0nDCHEwvoC2Rx+qKuZyV3LuKwJ
 Y=
X-Received: by 2002:a17:906:da88:b0:9be:e6d4:5753 with SMTP id
 xh8-20020a170906da8800b009bee6d45753mr3201052ejb.28.1697617689526; 
 Wed, 18 Oct 2023 01:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGPj3tBZr9k+fAgH9WRREj81srrloZGBlMhZMgcIUUfbqP7jho7a4rRD+TwdbXY9qowPLyQQ==
X-Received: by 2002:a17:906:da88:b0:9be:e6d4:5753 with SMTP id
 xh8-20020a170906da8800b009bee6d45753mr3201036ejb.28.1697617689206; 
 Wed, 18 Oct 2023 01:28:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 bu23-20020a170906a15700b009b2c5363ebasm1189667ejb.26.2023.10.18.01.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/32] scripts/get_maintainer.pl: don't print parentheses
Date: Wed, 18 Oct 2023 10:27:28 +0200
Message-ID: <20231018082752.322306-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

When called from git-send-email, some results contain unclosed
parentheses from the subsystem title, for example:

    (cc-cmd) Adding cc: qemu-ppc@nongnu.org (open list:PowerNV (Non-Virt...) from: 'scripts/get_maintainer.pl --nogit-fallback'
    (cc-cmd) Adding cc: qemu-devel@nongnu.org (open list:All patches CC here) from: 'scripts/get_maintainer.pl --nogit-fallback'
    Unmatched () '(open list:PowerNV (Non-Virt...)' '' at /usr/lib/git-core/git-send-email line 642.
    error: unable to extract a valid address from: qemu-ppc@nongnu.org (open list:PowerNV (Non-Virt...)
    What to do with this address? ([q]uit|[d]rop|[e]dit): d

This commit removes all parentheses from results.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231013091628.669415-1-manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 02fa828100e..00a0870b267 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -907,6 +907,7 @@ sub get_subsystem_name {
     if (length($subsystem) > 20) {
 	$subsystem = substr($subsystem, 0, 17);
 	$subsystem =~ s/\s*$//;
+	$subsystem =~ s/[()]//g;
 	$subsystem = $subsystem . "...";
     }
     return $subsystem;
-- 
2.41.0


