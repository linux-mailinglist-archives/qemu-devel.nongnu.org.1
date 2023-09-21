Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC47A949D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJaq-0003xq-3i; Thu, 21 Sep 2023 09:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjJam-0003xc-HY
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjJak-0002Rb-RR
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VpmrXx9N4UyYbOdNCIZeBexhwGeIYaBGZh5PpT9c3y4=;
 b=PF3nc2sb4JlHww4XhYA0fcAKfPzsnSu7sL3nmu0f/rU6bBe3Is18aM3pNJQsD+wCFvoWDy
 zp8qfjFXaofVvhJ8phPzJHo75TYvZ1OIfBGs2Ff4TdvLXKiDk2oKqr2fSPyQ9QFf/5+jCD
 z51Lo6S3kkSio+tIVR9We1YT7ZMIuTY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-MSXLT1YKOamsb9wZdJKgVw-1; Thu, 21 Sep 2023 08:10:55 -0400
X-MC-Unique: MSXLT1YKOamsb9wZdJKgVw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso6874535e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 05:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695298254; x=1695903054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VpmrXx9N4UyYbOdNCIZeBexhwGeIYaBGZh5PpT9c3y4=;
 b=EUVOOGdIEIQV+fG/WV4R66IzjfcL6bLEwxxr4qDdbkxrErnC36/mypVxVAzU8lhcgE
 twjEiTwpgGijvuWF14+leQbKkyRStPHwal4RfoSNFQcb2vBagA8quEo6IRHrPxCwsVKc
 mbqSVoifk04xMkqpPQCb03wlEG2eg7BreV0JG8P1V/H8pmyHca5743T26etoLP4rqsxN
 thQ8+cSmvux635z3xQ4kVVQAo6+Q5zmXm/jQNu5BfP00HTET1GkAAvb7hOe7NzFp39Gs
 1bLa1cPniWE+4zHlAgaCuOi1YDvrTuH+0408wZnktlTNL0Y7/UY6jZiWJUmQs2IfvXLM
 6qWA==
X-Gm-Message-State: AOJu0YxMr3ZQTHpWivOUjHYy6exre03OhZXoHy/75+sR9bDqNaZTbOSi
 cAXouSdIqrThwSCXDrV/goyIlX6dP3sXLeo2q7+KE/pF2KOjL7HIKw0gGZ3VXtKrPzkeuTN2hQA
 gjyWLJaDDzYVdjXmn6C++MLeAwpDU+FfcaM3z0NHmJc/Jqo22jDgM9YZGE+fKIxZC/WNjM6CJPQ
 Y=
X-Received: by 2002:adf:e5cd:0:b0:320:c9c7:fbb4 with SMTP id
 a13-20020adfe5cd000000b00320c9c7fbb4mr5205611wrn.58.1695298253833; 
 Thu, 21 Sep 2023 05:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG25uz5GWoI8pgND+NC0BVyGW4KgfsTZL9YfqtgbXnD2oqIhkDwE2D6lR8NtJrhlG5dxCiiNg==
X-Received: by 2002:adf:e5cd:0:b0:320:c9c7:fbb4 with SMTP id
 a13-20020adfe5cd000000b00320c9c7fbb4mr5205592wrn.58.1695298253398; 
 Thu, 21 Sep 2023 05:10:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a5d4a10000000b003200c918c81sm1586385wrq.112.2023.09.21.05.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 05:10:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	kraxel@redhat.com
Subject: [PATCH 0/2] pc_piix: remove machines using a 128K BIOS
Date: Thu, 21 Sep 2023 14:10:49 +0200
Message-ID: <20230921121051.192355-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Remove the deprecated machine types pc-i440fx-1.4 up to pc-i440fx-1.7
These are the last users of the 128K SeaBIOS blob in the i440FX family,
and removing them allows us to drop PCI support from the 128K blob,
which is always strapped for free space.

Paolo

Paolo Bonzini (2):
  pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7
  seabios: remove PCI drivers from bios.bin

 docs/about/deprecated.rst       |   8 ----
 docs/about/removed-features.rst |   2 +-
 hw/i386/pc.c                    |  54 -----------------------
 hw/i386/pc_piix.c               |  73 --------------------------------
 pc-bios/bios.bin                | Bin 131072 -> 131072 bytes
 roms/config.seabios-128k        |  30 +++++++++----
 6 files changed, 23 insertions(+), 144 deletions(-)

-- 
2.41.0


