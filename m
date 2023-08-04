Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E83BD7704B6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwl1-0006Dl-4D; Fri, 04 Aug 2023 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwkv-0006CZ-OH; Fri, 04 Aug 2023 11:30:21 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwku-0004MJ-6v; Fri, 04 Aug 2023 11:30:21 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1bbaa549bcbso1652298fac.3; 
 Fri, 04 Aug 2023 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163018; x=1691767818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rk0ufMi3dk4kgrpp1bd4RIeLfZAozZ6yw2JFgmfTZA8=;
 b=JSSyHIMrHARa0qJo4H34TTLe+jAHDuOSf/RjraGz51jFoTVsInERVCfZKNE0k8Ssmx
 SkyGD1Rh03JhakLsU0K09+qD2cTm8R3i1nUtSGL9uG3RvEMfUqZ17V0hBF+83uTmfREr
 RBtmKS1FR3tWDSl8UDq23Y3fsQgkda6w03FN6yBsor1e2VPegFTE42wdZRWy1h603FZ/
 ykfGdUP1HsgWd7OahAV45LdJq5CQVE/qZE6HRk3JYCMakp0iF18oZ/UPQNKGlz6S1JR8
 tL0Y2Pk9iaDrNaWsjBUEneNSgLf/GJ89lBxEhrs+ZGaJ6Cct7vyVkD8Q2YBjTSWwuxkK
 Cmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163018; x=1691767818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rk0ufMi3dk4kgrpp1bd4RIeLfZAozZ6yw2JFgmfTZA8=;
 b=PzEwd4vcIRKtcVMwAqTdUS5/KtFheiUzc9mAcuEWnHrv5HiO1ZIjuzk3faB8eOjWQU
 gy/SPvHD+edizrtLkgXbe9ERCTB9RUdwjgljP4rzZ5MCE6YdsRvlONOF52EnV++zEIEP
 kkQOEWXz4t2D7NSDzvzJ+tqDhWQiMrtPjZXNm6R0azPTPjIzPMTPCeQzzCuvAPPTzRo6
 QvVnvGONaEgm4kMp4C0swR0DCp4EVbayfC71wQqu+JLoedSLQPGcpd1r5dH+7/SplzbI
 RtQ3/rLsMe/DxaqytP3JASNmoVTbWdpYOi3YHY1pBWGfViQSoToPLYGeLdBOjY1liFVY
 QtAg==
X-Gm-Message-State: AOJu0YxuNfaA6fL+WrhsDmOqi8WgX1NDXlP6GkN2jCsJlKdqR//krCNh
 ThvNSvCI5rsQq8GxaSvPBj798ORNp+M=
X-Google-Smtp-Source: AGHT+IE2U90/MbOuDtdthMIXToy5323jqJvUVXCkcFk3uSBPvDGqS29ZnhPn/6ycCU4Fa9ML+TCj7w==
X-Received: by 2002:a05:6870:2050:b0:1be:deef:748a with SMTP id
 l16-20020a056870205000b001bedeef748amr2900012oad.50.1691163018153; 
 Fri, 04 Aug 2023 08:30:18 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:17 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 1/7] ppc/pegasos2: Fix reset state of USB functions
Date: Fri,  4 Aug 2023 12:29:49 -0300
Message-ID: <20230804152955.22316-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
References: <20230804152955.22316-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The original non-free board firmware sets the command register of the
USB functions to 7 and some guests rely on this for working USB. Match
what the board firmware does when using VOF instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <06a2b864431425f23d1f2b5abf0c027819ac11c6.1689725688.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pegasos2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 4447bbe8ec..4a2ab35f19 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -324,9 +324,13 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 2) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x409);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 2) << 8) |
+                              PCI_COMMAND, 2, 0x7);
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 3) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x409);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 3) << 8) |
+                              PCI_COMMAND, 2, 0x7);
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 4) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x9);
-- 
2.41.0


