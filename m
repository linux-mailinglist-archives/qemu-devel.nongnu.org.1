Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7A7C5D4A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 21:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeRD-0001GT-9Q; Wed, 11 Oct 2023 15:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeR6-0001FB-T4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeR5-0006lz-Be
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso24028666b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697050797; x=1697655597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t8+sii1qHf+I69Ap5ElbUQqOzNpUxNXavMOWQeXGnwk=;
 b=pegA4Gtdd9aqpvtjdZZ7pVN3npYfeLhXrTSMvSblnEFru51ABLeEeM5V5S/hb4VPIe
 LBbtNtMxpF+8uDl8BFWxavg0Fz3helymPn/DEoefLMstD0WFZlOuFBUpegaDKl2GvF+4
 XQoih6HkuVyePx7VSxpUbqSabJ+1IVd/VkvKDX+8Vi4DD8CIt0+CgEmo3sXNl3JSBs79
 1/Gtut9yW/3Ym2To2xiY/TgxUxjJ0suJOafaMO6wyGmimlkcQ7xexyILXwACqxCj/i+8
 RHcyXw9HKihZyGSy9K2SYGyiyo+z0+coX3vfzZJEcPxhDi22g1cENnQzSxQvGWOdzxiP
 P+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697050797; x=1697655597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8+sii1qHf+I69Ap5ElbUQqOzNpUxNXavMOWQeXGnwk=;
 b=cMEruztI/752N/OuFhrOqkfk7hC3M2yh1b9C3GWDafGBKbgkOXMwiOvzudrfGliBX4
 aLixystsDdy4jBPnAXZoaVsV19EOUvzkM5AqJ3eZuVhUuoEnOdmarIgL6NRC+kukuP7R
 4hkvLr5npiC3quW5AnJ/HuZmVkXrkrKArFEBVutjgOeshtt4c604MzJ8FKcX8BfnarIh
 A2QdQYnSk4aKcPeL4n4QImKeT36rdWvgeH/V6feG26v8EkBsIe0SE3OE0YZfi+rVrQNl
 96D6NIMII+uZjnJtXcKpWak2mdBgF83UFrnBg10lRhqBSTC1lGaNkbVmOKMfX10BhUmN
 ac5Q==
X-Gm-Message-State: AOJu0Ywi5FRuz94rnxAT6lX8MFqrN/I+CLiz608xNnWHMrt26/6IyG/0
 y8hazir+B4alHyX+4JGZbFf8eXq/T+xlcFfCTMA=
X-Google-Smtp-Source: AGHT+IG7fVbpgRdZYd1nTQyJ15qnayhZc9II5Cb3AlWjQoO1sgephOVJSo/R9bGyK2hkcA17/gEj6g==
X-Received: by 2002:a17:906:2219:b0:9ae:690d:4284 with SMTP id
 s25-20020a170906221900b009ae690d4284mr19856406ejs.75.1697050797189; 
 Wed, 11 Oct 2023 11:59:57 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 g20-20020a17090613d400b009b96e88759bsm10401469ejc.13.2023.10.11.11.59.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 11:59:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/4] hw/pci: Have functions acess memory regions via
 pci_address_space()
Date: Wed, 11 Oct 2023 20:59:50 +0200
Message-ID: <20231011185954.10337-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

PCI functions are plugged on a PCI bus. They can only
access external memory regions via the bus. Use the
corresponding pci_address_space() / pci_address_space_io()
for that.

Philippe Mathieu-Daudé (4):
  hw/isa/i82378: Access memory regions via pci_address_space()
  hw/isa/lpc_ich9: Access memory regions via pci_address_space[_io]()
  hw/pci-host/bonito: Access memory regions via pci_address_space[_io]()
  hw/sparc64/ebus: Access memory regions via pci_address_space_io()

 hw/isa/i82378.c      | 2 +-
 hw/isa/lpc_ich9.c    | 4 ++--
 hw/pci-host/bonito.c | 6 +++---
 hw/sparc64/sun4u.c   | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.41.0


