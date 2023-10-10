Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D69997BFA55
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:51:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBGL-0007XR-R1; Tue, 10 Oct 2023 07:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGJ-0007VX-Ks
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:50:55 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGH-0006yD-VG
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:50:55 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so9578888a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696938652; x=1697543452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MdE5ZXVMUl9wP3lI9W249ELGe5CMinosJna3/j60eG0=;
 b=xaE2lp6krtbHerWfUIROvKs5PjNquny+OUgwyB7P5OxM7ieQ5BuTaeHgyy8YITi+aw
 yn1/FEnqvk4eX6qgIFW4ZF4q5aQPYHlcJhgh5G8Svyi+icZEUogwGoyfrqNqHOuXX6yk
 CTTC7U3PK1ewfU30otQpG/1q8NLqnFXwzeVg1CRYLbfDxxVM19nLiNQTQMDIE4+S+rH7
 utkRsjZMaZjNB1vmpXYwSFszT16RbfRFzpzE6K+e7tb5jqbrhCg5/yjtIvaL+FCg8EfN
 a/9fi5EKcT98aEkPMq7LzdiUJMcW+tyviS2uU8oJd2c6uc7NJ7c0HiZH04fCsALi9QNo
 BTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696938652; x=1697543452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdE5ZXVMUl9wP3lI9W249ELGe5CMinosJna3/j60eG0=;
 b=ifs6nUDWNgv4po+pdwTnWFsXugMVoO1vM23ALv9InNvjm9UuQ20DhHRNFWjEArCRVF
 9bNfFdwiRAreXiY7PBi7tmLZNc1GHDM2o8SyXXdD2VQ9vUMo8WQCPHeyd3F5UVXq/W1o
 YJ3QgZT6YIzRJPOr+Fw+7Z0i4ZQtc9hE3pbCl/9T1CdDrMQP28cOIa5c3Xd4Th13ta0f
 Z2m7zygf1p3W3plD+CO3NHp+HfZk7KbwCFpnFwFl6Oie37kl/+uDQqrX88Zgf1bGLbj7
 hQIbQc2M80FG9JwQIOArqySBGBNWsAAdMVAu8BnO250Y+pjIhM/m5oXV6ENfr2wj11Qn
 +VlA==
X-Gm-Message-State: AOJu0YzsIm0gF4zLiEOdMzJtZBvQyPaIdYlD5AkkBacwNIuMMQvJewYl
 GVPRwEFi4bcEbvo9XnBRN08q1g2n2aCJyvRyJ/1sWA==
X-Google-Smtp-Source: AGHT+IHWFf5jqH74MQAixmheStsCdXuHeIcLbv1KOOA4E5ZeXwEVwR2Q/AsHMoHjWo/EeqD7zmSXDg==
X-Received: by 2002:aa7:cf87:0:b0:525:570c:566b with SMTP id
 z7-20020aa7cf87000000b00525570c566bmr15124825edx.22.1696938652014; 
 Tue, 10 Oct 2023 04:50:52 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 u1-20020a05640207c100b005311e934765sm7525231edy.27.2023.10.10.04.50.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 04:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/6] hw: Clean up global variables shadowing
Date: Tue, 10 Oct 2023 13:50:42 +0200
Message-ID: <20231010115048.11856-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Missing review: #1 #2 #3

v2:
- Addressed Ani's review comments (patches #2, #3)
- Added R-b tags

Clean up global variables shadowing in hw/ in
order to be able to use -Wshadow with Clang.

Philippe Mathieu-Daudé (6):
  hw/core/cpu: Clean up global variable shadowing
  hw/loader: Clean up global variable shadowing in rom_add_file()
  hw/display/vga: Clean up global variable shadowing
  hw/acpi/pcihp: Clean up global variable shadowing in acpi_pcihp_init()
  hw/pci: Clean up global variable shadowing of address_space_io
    variable
  hw/s390x: Clean up global variable shadowing in
    quiesce_powerdown_req()

 hw/display/vga_int.h      |  4 ++--
 include/hw/acpi/pcihp.h   |  2 +-
 include/hw/core/cpu.h     |  8 ++++----
 include/hw/loader.h       | 11 ++++++-----
 include/hw/pci/pci.h      |  9 +++------
 cpu-common.c              |  6 +++---
 hw/acpi/pcihp.c           |  5 ++---
 hw/core/loader.c          | 10 +++++-----
 hw/display/vga.c          | 12 ++++++------
 hw/pci/pci.c              | 25 +++++++++----------------
 hw/s390x/sclpquiesce.c    |  8 ++++----
 target/s390x/cpu_models.c |  2 +-
 12 files changed, 46 insertions(+), 56 deletions(-)

-- 
2.41.0


