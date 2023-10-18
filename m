Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C62F7CD66A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:28:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1ug-0001Dq-IU; Wed, 18 Oct 2023 04:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1ue-00013w-7F
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uc-0003cX-NO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kigZ1gdB5H+XjWPX4HIf/8kVEM1VbLJvt/chkAEw+1Y=;
 b=e5DqfJwcSw0XSWACgZC7ww1ft7GPzclFNsN5qMFevwqKdTzDHBU1KQYBPabZac7GJ4AOdb
 t9qRQ60XgWM2neRJWTfYlrfpqABxcQw08rofS7EFDsNbgbMoxQRHM2UtSWbdjgZdKCjhIs
 t1gpYQsj79Mkm/iGfAPI2xRZyUftDJg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-_7rmjzOPNzCDiu5nK-yOkw-1; Wed, 18 Oct 2023 04:28:17 -0400
X-MC-Unique: _7rmjzOPNzCDiu5nK-yOkw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b95fa56bd5so482905666b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617695; x=1698222495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kigZ1gdB5H+XjWPX4HIf/8kVEM1VbLJvt/chkAEw+1Y=;
 b=IOL3k5crubvFiW14t7FxDHqs3E3GfZ55rWZ+H5XanW+wMwHDAAFfPueBmResCiHiUz
 g97RE5WaeqgP2T9kvqMS0Tw9vx7cTT5gzARNPkibHVEVhiGdZrcnci5/YqVIUajVbsQb
 NRnQhPLgYe3GPY/HcWINxt1gn98V7HK+WRNbHe4ODJO/R5WkdBT91YT3b4IfRx35RCgy
 /71FTlwiLFhIRpquaQZ1Cg0zcG+fbPM7jNZKeIsvRsFkAeGuB53aVQPs6WB+2ycuilGZ
 q7eb6Cr50uhvGAzIu4fydFKnYaWm4AOI3k5Wb1CxXPzg8Pg2yPRjG5y7qygW5RZOCuWl
 w8nw==
X-Gm-Message-State: AOJu0YwcHMw/kj1jaE531/oJjQK0MDRILya2by7j/f978cNfq46aeNxX
 vzg/nKzZU1qRv5egNmG58Wh7d7k86yA8mYKQA8TbxVuxD+4WikjbWNUiBC9Wn7wrqrfr/AGY+Qo
 UtapVcPXFjp2LjS7b9o2zIinjQxyIZKlUB7vZRpHLacr632kig9Ko2MBof3iVwCqvIvIcQGlsZy
 w=
X-Received: by 2002:a17:907:31ce:b0:9be:a86:571f with SMTP id
 xf14-20020a17090731ce00b009be0a86571fmr3149952ejb.34.1697617695237; 
 Wed, 18 Oct 2023 01:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/4rcuERhN5GRkhtyWWw3nn32ToUNUxDahEkY261Z+1vicy+vlwzh8ACeP82cnGAe22ukNYA==
X-Received: by 2002:a17:907:31ce:b0:9be:a86:571f with SMTP id
 xf14-20020a17090731ce00b009be0a86571fmr3149943ejb.34.1697617694914; 
 Wed, 18 Oct 2023 01:28:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a170906739200b0099bc8bd9066sm1194780ejl.150.2023.10.18.01.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 11/32] target/hexagon: avoid invalid escape in Python string
Date: Wed, 18 Oct 2023 10:27:31 +0200
Message-ID: <20231018082752.322306-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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

This is an error in Python 3.12; fix it by using a raw string literal.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/hexagon/hex_common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index dce1b852a7b..0da65d6dd6a 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -45,7 +45,7 @@ def uniquify(seq):
 immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
 reg_or_immre = re.compile(
     r"(((?<!DUP)[MNRCOPQXSGVZA])([stuvwxyzdefg]+)"
-    + "([.]?[LlHh]?)(\d+S?))|([#]([rRsSuUm])(\d+)[:]?(\d+)?)"
+    r"([.]?[LlHh]?)(\d+S?))|([#]([rRsSuUm])(\d+)[:]?(\d+)?)"
 )
 relimmre = re.compile(r"[#]([rR])(\d+)(?:[:](\d+))?")
 absimmre = re.compile(r"[#]([sSuUm])(\d+)(?:[:](\d+))?")
@@ -337,7 +337,7 @@ def read_attribs_file(name):
 
 
 def read_overrides_file(name):
-    overridere = re.compile("#define fGEN_TCG_([A-Za-z0-9_]+)\(.*")
+    overridere = re.compile(r"#define fGEN_TCG_([A-Za-z0-9_]+)\(.*")
     for line in open(name, "rt").readlines():
         if not overridere.match(line):
             continue
-- 
2.41.0


