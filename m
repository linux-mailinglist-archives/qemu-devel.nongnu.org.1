Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8843929C94
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jul 2024 08:57:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiI1-0007pG-SH; Mon, 08 Jul 2024 02:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiI0-0007kc-7m
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:55:56 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiHw-0001mb-PV
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:55:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-767506e1136so1652500a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421751; x=1721026551;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BLMHbOmO7rZB07rZm/JRygb1KSCUKZmhbVac63WlWq8=;
 b=Qmwit1iBZlQTFpcf6jAQmDmsz7WTNL+PGkzXIf9/5yKpwh4D/KlHeLK8LFxscUwasR
 XEF58IGm9HEWcxWljppz8wW+m5fNWBnRfIsyhNPuRztm88DJHs1++XSxk9UH7/si7196
 GuTjzF4bK6mwkbSop3PY9eJ7FY9Fbgx5XyPj7ZaXL9jIajCjFeeCbsvwaGbfC8Aj/5BN
 52UYWgH4TzEVFk9hfRHIZcFWKmZUJg7kFzuDYEGrL0LgGoY7N7sCIN7yOWhXinnSCgDW
 oKxEh+SYYReuZiIkPxcQ+2A8w+LJT7JADCXzkoYZN8byvz9eGSYPHaGI6eMeRYlwCHZy
 kRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421751; x=1721026551;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLMHbOmO7rZB07rZm/JRygb1KSCUKZmhbVac63WlWq8=;
 b=s5ntcIDz257faZsLYuRp+2cEqBeuY66KaCUNdItvK8+Xh6l5dkA05cmLaTEIgVBvpv
 fLFw4GGhrl6D6i5Ds7LocAU/v04itMvR0n09s2zAH6q7sy7lxdtgPU6fkEMmwas3qDFU
 6tQzPqMyNywq9xXdY244LbfemIBL9KQNhzdXIhRvQZ772eTAioEk4tV425zGzURL2Zij
 n2wzz6aHj75geUCHHbV6PjucW9WFLRIJahJgVWDonPie0oMXffGktdSLwxPiAG1YaYDh
 XynLTUHa4nQhdx4qTdqdowOTXpNAKnbbe1a9nXvNWEGbqW8QnOvnvJ27sE1mOK38EiG9
 3TJw==
X-Gm-Message-State: AOJu0Yxcw1nfrny/CFSOzOCsU3JPIEfYfTVs79BvM55aDGeXRNbxQe86
 L4juKdMD7WcRvDUBRB36rb/vZEFOFAoSPFsqhW9VcugpPrBvWnwNwmXJtgdt4VE=
X-Google-Smtp-Source: AGHT+IGcU0uuqGQ/NDSbZyj838RXRnvxG4w/JAEUL06+/qPt3q4lUtlL1+8Nl5ZeuotEY4uOl1e47Q==
X-Received: by 2002:a05:6a20:748e:b0:1c0:f283:c4ed with SMTP id
 adf61e73a8af0-1c0f283c73bmr3369850637.28.1720421750829; 
 Sun, 07 Jul 2024 23:55:50 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b0932343asm6523151b3a.141.2024.07.07.23.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:55:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/9] Fix check-qtest-ppc64 sanitizer errors
Date: Mon, 08 Jul 2024 15:55:11 +0900
Message-Id: <20240708-san-v3-0-b03f671c40c6@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE+Ni2YC/1XMTQ6CMBCG4auQWVsznRYQV97DuCj9kS4spjUNh
 HB3C8ZEl99knneBZKO3Cc7VAtFmn/wYyhCHCvSgwt0yb8oGQpLYUM2SCgy7VjnlpOOaoHw+o3V
 +2ivXW9mDT68xzns08+369c3uM2fInNBakkDip+5i1Bz8dNTjA7ZApl/UfhAV1NbY99jJxvTmD
 63r+gby7f3ZzAAAAA==
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Based-on: <3ad18bc590ef28e1526e8053568086b453e7ffde.1718211878.git.quic_mathbern@quicinc.com>
("[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'")

I saw various sanitizer errors when running check-qtest-ppc64. While
I could just turn off sanitizers, I decided to tackle them this time.

Unfortunately, GLib does not free test data in some cases so some
sanitizer errors remain. All sanitizer errors will be gone with this
patch series combined with the following change for GLib:
https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Added patch "memory: Clarify that we use owner's reference count".
- Added patch "memory: Refer to docs/devel/memory.rst for 'owner'".
- Fixed the message of patch
  "memory: Do not create circular reference with subregion".
- Dropped patch "cpu: Free cpu_ases" in favor of:
  https://lore.kernel.org/r/20240607115649.214622-7-salil.mehta@huawei.com/
  ("[PATCH V13 6/8] physmem: Add helper function to destroy CPU
  AddressSpace")
- Dropped patches "hw/ide: Convert macio ide_irq into GPIO line" and
  "hw/ide: Remove internal DMA qemu_irq" in favor of commit efb359346c7a
  ("hw/ide/macio: switch from using qemu_allocate_irq() to qdev input
  GPIOs")
- Dropped patch "hw/isa/vt82c686: Define a GPIO line between vt82c686
  and i8259" in favor of:
  https://patchew.org/QEMU/20240704205854.18537-1-shentey@gmail.com/
  ("[PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks")
- Dropped pulled patches.
- Link to v2: https://lore.kernel.org/r/20240627-san-v2-0-750bb0946dbd@daynix.com

Changes in v2:
- Rebased to "[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'".
  (Philippe Mathieu-Daudé)
- Converted IRQs into GPIO lines and removed one qemu_irq usage.
  (Peter Maydell)
- s/suppresses/fixes/ (Michael S. Tsirkin)
- Corrected title of patch "hw/virtio: Free vqs after vhost_dev_cleanup()"
  (was "hw/virtio: Free vqs before vhost_dev_cleanup()")
- Link to v1: https://lore.kernel.org/r/20240626-san-v1-0-f3cc42302189@daynix.com

---
Akihiko Odaki (9):
      spapr: Free stdout path
      ppc/vof: Fix unaligned FDT property access
      migration: Free removed SaveStateEntry
      memory: Do not refer to "memory region's reference count"
      memory: Refer to docs/devel/memory.rst for "owner"
      memory: Clarify that owner may be missing
      memory: Clarify owner must not call memory_region_ref()
      memory: Do not create circular reference with subregion
      tests/qtest: Delete previous boot file

 include/exec/memory.h        | 22 +++++++---------------
 hw/ppc/spapr_vof.c           |  2 +-
 hw/ppc/vof.c                 |  2 +-
 migration/savevm.c           |  2 ++
 system/memory.c              | 11 +++++++++--
 tests/qtest/migration-test.c | 18 +++++++++++-------
 6 files changed, 31 insertions(+), 26 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


