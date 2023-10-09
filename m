Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 945357BD794
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmsS-0001mS-IW; Mon, 09 Oct 2023 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmrh-00019W-VE
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:47:58 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmrg-0005un-Au
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:47:53 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5334f9a56f6so7408925a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844870; x=1697449670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T4fpU9odqLdziVyYcEoCfkSrQnPbcJJ4w0phvrCeBiE=;
 b=mVxc8mNXtx99yIXZfZs/RlxZN8smhFRvsQ0y2Rhs8mRHeFIEiz5+4iSilEyKo4Vi7Z
 M9uQ10KWcBcrMA3T7G+8x2kEjHIn8FY2Sbtawh0COq3P33VX8WeZHtZoAhE0o6EuAAC1
 hQLlW7XlXETE+/EIpbWnDdmcqp97srb2pNcCv3IqmigwctQfa4/k4u7NGxxm+uHEWroy
 Daw9K/cerIGcL613ySYMSMC19z/5NziNhtfkkhgzBAeOFp4JDcvsdUcuDyABmS1mckB8
 tFlDauNST72MN9eWAmUGP5+al62h2r35hhW42F/cRzz7frL4Uyjsgu2lKuq/hLQBpwsU
 J7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844870; x=1697449670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T4fpU9odqLdziVyYcEoCfkSrQnPbcJJ4w0phvrCeBiE=;
 b=uHnjYT6k/uMlpNjsJpnttSBqMW200NJzsYKajrXIEFGSF7a+Ms3aBdfbKiwfpXNRM7
 2EYkZFF7yWvymQWGi5ttzxy/S1vef5r64Qt+MqO5zB7mBvslIGewggxQGomUQEwsveu0
 ypibHZwDtA/yTAON1H9ShXnMAn8hLNdCz8lKfIHrOUyRVGfEiFdl01uCaiqCPXD5d+pJ
 COKGPzRQ1C7yuOQfWjxDQmqF31+uYSszFBVn/oTfXzNrzgvafb5orRksCSr/IdBFHR7M
 /Uk25IgFflkuY8ph4RCl6ZFrlmyU/vIPUKOPpE0wiMz1zCgcPdSDI8vQFKHHdZS7wZuW
 OHDQ==
X-Gm-Message-State: AOJu0YxN6OmgdthzW8wk/4FgZ5ig153ll/WYTLbNb5EUfJpUKKr6lWW9
 1ugIpygLov5PuVjJfga4T7vaj/7QynWiLd9EkKY=
X-Google-Smtp-Source: AGHT+IGk4TAwqkR90HGiMROhiICScq8oifqwoddvWxvANQV3Be3XU1FWDM0BE5D9XKj+GNI8tpjDrw==
X-Received: by 2002:a17:906:10a:b0:9ae:3e2f:4d00 with SMTP id
 10-20020a170906010a00b009ae3e2f4d00mr16393095eje.70.1696844870374; 
 Mon, 09 Oct 2023 02:47:50 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 g20-20020a17090613d400b009b96e88759bsm6730417ejc.13.2023.10.09.02.47.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:47:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/6] hw: Clean up global variables shadowing
Date: Mon,  9 Oct 2023 11:47:40 +0200
Message-ID: <20231009094747.54240-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 hw/display/vga_int.h      |  2 +-
 include/hw/acpi/pcihp.h   |  2 +-
 include/hw/core/cpu.h     |  8 ++++----
 include/hw/loader.h       |  2 +-
 include/hw/pci/pci.h      |  9 +++------
 cpu-common.c              |  6 +++---
 hw/acpi/pcihp.c           |  5 ++---
 hw/core/loader.c          |  4 ++--
 hw/display/vga.c          |  6 +++---
 hw/pci/pci.c              | 25 +++++++++----------------
 hw/s390x/sclpquiesce.c    |  8 ++++----
 target/s390x/cpu_models.c |  2 +-
 12 files changed, 34 insertions(+), 45 deletions(-)

-- 
2.41.0


