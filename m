Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BF790808
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:06:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEn-0001OP-Pr; Sat, 02 Sep 2023 09:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEV-0001Em-2i
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEQ-0001x9-Us
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WcGDl6RkhTkBJqOx8dimnwDWVGbWEwjjaYfS1PTpFo=;
 b=i5UY3C0RuR11MzzEDAv9RQ0JdPNsxG5P0VhLYt+nEye5IRdWB3MxsU5FX9IRbFqJO3cXDN
 kKv9DQEDcZ/68RwfBbqSKLeVmZVcrkx6J59I9ojP9/aW9IM7h+MVwEkZkiREqjy8Ps+6uZ
 Yyp1aLg9Me3d2OdiINbTqgw5pg32EqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-XiQW7mQ6NguceJLlpNJmlA-1; Sat, 02 Sep 2023 09:00:04 -0400
X-MC-Unique: XiQW7mQ6NguceJLlpNJmlA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31400956ce8so1523183f8f.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 06:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659603; x=1694264403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WcGDl6RkhTkBJqOx8dimnwDWVGbWEwjjaYfS1PTpFo=;
 b=KqWGZHs5+lK2+UsoFQZvn6+2oisPqMhBmp0CslnsgizI2o2NPYO6M6FuwPOUJZI6vE
 UOVQgzSIhqNiM6MU8h9DuV9C+iI10Mix1OFY/fMPSkwPnUPlX5Jn3ASWuHCiMHVoUasb
 e4JaZov6M0OL/wRNXKi3ldzUaY6qDCv0DUj37pdS7/AVtXXu/GkwCsI8MJ+uk2g690li
 w29djg6iIeJHVz76FJK89sfhGg7XhyrPvsMxnx5/jCzXNUqfNMQegSMUiVEetgUmXOrO
 kb2IqJtClbutTckzXznPHlY4eQEuto2e/UvRYFiS1F6bPMJktKnjw34y+r3KqHPno6N3
 oe0g==
X-Gm-Message-State: AOJu0YyxTIqZ01+akgNnRH0Ex2LcO8MO8nKgcfGq0eoV03U9BvGOg3Tk
 FDjA62yptjpstZUf7U9uTrtiduHoxaoMsiy78QXEdv8ZKHuYcFMXAvAY3POY9Cqa/MQ5WKhKg/R
 uVKh2//BBwVA35FhsufD2mv0GIQzJITNp29mLIsSi9v67d69bYcWef5BnhQHJIaefK6CcQId3yY
 c=
X-Received: by 2002:a05:6000:82:b0:31d:cd2f:4a4b with SMTP id
 m2-20020a056000008200b0031dcd2f4a4bmr3460736wrx.50.1693659603150; 
 Sat, 02 Sep 2023 06:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNO0Z1oguqNDY7xj3vr1LGrnZH/BSf58pU72nTu7U+f+H+OjM4w2YkPQP8Mdrqby/dh3BT8Q==
X-Received: by 2002:a05:6000:82:b0:31d:cd2f:4a4b with SMTP id
 m2-20020a056000008200b0031dcd2f4a4bmr3460732wrx.50.1693659602896; 
 Sat, 02 Sep 2023 06:00:02 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a5d46c7000000b0031accc7228asm8443093wrs.34.2023.09.02.06.00.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 06:00:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/15] configure: remove dead code
Date: Sat,  2 Sep 2023 14:59:34 +0200
Message-ID: <20230902125934.113017-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/configure b/configure
index 6404b659718..a8d79602098 100755
--- a/configure
+++ b/configure
@@ -1126,14 +1126,6 @@ else
     done
 fi
 
-# see if system emulation was really requested
-case " $target_list " in
-  *"-softmmu "*) softmmu=yes
-  ;;
-  *) softmmu=no
-  ;;
-esac
-
 if test "$tcg" = "auto"; then
   if test -z "$target_list"; then
     tcg="disabled"
-- 
2.41.0


