Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 714927D9CAB
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:11:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwOTb-0001Hz-Sp; Fri, 27 Oct 2023 11:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwOTY-0001Hk-Ep
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:10:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwOTS-0000JU-H6
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:10:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40853c639abso17024935e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698419406; x=1699024206; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zwqi3Y4PrPun7LsPGJvGblmLBmCMXFboqk56Z5IRgHo=;
 b=dm0ZlXhEMgrJWmhWiyFzKQtwnOn2LW5bWiQMjl7sc3rcopXbjmdphGrqoJwTxj4QOE
 VIFaRecOS9hMgznfr8EjEwZ4TEIiPfKkIEkVo+1C4JckhUz32YMCPu2n6gOF/o2ANnp/
 at7sKjHT230o299IBtDHN+74pK/HUL3w0vA8U7vPeBWz3MTuvRto3ppiQsEtlJrwN0nT
 P3zd1VKuNPFGs6PqAZ7NxyXK35+OmTZ2fSPcb19RtGvc2CYh/2/WN7/OImLmun4anTKV
 BcpAnCKMpJvsbibUVDP8O03ehiO9t8nMS1A1wkC2+dDtObQhH0esIH5hm2Y0haPlizGq
 oXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698419406; x=1699024206;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zwqi3Y4PrPun7LsPGJvGblmLBmCMXFboqk56Z5IRgHo=;
 b=cZLbuT/b8k9ICD6LRBEk/3UUHGJ6GxWESegzxv9luMN5b1+LUugF+V4eq1Mq5uscjB
 TJfrvGckkPKQpSO6CUEOSf6oxESlYNbI7h9WboFWzR8YKk3Vob8qGTWXz7bQkqWU6gHL
 RyigJych/CAU4lUqGGtjGKE3O6rdbEht/4hOL5lwRsIPrH0wrzPQrAx3//bGwPpObJom
 VB4Boc/+sHW3m7yu7r2s9enR4khvu9tf9DuzOf8CKMCXdYhjrd3lJDac2LsWK7MJF9zW
 PuAttDpaq/YDcaLkaFpEC9WjtFHH28p/xZlptnWHE2dyVsD5CyaJRvz3DvShg8dRW9Lg
 21rQ==
X-Gm-Message-State: AOJu0YzfJmTHQV3YjgdygQmvV4D1tTTjMRoFGWkd+seLAiZwIEvM25W4
 De+dEjjUUIURQMeOn5MW0+rAN6o9UVw=
X-Google-Smtp-Source: AGHT+IF7GAVpmkpaFucwpdDn7VNFAYnQ2TYAx7/sqnF8uDR9RYtos22O9yscQbHIGXSFnIzfJ2IxMg==
X-Received: by 2002:adf:eacb:0:b0:32d:9cf7:77e1 with SMTP id
 o11-20020adfeacb000000b0032d9cf777e1mr2444787wrn.9.1698419406026; 
 Fri, 27 Oct 2023 08:10:06 -0700 (PDT)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 k6-20020adff286000000b0032da8fb0d05sm1926096wro.110.2023.10.27.08.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 08:10:05 -0700 (PDT)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com,
 Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH v2 0/1] ui/cocoa: add zoom-to-fit display option
Date: Fri, 27 Oct 2023 16:09:41 +0100
Message-ID: <20231027150942.72357-1-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=carwynellis@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Carwyn Ellis <carwynellis@gmail.com>

The intention here is to allow fullscreen scaling of the display to be
enabled by setting the display option `zoom-to-fit` to on, allowing this
to be set from the command line without having to interact with the ui
menu.

Includes changes requested by Akihiko Odaki.

Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>

Carwyn Ellis (1):
  ui/cocoa: add zoom-to-fit display option

 qapi/ui.json |  8 ++++++--
 ui/cocoa.m   | 35 ++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.42.0


