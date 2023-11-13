Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B97EA268
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:51:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b53-000330-69; Mon, 13 Nov 2023 12:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2b4v-00031A-0d
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:50:30 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2b4s-0003yW-3X
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:50:28 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5c19a328797so764352a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699897816; x=1700502616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QUWJFzILI58nvnk/d1ey4cz6Q2D0+1VXSh2CmPZY8oU=;
 b=FVGUIn5GlNm6Hfnb3JeygpmDmXEbwO9lpqNlZvqHDXwqNIinMx0qjc0RFNTyF1IPSI
 jMkAuw81wUciIoBk5PEoFvIL8Prlbe4/N1YyN4BkRS8c1qsrAdwpC0lnZQvuYcu48yFR
 USecsk9EVE4gT0MeuQL4vS14iF1fdKy++hIdjUUYWUJu16wRcvzYCkBe5Qr9YcAGt4MD
 QRqonKLIY5Kjr4oFGRwB0qkUdnZCBCWCblmZ5MODz/WjCgtV0KgduwJn9E1Lo3FZb9d5
 R/AC8vZJi8MnUIUTyB3HOX91rXsd5pT+MlwdB94nX6LMOZkT4XipOhGEJlqP8GtYqTGn
 /PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897816; x=1700502616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QUWJFzILI58nvnk/d1ey4cz6Q2D0+1VXSh2CmPZY8oU=;
 b=LJxuZylpjqs5/l+SgFMTROJaG95256tJFqZruSZCR1kgiIQQFOSBs9Fdl3VZTYW/jA
 aKbAMiUcyAy24uPni3ootlL/qBx8tvNdOA4JN2KhyCtb9OnfNiiilK62q287YnpWbcU5
 ZMl5Z6IBj04ghPg/QzJ9HzQu+rmaE74wOjKzHmhsOHPVpUcyEYjPM2ndZn3A/+0eapV9
 xritW8069Tum44iv36ld1xriw9uKJBmOj0lgSUNCFqhgcB0gt6+vtJcVcFo/cAdcHTxk
 Af/UsRDL33BY9NlvWisU9w5fQClQHNowzmglMSQG5MtK85up2e//VPx+QqrU28xOIPiR
 axqg==
X-Gm-Message-State: AOJu0Ywjbxs0m2h9UJzMKlTx2Xiq/4lMZbwWsOIC6pdUuY3kxuaNtS4u
 Bxrg1qykXNzoTmk8uCfOn1QgHAPQaP4UIjrRrmA=
X-Google-Smtp-Source: AGHT+IFeJ114rL89RgO4eK7CPcPIMggTejCKEwBuEZAeufXwO5JaQAPPeR2uUl5nNkKXRxo0XNoqEA==
X-Received: by 2002:a17:90b:3849:b0:280:aa7b:fbe8 with SMTP id
 nl9-20020a17090b384900b00280aa7bfbe8mr5288099pjb.32.1699897816702; 
 Mon, 13 Nov 2023 09:50:16 -0800 (PST)
Received: from grind.. ([152.250.131.148]) by smtp.gmail.com with ESMTPSA id
 hg23-20020a17090b301700b00277560ecd5dsm5869329pjb.46.2023.11.13.09.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:50:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mjt@tls.msk.ru, alistair.francis@wdc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH stable-8.1.3 0/2] RISC-V KVM fixes for 8.1.3
Date: Mon, 13 Nov 2023 14:50:09 -0300
Message-ID: <20231113175011.151022-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

These 2 patches fixes a problem we're having with QEMU 8.1 and Linux
6.6. More info here:

https://lore.kernel.org/kvm/6d8ff85e-b0b6-46f2-8554-b9543f3eab31@ventanamicro.com/


Daniel Henrique Barboza (2):
  target/riscv/kvm: improve 'init_multiext_cfg' error msg
  target/riscv/kvm: support KVM_GET_REG_LIST

 target/riscv/kvm.c | 100 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 3 deletions(-)

-- 
2.41.0


