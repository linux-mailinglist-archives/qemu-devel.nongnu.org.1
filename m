Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE05E7CD6A4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uZ-0000W9-5P; Wed, 18 Oct 2023 04:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uX-0000VM-L3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uW-0003aZ-4z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4h1jQd8MPaPCiSAma/Wz/kZ98BhCtpzrw70KbY8noQ=;
 b=QrZD9qRWBLFf5Xk9QhCEolzfLzVmbeDNy+GdBGe/zhgN4x17kd3NcVKlrbibdBSTniWMC7
 8kE9LIr2k+Dz1K4/l8efqU9rg7edyVWmzGa+hF+EbF1tsxesqb2pNYmEeJZf4GzF0+yzJo
 vMsFbPCkZf35eNzADtkJc36TpAIyXbU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-GEcmiMqWN36J8bVyLWdHDw-1; Wed, 18 Oct 2023 04:27:59 -0400
X-MC-Unique: GEcmiMqWN36J8bVyLWdHDw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9c57f8bbe45so160448266b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617678; x=1698222478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4h1jQd8MPaPCiSAma/Wz/kZ98BhCtpzrw70KbY8noQ=;
 b=KDSDgN5tZkg1KoHx/bTI/aIAIZWa8XYs2oI3kGWr+HXBTSYLc8L0FAt8wf/tjWjamw
 BvqYUf/mmDkE0MX92zfjULE0bxrDoL4CdEVZBZl1A9R/i+1FJG+6rrzCvEge+IopYPWJ
 BrFDvIFfcK87PJLowtZ6D9UkeT0s0kq+o/sUfavmHSPjzq+OC/qFEYdSl2i9ivMCLV8k
 nvHlPSSAj/hvXkQMlmXNn1zU/rvZ6uS6xlzRrs6WHWlCo7Ov66gek1H/hWdEY8CX1eG5
 n7pF7iVXdP8sqRBIPLoh4YbbJXKDSehcx6xNceI3qcvhqPvwyqYWxIOOFMDXfhUcWBXo
 SiAw==
X-Gm-Message-State: AOJu0YyHY1HmzYDvhRBpuHnpilS1nJlUkP0bnEfme/5s0WnZdkUxC4D4
 FC7P8cFTToHi8vHCoVvGe5rUvX9l13kYv9Ylqu+i8DYySYS3lY2sVo92/1RVfwk3uaX7FpMlc9d
 6cfZRIEyfDfeQSG49lek9dQxwZrMvMIO7wkytQBSe3Lb4IlMI0J9giNr2JGpflHt8L8bqGRSSx8
 s=
X-Received: by 2002:a05:6402:194b:b0:53e:7372:909f with SMTP id
 f11-20020a056402194b00b0053e7372909fmr3582298edz.22.1697617678296; 
 Wed, 18 Oct 2023 01:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgIxBHnEHFkRObKKByYT/LXRh56U11NK9ERipuIDSf1O0v50F/kRVwei3OHCoBj9dWdux5MA==
X-Received: by 2002:a05:6402:194b:b0:53e:7372:909f with SMTP id
 f11-20020a056402194b00b0053e7372909fmr3582293edz.22.1697617678036; 
 Wed, 18 Oct 2023 01:27:58 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 x27-20020a50d61b000000b00533dad8a9c5sm2486640edi.38.2023.10.18.01.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:27:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 02/32] iotests: use the correct python to run linters
Date: Wed, 18 Oct 2023 10:27:22 +0200
Message-ID: <20231018082752.322306-3-pbonzini@redhat.com>
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

From: John Snow <jsnow@redhat.com>

Whichever python is used to run iotest 297 should be the one used to
actually run the linters.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20230621002121.1609612-5-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/linters.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/linters.py b/tests/qemu-iotests/linters.py
index 65c4c4e8272..9fb3fd14497 100644
--- a/tests/qemu-iotests/linters.py
+++ b/tests/qemu-iotests/linters.py
@@ -68,7 +68,7 @@ def run_linter(
     :raise CalledProcessError: If the linter process exits with failure.
     """
     subprocess.run(
-        ('python3', '-m', tool, *args),
+        (sys.executable, '-m', tool, *args),
         env=env,
         check=True,
         stdout=subprocess.PIPE if suppress_output else None,
-- 
2.41.0


